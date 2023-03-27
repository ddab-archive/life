{
  Distributed under the MIT license.
  See the accompanying LICENSE file or go to
  http://delphidabbler.mit-license.org/1992-2015/
}

unit GameEngine;


interface


uses
  // Delphi
  SysUtils, Windows, Classes,
  // Project
  Rules;


const
  cWidthMax     =   20;
  cWidthMin     =   0;
  cHeightMax    =   20;
  cHeightMin    =   0;
  cTotalSquares =   (cWidthMax - cWidthMin + 1) * (cHeightMax - cHeightMin + 1);

type

  {
  EGameOfLife:
    Class of exception raised by TGameOfLife
  }
  EGameOfLife = class(Exception);

  {
  TGameOfLife:
    The Game of Life class.
  }
  TGameOfLife = class(TObject)
  private
    fGrid: array[cWidthMin..cWidthMax, cHeightMin..cHeightMax] of
      record
        Alive     : Boolean;     {flag true if cell has a life-form}
        Age       : Word;        {age of life-form in generations}
        Neighbours: 0..8;        {number of neighbouring cells with life-forms}
      end;
      {Grid containing information about game}
    fNumLifeForms: Integer;
      {Storage for NumLifeForms property - count of life forms on grid}
    fNumGenerations: Integer;
      {Storage for NumGenerations property - number of generations to date}
    fRule: TRule;
      {Storage for Rule property - rule used for game}
    fOnRuleChange: TNotifyEvent;
      {Storage for OnRuleChange event - triggered whenever game rule changes}
    fDeathCount: Integer;
      {Number of life-forms dying in last generation}
    fBirthCount: Integer;
      {Number of life-forms being born in last generation}
    fDeaths: array[0..cTotalSquares-1] of TPoint;
      {Array containing co-ordinates of cells whose life-forms died in last
      generation. Contents only meaningful for locations 0..fDeathCount-1}
    fBirths: array[0..cTotalSquares-1] of TPoint;
      {Array containing co-ordinates of cells whose life-forms were born in last
      generation. Contents only meaningful for locations 0..fDeathCount-1}
    procedure RuleModified(Sender: TObject);
      {Event handler for rule OnChange event}
    procedure SetRule(ARule: TRule);
      {Write access method for Rule property}
    procedure UpdateNeighbours(Col, Row, Offset: Integer);
      {Updates neighbouring cells when a life form is born or dies}
    procedure RuleChanged;
      {Triggers OnRuleChange event}
  public
    constructor Create;
      {Class constructor - creates owned object and sets up a game grid
      initialised for new game}
    destructor Destroy; override;
      {Class destructor - frees owned objects}
    procedure Assign(Another: TGameOfLife);
      {Copies contents of another game of life to this one}
    procedure SaveToFile(TheFile: TFileName);
      {Writes game details to given file. Generation & birth & death details are
      not written to file - game is reset to start when game is loaded again,
      regardless game position when saved}
    procedure LoadFromFile(TheFile: TFileName);
      {Loads game details from given file. Resets game before loading as
      generation, birth and death information is not stored in file - it is as
      if loaded file was 1st generation}
    procedure Init;
      {Initialises game grid for new game}
    procedure AddLifeForm(Col, Row: Integer);
      {Adds a life-form to the given cell and updates neighbouring cells}
    procedure KillLifeForm(Col, Row: Integer);
      {Deletes a life-form from the given cell and updates neighbouring cells}
    procedure Generate;
      {Calculates population and distribution of life-forms in next generation}
    function LifeFormExists(Col, Row: Integer): Boolean;
      {Returns true if given cell contains a life-form, false otherwise}
    function NumNeighbours(Col, Row: Integer): Integer;
      {Returns number of neighbouring cells which contain life-forms}
    function LifeFormAge(Col, Row: Integer): Word;
      {Returns age of life-form if cell contains a life-form and raises
      exception if there is no life-form in cell}
    property NumLifeForms: Integer read fNumLifeForms;
      {Read only property giving number of life forms in current generation}
    property NumGenerations: Integer read fNumGenerations;
      {Read only property giving number of generations in current game}
    property Rule: TRule read fRule write SetRule;
      {Rule used for births and deaths}
    property OnRuleChange: TNotifyEvent read fOnRuleChange write fOnRuleChange;
      {Event triggered whenever rule for game changes}
  end;


implementation


// Ensure that file I/O errors are reported by exception for this unit only
{$I+}

const
  GameFileIdent = '<-Game of Life file - 16.08.98->';

resourcestring
  sGameAssignError = 'Attempt to assign to invalid game';
  sGameWriteError = 'Error writing game of life file %s';
  sGameReadError = 'Error reading game of life file %s';
  sGameBadFileError = 'File %s is not a valid game of life file';
  sGameCellAgeError = 'Can''t take age in cell %d%d - there is no life form';

{ --- Public methods --- }

constructor TGameOfLife.Create;
  {Class constructor - creates owned object and sets up a game grid initialised
  for new game}
begin
  {Call inherited constructor}
  inherited Create;
  {Create a rule & attach event handler}
  fRule := TRule.Create;
  fRule.OnChange := RuleModified;
  {Simply call Init to configure an empty game}
  Init;
end;

destructor TGameOfLife.Destroy;
  {Class destructor - frees owned objects}
begin
  fRule.Free;
  inherited Destroy;
end;

procedure TGameOfLife.Assign(Another: TGameOfLife);
  {Copies contents of another game of life to this one}
begin
  {Check if Another is a current game of life}
  if Another <> nil then
  begin
    {It is - copy all fields}
    fGrid := Another.fGrid;
    fNumLifeForms := Another.fNumLifeForms;
    fNumGenerations := Another.fNumGenerations;
    fDeathCount := Another.fDeathCount;
    fBirthCount := Another.fBirthCount;
    fDeaths := Another.fDeaths;
    fBirths := Another.fBirths;
    Rule := Another.Rule;
  end
  else
    {It's not a current game - raise exception}
    raise EGameOfLife.Create(sGameAssignError);
end;

procedure TGameOfLife.SaveToFile(TheFile: TFileName);
  {Writes game details to given file. Generation & birth & death details are not
  written to file - game is reset to start when game is loaded again, regardless
  game position when saved}
var
  T: TextFile;        // text file where game details are written
  Col, Row: Integer;  // loop over columns and rows of game grid
begin
  // Open the file for writing
  AssignFile(T, TheFile);
  try
    try
      Rewrite(T);
      // Write header to denote this as a valid GOL file
      WriteLn(T, GameFileIdent);
      // Write out rules
      WriteLn(T, fRule.Name);
      WriteLn(T, fRule.BirthInfluence.AsString);
      WriteLn(T, fRule.SurvivalInfluence.AsString);
      // Write out number of life forms
      WriteLn(T, IntToStr(fNumLifeForms));
      // Write out contents of grid
      for Col := cWidthMin to cWidthMax do
      begin
        for Row := cHeightMin to cHeightMax do
        begin
          if fGrid[Col, Row].Alive then
            WriteLn(T, '1')
          else
            WriteLn(T, '0');
          WriteLn(T, IntToStr(fGrid[Col, Row].Neighbours));
        end;
      end;
    except
      on EInOutError do
      begin
        // There was an file error - raise exception in required form
        raise EGameOfLife.CreateFmt(sGameWriteError, [TheFile]);
      end;
    end;
  finally
    // Close text file
    CloseFile(T);
  end;
end;

procedure TGameOfLife.LoadFromFile(TheFile: TFileName);
  {Loads game details from given file. Resets game before loading as generation,
  birth and death information is not stored in file - it is as if loaded file
  was 1st generation}
var
  T: TextFile;        // text file where details are read
  Col, Row: Integer;  // loop over columns and rows of game grid

  // ---------------------------------------------------------------------------
  function ReadIn: string;
    {Read line from text file and return it}
  begin
    ReadLn(T, Result);
  end;
  // ---------------------------------------------------------------------------

begin
  // Initialise game:
  // loaded game starts at 0'th generation with no recorded births & deaths
  Init;
  // Open file for reading
  AssignFile(T, TheFile);
  try
    try
      Reset(T);
      // Check header to determine if this is a valid GOL file
      if ReadIn <> GameFileIdent then
        raise EGameOfLife.CreateFmt(sGameBadFileError, [TheFile]);
      // Read in rules
      fRule.Name := ReadIn;
      fRule.BirthInfluence.AsString := ReadIn;
      fRule.SurvivalInfluence.AsString := ReadIn;
      RuleChanged;
      // Read number of life forms
      fNumLifeForms := StrToInt(ReadIn);
      // Read grid information
      for Col := cWidthMin to cWidthMax do
      begin
        for Row := cHeightMin to cHeightMax do
        begin
          if ReadIn = '1' then
          begin
            fGrid[Col, Row].Alive := True;
            fGrid[Col, Row].Age := 0;
          end
          else
            fGrid[Col, Row].Alive := False;
          fGrid[Col, Row].Neighbours := StrToInt(ReadIn);
        end;
      end;
    except
      on EInOutError do
      begin
        // There was an file error - raise exception of required type
        raise EGameOfLife.CreateFmt(sGameReadError, [TheFile]);
      end;
    end;
  finally
    // Close text file
    CloseFile(T);
  end;
end;

procedure TGameOfLife.Init;
  {Initialises game grid for new game - doesn't alter rule}
var
  Col, Row: Integer;  // loop over columns and rows of game grid
begin
  // Access each cell in grid and ensure it has no life-form & no neighbours
  for Col := cWidthMin to cWidthMax do
    for Row := cHeightMin to cHeightMax do
    begin
      fGrid[Col, Row].Alive := False;
      fGrid[Col, Row].Neighbours := 0
    end;
  // Set game counters to zero
  fNumLifeForms := 0;
  fNumGenerations := 0;
  fDeathCount := 0;
  fBirthCount := 0;
end;

procedure TGameOfLife.AddLifeForm(Col, Row: Integer);
  {Adds a life-form to the given cell and updates neighbouring cells}
begin
  {Increase neighbour count of all neighbouring cells}
  UpdateNeighbours(Col, Row, 1);
  {Mark cell as containing a life-form with 0 age}
  fGrid[Col, Row].Alive := True;
  fGrid[Col, Row].Age := 0;
  {Increae count of life-forms}
  Inc(fNumLifeForms);
end;

procedure TGameOfLife.KillLifeForm(Col, Row: Integer);
  {Deletes a life-form from the given cell and updates neighbouring cells}
begin
  {Decrease neighbour count of all neighbouring cells}
  UpdateNeighbours(Col, Row, -1);
  {Mark cell as containing no life form}
  fGrid[Col, Row].Alive := False;
  {Decrease count of life-forms}
  Dec(fNumLifeForms);
end;

procedure TGameOfLife.Generate;
  {Calculates population and distribution of life-forms in next generation}
var
  Col, Row: Integer;    // references columns and rows of grid
  I: -1..cTotalSquares; // scans Changes array (need -1 to allow for empty loop)
begin
  {Initialises Births and Deaths counters to zero}
  fBirthCount := 0;
  fDeathCount := 0;
  {Scan through all cells in grid}
  for Col := cWidthMin to cWidthMax do
    for Row := cHeightMin to cHeightMax do
      {Act depending on whether grid has life-form or not}
      if fGrid[Col, Row].Alive then
      begin
        {Cell is "alive" - check if it should die}
        if not (fGrid[Col, Row].Neighbours in fRule.SurvivalInfluence.AsSet)
            then
        begin
          {Cell will die - it has a number of neighbours in Survival influence
          set for this rule}
          {record position of cell in array at "old" death counter position}
          fDeaths[fDeathCount].X := Col;
          fDeaths[fDeathCount].Y := Row;
          {increment death counter}
          Inc(fDeathCount);
        end
        else
          {It won't die - update its age}
          Inc(fGrid[Col, Row].Age);
      end
      else
      begin
        {Cell is not "alive" - check if there will be a birth}
        if fGrid[Col, Row].Neighbours in fRule.BirthInfluence.AsSet then
        begin
          {New life-form will be created - its number of neighbours is in birth
          influence set for this rule}
          {record position of cell in array at "old" birth counter position}
          fBirths[fBirthCount].X := Col;
          fBirths[fBirthCount].Y := Row;
          {increment birth counter}
          Inc(fBirthCount);
        end
      end;
  {Now update grid with births and deaths}
  {scan deaths array and alter game grid accordingly}
  for I := 0 to fDeathCount - 1 do
    KillLifeForm(fDeaths[I].X, fDeaths[I].Y);
  {scan births array and alter game grid accordingly}
  for I := 0 to fBirthCount - 1 do
    AddLifeForm(fBirths[I].X, fBirths[I].Y);
  {Increase generation count}
  Inc(fNumGenerations);
end;

function TGameOfLife.LifeFormExists(Col, Row: Integer): Boolean;
  {Returns true if given cell contains a life-form, false otherwise}
begin
  Result := fGrid[Col, Row].Alive;
end;

function TGameOfLife.NumNeighbours(Col, Row: Integer): Integer;
  {Returns number of neighbouring cells which contain life-forms}
begin
  Result := fGrid[Col, Row].Neighbours;
end;

function TGameOfLife.LifeFormAge(Col, Row: Integer): Word;
  {Returns age of life-form if cell contains a life-form and raises exception if
  there is no life-form in cell}
begin
  if fGrid[Col, Row].Alive then
    Result := fGrid[Col, Row].Age
  else
    raise EGameOfLife.CreateFmt(sGameCellAgeError, [Col, Row]);
end;

{ --- Private event handler methods --- }

procedure TGameOfLife.RuleModified(Sender: TObject);
  {Event handler for TRule OnChange event}
begin
  {Trigger the classes own change event}
  RuleChanged;
end;

{ --- Private property access methods --- }

procedure TGameOfLife.SetRule(ARule: TRule);
  {Write access method for Rule property}
begin
  {Copy rule}
  fRule.Assign(ARule);
  {Trigger change event}
  RuleChanged;
end;

{ --- Other private methods --- }

procedure TGameOfLife.UpdateNeighbours(Col, Row, Offset: Integer);
  {Updates neighbouring cells when a life form is born or dies}

  procedure AddOffset(Col, Row, Offset: Integer);
    {Adds offset (1 or -1) to neighbour count of given cell}
  begin
    fGrid[Col, Row].Neighbours := fGrid[Col, Row].Neighbours + Offset;
  end;

begin
  {Update neighbours in row above life form - if there is such a row}
  if Row > cHeightMin then
  begin
    {update neighbour above and to left, if exists}
    if Col > cWidthMin then
      AddOffset(Col-1, Row-1, Offset);
    {update neighbour immediately above}
    AddOffset(Col, Row-1, Offset);
    {update neighbour above and to right, if exists}
    if Col < cWidthMax then
      AddOffset(Col+1, Row-1, Offset)
  end;
  {Update neighbours on same row as life form}
  {update neighbour to left, if exists}
  if Col > cWidthMin then
    AddOffset(Col-1, Row, Offset);
  {update neighbour to right, if exists}
  if Col < cWidthMax then
    AddOffset(Col+1, Row, Offset);
  {Update neighbours on row below life form if such a row exists}
  if Row < cHeightMax then
  begin
    {update neighbour below and to left, if exists}
    if Col > cWidthMin then
      AddOffset(Col-1, Row+1, Offset);
    {update neighbour immediately below}
    AddOffset(Col, Row+1, Offset);
    {update neighbour below and to right, if exists}
    if Col < cWidthMax then
      AddOffset(Col+1, Row+1, Offset);
  end
end;

procedure TGameOfLife.RuleChanged;
  {Triggers OnRuleChange event}
begin
  if Assigned(fOnRuleChange) then fOnRuleChange(Self);
end;

end.