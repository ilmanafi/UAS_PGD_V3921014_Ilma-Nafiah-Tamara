extends CenterContainer

onready var tween = $Tween

var sudah_muncul = false

func _ready():
	pass

func muncul():
	tween.interpolate_property(self, "rect_position:y", 267, 56, 1, Tween.TRANS_ELASTIC)
	tween.start()

func _on_Hero_hero_menang():
	muncul()

func _on_Selanjutnya_pressed():
	get_tree().change_scene("res://Level2.tscn")

func _on_keluar_pressed():
	get_tree().change_scene("res://Title.tscn")

func _on_selanjutnya3_pressed():
	get_tree().change_scene("res://Level3.tscn")

func _on_mainLagi_pressed():
	get_tree().change_scene("res://Level1.tscn")
