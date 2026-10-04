extends CharacterBody2D
var esta_muerta: bool = false

func _process(delta: float) -> void:
	if not esta_muerta:
		$AnimatedSprite2D.play("fly")
	
func _physics_process(delta: float) -> void:
	if not esta_muerta:
		move_and_slide()
		
#Función que mata a mi mosca si se le acera Chiquitito.
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Chiquitito" and not esta_muerta:
		esta_muerta = true
		$AnimatedSprite2D.play("dead")
		#Creo un timer porque la animación de mi mosca muerta solo tiene un frame.
		await get_tree().create_timer(0.3).timeout
		queue_free()
