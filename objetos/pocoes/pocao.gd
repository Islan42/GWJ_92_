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
	
func levantar():
	colisao.disabled = true
func largar():
	colisao.disabled = false
func depositar():
	colisao.disabled = true
	sprite.visible = false
