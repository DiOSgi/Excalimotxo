extends Node2D
var vida
var dañoenemigo = 10
var dropeaFilo: int 
var dropeaMango: int 
@onready var Espata = $"/root/mundo/Espata" 
@onready var Guia = $"/root/mundo/Guia"
var rng = RandomNumberGenerator.new()
@onready var vivo = true 

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
		vivo = false

func recibir_daño(cantidad: int) -> void:
	vida -= cantidad
	print("Vida del enemigo: ", vida)  # para debug

func comportamiento() -> void:
	# Mientras el enemigo siga vivo, repetirá esto:
	while vida > 0:
		
		var CooldownAtaque = randi_range(3,8)#Cambiar por enemigo diferente
		print("Cooldown del Ataque: ", CooldownAtaque)
		
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
		Espata.ActionPoints = true
		
	if not Espata.bloqueando:
		Espata.vida -= dañoenemigo
		print("Tu vida: ", Espata.vida)

func morir():
	if vivo == false:
		return
	
	vida = 0
	$AnimatedSprite2D.play("die")
	await get_tree().create_timer(0.7).timeout
	if drop_filo():
		print("Te has encontrado un filo nuevo")
	elif drop_mango():
		print("Te has encontrado un mango nuevo")
	else:
		print("No te has encontrado nada")
	hide()

func drop_filo() -> bool:
	dropeaFilo = randi_range(1, 100)
	if dropeaFilo == 100:
		return true
	else:
		return false

func drop_mango() -> bool:
	dropeaMango = randi_range(1, 100)
	if dropeaMango == 100:
		return true
	else:
		return false
