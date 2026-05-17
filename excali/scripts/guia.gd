extends Area2D

# --- VARIABLES INICIALES---
var attack: int = 1
var move_direction: int = -1
var velocidad: float = 3
var can_move: bool = true
var atacando: bool = false 
@onready var enemy = $"../enemy"


# --- EMPEZAR ---
func _ready() -> void:
	# Posición inicial 
	position = Vector2(0, 249)
	attack = 1
	move_direction = -1
	velocidad = 3
	atacando = false
	
	set_process_input(true)
	# Activa el movimiento
	al_recibir_move()


# --- BUCLE DE MOVIMIENTO ---
func al_recibir_move() -> void:
	can_move = true



func _process(delta: float) -> void:
	if not can_move:
		return
		
	# SI move == 1 (Mover a la derecha)
	if move_direction == 1:
		if position.x <= 310:
			position.x += velocidad
		else:
			attack = 1
			move_direction = -1
			
	# SI move == -1 (Mover a la izquierda)
	elif move_direction == -1:
		if position.x >= -304:
			position.x -= velocidad
		else:
			attack = 1
			move_direction = 1


# --- AL PRESIONAR CLICK IZQ ---
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ATACAR"):
		if attack == 1:
			can_move = false 
			if verificar_zona():
				enemy.vida -= Filo.daño
				atacando = true
				await get_tree().create_timer(0.5).timeout
				attack = 1
				al_recibir_move()
				await get_tree().create_timer(0.5).timeout
				atacando = false
			else:
				await get_tree().create_timer(0.5).timeout
				attack = 0
				al_recibir_move()
			

func verificar_zona() -> bool:
	var areas_tocando = get_overlapping_areas()
	
	if areas_tocando.size() > 0:
		return true
	else:
		return false
