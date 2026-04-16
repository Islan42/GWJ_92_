extends Area2D
class_name Pocao

@export var levantavel : bool = true

@onready var colisao : CollisionShape2D = $CollisionShape2D
@onready var sprite : Sprite2D = $Sprite2D

var nome
var tipos_pocao : Dictionary = {
	"Poção de Cura": ["Curar", "Nada", "CURA"],
	"Poção de Mana": ["Restaurar mana", "Nada", "MANA"],
	"Poção do Vento": ["Aumenta a velocidade de movimento", "Inimigos ficam lentos", "VENTO"],
	"Poção do Fogo": ["Aumenta o dano em 1.5", "Explode", "FOGO"],
	"Poção do Fogo Fogo": ["Aumenta o dano em 2.0 e projétil explode", "Pega fogo na área", "FOGOFOGO"]
}

enum sprites_pocoes {CURA, MANA, VENTO, FOGO, FOGOFOGO}

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
