extends Control


func _on_ToTitleScreen_pressed():
	if get_tree().change_scene("res://interfaces/title_screen_menus/title_screen_main.tscn") != OK:
		print("An unexpected error occured when trying to switch to the Title Screen scene")


func _on_Audio_pressed():
	SoundHandler.master_mute()


func _on_Developer_pressed():
#	var base = 20
#	var price = rand_range(0, 40)
#
#	var chance = Game.purchase_hndlr.calculate_buy_chance(base, price)
#
#	print("base price of %s, current price of %s, buy chance = %s" % [base, price, chance])
	pass
