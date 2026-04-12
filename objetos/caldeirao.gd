extends Area2D
class_name Caldeirao

var receitas : Dictionary = {
	"Receita 1": {"ingredientes": ["Orangine", "Orangine", "Purplezite"], "tempo": 15},
	"Receita 2": {"ingredientes": ["Orangine", "Purplezite", "Purplezite"], "tempo": 15},
	"Poção de Mana": {"ingredientes": ["Purplezite", "Purplezite"], "tempo": 10},
	"Poção de Cura": {"ingredientes": ["Orangine", "Orangine"], "tempo": 10}
}

signal instanciar_pocao(nome, posicao)

@onready var tempo_cozimento_timer : Timer = $TempoCozimento
@onready var barra_progresso : ProgressBar = $ProgressBar

var lista_ingredientes : Array
var proxima_pocao : String = ""
var tempo_decorrido : float = 0
var tempo_total : float = 0

func _process(delta):
	if tempo_total != 0 and tempo_decorrido < tempo_total:
		tempo_decorrido += delta
		var valor : float = tempo_decorrido/tempo_total
		barra_progresso.value = 100 * valor

func add_ingrediente(ingrediente : Object):
	lista_ingredientes.append(ingrediente)
	print(lista_ingredientes)
	proxima_pocao = checar_ingredientes()
	preparar_pocao()

#func checar_ingredientes(receitas : Dictionary):
func checar_ingredientes() -> String:
	var proxima_pocao : String = ""
	for receita in receitas:
		var copia_ingredientes_caldeirao : Array = lista_ingredientes.duplicate()
		var copia_ingredientes_receita : Array = receitas[receita]["ingredientes"].duplicate()
		
		for ingrediente_caldeirao in copia_ingredientes_caldeirao:
			if copia_ingredientes_receita.has(ingrediente_caldeirao.nome):
				copia_ingredientes_receita.erase(ingrediente_caldeirao.nome)
		
		if copia_ingredientes_receita.is_empty():
			print("Possui todos os requisitos")
			print(receitas[receita])
			proxima_pocao = receita
			break
	return proxima_pocao

func preparar_pocao():
	if proxima_pocao != "":
		tempo_decorrido = 0
		tempo_total = receitas[proxima_pocao]["tempo"]
		tempo_cozimento_timer.start(tempo_total)
		barra_progresso.visible = true


func _on_tempo_cozimento_timeout():
	instanciar_pocao.emit(proxima_pocao, global_position)
	print("Emitiu sinal")
	tempo_decorrido = 0
	tempo_total = 0
	barra_progresso.value = 0
	barra_progresso.visible = false
	proxima_pocao = ""
	esvaziar_caldeirao()

func esvaziar_caldeirao():
	for item in lista_ingredientes:
		item.call_deferred("queue_free")
	lista_ingredientes = Array()
