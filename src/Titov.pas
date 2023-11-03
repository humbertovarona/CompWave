unit Titov;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, SortGrid;

type
  TTitovForm = class(TForm)
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
  g                                = 9.8;
  Rumbos : Array [1..16] of String = ('N','NNW','NW','WNW',
                                      'W','WSW','SW','SSW',
                                      'S','SSE','SE','ESE',
                                      'E','ENE','NE','NNE');

  Magnitudes : Array [1..6] of String = ('V(m/s)','H(m)','T(s)','L(m)','Lf(Km)','t(h)');

var
  TitovForm: TTitovForm;

implementation

{$R *.DFM}

uses PrntComp;

function pow(x, a: real) : real;

begin
  pow := exp(a * ln(x))
end;

procedure TTitovForm.NuevoClick(Sender: TObject);

var
  i, j    : byte;

begin
  for i := 1 to 16 do
    Datos.Cells[0,i] := Rumbos[i];
  for j := 1 to 6 do
    Datos.Cells[j,0] := Magnitudes[j];
  For j:=1 To 6 Do
    For i:=1 To 16 Do
      Datos.Cells[j,i]:='0.0';
  Calculo.Visible := True;
  Guardar.Visible := True;
  Imprimir.Visible := True    
end;

procedure TTitovForm.CalculoClick(Sender: TObject);

var
  i                     : byte;
  code                  : integer;
  V, tg,
  Lf, T, L, H           : real;
  sV, stg,
  sLf, sT, sL, sH       : String[5];

begin
  For i:=1 To 16 Do
    If (Datos.Cells[1,i] <> '0.0') Then
      begin

        Val(Datos.Cells[1,i], V, code);
        H := 0.0152*pow(V, 2);
        Str(H:3:1,sH);
        Datos.Cells[2,i] := sH;

        T := 0.64*V;
        Str(T:3:1,sT);
        Datos.Cells[3,i] := sT;

        L := V;
        Str(L:4:2,sL);
        Datos.Cells[4,i] := sL;

        Lf := 3*pow(V,2);
        Str(Lf:4:2,sLf);
        Datos.Cells[5,i] := sLf;

        tg := 19*V;
        Str(tg:4:2,stg);
        Datos.Cells[6,i] := stg;

      end;
end;


procedure TTitovForm.GuardarClick(Sender: TObject);
begin
  If Not SaveDialog.Execute Then
    begin
      MessageDlg('Operación Guardar Cancelada', mtInformation, [mbOK], 0);
      Exit;
    end
  Else
    Datos.SaveToFile(SaveDialog.FileName,',')
end;



procedure TTitovForm.ImprimirClick(Sender: TObject);
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

procedure TTitovForm.CerrarClick(Sender: TObject);
begin
  Close
end;

end.
