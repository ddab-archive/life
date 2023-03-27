object ColourSchemeDlg: TColourSchemeDlg
  Left = 229
  Top = 97
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Colour Schemes'
  ClientHeight = 228
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 8
    Top = 72
    Width = 241
    Height = 105
  end
  object ElementLbl: TLabel
    Left = 16
    Top = 78
    Width = 82
    Height = 13
    Caption = 'Current &element:'
    FocusControl = ElementCombo
  end
  object ColourLbl: TLabel
    Left = 16
    Top = 126
    Width = 35
    Height = 13
    Caption = '&Colour:'
    FocusControl = ColourCombo
  end
  object Bevel1: TBevel
    Left = 8
    Top = 185
    Width = 353
    Height = 9
    Shape = bsTopLine
  end
  object SchemeLbl: TLabel
    Left = 8
    Top = 6
    Width = 41
    Height = 13
    Caption = 'Sc&heme:'
  end
  object OKBtn: TButton
    Left = 106
    Top = 193
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    DoubleBuffered = True
    ModalResult = 1
    ParentDoubleBuffered = False
    TabOrder = 5
    OnClick = OKBtnClick
  end
  object ElementCombo: TComboBox
    Left = 16
    Top = 96
    Width = 127
    Height = 21
    Style = csDropDownList
    TabOrder = 1
    OnChange = ElementComboChange
    Items.Strings = (
      'Background'
      'Grid line'
      'Life form'
      'Highlight')
  end
  object GridPanel: TPanel
    Left = 152
    Top = 80
    Width = 89
    Height = 89
    TabOrder = 7
    object GridImg: TImage
      Left = 4
      Top = 4
      Width = 81
      Height = 81
      OnMouseDown = GridImgMouseDown
    end
  end
  object ColourCombo: TComboBox
    Left = 16
    Top = 144
    Width = 127
    Height = 21
    Style = csOwnerDrawFixed
    ItemHeight = 15
    TabOrder = 2
    OnChange = ColourComboChange
    OnDrawItem = ColourComboDrawItem
    Items.Strings = (
      'Black'
      'Maroon'
      'Green'
      'Olive'
      'Navy'
      'Purple'
      'Teal'
      'Silver'
      'Grey'
      'Red'
      'Lime'
      'Yellow'
      'Blue'
      'Fuchsia'
      'Aqua'
      'White'
      'User defined...')
  end
  object CancelBtn: TButton
    Left = 187
    Top = 193
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    DoubleBuffered = True
    ModalResult = 2
    ParentDoubleBuffered = False
    TabOrder = 6
  end
  object SchemeCombo: TComboBox
    Left = 8
    Top = 24
    Width = 353
    Height = 42
    Style = csOwnerDrawFixed
    DropDownCount = 10
    ItemHeight = 36
    TabOrder = 0
    OnClick = SchemeComboClick
    OnDrawItem = SchemeComboDrawItem
  end
  object SaveSchemeAsBtn: TButton
    Left = 260
    Top = 72
    Width = 101
    Height = 28
    Caption = '&Save as...'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 3
    OnClick = SaveSchemeAsBtnClick
  end
  object DeleteSchemeBtn: TButton
    Left = 260
    Top = 104
    Width = 101
    Height = 28
    Caption = 'De&lete'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 4
    OnClick = DeleteSchemeBtnClick
  end
  object CustomColourDlg: TColorDialog
    Options = [cdShowHelp]
    Left = 288
    Top = 152
  end
end
