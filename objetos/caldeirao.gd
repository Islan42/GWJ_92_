extends Area2D
class_name Caldeirao

signal instanciar_pocao(pocao, posicao)

@export var receitas : Array[Receita]
@export var capacidade_total : int = 5

@onready var tempo_cozimento_timer : Timer = $TempoCozimento
@onready var barra_progresso : ProgressBar = $ProgressBar
@onready var ui_caldeirao : Control = $ui_caldeirao

var lista_ingredientes : Array
var proxima_pocao : Receita
var tempo_decorrido : float = 0
var tempo_total : float = 0

func _process(delta):
	if tempo_total != 0 and tempo_decorrido < tempo_total:
		tempo_decorrido += delta
		var valor : float = tempo_decorrido/tempo_total
		barra_progresso.value = 100 * valor

func caldeirao_cheio() -> bool:
	return lista_ingredientes.size() >= capacidade_total

func add_ingrediente(ingrediente : Object):
	if not caldeirao_cheio():
		lista_ingredientes.append(ingrediente)
		#print(lista_ingredientes)
		ui_caldeirao.adicionar_item(ingrediente.nome)
		checar_ingredientes()
		preparar_pocao()

func checar_ingredientes():
	#proxima_pocao = null
	for receita in receitas:
		var copia_ingredientes_caldeirao : Array = lista_ingredientes.duplicate()
		var copia_ingredientes_receita : Array = receita.ingredientes.duplicate()
		
		for ingrediente_caldeirao in copia_ingredientes_caldeirao:
			if copia_ingredientes_receita.has(ingrediente_caldeirao.nome):
				copia_ingredientes_receita.erase(ingrediente_caldeirao.nome)
		
		if copia_ingredientes_receita.is_empty():
			print("Possui todos os requisitos")
			proxima_pocao = receita
			return

func preparar_pocao():
	if proxima_pocao != null:
		tempo_decorrido = 0
		tempo_total = proxima_pocao.tempo_preparo
		tempo_cozimento_timer.start(tempo_total)
		barra_progresso.visible = true

func esvaziar_caldeirao():
	for item in lista_ingredientes:
		item.call_deferred("queue_free")
	lista_ingredientes = Array()
	ui_caldeirao.esvaziar_ui()

func _on_tempo_cozimento_timeout():
	if proxima_pocao != null:
		print(proxima_pocao.nome)
		instanciar_pocao.emit(proxima_pocao, global_position)
		print("Emitiu sinal")
		tempo_decorrido = 0
		tempo_total = 0
		barra_progresso.value = 0
		barra_progresso.visible = false
		proxima_pocao = null
		esvaziar_caldeirao()
