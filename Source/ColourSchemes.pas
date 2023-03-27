{
  Distributed under the MIT license.
  See the accompanying LICENSE file or go to
  http://delphidabbler.mit-license.org/1992-2015/
}

unit ColourSchemes;

interface

uses
  Graphics, Classes,        {Delphi library units}
  Shared;                   {Propject unit}

type
  TGridColours = class(TObject)
    {Class encapsulating a colour scheme}
  private
    {Property storage}
    FName : string;
    FColours : array[TGridElement] of TColor;
    FOnChange : TNotifyEvent;
    {Property access methods}
    procedure SetName(AName : string);
    function GetColour(Element : TGridElement) : TColor;
    procedure SetColour(Element : TGridElement; AColor : TColor);
    {Other methods}
    procedure Changed;
      {Triggers OnChange event}
  public
    constructor Create;
      {Class constructor - creates a default colour scheme}
    procedure Assign(Source : TGridColours);
      {Method which assigns one colour scheme to another}
    procedure ReadFromIni;
      {Reads the colour scheme from the program's ini file}
    procedure WriteToIni;
      {Writes the colour scheme to the program's ini file}
    property Name : string read FName write SetName;
      {The name of the scheme}
    property Colours[Element : TGridElement] : TColor read GetColour
        write SetColour; default;
      {The colours of the various grid elements within the scheme}
    property OnChange : TNotifyEvent read FOnChange write FOnChange;
      {Event triggered when the current scheme's index changes}
  end;

  TColourSchemes = class(TObject)
    {Class encapsulating and maintaining list of colour schemes available to the
    program}
  private
    {Property storage}
    FCurrentIndex : integer;
    FOnCurrentIndexChange : TNotifyEvent;
    {Other storage}
    FList : TList;
      {Used to maintain the list}
    FUnknown : TGridColours;
      {An "unknown" colour scheme}
    {Property access methods}
    function GetItem(I : integer) : TGridColours;
    procedure SetItem(I : integer; AScheme : TGridColours);
    function GetCount : integer;
    procedure SetCurrentIndex(AnIndex : integer);
    function GetCurrentScheme : TGridColours;
    procedure SetCurrentScheme(AScheme : TGridColours);
    {Other methods}
    procedure CurrentIndexChanged;
  public
    constructor Create;
      {Class constructor - creates the scheme list and reads in from ini file}
    destructor Destroy; override;
      {Class destructor - destroys the scheme list and records current scheme
      index in ini file}
    procedure Delete(const Index : integer);
      {Deletes the scheme at the given index from the list}
    function Add(AScheme : TGridColours) : integer;
      {Adds the given colour scheme to the end of the list of schemes}
    function IndexOfName(AName : string) : integer;
      {The index of the colour scheme with the given name in the list - returns
      -1 if no such scheme found}
    property Items[I : Integer] : TGridColours read GetItem write SetItem;
        default;
      {The colour schemes in the scheme list}
    property Count : integer read GetCount;
      {The number of colour schemes in the scheme list}
    property CurrentIndex : integer read FCurrentIndex write SetCurrentIndex;
      {The index of the current scheme in the scheme list}
    property CurrentScheme : TGridColours read GetCurrentScheme
        write SetCurrentScheme;
      {The current scheme in the scheme list}
    property OnCurrentIndexChange : TNotifyEvent read FOnCurrentIndexChange
        write FOnCurrentIndexChange;
      {Event triggered when current scheme index changes}
  end;

var
  ColourSchemeList : TColourSchemes;

implementation

uses
  SysUtils,                 {Delphi library unit}
  Config;                   {Project unit}


{ ++++++++++++++++++++++ }
{ +++ TColourSchemes +++ }
{ ++++++++++++++++++++++ }

{ --- Public methods --- }

constructor TColourSchemes.Create;
  {Class constructor - creates the scheme list and reads in from ini file}
var
  NumSchemes : integer;     {number of schemes in ini file}
  I : integer;              {loop control}
  C : TGridColours;         {colour scheme object to be added to scheme list}
begin
  inherited Create;
  {Create owned list}
  FList := TList.Create;
  {Create schemes list using ini file}
  {record number of schemes in ini file}
  NumSchemes := ConfigFile.NumSchemes;
  if NumSchemes > 0 then
  begin
    {there are some schemes - read them and build list of schemes}
    for I := 0 to NumSchemes - 1 do
    begin
      {create object to hold scheme}
      C := TGridColours.Create;
      {find scheme name}
      C.Name := ConfigFile.SchemeNames[I];
      {read in scheme details from ini file}
      C.ReadFromIni;
      {add scheme to list}
      FList.Add(C);
      {record current scheme}
      CurrentIndex := ConfigFile.CurrentSchemeId;
      if (CurrentIndex < 0) or (CurrentIndex >= FList.Count) then
        CurrentIndex := -1;
    end
  end
  else
  begin
    {there are no schemes - create Default scheme}
    {create object to hold default scheme}
    C := TGridColours.Create;
    {add default scheme to list and ini file (Default scheme is always present}
    Add(C);
    {make the default scheme current}
    CurrentIndex := 0;
  end;
  {Create <Unknown> colour scheme and read it in from ini file}
  FUnknown := TGridColours.Create;
  FUnknown.Name := '';
  FUnknown.ReadFromIni;
end;

destructor TColourSchemes.Destroy;
  {Class destructor}
var
  I : integer;  {loop control}
begin
  {Record current scheme in the ini file}
  ConfigFile.CurrentSchemeId := CurrentIndex;
  {Free the unknown scheme}
  FUnknown.Free;
  {Free all scheme objects in list}
  for I := 0 to FList.Count - 1 do
    TGridColours(FList[I]).Free;
  {Free owned list object}
  FList.Free;
  inherited Destroy;
end;

procedure TColourSchemes.Delete(const Index : integer);
  {Deletes the scheme at the given index from the list}
var
  I : integer;            {loop control}
  DeletedName : string;   {name of scheme being deleted}
begin
  {Record name of scheme being deleted for later use}
  DeletedName := TGridColours(FList[Index]).Name;
  {Remove scheme from list}
  TGridColours(FList[Index]).Free;
  FList.Delete(Index);
  {Update ini file}
  {record reduced number of schemes}
  ConfigFile.NumSchemes := FList.Count;
  {renumber all schemes following deleted scheme in ini file}
  for I := Index to FList.Count - 1 do
    ConfigFile.SchemeNames[I] := TGridColours(FList[I]).Name;
  {delete reference to last scheme in ini file}
  ConfigFile.SchemeNames[FList.Count] := '';
  {erase section describing deleted scheme in ini file}
  ConfigFile.EraseScheme(DeletedName);
  {update current index}
  if FCurrentIndex > Index then
    {current scheme had higher index than one deleted - reduce current}
    FCurrentIndex := FCurrentIndex - 1
  else if FCurrentIndex = Index then
    {current scheme was deleted - renumber current scheme if there was no
    following scheme (if there was then it will already have been renumbered to
    be current)}
    if Index = FList.Count then
      {there is no following item - use one before (this gives -1 as required if
      list is now empty}
      FCurrentIndex := FCurrentIndex - 1;
  {Trigger current index changed event}
  CurrentIndexChanged;
end;

function TColourSchemes.Add(AScheme : TGridColours) : integer;
  {Adds the given colour scheme to the end of the list of schemes}
var
  C : TGridColours;   {instance of colour scheme to be added to list}
begin
  {Create colour scheme object for the required scheme to be added}
  C := TGridColours.Create;
  C.Assign(AScheme);
  {Add to list}
  Result := Flist.Add(C);
  {Update ini file}
  {record increased number of schemes}
  ConfigFile.NumSchemes := FList.Count;
  {add reference to new scheme}
  ConfigFile.SchemeNames[Result] := C.Name;
  {add section describing new scheme}
  C.WriteToIni;
end;

function TColourSchemes.IndexOfName(AName : string) : integer;
  {The index of the colour scheme with the given name in the list - returns -1
  if no such scheme found}
var
  I : integer;    {loop control}
begin
  {Set "not found" result}
  Result := -1;
  {Scan scheme list looking for a scheme with same name - case independent}
  for I := 0 to FList.Count - 1 do
    if CompareText(TGridColours(FList[I]).Name, AName) = 0 then
    begin
      {Found one - record its index as result and escape from loop}
      Result := I;
      Break;
    end;
end;

{ --- Private property access methods --- }

function TColourSchemes.GetItem(I : integer) : TGridColours;
  {Read access method for Items property}
begin
  {Return required scheme if I >= 0 else return the unknown scheme}
  if I <> -1 then
    Result := TGridColours(FList[I])
  else
    Result := FUnknown;
end;

procedure TColourSchemes.SetItem(I : integer; AScheme : TGridColours);
  {Write access method for Items property}
begin
  {Check if the scheme is unknown}
  if I <> -1 then
  begin
    {This is a known scheme - assign it to list and record in ini file}
    TGridColours(FList[I]).Assign(AScheme);
    TGridColours(FList[I]).WriteToIni;
  end
  else
  begin
    {This is an unknown scheme - assign to FUnknown and record in ini file}
    FUnknown.Assign(AScheme);
    FUnknown.WriteToIni;
  end;
end;

function TColourSchemes.GetCount : integer;
  {Read access method for Count property}
begin
  {Return number of items in list}
  Result := FList.Count;
end;

procedure TColourSchemes.SetCurrentIndex(AnIndex : integer);
  {Write access method for CurrentIndex property}
begin
  {Record new index and trigger OnCurrentIndexChange event}
  FCurrentIndex := AnIndex;
  CurrentIndexChanged;
end;

function TColourSchemes.GetCurrentScheme : TGridColours;
  {Read access method for CurrentScheme property}
begin
  {Pick the scheme from the list}
  Result := Items[CurrentIndex];
end;

procedure TColourSchemes.SetCurrentScheme(AScheme : TGridColours);
  {Write access method for the CurrentScheme property}
begin
  Items[CurrentIndex] := AScheme;
end;

{ --- Other private methods --- }

procedure TColourSchemes.CurrentIndexChanged;
  {Trigger the OnCurrentIndexChange event}
begin
  if Assigned(FOnCurrentIndexChange) then FOnCurrentIndexChange(Self);
end;


{ ++++++++++++++++++++ }
{ +++ TGridColours +++ }
{ ++++++++++++++++++++ }

{ --- Public methods --- }

constructor TGridColours.Create;
  {Class constructor - creates a default colour scheme}
begin
  inherited Create;
  {Create a scheme with the default name and colours as defined in Shared unit}
  FName := 'Default';
  FColours[geBackground] := CBackgroundColour;
  FColours[geGridLine] := CGridLineColour;
  FColours[geLifeForm] := CLifeFormColour;
  FColours[geHighlight] := CHighlightColour;
end;

procedure TGridColours.Assign(Source : TGridColours);
  {Method which assigns one colour scheme to another}
begin
  {Copy all fields in source object to this object}
  FName := Source.FName;
  FColours := Source.FColours;
  {Trigger OnChange event}
  Changed;
end;

procedure TGridColours.ReadFromIni;
  {Reads the colour scheme from the program's ini file}
var
  I : TGridElement;   {loop control - scans through all elements}
  N : string;         {name of section to read from}
begin
  {Record name of section - if FName is '' then the section is <Unknown>}
  if FName <> '' then N := FName else N := '<Unknown>';
  {Read the colours from the ini file using the ConfigFile global class
  instance}
  for I := Low(TGridElement) to High(TGridElement) do
    FColours[I] := ConfigFile.SchemeColours[N, I];
end;

procedure TGridColours.WriteToIni;
  {Writes the colour scheme to the program's ini file}
var
  I : TGridElement;   {loop control - scans through all elements}
  N : string;         {name of section to read from}
begin
  {Record name of section - if FName is '' then the section is <Unknown>}
  if FName <> '' then N := FName else N := '<Unknown>';
  {Write the colours from the ini file using the ConfigFile global class
  instance}
  for I := Low(TGridElement) to High(TGridElement) do
    ConfigFile.SchemeColours[N, I] := FColours[I];
end;

{ --- Private property access methods --- }

procedure TGridColours.SetName(AName : string);
  {Write access method for Name property}
begin
  FName := AName;
  Changed;
end;

function TGridColours.GetColour(Element : TGridElement) : TColor;
  {Read access method for Colours property}
begin
  Result := FColours[Element];
end;

procedure TGridColours.SetColour(Element : TGridElement; AColor : TColor);
  {Write access method for Colours property}
begin
  FColours[Element] := AColor;
  Changed;
end;

{ --- Other private methods --- }

procedure TGridColours.Changed;
  {Triggers OnChange event}
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

initialization

// Create TColourSchemes singleton at startup
ColourSchemeList := TColourSchemes.Create;

finalization

// Free singleton
ColourSchemeList.Free;

end.
