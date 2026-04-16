extends Ingrediente
class_name Fruta

enum sprites_frutas {
	GREENET,
	ORANGINE,
	PURPLEZITE,
	REDJAN,
	REDJAN2
}

@onready var sprite : Sprite2D = $Sprite2D
@onready var colisao : CollisionShape2D = $CollisionShape2D

var tipos_frutas : Array = ["Orangine", "Purplezite", "Greenet", "Redjan2"]

func setup(tipo_fruta:String = "random"):
	if tipo_fruta == "random":
		nome = tipos_frutas.pick_random()
	else:
		nome = tipo_fruta
	sprite.frame = sprites_frutas[nome.to_upper()]

func levantar():
	colisao.disabled = true
func largar():
	colisao.disabled = false

