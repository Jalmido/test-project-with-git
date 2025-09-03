extends Node2D

@onready var player:Player = $Player
#@onready var enemy:Enemy = $Enemy

var t = 0
var is_waiting_on_reload = false

#Spawnar enemys
const ENEMY_SCENE = preload("res://enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#enemy.player = player
	player.connect("dead", _on_player_dead)
	_spawn_enemy()
func _process(delta: float) -> void: #fördefinierad loopfunktion
	if is_waiting_on_reload: #om jag väntar på att scenen ska reloada
		t += delta #Tiden kommer att räknas upp, då delta är tiden sen den sist körde funktion
		if t >= 0.5:
			get_tree().reload_current_scene()

#lyssna på dead signalen från player
func _on_player_dead() -> void: # void = returnerar inget ting, bara utför en kod.
	#await get_tree().create_timer(0.5).timeout #create timer skapar timer på 0.5 sekund, som sedan skickar timeout signal. När den är färdig skickas koden vidare
	#get_tree().reload_current_scene() #Startar alltså om svenen #get tree betyder att man vill få åtkomst till scenträdet. Alltså allt som finns i levelträdet. Den har åtkomst till nuvarande noder och kan byta å så
	#$Restart_timer.start() funktion 2
	is_waiting_on_reload = true

func _spawn_enemy():
	var enemy = ENEMY_SCENE.instantiate()
	enemy.global_position = Vector2(randf_range(0, 1000), randf_range(0, 800))
	enemy.player = player
	add_child(enemy)
	_enemy_lifetime(enemy)


func _enemy_lifetime(enemy):
	await get_tree().create_timer(2).timeout
	enemy.queue_free()
	_spawn_enemy()
	


func _on_restart_timer_timeout() -> void:
	get_tree().reload_current_scene()
