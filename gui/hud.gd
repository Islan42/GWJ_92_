extends Control

@export var atributos_jogador : AtributosPersonagem
@export var ui_atributos : Texture2D

func _ready():
	atualizar_atributos()
	atributos_jogador.alterar_atributos.connect(atualizar_atributos)

func atualizar_atributos():
	for child in %AtributosJogador.get_children():
		child.queue_free()
	
	criar_linha_atributo(atributos_jogador.vida, atributos_jogador.vida_maxima, Rect2(0,0,16,16), Rect2(16,0,16,16))
	criar_linha_atributo(atributos_jogador.forca, atributos_jogador.forca, Rect2(32,0,16,16), Rect2(32,0,16,16))
	criar_linha_atributo(atributos_jogador.mana, atributos_jogador.mana_maxima, Rect2(112,0,16,16), Rect2(128,0,16,16))

func criar_linha_atributo(quantidade : int, maxima : int, regiao1 : Rect2, regiao2 : Rect2):
	var new_hbox : HBoxContainer = HBoxContainer.new()
	
	var new_atlas : AtlasTexture = AtlasTexture.new()
	new_atlas.atlas = ui_atributos
	new_atlas.region = regiao1
	
	var new_atlas2 : AtlasTexture = AtlasTexture.new()
	new_atlas2.atlas = ui_atributos
	new_atlas2.region = regiao2
	
	for i in range(quantidade):
		var new_texture : TextureRect = TextureRect.new()
		new_texture.texture = new_atlas
		new_hbox.add_child(new_texture)
	
	for i in range(maxima - quantidade):
		var new_texture : TextureRect = TextureRect.new()
		new_texture.texture = new_atlas2
		new_hbox.add_child(new_texture)
		
	
	%AtributosJogador.add_child(new_hbox)
