extends EnemyState

func process(delta):
	return body.get_director().get_random_behaviour()
  
