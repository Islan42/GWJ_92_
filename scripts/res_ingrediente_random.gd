extends Ingrediente_Res
class_name Ingrediente_Res_Random

@export var opcoes : Array[Ingrediente_Res]

func pick_random() -> Ingrediente_Res:
	return opcoes.pick_random()
