extends CharacterBody2D

@onready var _bullet = preload("res://Tank/bullets.tscn")

var rng = RandomNumberGenerator.new()
var direction = Vector2(0,0)
const _speed = 100
var should_fire = rng.randi_range(0, 1)

func _ready():
	rng.randomize()

func _process(delta):
	if direction != Vector2.ZERO:
		var movement = direction * _speed * delta
		move_and_collide(movement)
	if should_fire == 1:
		shoot(delta)
		should_fire = 0

func _on_timer_timeout():
	var decision = rng.randi_range(0, 3)
	should_fire = 1
	
	match decision:
		0:
			direction = Vector2.UP
			rotation_degrees = 0
		1:
			direction = Vector2.DOWN
			rotation_degrees = 180
		2:
			direction = Vector2.LEFT
			rotation_degrees = -90
		3:
			direction = Vector2.RIGHT
			rotation_degrees = 90

func shoot(_delta):
	var new_bullet = _bullet.instantiate()
	new_bullet.direction = direction
	new_bullet.position = position

	get_parent().add_child(new_bullet)
