extends Ingrediente
class_name Fruta

@onready var sprite : Sprite2D = $Sprite2D
@onready var colisao : CollisionShape2D = $CollisionShape2D

var tipos_frutas : Array = ["Orangine", "Purplezite", "Greenet", "Redarang_2"]

func setup(tipo_fruta:String = "random"):
	if tipo_fruta == "random":
		nome = tipos_frutas.pick_random()
	else:
		nome = tipo_fruta
	sprite.texture = load("res://objetos/ingredientes/%s.png" % [nome.to_lower()])

func levantar():
	colisao.disabled = true
func largar():
	colisao.disabled = false

