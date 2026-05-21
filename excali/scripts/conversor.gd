extends Node2D

var velocidad : int
var spawnrate : float
var tamañobarra
var daño : int
var parry : float
var freezetimebarra #Provisional, testear, puede ir anexado a la velocidad
@onready var script_filo = load("res://scripts/filo_equipado.gd")
@onready var script_mango = load("res://scripts/mango_equipado.gd")
@onready var Espata = $"/root/mundo/Espata" 

func _ready() -> void:
	if script_filo and script_mango:
		var filo = script_filo.new()
		var mango = script_mango.new()
		
		velocidad = (filo.velocidad + mango.velocidad) * 2
		spawnrate = (1.5 - (filo.spawnrate + mango.spawnrate)*0.15)
		#tamañobarra = (filo.tamañobarra + mango.tamañobarra)*5
		daño = (filo.daño + mango.daño)*2
		parry = (filo.parry + mango.parry)*0.2
		
		Espata.setEstadisticas()
		# Si terminamos poniendo tipos de filos, seria hacer otra variable
		# llamada "tipo" que diga si es espada, mandoble, daga...
		#entonces seria poner las variables iniciales dentro de ifs de si es espada o no y etc.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
