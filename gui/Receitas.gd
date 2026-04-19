extends Control

var receitas : Dictionary = {
	"Health Potion": {"ingredientes": ["Orangine", "Orangine"], "tempo": 15},
	"Mana Potion": {"ingredientes": ["Purplezite", "Purplezite"], "tempo": 15},
	"Wind Potion": {"ingredientes": ["Greenet", "Greenet"], "tempo": 15},
	"Fire Potion": {"ingredientes": ["Orangine", "Red Jane"], "tempo": 10},
	"Fire Fire Potion": {"ingredientes": ["Orangine", "Red_Jane", "Red_Jane"], "tempo": 10}
}

@onready var label : Label = $Label

var texto = ""

func _unhandled_input(event):
	if event.is_action_released("ui_mostrar_receitas"):
		alternar_visibilidade()

func alternar_visibilidade():
	visible = !visible
	
	if visible:
		texto = ""
		for receita in receitas:
			texto += receita + ": "
			for item in receitas[receita]["ingredientes"]:
				texto += item + " - "
			texto += "\n"
		label.text = texto
