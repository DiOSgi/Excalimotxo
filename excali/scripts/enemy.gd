extends Node2D
var vida 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	vida = 30
	comportamiento()
	$AnimatedSprite2D.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if vida <= 0:
		morir()

func recibir_daño(cantidad: int) -> void:
	vida -= cantidad
	print("Vida restante: ", vida)  # para debug

func comportamiento() -> void:
	# Mientras el enemigo siga vivo, repetirá esto:
	while vida > 0:
	
		await get_tree().create_timer(3.0).timeout
		
		if vida <= 0: break
		
		attack()
		
		await get_tree().create_timer(3.0).timeout
		
		if vida <= 0: break
		
		
		$AnimatedSprite2D.play("idle")





func attack():
	$AnimatedSprite2D.play("attack")
	
func morir():
	vida = 0
	$AnimatedSprite2D.play("die")
	await get_tree().create_timer(0.7).timeout
	hide()
