unit Hasselman;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, SortGrid, ExtCtrls;

type
  THasselmanForm = class(TForm)
    ScrollBox: TScrollBox;
    Datos: TSortGrid;
    Cerrar: TBitBtn;
    Calculo: TBitBtn;
    Nuevo: TBitBtn;
    Guardar: TBitBtn;
    Imprimir: TBitBtn;
    SaveDialog: TSaveDialog;
    PrintDialog: TPrintDialog;
    DOla: TRadioGroup;
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

  Magnitudes : Array [1..5] of String = ('Ua(m/s)','Lf(Km)','Hmo(m)','Tp(s)','t(h)');

var
  HasselmanForm: THasselmanForm;

implementation

{$R *.DFM}

uses PrntComp;

function pow(x, a: real) : real;

begin
  pow := exp(a * ln(x))
end;

procedure THasselmanForm.NuevoClick(Sender: TObject);

var
  i, j    : byte;

begin
  for i := 1 to 16 do
    Datos.Cells[0,i] := Rumbos[i];

  If DOla.ItemIndex = 0 Then
    begin
      Datos.ColCount := 6;
      for j := 1 to 5 do
        Datos.Cells[j,0] := Magnitudes[j]
    end
  Else
    begin
      Datos.ColCount := 5;
      Datos.Cells[1,0] := Magnitudes[1];
      for j := 3 to 5 do
        Datos.Cells[j - 1,0] := Magnitudes[j]
    end;

  For j:=1 To 5 Do
    For i:=1 To 16 Do
      Datos.Cells[j,i]:='0.0';
  Calculo.Visible := True;
  Guardar.Visible := True;
  Imprimir.Visible := True    
end;

procedure THasselmanForm.CalculoClick(Sender: TObject);

var
  i                     : byte;
  code                  : integer;
  U, tg,
  Lf, Tp, Hmo           : real;
  sU, stg,
  sLf, sTp, sHmo        : String[5];

begin
  For i:=1 To 16 Do
    If (Datos.Cells[1,i] <> '0.0') Then
      begin
        If DOla.ItemIndex = 0 Then
          begin
            Val(Datos.Cells[1,i], U, code);
            Val(Datos.Cells[2,i], Lf, code);

            Hmo := 5.112E-4*U*pow(Lf,1/2);
            Str(Hmo:3:1,sHmo);
            Datos.Cells[3,i] := sHmo;

            Tp := 6.238E-2*pow(U*Lf,1/3);
            Str(Tp:3:1,sTp);
            Datos.Cells[4,i] := sTp;

            tg := 32.15*pow(pow(Lf,2)/U,1/3)/3600;
            Str(tg:3:1,stg);
            Datos.Cells[5,i] := stg;

          end
        Else
          begin
            Val(Datos.Cells[1,i], U, code);

            Hmo := 2.482E-2*pow(U,2);
            Str(Hmo:3:1,sHmo);
            Datos.Cells[2,i] := sHmo;

            Tp := 8.3E-1*U;
            Str(Tp:3:1,sTp);
            Datos.Cells[3,i] := sTp;

            tg := 7.296E3*U/3600;
            Str(tg:3:1,stg);
            Datos.Cells[4,i] := stg;
          end
      end
end;


procedure THasselmanForm.GuardarClick(Sender: TObject);
begin
  If Not SaveDialog.Execute Then
    begin
      MessageDlg('Operación Guardar Cancelada', mtInformation, [mbOK], 0);
      Exit;
    end
  Else
    Datos.SaveToFile(SaveDialog.FileName,',')
end;



procedure THasselmanForm.ImprimirClick(Sender: TObject);
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

procedure THasselmanForm.CerrarClick(Sender: TObject);
begin
  Close
end;

end.
