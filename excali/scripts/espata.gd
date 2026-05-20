extends Node2D

var velocidad : int
var spawnrate : float
var tamañobarra
var daño : int
var parry : float = 0.5
var freezetimebarra

var vida = 30
var bloqueando = false
var sonido : float

@onready var Guia = $"/root/mundo/Guia"
@onready var zona_verde = $"/root/mundo/zona_verde"

func _ready() -> void:
	update_animations("idle")

func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ATACAR"):#cuando se presiona atacar
		if Guia.puntos_de_acción >= 1:#si puntos de accion son mayores o iguales que 1
			Guia.puntos_de_acción -= 1
			Guia.procesar_ataque()
			update_animations("attack")#hace animación de atacar
			await get_tree().create_timer(0.5).timeout#espera 0.5 segundos
			update_animations("idle")#hace animacion idle
			print("Atacas")
		else: #si puntos de accion no son mayores o iguales a 1
			print("No puedes hacer nada")
			update_animations("idle")#hacer animación idle
			
	if event.is_action_pressed("BLOQUEAR"):#Cuando se presiona bloquear
		if Guia.puntos_de_acción >= 1:#si accion de guia es igual o mayor a 1
			Guia.puntos_de_acción -= 1
			update_animations("Parry")#Hace animacion de parry
			bloqueando = true#Pasa a estar bloqueando
			print("Intentas bloquear")
			await get_tree().create_timer(parry).timeout#espera el tiempo que dura parry
			bloqueando = false#deja de bloquear
			update_animations("idle")#Hace animacion idle
		else:#si ataque de guia no era igual a 1
			update_animations("idle") #

func sonido_hit_espada():
	print("Sonido de espada golpeando.mp4")
	sonido = randi_range(1, 3)
	if sonido == 1:
		$SoundEffects/HitEspada/Espada1.play()
	elif sonido == 2:
		$SoundEffects/HitEspada/Espada2.play()
	else:
		$SoundEffects/HitEspada/Espada3.play()

func update_animations(animation):
	if $AnimationPlayer.current_animation == animation:
		return
	$AnimationPlayer.play(animation)

func on_animation_finished(anim_name: String) -> void:
	if anim_name == "attack":
		update_animations("idle")
