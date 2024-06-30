extends EnemyState

func enter():
	body.animation_player.stop()

func process(delta):
	return body.get_director().get_random_behaviour()
  
