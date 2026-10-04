extends CharacterBody2D


const SPEED = 300.0
var estaEnfadado: bool = false
	
func _process(delta: float) -> void:
	if estaEnfadado:
		return
	# Animacioneas de AmarilloViolento
	if $RayCast.is_colliding() and $RayCast.get_collider().name == "Chiquitito":
		estaEnfadado = true
		$AnimatedSprite2D.play("punito")
	else:
		$AnimatedSprite2D.play("idle")
		
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()

func _on_animated_sprite_2d_frame_changed() -> void:
	if $AnimatedSprite2D.animation == "punito":
		# Si esta en los frames del punito se activa el area 
		if $AnimatedSprite2D.frame == 1 or $AnimatedSprite2D.frame == 2 or $AnimatedSprite2D.frame == 3 or $AnimatedSprite2D.frame == 4:
			$Area2D/CollisionShape2D.disabled = false
		else:
			$Area2D/CollisionShape2D.disabled = true

#	Funcion que activa el punito.
func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "punito":
		$Area2D/CollisionShape2D.disabled = true
		estaEnfadado = false
		$AnimatedSprite2D.play("idle")

#Funcion que mata a chuiquito si lo toca el puno.
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Chiquitito" :
		body.get_node("AnimatedSprite2D").animation = "dead"
		body.get_node("AnimatedSprite2D").play()
