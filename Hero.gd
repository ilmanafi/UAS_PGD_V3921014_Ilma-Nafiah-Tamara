extends KinematicBody2D

var laju_cepat = 160
var laju_normal = 80
var laju = laju_normal
var kecepatan = Vector2.ZERO
var laju_lompat = -280
var gravitasi = 12
var koin = 0
var sedang_terluka = false
var maks_health = 200
var health = 200

onready var sprite = $Sprite

signal hero_mati
signal hero_menang
signal hero_update_health(value)
signal hero_update_koin(value)

func _physics_process(delta):
	kecepatan.y = kecepatan.y + gravitasi
	if(not sedang_terluka and Input.is_action_pressed("move_right")):
		kecepatan.x = laju
	if(not sedang_terluka and Input.is_action_pressed("move_left")):
		kecepatan.x = -laju
	if(not sedang_terluka and Input.is_action_just_pressed("fast_run")):
		lari_cepat()
	
	if(not sedang_terluka and Input.is_action_pressed("jump")and is_on_floor()):
		kecepatan.y = laju_lompat
		
	kecepatan.x = lerp(kecepatan.x, 0, 0.2)
	kecepatan = move_and_slide(kecepatan, Vector2.UP)
	
	if not sedang_terluka:
		update_animasi()
	
func update_animasi():
	if is_on_floor():
		if kecepatan.x < (laju * 0.5) and kecepatan.x > (-laju * 0.5):
			sprite.play("diam")
		else:
			if laju == laju_normal:
				sprite.play("lari")
			elif laju == laju_cepat:
				sprite.play("lariCepat")
	else:
		if kecepatan.y > 0:
			sprite.play("lompat")
		else:
			sprite.play("jatuh")
	
	sprite.flip_h = false
	if kecepatan.x < 0:
		sprite.flip_h = true

func lari_cepat():
	laju = laju_cepat
	$Timer.start()

func _on_Timer_timeout():
	laju = laju_normal

func dapat_koin():
	koin += 1
	emit_signal("hero_update_koin", koin)
	var grup_koin = get_tree().get_nodes_in_group("GrupKoin")
	var jumlah_koin = grup_koin.size()
	print("GRUP KOIN : ", grup_koin)
	print("JUMLAH KOIN : ", jumlah_koin)
	if jumlah_koin == 0:
		emit_signal("hero_menang")

func terluka():
	sedang_terluka = true
	
	health -= 25
	emit_signal("hero_update_health", (float(health)/float(maks_health)) * 100)
	if kecepatan.x > 0:
		kecepatan.x = -100
	else :
		kecepatan.x = 100
	sprite.play("terluka")
	yield(get_tree().create_timer(1), "timeout")
	
	if health <= 0:
		mati()
	else:
		sedang_terluka = false
	sedang_terluka = false

func mati():
	sprite.play("mati")
	set_collision_layer_bit(0, false)
	set_collision_mask_bit(2, false)
	yield(get_tree().create_timer(1), "timeout")
	emit_signal("hero_mati")

