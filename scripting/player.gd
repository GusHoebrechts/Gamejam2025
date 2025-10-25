extends CharacterBody2D


const SPEED = 190.0
const JUMP_VELOCITY = -220.0

enum State{Idle,Run,Walking,Jumping, Falling}
var state: State=State.Idle


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		state=State.Jumping
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		state=State.Walking
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		state=State.Idle
	move_and_slide()
	
	if not is_on_floor() and velocity.y<0.0:
		state=State.Jumping
	elif not is_on_floor() and velocity.y>0.0:
		state=State.Falling
	#Animating
	match state:	
		State.Idle:
			$AnimatedSprite2D.play("Idle")
			print("Idle")
		State.Walking:
			$AnimatedSprite2D.play("Walking")
			print("Walking")
			if velocity.x<0:
				$AnimatedSprite2D.flip_h = true
			if velocity.x>0:
				$AnimatedSprite2D.flip_h = false
		State.Jumping:
			$AnimatedSprite2D.play("Jumping")
			print("Jumping")
		State.Falling:
			$AnimatedSprite2D.play("Falling")
			print("Falling")
			if velocity.x<0:
				$AnimatedSprite2D.flip_h = true
			if velocity.x>0:
				$AnimatedSprite2D.flip_h = false
		
