object ApplyRuleDlg: TApplyRuleDlg
  Left = 200
  Top = 99
  ActiveControl = StartGameChkBox
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Apply Rule Options'
  ClientHeight = 141
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
    Top = 98
    Width = 409
    Height = 9
    Shape = bsTopLine
  end
  object PromptLbl: TLabel
    Left = 8
    Top = 8
    Width = 285
    Height = 34
    AutoSize = False
    Caption = 
      'Your new rule will be applied to the current game. Select if you' +
      ' also want to:'
    WordWrap = True
  end
  object OKBtn: TButton
    Left = 72
    Top = 106
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    DoubleBuffered = True
    ModalResult = 1
    ParentDoubleBuffered = False
    TabOrder = 2
  end
  object CancelBtn: TButton
    Left = 152
    Top = 106
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    DoubleBuffered = True
    ModalResult = 2
    ParentDoubleBuffered = False
    TabOrder = 3
  end
  object StartGameChkBox: TCheckBox
    Left = 16
    Top = 48
    Width = 201
    Height = 17
    Caption = 'Apply rule to start of game'
    Checked = True
    State = cbChecked
    TabOrder = 0
  end
  object SnapshotChkBox: TCheckBox
    Left = 16
    Top = 72
    Width = 201
    Height = 17
    Caption = 'Apply rule to snapshot'
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
end
