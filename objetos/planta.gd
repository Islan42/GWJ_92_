extends Area2D
class_name Planta

@export var cooldown : float = 10.0
@export var tipo_frutos : String = "random"

signal instanciar_fruta(nome, posicao)

@onready var sprite : Sprite2D = $Sprite2D
@onready var colisao : CollisionShape2D = $CollisionShape2D
@onready var cooldown_timer : Timer = $Cooldown

func colher():
	if not colisao.disabled:
		colisao.set_deferred("disabled", true)
		sprite.modulate = Color("ffffff", 0.3) #Mudar SpriteAnimado para o original
		cooldown_timer.start(cooldown)
		
		instanciar_fruta.emit(tipo_frutos,global_position)

func _on_cooldown_timeout():
	colisao.disabled = false
	sprite.modulate = Color("ffffff", 1.0)#Mudar SpriteAnimado para o original
