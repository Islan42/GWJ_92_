extends EfeitoPocao
class_name EfeitoFogo

@export var fator_forca : int = 0
@export var fator_tempo : int = 15

func ativar_efeito_primario(heroi : Heroi, scene_tree : SceneTree):
	heroi.atributos.ganhar_forca(fator_forca)
	scene_tree.create_timer(fator_tempo).timeout.connect(func(): 
		if is_instance_valid(heroi):
			heroi.atributos.ganhar_forca(-1 * fator_forca)
	)
