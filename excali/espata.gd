extends Node2D


func _ready() -> void:
	$AnimationPlayer.play("idle")



func _process(delta: float) -> void:
	update_animations("idle")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ATACAR"):
		if Guia.atacando == true:
			update_animations("atack")

func update_animations(animation):
	$AnimationPlayer.play(animation)
