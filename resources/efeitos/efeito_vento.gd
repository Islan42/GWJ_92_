extends EfeitoPocao
class_name EfeitoVento

@export var fator_velocidade : int = 0
@export var fator_tempo : int = 20

func ativar_efeito_primario(heroi : Heroi, scene_tree : SceneTree):
	heroi.atributos.ganhar_velocidade(fator_velocidade)
	scene_tree.create_timer(fator_tempo).timeout.connect(func(): 
		if is_instance_valid(heroi):
			heroi.atributos.ganhar_velocidade(-1 * fator_velocidade)
			print("passou")
	)
