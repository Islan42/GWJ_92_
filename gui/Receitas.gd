extends Control

@export var pocoes : Pocao_Res_Lista

@onready var label : Label = $MarginContainer/Label


func _unhandled_input(event):
	if event.is_action_released("ui_mostrar_receitas"):
		alternar_visibilidade()

func _ready():
	for pocao in pocoes.lista:
		var new_control = Control.new()
		new_control.custom_minimum_size = Vector2(0,26)
		new_control.size_flags_horizontal = Control.SIZE_FILL
		new_control.size_flags_vertical = Control.SIZE_FILL
		%ListaReceitas.add_child(new_control)
		
		var new_color : ColorRect = ColorRect.new()
		new_color.color = Color(1,1,1,0.5)
		new_color.set_anchors_preset(PRESET_FULL_RECT)
		new_control.add_child(new_color)
		
		var new_hbox : HBoxContainer = HBoxContainer.new()
		new_hbox.set_anchors_preset(PRESET_FULL_RECT)
		new_control.add_child(new_hbox)
		
		var new_pocao_texture = TextureRect.new()
		new_pocao_texture.custom_minimum_size = Vector2(16,0)
		new_pocao_texture.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		new_pocao_texture.texture = pocao.ui_sprite
		new_hbox.add_child(new_pocao_texture)
		
		var new_label = Label.new()
		new_label.size_flags_vertical = Control.SIZE_FILL
		new_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		new_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		new_label.add_theme_font_size_override("font_size", 12)
		new_label.text = "=>"
		new_hbox.add_child(new_label)
		
		for item in pocao.receita.ingredientes:
			var new_texture : TextureRect = TextureRect.new()
			new_texture.custom_minimum_size = Vector2(16,0)
			new_texture.size_flags_vertical = Control.SIZE_SHRINK_CENTER
			new_texture.texture = item.ui_sprite
			new_hbox.add_child(new_texture)
		
		new_label = Label.new()
		new_label.size_flags_vertical = Control.SIZE_FILL
		new_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		new_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		new_label.add_theme_font_size_override("font_size", 12)
		new_label.text = "=>"
		new_hbox.add_child(new_label)
		
		for i in range(pocao.res_efeito.ui_dica):
			var new_texture : TextureRect = TextureRect.new()
			#new_texture.custom_minimum_size = Vector2(16,16)
			#new_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			new_texture.size_flags_vertical = Control.SIZE_SHRINK_CENTER
			new_texture.texture = pocao.res_efeito.ui_sprite
			new_hbox.add_child(new_texture)
		
		if pocao.res_efeito.temporario:
			var new_texture : TextureRect = TextureRect.new()
			new_texture.custom_minimum_size = Vector2(12,12)
			new_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			new_texture.size_flags_vertical = Control.SIZE_SHRINK_CENTER
			
			var new_atlas : AtlasTexture = AtlasTexture.new()
			new_atlas.atlas = preload("res://gui/hud_icons.png")
			new_atlas.region = Rect2(160,0,16,16)
			new_texture.texture = new_atlas
			new_hbox.add_child(new_texture)

func alternar_visibilidade():
	visible = !visible
	
	#if visible:
	#	texto = ""
	#	for pocao in pocoes.lista:
	#		texto += pocao.nome + ": "
	#		for item in pocao.receita.ingredientes:
	#			texto += item.nome + " - "
	#		texto += String.num(pocao.receita.tempo_preparo) + " sec"
	#		texto += "\n"
	#	label.text = texto
