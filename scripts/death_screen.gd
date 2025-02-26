extends ColorRect

func _on_texture_button_pressed():
	get_tree().reload_current_scene()
	
func _on_texture_button_2_pressed() -> void:
	get_tree().quit()
