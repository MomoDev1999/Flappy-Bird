extends Marker2D

@onready var tuberia_scene = load("res://escenas/tuberia.tscn")
var random = RandomNumberGenerator.new()
var bool_spawn = true
var has_jumped = false

func _ready():
	random.randomize()

func _process(delta):
	# Si el pájaro no ha saltado todavía
	if not has_jumped:
		if Input.is_action_just_pressed("ui_accept"):
			has_jumped = true  # Marcar que el pájaro ha saltado.
		else:
			return
	spawn()

func spawn():
	if bool_spawn:
		$Timer.start()
		bool_spawn = false
		var tuberia_instance = tuberia_scene.instantiate()
		tuberia_instance.position = Vector2(0 , random.randi_range(100, 300))
		add_child(tuberia_instance)
	
	

func _on_timer_timeout():
	bool_spawn = true
