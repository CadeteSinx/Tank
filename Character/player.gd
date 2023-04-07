extends CharacterBody2D

const _speed = 100

@onready var _bullet = preload("res://Tank/Character/AllyBullets.tscn")
@onready var _timer = $Timer

var direction = Vector2()
var last_direction = Vector2.UP
var can_shoot = true

func _physics_process(delta):
	direction = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		direction = Vector2.UP
	if Input.is_action_pressed("down"):
		direction = Vector2.DOWN
	if Input.is_action_pressed("left"):
		direction = Vector2.LEFT
	if Input.is_action_pressed("right"):
		direction = Vector2.RIGHT
	
	if can_shoot:
		if Input.is_action_just_pressed("shoot"):
			shoot(delta)
			_timer.start()
			can_shoot = false

	if direction != Vector2.ZERO:
		var movement = direction * _speed * delta
		move_and_collide(movement)
		last_direction = direction

func shoot(_delta):
	var new_bullet = _bullet.instantiate()
	if direction == Vector2.ZERO:
		new_bullet.direction = last_direction
	else:
		new_bullet.direction = direction
	new_bullet.position = position

	get_parent().add_child(new_bullet)


func _on_timer_timeout():
	can_shoot = true
