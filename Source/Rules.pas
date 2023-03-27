{
  Distributed under the MIT license.
  See the accompanying LICENSE file or go to
  http://delphidabbler.mit-license.org/1992-2015/
}

unit Rules;

interface

uses
  {Delphi library unit}
  Classes;

type

  TInfluenceSet = set of 0..8;
    {The set of possible numbers of neighbours influencing a cell}

  TInfluence = class(TObject)
    {Class which encapsulates an "influence set" (the set of numbers of cells
    which influence birth or survival of a life-form for a given rule). Each
    rule has a birth and a survival influence set}
  private
    FNeighbours : TInfluenceSet;
      {The influence set}
    function GetAsString : string;
      {Read access method for AsString property}
    procedure SetAsString(AStr : string);
      {Write access method for AsString property}
  public
    procedure Assign(Source : TInfluence);
      {Assigns contents of Source influence object to this object}
    property AsSet : TInfluenceSet read FNeighbours write FNeighbours;
      {The influence set}
    property AsString : string read GetAsString write SetAsString;
      {The influence set coded as a string}
  end;

  TRule = class(TObject)
    {Class encapsulating a game of life rule}
  private
    FName : string;
      {Storage for Name property}
    FBirthInfluence : TInfluence;
      {Storage for BirthInfluence property}
    FSurvivalInfluence : TInfluence;
      {Storage for SurvivalInfluence property}
    FOnChange : TNotifyEvent;
      {Storage for OnChange event}
    procedure SetBirthInfluence(AnInfluence : TInfluence);
      {Write access method for BirthInfluence property}
    procedure SetSurvivalInfluence(AnInfluence : TInfluence);
      {Write access method for SurvivalInfluence property}
    procedure SetName(AName : string);
      {Write access method for Name property}
    procedure Changed;
      {Calls OnChanged event if one has been assigned}
  public
    constructor Create;
      {Class constructor}
    destructor Destroy; override;
      {Class destructor}
    procedure Assign(Source : TRule);
      {Assigns contents of Source rule object to this object}
    function IsEqual(Source : TRule) : Boolean;
      {Returns true if Source rule is the same as this rule - i.e. all its
      fields are the same as all this object's fields}
    property BirthInfluence : TInfluence read FBirthInfluence
        write SetBirthInfluence;
      {The influence object representing the set of neighbour counts that cause
      a Life-Form to be born}
    property SurvivalInfluence : TInfluence read FSurvivalInfluence
        write SetSurvivalInfluence;
      {The influence object representing the set of neighbour counts that cause
      a Life-Form to survive}
    property Name : string read FName write SetName;
      {The name of the rule}
    property OnChange : TNotifyEvent read FOnChange write FOnChange;
      {Event triggered when a rule is changed}
  end;

  TRules = class(TObject)
    {Class which encapsulates and manages the list of rules known to a program}
  private
    FList : TList;
      {List object}
    FCurrent : integer;
      {Storage for Current property}
    function GetItem(I : integer) : TRule;
      {Read access method for Items array property}
    procedure SetItem(I : integer; TheRule : TRule);
      {Write access method for Items array property}
    function GetCount : integer;
      {Read access method for Count property}
    function GetCurrentRule : TRule;
      {Read access method for CurrentRule property}
    procedure SetCurrentRule(ARule : TRule);
      {Write access method for CurrentRule property}
  public
    constructor Create;
      {Class construcor}
    destructor Destroy; override;
      {Class destructor}
    procedure Delete(const Index : integer);
      {Deletes the rule at the given index from the list}
    function Add(ARule : TRule) : integer;
      {Appends given rule to end of list}
    function IndexOf(ARule : TRule) : integer;
      {Returns the index in the list of the given rule or -1 if rule not in
      list}
    function IndexOfName(AName : string) : integer;
      {Returns the index in list of a rule with given name or -1 if there is no
      rule with the name in the list}
    function IndexOfInfluences(ARule : TRule) : integer;
      {Returns the index in list of a rule with sane influences as given rule or
      -1 if there is no such rule}
    property Items[I : integer] : TRule read GetItem write SetItem; default;
      {The rules in the list}
    property Count : integer read GetCount;
      {The number of rules in the list}
    property Current : integer read FCurrent write FCurrent;
      {The index of the current rule in the list}
    property CurrentRule : TRule read GetCurrentRule write SetCurrentRule;
      {The current rule in the list}
  end;

var
  RuleList : TRules;

implementation

uses
  {Delphi library unit}
  SysUtils,
  {Project units}
  Config, Shared;


{ ++++++++++++++ }
{ +++ TRules +++ }
{ ++++++++++++++ }

{ --- Public methods --- }

constructor TRules.Create;
  {Class constructor - creates owned list object and builds list from ini file}
var
  NumRules : integer;     {number of rules in ini file}
  R : TRule;              {rule object to be added to rule list}
  I : integer;            {loop control}
begin
  inherited Create;
  {Create list object}
  FList := TList.Create;
  {Create rule list using ini file}
  {record number of rules in ini file}
  NumRules := ConfigFile.NumRules;
  if NumRules > 0 then
    {there are some rules - read them and build list of rules}
    for I := 0 to NumRules - 1 do
    begin
      {create object to hold rule}
      R := TRule.Create;
      {find rule name}
      R.Name := ConfigFile.RuleNames[I];
      {read influences for given rule}
      R.BirthInfluence.AsString := ConfigFile.RuleBirthSet[R.Name];
      R.SurvivalInfluence.AsString := ConfigFile.RuleSurvivalSet[R.Name];
      {add to list only - already in ini file}
      FList.Add(R);
    end
  else
  begin
    {there are no rules - create Game of Life default rule}
    {create object to hold default rule}
    R := TRule.Create;
    {add default rule to list and ini file - Game of Life - this is always
    present}
    Add(R);
  end;
  {Record current rule}
  FCurrent := ConfigFile.CurrentRuleId;
  if (FCurrent < 0) or (FCurrent >= FList.Count) then
    FCurrent := 0;
end;

destructor TRules.Destroy;
  {Class destructor - records current rule in ini file and frees owned list
  object and all rule objects in the list}
var
  I : integer;    {loop control}
begin
  {Record current rule}
  ConfigFile.CurrentRuleId := FCurrent;
  {Free all rule objects}
  for I := 0 to FList.Count - 1 do
    TRule(FList[I]).Free;
  {Free the list}
  FList.Free;
  inherited Destroy;
end;

procedure TRules.Delete(const Index : integer);
  {Deletes the rule at the given index from the list}
var
  I : integer;            {loop control}
  DeletedName : string;   {name of rule being deleted}
begin
  {Record name of rule being deleted for later use}
  DeletedName := TRule(FList[Index]).Name;
  {Remove rule from list}
  TRule(FList[Index]).Free;
  FList.Delete(Index);
  {Update ini file}
  {record reduced number of rules}
  ConfigFile.NumRules := FList.Count;
  {renumber all rules following deleted rule}
  for I := Index to FList.Count - 1 do
    ConfigFile.RuleNames[I] := TRule(FList[I]).Name;
  {delete reference to last rule}
  ConfigFile.RuleNames[FList.Count] := '';
  {erase section describing rule in ini file}
  ConfigFile.EraseRule(DeletedName);
  {update current index}
  if FCurrent > Index then
    {current rule had higher index than one deleted - reduce current}
    Dec(FCurrent)
  else if FCurrent = Index then
    {current rule was deleted - renumber current rule if there was no following
    rule (if there was then it will already have been renumbered to be current}
    if Index = FList.Count then
      {there is no following item - use one before (this gives -1 as required if
      list is now empty}
      Dec(FCurrent);
end;

function TRules.Add(ARule : TRule) : integer;
  {Appends given rule to end of list}
var
  R : TRule;  {new rule object to be placed in list}
begin
  {Create storage and record new rule}
  R := TRule.Create;
  R.Assign(ARule);
  {Add new rule to list}
  Result := FList.Add(R);
  {Update ini file}
  {record increased number of rules}
  ConfigFile.NumRules := FList.Count;
  {add reference to new rule}
  ConfigFile.RuleNames[Result] := R.Name;
  {add section describing new rule}
  ConfigFile.RuleBirthSet[R.Name] := R.BirthInfluence.AsString;
  ConfigFile.RuleSurvivalSet[R.Name] := R.SurvivalInfluence.AsString;
end;

function TRules.IndexOf(ARule : TRule) : integer;
  {Returns the index in the list of the given rule or -1 if rule not in list}
var
  I : integer;    {loop control}
begin
  {Set "not found" result}
  Result := -1;
  {Scan rule list looking for an equivalent rule}
  for I := 0 to RuleList.Count - 1 do
    if RuleList[I].IsEqual(ARule) then
    begin
      {Found one - record its index as result and escape from loop}
      Result := I;
      Break;
    end;
end;

function TRules.IndexOfName(AName : string) : integer;
  {Returns the index in list of a rule with given name or -1 if there is no rule
  with the name in the list}
var
  I : integer;    {loop control}
begin
  {Set "not found" result}
  Result := -1;
  {Scan rule list looking for a rule with same name}
  for I := 0 to RuleList.Count - 1 do
    if CompareText(RuleList[I].Name, AName) = 0 then
    begin
      {Found one - record its index as result and escape from loop}
      Result := I;
      Break;
    end;
end;

function TRules.IndexOfInfluences(ARule : TRule) : integer;
  {Returns the index in list of a rule with sane influences as given rule or -1
  if there is no such rule}
var
  I : integer;    {loop control}
begin
  {Set "not found" result}
  Result := -1;
  {Scan rule list looking for a rule with same influences}
  for I := 0 to RuleList.Count - 1 do
    if (RuleList[I].BirthInfluence.AsSet = ARule.BirthInfluence.AsSet)
        and (RuleList[I].SurvivalInfluence.AsSet
        = ARule.SurvivalInfluence.AsSet) then
    begin
      {Found one - record its index as result and escape from loop}
      Result := I;
      Break;
    end;
end;

{ --- Private property access methods --- }

function TRules.GetItem(I : integer) : TRule;
  {Read access method for Items array property}
begin
  Result := TRule(Flist[I]);
end;

procedure TRules.SetItem(I : integer; TheRule : TRule);
  {Write access method for Items array property}
begin
  {Record new rule}
  TRule(FList[I]).Assign(TheRule);
  {Update ini file}
  ConfigFile.RuleBirthSet[TheRule.Name] := TheRule.BirthInfluence.AsString;
  ConfigFile.RuleSurvivalSet[TheRule.Name] :=
      TheRule.SurvivalInfluence.AsString;
end;

function TRules.GetCount : integer;
  {Read access method for Count property}
begin
  Result := FList.Count;
end;

function TRules.GetCurrentRule : TRule;
  {Read access method for CurrentRule property}
begin
  Result := RuleList[RuleList.Current];
end;

procedure TRules.SetCurrentRule(ARule : TRule);
  {Write access method for CurrentRule property}
begin
  RuleList[RuleList.Current] := ARule;
end;


{ +++++++++++++ }
{ +++ TRule +++ }
{ +++++++++++++ }

{ --- Public methods --- }

constructor TRule.Create;
  {Class constructor - creates owned objects and sets rule "Game of Life"}
begin
  {Create influence objects}
  FBirthInfluence := TInfluence.Create;
  FSurvivalInfluence := TInfluence.Create;
  {Set influence to those used in Game of Life}
  FBirthInfluence.AsSet := [3];
  FSurvivalInfluence.AsSet := [2,3];
  {Set name to the default name}
  FName := CDefRuleName;
end;

destructor TRule.Destroy;
  {Class destructor - frees owned influence objects}
begin
  FSurvivalInfluence.Free;
  FBirthInfluence.Free;
end;

procedure TRule.Assign(Source : TRule);
  {Assigns contents of Source rule object to this object}
begin
  {Copy all fields of source object to this one}
  FBirthInfluence.Assign(Source.FBirthInfluence);
  FSurvivalInfluence.Assign(Source.FSurvivalInfluence);
  FName := Source.FName;
  {Trigger OnChange event}
  Changed;
end;

function TRule.IsEqual(Source : TRule) : Boolean;
  {Returns true if Source rule is the same as this rule - i.e. all its fields
  are the same as all this object's fields}
begin
  {Check if name and influence objects are the same}
  Result := (CompareText(FName, Source.FName) = 0)
      and (FBirthInfluence.AsSet = Source.FBirthInfluence.AsSet)
      and (FSurvivalInfluence.AsSet = Source.FSurvivalInfluence.AsSet);
end;

{ --- Private property access methods --- }

procedure TRule.SetBirthInfluence(AnInfluence : TInfluence);
  {Write access method for BirthInfluence property}
begin
  {Assign new influence to object field}
  FBirthInfluence.Assign(AnInfluence);
  {Trigger on change event}
  Changed;
end;

procedure TRule.SetSurvivalInfluence(AnInfluence : TInfluence);
  {Write access method for SurvivalInfluence property}
begin
  {Assign new influence to object field}
  FSurvivalInfluence.Assign(AnInfluence);
  {Trigger on change event}
  Changed;
end;

procedure TRule.SetName(AName : string);
  {Write access method for Name property}
begin
  {Record new name in field}
  FName := AName;
  {Trigger on change event}
  Changed;
end;

{ --- Other private methods --- }

procedure TRule.Changed;
  {Calls OnChanged event if one has been assigned}
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;


{ ++++++++++++++++++ }
{ +++ TInfluence +++ }
{ ++++++++++++++++++ }

{ --- Public methods --- }

procedure TInfluence.Assign(Source : TInfluence);
  {Assigns contents of Source influence object to this object}
begin
  {Copy the only field of the object}
  FNeighbours := Source.FNeighbours;
end;

{ --- Private property access methods --- }

function TInfluence.GetAsString : string;
  {Read access method for AsString property - codes influence set as a string
  which has one character representing each digit in the influence set}
var
  I : integer;      {loop control}
begin
  {Set result to represent empty set}
  Result := '';
  {Check if each possible member of the influence set is in the set and add its
  character representation to the string if so}
  for I := 0 to 8 do
    if I in FNeighbours then
      Result := Result + Chr(I + Ord('0'));
end;

procedure TInfluence.SetAsString(AStr : string);
  {Write access method for AsString property - sets the influence set to
  correspond to the elements represented as characters in the string. It is an
  error if the string contains invalid characters}
var
  I : integer;      {loop control}
begin
  {Set result to empty set}
  FNeighbours := [];
  {For each digit represented in the string add the corresponding element to the
  array}
  for I := 1 to Length(AStr) do
    Include(FNeighbours, Ord(AStr[I]) - Ord('0'));
end;

initialization

// Create TRules singleton at start-up
RuleList := TRules.Create;

finalization

// Free singleton
RuleList.Free;

end.
