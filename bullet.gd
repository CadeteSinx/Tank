extends StaticBody2D

const _SPEED = 300
var direction = Vector2.ZERO



func _physics_process(delta):
	var movement = direction * _SPEED * delta
	move_and_collide(movement)
