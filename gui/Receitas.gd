extends Control

var receitas : Dictionary = {
	"Receita 1": {"ingredientes": ["Orangine", "Orangine", "Purplezite"], "tempo": 15},
	"Receita 2": {"ingredientes": ["Orangine", "Purplezite", "Purplezite"], "tempo": 15},
	"Poção de Mana": {"ingredientes": ["Purplezite", "Purplezite"], "tempo": 10},
	"Poção de Cura": {"ingredientes": ["Orangine", "Orangine"], "tempo": 10}
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
