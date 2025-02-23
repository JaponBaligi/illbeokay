extends CharacterBody2D

var movement_speed : float = 50.0
var hp = 101
var maxhp = 101
var last_movement = Vector2.UP
var time = 0
var aiming_mode = ""
var exp_value = 0
var exp_level = 1
var total_exp = 0

# Attacks

var fireBall = preload("res://scenes/fireball.tscn")
var nebula = preload("res://scenes/nebula.tscn")
var staff = preload("res://scenes/staff.tscn")

# Attack Nodes

@onready var reload_timer = Timer.new()
@onready var FireBallTimer = get_node("%FireBallTimer")
@onready var FireBallAttackTimer = get_node("%FireBallAttackTimer")
@onready var NebulaTimer = get_node("%NebulaTimer")
@onready var NebulaAttackTimer = get_node("%NebulaAttackTimer")
@onready var staffBase = get_node("%StaffBase")

#UPGRADE SECTION

var collected_upgrades = []
var upgrade_options = []
var armor = 0 
var spell_cdr = 0
var spell_size = 0
var additional_attacks = 0 

# Fireball

var fireball_ammo = 0
var fireball_baseammo = 0
var fireball_attackspeed = 1.5
var fireball_level = 0

# Nebula

var nebula_ammo = 0
var nebula_baseammo = 0
var nebula_attackspeed = 3
var nebula_level = 0

#Staff

var staff_ammo = 0
var staff_level = 0

#Collector Hand

@onready var grabAreaCollision = $GrabArea/CollisionShape2D

#Third Eye

@onready var fov = $FOV

# Enemy Related

var enemy_close = []

@onready var sprite = $AnimatedSprite2D

#GUI Elements

@onready var expBar = get_node("%ExperienceBar")
@onready var label_level = get_node("%label_level")
@onready var levelPanel = get_node("%LevelUp")
@onready var upgradeOptions = get_node("%UpgradeOptions")
@onready var itemOptions = preload("res://scenes/item_option.tscn")
@onready var sndLevelUp = get_node("%snd_levelup")
@onready var healthBar = get_node("%HealthBar")
@onready var label_Timer = get_node("%label_Timer")
@onready var deathPanel = get_node("%DeathPanel")
@onready var lblResult = get_node("%label_Result")
@onready var sndVictory = get_node("%snd_victory")
@onready var sndLose = get_node("%snd_lose")

# OPTIONS SECTION
@onready var settings_tab_container = get_node("GUILayer/OptionsMenu/MarginContainer/VBoxContainer/Settings_Tab_Container")


func _ready():
	reload_timer.set_wait_time(1.5)
	reload_timer.connect("timeout", Callable(self,"_on_reload_timer_timeout"))
	add_child(reload_timer)
	upgrade_character("fireball1")
	attack()
	set_expbar(exp_value, calculate_expcap())
	_on_hurt_box_hurt(0,0,0)
	aiming_mode = GameData.aiming_mode
	$AnimatedSprite2D.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _physics_process(delta):
	movement()

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if aiming_mode == "manual" and fireball_ammo > 0:
			shoot_manual()

func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov, y_mov)
	if mov.x > 0:
		sprite.flip_h = false
		sprite.play("move_right")
	elif mov.x < 0:
		sprite.flip_h = false
		sprite.play("move_left")
	elif mov.y < 0:
		sprite.play("idle")
	elif mov.y > 0:
		sprite.play("idle")
	else:
		sprite.play("idle")
	if mov != Vector2.ZERO:
		last_movement = mov.normalized()
		velocity = mov.normalized() * movement_speed
		move_and_slide()

func attack():
	if fireball_level > 0:
		FireBallTimer.wait_time = fireball_attackspeed * (1-spell_cdr)
	if FireBallTimer.is_stopped():
		FireBallTimer.start()
	if nebula_level > 0:
		NebulaTimer.wait_time = nebula_attackspeed * (1-spell_cdr)
	if NebulaTimer.is_stopped():
		NebulaTimer.start()
	if staff_level > 0:
		spawn_staff()

func _on_hurt_box_hurt(damage, _angle, _knockback):
	hp -= clamp(damage-armor, 1.0,999.0) 
	healthBar.max_value = maxhp
	healthBar.value = hp
	print("Current HP: ",hp)
	if hp <= 0:
		death()

func _on_fire_ball_timer_timeout():
	fireball_ammo += fireball_baseammo + additional_attacks
	FireBallAttackTimer.start()

func _on_fire_ball_attack_timer_timeout():
	if aiming_mode == "automatic":
		if fireball_ammo > 0:
			var fireball_attack = fireBall.instantiate()
			fireball_attack.global_position = global_position
			var closest_enemy = get_closest_enemy()
			if closest_enemy:
				fireball_attack.target = closest_enemy.global_position
			else:
				fireball_attack.target = global_position + last_movement * 100 
			fireball_attack.level = fireball_level
			add_child(fireball_attack)
			fireball_ammo -= 1
	elif aiming_mode == "manual":
		return shoot_manual()
	if fireball_ammo > 0:
		FireBallAttackTimer.start()
	else:
		FireBallAttackTimer.stop()


func _on_nebula_timer_timeout():
	nebula_ammo += nebula_baseammo + additional_attacks
	NebulaAttackTimer.start()

func _on_nebula_attack_timer_timeout():
	if nebula_ammo > 0:
		var nebula_attack = nebula.instantiate()
		nebula_attack.global_position = global_position
		nebula_attack.target = get_random_target()
		nebula_attack.level = nebula_level
		add_child(nebula_attack)
		nebula_ammo -= 1
	if nebula_ammo > 0:
		NebulaAttackTimer.start()
	else:
		NebulaAttackTimer.stop()

func spawn_staff():
	var get_staff_total = staffBase.get_child_count()
	var count_spawns = staff_ammo - get_staff_total
	while count_spawns > 0:
		var staff_spawn = staff.instantiate()
		staff_spawn.global_position = global_position
		staffBase.add_child(staff_spawn)
		count_spawns -= 1
	var get_staff = staffBase.get_children()
	for i in get_staff:
		if i.has_method("update_staff"):
			i.update_staff()

func _on_change_aim_mode(mode: String):
	aiming_mode = GameData.aiming_mode

func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close[randi() % enemy_close.size()].global_position
	else:
		return global_position + last_movement * 100

func get_closest_enemy():
	var closest_enemy = null
	var closest_distance = INF  
	for enemy in enemy_close:
		var distance_to_enemy = global_position.distance_to(enemy.global_position)
		if distance_to_enemy < closest_distance:
			closest_distance = distance_to_enemy
			closest_enemy = enemy
	return closest_enemy

func get_manual_target():
	shoot_manual()
	return get_global_mouse_position()

func shoot_manual():
	if fireball_level > 0 and fireball_ammo > 0:
		var fireball_attack = fireBall.instantiate()
		fireball_attack.global_position = global_position 
		var mouse_position = get_global_mouse_position()
		var direction = (mouse_position - global_position).normalized()
		fireball_attack.angle = direction
		fireball_attack.speed = fireball_attack.speed      
		fireball_attack.level = fireball_level
		add_child(fireball_attack)
		fireball_ammo -= 1
		if fireball_ammo <= 0:
			FireBallTimer.stop()
			reload_timer.start()

func get_target():
	if aiming_mode == "automatic":
		return get_closest_enemy()
	elif aiming_mode == "manual":
		return get_manual_target()

func _on_reload_timer_timeout():
	# Mermiyi yenile
	fireball_ammo = fireball_baseammo + additional_attacks
	FireBallTimer.start() 

func _on_enemy_detection_area_body_entered(body):
	if body.is_in_group("enemy") and body != self and not enemy_close.has(body):
		enemy_close.append(body)

func _on_enemy_detection_area_body_exited(body):
	if body.is_in_group("enemy") and enemy_close.has(body):
		enemy_close.erase(body)

func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self

func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		var exp_orb = area.collect()
		calculate_exp(exp_orb)

func calculate_exp(exp_orb):
	var exp_required = calculate_expcap()
	total_exp += exp_orb
	if exp_value + total_exp >= exp_required: #level_up
		total_exp -= exp_required - exp_value
		exp_level += 1
		exp_value = 0 
		exp_required = calculate_expcap()
		levelup()
	else:
		exp_value += total_exp
		total_exp = 0
	set_expbar(exp_value, exp_required)

func calculate_expcap():
	var exp_cap = exp_level
	if exp_level < 20:
		exp_cap = exp_level*5
	elif exp_level <40 :
		exp_cap + 95 * (exp_level-19)*8
	else:
		exp_cap = 255 + (exp_level - 39)*12
	return exp_cap

func set_expbar(set_value = 1, set_max_value = 100):
	expBar.value = set_value
	expBar.max_value = set_max_value

func levelup():
	sndLevelUp.play()
	label_level.text = str("Level: ",exp_level)
	var tween = levelPanel.create_tween()
	tween.tween_property(levelPanel,"position",Vector2(180,50),0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.play()
	levelPanel.visible = true
	var options = 0
	var optionsmax = 3
	while options < optionsmax:
		var option_choice = itemOptions.instantiate()
		option_choice.item = get_random_item()
		upgradeOptions.add_child(option_choice)
		options += 1
	get_tree().paused = true

func upgrade_character(upgrade):
	match upgrade:
		"fireball1":
			fireball_level = 1
			fireball_baseammo += 1
		"fireball2":
			fireball_level = 2
			fireball_baseammo += 1
		"fireball3":
			fireball_level = 3
		"fireball4":
			fireball_level = 4
			fireball_baseammo += 2
		"nebula1":
			nebula_level = 1
			nebula_baseammo += 1
		"nebula2":
			nebula_level = 2
			nebula_baseammo += 1
		"nebula3":
			nebula_level = 3
			nebula_attackspeed -= 0.5
		"nebula4":
			nebula_level = 4
			nebula_baseammo += 1
		"staff1":
			staff_level = 1
			staff_ammo  = 1
		"staff2":
			staff_level = 2
		"staff3":
			staff_level = 3
		"staff4":
			staff_level = 4
		"armor1","armor2","armor3","armor4":
			armor += 1
		"speed1":
			movement_speed += 10 
		"speed2":
			movement_speed += 18
		"speed3":
			movement_speed += 25
		"speed4":
			movement_speed += 30
		"expand1","expand2","expand3","expand4":
			spell_size += 0.10
		"scroll1","scroll2","scroll3","scroll4":
			spell_cdr += 0.05
		"ring1","ring2":
			additional_attacks += 1
		"food":
			hp += 20
			hp = clamp(hp,0,maxhp)
		"collector1":
			grabAreaCollision.shape.radius *= 1.25
		"collector2":
			grabAreaCollision.shape.radius *= 1.35
		"collector3":
			grabAreaCollision.shape.radius *= 1.50
		"thirdeye1","thirdeye2","thirdeye3","thirdeye4":
			fov.texture_scale += 0.1
			spell_cdr += 0.05
	attack()
	var option_children = upgradeOptions.get_children()
	for i in option_children:
		i.queue_free()
	upgrade_options.clear()
	collected_upgrades.append(upgrade)
	levelPanel.visible = false
	levelPanel.position = Vector2(800,50)
	get_tree().paused = false
	calculate_exp(0)

func get_random_item():
	var dblist = []
	for i in UpgradeDb.UPGRADES:
		if i in collected_upgrades: #hazırda alınan gelıstırmelerı bul
			pass
		elif i in upgrade_options: #gelistirme zaten seçenekte varsa
			pass
		elif UpgradeDb.UPGRADES[i]["type"] == "item":
		#level up'da başka hiçbir seçenek kalmaması durumunda yemek spamlaması için 
			pass
		elif UpgradeDb.UPGRADES[i]["prerequisite"].size() > 0:
			var to_add = true
			for j in UpgradeDb.UPGRADES[i]["prerequisite"]:
				if not j in collected_upgrades:
					to_add = false
				if to_add:
					dblist.append(i)
		else:
			dblist.append(i)
	if dblist.size() > 0:
		var randomitem = dblist.pick_random()
		upgrade_options.append(randomitem)
		return randomitem
	else:
		return null

func time_counter(argtime = 0):
	time = argtime
	var get_m = int(time/60.0)
	var get_s = time % 60
	if get_m < 10:
		get_m = str(0, get_m)
	if get_s < 10:
		get_s = str(0,get_s)
	label_Timer.text = str(get_m,":",get_s)

func death():
	sprite.play("death")
	deathPanel.visible = true
	get_tree().paused = true
	var tween = deathPanel.create_tween()
	tween.tween_property(deathPanel,"position",Vector2(180,50),3.0).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	if time >= 900:
		lblResult.text = "You MADE IT !!!"
		sndVictory.play()
	else:
		lblResult.text = "Next Time Buddy!"
		sndLose.play()
		
func _on_timer_timeout():
	queue_free()

func _on_btn_menu_click_end():
	get_tree().paused = false
	var _level = get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
