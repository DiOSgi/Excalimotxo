extends Area2D  

# --- VARIABLES INICIALES ---
var areas_tocando

@onready var Guia = $"/root/mundo/Guia"
@onready var Espata = $"/root/mundo/Espata"
# --- EMPEZAR ---
func _ready() -> void:
	position.y = 249
	position.x = randf_range(-289.0, 292.0)
	al_recibir_turno()
	
func _process(_delta: float) -> void:
	if Guia.position.x <= -304 or Guia.position.x >=310:
		al_recibir_turno()

# --- AL RECIBIR "HIT" ---
func SeTocan() -> bool:
	areas_tocando = get_overlapping_areas()
	if areas_tocando.size() > 0:
		return true
	else:
		return false

func Ataque_acertado() -> bool:
	if SeTocan():
		hide()
		await get_tree().create_timer(Espata.spawnrate).timeout
		position.x = randf_range(-119.0, 119.0)
		show()  # mostrar
		return true
	else:
		return false

# --- AL RECIBIR "TURNO" ---
func al_recibir_turno() -> void:
	await get_tree().create_timer(0.1).timeout
