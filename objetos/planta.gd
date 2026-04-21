extends Area2D
class_name Planta

@export var cooldown : float = 10.0
@export var drops : Ingrediente_Res
#@export var drops : String = "random"

signal instanciar_fruta(drop, posicao)

@onready var sprite : Sprite2D = $Sprite2D
@onready var colisao : CollisionShape2D = $CollisionShape2D
@onready var cooldown_timer : Timer = $Cooldown

func colher():
	if not colisao.disabled:
		colisao.set_deferred("disabled", true)
		#sprite.modulate = Color("ffffff", 0.3) #Mudar SpriteAnimado para o original
		sprite.frame = 1
		cooldown_timer.start(cooldown)
		
		instanciar_fruta.emit(drops,global_position)

func _on_cooldown_timeout():
	colisao.disabled = false
	#sprite.modulate = Color("ffffff", 1.0)#Mudar SpriteAnimado para o original
	sprite.frame = 0
