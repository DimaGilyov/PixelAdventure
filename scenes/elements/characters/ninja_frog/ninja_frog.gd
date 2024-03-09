extends CharacterBody2D

@onready var anim = $CollisionShape2D/AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

const SPEED = 200.0
const JUMP_VELOCITY = -300.0


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction > 0:
		anim.flip_h = false
	elif direction < 0:
		anim.flip_h = true
		
	if direction:
		anim.play("Run")
		velocity.x = direction * SPEED
	else:
		anim.play("Idel")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	

	move_and_slide()
