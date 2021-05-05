extends Node2D

func _ready():
	$Player/BallAudio.play();
	$Player/BallCamera.make_current();
	$Airplane.set_physics_process(false);
	$Airplane.set_visible(0);

