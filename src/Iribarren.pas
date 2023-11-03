unit Iribarren;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids;

type
  TIribarrenForm = class(TForm)
    ScrollBox: TScrollBox;
    Cerrar: TBitBtn;
    Calculo: TBitBtn;
    Nuevo: TBitBtn;
    Guardar: TBitBtn;
    Imprimir: TBitBtn;
    SaveDialog: TSaveDialog;
    PrintDialog: TPrintDialog;
    Datos: TVGrid;
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
  g                                = 9.8;
  Rumbos : Array [1..16] of String = ('N','NNW','NW','WNW',
                                      'W','WSW','SW','SSW',
                                      'S','SSE','SE','ESE',
                                      'E','ENE','NE','NNE');

  Magnitudes : Array [1..4] of String = ('Lf(Km)','T(s)','L(m)','H(m)');

var
  IribarrenForm: TIribarrenForm;

implementation

{$R *.DFM}

uses PrntComp;

function pow(x, a: real) : real;

begin
  pow := exp(a * ln(x))
end;

procedure TIribarrenForm.NuevoClick(Sender: TObject);

var
  i, j    : byte;

begin
  for i := 1 to 16 do
    Datos.Cells[0,i] := Rumbos[i];
  for j := 1 to 4 do
    Datos.Cells[j,0] := Magnitudes[j];
  For j:=1 To 4 Do
    For i:=1 To 16 Do
      Datos.Cells[j,i]:='0.0';
  Calculo.Visible := True;
  Guardar.Visible := True;
  Imprimir.Visible := True    
end;

procedure TIribarrenForm.CalculoClick(Sender: TObject);

var
  i                     : byte;
  code                  : integer;
  Lf, T, L, H           : real;
  sLf, sT, sL, sH       : String[5];

begin
  For i:=1 To 16 Do
    If (Datos.Cells[1,i] <> '0.0') Then
      begin

        Val(Datos.Cells[1,i], Lf, code);
        T := sqrt(62*pi/g)*pow(Lf,1/6);
        Str(T:3:1,sT);
        Datos.Cells[2,i] := sT;

        L := 31*pow(Lf,1/3);
        Str(L:3:1,sL);
        Datos.Cells[3,i] := sL;

        H := 1.2*pow(Lf,1/4);
        Str(H:4:2,sH);
        Datos.Cells[4,i] := sH;

      end;
end;


procedure TIribarrenForm.GuardarClick(Sender: TObject);
begin
  If Not SaveDialog.Execute Then
    begin
      MessageDlg('Operación Guardar Cancelada', mtInformation, [mbOK], 0);
      Exit;
    end
  Else
    Datos.SaveToFile(SaveDialog.FileName,',')
end;



procedure TIribarrenForm.ImprimirClick(Sender: TObject);
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

procedure TIribarrenForm.CerrarClick(Sender: TObject);
begin
  Close
end;

end.
