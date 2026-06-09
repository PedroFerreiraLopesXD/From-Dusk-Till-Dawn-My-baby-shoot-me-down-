extends Node3D

@onready var ShootAnim =  $animation_player
@onready var MuzzleFlash = $MuzzleFlash

func _physics_process(delta: float) -> void:
	if ShootAnim.is_playing():
		MuzzleFlash.visible = true
	else:
		MuzzleFlash.visible = false
