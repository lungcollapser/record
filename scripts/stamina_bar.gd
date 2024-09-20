extends ProgressBar


func _process(delta: float) -> void:
	if value < 100:
		value += 1 * delta
		
func _ready() -> void:
	$playerbody3d.update_stamina()
