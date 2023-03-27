object ExplainRuleDlg: TExplainRuleDlg
  Left = 200
  Top = 99
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Explain Rules'
  ClientHeight = 195
  ClientWidth = 409
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
    Top = 152
    Width = 393
    Height = 9
    Shape = bsTopLine
  end
  object CloseBtn: TButton
    Left = 167
    Top = 160
    Width = 75
    Height = 25
    Caption = '&Close'
    DoubleBuffered = True
    ModalResult = 1
    ParentDoubleBuffered = False
    TabOrder = 0
  end
  object BirthRuleGp: TGroupBox
    Left = 8
    Top = 8
    Width = 393
    Height = 65
    Caption = 'Explanation of Birth Rule'
    TabOrder = 1
    object BirthRuleExplainedLbl: TLabel
      Left = 8
      Top = 20
      Width = 377
      Height = 37
      AutoSize = False
      WordWrap = True
    end
  end
  object SurvivalRuleGp: TGroupBox
    Left = 8
    Top = 80
    Width = 393
    Height = 65
    Caption = 'Explanation of Survival Rule'
    TabOrder = 2
    object SurvivalRuleExplainedLbl: TLabel
      Left = 8
      Top = 20
      Width = 377
      Height = 37
      AutoSize = False
      WordWrap = True
    end
  end
end
