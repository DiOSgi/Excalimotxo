extends Area2D

# --- VARIABLES INICIALES---
var attack: int = 1
var puntos: int = 0
var move_direction: int = -1
var velocidad: float = 8.0
var can_move: bool = true
var vida: int = 30

# --- EMPEZAR ---
func _ready() -> void:
	# Posición inicial 
	position = Vector2(0, 249)
	attack = 1
	puntos = 0
	move_direction = -1
	velocidad = 8.0
	
	# ir a capa delantera
	z_index = 1
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
		if position.x <= 130:
			position.x += velocidad
		else:
			# Repetir hasta que x > 145 ha terminado
			enviar_mensaje("turno")
			attack = 1
			move_direction = -1
			
	# SI move == -1 (Mover a la izquierda)
	elif move_direction == -1:
		if position.x >= -130:
			position.x += (0 - velocidad) # o simplemente: position.x -= velocidad
		else:
			# Repetir hasta que x < -114 ha terminado
			enviar_mensaje("turno")
			attack = 1
			move_direction = 1


# --- AL PRESIONAR CLICK IZQ ---
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ATACAR"):
		if attack == 1:
			attack = 0
			can_move = false  # ← solo frena si realmente ataca
			if verificar_zona():
				enviar_mensaje("hit")
				vida -= 10
			await get_tree().create_timer(0.5).timeout
			attack = 1
			al_recibir_move()

# --- FUNCIONES AUXILIARES SIMULADAS ---
# (Sustituye esto por tus señales reales de Godot si es necesario)
func enviar_mensaje(mensaje: String) -> void:
	print("Se envió el mensaje: ", mensaje)

func verificar_zona() -> bool:
	var areas_tocando = get_overlapping_areas()
	
	# Si la lista NO está vacía, significa que estamos tocando otra Area2D
	if areas_tocando.size() > 0:
		return true
	else:
		return false
