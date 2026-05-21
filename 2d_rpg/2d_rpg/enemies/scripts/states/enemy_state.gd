class_name EnemyState extends Node

## stores a refernece to the enemy that this state belongs to
var enemy : Enemy
var state_machine : EnemyStateMachine


#what happens when we initilize the state
func init() -> void:
	pass


#what happens when the player enters the state
func Enter() -> void:
	pass

#what happens when the player exits the state
func Exit() -> void:
	pass

#what happens during the process update in this state
func Process( _delta : float) -> EnemyState:
	return null

#what happens durning the physics process update
func Physics( _delta: float) -> EnemyState:
	return null
