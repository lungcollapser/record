extends ProgressBar

@onready var player_stamina = $playerbody3d


func update_stamina(delta):
	if player_stamina.max_endurance <= 100:
		value += 1 * delta
	
	
