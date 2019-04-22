object panel_propiedades: Tpanel_propiedades
  Left = 364
  Height = 203
  Top = 185
  Width = 185
  Caption = 'Propiedades'
  ClientHeight = 203
  ClientWidth = 185
  LCLVersion = '6.7'
  object texto_nombre: TLabel
    Left = 25
    Height = 15
    Top = 27
    Width = 44
    Caption = 'Nombre'
    ParentColor = False
  end
  object nombre_figura: TEdit
    Left = 80
    Height = 23
    Top = 24
    Width = 80
    OnChange = nombre_figuraChange
    TabOrder = 0
  end
  object texto_tipo: TLabel
    Left = 25
    Height = 15
    Top = 72
    Width = 24
    Caption = 'Tipo'
    ParentColor = False
  end
  object texto_color: TLabel
    Left = 25
    Height = 15
    Top = 112
    Width = 29
    Caption = 'Color'
    ParentColor = False
  end
  object tipo_figura: TLabel
    Left = 80
    Height = 15
    Top = 72
    Width = 7
    Caption = '#'
    ParentColor = False
  end
  object color_figura: TColorButton
    Left = 80
    Height = 25
    Top = 112
    Width = 34
    BorderWidth = 2
    ButtonColorSize = 16
    ButtonColor = clBlack
    OnColorChanged = color_figuraColorChanged
  end
  object boton_ok: TButton
    Left = 12
    Height = 25
    Top = 160
    Width = 44
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 1
  end
  object boton_cancel: TButton
    Left = 96
    Height = 25
    Top = 160
    Width = 75
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 2
  end
end
