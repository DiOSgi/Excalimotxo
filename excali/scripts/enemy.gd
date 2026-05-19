extends Node2D
var vida
var dañoenemigo = 10
@onready var Espata = $"/root/mundo/Espata" 
@onready var Guia = $"/root/mundo/Guia"
var rng = RandomNumberGenerator.new()

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
	print("Vida del enemigo: ", vida)  # para debug

func comportamiento() -> void:
	# Mientras el enemigo siga vivo, repetirá esto:
	while vida > 0:
		
		var CooldownAtaque = randi_range(3,8)#Cambiar por enemigo diferente
		print(CooldownAtaque)
		
		await get_tree().create_timer(CooldownAtaque).timeout
		
		if vida <= 0: break
		
		attack()
		
		await get_tree().create_timer(3.0).timeout
		
		if vida <= 0: break
		
		
		$AnimatedSprite2D.play("idle")

func attack():
	$AnimatedSprite2D.play("attack")
	await get_tree().create_timer(1).timeout
	
	if Espata.bloqueando:
		print("Tu vida: ", Espata.vida)
		Guia.puntos_de_acción += 1
		
	if not Espata.bloqueando:
		Espata.vida -= dañoenemigo
		print("Tu vida: ", Espata.vida)

func morir():
	vida = 0
	$AnimatedSprite2D.play("die")
	await get_tree().create_timer(0.7).timeout
	hide()
