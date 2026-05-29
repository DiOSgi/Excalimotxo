extends Area2D

# --- VARIABLES INICIALES---
var move_direction: int = -1
var moverse: bool = true
var sonido: float

@onready var Espata = $"/root/mundo/Espata"
@onready var Enemy: Node2D = $"/root/mundo/Enemy"
@onready var zona_verde: Area2D = $"../zona_verde"

# --- EMPEZAR ---
func _ready() -> void:
	
	# Posición inicial 
	position = Vector2(0, 249)
	move_direction = -1
	
	set_process_input(true)
	# Activa el movimiento
	moverse = true

func _process(_delta: float) -> void:
	if not moverse:
		return
		
	# SI move == 1 (Mover a la derecha)
	if move_direction == 1:
		if position.x <= 310:
			position.x += Espata.velocidad
		else:
			Espata.ActionPoints = true
			move_direction = -1
			
	# SI move == -1 (Mover a la izquierda)
	elif move_direction == -1:
		if position.x >= -304:
			position.x -= Espata.velocidad
		else:
			Espata.ActionPoints = true
			move_direction = 1

# --- AL PRESIONAR CLICK IZQ ---
func _input(_event: InputEvent) -> void:
	pass

func procesar_ataque():
	moverse = false #convierte can_move en falso
	if await zona_verde.SeTocan():
		Espata.sonido_hit_espada() 
		
		Enemy.recibir_daño(Espata.daño) 
		
		await get_tree().create_timer(0.15).timeout
		moverse = true
		await zona_verde.Ataque_acertado()
		#await get_tree().create_timer(0.15).timeout
	else:
		await get_tree().create_timer(0.15).timeout
		Espata.ActionPoints = false
		moverse = true
