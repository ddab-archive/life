{
  Distributed under the MIT license.
  See the accompanying LICENSE file or go to
  http://delphidabbler.mit-license.org/1992-2015/
}

unit FmColourSchemeDlg;

interface


uses
  // Delphi
  Forms, Dialogs, ExtCtrls, Controls, StdCtrls, Buttons, Classes, Windows,
  Graphics,
  // Project
  ColourSchemes, Shared;

type
  {
  TGridElementRange:
    Range of grid elements.
  }
  TGridElementRange = geBackground..geHighlight;

  {
  TGridElementColours:
    Array of colours for the range of grid elements.
  }
  TGridElementColours = array[TGridElementRange] of TColor;

  {
  TColourSchemeDlg:
    Class implements colour schemes dialgue box.
  }
  TColourSchemeDlg = class(TForm)
    SaveSchemeAsBtn: TButton;
    DeleteSchemeBtn: TButton;
    OKBtn: TButton;
    CancelBtn: TButton;
    ElementCombo: TComboBox;
    ElementLbl: TLabel;
    ColourCombo: TComboBox;
    ColourLbl: TLabel;
    SchemeCombo: TComboBox;
    SchemeLbl: TLabel;
    GridPanel: TPanel;
    GridImg: TImage;
    CustomColourDlg: TColorDialog;
    Bevel1: TBevel;
    Bevel2: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DeleteSchemeBtnClick(Sender: TObject);
    procedure SaveSchemeAsBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure ElementComboChange(Sender: TObject);
    procedure ColourComboChange(Sender: TObject);
    procedure ColourComboDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure SchemeComboClick(Sender: TObject);
    procedure GridImgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SchemeComboDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormShow(Sender: TObject);
  private
    fColours: TGridColours;
      {Storage for public Colours array property}
    fColoursChanged: Boolean;
      {Storage for public ColoursChanged property}
    fElement: TGridElement;
      {Storage for private Element property}
    fPrevColourIndex: Integer;
      {Index of last selected element in Colours list box - used to restore
      after User defined colour dialogue box is cancelled}
    fWorkColours: TGridColours;
      {Storage for working copy of element colours as edited}
    fUseBackground: Boolean;
      {True if next click on grid away from life-form and highlight will select
      background - if false then grid lines will be selected}
    procedure SetElement(TheElement: TGridElement);
      {Write access method for private Elements property}
    procedure PaintGridLines;
      {Displays lines on grid}
    procedure PaintLifeForm;
      {Displays sample life-form on grid}
    procedure PaintBackground;
      {Displays grid background}
    procedure PaintHighlight;
      {Displays sample highlight on grid}
    function ColourIndex(TheColour: TColor): Integer;
      {Returns index of colour in colour combo box if the given colour is
      predefined or index of user defined element in combo box otherwise}
    function GetNewSchemeName(var Name: string): Boolean;
      {Gets a new scheme name from user and returns it in Name parameter.
      Returns value is true if user clicked OK, false if cancelled}
    procedure SchemeIndexChange(Sender: TObject);
      {Event handler for colour scheme list OnCurrentIndexChange event}
    procedure SchemeChange(Sender: TObject);
      {Event handler for colour scheme OnChange event}
    procedure UpdateButtons;
      {Enable or disable save as and delete buttons according to current state
      of colour scheme}
    property Element: TGridElement read fElement write SetElement;
      {Property storing ID of currently selected grid element}
  public
    property Colours: TGridColours read fColours;
      {Colour scheme object currently in use}
    property ColoursChanged: Boolean read fColoursChanged;
      {Read only property true if actual colours used have been changed,
      regardless of scheme (there could be two schemes with same colours). False
      otherwise. Used to determine whether to redraw grid display}
  end;

var
  ColourSchemeDlg: TColourSchemeDlg;


implementation


uses
  // Delphi
  SysUtils,
  // Project
  Config, FmNameSelectDlg;

{$R *.DFM}

const
  // Sample grid parameters
  cNumSquares = 5;                              // Number of squares per side
  cSquareEdge = 16;                             // Size of a square
  cEdge = cNumSquares * cSquareEdge;            // Size of grid
  cLifeFormSquare: TPoint = (X: 3; Y: 2);       // Position of sample lifeform
  cHighlightSquare: TPoint = (X: 2; Y: 1);      // Position of sample highlight
  // Combo box grid parameters
  cComboNumSquares = 2;                         // Number of squares per side
  cComboLifeFormSquare: TPoint = (X: 1; Y: 1);  // Position of sample life-form
  cComboHighlightSquare: TPoint = (X: 0; Y: 0); // Position of sample highlight

const
  {List of colour numbers of predefined colours - in order their descriptions
  appear in colour combo box}
  ColourList: array[0..15] of TColor = (
    clBlack, clMaroon, clGreen, clOlive, clNavy, clPurple, clTeal, clSilver,
    clGray, clRed, clLime, clYellow, clBlue, clFuchsia, clAqua, clWhite
  );

{ --- Public event methods --- }

{ Form events }

procedure TColourSchemeDlg.FormCreate(Sender: TObject);
  {Form creation event - intialise system colours and set-up box details}
var
  I: Integer;                {Loop control variable}
begin
  {Create owned colour objects}
  fColours := TGridColours.Create;
  fWorkColours := TGridColours.Create;
  fWorkColours.OnChange := SchemeChange;
  {Put scheme names in scheme combo box}
  for I := 0 to ColourSchemeList.Count -1 do
    SchemeCombo.Items.Add(ColourSchemeList[I].Name);
  {Record current scheme}
  fColours.Assign(ColourSchemeList.CurrentScheme);
  {Next click on background selects grid - background is selected now}
  fUseBackground := False;
  {Make background the current element}
  Element := geBackGround;
  {Set current change event for ColourSchemeList to required event handler}
  ColourSchemeList.OnCurrentIndexChange := SchemeIndexChange;
end;

procedure TColourSchemeDlg.FormPaint(Sender: TObject);
  {Form paint event - ensure that the sample grid is displayed}
begin
  {Paint all grid components}
  PaintBackGround;
  PaintGridLines;
  PaintLifeForm;
  PaintHighlight;
end;

procedure TColourSchemeDlg.FormShow(Sender: TObject);
begin
  // Use current colours and select in combo box
  fWorkColours.Assign(fColours);
  ColourSchemeList.CurrentIndex :=
    ColourSchemeList.IndexOfName(fWorkColours.Name);
  fColoursChanged := False;
  // Ensure currently selected item is displayed
  ColourCombo.ItemIndex := ColourIndex(fWorkColours[Element]);
  fPrevColourIndex := ColourCombo.ItemIndex;
end;

procedure TColourSchemeDlg.FormDestroy(Sender: TObject);
  {Form destruction event - free storage}
begin
  {Free owned objects}
  fColours.Free;
  fWorkColours.Free;
end;

{ Button events }

procedure TColourSchemeDlg.DeleteSchemeBtnClick(Sender: TObject);
begin
  {Get confirmation from user to delete scheme}
  if MessageDlg(
    Format('Are you sure you want to delete scheme "%s"?', [fWorkColours.Name]),
    mtConfirmation,
    [mbYes, mbNo],
    0
  ) = mrYes then
  begin
    {Delete scheme from combo box & from schemes list}
    SchemeCombo.Items.Delete(ColourSchemeList.CurrentIndex);
    ColourSchemeList.Delete(ColourSchemeList.CurrentIndex);
    {Load new current scheme}
    SchemeComboClick(Self);
  end;
end;

procedure TColourSchemeDlg.SaveSchemeAsBtnClick(Sender: TObject);
  {Save scheme as button click event - save scheme with a user-provided name}
var
  SchemeName: string;    {The name of the new scheme}
  NameIndex: Integer;    {The index of the new scheme in scheme combo box}

  // ---------------------------------------------------------------------------
  function ValidName(N: string): Integer;
    {Subsidiary function to test validity of scheme name N. Returns FNumSchemes
    if name is OK and doesn't exist, index of name in scheme combo box if OK and
    must be overwritten, -1 if not OK}
  const
    {Array of reserved scheme names}
    Reserved: array[0..1] of string = ('DEFAULT', '<UNKNOWN>');
  var
    I: Integer;        {loop control}
    Index: Integer;    {index of scheme name in scheme list}
  begin
    {Check for empty string}
    if N = '' then
    begin
      Result := -1;
      MessageDlg(
        'You must specify a name for the scheme',
        mtError, [mbOK], 0
      );
      Exit;
    end;
    {Check for reserved names}
    for I := Low(Reserved) to High(Reserved) do
      if CompareText(N, Reserved[I]) = 0 then
      begin
        Result := -1;
        MessageDlg(
          Format('Scheme name "%s" is prohibited', [N]),
          mtError,
          [mbOK],
          0
        );
        Exit;
      end;
    {Check for existing scheme names}
    Index := ColourSchemeList.IndexOfName(N);
    if Index > -1 then
    begin
      {scheme already exists - decide what to do}
      if CompareText(N, fColours.Name) = 0 then
      begin
        {scheme in use - can't overwrite}
        Result := -1;
        MessageDlg(
          Format(
            'Can''t overwrite scheme "%s" - it is currently in use', [N]
          ),
          mtError,
          [mbOK],
          0
        );
      end
      else if MessageDlg(
        Format(
          'Scheme with name "%s" already exists.'#13#13'Overwrite?'#13,
          [N]
        ),
        mtConfirmation,
        [mbYes, mbNo],
        0
      ) = mrYes then
        {user allows overwrite}
        Result := Index
      else
        {user doesn't allow overwrite}
        Result := -1;
    end
    else
      {scheme doesn't exist - set result to just beyond end of scheme list}
      Result := ColourSchemeList.Count;
  end;
  // ---------------------------------------------------------------------------

begin
  {Get name from user - check for user cancel}
  if GetNewSchemeName(SchemeName) then
  begin
    {User clicked OK - validate name}
    NameIndex := ValidName(SchemeName);
    if NameIndex <> -1 then
    begin
      {Valid name: record the scheme}
      fWorkColours.Name := SchemeName;
      if NameIndex = ColourSchemeList.Count then
      begin
        {This is a new scheme - add it to scheme list}
        SchemeCombo.Items.Add(SchemeName);
        ColourSchemeList.CurrentIndex := ColourSchemeList.Add(fWorkColours);
      end
      else
      begin
        {This is an existing scheme - overwrite it in scheme list}
        ColourSchemeList.CurrentIndex := NameIndex;
        ColourSchemeList.CurrentScheme := fWorkColours;
      end;
    end;
  end;
end;

procedure TColourSchemeDlg.OKBtnClick(Sender: TObject);
  {OK button click event - accept changes and quit}
var
  I: TGridElementRange;    {loop control}
begin
  {Note if the colours have changed by comparing working colours with those in
  use on main display}
  for I := Low(TGridElementRange) to High(TGridElementRange) do
    if fColours[I] <> fWorkColours[I] then
      fColoursChanged := True;
  {Copy working colours to those for use by main display}
  fColours.Assign(fWorkColours);
end;

{ Combo box events events }

procedure TColourSchemeDlg.ElementComboChange(Sender: TObject);
  {Element combo box change event - this event occurs only when user selects
  new item - not if item altered programatically by altering ItemIndex. We are
  relying on this behaviour not to set up an infinate loop because the Element
  property write method alters this combo box}
begin
  {Record element selected by coercing ItemIndex to a TGridElement value}
  Element := TGridElement(ElementCombo.ItemIndex);
end;

procedure TColourSchemeDlg.ColourComboChange(Sender: TObject);
  {Colour combo box change event - sets colour of current element depending on
  colour chosen from combo box. If user chooses "User defined" then standard
  color dialogue box is displayed}
var
  PrevColour: TColor;    {Colour selected before choice is made}
begin
  {Record existing colour before new choice}
  PrevColour := fWorkColours[Element];
  {Check if item index represents a pre-defined colour (index is 0..15)}
  if ColourCombo.ItemIndex in [0..15] then
  begin
    {This is a predefined colour - record the colour for the current element}
    fWorkColours[Element] := ColourList[ColourCombo.ItemIndex];
    {Redisplay the form to update the grid}
    Invalidate;
  end
  else
  begin
    {This is not a predefined colour - the user will define using the standard
    colour dialogue box - call it}
    if CustomColourDlg.Execute then
    begin
      {User clicked OK in colour dialogue box}
      {record the selected colour from the colour dialogue}
      fWorkColours[Element] := CustomColourDlg.Color;
      {find out if the selected colour is actually a predefined one - display it
      in colour combo box if it is, otherwise continue to display the user
      defined entry}
      ColourCombo.ItemIndex := ColourIndex(fWorkColours[Element]);
      {Redisplay the form to update the grid}
      Invalidate;
    end
    else
      {User cancelled - restore previous colour selection}
      ColourCombo.ItemIndex := fPrevColourIndex;
  end;
  {Record that colour scheme has been changed if this element's colour has been
  altered}
  if PrevColour <> fWorkColours[Element] then
  begin
    {Colour has changed - set nul name and record as Unknown scheme (index -1)}
    fWorkColours.Name := '';
    ColourSchemeList.CurrentIndex := -1;
    ColourSchemeList.CurrentScheme := fWorkColours;
  end;
  {Record index of current selection for later restoration if Custom Colour
  dialogue box used again and cancelled}
  fPrevColourIndex := ColourCombo.ItemIndex;
end;

procedure TColourSchemeDlg.SchemeComboDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  TextArea: TRect;              // area in which text (scheme name) is drawn
  PicArea: TRect;               // area in which picture of scheme is drawn
  Col, Row: Integer;            // rows and columns within grid (picture)
  LeftCoord, TopCoord: Integer; // co-ords used in drawing grid
  SBuf: array[0..255] of char;  // buffer to store text for API calls
begin
  PicArea := Rect;
  PicArea.Right := 38;
  PicArea.Left := 2;
  TextArea := Rect;
  TextArea.Left := PicArea.Right + 4;
  InflateRect(PicArea, -2, -2);
  with (Control as TComboBox).Canvas do
  begin
    {Set background according to if highlighted or not}
    Pen.Color := clBlack;
    if odSelected in State then
      {selected => highlighted}
      Brush.Color := clHighlight
    else
      {no selected => no highlighted}
      Brush.Color := clWindow;
    {Clear rectangle}
    FillRect(Rect);
    {Display the text, wrapped and clipped in given rectangle using Windows API
    call}
    StrPCopy(SBuf, (Control as TComboBox).Items[Index]);
    DrawText(
      Handle,
      SBuf,
      StrLen(SBuf),
      TextArea,
      DT_LEFT or DT_NOPREFIX or DT_WORDBREAK
    );
    {Display grid background}
    Brush.Color := ColourSchemeList[Index][geBackground];
    FillRect(PicArea);
    {Display gridlines}
    Pen.Color := ColourSchemeList[Index][geGridLine];
    TopCoord := PicArea.Top;
    for Row := 0 to cComboNumSquares do
    begin
      MoveTo(PicArea.Left, TopCoord);
      LineTo(PicArea.Right+1, TopCoord);
      Inc(TopCoord, cSquareEdge);
    end;
    LeftCoord := PicArea.Left;
    for Col := 0 to cComboNumSquares do
    begin
      MoveTo(LeftCoord, PicArea.Top);
      LineTo(LeftCoord, PicArea.Bottom+1);
      Inc(LeftCoord, cSquareEdge);
    end;
    {Display grid life-form}
    LeftCoord := PicArea.Left + cComboLifeFormSquare.X * cSquareEdge;
    TopCoord := PicArea.Top + cComboLifeFormSquare.Y * cSquareEdge;
    Pen.Color := ColourSchemeList[Index][geLifeForm];
    Brush.Color := Pen.Color;
    Ellipse(LeftCoord + 3, TopCoord + 3, LeftCoord + cSquareEdge - 2, TopCoord + cSquareEdge - 2);
    {Display grid highlight}
    LeftCoord := PicArea.Left + cComboHighlightSquare.X * cSquareEdge;
    TopCoord := PicArea.Top + cComboHighlightSquare.Y * cSquareEdge;
    {select a dotted line style, and ensure highlight rectangle is transparent}
    Pen.Style := psDot;
    Brush.Style := bsClear;
    {select the current working colour for the highlight}
    Pen.Color := ColourSchemeList[Index][geHighlight];
    {draw the highlight rectangle over the gridlines surrounding the square}
    Rectangle(LeftCoord, TopCoord, LeftCoord + cSquareEdge + 1, TopCoord + cSquareEdge + 1);
    {revert to solid drawing style}
    Brush.Style := bsSolid;
    Pen.Style := psSolid;

    {"draw" invisible box - corrects bug which shows focus in one of box
    colours if the last drawing is with a coloured brush}
    Brush.Color := clBlack;
    Rectangle(Rect.Left, Rect.Top, Rect.Left, Rect.Top);
    Pen.Color := ColourSchemeList[Index][geGridLine];
  end;
end;

procedure TColourSchemeDlg.ColourComboDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
  {Draw item event for owner draw colour combo box - display current colour with
  text description if pre-defined, otherwise simply display text}
begin
  // Act on the control's canvas
  with (Control as TComboBox).Canvas do
  begin
    // Set background according to if highlighted (selected) or not
    Pen.Color := clBlack;
    if odSelected in State then
      Brush.Color := clHighlight
    else
      Brush.Color := clWindow;
    // Clear rectangle
    FillRect(Rect);
    // Display the text
    TextOut(
      Rect.Left + 2,
      (Rect.Bottom + Rect.Top - TextHeight('W')) div 2,
      (Control as TComboBox).Items[Index]
    );
    // Display appropriate colour rectangle, if any: not for user defined colour
    if Index in [0..15] then
    begin
      // These are predefined colours: draw box of colour
      Brush.Color := ColourList[Index];
      Rectangle(Rect.Left + 60, Rect.Top + 2,
        Rect.Left + 100, Rect.Bottom - 2);
      // "draw" invisible box - corrects bug which shows focus in one of box
      // colours if the last drawing is with a coloured brush
      Brush.Color := clBlack;
      Rectangle(Rect.Left, Rect.Top, Rect.Left, Rect.Top);
    end;
  end;
end;

procedure TColourSchemeDlg.SchemeComboClick(Sender: TObject);
  {Scheme combo box click event - load the newly selected colour scheme or
  re-load current scheme if it is clicked}
begin
  {Check if colour scheme for current scheme has changed and warn user changes
  will be lost if not saved}
  if (fWorkColours.Name <> '')
    or (MessageDlg(
      'Current colour scheme not been saved.' +
      #13#13 + 'Do you wish to abandon changes?'#13,
      mtConfirmation,
      [mbYes, mbNo],
      0
    )  = mrYes) then
  begin
    {Can use newly selected scheme}
    {read the colour scheme for the current (newly selected) scheme}
    ColourSchemeList.CurrentIndex := SchemeCombo.ItemIndex;
    fWorkColours.Assign(ColourSchemeList.CurrentScheme);
    {select the colour combo box item for the current element colour}
    ColourCombo.ItemIndex := ColourIndex(fWorkColours[Element]);
    {re-display to show new game-board colours}
    Invalidate;
  end
  else
    {Not using newly selected scheme - restore item which was current before}
    ColourSchemeList.CurrentIndex := ColourSchemeList.IndexOfName(fWorkColours.Name);
end;

{ Other events }

procedure TColourSchemeDlg.GridImgMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  {Mouse down event for image that grid is drawn on - find square clicked}
var
  Col, Row: Integer;       {the row and column of the grid that was clicked}
begin
  {Find row and column clicked from mouse coordinates}
  Col := X div cSquareEdge;
  Row := Y div cSquareEdge;
  {Record which element was clicked using row and column clicked and information
  about where elements are placed}
  if (Col = cLifeFormSquare.X) and (Row = cLifeFormSquare.Y) then
    {The square containing the sample life form was clicked}
    Element := geLifeForm
  else if (Col = cHighlightSquare.X) and (Row = cHighlightSquare.Y) then
    {The square containing the sample highlight was clicked}
    Element := geHighlight
  else
  begin
    {A square containing neither the life form nor the highlight was clicked -
    element is either background or grid line - toggles between the two on each
    such click}
    if fUseBackground then
      {It's the background's turn}
      Element := geBackground
    else
      {It's the grid line's turn}
      Element := geGridLine;
  end;
end;

{ --- Private property access methods --- }

procedure TColourSchemeDlg.SetElement(TheElement: TGridElement);
  {Write method for private Element property}
begin
  {Record the new element}
  fElement := TheElement;
  {Select the matching grid combo box item}
  ElementCombo.ItemIndex := Ord(fElement);
  {Select the colour combo box item for the CurrentIndex element colour}
  ColourCombo.ItemIndex := ColourIndex(fWorkColours[TheElement]);
  {If new element is either background or gridline, ensure that next click on
  an appropriate part of the grid selects the other one}
  if TheElement = geBackground then
    fUseBackground := False
  else if TheElement = geGridLine then
    fUseBackground := True;
end;

{ --- Private grid display methods --- }

procedure TColourSchemeDlg.PaintGridLines;
  {Display grid lines}
var
  Col, Row: Integer;  // loop thru grid columns and rows
begin
  {Use the Grid image control canvas}
  with GridImg.Canvas do
  begin
    {Use current working colour for grid lines}
    Pen.Color := fWorkColours[geGridLine];
    {Paint the column lines}
    for Col := 0 to cNumSquares do
    begin
      MoveTo(Col * cSquareEdge, 0);
      LineTo(Col * cSquareEdge, cEdge + 1);
    end;
    {Paint the row lines}
    for Row := 0 to cNumSquares do
    begin
      MoveTo(0, Row * cSquareEdge);
      LineTo(cEdge, Row * cSquareEdge);
    end;
  end;
end;

procedure TColourSchemeDlg.PaintLifeForm;
  {Display life form at the pre-defined position}
var
  X, Y: Integer; {Pixel position of life form square's top left corner}
begin
  {Calculate pixel position of life-form sqaure's top left corner}
  X := cLifeFormSquare.X * cSquareEdge;
  Y := cLifeFormSquare.Y * cSquareEdge;
  with GridImg.Canvas do
  {Use the canvas of the grid image control for drawing}
  begin
    {Use the current working colour for this element}
    Brush.Color := fWorkColours[geLifeForm];
    Pen.Color := fWorkColours[geLifeForm];
    {Draw the life-form within the square}
    Ellipse(X + 3, Y + 3, X + cSquareEdge - 2, Y + cSquareEdge - 2);
  end;
end;

procedure TColourSchemeDlg.PaintBackGround;
  {Display the grid background}
begin
  {Use the canvas of the grid image control for drawing}
  with GridImg.Canvas do
  begin
    {Use the current working colour for this element}
    Brush.Color := fWorkColours[geBackground];
    {Fill a rectangle the size of the grid}
    FillRect(Rect(0, 0, cEdge, cEdge));
  end;
end;

procedure TColourSchemeDlg.PaintHighlight;
  {Display the sample highlight}
var
  X, Y: Integer;   {Pixel position of the highlight sqaure's top left corner}
begin
  {Calculate pixel position of the highlight square's top left corner}
  X := cHighlightSquare.X * cSquareEdge;
  Y := cHighlightSquare.Y * cSquareEdge;
  {Use the canvas of the grid image control for drawing}
  with GridImg.Canvas do
  begin
    {Select a dotted line style, and ensure highlight rectangle is transparent}
    Pen.Style := psDot;
    Brush.Style := bsClear;
    {Select the current working colour for the highlight}
    Pen.Color := fWorkColours[geHighlight];
    {Draw the highlight rectangle over the gridlines surrounding the square}
    Rectangle(X, Y, X + cSquareEdge + 1, Y + cSquareEdge + 1);
    {Revert to solid drawing style}
    Brush.Style := bsSolid;
    Pen.Style := psSolid;
  end;
end;

{ --- Other private methods --- }

function TColourSchemeDlg.ColourIndex(TheColour: TColor): Integer;
  {Search for given colour in the array of predefined colours and return its
  position in the array, or 16 if not in array. These return values map onto the
  index of the colour descriptions in the Colour combo box}
var
  Found: Boolean;      {Flag set true when colour found}
begin
  {Initialise Result and Found flag}
  Result := 0;
  Found := False;
  {Scan ColourList array looking for required colour - if not found Result will
  have value 16}
  while (Result < 16) and not Found do
    if ColourList[Result] = TheColour then
      {Found it - record fact}
      Found := True
    else
      {Not found it - try next array element}
      Inc(Result);
end;

function TColourSchemeDlg.GetNewSchemeName(var Name: string): Boolean;
  {Gets a new scheme name from user and returns it in Name parameter. Returns
  value is true if user clicked OK, false if cancelled}
begin
  {Set up SaveIni dialogue box to use scheme names, copy scheme names (excluding
  Default) to dialogue combo box - ensure no item is selected}
  with NameSelectDlg do
  begin
    {set up dialogue box}
    Title := 'Save Colour Scheme';
    Prompt := 'Choose or enter new scheme &name:';
    {copy schemes to combo box}
    NameCombo.Items := SchemeCombo.Items;
    {exclude default scheme}
    NameCombo.Items.Delete(SchemeCombo.Items.IndexOf('Default'));
    {make sure no items selected}
    NameCombo.ItemIndex := -1;
  end;
  {Call dialogue box and record if user presses OK}
  Result := (NameSelectDlg.ShowModal = mrOK);
  {Record name entered (not used if Result = False)}
  Name := NameSelectDlg.NameCombo.Text;
end;

procedure TColourSchemeDlg.SchemeIndexChange(Sender: TObject);
  {Event handler for colour scheme list OnCurrentIndexChange event}
begin
  {Select scheme lists current record in scheme combo box}
  SchemeCombo.ItemIndex := ColourSchemeList.CurrentIndex;
end;

procedure TColourSchemeDlg.SchemeChange(Sender: TObject);
  {Event handler for colour scheme OnChange event}
begin
  {Update state of buttons}
  UpdateButtons;
end;

procedure TColourSchemeDlg.UpdateButtons;
  {Enable or disable save as and delete buttons according to current state of
  colour scheme}
begin
  {Update Delete button & Save As button}
  DeleteSchemeBtn.Enabled := (CompareText(fWorkColours.Name, 'Default') <> 0)
    and (fWorkColours.Name <> '')
    and (CompareText(fWorkColours.Name, fColours.Name) <> 0);
  SaveSchemeAsBtn.Enabled := CompareText(fWorkColours.Name, 'Default') <> 0;
end;

end.