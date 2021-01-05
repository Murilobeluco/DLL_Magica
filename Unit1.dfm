object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Form1'
  ClientHeight = 641
  ClientWidth = 564
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 548
    Height = 217
    Proportional = True
  end
  object lblIp: TLabel
    Left = 368
    Top = 282
    Width = 57
    Height = 35
    Caption = 'lblIp'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -29
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object lblHorario: TLabel
    Left = 8
    Top = 282
    Width = 124
    Height = 35
    Caption = 'lblHorario'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -29
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object lblInfo: TLabel
    Left = 8
    Top = 231
    Width = 82
    Height = 35
    Caption = 'lblInfo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -29
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Button1: TButton
    Left = 8
    Top = 320
    Width = 548
    Height = 106
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 432
    Width = 548
    Height = 195
    Lines.Strings = (
      'Memo1')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object IdSNTP1: TIdSNTP
    Active = True
    Host = 'a.ntp.br'
    Port = 123
    Left = 512
    Top = 80
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 368
    Top = 64
  end
  object Timer2: TTimer
    Interval = 20000
    OnTimer = Timer2Timer
    Left = 408
    Top = 136
  end
end
