extends Node2D

var velocidad : int = 2
var spawnrate : float = 2
var tamañobarra = 3
var daño : int = 3
var parry : float = 2
var freezetimebarra #Provisional, testear, puede ir anexado a la velocidad

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocidad = 2
	spawnrate = 2
	tamañobarra = 3
	daño = 3
	parry = 2


func set_estadisticas() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
