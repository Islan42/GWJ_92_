extends Control

enum indice_lista_ingredientes {ORANGINE, PURPLEZITE, GREENET, RED_JANE, POÇÃO_DE_CURA, POÇÃO_DE_MANA, POÇÃO_DO_VENTO, POÇÃO_DO_FOGO,
	POÇÃO_DO_FOGO_FOGO
}


@onready var container : HBoxContainer = $HBoxContainer
@onready var ingredientes_retratos : CompressedTexture2D = load("res://gui/ingredientes.png")

@onready var slot_0 : Control = $HBoxContainer/Slot0
@onready var slot_1 : Control = $HBoxContainer/Slot1
@onready var slot_2 : Control = $HBoxContainer/Slot2
@onready var slot_3 : Control = $HBoxContainer/Slot3
@onready var slot_4 : Control = $HBoxContainer/Slot4

var mapeamento_slots : Dictionary

func _ready():
	slot_0.visible = false
	slot_1.visible = false
	slot_2.visible = false
	slot_3.visible = false
	slot_4.visible = false
	
	mapeamento_slots = {
		slot_0 : {"ocupado" : false, "textura" : $HBoxContainer/Slot0/slot_0_textura},
		slot_1 : {"ocupado" : false, "textura" : $HBoxContainer/Slot1/slot_1_textura},
		slot_2 : {"ocupado" : false, "textura" : $HBoxContainer/Slot2/slot_2_textura},
		slot_3 : {"ocupado" : false, "textura" : $HBoxContainer/Slot3/slot_3_textura},
		slot_4 : {"ocupado" : false, "textura" : $HBoxContainer/Slot4/slot_4_textura}
	}

func adicionar_item(nome_ingrediente : String):
	nome_ingrediente = nome_ingrediente.to_snake_case().to_upper()
	
	var atlas_texture = AtlasTexture.new()
	var regiao = indice_lista_ingredientes[nome_ingrediente] * 16
	atlas_texture.atlas = ingredientes_retratos
	atlas_texture.region = Rect2(regiao, 0, 16,16)
	
	for slot in mapeamento_slots:
		var dicionario = mapeamento_slots[slot]
		if not dicionario["ocupado"]:
			dicionario["textura"].texture = atlas_texture
			dicionario["ocupado"] = true
			slot.visible = true
			break

func esvaziar_ui():
	for slot in mapeamento_slots:
		var dicionario = mapeamento_slots[slot]
		slot.visible = false
		dicionario["ocupado"] = false
		
