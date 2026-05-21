class_name EnemyStateChase extends EnemyState

@export var anim_name : String = "walk"
@export var chase_speed : float = 20.0

@export_category("AI")
@export var min_distance_to_player : float = 15.0
@export var next_state : EnemyState

var distance_to_player : float
var _direction : Vector2

#what happens when we initilize the state
func init() -> void:
	enemy.detection_box.player_detected.connect( _player_detected )
	enemy.detection_box.player_undetected.connect( _player_undetected )
	pass


#what happens when the enemy enters the state
func Enter() -> void:
	pass

#what happens when the enemy exits the state
func Exit() -> void:
	pass

#what happens during the process update in this state
func Process( _delta : float) -> EnemyState:
	return null

#what happens durning the physics process update
func Physics(_delta: float) -> EnemyState:
	distance_to_player = enemy.global_position.distance_to(enemy.player.global_position)
	
	if distance_to_player <= min_distance_to_player:
		enemy.velocity = Vector2.ZERO
		return null
	
	_direction = enemy.global_position.direction_to( enemy.player.global_position )
	enemy.SetDirection( _direction )
	enemy.UpdateAnimation( anim_name )
	enemy.velocity = _direction * chase_speed
	return null


func  _player_detected() -> void:
	enemy.state_machine.ChangeState( self )
	pass

func  _player_undetected() -> void:
	enemy.state_machine.ChangeState( next_state )
	pass
