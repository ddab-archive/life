{
  Distributed under the MIT license.
  See the accompanying LICENSE file or go to
  http://delphidabbler.mit-license.org/1992-2015/
}

program Life;

uses
  Forms,
  ColourSchemes in 'ColourSchemes.pas',
  Config in 'Config.pas',
  FmApplyRuleDlg in 'FmApplyRuleDlg.pas' {ApplyRuleDlg},
  FmColourSchemeDlg in 'FmColourSchemeDlg.pas' {ColourSchemeDlg},
  FmEditRuleDlg in 'FmEditRuleDlg.pas' {EditRuleDlg},
  FmExplainRuleDlg in 'FmExplainRuleDlg.pas' {ExplainRuleDlg},
  FmMainForm in 'FmMainForm.pas' {MainForm},
  FmNameSelectDlg in 'FmNameSelectDlg.pas' {NameSelectDlg},
  FmReplayDlg in 'FmReplayDlg.pas' {ReplayDlg},
  FmSaveGameStateDlg in 'FmSaveGameStateDlg.pas' {SaveGameStateDlg},
  GameEngine in 'GameEngine.pas',
  Rules in 'Rules.pas',
  Shared in 'Shared.pas',
  SystemFolders in 'SystemFolders.pas';

{$R Resource.res}     // Main application resources, including main icon
{$R Version.res}      // For version information

begin
  {Set application title}
  Application.Title := 'Game of Life';
  {Create required forms}
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TColourSchemeDlg, ColourSchemeDlg);
  Application.CreateForm(TNameSelectDlg, NameSelectDlg);
  Application.CreateForm(TEditRuleDlg, EditRuleDlg);
  Application.CreateForm(TApplyRuleDlg, ApplyRuleDlg);
  Application.CreateForm(TSaveGameStateDlg, SaveGameStateDlg);
  Application.CreateForm(TExplainRuleDlg, ExplainRuleDlg);
  Application.CreateForm(TReplayDlg, ReplayDlg);
  {Run the application}
  Application.Run;
end.
