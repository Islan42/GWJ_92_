extends Area2D
class_name Pocao

@export var levantavel : bool = true

@onready var colisao : CollisionShape2D = $CollisionShape2D
@onready var sprite : Sprite2D = $Sprite2D

var nome
var tipos_pocao : Dictionary = {
	"Poção de Cura": ["Curar", "Nada", "POCAO_CURA"],
	"Poção de Mana": ["Restaurar mana", "Nada", "POCAO_MANA"],
	"Poção do Vento": ["Aumenta a velocidade de movimento", "Inimigos ficam lentos", "POCAO_VENTO"],
	"Poção do Fogo": ["Aumenta o dano em 1.5", "Explode", "POCAO_FOGO"],
	"Poção do Fogo Fogo": ["Aumenta o dano em 2.0 e projétil explode", "Pega fogo na área", "POCAO_FOGO_FOGO"]
}

enum sprites_pocoes {POCAO_CURA, POCAO_MANA, POCAO_VENTO, POCAO_FOGO, POCAO_FOGO_FOGO}

func _ready():
	add_to_group("carregavel")

func setup(nome_pocao:String = "random"):
	if nome_pocao == "random":
		var chaves = tipos_pocao.keys()
		var rng = randi_range(0, chaves.size-1)
		nome = chaves[rng]
	else:
		nome = nome_pocao
	sprite.frame = sprites_pocoes[tipos_pocao[nome][2]] 

func ativar_efeito_primario(heroi : Heroi):
	match nome:
		"Poção de Cura":
			heroi.curar(2)
		"Poção de Mana":
			heroi.recuperar_mana(2)
		"Poção do Vento":
			heroi.velocidade += 2
			get_tree().create_timer(20).timeout.connect(func(): 
				if is_instance_valid(heroi):
					heroi.velocidade -= 2
					print("passou")
			)
		"Poção do Fogo":
			heroi.ataque += 1
			get_tree().create_timer(15).timeout.connect(func(): 
				if is_instance_valid(heroi):
					heroi.ataque -= 1
			)
		"Poção do Fogo Fogo":
			heroi["ataque"] += 2
			get_tree().create_timer(20).timeout.connect(func(): 
				if is_instance_valid(heroi):
					heroi.ataque -= 2
			)
	call_deferred("queue_free")

func ativar_efeito_secundario():
	pass

func levantar():
	colisao.disabled = true
func largar():
	colisao.disabled = false
func depositar():
	colisao.disabled = true
	sprite.visible = false
