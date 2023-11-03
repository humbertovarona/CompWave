unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls, Buttons, StdCtrls, ExtCtrls;

type
  TMainForm = class(TForm)
    ScrollBox1: TScrollBox;
    Correcciones: TBitBtn;
    Iribarren: TBitBtn;
    Defant: TBitBtn;
    Titov: TBitBtn;
    Hasselman: TBitBtn;
    Ayuda: TBitBtn;
    Terminar: TBitBtn;
    Oleaje: TPanel;
    BitBtn1: TBitBtn;
    procedure IribarrenClick(Sender: TObject);
    procedure DefantClick(Sender: TObject);
    procedure TerminarClick(Sender: TObject);
    procedure TitovClick(Sender: TObject);
    procedure HasselmanClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses Iribarren, Defant, Titov, Hasselman;

{$R *.DFM}

procedure TMainForm.IribarrenClick(Sender: TObject);
begin
  IribarrenForm.ShowModal
end;

procedure TMainForm.DefantClick(Sender: TObject);
begin
  DefantForm.ShowModal
end;

procedure TMainForm.TerminarClick(Sender: TObject);
begin
  Close
end;

procedure TMainForm.TitovClick(Sender: TObject);
begin
  TitovForm.ShowModal
end;

procedure TMainForm.HasselmanClick(Sender: TObject);
begin
  HasselmanForm.ShowModal
end;

end.
