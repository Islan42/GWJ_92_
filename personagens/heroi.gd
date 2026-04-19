extends Area2D
class_name Heroi

@export var velocidade : float = 4
@export var hp : int = 5

@onready var animacao : AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast : RayCast2D = $RayCast2D
@onready var area_ataque : Area2D = $AreaAtaque
@onready var colisao_area_ataque : CollisionShape2D = $AreaAtaque/CollisionShape2D

var direcao : Vector2
var posicao_alvo : Vector2
var direcao_olhar : Vector2
var agindo : bool = false
var tempo_parado : float = 0
var carregando_objeto : bool = false
var objeto_carregado : Object

func _ready():
	position = Vector2(32,32)
	posicao_alvo = position
	direcao_olhar = Vector2.RIGHT
	raycast.target_position = Vector2.RIGHT * 64
	colisao_area_ataque.disabled = true
	#animacao.play("normal_idle_frente")

func _process(delta):
	if position.is_equal_approx(posicao_alvo):
		calcular_acao()
		calcular_movimento()
	else:
		position = position.move_toward(posicao_alvo, 64 * velocidade * delta)
	animar()

func calcular_acao():
	var objeto = null
	raycast.force_raycast_update()
	if raycast.is_colliding():
		objeto = raycast.get_collider()
		
	if not agindo:
		if Input.is_action_just_pressed("acao"):
			if not carregando_objeto:
				agindo = true
				colisao_area_ataque.disabled = false
			elif objeto is Caldeirao:
				objeto.add_ingrediente(objeto_carregado)
				remove_child(objeto_carregado)
				objeto.add_child(objeto_carregado)
				
				objeto_carregado.depositar()
				carregando_objeto = false
				objeto_carregado = null
		elif Input.is_action_just_pressed("carregar_item"):
			if objeto is Planta: # SE DER TEMPO, TIRAR QUANDO ADICIONAR O ATAQUE
				objeto.colher()
			if carregando_objeto:
				largar_item()
			elif objeto and objeto.is_in_group("carregavel"):
				carregando_objeto = true
				objeto.levantar()
				objeto.get_parent().remove_child(objeto)
				add_child(objeto)
				objeto.position = Vector2(0,-64)
				objeto_carregado = objeto

func calcular_movimento():
	raycast.force_raycast_update()
	direcao = Vector2.ZERO
	if not agindo:
		# is action just pressed + buffer
		if Input.is_action_pressed("mover_esquerda"):
			direcao = Vector2.LEFT
			area_ataque.rotation = 3*PI/2
		elif Input.is_action_pressed("mover_direita"):
			direcao = Vector2.RIGHT
			area_ataque.rotation = PI/2
		elif Input.is_action_pressed("mover_cima"):
			direcao = Vector2.UP
			area_ataque.rotation = 0
		elif Input.is_action_pressed("mover_baixo"):
			direcao = Vector2.DOWN
			area_ataque.rotation = PI
	if direcao != Vector2.ZERO:
		#print(raycast.is_colliding())
		if direcao == direcao_olhar and not raycast.is_colliding():
			posicao_alvo += direcao * 64
		else:
			#print(direcao_olhar)
			direcao_olhar = direcao
			raycast.target_position = direcao_olhar * 64
			raycast.force_raycast_update()

func animar():
	var nome_animacao : String = ""
	animacao.flip_h = false
	
	if agindo:
		nome_animacao = "ataque_"
	else:
		if carregando_objeto:
			nome_animacao = "carregar_"
		else:
			nome_animacao = "normal_"
		
		if position.is_equal_approx(posicao_alvo):
			tempo_parado += get_process_delta_time()
			if tempo_parado > 0.1:
				nome_animacao += "idle_"
		else:
			tempo_parado = 0
			nome_animacao += "andar_"
		
	match direcao_olhar:
		Vector2(0,1):
			nome_animacao += "frente"
		Vector2(0,-1):
			nome_animacao += "costas"
		Vector2(1,0):
			nome_animacao += "lado"
			animacao.flip_h = false
		Vector2(-1,0):
			nome_animacao += "lado"
			animacao.flip_h = true
	if animacao.animation != nome_animacao:
		animacao.play(nome_animacao)

func largar_item():
	if not raycast.is_colliding():
		carregando_objeto = false
		remove_child(objeto_carregado)
		get_tree().current_scene.add_child(objeto_carregado)
		objeto_carregado.global_position = raycast.global_position + raycast.target_position
		objeto_carregado.largar()
		objeto_carregado = null

func tomar_dano():
	hp -= 1
	print(hp)

func _on_animated_sprite_2d_animation_finished():
	if animacao.animation.contains("ataque"):
		agindo = false
		colisao_area_ataque.disabled = true

func _on_area_ataque_area_entered(area):
	if area.has_method("colher"):
		area.colher()
	elif area.has_method("tomar_dano"):
		area.tomar_dano()
