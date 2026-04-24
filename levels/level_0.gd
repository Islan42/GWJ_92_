extends Node2D

signal instanciar_fruta(nome, posicao)
signal instanciar_pocao(pocao, posicao)
signal inimigo_morreu(being : Area2D)
signal chamar_proxima_fase

@onready var label : RichTextLabel = $CanvasLayer/Control/MarginContainer/RichTextLabel
@onready var timer : Timer = $TimerTextos

var texto_atual : int = 0
var textos : Array[String] = ["Welcome to the Tutorial of this game. You can move around using WASD or the ARROW KEYS. Try it out!"]

func _ready():
	label.text = textos[texto_atual]
	label.visible_ratio = 0
	
	for planta : Planta in $Plantas.get_children():
		planta.instanciar_fruta.connect(on_planta_instanciar_fruta)
	
	for caldeirao : Caldeirao in $Caldeiroes.get_children():
		caldeirao.instanciar_pocao.connect(on_caldeirao_instanciar_pocao)
	
	for inimigo in $Inimigos.get_children():
		inimigo.morreu.connect(func (being : Area2D):
			inimigo_morreu.emit(being)
		)

func _process(delta):
	if label.visible_ratio < 1.0:
		label.visible_ratio += delta * 0.25

func _on_area_1_area_entered(area):
	textos.append_array(["Use SPACEBAR next to a bush to harvest it.",
	"Also, use SPACEBAR next to an object to carry it around.",
	"While carrying a fruit you can press LEFT MOUSE BUTTON next to a cauldron do drop it there. When it have the needed ingredients it will automatically start to brew it. You can press R to see the recipes.",
	"Once the cauldron finish brewing it will drop a potion. Carry it an press LEFT MOUSE BUTTON to use it."])
	#texto_atual += 1
	#label.text = textos[texto_atual]
	#label.visible_ratio = 0
	
	#get_tree().create_timer(5).timeout.connect(func():
	#	pass
	#)


func _on_area_2_area_entered(area):
	textos.append("Use LEFT MOUSE BUTTON to land an atack and defeat your foes.")
	#label.visible_ratio = 0


func _on_timer_textos_timeout():
	if texto_atual < textos.size() - 1:
		texto_atual += 1
		label.text = textos[texto_atual]
		label.visible_ratio = 0


func _on_area_3_area_entered(area):
	textos.append("Step ahead and advance to the next level.")


func _on_area_4_area_entered(area):
	chamar_proxima_fase.emit()
	
func on_planta_instanciar_fruta(nome_fruta, posicao):
	instanciar_fruta.emit(nome_fruta, posicao)

func on_caldeirao_instanciar_pocao(pocao, posicao):
	instanciar_pocao.emit(pocao, posicao)
