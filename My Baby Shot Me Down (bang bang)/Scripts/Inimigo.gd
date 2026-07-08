extends CharacterBody3D

@onready var jogador =  get_tree().get_first_node_in_group("Jogador")
@onready var timer = $Timer
@onready var ponta_arma = $RayCast3D


var speed = 5.0
var distancia_ataque = 15.0
var cooldown = 1.0
var jogador_detectado = false
var bala_cena = preload("res://Scenes/bullet.tscn")

func _physics_process(delta):
	
	var dir = jogador.global_position - global_position
	var distancia = dir.length()
	
	look_at(Vector3(
		jogador.global_position.x,
		jogador.global_position.y,
		jogador.global_position.z
	))
	if distancia > distancia_ataque:
		var move_dir = dir.normalized()
		
		velocity.x = move_dir.x * speed
		velocity.y = move_dir.y * speed
	else:
		velocity.x = 0
		velocity.y = 0
	
	
	move_and_slide()

func _ready():
	timer.timeout.connect(disparar)

func disparar():
	print("Disparando")
	var nova_bala = bala_cena.instantiate()
	add_child(nova_bala)
	nova_bala.global_position = ponta_arma.global_position
	nova_bala.look_at(jogador.global_position)

func _on_area_3d_body_entered(body: Node3D) -> void:
	print("Entrou algo:", body.name)
	if body.is_in_group("Jogador"):
		print("Jogador detectado")
		jogador_detectado = true
		timer.start()
		disparar()


func _on_area_3d_body_exited(body: Node3D) -> void:
		if body.is_in_group("Jogador"):
			jogador_detectado = false
			timer.stop()
