{
  Distributed under the MIT license.
  See the accompanying LICENSE file or go to
  http://delphidabbler.mit-license.org/1992-2015/
}

unit FmSaveGameStateDlg;


interface


uses
  // Delphi
  Forms, StdCtrls, Controls, Buttons, Classes, ExtCtrls;

type

  {
  TSaveGameStateDlg:
    Class implementing a dialog box asking user to choose whether to save
    initial state of game, current state or last snapshot.
  }
  TSaveGameStateDlg = class(TForm)
    Bevel1: TBevel;
    PromptLbl: TLabel;
    OKBtn: TButton;
    StartRadio: TRadioButton;
    SnapshotRadio: TRadioButton;
    CancelBtn: TButton;
    CurrentRadio: TRadioButton;
  end;

var
  SaveGameStateDlg: TSaveGameStateDlg;


implementation


{$R *.DFM}

end.
