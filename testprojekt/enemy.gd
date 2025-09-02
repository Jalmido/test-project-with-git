extends CharacterBody2D
class_name Enemy

const MAX_SPEED = 500
const ACC = 2000

#kommer definieras av föräldern, som har åtkomst till sina barn.
var player


func _physics_process(delta: float) -> void:
	if player:
		var direction_to_player = global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(direction_to_player*MAX_SPEED, ACC*delta)
		move_and_slide()

#Anropas automatiskt av godot när en kollisionskropp (Player) överlappar arean.
func _on_player_detect_area_body_entered(body: Node2D) -> void:
	if body is Player: #om min kollisionskropp är min player
		body.die() #die funktionen kommer triggas i player
