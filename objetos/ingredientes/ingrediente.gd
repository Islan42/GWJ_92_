extends Area2D
class_name Ingrediente

@export var nome : String

func _ready():
	add_to_group("carregavel")
