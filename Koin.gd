extends Area2D

func _on_Koin_body_entered(body):
	
	var _koinefek = preload("res://KoinEfek.tscn")
	var koinefek = _koinefek.instance()
	koinefek.transform = self.transform
	get_tree().current_scene.add_child(koinefek)
	
	remove_from_group("GrupKoin")
	if body.name == "Hero":
		body.dapat_koin()
	queue_free()
