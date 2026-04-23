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
	match pocao_res.nome:
		"Poção de Cura":
			heroi.curar(2)
		"Poção de Mana":
			heroi.recuperar_mana(2)
		"Poção do Vento":
			heroi.atributos.ganhar_velocidade(2)
			get_tree().create_timer(20).timeout.connect(func(): 
				if is_instance_valid(heroi):
					heroi.atributos.ganhar_velocidade(-2)
					print("passou")
			)
		"Poção do Fogo":
			heroi.atributos.ganhar_forca(1)
			get_tree().create_timer(15).timeout.connect(func(): 
				if is_instance_valid(heroi):
					heroi.atributos.ganhar_forca(-1)
			)
		"Poção do Fogo Fogo":
			heroi.atributos.ganhar_forca(2)
			get_tree().create_timer(20).timeout.connect(func(): 
				if is_instance_valid(heroi):
					heroi.atributos.ganhar_forca(-2)
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
