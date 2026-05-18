extends Area2D

# --- VARIABLES INICIALES---
var puntos_de_acción: int = 1
var move_direction: int = -1
var velocidad: float = 3
var can_move: bool = true
var atacando: bool = false 
var sonido: float
@onready var enemy = $"/root/mundo/Enemy"
@onready var espada1 : AudioStreamPlayer = $SoundEffects/HitEspada/Espada1
@onready var espada2 : AudioStreamPlayer = $SoundEffects/HitEspada/Espada2
@onready var espada3 : AudioStreamPlayer = $SoundEffects/HitEspada/Espada3

# --- EMPEZAR ---
func _ready() -> void:
	# Posición inicial 
	position = Vector2(0, 249)
	puntos_de_acción = 1
	move_direction = -1
	velocidad = 3
	atacando = false
	
	set_process_input(true)
	# Activa el movimiento
	al_recibir_move()


# --- BUCLE DE MOVIMIENTO ---
func al_recibir_move() -> void:
	can_move = true



func _process(_delta: float) -> void:
	if not can_move:
		return
		
	# SI move == 1 (Mover a la derecha)
	if move_direction == 1:
		if position.x <= 310:
			position.x += velocidad
		else:
			puntos_de_acción = 1
			move_direction = -1
			
	# SI move == -1 (Mover a la izquierda)
	elif move_direction == -1:
		if position.x >= -304:
			position.x -= velocidad
		else:
			puntos_de_acción = 1
			move_direction = 1


# --- AL PRESIONAR CLICK IZQ ---
func _input(event: InputEvent) -> void:
	pass

func procesar_ataque():
		if puntos_de_acción >= 1: #si actionpoints son mayores o iguales a 1
			can_move = false #convierte can_move en falso
			if await verificar_zona():
				if enemy:
					sonido = randf_range(1,3)
					if sonido == 1:
						espada1.play()
					elif sonido == 2:
						espada2.play()
					else:
						espada3.play()
					enemy.recibir_daño(Filo.daño) 
				atacando = true
				await get_tree().create_timer(0.5).timeout
				puntos_de_acción = 1
				al_recibir_move()
				await get_tree().create_timer(0.5).timeout
				atacando = false
			else:
				await get_tree().create_timer(0.5).timeout
				puntos_de_acción = 0
				al_recibir_move()


func verificar_zona() -> bool:
	await get_tree().process_frame
	var areas_tocando = get_overlapping_areas()
	
	if areas_tocando.size() > 0:
		return true
	else:
		return false
