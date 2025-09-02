extends CharacterBody2D
class_name Player

const MAX_SPEED = 800
const ACC = 2500



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right","ui_up","ui_down")
	
	#velocity är fördefinierad av godot och är knuten till noden Characterbody2d
	velocity = velocity.move_toward(direction*MAX_SPEED, ACC*delta) #delta är fördeinierad i physics och säger hur länge sen man sist anropade funktionen. Troligen typ 1/60 dels sekund, alltså sker accen alltid lika snabbt accar lika mycket per frame.

	#För spelarobjektet enligt velocity vektorn och hanterar kollissioner
	move_and_slide()

func die():
	hide()
