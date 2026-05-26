extends Node
var velocidad : int = 2
var spawnrate : int = 2
var tamañobarra 
var daño : int  = 3
var parry : int  = 2
var stats_1 : String


@onready var Enemy: Node2D = $"/root/mundo/Enemy"
@onready var statsRandom: Array = ["velocidad", "spawnrate", "daño", "parry"]
func _ready() -> void:
	randomize()

func _process(_delta: float) -> void:
	pass

func DropeandoFilos():
	for i in range(3):
		stats_1 = statsRandom.pick_random() 
		print("--- Intento ", i+1, " ---")
		print("Se seleccionó mejorar: ", stats_1)
		actualizar()
		imprimir_valor_actual()

func actualizar():
	if stats_1 == "velocidad":
		velocidad +=1 
	elif stats_1 == "daño":
		daño +=1 
	elif stats_1 == "spawnrate":
		spawnrate +=1 
	elif stats_1 == "parry":
		parry +=1 	

func imprimir_valor_actual():
	if stats_1 == "velocidad":
		print("Valor de velocidad: ", velocidad)
	elif stats_1 == "daño":
		print("Valor de daño: ", daño)
	elif stats_1 == "spawnrate":
		print("Valor de spawnrate: ", spawnrate)
	elif stats_1 == "parry":
		print("Valor de parry: ", parry)
