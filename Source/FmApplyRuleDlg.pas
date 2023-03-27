{
  Distributed under the MIT license.
  See the accompanying LICENSE file or go to
  http://delphidabbler.mit-license.org/1992-2015/
}

unit FmApplyRuleDlg;


interface


uses
  // Delphi
  Forms, StdCtrls, Controls, Buttons, Classes, ExtCtrls;

type
  {
  TApplyRuleDlg:
    Class implements a dialog box which is called when a new rule is applied.
    Dialog asks user whether to apply rule to start of game and/or to any
    snapshot.
  }
  TApplyRuleDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    StartGameChkBox: TCheckBox;
    SnapshotChkBox: TCheckBox;
    PromptLbl: TLabel;
    Bevel1: TBevel;
    procedure FormShow(Sender: TObject);
  end;

var
  ApplyRuleDlg: TApplyRuleDlg;


implementation


{$R *.DFM}

{ TApplyRuleDlg }

procedure TApplyRuleDlg.FormShow(Sender: TObject);
begin
  // Focus the first check box when form displayed
  StartGameChkBox.SetFocus;
end;

end.
