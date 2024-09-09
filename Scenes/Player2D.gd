extends CharacterBody2D

@export var speed = 400
@export var friction = 0.01
@export var acceleration = 0.1

@onready var _animated_sprite = $AnimatedSprite2D

func get_input():
	var input = Vector2()
	if Input.is_action_pressed('right'):
		_animated_sprite.play("walk_right")
		input.x += 1
	if Input.is_action_pressed('left'):
		_animated_sprite.play("walk_left")
		input.x -= 1
	if Input.is_action_pressed('down'):
		_animated_sprite.play("walk_down")
		input.y += 1
	if Input.is_action_pressed('up'):
		_animated_sprite.play("walk_up")
		input.y -= 1
	return input

func _physics_process(delta):
	var direction = get_input()
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		# velocity = velocity.lerp(Vector2.ZERO, friction)
		velocity = Vector2.ZERO
	move_and_slide()
