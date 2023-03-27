object SaveGameStateDlg: TSaveGameStateDlg
  Left = 200
  Top = 98
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Save Options'
  ClientHeight = 157
  ClientWidth = 299
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 114
    Width = 283
    Height = 3
    Shape = bsTopLine
  end
  object PromptLbl: TLabel
    Left = 8
    Top = 8
    Width = 144
    Height = 13
    Caption = 'Select what you wish to save:'
  end
  object OKBtn: TButton
    Left = 71
    Top = 122
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    DoubleBuffered = True
    ModalResult = 1
    ParentDoubleBuffered = False
    TabOrder = 3
  end
  object StartRadio: TRadioButton
    Left = 16
    Top = 31
    Width = 185
    Height = 17
    Caption = 'Save start of game'
    Checked = True
    TabOrder = 0
    TabStop = True
  end
  object SnapshotRadio: TRadioButton
    Left = 16
    Top = 80
    Width = 185
    Height = 17
    Caption = 'Save snapshot'
    TabOrder = 2
  end
  object CancelBtn: TButton
    Left = 152
    Top = 122
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    DoubleBuffered = True
    ModalResult = 2
    ParentDoubleBuffered = False
    TabOrder = 4
  end
  object CurrentRadio: TRadioButton
    Left = 16
    Top = 56
    Width = 185
    Height = 17
    Caption = 'Save current generation'
    TabOrder = 1
  end
end
