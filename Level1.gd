extends Node2D

onready var health_progress = $CanvasLayer/HealtgBar/TextureProgress
onready var jumlah_koin = $CanvasLayer/KoinBar/Label

func _on_Hero_hero_update_health(value):
	health_progress.value = value

func _on_Hero_hero_update_koin(value):
	jumlah_koin.text = String(value)
