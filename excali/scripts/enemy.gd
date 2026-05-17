extends Node2D
var vida 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	update_animation("idle")
	vida = 30
	comportamiento()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func comportamiento() -> void:
	# Mientras el enemigo siga vivo, repetirá esto:
	while vida > 0:
	
		await get_tree().create_timer(3.0).timeout
		
		if vida <= 0: break
		
		attack()
		
		await get_tree().create_timer(3.0).timeout
		
		if vida <= 0: break
		
		
		update_animation("idle")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ATACAR"):
		if Guia.attack == 1:
			await get_tree().create_timer(3.0).timeout
			if vida <= 0:
				morir()

func update_animation(animacion):
	$AnimatedSprite2D.play(animacion)

func attack():
	update_animation("attack")
	
func morir():
	vida = 0
	update_animation("die")
	await get_tree().create_timer(0.7).timeout
	hide()
