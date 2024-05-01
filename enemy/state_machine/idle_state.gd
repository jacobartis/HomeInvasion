extends EnemyState

func process(delta):
	if body.get_director().get_pos_of_interest():
		return EnemyState.State.Invesigation
	return body.get_director().get_random_behaviour()
  
