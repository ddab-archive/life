object ReplayDlg: TReplayDlg
  Left = 200
  Top = 99
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Replay'
  ClientHeight = 135
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
    Top = 90
    Width = 283
    Height = 3
    Shape = bsTopLine
  end
  object PromptLbl: TLabel
    Left = 8
    Top = 8
    Width = 185
    Height = 13
    Caption = 'Select  where you wish to replay from:'
  end
  object OKBtn: TButton
    Left = 71
    Top = 98
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    DoubleBuffered = True
    ModalResult = 1
    ParentDoubleBuffered = False
    TabOrder = 2
  end
  object StartRadio: TRadioButton
    Left = 16
    Top = 31
    Width = 217
    Height = 17
    Caption = 'Replay from start of game'
    Checked = True
    TabOrder = 0
    TabStop = True
  end
  object SnapshotRadio: TRadioButton
    Left = 16
    Top = 56
    Width = 217
    Height = 17
    Caption = 'Replay from snapshot'
    TabOrder = 1
  end
  object CancelBtn: TButton
    Left = 152
    Top = 98
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    DoubleBuffered = True
    ModalResult = 2
    ParentDoubleBuffered = False
    TabOrder = 3
  end
end
