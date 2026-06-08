extends Node2D


var velocidad : int = 2 + 10
var spawnrate : float = 2
var tamañobarra 
var daño : int = 3
var parry : float = 2

var freezetimebarra #Provisional, testear, puede ir anexado a la velocidad

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	# Si terminamos poniendo tipos de filos, seria hacer otra variable
	# llamada "tipo" que diga si es espada, mandoble, daga...
	#entonces seria poner las variables iniciales dentro de ifs de si es espada o no y etc.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
