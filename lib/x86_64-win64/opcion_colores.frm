object opColores: TopColores
  Left = 316
  Height = 240
  Top = 174
  Width = 320
  Caption = 'Colores'
  ClientHeight = 240
  ClientWidth = 320
  OnCreate = FormCreate
  LCLVersion = '6.7'
  object a_: TLabel
    Left = 56
    Height = 15
    Top = 32
    Width = 8
    Caption = 'A'
    ParentColor = False
  end
  object e_: TLabel
    Left = 208
    Height = 15
    Top = 32
    Width = 6
    Caption = 'E'
    ParentColor = False
  end
  object i_: TLabel
    Left = 61
    Height = 15
    Top = 104
    Width = 3
    Caption = 'I'
    ParentColor = False
  end
  object o_: TLabel
    Left = 208
    Height = 15
    Top = 104
    Width = 9
    Caption = 'O'
    ParentColor = False
  end
  object u_: TLabel
    Left = 136
    Height = 15
    Top = 152
    Width = 8
    Caption = 'U'
    ParentColor = False
  end
  object color_a: TColorButton
    Left = 80
    Height = 25
    Top = 24
    Width = 27
    BorderWidth = 2
    ButtonColorSize = 16
    ButtonColor = clBlack
    OnColorChanged = color_aColorChanged
  end
  object color_i: TColorButton
    Left = 80
    Height = 25
    Top = 94
    Width = 27
    BorderWidth = 2
    ButtonColorSize = 16
    ButtonColor = clBlack
    OnColorChanged = color_iColorChanged
  end
  object color_e: TColorButton
    Left = 232
    Height = 25
    Top = 24
    Width = 27
    BorderWidth = 2
    ButtonColorSize = 16
    ButtonColor = clBlack
    OnColorChanged = color_eColorChanged
  end
  object color_o: TColorButton
    Left = 232
    Height = 25
    Top = 96
    Width = 27
    BorderWidth = 2
    ButtonColorSize = 16
    ButtonColor = clBlack
    OnColorChanged = color_oColorChanged
  end
  object color_u: TColorButton
    Left = 160
    Height = 25
    Top = 144
    Width = 27
    BorderWidth = 2
    ButtonColorSize = 16
    ButtonColor = clBlack
    OnColorChanged = color_uColorChanged
  end
  object boton_ok: TBitBtn
    Left = 48
    Height = 30
    Top = 200
    Width = 75
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object boton_cancelar: TBitBtn
    Left = 224
    Height = 30
    Top = 202
    Width = 75
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 1
  end
end
