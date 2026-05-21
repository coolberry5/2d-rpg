class_name EnemyStateDestroy extends EnemyState

@export var anim_name : String = "destroy"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")

var _direction : Vector2

#what happens when we initilize the state
func init() -> void:
	enemy.EnemyDestroyed.connect( _on_enemy_destroyed )
	pass


#what happens when the enemy enters the state
func Enter() -> void:
	enemy.Invulnerable = true
	_direction = enemy.global_position.direction_to( enemy.player.global_position )
	enemy.SetDirection( _direction )
	enemy.velocity = _direction * -knockback_speed
	enemy.UpdateAnimation( anim_name )
	enemy.animation_player.animation_finished.connect( _on_animation_finised )
	pass

#what happens when the enemy exits the state
func Exit() -> void:
	pass

#what happens during the process update in this state
func Process( _delta : float) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null

#what happens durning the physics process update
func Physics(_delta: float) -> EnemyState:
	return null


func _on_enemy_destroyed() -> void:
	state_machine.ChangeState( self )
	pass


func _on_animation_finised( _a : String ) -> void:
	enemy.queue_free()
	pass
