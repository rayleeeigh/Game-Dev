extends Actor

func _ready():
	$AnimationPlayer.play("PlayerFall")

func _physics_process(_delta: float) -> void:
	var direction: = get_direction()
	
	velocity = calculate_velocity(velocity,direction,speed)
	velocity = move_and_slide(velocity,FLOOR_NORMAL)
	
	if Input.is_action_just_pressed("jump"):
		$AnimationPlayer.play("PlayerRise")
	elif Input.is_action_just_released("jump"):
		$AnimationPlayer.play("PlayerFall")
		
	if $CollisionX.is_colliding() or $CollisionY.is_colliding() or $CollisionZ.is_colliding():
		restartt()
		
func get_direction() -> Vector2:
	return Vector2(1.0,
	-1.0 if Input.is_action_pressed("jump")else 1.0
	)

func calculate_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2
	) -> Vector2:
	
	var new_velocity = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity*get_physics_process_delta_time()
	
	if direction.y ==-1.0:
		new_velocity.y = speed.y * direction.y
	
	return new_velocity

func restartt():
	position.x=15225.3
	position.y=505.068
	$AirplaneAudio.stop();
	
	$".".set_physics_process(false);
	$".".set_visible(0);
	get_parent().get_node("Change").get_node("Sprite").set_visible(1);
	get_parent().get_node("Player").position.x=16;
	get_parent().get_node("Player").position.y=560;
	get_parent().get_node("Player").set_physics_process(true);
	get_parent().get_node("Player").set_visible(1);
	get_parent().get_node("Player").get_node("BallCamera").make_current();
	get_parent().get_node("Player").get_node("BallAudio").play()
	get_parent().get_node("Player").get_node("CollisionX").enabled=true
	get_parent().get_node("Player").get_node("CollisionY").enabled=true
	get_parent().get_node("Player").get_node("CollisionZ").enabled=true
	
