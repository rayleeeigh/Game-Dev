extends Area2D

func _on_Change_body_entered(body):
	get_node("Airplane").set_physics_process(true);
