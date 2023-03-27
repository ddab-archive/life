{
  Distributed under the MIT license.
  See the accompanying LICENSE file or go to
  http://delphidabbler.mit-license.org/1992-2015/
}

unit FmNameSelectDlg;


interface


uses
  // Delphi
  Forms, StdCtrls, Controls, Buttons, Classes, ExtCtrls;

type
  {
  TNameSelectDlg:
    Class implementing dialog box that allows user to choose from a list of
    existing names or to enter an alternative name.
  }
  TNameSelectDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    NameCombo: TComboBox;
    PromptLbl: TLabel;
    Bevel1: TBevel;
    procedure FormShow(Sender: TObject);
  private
    fTitle: string;
      {Value of Title property}
    fPrompt: string;
      {Value of Prompt property}
  public
    property Title: string read fTitle write fTitle;
      {The title to use in the caption of the dialogue box following the name
      of the application}
    property Prompt: string read fPrompt write fPrompt;
      {The prompt to be displayed above the combo box}
  end;

var
  NameSelectDlg: TNameSelectDlg;


implementation


{$R *.DFM}

{ TSaveIniDlg }

procedure TNameSelectDlg.FormShow(Sender: TObject);
begin
  // Set up form from properties
  Caption := fTitle;
  PromptLbl.Caption := fPrompt;
  // Ensure combo box is blank and focussed
  NameCombo.ItemIndex := -1;
  NameCombo.SetFocus;
end;

end.
