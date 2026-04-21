extends Control

@export var pocoes : Pocao_Res_Lista

@onready var label : Label = $Label

var texto = ""

func _unhandled_input(event):
	if event.is_action_released("ui_mostrar_receitas"):
		alternar_visibilidade()

func alternar_visibilidade():
	visible = !visible
	
	if visible:
		texto = ""
		for pocao in pocoes.lista:
			texto += pocao.nome + ": "
			for item in pocao.receita.ingredientes:
				texto += item.nome + " - "
			texto += String.num(pocao.receita.tempo_preparo) + " sec"
			texto += "\n"
		label.text = texto
