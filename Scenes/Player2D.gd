extends CharacterBody2D

@export var speed = 400
@export var friction = 0.01
@export var acceleration = 0.1

# Defining screen size, etc
@export var screen_size : Vector2 

@onready var _animated_sprite = $AnimatedSprite2D

var last_direction: Vector2 = Vector2.ZERO  # Store the last movement direction

func _ready() -> void:
	screen_size = get_viewport_rect().size 
	position = screen_size / 2

func get_input():
	var input = Vector2()
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	if Input.is_action_pressed('down'):
		input.y += 1
	if Input.is_action_pressed('up'):
		input.y -= 1
	return input

func _physics_process(delta):
	var direction = get_input()
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
		last_direction = direction
		play_walk_animation(direction)  # Play the walking animation
	else:
		velocity = Vector2.ZERO
		play_idle_animation(last_direction)  # Play idle animation based on last direction

	move_and_slide()
	
	# Limit movement to window size 
	position = position.clamp(Vector2.ZERO, screen_size) 

func play_walk_animation(direction: Vector2):
	if direction.x > 0 and _animated_sprite.animation != "walk_right":
		_animated_sprite.play("walk_right")
	elif direction.x < 0 and _animated_sprite.animation != "walk_left":
		_animated_sprite.play("walk_left")
	elif direction.y > 0 and _animated_sprite.animation != "walk_down":
		_animated_sprite.play("walk_down")
	elif direction.y < 0 and _animated_sprite.animation != "walk_up":
		_animated_sprite.play("walk_up")

func play_idle_animation(direction: Vector2):
	if direction.x > 0 and _animated_sprite.animation != "idle_right":
		_animated_sprite.play("idle_right")
	elif direction.x < 0 and _animated_sprite.animation != "idle_left":
		_animated_sprite.play("idle_left")
	elif direction.y > 0 and _animated_sprite.animation != "idle_down":
		_animated_sprite.play("idle_down")
	elif direction.y < 0 and _animated_sprite.animation != "idle_up":
		_animated_sprite.play("idle_up")
