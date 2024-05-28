extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ROTATION_SPEED = 5.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_jumped = false  # Variable para controlar si el pájaro ha saltado.
var can_jump = true

func _physics_process(delta):
	if can_jump :
		$AnimationPlayer2D.play("Vuelo")
	# Si el pájaro no ha saltado todavía, no aplicar gravedad.
	if not has_jumped and can_jump:
		if Input.is_action_just_pressed("ui_accept"):
			has_jumped = true  # Marcar que el pájaro ha saltado.
		else:
			return
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and can_jump:
		velocity.y = JUMP_VELOCITY
		$Sprite2D.rotation_degrees = 0
		$wing.play()

	var target_rotation = 0.0
	if velocity.y > 0:
		target_rotation = 30.0
	elif velocity.y < 0:
		target_rotation = -30.0
	$Sprite2D.rotation_degrees = lerp(float($Sprite2D.rotation_degrees), target_rotation, ROTATION_SPEED * delta)
	move_and_slide()

func _on_death_zone_body_entered(body):
	can_jump = false
	$die.play()
	$AnimationPlayer2D.play("Die")
	await $die.finished
	get_tree().get_root().get_node("Escena Principal").save_score() # Llama a la función save_score() en la escena principal
	get_tree().reload_current_scene()

func death():
	if can_jump:
		can_jump = false
		$AnimationPlayer2D.play("Die")
		$hit.play()
		await $hit.finished
		get_tree().get_root().get_node("Escena Principal").save_score() # Llama a la función save_score() en la escena principal
		get_tree().reload_current_scene()

