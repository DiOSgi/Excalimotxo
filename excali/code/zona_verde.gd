extends Area2D  

# --- VARIABLES INICIALES ---
var spawn: float = 0.04
var attack: int = 1


# --- EMPEZAR ---
func _ready() -> void:
	spawn = 0.04
	position.y = 249
	position.x = randf_range(-289.0, 292.0)
	al_recibir_turno()
	
func _process(_delta: float) -> void:
	if Guia.position.x <= -304 or Guia.position.x >=310:
		al_recibir_turno()

# --- AL RECIBIR "HIT" ---
func al_recibir_hit() -> bool:
	var areas_tocando = get_overlapping_areas()
	if areas_tocando.size() > 0:
		return true
	else:
		return false
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ATACAR"):
		if attack == 1:
			if al_recibir_hit():
				hide()
				# esperar [spawn] segundos
				await get_tree().create_timer(spawn).timeout
				position.x = randf_range(-119.0, 119.0)
				show()  # mostrar
				attack = 1
			else:
					attack = 0
			


# --- AL RECIBIR "TURNO" ---
func al_recibir_turno() -> void:
	attack = 1
	# esperar 0.1 segundos
	await get_tree().create_timer(0.1).timeout
