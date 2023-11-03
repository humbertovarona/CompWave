program ola;

uses
  Forms,
  main in 'main.pas' {MainForm},
  Defant in 'defant.pas' {DefantForm},
  Iribarren in 'Iribarren.pas' {IribarrenForm},
  Titov in 'Titov.pas' {TitovForm},
  Hasselman in 'Hasselman.pas' {HasselmanForm},
  FzaImpacto in 'FzaImpacto.pas' {FzaImpactoForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDefantForm, DefantForm);
  Application.CreateForm(TIribarrenForm, IribarrenForm);
  Application.CreateForm(TTitovForm, TitovForm);
  Application.CreateForm(THasselmanForm, HasselmanForm);
  Application.CreateForm(TFzaImpactoForm, FzaImpactoForm);
  Application.Run;
end.
