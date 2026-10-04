extends CharacterBody2D


const SPEED = 100.0
var velocidad_actual = SPEED

func _process(delta: float) -> void:
	
	# Da la vuelta al gusanito
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
		
func _physics_process(delta: float) -> void:
			
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#Raycas que hacen que gusanito no caiga al vacio y gire al colisionar.
	if $RayCastDet.is_colliding():
		velocidad_actual = -SPEED
		
	if $RayCastDel.is_colliding():
		velocidad_actual = SPEED
	
	if not $RayCastAbDel.is_colliding():
		velocidad_actual = SPEED
	
	if not $RayCastAbDet.is_colliding():
		velocidad_actual = -SPEED
		
	velocity.x = velocidad_actual

	move_and_slide()

func _on_area_dano_body_entered(body: Node2D) -> void:
	if body.name == "Chiquitito" :
		body.get_node("AnimatedSprite2D").animation = "dead"
		body.get_node("AnimatedSprite2D").play()
