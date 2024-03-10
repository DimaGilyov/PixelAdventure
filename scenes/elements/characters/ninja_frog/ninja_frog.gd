extends CharacterBody2D

@onready var anim = $CollisionShape2D/AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

const SPEED = 200.0
const JUMP_VELOCITY = -350.0
var jumps_count = 0

var double_jump_fineshed = true
func _physics_process(delta):	
	if is_on_floor():
		jumps_count = 0
		
	if not is_on_floor():
		if jumps_count == 2:
			anim.play("DoubleJump")
			jumps_count += 1
			double_jump_fineshed = false
			await anim.animation_finished
			double_jump_fineshed = true
		elif double_jump_fineshed:
			anim.play("Jump")
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jumps_count += 1
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("ui_accept") and not is_on_floor():
		if jumps_count < 2:		
			jumps_count += 1
			velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction > 0:
		anim.flip_h = false
	elif direction < 0:
		anim.flip_h = true
		
	if direction:
		if is_on_floor():
			anim.play("Run")
		velocity.x = direction * SPEED
	else:
		if is_on_floor():
			anim.play("Idel")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	

	move_and_slide()
