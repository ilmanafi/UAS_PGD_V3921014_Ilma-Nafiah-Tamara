extends CenterContainer

onready var tween = $Tween

var sudah_muncul = false

func _ready():
	pass

func muncul():
	tween.interpolate_property(self, "rect_position:y", 267, 56, 1, Tween.TRANS_ELASTIC)
	tween.start()

func _on_mainLagi_pressed():
	get_tree().change_scene("res://Level1.tscn")

func _on_Hero_hero_mati():
	if not sudah_muncul:
		sudah_muncul = true
		muncul()

func _on_ZonaApi_body_entered(body):
	if not sudah_muncul:
		sudah_muncul = true
		muncul()


func _on_keluar_pressed():
	get_tree().change_scene("res://Title.tscn")
