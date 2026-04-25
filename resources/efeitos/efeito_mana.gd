extends EfeitoPocao
class_name EfeitoMana

@export var fator_rec : int = 0

func ativar_efeito_primario(heroi : Heroi, scene_tree : SceneTree):
	heroi.recuperar_mana(fator_rec)

func ativar_efeito_secundario():
	pass
