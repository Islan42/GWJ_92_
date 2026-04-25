extends Area2D
class_name Pocao

@export var levantavel : bool = true

@onready var colisao : CollisionShape2D = $CollisionShape2D
@onready var sprite : Sprite2D = $Sprite2D

var pocao_res : Pocao_Res

enum sprites_pocoes {POCAO_CURA, POCAO_MANA, POCAO_VENTO, POCAO_FOGO, POCAO_FOGO_FOGO}

func _ready():
	add_to_group("carregavel")

func setup(nova_pocao : Pocao_Res):
	pocao_res = nova_pocao
	sprite.texture = pocao_res.ui_sprite

func ativar_efeito_primario(heroi : Heroi):
	pocao_res.ativar_efeito_primario(heroi, get_tree())
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
