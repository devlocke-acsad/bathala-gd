extends Node2D

# Player and Enemy Stats (Placeholder) - These will be your actual game variables
var player_max_health: int = 100
var player_current_health: int = 100

var enemy_max_health: int = 50
var enemy_current_health: int = 50

# References to UI elements using @onready
@onready var player_health_bar: ProgressBar = $PlayerContainer/PlayerHealthBar
@onready var player_health_label: Label = $PlayerContainer/PlayerHealthLabel
@onready var player_sprite: TextureRect = $PlayerContainer/PlayerSprite # Assuming you have this
@onready var player_animation_player: AnimationPlayer = $PlayerContainer/AnimationPlayer # Assuming you have this

@onready var enemy_health_bar: ProgressBar = $EnemyContainer/EnemyHealthBar
@onready var enemy_health_label: Label = $EnemyContainer/EnemyHealthLabel
@onready var enemy_sprite: TextureRect = $EnemyContainer/EnemySprite # Assuming you have this
@onready var enemy_animation_player: AnimationPlayer = $EnemyContainer/AnimationPlayer # Assuming you have this


func _ready():
	# Initialize the health bar and label values when the scene starts
	player_health_bar.max_value = player_max_health
	enemy_health_bar.max_value = enemy_max_health
	update_health_display() # Call this to set initial values

	print("Combat Scene Loaded!")
	# Your previous test code for damage:
	await get_tree().create_timer(1.0).timeout
	take_damage_example(enemy_sprite, 10, "enemy")
	await get_tree().create_timer(1.0).timeout
	take_damage_example(player_sprite, 5, "player")


func update_health_display():
	# Update ProgressBar value
	player_health_bar.value = player_current_health
	enemy_health_bar.value = enemy_current_health

	# Update Label text
	player_health_label.text = str(player_current_health) + " / " + str(player_max_health)
	enemy_health_label.text = str(enemy_current_health) + " / " + str(enemy_max_health)

# (Keep your take_damage_example function and animation code as before)
func take_damage_example(target_sprite: TextureRect, damage: int, target_type: String):
	# ... (rest of the take_damage_example function from previous steps)
	if target_type == "player":
		player_current_health = max(0, player_current_health - damage)
		if player_animation_player:
			player_animation_player.play("hit")
			await player_animation_player.animation_finished
		if player_current_health <= 0:
			print("Player defeated!")
			get_tree().change_scene_to_file("res://MainMenu.tscn")
	elif target_type == "enemy":
		enemy_current_health = max(0, enemy_current_health - damage)
		if enemy_animation_player:
			enemy_animation_player.play("hit")
			await enemy_animation_player.animation_finished
		if enemy_current_health <= 0:
			print("Enemy defeated!")
			get_tree().change_scene_to_file("res://GameMap.tscn")

	update_health_display() # Crucial: call this after changing health
