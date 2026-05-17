extends Node2D

var velocidad : int
var spawnrate : float
var tamañobarra
var daño : int
var parry : float
var freezetimebarra #Provisional, testear, puede ir anexado a la velocidad

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocidad = 2
	spawnrate = 2
	tamañobarra = 3
	daño = 30
	parry = 2
	# Si terminamos poniendo tipos de filos, seria hacer otra variable
	# llamada "tipo" que diga si es espada, mandoble, daga...
	#entonces seria poner las variables iniciales dentro de ifs de si es espada o no y etc.

func set_estadisticas() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
