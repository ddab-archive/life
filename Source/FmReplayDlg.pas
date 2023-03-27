{
  Distributed under the MIT license.
  See the accompanying LICENSE file or go to
  http://delphidabbler.mit-license.org/1992-2015/
}

unit FmReplayDlg;


interface


uses
  // Delphi
  Forms, StdCtrls, Controls, Buttons, Classes, ExtCtrls;

type
  {
  TReplayDlg:
    Class implementing a dialog box asking user whether to replay from start of
    game or from latest snapshot.
  }
  TReplayDlg = class(TForm)
    Bevel1: TBevel;
    OKBtn: TButton;
    PromptLbl: TLabel;
    StartRadio: TRadioButton;
    SnapshotRadio: TRadioButton;
    CancelBtn: TButton;
  end;

var
  ReplayDlg: TReplayDlg;


implementation


{$R *.DFM}


end.
