extends CharacterBody2D

const speed = 100
var current_dir = "none"

func _ready():
	$AnimatedSprite2D.play("back_idle")

func _physics_process(delta):
	player_movement(delta)

func setPlayertoIdle():
	print("Harusnya back_idle")
	$AnimatedSprite2D.play("back_idle")

func player_movement(delta):
	if Input.is_action_pressed("keyto_right"):
		if global.player_movable == true:
			current_dir = "right"
			play_anim(1)
			velocity.x = speed
			velocity.y = 0
		
	elif Input.is_action_pressed("keyto_left"):
		if global.player_movable == true:
			current_dir = "left"
			play_anim(1)
			velocity.x = -speed
			velocity.y = 0
		
	elif Input.is_action_pressed("keyto_down"):
		if global.player_movable == true:
			current_dir = "down"
			play_anim(1)
			velocity.x = 0
			velocity.y = speed
		
	elif Input.is_action_pressed("keyto_up"):
		if global.player_movable == true:
			current_dir = "up"
			play_anim(1)
			velocity.x = 0
			velocity.y = -speed
		
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
	
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
			
		elif movement == 0:
			anim.play("side_idle")

	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
			
		elif movement == 0:
			anim.play("side_idle")
	
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("front_walk")
			
		elif movement == 0:
			anim.play("front_idle")
	
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("back_walk")
			
		elif movement == 0:
			anim.play("back_idle")
 
func player():
	pass
