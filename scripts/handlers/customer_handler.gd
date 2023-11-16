extends Node

export(Resource) var CUSTO

func get_rand_customer() -> Dictionary:
  # Chooses the customer number (for now they are all equally likely to appear)
  var id = randi() % 3
  var stats
  
  # Basically a switch statement
  match id:
    0: stats = CUSTO.tourist
    1: stats = CUSTO.regular
    2: stats = CUSTO.local
  
  return stats
