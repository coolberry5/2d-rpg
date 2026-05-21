class_name EnemyStateStun extends EnemyState

@export var anim_name : String = "stun"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")
@export var next_state : EnemyState

var _direction : Vector2
var _animation_finished : bool = false

#what happens when we initilize the state
func init() -> void:
	enemy.EnemyDamaged.connect( _on_enemy_damaged )
	pass


#what happens when the enemy enters the state
func Enter() -> void:
	enemy.Invulnerable = true
	_animation_finished = false
	_direction = enemy.global_position.direction_to( enemy.player.global_position )
	enemy.SetDirection( _direction )
	enemy.velocity = _direction * -knockback_speed
	enemy.UpdateAnimation( anim_name )
	enemy.animation_player.animation_finished.connect( _on_animation_finised )
	pass

#what happens when the enemy exits the state
func Exit() -> void:
	enemy.animation_player.animation_finished.disconnect( _on_animation_finised )
	enemy.Invulnerable = false
	pass

#what happens during the process update in this state
func Process( _delta : float) -> EnemyState:
	if _animation_finished == true:
		return next_state
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null

#what happens durning the physics process update
func Physics(_delta: float) -> EnemyState:
	return null


func _on_enemy_damaged() -> void:
	state_machine.ChangeState( self )
	pass


func _on_animation_finised( _a : String ) -> void:
	_animation_finished = true
	pass
