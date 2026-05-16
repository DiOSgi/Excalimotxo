extends Area2D  

# --- VARIABLES INICIALES ---
var spawn: float = 0.04
var turno: int = 0


# --- EMPEZAR ---
func _ready() -> void:
	spawn = 0.04
	
	position.y = 249
	
	
	position.x = randf_range(-119.0, 119.0)


# --- AL RECIBIR "HIT" ---
func al_recibir_hit() -> bool:
	var areas_tocando = get_overlapping_areas()
	if areas_tocando.size() > 0:
		return true
	else:
		return false
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ATACAR"):
		if al_recibir_hit():
			hide()  
			
			# esperar [spawn] segundos
			await get_tree().create_timer(spawn).timeout
			
			position.x = randf_range(-119.0, 119.0)
			
			show()  # mostrar


# --- AL RECIBIR "TURNO" ---
func al_recibir_turno() -> void:
	turno = 1  # dar a turno el valor 1
	
	# esperar 0.1 segundos
	await get_tree().create_timer(0.1).timeout
	
	turno = 0  # dar a turno el valor 0
