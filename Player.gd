extends KinematicBody2D

var SPEED = 420
var JUMP = 890
var GRAVITY = 3500
var direction = 1
var velocity = Vector2()
var FLOOR = Vector2(0 , -1)

func _ready():
	$AnimationPlayer.play("PlayerMove")

func _physics_process(delta):
	velocity.x = SPEED * direction
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -JUMP
		$AnimationPlayer.play("PlayerJump")
	elif is_on_floor():
		$AnimationPlayer.play("PlayerMove")
		
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity , FLOOR)
	
	if $CollisionX.is_colliding() or $CollisionY.is_colliding() or $CollisionZ.is_colliding():
		restartt()

func _on_Fallzone_body_entered(body):
	restartt()
	
func restartt():
	position.x=16
	position.y=560
	$BallAudio.stop();
	$BallAudio.play();


func _on_Obstacles_tree_entered():
	restartt()
	
func _on_Change_body_entered(body):
	$CollisionX.enabled=false;
	$CollisionY.enabled=false;
	$CollisionZ.enabled=false;
	$".".set_visible(0);
	$".".set_physics_process(false);
	$BallAudio.stop();
	
	get_parent().get_node("Change").get_node("Sprite").set_visible(0);
	
	get_parent().get_node("Airplane").set_physics_process(true);
	get_parent().get_node("Airplane").set_visible(1);
	get_parent().get_node("Airplane").get_node("AirplaneCamera").make_current();
	get_parent().get_node("Airplane").get_node("AirplaneAudio").play($BallAudio.get_playback_position());
