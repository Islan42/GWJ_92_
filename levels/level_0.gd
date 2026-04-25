extends Node2D

signal instanciar_fruta(nome, posicao)
signal instanciar_pocao(pocao, posicao)
signal chamar_mensageiro(new_buffer : Array[String])
signal inimigo_morreu(being : Area2D)
signal chamar_proxima_fase

@export var msg_buffers : Array[MsgBufferRes]

func _ready():
	chamar_mensageiro.emit(msg_buffers[0].buffer)
	
	for planta : Planta in $Plantas.get_children():
		planta.instanciar_fruta.connect(on_planta_instanciar_fruta)
	
	for caldeirao : Caldeirao in $Caldeiroes.get_children():
		caldeirao.instanciar_pocao.connect(on_caldeirao_instanciar_pocao)
	
	for inimigo in $Inimigos.get_children():
		inimigo.morreu.connect(func (being : Area2D):
			inimigo_morreu.emit(being)
		)

func _on_area_1_area_entered(area):
	chamar_mensageiro.emit(msg_buffers[1].buffer)


func _on_area_2_area_entered(area):
	chamar_mensageiro.emit(msg_buffers[2].buffer)


func _on_timer_textos_timeout():
	pass


func _on_area_3_area_entered(area):
	chamar_mensageiro.emit(msg_buffers[3].buffer)


func _on_area_4_area_entered(area):
	chamar_proxima_fase.emit()
	
func on_planta_instanciar_fruta(nome_fruta, posicao):
	instanciar_fruta.emit(nome_fruta, posicao)

func on_caldeirao_instanciar_pocao(pocao, posicao):
	instanciar_pocao.emit(pocao, posicao)
