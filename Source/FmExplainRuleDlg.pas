{
  Distributed under the MIT license.
  See the accompanying LICENSE file or go to
  http://delphidabbler.mit-license.org/1992-2015/
}

unit FmExplainRuleDlg;


interface


uses
  // Delphi
  Forms, StdCtrls, Controls, Buttons, Classes, ExtCtrls;

type
  {
  TExplainRulesDlg:
    Class implementing a dialog box to explain in English the current rule
    displayed in the Edit Rule dialog box.
  }
  TExplainRuleDlg = class(TForm)
    CloseBtn: TButton;
    BirthRuleGp: TGroupBox;
    BirthRuleExplainedLbl: TLabel;
    SurvivalRuleGp: TGroupBox;
    SurvivalRuleExplainedLbl: TLabel;
    Bevel1: TBevel;
    procedure FormShow(Sender: TObject);
  private
    fBirthSetStr, fSurvivalSetStr: string;
      {Storage for BirthSetStr and SurvivalSetStr properties}
    function ExplainText(const SetStr: string): string;
      {Returns English explanation for the given set string}
  public
    property BirthSetStr: string read fBirthSetStr write fBirthSetStr;
      {The birth influence set to be explained, in string format}
    property SurvivalSetStr: string read fSurvivalSetStr
        write fSurvivalSetStr;
      {The survival influence set to be explained, in string format}
  end;

var
  ExplainRuleDlg: TExplainRuleDlg;


implementation


{$R *.DFM}


{ --- Public events of form --- }

procedure TExplainRuleDlg.FormShow(Sender: TObject);
begin
  {Display explanation for birth influence set}
  if BirthSetStr <> '' then
    BirthRuleExplainedLbl.Caption :=
      'A life-form will be born if an empty cell has '
      + ExplainText(BirthSetStr) + '.'
  else
    BirthRuleExplainedLbl.Caption :=
      'No rule specified - nothing will ever be born!!';
  {Display explanation for survival influence set}
  if SurvivalSetStr <> '' then
    SurvivalRuleExplainedLbl.Caption :=
      'A life-form will survive if it''s cell has '
      + ExplainText(SurvivalSetStr) + '.'
  else
    SurvivalRuleExplainedLbl.Caption :=
      'No rule specified - nothing will ever survive!!';
end;

{ --- Private methods --- }

function TExplainRuleDlg.ExplainText(const SetStr: string): string;
  {Returns English explanation for the given set string - SetStr must contain
  only the digits from '0' to '8' which must not be repeated and must be in
  order. At least one digit should be in the string}
const
  cNumNames: array [0..8] of string =
      ('zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight');
    {table of names of numbers from 0 to 8}
var
  I: Integer;    {loop control}
begin
  {Record name of first number}
  Result := cNumNames[ord(SetStr[1]) - ord('0')];
  {Iterate across remainder of string, if any, formatting output}
  for I := 2 to Length(SetStr) do
  begin
    if I < Length(SetStr) then
      {Not at last element, output a comma before it}
      Result := Result + ', '
    else
      {At last element output 'or' before it}
      Result := Result + ' or ';
    {Output required number name}
    Result := Result + cNumNames[ord(SetStr[I]) - ord('0')];
  end;
  {Output terminal text}
  Result := Result + ' neighbouring life-form';
  {make it plural if required}
  if (Length(SetStr) > 1) or (SetStr[1] <> '1') then
    Result := Result + 's';
end;

end.