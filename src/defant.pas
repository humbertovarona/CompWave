unit Defant;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, SortGrid;

type
  TDefantForm = class(TForm)
    ScrollBox: TScrollBox;
    Datos: TSortGrid;
    Cerrar: TBitBtn;
    Calculo: TBitBtn;
    Nuevo: TBitBtn;
    Guardar: TBitBtn;
    Imprimir: TBitBtn;
    SaveDialog: TSaveDialog;
    PrintDialog: TPrintDialog;
    procedure NuevoClick(Sender: TObject);
    procedure CalculoClick(Sender: TObject);
    procedure GuardarClick(Sender: TObject);
    procedure ImprimirClick(Sender: TObject);
    procedure CerrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  C                                = 8.25e-4;
  g                                = 9.8;
  ro                               = 1.0;
  Rumbos : Array [1..16] of String = ('N','NNW','NW','WNW',
                                      'W','WSW','SW','SSW',
                                      'S','SSE','SE','ESE',
                                      'E','ENE','NE','NNE');

  Magnitudes : Array [1..10] of String = ('V(m/s)','T(s)', 'Tmax(s)',
                                         'L(m)','H(m)',
                                         'Hmodal(m)',
                                         'H 1/3(m)', 'H 1/10(m)',
                                         'Et()', 'Ep(m2)');

var
  DefantForm: TDefantForm;

implementation

{$R *.DFM}

uses PrntComp;

procedure TDefantForm.NuevoClick(Sender: TObject);

var
  i, j    : byte;

begin
  for i := 1 to 16 do
    Datos.Cells[0,i] := Rumbos[i];
  for j := 1 to 10 do
    Datos.Cells[j,0] := Magnitudes[j];
  For j:=1 To 10 Do
    For i:=1 To 16 Do
      Datos.Cells[j,i]:='0.0';
  Calculo.Visible := True;
  Guardar.Visible := True;
  Imprimir.Visible := True    
end;

procedure TDefantForm.CalculoClick(Sender: TObject);

var
  i                     : byte;
  code                  : integer;
  V, Tmax,
  T, L, H, H1_3,
  H1_10, Et, Ep,
  Hmodal                : real;
  sTmax,
  sT, sL, sH, sH1_3,
  sH1_10, sEtotal, sEp,
  sHmodal               : String[5];

begin
  For i:=1 To 16 Do
    If (Datos.Cells[1,i] <> '0.0') Then
      begin

        Val(Datos.Cells[1,i], V, code);
        T := pi*sqrt(3)*V/g;
        Str(T:3:1,sT);
        Datos.Cells[2,i] := sT;

        Tmax := sqrt(2)*T;
        Str(Tmax:3:1,sTmax);
        Datos.Cells[3,i] := sTmax;

        L := sqrt(3)*g*sqr(T)/(6*pi);
        Str(L:3:1,sL);
        Datos.Cells[4,i] := sL;

        Et := C*ro*sqr(pi)*pi*sqrt(pi/2)*3/(32*sqr(g))*sqr(V)*sqr(V)*V;
        Str(Et:7:5,sEtotal);
        Datos.Cells[9,i] := sEtotal;

        Ep := 2*Et/(ro*g);
        Str(Ep:7:5,sEp);
        Datos.Cells[10,i] := sEp;

        H := sqrt(pi*Ep);
        Str(H:4:2,sH);
        Datos.Cells[5,i] := sH;

        Hmodal := sqrt(2*Ep);
        Str(Hmodal:4:2,sHmodal);
        Datos.Cells[6,i] := sHmodal;

        H1_3 := 2.832*sqrt(Ep);
        Str(H1_3:4:2,sH1_3);
        Datos.Cells[7,i] := sH1_3;

        H1_10 := 3.6*sqrt(Ep);
        Str(H1_10:4:2,sH1_10);
        Datos.Cells[8,i] := sH1_10;

      end;
end;


procedure TDefantForm.GuardarClick(Sender: TObject);
begin
  If Not SaveDialog.Execute Then
    begin
      MessageDlg('Operación Guardar Cancelada', mtInformation, [mbOK], 0);
      Exit;
    end
  Else
    Datos.SaveToFile(SaveDialog.FileName,',')
end;



procedure TDefantForm.ImprimirClick(Sender: TObject);
begin
  If Not PrintDialog.Execute Then
    begin
      MessageDlg('Operación Imprimir Cancelada', mtInformation, [mbOK], 0);
      Exit;
    end
  Else
    begin
      PrintPage(ScrollBox, 0);
    end  
end;

procedure TDefantForm.CerrarClick(Sender: TObject);
begin
  Close
end;

end.
