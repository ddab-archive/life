{
  Distributed under the MIT license.
  See the accompanying LICENSE file or go to
  http://delphidabbler.mit-license.org/1992-2015/
}

unit FmEditRuleDlg;


interface


uses
  // Delphi
  Forms, StdCtrls, Controls, Buttons, Classes, ExtCtrls,
  // Project
  Rules;

type
  {
  TEditRuleDlg:
    Class implementing a dialog box that allows user to edit or create, name and
    save new rules or to select a rule to be used by current game.
  }
  TEditRuleDlg = class(TForm)
    SaveBtn: TButton;
    SaveAsBtn: TButton;
    DeleteBtn: TButton;
    ApplyBtn: TButton;
    ExplainBtn: TButton;
    CloseBtn: TButton;
    RuleCombo: TComboBox;
    RuleComboLbl: TLabel;
    BirthGpBox: TGroupBox;
    BirthRuleChkBox0: TCheckBox;
    BirthRuleChkBox1: TCheckBox;
    BirthRuleChkBox2: TCheckBox;
    BirthRuleChkBox3: TCheckBox;
    BirthRuleChkBox4: TCheckBox;
    BirthRuleChkBox5: TCheckBox;
    BirthRuleChkBox6: TCheckBox;
    BirthRuleChkBox7: TCheckBox;
    BirthRuleChkBox8: TCheckBox;
    BirthSetLbl: TLabel;
    SurvivalGpBox: TGroupBox;
    SurvivalRuleChkBox0: TCheckBox;
    SurvivalRuleChkBox1: TCheckBox;
    SurvivalRuleChkBox2: TCheckBox;
    SurvivalRuleChkBox3: TCheckBox;
    SurvivalRuleChkBox4: TCheckBox;
    SurvivalRuleChkBox5: TCheckBox;
    SurvivalRuleChkBox6: TCheckBox;
    SurvivalRuleChkBox7: TCheckBox;
    SurvivalRuleChkBox8: TCheckBox;
    SurvivalSetLbl: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure SaveAsBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure ApplyBtnClick(Sender: TObject);
    procedure RuleComboChange(Sender: TObject);
    procedure SurvivalRuleChkBoxClick(Sender: TObject);
    procedure BirthRuleChkBoxClick(Sender: TObject);
    procedure ExplainBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fBirthCheckBoxes, fSurvivalCheckBoxes: array[0..8] of TCheckBox;
      {Array of check boxes for birth and survival influences}
    fWorkRule: TRule;
      {Storage for private WorkRule property}
    fOnApply: TNotifyEvent;
      {Storage for public OnApply event}
    procedure SetWorkRule(ARule: TRule);
      {Write access method for private WorkRule property}
    procedure UpdateButtons;
      {Updates state of buttons}
    procedure UpdateSetDisplay;
      {Updates display of influence sets in current work rule}
    property WorkRule: TRule read fWorkRule write SetWorkRule;
      {Stores rule currently being edited}
  public
    property OnApply: TNotifyEvent read fOnApply write fOnApply;
      {Event triggered when the Apply button is clicked - allows another class
      to respond to the button being clicked (allows LifeForm updates
      appropriate game objects)}
  end;

var
  EditRuleDlg: TEditRuleDlg;


implementation


uses
  // Delphi
  SysUtils, Dialogs, Windows,
  // Project
  Config, Shared, FmMainForm, FmNameSelectDlg, FmExplainRuleDlg;

{$R *.DFM}

{ --- Form event handlers --- }

{ +++ Form events +++ }

procedure TEditRuleDlg.FormCreate(Sender: TObject);
  {Form creation event. Sets caption and creates working rule object}
begin
  {Create working rule objects}
  fWorkRule := TRule.Create;
  {Set up arrays of check boxes}
  fBirthCheckBoxes[0] := BirthRuleChkBox0;
  fBirthCheckBoxes[1] := BirthRuleChkBox1;
  fBirthCheckBoxes[2] := BirthRuleChkBox2;
  fBirthCheckBoxes[3] := BirthRuleChkBox3;
  fBirthCheckBoxes[4] := BirthRuleChkBox4;
  fBirthCheckBoxes[5] := BirthRuleChkBox5;
  fBirthCheckBoxes[6] := BirthRuleChkBox6;
  fBirthCheckBoxes[7] := BirthRuleChkBox7;
  fBirthCheckBoxes[8] := BirthRuleChkBox8;
  fSurvivalCheckBoxes[0] := SurvivalRuleChkBox0;
  fSurvivalCheckBoxes[1] := SurvivalRuleChkBox1;
  fSurvivalCheckBoxes[2] := SurvivalRuleChkBox2;
  fSurvivalCheckBoxes[3] := SurvivalRuleChkBox3;
  fSurvivalCheckBoxes[4] := SurvivalRuleChkBox4;
  fSurvivalCheckBoxes[5] := SurvivalRuleChkBox5;
  fSurvivalCheckBoxes[6] := SurvivalRuleChkBox6;
  fSurvivalCheckBoxes[7] := SurvivalRuleChkBox7;
  fSurvivalCheckBoxes[8] := SurvivalRuleChkBox8;
end;

procedure TEditRuleDlg.FormCloseQuery(Sender: TObject;
    var CanClose: Boolean);
  {Close query event for form. Can close form if current rule hasn't been
  changed or if user gives permission to abandon}
begin
  CanClose := WorkRule.IsEqual(RuleList.CurrentRule)
      or (MessageDlg(
        Format(
          'Rule "%s" has been changed'#13#13
            + 'Do you wish to abandon the changes?',
          [WorkRule.Name]
        ),
        mtConfirmation,
        [mbYes, mbNo],
        0
      ) = mrYes);
end;

procedure TEditRuleDlg.FormDestroy(Sender: TObject);
  {Form destruction event. Frees owned object}
begin
  fWorkRule.Free;
end;

procedure TEditRuleDlg.FormShow(Sender: TObject);
var
  I: Integer; //loop control
begin
  // Load combo box with rule names
  RuleCombo.Clear;
  for I := 0 to RuleList.Count - 1 do
    RuleCombo.Items.Add(RuleList[I].Name);
  // Highlight current rule and use as working rule
  RuleCombo.ItemIndex := RuleList.Current;
  WorkRule := RuleList.CurrentRule;
  // Iniatialise display
  UpdateButtons;
  RuleCombo.SetFocus;
end;

{ +++ Button click events +++ }

procedure TEditRuleDlg.SaveBtnClick(Sender: TObject);
  {Save button click event. Overwites current rule with new contents. Makes no
  checks on desirability of action (depends on button being disabled when saving
  is not appropriate)}
begin
  {Overwrite current rule with working rule}
  RuleList.CurrentRule := WorkRule;
  {Update buttons}
  UpdateButtons;
end;

procedure TEditRuleDlg.SaveAsBtnClick(Sender: TObject);
  {Save As button click event. Saves a rule with a different name. User provides
  name which is validated. Checks whether rule exists and, if it does, either
  refuses to use name if it's not appropriate or gets permission to over-write}
var
  NewName: string;   {new name for rule provided by user}
  Index: Integer;    {index of new name in existing rule list}
  I: Integer;        {loop control}
begin
  {Prepare SaveIniDlg to get the required names}
  with NameSelectDlg do
  begin
    {set title & prompt}
    Title := 'Save Rule';
    Prompt := 'Choose or enter new rule &name:';
    {copy required rule names into combo box}
    NameCombo.Items.Clear;
    for I := 0 to RuleList.Count - 1 do
      if CompareText(RuleList[I].Name, CDefRuleName) <> 0 then
        NameCombo.Items.Add(RuleList[I].Name);
  end;
  {Call NameSelectDlg form to get name of rule from user}
  if NameSelectDlg.ShowModal = mrOK then
  begin
    {Got name and user clicked OK - validate name}
    NewName := NameSelectDlg.NameCombo.Text;
    if CompareText(NewName, CDefRuleName) = 0 then
    begin
      {user has specified 'Game of Life' - this name is reserved}
      MessageDlg(
        Format('Can''t save a rule with name "%s"', [CDefRuleName]),
        mtError,
        [mbOK],
        0
      );
      Exit;
    end;
    if MainForm.RuleInUse(NewName) then
    begin
      {the specified name exists and is in use - can't use it}
      MessageDlg(
        Format('Can''t overwrite rule "%s" - it is being used', [NewName]),
        mtError,
        [mbOK],
        0
      );
      Exit;
    end;
    if NewName = '' then
    begin
      {no name specified - there must be one}
      MessageDlg('You must name your rule', mtError, [mbOK], 0);
      Exit;
    end;
    {Name validated OK -record index of new name in rule combo box (or -1 if not
    in it)}
    Index := RuleCombo.Items.IndexOf(NewName);
    if Index = -1 then
    begin
      {Rule with this name doesn't already exist - add it}
      {record new name for working rule}
      WorkRule.Name := NewName;
      {add to rule list and to combo box and make it current}
      RuleList.Current := RuleList.Add(WorkRule);
      RuleCombo.Items.Add(WorkRule.Name);
      RuleCombo.ItemIndex := RuleList.Current;
      {udpate buttons}
      UpdateButtons;
    end
    else if (
      MessageDlg(
        Format('Rule "%s" already exists'#13#13'Overwrite?', [NewName]),
        mtConfirmation,
        [mbYes, mbNo],
        0
      ) = mrYes) then
    begin
      {Rule with this name already exists and user has given permission to
      overwrite - save it with new name}
      {record new name for work rule}
      WorkRule.Name := NewName;
      {overwrite in rule list}
      RuleList[Index] := WorkRule;
      {make rule current}
      RuleList.Current := Index;
      RuleCombo.ItemIndex := RuleList.Current;
      {update buttons}
      UpdateButtons;
    end;
  end;
end;

procedure TEditRuleDlg.DeleteBtnClick(Sender: TObject);
  {Delete button click event. Deletes current rule with user's permission. Makes
  no checks on desirability of action (depends on button being disabled when
  saving is not appropriate)}
begin
  {Get user to confirm deletion}
  if MessageDlg(
    Format('Are you sure you want to delete rule "%s"?', [WorkRule.Name]),
    mtConfirmation,
    [mbYes, mbNo],
    0
  )= mrYes then
  begin
    {Delete current work rule}
    RuleCombo.Items.Delete(RuleList.Current);
    RuleList.Delete(RuleList.Current);
    {Highlight new current rule}
    RuleCombo.ItemIndex := RuleList.Current;
    {Record details of new current rule}
    WorkRule := RuleList.CurrentRule;
    {Update buttons}
    UpdateButtons;
  end;
end;

procedure TEditRuleDlg.ApplyBtnClick(Sender: TObject);
  {Apply button click event. Calls any registered event handler in another form
  to perform required processing. Makes no checks on desirability of action
  (depends on button being disabled when saving is not appropriate)}
begin
  {Call event handler for apply button event}
  if Assigned(fOnApply) then fOnApply(Self);
  {Update buttons given result of applying event handler}
  UpdateButtons;
end;

procedure TEditRuleDlg.ExplainBtnClick(Sender: TObject);
  {Explain button click event. Displays explanation of current rule in a
  dialogue box}
begin
  with ExplainRuleDlg do
  begin
    {Set the influence properties for the dialogue box}
    BirthSetStr := WorkRule.BirthInfluence.AsString;
    SurvivalSetStr := WorkRule.SurvivalInfluence.AsString;
    {Display the dialogue box}
    ShowModal;
  end;
end;

{ +++ Rule combo box events +++ }

procedure TEditRuleDlg.RuleComboChange(Sender: TObject);
  {Rule Combo box change event. Loads the selected rule. Checks to see if user
  wants to loose any un-saved changes before doing so}
begin
  {Test if working rule has been updated since last saved - if so get permission
  from user to abandon it}
  if WorkRule.IsEqual(RuleList.CurrentRule)
    or (MessageDlg(
      Format(
        'Rule "%s" has been changed'#13#13
          + 'Do you wish to abandon the changes?',
        [WorkRule.Name]
      ),
      mtConfirmation,
      [mbYes, mbNo],
      0
    ) = mrYes) then
  begin
    {Either rule hasn't changed or user wishes to loose changes - move to
    selected rule}
    RuleList.Current := RuleCombo.ItemIndex;
    WorkRule := RuleList.CurrentRule;
  end
  else
    {Rule has changed and user doesn't want to loose changes - restore
    current rule}
    RuleCombo.ItemIndex := RuleList.Current;
  {Update buttons for new rule}
  UpdateButtons;
end;

{ +++ Influence check box events +++ }

procedure TEditRuleDlg.BirthRuleChkBoxClick(Sender: TObject);
  {Click event for Birth Rule check boxes}
begin
  {Update birth influence set for current rule, either adding or removing
  relevant element depending on state of check box}
  with Sender as TCheckBox do
    if Checked then
      WorkRule.BirthInfluence.AsSet := WorkRule.BirthInfluence.AsSet + [Tag]
    else
      WorkRule.BirthInfluence.AsSet := WorkRule.BirthInfluence.AsSet - [Tag];
  {Display new set contents}
  UpdateSetDisplay;
  {Update buttons to reflect changes}
  UpdateButtons;
end;

procedure TEditRuleDlg.SurvivalRuleChkBoxClick(Sender: TObject);
  {Click event for Survival Rule check boxes}
begin
  {Update survival influence set for current rule, either adding or removing
  relevant element depending on state of check box}
  with Sender as TCheckBox do
    if Checked then
      WorkRule.SurvivalInfluence.AsSet := WorkRule.SurvivalInfluence.AsSet + [Tag]
    else
      WorkRule.SurvivalInfluence.AsSet := WorkRule.SurvivalInfluence.AsSet - [Tag];
  {Display new set contents}
  UpdateSetDisplay;
  {Update buttons to reflect changes}
  UpdateButtons;
end;

{ --- Private methods --- }

{ +++ Property access methods +++ }

procedure TEditRuleDlg.SetWorkRule(ARule: TRule);
  {Write access method for private WorkRule property - copies given rule to
  working rule object and updates edit boxes with correct influence strings}
var
  I: Integer;    {loop control}
begin
  {Assign new rule instance to WorkRule property}
  fWorkRule.Assign(ARule);
  {Check / un check check boxes according to new rule}
  for I := 0 to 8 do
  begin
     fBirthCheckBoxes[I].Checked := I in ARule.BirthInfluence.AsSet;
     fSurvivalCheckBoxes[I].Checked := I in ARule.SurvivalInfluence.AsSet;
  end;
  {Update display of items in birth and survival sets}
  UpdateSetDisplay;
end;

{ +++ Other private methods +++ }

procedure TEditRuleDlg.UpdateButtons;
  {Updates state of buttons to allow only valid actions}
begin
  {Save button is enabled only when a rule has been changed, it isn't the
  default 'Game of Life' rule and the rule isn't in use in the current game}
  SaveBtn.Enabled := not WorkRule.IsEqual(RuleList.CurrentRule)
      and (WorkRule.Name <> CDefRuleName)
      and not MainForm.RuleInUse(WorkRule.Name);
  {Delete button is enabled only when a rule hasn't been chnaged, it isn't the
  default "Game of Life' rule and the rule isn't in use in the current game}
  DeleteBtn.Enabled := WorkRule.IsEqual(RuleList.CurrentRule)
      and (WorkRule.Name <> CDefRuleName)
      and not MainForm.RuleInUse(WorkRule.Name);
  {Apply button is enabled only when a rule hasn't been edited and not saved}
  ApplyBtn.Enabled := WorkRule.IsEqual(RuleList.CurrentRule);
end;

procedure TEditRuleDlg.UpdateSetDisplay;
  {Updates display of influence sets in current work rule}
  function SetNotation(S: TInfluenceSet): string;
    {Subsidiary function to return string describing the given set in set
    notation}
  var
    I: Integer;      {loop vontrol}
    First: Boolean;  {flag true when first set element being output}
  begin
    {Opening brace of set}
    Result := '{';
    {The next element is the first one}
    First := True;
    {Iterate over possible set value}
    for I := 0 to 8 do
      if I in S then
      begin
        {The number is in the set - no preceeding comma if first item}
        if not First then Result := Result + ',';
        Result := Result + chr(ord('0') + I);
        {We've now done the first element}
        First := False;
      end;
    {Add closing brace of set}
    Result := Result + '}';
  end;
begin
  {Display influence set in set notation in label of each influence}
  BirthSetLbl.Caption := SetNotation(WorkRule.BirthInfluence.AsSet);
  SurvivalSetLbl.Caption := SetNotation(WorkRule.SurvivalInfluence.AsSet);
end;

end.