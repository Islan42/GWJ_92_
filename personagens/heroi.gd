extends Area2D

@export var velocidade : float = 4

@onready var animacao : AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast : RayCast2D = $RayCast2D

var direcao : Vector2
var posicao_alvo : Vector2
var direcao_olhar : Vector2
var agindo : bool = false
var levantando_objeto : bool = false
var objeto_levantado : Object

func _ready():
	position = Vector2(32,32)
	posicao_alvo = position
	direcao_olhar = Vector2.RIGHT
	raycast.target_position = Vector2.RIGHT * 64

func _process(delta):
	if position.is_equal_approx(posicao_alvo):
		if not agindo:
			if Input.is_action_just_pressed("acao"):
				agindo = true
				animacao.play("acao")
				if raycast.is_colliding():
					var objeto = raycast.get_collider()
					if objeto is Planta:
						objeto.colher()
					elif objeto is Ingrediente and not levantando_objeto:
						levantando_objeto = true
						objeto.levantar()
						objeto.get_parent().remove_child(objeto)
						add_child(objeto)
						objeto.position = Vector2(0,-64)
						objeto_levantado = objeto
					elif objeto is Pocao and not levantando_objeto:
						levantando_objeto = true
						objeto.levantar()
						objeto.get_parent().remove_child(objeto)
						add_child(objeto)
						objeto.position = Vector2(0,-64)
						objeto_levantado = objeto
					elif objeto is Caldeirao and levantando_objeto:
						objeto.add_ingrediente(objeto_levantado)
						remove_child(objeto_levantado)
						objeto.add_child(objeto_levantado)
						levantando_objeto = false
			elif Input.is_action_just_pressed("largar_item") and levantando_objeto:
				largar_item()
				
		
		direcao = Vector2.ZERO
		
		if Input.is_action_pressed("mover_esquerda"):
			direcao = Vector2.LEFT
		elif Input.is_action_pressed("mover_direita"):
			direcao = Vector2.RIGHT
		elif Input.is_action_pressed("mover_cima"):
			direcao = Vector2.UP
		elif Input.is_action_pressed("mover_baixo"):
			direcao = Vector2.DOWN
		
		if direcao != Vector2.ZERO:
			#print(raycast.is_colliding())
			if direcao == direcao_olhar and not raycast.is_colliding():
				posicao_alvo += direcao * 64
			else:
				#print(direcao_olhar)
				direcao_olhar = direcao
				raycast.target_position = direcao_olhar * 64
				raycast.force_raycast_update()
				
				if direcao_olhar.x > 0:
					animacao.rotation = PI/2
				elif direcao_olhar.x < 0:
					animacao.rotation = -1 * PI/2
				elif direcao_olhar.y > 0:
					animacao.rotation = PI
				elif direcao_olhar.y < 0:
					animacao.rotation = 0
		
	else:
		position = position.move_toward(posicao_alvo, 64 * velocidade * delta)
		#print(position, posicao_alvo)

func largar_item():
	if not raycast.is_colliding():
		levantando_objeto = false
		remove_child(objeto_levantado)
		get_tree().current_scene.add_child(objeto_levantado)
		objeto_levantado.global_position = raycast.global_position + raycast.target_position
		objeto_levantado.largar()
		objeto_levantado = null

func _on_animated_sprite_2d_animation_finished():
	if animacao.animation == "acao":
		agindo = false
