extends Resource
class_name Pocao_Res

@export var nome : String
@export var receita : Receita
@export var ui_sprite : AtlasTexture
@export var res_efeito : EfeitoPocao

func ativar_efeito_primario(heroi : Heroi, scene_tree : SceneTree):
	res_efeito.ativar_efeito_primario(heroi, scene_tree)

func ativar_efeito_secundario():
	pass
