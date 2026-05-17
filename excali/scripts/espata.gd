extends Node2D

var velocidad : int
var spawnrate : float
var tamañobarra
var daño : int
var parry : float = 0.5
var freezetimebarra
var bloqueado = false
var vida = 30

func _ready() -> void:
	update_animations("idle")



func _process(_delta: float) -> void:
	if vida <= 0:
		get_tree().quit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ATACAR"):
		if Guia.attack == 1:
			update_animations("attack")
			await get_tree().create_timer(0.5).timeout
			update_animations("idle")
		else:
			update_animations("idle")
	if event.is_action_pressed("BLOQUEAR"):
		if Guia.attack == 1:
			update_animations("parry")
			bloqueado = true
			await get_tree().create_timer(parry).timeout
			bloqueado = false
			update_animations("idle")
		else:
			update_animations("idle")


func update_animations(animation):
	if $AnimationPlayer.current_animation == animation:
		return
	$AnimationPlayer.play(animation)

func on_animation_finished(anim_name: String) -> void:
	if anim_name == "attack":
		update_animations("idle")
