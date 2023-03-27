object MainForm: TMainForm
  Left = 191
  Top = 97
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 437
  ClientWidth = 545
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object KillBtn: TBitBtn
    Left = 428
    Top = 377
    Width = 109
    Height = 28
    Caption = '&Kill cell'
    DoubleBuffered = True
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000010000000000000000000
      BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      7777777700007777777777777777777700007777777788888877777700007777
      7778BBBBBB87777700007777778BBBBBBBB877770000777778BB0BBBB0BB8777
      000077778BBBB0000BBBB877000077778BBBBBBBBBBBB877000077778BBBBB00
      BBBBB877000077778BBBBB00BBBBB877000077778BBBBBBBBBBBB87700007777
      8BB00BBBB00BB8770000711778B11BBBB00B8777000077117711BBBBBBB87777
      000077711118BBBBBB8777770000777711778888887777770000777111177777
      7777777700007711771177777777777700007777777117777777777700007777
      77777777777777770000}
    ParentDoubleBuffered = False
    TabOrder = 5
    OnClick = KillBtnClick
  end
  object GridPnl: TPanel
    Left = 8
    Top = 58
    Width = 345
    Height = 345
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 6
    object GridImg: TImage
      Left = 4
      Top = 4
      Width = 337
      Height = 337
      DragCursor = crArrow
      OnDblClick = GridImgDblClick
      OnDragOver = GridImgDragOver
      OnEndDrag = GridImgEndDrag
      OnMouseDown = GridImgMouseDown
    end
  end
  object SquareInfoGpBox: TGroupBox
    Left = 384
    Top = 52
    Width = 153
    Height = 85
    Caption = 'Square Info'
    TabOrder = 7
    object SquareLbl: TLabel
      Left = 8
      Top = 17
      Width = 38
      Height = 13
      Caption = 'Square:'
    end
    object BugLbl: TLabel
      Left = 8
      Top = 33
      Width = 54
      Height = 13
      Caption = 'Life-Form?:'
    end
    object NeighbourLbl: TLabel
      Left = 8
      Top = 65
      Width = 58
      Height = 13
      Caption = 'Neighbours:'
    end
    object SquareDtl: TLabel
      Left = 96
      Top = 17
      Width = 36
      Height = 13
      Caption = '(10,10)'
    end
    object BugDtl: TLabel
      Left = 96
      Top = 33
      Width = 13
      Height = 13
      Caption = 'No'
      Color = clBtnFace
      ParentColor = False
    end
    object NeighbourDtl: TLabel
      Left = 96
      Top = 65
      Width = 6
      Height = 13
      Caption = '0'
      Color = clBtnFace
      ParentColor = False
    end
    object AgeLbl: TLabel
      Left = 8
      Top = 49
      Width = 23
      Height = 13
      Caption = 'Age:'
    end
    object AgeDtl: TLabel
      Left = 96
      Top = 49
      Width = 17
      Height = 13
      Caption = 'N/a'
      Color = clBtnFace
      ParentColor = False
    end
  end
  object GenInfoGpBox: TGroupBox
    Left = 384
    Top = 141
    Width = 153
    Height = 53
    Caption = 'Generation Info'
    TabOrder = 8
    object BugCountLbl: TLabel
      Left = 8
      Top = 17
      Width = 54
      Height = 13
      Caption = 'Life-Forms:'
    end
    object GenLbl: TLabel
      Left = 8
      Top = 33
      Width = 57
      Height = 13
      Caption = 'Generation:'
    end
    object BugCountDtl: TLabel
      Left = 96
      Top = 17
      Width = 6
      Height = 13
      Caption = '0'
    end
    object GenDtl: TLabel
      Left = 96
      Top = 33
      Width = 6
      Height = 13
      Caption = '0'
      Color = clBtnFace
      ParentColor = False
    end
  end
  object GenBtn: TBitBtn
    Left = 384
    Top = 206
    Width = 153
    Height = 33
    Caption = 'Next &Generation'
    Default = True
    DoubleBuffered = True
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000010000000000000000000
      BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      77777777000077777777777888777777000077777777778BBB87777700007777
      7777778BBB8777770000777777777778887888770000777778888887778BBB87
      000077778BBBBBB8778BBB8700007778BB0000BB877888770000778BB0BBBB0B
      B8777777000078BB0BBBBBB0BB877777000078BBBBBBBBBBBB877777000078BB
      BBB00BBBBB877777000078BBBBB00BBBBB877777000078BBBBBBBBBBBB877777
      000078BB00BBBB00BB8777770000778B00BBBB00B878887700007778BBBBBBBB
      878BBB87000077778BBBBBB8778BBB8700007777788888877778887700007777
      77777777777777770000}
    ParentDoubleBuffered = False
    TabOrder = 0
    OnClick = GenBtnClick
  end
  object ReplayBtn: TBitBtn
    Left = 428
    Top = 247
    Width = 109
    Height = 28
    Caption = '&Replay'
    DoubleBuffered = True
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000010000000000000000000
      BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      7777777700007777777777777777777700007777777777777777777700007777
      77777777777777770000777777774F7777774F770000777777744F7777744F77
      0000777777444F7777444F770000777774444F7774444F770000777744444F77
      44444F770000777444444F7444444F770000774444444F4444444F7700007774
      44444F7444444F770000777744444F7744444F770000777774444F7774444F77
      0000777777444F7777444F770000777777744F7777744F770000777777774F77
      77774F7700007777777777777777777700007777777777777777777700007777
      77777777777777770000}
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = ReplayBtnClick
  end
  object SnapshotBtn: TBitBtn
    Left = 428
    Top = 278
    Width = 109
    Height = 28
    Caption = '&Snapshot'
    DoubleBuffered = True
    NumGlyphs = 3
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = SnapshotBtnClick
  end
  object CreateBtn: TBitBtn
    Left = 428
    Top = 346
    Width = 109
    Height = 28
    Caption = '&Create cell'
    DoubleBuffered = True
    Glyph.Data = {
      4E010000424D4E01000000000000760000002800000012000000120000000100
      040000000000D800000000000000000000001000000010000000000000000000
      BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0077777777FF77
      7777770000007F77777777777777F700000077F777888888777F77000000777F
      78BBBBBB87F77700000077778BB0000BB877770000007778BB0BBBB0BB877700
      0000778BB0BBBBBB0BB877000000778BBBBBBBBBBBB877000000F78BBBBB00BB
      BBB87F000000F78BBBBB00BBBBB87F000000778BBBBBBBBBBBB877000000778B
      B00BBBB00BB8770000007778B00BBBB00B877700000077778BBBBBBBB8777700
      0000777F78BBBBBB87F77700000077F777888888777F770000007F7777777777
      7777F700000077777777FF77777777000000}
    ParentDoubleBuffered = False
    TabOrder = 4
    OnClick = CreateBtnClick
  end
  object ClearBtn: TBitBtn
    Left = 428
    Top = 312
    Width = 109
    Height = 28
    Caption = 'C&lear'
    DoubleBuffered = True
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000010000000000000000000
      BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      7777777700007788888888888888888700007787778777877787778700007F87
      F7FF77877787778700007F8FFFFFF7877787778700007FFFFFFFFF7788888887
      00007FFFFFFF84047787778700007FFFFFF84CC60787778700007FFFFFF4C4CC
      6077778700007FFFFFFC4F4CC607888700007FFFFFF4CFC4C060778700007FF7
      FF874CFC0246078700007F877F8774C0A2246077000077888888880ABA220807
      0000778777877780ABA0488700007787778777870A07B4870000778777877787
      707FBB470000778888888888880FFBB700007777777777777770FFB700007777
      77777777777777770000}
    ParentDoubleBuffered = False
    TabOrder = 3
    OnClick = ClearBtnClick
  end
  object StatusPnl: TPanel
    Left = 0
    Top = 412
    Width = 545
    Height = 25
    Align = alBottom
    Alignment = taLeftJustify
    BevelInner = bvRaised
    BevelOuter = bvNone
    TabOrder = 9
    object SchemePnl: TPanel
      Left = 201
      Top = 1
      Width = 288
      Height = 23
      Align = alLeft
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      TabOrder = 0
      object SchemeLbl: TLabel
        Left = 2
        Top = 4
        Width = 283
        Height = 13
        AutoSize = False
        ShowAccelChar = False
        OnDblClick = SchemeLblDblClick
      end
    end
    object RulePnl: TPanel
      Left = 1
      Top = 1
      Width = 200
      Height = 23
      Align = alLeft
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      TabOrder = 1
      object RuleLbl: TLabel
        Left = 2
        Top = 4
        Width = 195
        Height = 13
        AutoSize = False
        ShowAccelChar = False
        OnDblClick = RuleLblDblClick
      end
    end
  end
  object ToolBar1: TToolBar
    AlignWithMargins = True
    Left = 4
    Top = 4
    Width = 537
    Height = 42
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ButtonHeight = 36
    ButtonWidth = 55
    EdgeBorders = [ebBottom]
    EdgeOuter = esNone
    Images = Images
    ShowCaptions = True
    TabOrder = 10
    object TBOpen: TToolButton
      Left = 0
      Top = 0
      Action = OpenAction
    end
    object TBSave: TToolButton
      Left = 55
      Top = 0
      Action = SaveAction
    end
    object TBSeparator1: TToolButton
      Left = 110
      Top = 0
      Width = 8
      Caption = 'TBSeparator1'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object TBRules: TToolButton
      Left = 118
      Top = 0
      Action = RulesAction
    end
    object TBColourSchemes: TToolButton
      Left = 173
      Top = 0
      Action = ColourSchemesAction
    end
    object TBSeparator2: TToolButton
      Left = 228
      Top = 0
      Width = 8
      Caption = 'TBSeparator2'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object TBHelp: TToolButton
      Left = 236
      Top = 0
      Action = HelpAction
    end
    object TBAbout: TToolButton
      Left = 291
      Top = 0
      Action = AboutAction
    end
    object TBSeparator3: TToolButton
      Left = 346
      Top = 0
      Width = 8
      Caption = 'TBSeparator3'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object TBexit: TToolButton
      Left = 354
      Top = 0
      Action = ExitAction
    end
  end
  object OpenDlg: TOpenDialog
    DefaultExt = 'gol'
    Filter = 'Game of Life (*.gol)|*.gol|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofShowHelp, ofPathMustExist, ofFileMustExist]
    Title = 'Open Game'
    Left = 40
    Top = 184
  end
  object SaveDlg: TSaveDialog
    DefaultExt = 'gol'
    Filter = 'Game of Life (*.gol)|*.gol|All Files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofShowHelp, ofPathMustExist]
    Title = 'Save Game As'
    Left = 104
    Top = 184
  end
  object AboutBoxDlg: TPJAboutBoxDlg
    Title = 'About'
    ButtonKind = abkClose
    VersionInfo = VerInfo
    Position = abpOwner
    UseOwnerAsParent = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 104
    Top = 128
  end
  object VerInfo: TPJVersionInfo
    Left = 40
    Top = 128
  end
  object Images: TImageList
    Left = 104
    Top = 72
    Bitmap = {
      494C010107003C00740010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ECF2F600CCDBE800A5C1
      D60080A7C5006394B800165E93001D6397000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F4ECE500D6BAA200B6845A00AC744500AB724300B27E5300D2B59C00F2EA
      E300000000000000000000000000000000000000000000000000000000000000
      0000F1E8E300CBAB9B00A16A510090583E008E573E009A695200C5A99C00EEE7
      E300000000000000000000000000000000009999990071717100545454005151
      51004F4F4F004C4C4C004A4A4A00474747004545450025679D003274A8003D7C
      AF004784B5004E8ABA003E7EAD00206598000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E7D5
      C600BA895F00D7BBA300E9DACA00ECE0D100ECE0D100E8D8C800D3B59C00B07A
      4D00E2CFBE00000000000000000000000000000000000000000000000000E0C8
      BD00A3664800B2805700D5B79300DBC3A600DAC3A600D2B49000AB7A52009260
      4800D8C6BD00000000000000000000000000000000000000000058585800A2A2
      A200A2A2A200A3A3A300A4A4A400A4A4A400A5A5A5002F6FA50078ABD20078AB
      D30073A7D10069A0CD00407FAE0023679A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EAD9CB00BE8C
      6200E7D5C400E5D2BF00C9A68500B88E6700B68A6500C5A18000E0CCBA00E3D0
      BE00AF764800E3D0C00000000000000000000000000000000000E2CCBD00A35C
      3C00CBA77D00D8BB9F00C39C7700B68A6200B4866000BE967200D1B39700C5A3
      770089573E00D9C6BD00000000000000000000000000000000005C5C5C00A1A1
      A1003C734000A0A1A100A3A3A300A3A3A300A4A4A4003674AA007DAFD4005B9A
      C9005495C7005896C8004180AE0026699D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F1EC00C99D7900EAD8
      C900E3CDBA00C0946B00BA8C6200CFB09400CFB09400B7895F00B2876100DAC0
      AA00E4D1C000B6835900F4ECE6000000000000000000F4ECE400B4784A00CFAA
      8100DABCA200BE916600BA8C6200B7895F00B3845E00B1835D00B0835C00CDAA
      8D00C6A5790095624900EFE8E40000000000000000000000000060606000A0A0
      A0003D76410036713900A2A2A200A2A2A200A3A3A3003D79B00082B3D700629F
      CC005A9AC9005E9BCA004381AF002C6DA0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E6CFBC00E4CCB900EAD6
      C500C7997100BF906600BF906600F7F1EC00F6F0EA00B7895F00B7895F00B589
      6300E2CEBB00D9BDA600D9BEA7000000000000000000DCBC9B00BF915E00E0C2
      A800C5966C00C2916900E1CBB800FEFDFC00FFFFFE00EADCD000B4855E00B385
      5E00D4B59900AE7B5600C8A99B000000000037823E00347E3B00317937002E75
      340049915000468F4C0039733D00A1A1A100A2A2A200457EB40088B7D90067A3
      CF00619ECC00639FCC004583B1003171A4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D9B39500EFE1D300D9B5
      9500C7986C00C3956900C1936700BF906600BF906600BB8B6300B98A6300B88A
      6200CBA78600EADCCC00C2956F000000000000000000C5905200DBBC9C00D5AD
      8900C7986C00C3956900C1936700EDDFD300FAF7F400BB8B6300B98A6300B88A
      6200C59D7800D2B89300A06A5200000000003B87420089CB920084C88D0080C6
      88007BC3830077C17F00478F4D003B743F00A1A1A1004C84BA008DBBDB006EA8
      D10066A6D1005FB4DF004785B1003775A9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DAB39300F2E4D900D1A5
      7A00C5996B00C4976A00C4966900FAF6F200F3EAE100C2956D00BE8F6500BE8F
      6400C0956D00EFE3D500C19067000000000000000000C1833C00E3C7AF00D0A2
      7600C5996B00C4976A00C4966900EEE0D400FBF7F400BF906600BE8F6500BE8F
      6400BE926900DFC6AA0096563B00000000003E8B46008FCE99007DC6870078C3
      810073C07C0074C07C0079C2810049904F00547F57005489BF0094BFDD0075AD
      D40063B8E1004BD4FF00428BB8003D7AAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E1BB9D00F2E5DA00D1A6
      7E00CC9D7100C79A6C00C5986B00E2CCB600F8F3EE00F6EEE800D9BDA100C294
      6800C59B7100F0E2D600C79971000000000000000000C7894200E4C9B000D0A3
      7A00CC9D7100C79A6C00C5986B0000000000FFFFFE00C3966900C1946800C294
      6800C3986D00DFC5AB0099593B000000000041904A0094D29F0091D09A008DCD
      960089CB920084C88D0051985800417C46009F9F9F005A8EC40098C3E0007CB3
      D70074AFD6005EC4ED004B88B300457FB2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EACAB000F3E5D900DFBB
      9E00CFA07500CD9E7200F5EBE300E4CBB400E7D3BF00FBF8F600E5D3BF00C498
      6B00D6B49100EEE0D200D3AC8B000000000000000000D29E5C00E0BC9F00DBB3
      9300CFA07500CD9E7200CB9C7100DDBFA300DDBFA200C5996B00C5996B00C498
      6B00D1AB8500D8BA9700AC6E52000000000044944D0042914B003F8D48003D89
      45005DA465005AA0610045834B009E9E9E009E9E9E006092C9009EC7E20083B8
      DA007DB4D7007EB3D7004F89B4004B84B7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F5E4D600F4E3D400EFDC
      CD00D5A87E00D0A07700FBF8F500FCF8F500FCF8F500FBF8F500D1A88100CFA4
      7B00EAD5C300EAD4C200E9D4C2000000000000000000E7C9A400CD9C6800E7CB
      B400D4A57A00D0A07700CF9E7400FBF8F500FBF8F500CB9E7100CB9D7100CDA1
      7700DFC0A500B98A5B00D2AE9B00000000000000000000000000777777009A9A
      9A003D8A4500498A4F009C9C9C009D9D9D009D9D9D006696CC00A2CBE30089BD
      DC0083B9DA0084B9DA00518BB5005289BC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FDF9F500F1D3BB00F6E9
      DD00ECD8C600D7AC8100DCBB9A00F6ECE300F5ECE200E4C8AE00D2A77B00E6CE
      BA00F1E2D500DFBB9C00FAF4F0000000000000000000F9F1E700D39A5A00D9B2
      8C00E6CAB300D6A97D00D1A57900E2C4A800E1C3A800D0A27600D1A47700DDBD
      A200D0AC8500B4764A00F4EAE4000000000000000000000000007A7A7A009999
      990052915900999A99009B9B9B009C9C9C009C9C9C006C9AD000A7CEE5008FC1
      DF0089BDDC008BBDDC00538DB6005A8EC2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FBF1E900F3D4
      BB00F7EADF00EEDED000E3C1A700D8AE8900D7AC8600DDBB9C00EBD6C700F3E6
      D900E4C1A300F5E9DF0000000000000000000000000000000000F1DDC500D192
      4F00D9B28C00E6CDB800E0BA9D00D7AB8500D6A98200D9B39100E1C2AB00D4AE
      8600B4713E00E6D0BD00000000000000000000000000000000007D7D7D009999
      9900999999009A9A9A009A9A9A009B9B9B009B9B9B006F9DD300AAD1E700ABD1
      E70098C7E10091C2DE00568FB7006093C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FCF2
      EA00F6DAC300F9E9DC00F6E8DD00F3E5DA00F3E5DA00F5E7DC00F5E4D600EDCD
      B400F8ECE300000000000000000000000000000000000000000000000000F2DD
      C600D69C5B00D0A06A00E0BFA000E3C5AE00E3C5AE00DFBC9F00C8976200C38A
      4900E9D5BD000000000000000000000000000000000000000000808080007E7E
      7E007C7C7C007A7A7A00777777007575750072727200719ED4006F9ED60087B2
      DC00ABD3E800A9D0E6005890B8006797CB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFAF700FCEDE100F8DEC900F6D9C100F5D7BF00F5D9C300F8E8DC00FDF8
      F500000000000000000000000000000000000000000000000000000000000000
      0000FAF1E700EACCA800D8A16500CF914E00CD904A00D19B5B00E4C6A100F7EF
      E400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000084AC
      DC006D9CD40085B1DA005A91B9006D9CCF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B1CAE8006C9CD300709ED2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CD957000BD734200B768
      3500B5683500B4673400B2663400B0653300AE643300AC633200AA623200A961
      3200A8603100A7613200AB693C00BC8661000000000000000000000000000000
      000018435A002B6289004C8ABE0070A9CC00E3EDF50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C37D4F00EBC6AD00EAC5AD00FEFB
      F800FEFBF800FEFBF800FEFBF800FEFBF800FEFBF800FEFBF800FEFBF800FEFB
      F800FEFBF800C89A7C00C7987900AD6B40000000000000000000000000000000
      00002E67850094C7F90091C9F9004185C900276BAE00D8E6F200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A2CAEE0076B2E6003E91
      DB00348CD900348CD900348CD900348CD900348CD900348CD900348CD900348C
      D900348BD900398FDA0085B9E90000000000BA6C3800EDCAB300E0A27A00FEFA
      F70062C0880062C0880062C0880062C0880062C0880062C0880062C0880062C0
      8800FDF9F600CA8D6500C99B7C00A761320000000000DAAF8D00D39C7400D196
      68004389AA00E0F2FF00549AD8001A7ABE004998C5004382B600AB856800C384
      5200C3845200C798730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004799DD00DEF1FA00A8DD
      F4009EDBF40096DAF3008ED8F30086D7F3007FD4F20079D3F20072D2F1006CD0
      F10069CFF100C2EAF8003F95DB0000000000BB6C3800EECCB600E1A27A00FEFA
      F700BFDCC200BFDCC200BFDCC200BFDCC200BFDCC200BFDCC200BFDCC200BFDC
      C200FDF9F600CD906800CC9E8100A861320000000000D7A17500000000000000
      0000A7C5D9007AB6D50090B7D10055C9E4005BDFF50078D0ED00519DDD00E4F0
      FA0000000000C58A5E0000000000000000000000000000000000B07A5800B07A
      5800B07A580000000000DD9BD900DD9BD900DD9BD90000000000B177FF00B177
      FF00B177FF00000000000000000000000000000000003B97DB00EFFAFE00A1E9
      F90091E5F80081E1F70072DEF60063DAF50054D7F40047D3F30039D0F2002ECD
      F10026CBF000CAF2FB003B97DB0000000000BB6B3800EFCEB800E1A27900FEFA
      F70062C0880062C0880062C0880062C0880062C0880062C0880062C0880062C0
      8800FDF9F600CF936A00CEA38400AA61320000000000D9A47A00000000000000
      000000000000B4D7E70076BAD700C2F6FD0063DFF7005DE2F80079D3F0004A99
      DC00E6F1FA00C68C5F0000000000000000000000000000000000B07A5800B07A
      5800B07A580000000000DD9BD900DD9BD900DD9BD90000000000B177FF00B177
      FF00B177FF00000000000000000000000000000000003C9DDB00F2FAFD00B3ED
      FA00A4E9F90095E6F80085E2F70076DEF60065DBF50057D7F40049D4F3003BD1
      F20030CEF100CCF2FB003B9BDB0000000000BA6A3600EFD0BB00E2A27A00FEFB
      F800FEFBF800FEFBF800FEFBF800FEFBF800FEFBF800FEFBF800FEFBF800FEFB
      F800FEFBF800D3966D00D2A78A00AB62320000000000DDA87E00000000000000
      00000000000000000000B7DFEC0077CBE700C7F7FD005EDCF5005AE1F7007BD4
      F1004C9ADE00A98A750000000000000000000000000000000000B07A5800B07A
      5800B07A580000000000DD9BD900DD9BD900DD9BD90000000000B177FF00B177
      FF00B177FF00000000000000000000000000000000003BA3DB00F6FCFE00C8F2
      FC00B9EFFB00ACECFA009CE8F9008BE3F7007CE0F6006CDCF6005DD9F5004FD6
      F40044D3F300D0F3FC003BA2DB0000000000BB6A3600F0D2BE00E2A37A00E2A3
      7A00E1A37A00E2A37B00E1A37B00E0A17800DE9F7700DD9F7600DC9D7400D99B
      7200D8997100D6997000D5AB8E00AD63330000000000E4AF8700000000000000
      00000000000000000000000000009898850079D3EE00C7F7FD005FDCF5005BE2
      F7007AD6F2004C97D300DCEAF600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003BA8DB00FEFFFF00F8FD
      FF00F6FDFF00F5FCFF00F3FCFE00D8F6FC0094E6F80085E3F70076DFF60068DB
      F5005CD8F400D7F4FC003BA7DB0000000000BB6A3600F2D5C200E3A37A00E3A3
      7A00E2A37B00E2A37B00E2A47B00E1A27900E0A17800DEA07700DE9E7500DC9D
      7400DA9B7300D99B7300DAB09500AF64330000000000E3B18C00000000000000
      0000000000000000000000000000D69E7600BCE5F2007DD3EE00C4F6FD006CDD
      F6006DCAED0063A3D7006398C700DCEAF6000000000000000000B2EBD000B2EB
      D000B2EBD000000000006DCC50006DCC50006DCC500000000000EBB06000EBB0
      6000EBB060000000000000000000000000000000000039ADDB00E8F6FB0094D4
      EF0088CEEE0073C1E9003F8B450035803B00327C380039823F00F0FCFE00EFFB
      FE00EEFBFE00FEFFFF003CAEDB0000000000BB6A3600F2D8C500E3A47B00E3A3
      7A00E3A47A00E2A47B00E2A37B00E1A37B00E1A27900DFA07700DE9F7600DD9E
      7400DB9C7200DC9D7400DDB59A00B165340000000000E5B48F00E3B69800E1AF
      8B00DEAD8800DEAB8500DCA88100D8A27900D7A07600A0A18F007DD2ED00B2E3
      F9008BC0E700AED3F600C4E0FC00699DCF000000000000000000B2EBD000B2EB
      D000B2EBD000000000006DCC50006DCC50006DCC500000000000EBB06000EBB0
      6000EBB060000000000000000000000000000000000040AEDC00F1FAFD0094DE
      F50093DCF40081D5F2004A9550007EC383007DC283004A9250007AD0EF0076CF
      EE0072CFEE00E9F7FB003EB2DC0000000000BB6B3600F4D9C700E6A67D00C88C
      6400C98D6500C98E6700CB926C00CB926D00CA906900C88C6500C88C6400C88C
      6400C88C6400DA9C7400E1BA9F00B366340000000000E7B79400000000000000
      0000000000000000000000000000DAA57E000000000000000000C1EBF70077BE
      E700B4D2F000E5F3FF00ACD2EF005590C4000000000000000000B2EBD000B2EB
      D000B2EBD000000000006DCC50006DCC50006DCC500000000000EBB06000EBB0
      6000EBB060000000000000000000000000000000000041B4DC00F7FCFE008EE4
      F80091DEF5009FE0F5005CAA640087CC8E0086CB8E005DA76400F1FCFE00EFFB
      FE00EEFBFE00FAFDFF0058BCE00000000000BB6C3700F4DCC900E7A77D00F9EC
      E100F9ECE100F9EDE300FCF4EE00FDFAF700FDF7F300FAEDE500F7E7DB00F7E5
      D900F6E5D800DEA07700E4BEA400B467340000000000E9BA9800000000000000
      0000000000000000000000000000DCA88300000000000000000000000000BAE4
      F30058A5D80085B1DB00469DD00080BFE3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003CB5DB00FDFEFE00FEFF
      FF00FEFEFF00FDFEFF006DBB760090D59A008FD49A006DBA77006FC9E4006FC9
      E4007DCFE70084D0E800BAE5F20000000000BD6E3A00F5DDCC00E7A87E00FAF0
      E800FAF0E800C98D6600FAF0E900FDF8F300FEFAF800FCF4EF00F9E9DF00F7E7
      DB00F7E5D900E0A27800E7C2A900B668350000000000EBBD9B00000000000000
      0000000000000000000000000000DEAC86000000000000000000000000000000
      000000000000D1976A00000000000000000000000000000000006B6FFE006B6F
      FE006B6FFE000000000073AAFF0073AAFF0073AAFF000000000067D5F00067D5
      F00067D5F0000000000000000000000000000000000059C2E00061C3E20063C4
      E30063C08E0061BD70007CCA860099DDA50098DDA40076C581005AAF63007DBE
      8600F3FAFD00F3FBFD00FCFEFE0000000000C0744200F6DFD000E8A87E00FCF6
      F100FCF6F100C88C6400FAF1E900FBF4EE00FDFAF700FDF9F600FAF0E800F8E8
      DD00F7E6DB00E1A37A00EFD5C300B76A360000000000ECBF9E00000000000000
      0000000000000000000000000000E0AE89000000000000000000000000000000
      000000000000D49B6F00000000000000000000000000000000006B6FFE006B6F
      FE006B6FFE000000000073AAFF0073AAFF0073AAFF000000000067D5F00067D5
      F00067D5F0000000000000000000000000000000000000000000000000000000
      0000FBFEFC007AC984007ACC86009DE0AA009CDFA80074C5800070BB7800FBFD
      FB0000000000000000000000000000000000C6825500F6DFD100E9AA8000FEFA
      F600FDFAF600C88C6400FBF3EE00FBF1EA00FCF6F200FEFBF800FCF6F100F9EC
      E200F8E7DB00EED0BA00ECD0BD00BD74430000000000EEC4A700000000000000
      0000000000000000000000000000E3B494000000000000000000000000000000
      000000000000D8A27700000000000000000000000000000000006B6FFE006B6F
      FE006B6FFE000000000073AAFF0073AAFF0073AAFF000000000067D5F00067D5
      F00067D5F0000000000000000000000000000000000000000000000000000000
      0000000000000000000080CC8A007BCC860079CA85007AC48300000000000000
      000000000000000000000000000000000000D6A58500F6E0D100F7E0D100FEFB
      F800FEFBF700FDF9F600FCF5F000FAF0EA00FBF2ED00FDF9F600FDFAF700FBF1
      EB00F8E9DF00ECD1BE00CD926A00E2C5B10000000000F2DCCD00EFC6AA00EDC0
      9F00EBBE9D00EBBC9A00E9BA9600E6B59000E4B28C00E2AF8800E0AC8400DDA9
      8000DCA57D00DDB1910000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000087CF900083CC8C0000000000000000000000
      000000000000000000000000000000000000E1BDA600D9AB8D00C9895E00C075
      4300BD6E3A00BB6C3700BB6B3600BB6A3600BB6A3600BC6C3900BD6E3B00BB6D
      3A00BF744400C98D6500E7CEBC00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFF800000F00FF00F00000000
      E007E007C0000000C003C003C000000080018001C00000008001800100000000
      8001800100000000800180010000000080018101000000008001800100000000
      80018001C000000080018001C0000000C003C003C0000000E007E007C0000000
      F00FF00FFFE00000FFFFFFFFFFF80000FFFF8000F07FFFFFFFFF0000F03FFFFF
      800100008003FFFF80010000B00BC44780010000B803C44780010000BC03C447
      80010000BE01FFFF80010000BE00C447800100008000C44780010000BEC0C447
      80010000BEE0FFFF80010000BEFBC44780010000BEFBC447F00F0000BEFBC447
      FC3F00008003FFFFFE7F0000FFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object Actions: TActionList
    Images = Images
    Left = 40
    Top = 72
    object OpenAction: TAction
      Caption = 'Open...'
      ImageIndex = 0
      ShortCut = 16463
      OnExecute = OpenActionExecute
    end
    object SaveAction: TAction
      Caption = 'Save...'
      ImageIndex = 1
      ShortCut = 16467
      OnExecute = SaveActionExecute
    end
    object RulesAction: TAction
      Caption = 'Rules...'
      ImageIndex = 2
      ShortCut = 16466
      OnExecute = RulesActionExecute
    end
    object ColourSchemesAction: TAction
      Caption = 'Colours...'
      ImageIndex = 3
      ShortCut = 16460
      OnExecute = ColourSchemesActionExecute
    end
    object HelpAction: TAction
      Caption = 'Help'
      ImageIndex = 4
      ShortCut = 112
      OnExecute = HelpActionExecute
    end
    object AboutAction: TAction
      Caption = 'About...'
      ImageIndex = 5
      OnExecute = AboutActionExecute
    end
    object ExitAction: TAction
      Caption = 'Exit'
      ImageIndex = 6
      OnExecute = ExitActionExecute
    end
  end
end
