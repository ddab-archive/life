{
  Distributed under the MIT license.
  See the accompanying LICENSE file or go to
  http://delphidabbler.mit-license.org/1992-2015/
}

unit FmMainForm;


interface


uses
  // Delphi
  Classes, ActnList, ImgList, Controls, ComCtrls, ToolWin, Menus, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Forms, Windows, Graphics,
  // PJ library
  PJAbout, PJVersionInfo,
  // Project
  GameEngine, ColourSchemes;


type
  {
  TMainForm:
    Class implementing Game of Life's main window and game drawing code.
  }
  TMainForm = class(TForm)
    SquareInfoGpBox: TGroupBox;
    GenInfoGpBox: TGroupBox;
    GridPnl: TPanel;
    SquareLbl: TLabel;
    BugLbl: TLabel;
    NeighbourLbl: TLabel;
    GenLbl: TLabel;
    SquareDtl: TLabel;
    BugDtl: TLabel;
    NeighbourDtl: TLabel;
    BugCountLbl: TLabel;
    BugCountDtl: TLabel;
    GenDtl: TLabel;
    GridImg: TImage;
    GenBtn: TBitBtn;
    ReplayBtn: TBitBtn;
    SnapshotBtn: TBitBtn;
    CreateBtn: TBitBtn;
    KillBtn: TBitBtn;
    OpenDlg: TOpenDialog;
    SaveDlg: TSaveDialog;
    ClearBtn: TBitBtn;
    AboutBoxDlg: TPJAboutBoxDlg;
    StatusPnl: TPanel;
    SchemePnl: TPanel;
    AgeLbl: TLabel;
    AgeDtl: TLabel;
    RulePnl: TPanel;
    SchemeLbl: TLabel;
    RuleLbl: TLabel;
    VerInfo: TPJVersionInfo;
    ToolBar1: TToolBar;
    TBOpen: TToolButton;
    Images: TImageList;
    TBSave: TToolButton;
    TBRules: TToolButton;
    TBColourSchemes: TToolButton;
    TBSeparator1: TToolButton;
    TBSeparator2: TToolButton;
    TBAbout: TToolButton;
    TBSeparator3: TToolButton;
    TBexit: TToolButton;
    Actions: TActionList;
    SaveAction: TAction;
    OpenAction: TAction;
    RulesAction: TAction;
    ColourSchemesAction: TAction;
    AboutAction: TAction;
    ExitAction: TAction;
    HelpAction: TAction;
    TBHelp: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ExitClick(Sender: TObject);
    procedure MHAboutClick(Sender: TObject);
    procedure GenBtnClick(Sender: TObject);
    procedure ReplayBtnClick(Sender: TObject);
    procedure SnapshotBtnClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure CreateBtnClick(Sender: TObject);
    procedure KillBtnClick(Sender: TObject);
    procedure GridImgDblClick(Sender: TObject);
    procedure GridImgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GridImgDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure GridImgEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure TBOpenClick(Sender: TObject);
    procedure SaveActionExecute(Sender: TObject);
    procedure RulesActionExecute(Sender: TObject);
    procedure ColourSchemesActionExecute(Sender: TObject);
    procedure MORulesClick(Sender: TObject);
    procedure AboutActionExecute(Sender: TObject);
    procedure OpenActionExecute(Sender: TObject);
    procedure ExitActionExecute(Sender: TObject);
    procedure RuleLblDblClick(Sender: TObject);
    procedure SchemeLblDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HelpActionExecute(Sender: TObject);
  private
    fSelectedSquare: TPoint;
      {Co-ordinates of currently selected square}
    fEndSelectionSquare: TPoint;
      {Co-ordinates of square at end of selection}
    fGridColours: TGridColours;
      {Instance of class storing grid colours}
    fGame: TGameOfLife;
      {Instance of game of life class used to run game}
    fGameStart: TGameOfLife;
      {Instance of game of life class to record game's initial configuration}
    fStartRecorded: Boolean;
      {Flag true if game's initial configuration has been recorded, false if
      not}
    fSnapShot: TGameOfLife;
      {Instance of game of life class to record game's position when user takes
      snapshot}
    fSnapShotTaken: Boolean;
      {Flag true if a snapshot has been taken, false otherwise}
    fSnapShot0Glyph: TBitmap;
      {Glyph used on Snapshot button when no snapshot has been taken}
    fSnapShot1Glyph: TBitmap;
      {Glyph used on Snapshot button after a snapshot has been taken}
    procedure SquareInfo;
      {Updates Square Info box statistics for currently selected square}
    procedure GenerationInfo;
      {Updates Generation Info box statistics with current info}
    procedure UpdateStatusBar;
      {Updates information on status bar}
    procedure GridDisplayLifeForm(Col, Row: Integer);
      {Display life form at given cell co-ordinates}
    procedure GridEraseLifeForm(Col, Row: Integer);
      {Erase life form at given cell co-ordinates}
    procedure GridDisplayHighlight;
      {Display highlight around currently selected block}
    procedure GridEraseHighlight;
      {Erase highlight around currently selected block}
    procedure DrawGrid;
      {Draw / redraw the whole grid}
    procedure DrawGridRegion(Reg: TRect);
      {Draw / redraw the given area of the grid. Reg is a normalised rectangle
      in cell coordinates}
    procedure DrawLifeForm(Col, Row: Integer);
      {Draws life form at given position in cell coordinates with current pen
      and brush}
    function CellAtPos(X, Y: Integer): TPoint;
      {Returns address cell at given pixel point in grid in a TPoint structure}
    function CellsToPixels(CellRect: TRect): TRect;
      {Converts the given rectangle of cells in cell co-ordinates into a
      rectangle of pixels in the grids co-ordinates. No normalisation is carried
      out}
    function Selection: TRect;
      {Returns current selection normalised in cell co-ordinates}
    function IsSingleSelection: Boolean;
      {Returns true if only one square is selected, false if more than one
      selected}
    procedure ChangedRule(Sender: TObject);
      {Event handler for rules dialogue box "apply rule" button click event}
    procedure UpdateGameRule(Sender: TObject);
      {Event handler for game object's rule change event}
    procedure CheckOpenedGameRule;
      {Checks if rule for game just opened is recorded in user's ini file and
      gives opportunity to record it if it's not there}
  public
    function RuleInUse(ARuleName: string): Boolean;
      {Returns whether the given rule name is currently being used by game,
      start- game or snapshot game objects}
  end;

var
  MainForm: TMainForm;


implementation


{$R *.DFM}

uses
  // Delphi
  SysUtils, ShellAPI,
  // Project
  Config, Shared, Rules, FmColourSchemeDlg, FmSaveGameStateDlg, FmReplayDlg,
  FmEditRuleDlg, FmApplyRuleDlg;

const
  // Sizes
  cGridSquareEdgeLen = 16;      {Length of grid square edge}
  cLifeFormTLOffset = 3;        {Offset of "life-form" from top & left of
                                square}
  cLifeFormBROffset = cGridSquareEdgeLen - 5;
                                {Offset of "life-form" from bottom & right of
                                square}
  cGridSquareCount = 21;        {Number of rows/columns in grid square}
  cGridCentreCol = 10;          {Column number of centre square}
  cGridCentreRow = 10;          {Row number of centre square}

{ --- Private service routine --- }

function NormaliseRect(TopX, TopY, BottomX, BottomY: Integer): TRect; forward;
  {Given cordinates of top-left and bottom-right corners of rectangle this
  routines converts them into a normalised rectangle with top-left corner
  "further up and to left of" bottom-right corner}

{ --- Public event methods --- }

{ +++ Form methods +++}

procedure TMainForm.FormCreate(Sender: TObject);
  {Form creation event}
begin
  {Set form caption to be same as application title}
  Caption := Application.Title;
  {Set selection in Grid to centre of grid}
  fSelectedSquare := Point(cGridCentreCol, cGridCentreRow);
  fEndSelectionSquare := fSelectedSquare;
  {Create instances of the TGameOfLife classes to "run" and record game}
  {create main game object, give currently selected rule per ini file and then
  (order is important) assign OnChange event handler}
  fGame := TGameOfLife.Create;
  fGame.Rule := RuleList.CurrentRule;
  fGame.OnRuleChange := UpdateGameRule;
  {create objects to reocrd start of game and snapshot}
  fGameStart := TGameOfLife.Create;
  fSnapShot := TGameOfLife.Create;
  {Create and load bitmaps instances to hold bitmap resources}
  fSnapShot0Glyph := TBitmap.Create;
  fSnapShot1Glyph := TBitmap.Create;
  fSnapShot0Glyph.Handle := LoadBitmap(HInstance, 'SNAPSHOT0');
  fSnapShot1Glyph.Handle := LoadBitmap(HInstance, 'SNAPSHOT1');
  {Record that no snapshot has been taken}
  fSnapShotTaken := False;
  SnapshotBtn.Glyph := fSnapShot0Glyph;
  {Record that start of game has not been recorded}
  fStartRecorded := False;
  {Create instance of grid colours object to store colours of grid}
  fGridColours := TGridColours.Create;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  {Form Close Query event}
begin
  {Get permission to halt program from user and only close if we get it}
  CanClose := (
    MessageDlg(
      'Are you sure you want to exit the Game of Life?'#10#10
        + 'If you want to save the current game answer No and go back and save '
        + 'the game.',
      mtConfirmation,
      [mbYes, mbNo],
      0
    ) = mrYes
  );
end;

procedure TMainForm.FormDestroy(Sender: TObject);
  {Form destruction event}
begin
  {Free resource bitmap instances}
  fSnapShot0Glyph.Free;
  fSnapShot1Glyph.Free;
  {Free instance of grid colour class}
  fGridColours.Free;
  {Free instances of TGameOfLife class}
  fGame.Free;
  fGameStart.Free;
  fSnapShot.Free;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  // Set display to current colour scheme and display grid using it
  fGridColours.Assign(ColourSchemeDlg.Colours);
  DrawGrid;
  UpdateStatusBar;
  {Register method for OnApply event of Rules dialogue box}
  EditRuleDlg.OnApply := ChangedRule;
end;

{ +++ Main Menu click event methods +++ }

{ File menu }

procedure TMainForm.OpenActionExecute(Sender: TObject);
begin
  {Call standard open dialogue box and test if use clicked OK}
  if OpenDlg.Execute then
  begin
    {Load game from file and chekc if rule is known to program}
    fGame.LoadFromFile(OpenDlg.FileName);
    CheckOpenedGameRule;
    Screen.Cursor := crHourglass;
    try
      {Store loaded game in fGameStart object}
      fGameStart.Assign(fGame);
      {Set that game not recorded so that any modifications before 1st
      generation will be recorded}
      fStartRecorded := False;
      {Clear snapshot}
      fSnapShot.Init;
      {Record that snapshot not recorded and put appropriate glyph on button}
      fSnapShotTaken := False;
      SnapshotBtn.Glyph := fSnapShot0Glyph;
      {Update stats info for new generation and current square}
      SquareInfo;
      GenerationInfo;
      {Update display}
      DrawGrid;
    finally
      Screen.Cursor := crArrow;
    end;
  end;
end;

procedure TMainForm.SaveActionExecute(Sender: TObject);
begin
  {Check whether a snapshot has been taken and enable / disable snapshot radio
  button accordingly}
  if fSnapShotTaken then
    {There has been a snap-shot - enable radio button}
    SaveGameStateDlg.SnapshotRadio.Enabled := True
  else
  begin
    {There is no snap-shot - disable radio button and select game-start radio
    button if snap-shot button is currently selected}
    if SaveGameStateDlg.SnapshotRadio.Checked then
      SaveGameStateDlg.StartRadio.Checked := True;
    SaveGameStateDlg.SnapshotRadio.Enabled := False;
  end;
  {Check whether & what user wants to save & to where}
  {call dialogue boxes}
  if (SaveGameStateDlg.ShowModal = mrOK) and SaveDlg.Execute then
  begin
    {Now decide what to save depending on radio buttons}
    if SaveGameStateDlg.StartRadio.Checked then
    begin
      {Start of game selected - save game start}
      {Check if zero generation - game start class not yet recorded so save
      current game}
      if fGame.NumGenerations = 0 then
        fGame.SaveToFile(SaveDlg.FileName)
      else
        fGameStart.SaveToFile(SaveDlg.FileName);
    end
    else if SaveGameStateDlg.SnapshotRadio.Checked then
      {Snapshot selected (there must be one) - save snapshot}
      fSnapShot.SaveToFile(SaveDlg.FileName)
    else
      {Current game position must be selected - save that}
      fGame.SaveToFile(SaveDlg.FileName);
  end;
end;

procedure TMainForm.SchemeLblDblClick(Sender: TObject);
begin
  ColourSchemesAction.Execute;
end;

procedure TMainForm.ExitActionExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.ExitClick(Sender: TObject);
  {File | Exit menu click - causes application to close}
begin
end;

{ Options menu }

procedure TMainForm.RulesActionExecute(Sender: TObject);
begin
  EditRuleDlg.ShowModal;
end;

procedure TMainForm.MORulesClick(Sender: TObject);
begin

end;

{ Help menu }

procedure TMainForm.MHAboutClick(Sender: TObject);
  {Help | About menu click - display About box}
begin
end;

{ +++ Game Button click events +++}

procedure TMainForm.GenBtnClick(Sender: TObject);
  {Next generation button click - causes next generation of life-forms to be
  calculated and displayed}
begin
  {Set cursor to hourglass}
  Screen.Cursor := crHourglass;
  try
    {Check if first time generation button clicked in this game - if so, record
    game start position for replay}
    if not fStartRecorded then
    begin
      fGameStart.Assign(fGame);
      fStartRecorded := True;
    end;
    {Calculate next generation from current position}
    fGame.Generate;
    {Update display using recalculated information}
    DrawGrid;
    {Update stats info for new generation and current square}
    SquareInfo;
    GenerationInfo;
  finally
    {Set cursor back to arrow}
    Screen.Cursor := crArrow;
  end;
end;

procedure TMainForm.ReplayBtnClick(Sender: TObject);
  {Replay button click - causes game to be replayed from a given point}
var
  ReplayFromSnapShot: Boolean;
                   {Flag true if game to be replayed from a snapshot, false if
                   to be replayed from start}
begin
  {Decide whether to Replay game from start or from snapshot}
  if fSnapShotTaken then
  begin
    {A snapshot has been taken - ask user where to Replay from}
    if ReplayDlg.ShowModal = mrCancel then
      {User cancelled - abort process}
      Exit;
    {User OK'd - record selection}
    ReplayFromSnapShot := ReplayDlg.SnapshotRadio.Checked;
  end
  else
    {No snapshot has been taken - Replay from start}
    ReplayFromSnapShot := False;
  {Replay game from beginning or from snapshot as appropriate}
  Screen.Cursor := crHourglass;
  try
    if ReplayFromSnapShot then
      {Replaying from snapshot - make game state equivalent to snapshot}
      fGame.Assign(fSnapShot)
    else
      {Replaying from game start - restore game to initial state}
      fGame.Assign(fGameStart);
    {Update stats info for new generation and current square}
    SquareInfo;
    GenerationInfo;
    {Update display using re-start information}
    DrawGrid;
  finally
    Screen.Cursor := crArrow;
  end;
end;

procedure TMainForm.SnapshotBtnClick(Sender: TObject);
  {Snapshot button click - copies current state of game to storage}
begin
  {Check if snapshot already taken and get permission to over-write if so}
  if not fSnapShotTaken or
    (MessageDlg(
      'Overwrite previous snapshot?',
      mtConfirmation,
      [mbYes, mbNo],
      0
    ) = mrYes) then
  begin
    {It's OK to take snapshot - take it by copying game position}
    fSnapShot.Assign(fGame);
    {Record that snapshot taken}
    fSnapShotTaken := True;
    SnapshotBtn.Glyph := fSnapShot1Glyph;
  end;
end;

procedure TMainForm.ClearBtnClick(Sender: TObject);
  {Clear button click - clears game to empty grid}
begin
  {Get user's permission to do this}
  if MessageDlg(
    'Are you sure you want to clear the game and snapshots?',
    mtConfirmation,
    [mbYes, mbNo],
    0
  ) = mrYes then
  begin
    {Reset game to start & reset start game to new one}
    fGame.Init;
    fGameStart.Assign(fGame);
    fStartRecorded := False;
    {Clear snapshot}
    fSnapShot.Init;
    fSnapShotTaken := False;
    SnapshotBtn.Glyph := fSnapShot0Glyph;
    {Update display - doesn't take long - no life-forms to display => no
    hourglass}
    DrawGrid;
    {Update stats info for new generation and current square}
    SquareInfo;
    GenerationInfo;
  end;
end;

procedure TMainForm.ColourSchemesActionExecute(Sender: TObject);
begin
  {Display set-up dialog box}
  if ColourSchemeDlg.ShowModal = mrOK then
  begin
    {User accepted set-up - do any none-colour related processing}
    UpdateStatusBar;
    {Now see if colours have *actually* changed - it's worth avoiding a grid
    redraw if nothing has changed}
    if ColourSchemeDlg.ColoursChanged then
    begin
      {Colours have changed - a possibly lengthy redraw is required}
      {use hourglass cursor}
      Screen.Cursor := crHourglass;
      try
        {copy details to main storage}
        fGridColours.Assign(ColourSchemeDlg.Colours);
        {redisplay grid}
        DrawGrid;
      finally
        Screen.Cursor := crArrow;
      end;
    end;
  end;
end;

procedure TMainForm.CreateBtnClick(Sender: TObject);
  {Create button click. Populates all of selected area with life- forms. This
  can take some time so hourglass cursor is used. It is quicker to deliberately
  display each life-form required than to re-display region => display technique
  used here is different to that in the opposite KillBtnClick method}
var
  R: TRect;            {Normalised rectangle of cells in which to create life}
  Col, Row: Integer;   {Loop control for iterating over selected rectangle}
begin
  Screen.Cursor := crHourglass; {cursor reset to arrow when repaint is complete}
  try
    {Normalise selected region}
    R := Selection;
    {Create life forms in all the region}
    for Col := R.Left to R.Right do
      for Row := R.Top to R.Bottom do
        if not fGame.LifeFormExists(Col, Row) then
        begin
          {There is no life form here - add one}
          {update grid}
          fGame.AddLifeForm(Col, Row);
          {update display}
          GridDisplayLifeForm(Col, Row);
        end;
  finally
    Screen.Cursor := crArrow;
  end;
end;

procedure TMainForm.KillBtnClick(Sender: TObject);
  {Kill button click - kills all life forms in selected region. Redisplay when
  erasing a block of life-forms is quicker than drawing new ones, so this event
  doesn't use the hourglass cursor. It also uses a different display technique
  to its opposite CreateBtnClick method}
var
  R: TRect;          {Normalised rectangle of cells in which to kill lifeforms}
  Col, Row: Integer; {Loop control for iterating over selected rectangle}
begin
  {Normalise selected region}
  R := Selection;
  {Kill all life forms in the region}
  for Col := R.Left to R.Right do
    for Row := R.Top to R.Bottom do
      if fGame.LifeFormExists(Col, Row) then
        {There is a life form here - remove it from game}
        fGame.KillLifeForm(Col, Row);
  {Redisplay killed region}
  DrawGridRegion(R);
end;

{ +++ Grid event methods +++ }

procedure TMainForm.GridImgDblClick(Sender: TObject);
  {Double click event over a square of the grid toggles bugs on and off}
var
  Row, Col: LongInt;
begin
  {Find row and column of currently selected square}
  Col := fSelectedSquare.X;
  Row := fSelectedSquare.Y;
  {Now check if outer or inner cols and rows selected - do nothing when outer
  ones selected}
  if not ((Col = 0) or (Col = cGridSquareCount - 1)
    or (Row = 0) or (Row = cGridSquareCount - 1)) then
  begin
    {An inner cell selected - toggle contents of grid}
    if fGame.LifeFormExists(Col, Row) then
    begin
      {Cell contained a life form - remove it}
      {Update display}
      GridEraseLifeForm(Col, Row);
      {Update grid}
      fGame.KillLifeForm(Col, Row);
    end
    else
    begin
      {Cell was empty - add a life form}
      {Update display}
      GridDisplayLifeForm(Col, Row);
      {Update grid}
      fGame.AddLifeForm(Col, Row);
    end;
  end;
  GenerationInfo;
end;

procedure TMainForm.GridImgMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  {Mouse left button press down event over a square on the grid causes stats to
  be displayed about that square. Dragging the mouse causes highlight to be
  extended}
begin
  {Do nothing if not left mouse button}
  if Button <> mbLeft then Exit;
  {Remove highlight from currently selected block}
  GridEraseHighlight;
  {Make clicked square the current square}
  fSelectedSquare := CellAtPos(X, Y);
  fEndSelectionSquare := fSelectedSquare;
  {Show highlight on newly selected square-block}
  GridDisplayHighlight;
  {Begin dragging}
  GridImg.BeginDrag(True);
end;

procedure TMainForm.HelpActionExecute(Sender: TObject);
  {Displays program manual in default browser when Help tool button is clicked}
begin
  if ShellExecute(
    0,
    'open',
    PChar(ExtractFilePath(ParamStr(0)) + 'Manual.html'),
    nil,
    nil,
    SW_SHOW
  ) <= 32 then
    MessageDlg(
      'Can''t display the program manual (Manual.html). '#10#10
        + 'It should be present in the same directory as Life.exe',
      mtError,
      [mbOK],
      0
    );
end;

procedure TMainForm.GridImgDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
  {Drag over event handler - accepts dragging if from self and updates selection
  highlight if necessary}
var
  MouseAtCell: TPoint;   {the cell which mouse is over now}
begin
  {Accept a dragging operation only if it started on the grid}
  Accept := Source = Sender; {this is safe as there is only one image on form}
  {Update drag end position and redraw extended highlight if it's changed}
  {find cell which mouse is over}
  MouseAtCell := CellAtPos(X, Y);
  {check if drag-end cell has changed}
  if ((MouseAtCell.X <> fEndSelectionSquare.X)
      or (MouseAtCell.Y <> fEndSelectionSquare.Y)) then
  begin
    {un-draw old highlight block}
    GridEraseHighlight;
    {record new drag-end square}
    fEndSelectionSquare := MouseAtCell;
    {draw new highlight block}
    GridDisplayHighlight;
  end;
end;

procedure TMainForm.GridImgEndDrag(Sender, Target: TObject; X, Y: Integer);
  {End drag event handler - sets captions on "Kill" and "Create" buttons and
  updates cell info if appropriate}
begin
  {Check if dragged area enclosed more than one square, setting "Kill" and
  "Create" button captions}
  if not IsSingleSelection then
  begin
    {Selection contains more than one square}
    KillBtn.Caption := '&Kill all';
    CreateBtn.Caption := '&Create all';
  end
  else
  begin
    {Selection contain just one square}
    KillBtn.Caption := '&Kill cell';
    CreateBtn.Caption := '&Create cell';
  end;
  {Update square stats}
  SquareInfo;
end;

{ --- Other public methods --- }

function TMainForm.RuleInUse(ARuleName: string): Boolean;
  {Returns whether the given rule name is currently being used by game, start-
  game or snapshot game objects}
begin
  Result := (CompareText(ARuleName, fGame.Rule.Name) = 0)
    or (CompareText(ARuleName, fGameStart.Rule.Name) = 0)
    or ((CompareText(ARuleName, fSnapShot.Rule.Name) = 0) and fSnapShotTaken);
end;

procedure TMainForm.RuleLblDblClick(Sender: TObject);
begin
  RulesAction.Execute;
end;

{ --- Private methods --- }

{ +++ Information update methods +++ }

procedure TMainForm.SquareInfo;
  {Updates Square Info box statistics for currently selected square}
var
  Col, Row: Integer;   {The row and column of currently selected cell}
begin
  {Find if one or more than one square selected}
  if IsSingleselection then
  begin
    {Record row and column co-ordinates of currently selected cell}
    Col := fSelectedSquare.X;
    Row := fSelectedSquare.Y;
    {Display co-ordinates}
    SquareDtl.Caption := '('+IntToStr(Col)+','+IntToStr(Row)+')';
    {Display whether the cell contains a life form and its age if it does}
    if fGame.LifeFormExists(Col, Row) then
    begin
      BugDtl.Caption := 'Yes';
      AgeDtl.Caption := IntToStr(fGame.LifeFormAge(Col, Row));
    end
    else
    begin
      BugDtl.Caption := 'No';
      AgeDtl.Caption := 'N/a';
    end;
    {Display number of neighbours}
    NeighbourDtl.Caption := IntToStr(fGame.NumNeighbours(Col, Row));
  end
  else
  begin
    {Show no information}
    SquareDtl.Caption := 'N/a';
    BugDtl.Caption := 'N/a';
    AgeDtl.Caption := 'N/a';
    NeighbourDtl.Caption := 'N/a';
  end;
end;

procedure TMainForm.TBOpenClick(Sender: TObject);
begin
  {Call standard open dialogue box and test if use clicked OK}
  if OpenDlg.Execute then
  begin
    {Load game from file and chekc if rule is known to program}
    fGame.LoadFromFile(OpenDlg.FileName);
    CheckOpenedGameRule;
    Screen.Cursor := crHourglass;
    try
      {Store loaded game in fGameStart object}
      fGameStart.Assign(fGame);
      {Set that game not recorded so that any modifications before 1st
      generation will be recorded}
      fStartRecorded := False;
      {Clear snapshot}
      fSnapShot.Init;
      {Record that snapshot not recorded and put appropriate glyph on button}
      fSnapShotTaken := False;
      SnapshotBtn.Glyph := fSnapShot0Glyph;
      {Update stats info for new generation and current square}
      SquareInfo;
      GenerationInfo;
      {Update display}
      DrawGrid;
    finally
      Screen.Cursor := crArrow;
    end;
  end;
end;

procedure TMainForm.GenerationInfo;
  {Updates Generation Info box statistics with current info}
begin
  {Display total number of lifeforms in game}
  BugCountDtl.Caption := IntToStr(fGame.NumLifeForms);
  {Display current generation number}
  GenDtl.Caption := IntToStr(fGame.NumGenerations);
end;

procedure TMainForm.UpdateStatusBar;
  {Updates information on status bar}
var
  Str: string;   {temporary string for building colour scheme name}
begin
  {Scheme panel caption update}
  Str := ColourSchemeDlg.Colours.Name;
  if Str = '' then Str := '<un-named>';
  SchemeLbl.Caption := Format('Colour scheme: %s', [Str]);
  {Rules panel caption}
  RuleLbl.Caption := Format('Rule: %s', [fGame.Rule.Name]);
end;

{ +++ Grid display methods +++ }

procedure TMainForm.GridDisplayLifeForm(Col, Row: Integer);
  {Display life form at given cell co-ordinates}
begin
  with GridImg.Canvas do
  begin
    {Select appropriate pen and brush colours}
    Brush.Color := fGridColours[geLifeForm];
    Pen.Color := fGridColours[geLifeForm];
  end;
  DrawLifeForm(Col, Row);
end;

procedure TMainForm.GridEraseLifeForm(Col, Row: Integer);
  {Erase life form at given cell co-ordinates}
begin
  with GridImg.Canvas do
  begin
    {Set brush and pen to required colours}
    Brush.Color := fGridColours[geBackground];
    Pen.Color := fGridColours[geBackground];
  end;
  DrawLifeForm(Col, Row);
end;

procedure TMainForm.GridDisplayHighlight;
  {Display highlight around currently selected block}
var
  RP: TRect;   {Normalised highlight rectangle in pixel co-ordinates}
begin
  {Get normalised rectangle of cells to select in pixel co-ordinates}
  RP := CellsToPixels(Selection);
  with GridImg.Canvas do
  begin
    {Select appropriate pen & brush style & pen colour}
    Brush.Style := bsClear;
    Pen.Style := psDot;
    Pen.Color := fGridColours[geHighlight];
    {Draw highlight}
    Rectangle(RP.Left, RP.Top, RP.Right, RP.Bottom);
    {Revert to solid pen and brush}
    Pen.Style := psSolid;
    Brush.Style := bsSolid;
  end;
end;

procedure TMainForm.GridEraseHighlight;
  {Erase highlight around currently selected block}
var
  RP: TRect;   {Normalised highlight rectangle in pixel co-ordinates}
begin
  {Get normalised rectangle of cells to de-select in pixel co-ordinates}
  RP := CellsToPixels(Selection);
  with GridImg.Canvas do
  begin
    {Select appropriate brush style and pen colour}
    Brush.Style := bsClear;
    Pen.Color := fGridColours[geGridLine];
    {Obliterate highlight}
    Rectangle(RP.Left, RP.Top, RP.Right, RP.Bottom);
    {Revert to solid brush}
    Brush.Style := bsSolid;
  end;
end;

procedure TMainForm.DrawGrid;
  {Draw / redraw the whole grid}
begin
  DrawGridRegion(Rect(0, 0, cGridSquareCount - 1, cGridSquareCount - 1));
end;

procedure TMainForm.DrawGridRegion(Reg: TRect);
  {Draw / redraw the given area of the grid. Reg is a normalised rectangle in
  cell coordinates}
var
  PixReg: TRect;       {The redraw area in pixels}
  Col, Row: Integer;   {Loop control - iterate over rows and columns of grid}
  PixCol, PixRow: Integer;
begin
  {Convert Reg into pixels, stored in PixReg}
  PixReg := CellsToPixels(Reg);
  with GridImg.Canvas do
  begin
    {Fill region with background colour}
    Brush.Color := fGridColours[geBackground];
    FillRect(PixReg);
    {Draw grid}
    Pen.Color := fGridColours[geGridLine];
    {draw vertical lines}
    PixCol := PixReg.Left;
    while PixCol <= PixReg.Right do
    begin
      MoveTo(PixCol, PixReg.Top);
      LineTo(PixCol, PixReg.Bottom);
      Inc(PixCol, cGridSquareEdgeLen);
    end;
    {draw horizontal lines}
    PixRow := PixReg.Top;
    while PixRow <= PixReg.Bottom do
    begin
      MoveTo(PixReg.Left, PixRow);
      LineTO(PixReg.Right, PixRow);
      Inc(PixRow, cGridSquareEdgeLen);
    end;
    {Draw life-forms}
    Brush.Color := fGridColours[geLifeForm];
    Pen.Color := fGridColours[geLifeForm];
    for Col := Reg.Left to Reg.Right do
      for Row := Reg.Top to Reg.Bottom do
        if fGame.LifeFormExists(Col, Row) then
        begin
          DrawLifeForm(Col, Row);
        end;
    {Draw highlight}
    GridDisplayHighlight;
  end;
end;

procedure TMainForm.DrawLifeForm(Col, Row: Integer);
  {Draws life form at given position in cell coordinates with current pen and
  brush}
var
  X, Y: Integer;     {Top left corner of lifeform in pixel co-ordinates}
begin
  X := cGridSquareEdgeLen * Col + cLifeFormTLOffset;
  Y := cGridSquareEdgeLen * Row + cLifeFormTLOffset;
  GridImg.Canvas.Ellipse(X, Y, X + cLifeFormBROffset, Y + cLifeFormBROffset);
end;

{ +++ Grid interogation and conversion methods +++ }

procedure TMainForm.AboutActionExecute(Sender: TObject);
begin
  AboutBoxDlg.Execute;
end;

function TMainForm.CellAtPos(X, Y: Integer): TPoint;
  {Returns address cell at given pixel point in grid in a TPoint structure}
begin
  Result.X := X div cGridSquareEdgeLen;
  if Result.X >= cGridSquareCount then Result.X := cGridSquareCount - 1;
  Result.Y := Y div cGridSquareEdgeLen;
  if Result.Y >= cGridSquareCount then Result.Y := cGridSquareCount - 1;
end;

function TMainForm.CellsToPixels(CellRect: TRect): TRect;
  {Converts the given rectangle of cells in cell co-ordinates into a rectangle
  of pixels in the grids co-ordinates. No normalisation is carried out}
begin
  {Convert to pixels}
  Result.Left := cGridSquareEdgeLen * CellRect.Left;
  Result.Top := cGridSquareEdgeLen * CellRect.Top;
  Result.Right := cGridSquareEdgeLen * CellRect.Right
      + cGridSquareEdgeLen + 1;
  Result.Bottom := cGridSquareEdgeLen * CellRect.Bottom
      + cGridSquareEdgeLen + 1;
end;

function TMainForm.Selection: TRect;
  {Returns current selection normalised in cell co-ordinates}
begin
  Result := NormaliseRect(fSelectedSquare.X, fSelectedSquare.Y,
      fEndSelectionSquare.X, fEndSelectionSquare.Y);
end;

function TMainForm.IsSingleSelection: Boolean;
  {Returns true if only one square is selected, false if more than one selected}
begin
  Result := (fSelectedSquare.X = fEndSelectionSquare.X)
      and (fSelectedSquare.Y = fEndSelectionSquare.Y);
end;

{ +++ Rule handling methods +++ }

procedure TMainForm.ChangedRule(Sender: TObject);
  {Event handler for rules dialogue box "apply rule" button click event - gets
  where new rule is to be applied from user and does application}
begin
  with ApplyRuleDlg do
  begin
    {first enable required check boxes}
    SnapshotChkBox.Enabled := fSnapShotTaken;
    {call dialogue box}
    if ShowModal = mrOK then
    begin
      {user selected OK - update snapshot and game start records as required}
      if SnapshotChkBox.Enabled and SnapshotChkBox.Checked then
        fSnapShot.Rule := RuleList.CurrentRule;
      if StartGameChkBox.Enabled and StartGameChkBox.Checked then
        fGameStart.Rule := RuleList.CurrentRule;
      {update game with new rule}
      fGame.Rule := RuleList.CurrentRule;
    end;
  end;
end;

procedure TMainForm.UpdateGameRule(Sender: TObject);
  {Event handler for game object's rule change event - updates status bar to
  show new rule name}
begin
  UpdateStatusBar;
end;

procedure TMainForm.CheckOpenedGameRule;
  {Checks if rule for game just opened is recorded in user's ini file and gives
  opportunity to record it if it's not there}
var
  RuleIndex: Integer;
  NameIndex: Integer;
  InfluenceIndex: Integer;
  NameCounter: Integer;
  NewName: string;
  OldName: string;
begin
  {Check if rule is in list of known rules}
  RuleIndex := RuleList.IndexOf(fGame.Rule);
  if RuleIndex = -1 then
  begin
    {The rule isn't in list}
    {Find if a rule with same name (but different rules) is in list}
    NameIndex := RuleList.IndexOfName(fGame.Rule.Name);
    if NameIndex = -1 then
    begin
      {There is no rule with same name in list - add it to list}
      RuleList.Add(fGame.Rule);
      RuleList.Current := RuleList.IndexOf(fGame.Rule);
      MessageDlg(
        Format(
          'The game being opened has rule "%s"'#13
            + 'There was no rule with this name in the rule list'#13#13
            + 'This game''s rule has now been added to the list',
          [fGame.Rule.Name]
        ),
        mtInformation,
        [mbOK
        ],
        0
      );
    end
    else
    begin
      {There is a rule with same name but different contents in list - try to
      find rule with same influences}
      InfluenceIndex := RuleList.IndexOfInfluences(fGame.Rule);
      if InfluenceIndex = -1 then
      begin
        {No rule with same influences in list - add a new one with a unique name
        based on rule's name}
        NameCounter := 0;
        repeat
          {try various names until one that hae not been used is found}
          Inc(NameCounter);
          NewName := Format('%s %d', [fGame.Rule.Name, NameCounter]);
        until RuleList.IndexOfName(NewName) = -1;
        OldName := fGame.Rule.Name;
        fGame.Rule.Name := NewName;
        RuleList.Add(fGame.Rule);
        RuleList.Current := RuleList.IndexOf(fGame.Rule);
        MessageDlg(
          Format(
            'The game being opened has rule named "%s".'#13
              + 'This name clashed with that of another rule in the rule list.'
              + #13
              + 'There are no other similar rules which can be used.'#13#13
              + 'This rule has been renamed "%s" and added to the rule list',
            [OldName, NewName]
          ),
          mtInformation,
          [mbOK],
          0
        );
      end
      else
      begin
        {Found a rule with same influences and different name - use this}
        MessageDlg(
          Format(
            'The game being opened has rule named "%s".'#13
              + 'This name clashed with that of another rule in the rule list.'
              + #13#13
              + 'The game''s rule is being replaced by an existing similar'
              + ' rule named "%s"',
            [fGame.Rule.Name, RuleList[InfluenceIndex].Name]
          ),
          mtInformation,
          [mbOK],
          0
        );
        fGame.Rule := RuleList[InfluenceIndex];
        RuleList.Current := InfluenceIndex;
      end;
    end;
  end
  else
    {The rule is known about - make it current}
    RuleList.Current := RuleIndex;
end;

{ --- Service routine --- }

function NormaliseRect(TopX, TopY, BottomX, BottomY: Integer): TRect;
  {Given cordinates of top-left and bottom-right corners of rectangle this
  routines converts them into a normalised rectangle with top-left corner
  "further up and to left of" bottom-right corner}
  procedure Swap(var X, Y: Integer);
    {Swaps values of given integers}
  var
    Temp: Integer;
  begin
    if X > Y then
    begin
      Temp := X;
      X := Y;
      Y := Temp;
    end;
  end;
begin
  {Swap top/bottom and left/right to put in correct order}
  if TopX > BottomX then Swap(TopX, BottomX);
  if TopY > BottomY then Swap(TopY, BottomY);
  Result := Rect(TopX, TopY, BottomX, BottomY);
end;

end.
