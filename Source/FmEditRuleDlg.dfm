object EditRuleDlg: TEditRuleDlg
  Left = 200
  Top = 99
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Rules'
  ClientHeight = 307
  ClientWidth = 353
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 264
    Width = 337
    Height = 9
    Shape = bsTopLine
  end
  object RuleComboLbl: TLabel
    Left = 8
    Top = 6
    Width = 25
    Height = 13
    Caption = '&Rule:'
    FocusControl = RuleCombo
  end
  object CloseBtn: TButton
    Left = 139
    Top = 272
    Width = 75
    Height = 25
    Caption = '&Close'
    DoubleBuffered = True
    ModalResult = 1
    ParentDoubleBuffered = False
    TabOrder = 8
  end
  object SaveAsBtn: TButton
    Left = 244
    Top = 56
    Width = 101
    Height = 28
    Caption = 'Save &as...'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 4
    OnClick = SaveAsBtnClick
  end
  object DeleteBtn: TButton
    Left = 244
    Top = 88
    Width = 101
    Height = 28
    Caption = 'De&lete'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 5
    OnClick = DeleteBtnClick
  end
  object SaveBtn: TButton
    Left = 244
    Top = 24
    Width = 101
    Height = 28
    Caption = '&Save'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 3
    OnClick = SaveBtnClick
  end
  object ApplyBtn: TButton
    Left = 244
    Top = 120
    Width = 101
    Height = 28
    Caption = 'A&pply'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 6
    OnClick = ApplyBtnClick
  end
  object BirthGpBox: TGroupBox
    Left = 8
    Top = 64
    Width = 105
    Height = 193
    Caption = '&Birth rule'
    TabOrder = 1
    object Bevel2: TBevel
      Left = 3
      Top = 168
      Width = 99
      Height = 25
      Shape = bsTopLine
    end
    object BirthSetLbl: TLabel
      Left = 2
      Top = 174
      Width = 101
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object BirthRuleChkBox0: TCheckBox
      Left = 13
      Top = 21
      Width = 44
      Height = 17
      Caption = '0'
      TabOrder = 0
      OnClick = BirthRuleChkBoxClick
    end
    object BirthRuleChkBox1: TCheckBox
      Tag = 1
      Left = 13
      Top = 37
      Width = 44
      Height = 17
      Caption = '1'
      TabOrder = 1
      OnClick = BirthRuleChkBoxClick
    end
    object BirthRuleChkBox2: TCheckBox
      Tag = 2
      Left = 13
      Top = 53
      Width = 44
      Height = 17
      Caption = '2'
      TabOrder = 2
      OnClick = BirthRuleChkBoxClick
    end
    object BirthRuleChkBox3: TCheckBox
      Tag = 3
      Left = 13
      Top = 69
      Width = 44
      Height = 17
      Caption = '3'
      TabOrder = 3
      OnClick = BirthRuleChkBoxClick
    end
    object BirthRuleChkBox4: TCheckBox
      Tag = 4
      Left = 13
      Top = 85
      Width = 44
      Height = 17
      Caption = '4'
      TabOrder = 4
      OnClick = BirthRuleChkBoxClick
    end
    object BirthRuleChkBox5: TCheckBox
      Tag = 5
      Left = 13
      Top = 101
      Width = 44
      Height = 17
      Caption = '5'
      TabOrder = 5
      OnClick = BirthRuleChkBoxClick
    end
    object BirthRuleChkBox6: TCheckBox
      Tag = 6
      Left = 13
      Top = 117
      Width = 44
      Height = 17
      Caption = '6'
      TabOrder = 6
      OnClick = BirthRuleChkBoxClick
    end
    object BirthRuleChkBox7: TCheckBox
      Tag = 7
      Left = 13
      Top = 133
      Width = 44
      Height = 17
      Caption = '7'
      TabOrder = 7
      OnClick = BirthRuleChkBoxClick
    end
    object BirthRuleChkBox8: TCheckBox
      Tag = 8
      Left = 13
      Top = 149
      Width = 44
      Height = 17
      Caption = '8'
      TabOrder = 8
      OnClick = BirthRuleChkBoxClick
    end
  end
  object RuleCombo: TComboBox
    Left = 8
    Top = 24
    Width = 225
    Height = 21
    Style = csDropDownList
    TabOrder = 0
    OnChange = RuleComboChange
  end
  object SurvivalGpBox: TGroupBox
    Left = 128
    Top = 64
    Width = 105
    Height = 193
    Caption = 'S&urvival rile'
    TabOrder = 2
    object Bevel3: TBevel
      Left = 3
      Top = 168
      Width = 99
      Height = 25
      Shape = bsTopLine
    end
    object SurvivalSetLbl: TLabel
      Left = 2
      Top = 174
      Width = 101
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object SurvivalRuleChkBox0: TCheckBox
      Left = 13
      Top = 21
      Width = 44
      Height = 17
      Caption = '0'
      TabOrder = 0
      OnClick = SurvivalRuleChkBoxClick
    end
    object SurvivalRuleChkBox1: TCheckBox
      Tag = 1
      Left = 13
      Top = 37
      Width = 44
      Height = 17
      Caption = '1'
      TabOrder = 1
      OnClick = SurvivalRuleChkBoxClick
    end
    object SurvivalRuleChkBox2: TCheckBox
      Tag = 2
      Left = 13
      Top = 53
      Width = 44
      Height = 17
      Caption = '2'
      TabOrder = 2
      OnClick = SurvivalRuleChkBoxClick
    end
    object SurvivalRuleChkBox3: TCheckBox
      Tag = 3
      Left = 13
      Top = 69
      Width = 44
      Height = 17
      Caption = '3'
      TabOrder = 3
      OnClick = SurvivalRuleChkBoxClick
    end
    object SurvivalRuleChkBox4: TCheckBox
      Tag = 4
      Left = 13
      Top = 85
      Width = 44
      Height = 17
      Caption = '4'
      TabOrder = 4
      OnClick = SurvivalRuleChkBoxClick
    end
    object SurvivalRuleChkBox5: TCheckBox
      Tag = 5
      Left = 13
      Top = 101
      Width = 44
      Height = 17
      Caption = '5'
      TabOrder = 5
      OnClick = SurvivalRuleChkBoxClick
    end
    object SurvivalRuleChkBox6: TCheckBox
      Tag = 6
      Left = 13
      Top = 117
      Width = 44
      Height = 17
      Caption = '6'
      TabOrder = 6
      OnClick = SurvivalRuleChkBoxClick
    end
    object SurvivalRuleChkBox7: TCheckBox
      Tag = 7
      Left = 13
      Top = 133
      Width = 44
      Height = 17
      Caption = '7'
      TabOrder = 7
      OnClick = SurvivalRuleChkBoxClick
    end
    object SurvivalRuleChkBox8: TCheckBox
      Tag = 8
      Left = 13
      Top = 149
      Width = 44
      Height = 17
      Caption = '8'
      TabOrder = 8
      OnClick = SurvivalRuleChkBoxClick
    end
  end
  object ExplainBtn: TButton
    Left = 244
    Top = 229
    Width = 101
    Height = 28
    Caption = '&Explain...'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 7
    OnClick = ExplainBtnClick
  end
end
