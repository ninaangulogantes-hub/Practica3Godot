extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
var estaMuerto: bool = false
	
func _process(delta: float) -> void:
	
#Si esta muerto se va del juego
	if $AnimatedSprite2D.animation == "dead":
			get_tree().reload_current_scene()
			
#Control de animaciones.
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true

	if not is_on_floor():
		$AnimatedSprite2D.play("jump")
	elif velocity.x != 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
		
func _physics_process(delta: float) -> void:
			
#Si no esta en el suelo le aplicamos gravedad.
	if not is_on_floor():
		velocity += get_gravity() * delta

#Controla la velocidad de salto
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
#Controla la velocidad de andar
	if Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	else:
		velocity.x = 0
#salto
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		
#Controla la direccion
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

		
