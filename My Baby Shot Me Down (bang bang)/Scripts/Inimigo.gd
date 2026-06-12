extends CharacterBody3D

@onready var jogador =  get_tree().get_first_node_in_group("Jogador")
@onready var ray = $RayCast3D

var speed = 5.0
var distancia_ataque = 15.0
var cooldown = 1.0
var timer = 0.0

func _physics_process(delta):
	
	if jogador == null:
		return
	timer -= delta
	
	var dir = jogador.global_position - global_position
	var distancia = dir.length()
	
	look_at(Vector3(
		jogador.global_position.x,
		jogador.global_position.y,
		jogador.global_position.z
	))
	ray.target_position = ray.to_local(jogador.global_position)
	if distancia > distancia_ataque:
		var move_dir = dir.normalized()
		
		velocity.x = move_dir.x * speed
		velocity.y = move_dir.y * speed
	else:
		velocity.x = 0
		velocity.y = 0

		if ray.is_colliding() and ray.get_collider().is_in_group("Jogador"):
			if timer <= 0:
				atirar()
				timer = cooldown

	move_and_slide()

func atirar():
	print("PEW PEW")
	var bala = preload("res://Scripts/bullet.gd").instantiate()
	get_tree().current_scene.add_child(bala)
	bala.global_position = global_position = Vector3.UP
	bala.direcao = (
	player.global_position - bala.global_position).normalized()
