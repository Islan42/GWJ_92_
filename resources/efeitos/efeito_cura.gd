extends EfeitoPocao
class_name EfeitoCura

@export var fator_cura : int = 0

func ativar_efeito_primario(heroi : Heroi, scene_tree : SceneTree):
	heroi.curar(fator_cura)

func ativar_efeito_secundario():
	pass
