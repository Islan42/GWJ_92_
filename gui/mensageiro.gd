extends Control

@export var to_loop : bool = false
@export var delay : float = 5.0

@onready var label : RichTextLabel = %RichTextLabel

var last_acumulo : float = 0
var acumulo : float = 0
var indice_atual : int = -1
var msg_atual : String = ""
var msg_buffer : Array[String] = []

func _ready():
	reset_buffer()
	add_buffer(["ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz", "0123456789101112131415161718192021222324252627282930"])
	next_msg()

func _process(delta):
	if acumulo < msg_atual.length():
		last_acumulo = acumulo
		acumulo += 12 * delta
		#print(acumulo)
	elif last_acumulo < acumulo:
		last_acumulo = acumulo
		#print("A")
		get_tree().create_timer(delay).timeout.connect(next_msg)
	label.visible_characters = acumulo

func reset_buffer():
	msg_buffer.clear()
	indice_atual = -1

func add_buffer(new_array : Array[String]):
	msg_buffer.append_array(new_array)

func next_msg():
	if indice_atual < msg_buffer.size() - 1:
		indice_atual += 1
	elif to_loop:
		indice_atual = 0
	else:
		return
	acumulo = 0
	label.visible_characters = acumulo
	msg_atual = msg_buffer[indice_atual]
	label.text = msg_atual
