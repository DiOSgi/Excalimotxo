extends Node2D


func _ready() -> void:
	update_animations("idle")



func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ATACAR"):
		if Guia.attack == 1:
			update_animations("attack")
			await get_tree().create_timer(0.5).timeout
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
