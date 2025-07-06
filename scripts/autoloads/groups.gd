extends Node

const ENTITIES_LAYER = "entities"

const PLAYER: String = "player"

var entities_layer: Node2D :get = get_entities_layer

var player: Player: get = get_player

func get_entities_layer() -> Player:
  return get_tree().get_first_node_in_group(ENTITIES_LAYER) as Node2D

func get_player() -> Player:
  return get_tree().get_first_node_in_group(PLAYER) as Player
