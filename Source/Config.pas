{
  Distributed under the MIT license.
  See the accompanying LICENSE file or go to
  http://delphidabbler.mit-license.org/1992-2015/
}

unit Config;

interface

uses
  {Delphi library units}
  IniFiles, Graphics,
  {Project units}
  Shared;

type
  TConfigFile = class(TObject)
  private
    FIniFile : TIniFile;
      {Ini file handling object}
    FShowStatusBar : Boolean;
      {Storage for public ShowStatusBar property}
    function ConfigFilePath: string;
      {Returns fully specified name of config file. If program is running from
      a Program Files folder then the config file is stored in asub-directory of
      the current user's application data directory. Otherwise the config file
      is stored in the same directory as the program}
    function GetNumSchemes : integer;
      {Read access method for NumSchemes property}
    procedure SetNumSchemes(ANum : integer);
      {Write access method for NumSchemes property}
    function GetCurrentSchemeId : Integer;
      {Read access method for CurrentSchemeId property}
    procedure SetCurrentSchemeId(AnId : integer);
      {Write access method for CurrentScheme Id property}
    function GetSchemeName(AnId : Integer) : string;
      {Read access method for SchemeNames property}
    procedure SetSchemeName(AnId : Integer; AName : string);
      {Write access method for SchemeNames property}
    function GetSchemeColour(AScheme : string; AnElement : TGridElement)
        : TColor;
      {Read access method for SchemeColours property}
    procedure SetSchemeColour(AScheme : string; AnElement : TGridElement;
        AColor : TColor);
      {Write access method for SchemeColours property}
    function GetNumRules : integer;
      {Read access method for NumRules property}
    procedure SetNumRules(ANum : integer);
      {Write access method for NumRules property}
    function GetCurrentRuleId : integer;
      {Read access method for CurrentRuleId property}
    procedure SetCurrentRuleId(AnId : integer);
      {Write access method for CurrentRuleId property}
    function GetRuleName(AnId : integer) : string;
      {Read access method for RuleNames property}
    procedure SetRuleName(AnId : integer; AName : string);
      {Write access method for RuleNames property}
    function GetBirthRuleSet(AName : string) : string;
      {Read access method for BirthRuleSet property}
    procedure SetBirthRuleSet(AName : string; TheValue : string);
      {Write access method for BirthRuleSet property}
    function GetSurvivalRuleSet(AName : string) : string;
      {Read access method for SurvivalRuleSet property}
    procedure SetSurvivalRuleSet(AName : string; TheValue : string);
      {Write access method for SurvivalRuleSet property}
  public
    constructor Create;
      {Class constructor}
    destructor Destroy; override;
      {Destructor - writes out config information and frees ini file}
    procedure EraseScheme(ASchemeName : string);
      {Method to erase the ini file section for the given scheme}
    procedure EraseRule(ARuleName : string);
      {Method to erase the ini file section for the given rule}
    property NumSchemes : integer read GetNumSchemes write SetNumSchemes;
      {The number of named colour schemes recorded in the ini file}
    property CurrentSchemeId : Integer read GetCurrentSchemeId
        write SetCurrentSchemeId;
      {The id number of the named scheme currently in use, or -1 if the current
      scheme is not named}
    property SchemeNames[AnId : Integer] : string read GetSchemeName
        write SetSchemeName;
      {List of scheme names accessed by id numbers}
    property SchemeColours[AScheme : string; AnElement : TGridElement] : TColor
        read GetSchemeColour write SetSchemeColour;
      {Table of colours used for each grid element in each colour scheme}
    property ShowStatusBar : Boolean read FShowStatusBar write FShowStatusBar;
      {Whether status bar is to be displayed}
    property NumRules : integer read GetNumRules write SetNumRules;
      {The number of named rules recorded in the ini file}
    property CurrentRuleId : Integer read GetCurrentRuleId
        write SetCurrentRuleId;
      {The id number of the named rule currently in use, or -1 if the current
      rule is not named}
    property RuleNames[AnId : Integer] : string read GetRuleName
        write SetRuleName;
      {List of rule names accessed by id numbers}
    property RuleBirthSet[AName : string] : string read GetBirthRuleSet
        write SetBirthRuleSet;
      {The birth influences for a given rule in string format}
    property RuleSurvivalSet[AName : string] : string read GetSurvivalRuleSet
        write SetSurvivalRuleSet;
      {The survival influences for a given rule in string format}
  end;

var
  ConfigFile : TConfigFile;

implementation

uses
  {Delphi library units}
  SysUtils, StrUtils,
  // Project units
  SystemFolders;

const
  {ini file variable names for each grid element colour}
  CElements : array[TGridElement] of string =
    ('Background', 'GridLine', 'LifeForm', 'Highlight');
  {default colours to be used for particular grid elements if none specified}
  CDefColours : array[TGridElement] of TColor =
    (CBackgroundColour, CGridLineColour, CLifeFormColour, CHighlightColour);

function TConfigFile.ConfigFilePath: string;
  {Returns fully specified name of config file. If program is running from a
  Program Files folder then the config file is stored in asub-directory of the
  current user's application data directory. Otherwise the config file is stored
  in the same directory as the program}

  function IsSubDirOf(const ParentPath, SubDirPath: string): Boolean;
    {Checks if a fully qualified directory path is a sub-directory of another
    fully qualified directory path.
      @param ParentPath [in] Fully qualified path of parent directory.
      @param SubDirPath [in] Fully qualified path of possible sub-directory.
      @return True if SubDirPath is a sub-directory of ParentPath or False if
        not.
    }
  begin
    if ParentPath = '' then
      Result := False
    else
      Result := StartsStr(ParentPath, SubDirPath);
  end;

var
  ExeDir: string;
const
  AppDataSubDir = 'DelphiDabbler\Life';
  ConfigFileName = 'Life.ini';
begin
  ExeDir := ExtractFileDir(ParamStr(0));
  if IsSubDirOf(TSystemFolders.ProgramFilesDir, ExeDir) or
    IsSubDirOf(TSystemFolders.ProgramFilesX86Dir, ExeDir) or
    IsSubDirOf(TSystemFolders.CommonFilesDir, ExeDir) or
    IsSubDirOf(TSystemFolders.CommonFilesX86Dir, ExeDir) then
  begin
    ForceDirectories(
      IncludeTrailingPathDelimiter(TSystemFolders.PerUserAppDataDir)
        + AppDataSubDir
    );
    Result := IncludeTrailingPathDelimiter(TSystemFolders.PerUserAppDataDir)
      + IncludeTrailingPathDelimiter(AppDataSubDir)
      + ConfigFileName;
  end
  else
    Result := IncludeTrailingPathDelimiter(ExeDir) + ConfigFileName;
end;

constructor TConfigFile.Create;
  {Class constructor - creates ini file object and reads in status bar
  property values}
begin
  inherited Create;
  {Create ini file object for the life.ini file}
  FIniFile := TIniFile.Create(ConfigFilePath);
  {Find whether status bar was showing - assume so if no ini file entry}
  FShowStatusBar := FIniFile.ReadBool('System', 'StatusBarShowing', True);
end;

destructor TConfigFile.Destroy;
  {Destructor - writes out config information and frees ini file}
begin
  {Write out state of status bar}
  FIniFile.WriteBool('System', 'StatusBarShowing', FShowStatusBar);
  {Free the ini file object}
  FIniFile.Free;
  inherited Destroy;
end;

procedure TConfigFile.EraseScheme(ASchemeName : string);
  {Method to erase the ini file section for the given scheme}
begin
  FIniFile.EraseSection('Colour Scheme:'+ASchemeName);
end;

procedure TConfigFile.EraseRule(ARuleName : string);
  {Method to erase the ini file section for the given rule}
begin
  FIniFile.EraseSection('Rule:'+ARuleName);
end;

function TConfigFile.GetNumSchemes : integer;
  {Read access method for NumSchemes property - reads number of schemes from ini
  file - returns 0 if no count of schemes is specified}
begin
  Result := FIniFile.ReadInteger('Colour Schemes', 'Count', 0);
end;

procedure TConfigFile.SetNumSchemes(ANum : integer);
  {Write access method for NumSchemes property - writes given number of schemes
  to ini file}
begin
  FIniFile.WriteInteger('Colour Schemes', 'Count', ANum);
end;

function TConfigFile.GetCurrentSchemeId : Integer;
  {Read access method for CurrentSchemeId property - reads id of current scheme
  from ini file - returns -1 if no current named scheme}
begin
  Result := FIniFile.ReadInteger('Colour Schemes', 'Current', -1);
end;

procedure TConfigFile.SetCurrentSchemeId(AnId : integer);
  {Write access method for CurrentSchemeId property - writes given current
  scheme id to ini file}
begin
  FIniFile.WriteInteger('Colour Schemes', 'Current', AnId);
end;

function TConfigFile.GetSchemeName(AnId : Integer) : string;
  {Read access method for SchemeNames array property - reads scheme name for
  given scheme id from ini file and returns it - returns empty string if there
  is no such scheme}
begin
  Result := FIniFile.ReadString('Colour Schemes',
    Format('Scheme %d',[AnId]), '');
end;

procedure TConfigFile.SetSchemeName(AnId : Integer; AName : string);
  {Write access method for SchemeNames array property - writes the given name
  for specified scheme id to ini file}
begin
  FIniFile.WriteString('Colour Schemes', Format('Scheme %d',[AnId]), AName);
end;

function TConfigFile.GetSchemeColour(AScheme : string; AnElement : TGridElement)
    : TColor;
  {Read access method for SchemeColours array property - reads colour number for
  given element of given scheme from ini file and returns it - returns default
  colour for the element if there is no relevant entry in ini file}
begin
  if AScheme = '' then AScheme := '<Unknown>';
  Result := FIniFile.ReadInteger('Colour Scheme:'+AScheme, CElements[AnElement],
      CDefColours[AnElement]);
end;

procedure TConfigFile.SetSchemeColour(AScheme : string;
    AnElement : TGridElement; AColor : TColor);
  {Write access method for SchemeColours array property - writes the given
  colour to the ini file file for the given scheme and grid element}
begin
  if AScheme = '' then AScheme := '<Unknown>';
  FIniFile.WriteInteger('Colour Scheme:'+AScheme, CElements[AnElement], AColor);
end;

function TConfigFile.GetNumRules : integer;
  {Read access method for NumRules property - returns number of rules recorded
  in ini file - 0 if no entry in file}
begin
  Result := FIniFile.ReadInteger('Rules', 'NumRules', 0);
end;

procedure TConfigFile.SetNumRules(ANum : integer);
  {Write access method for NumRules property - writes number of rules to ini
  file}
begin
  FIniFile.WriteInteger('Rules', 'NumRules', ANum);
end;

function TConfigFile.GetCurrentRuleId : integer;
  {Read access method for CurrentRuleId property - reads id number of current
  rule, returns -1 if no entry in ini file}
begin
  Result := FIniFile.ReadInteger('Rules', 'CurrentRuleId', -1);
end;

procedure TConfigFile.SetCurrentRuleId(AnId : integer);
  {Write access method for CurrentRuleId property - writes id of rule currently
  in use to ini file}
begin
  FIniFile.WriteInteger('Rules', 'CurrentRuleId', AnId);
end;

function TConfigFile.GetRuleName(AnId : integer) : string;
  {Read access method for RuleNames array property - reads name of rule with
  given id from ini file - returns '<Unknown>' if there is no entry in ini file
  for this rule id}
begin
  Result := FIniFile.ReadString('Rules', Format('Rule %d',[AnId]), '<Unknown>');
end;

procedure TConfigFile.SetRuleName(AnId : integer; AName : string);
  {Write access method for RuleNames array property - writes the given name to
  ini file for rule with given id}
begin
  FIniFile.WriteString('Rules', Format('Rule %d',[AnId]), AName);
end;

function TConfigFile.GetBirthRuleSet(AName : string) : string;
  {Read access method for BirthRuleSet array property - reads birth influence
  set as a string from ini file - returns '#' (which is not a valid set member)
  if there is no entry for the rule in ini file}
begin
  Result := FIniFile.ReadString('Rule:'+AName, 'BirthSet', '#');
end;

procedure TConfigFile.SetBirthRuleSet(AName : string; TheValue : string);
  {Write access method for BirthRuleSet array property - writes given birth
  influence set in string format for given rule to ini file}
begin
  FIniFile.WriteString('Rule:'+AName, 'BirthSet', TheValue);
end;

function TConfigFile.GetSurvivalRuleSet(AName : string) : string;
  {Read access method for SurvivalRuleSet array property - reads survival
  influence set as a string from ini file - returns '#' (which is not a valid
  set member) if there is no entry for the rule in ini file}
begin
  Result := FIniFile.ReadString('Rule:'+AName, 'SurvivalSet', '#');
end;

procedure TConfigFile.SetSurvivalRuleSet(AName : string; TheValue : string);
  {Write access method for SurvivalRuleSet array property - writes given
  survival influence set in string format for given rule to ini file}
begin
  FIniFile.WriteString('Rule:'+AName, 'SurvivalSet', TheValue);
end;

initialization

// Create TConfigFile singleton at start-up
ConfigFile := TConfigFile.Create;

finalization

// Free singleton
ConfigFile.Free;

end.
