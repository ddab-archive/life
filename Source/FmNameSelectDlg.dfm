object NameSelectDlg: TNameSelectDlg
  Left = 444
  Top = 124
  ActiveControl = NameCombo
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  ClientHeight = 189
  ClientWidth = 299
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 144
    Width = 283
    Height = 9
    Shape = bsTopLine
  end
  object PromptLbl: TLabel
    Left = 11
    Top = 8
    Width = 277
    Height = 13
    AutoSize = False
    FocusControl = NameCombo
  end
  object OKBtn: TButton
    Left = 71
    Top = 152
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    DoubleBuffered = True
    ModalResult = 1
    ParentDoubleBuffered = False
    TabOrder = 1
  end
  object CancelBtn: TButton
    Left = 152
    Top = 152
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    DoubleBuffered = True
    ModalResult = 2
    ParentDoubleBuffered = False
    TabOrder = 2
  end
  object NameCombo: TComboBox
    Left = 8
    Top = 32
    Width = 283
    Height = 21
    TabOrder = 0
  end
end
