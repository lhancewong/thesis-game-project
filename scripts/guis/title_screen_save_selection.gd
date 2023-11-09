extends Control

var save_buttons: Array

func _ready():
    for i in $Background/HBoxContainer/VBoxContainer/GridContainer.get_children():
        save_buttons.append(i.get_node('Save'))
    check_saves()

func check_saves():
    for num in 6:
        var save_path = "user://savegame%s.save" % num
        var save_game = File.new()
        var button_label
        if not save_game.file_exists(save_path):
            button_label = "Save File %s" % (num+1)
        else:
            button_label = "Load File %s" % (num+1)
        save_buttons[num].text = button_label

func save_button_pressed(button_label, num):
    if button_label.begins_with("Save"):
        Game.save_game(num)
    elif button_label.begins_with("Load"):
        Game.load_game(num)
    get_tree().change_scene("res://interfaces/on_daylight_menus/on_daylight_main.tscn")

func _on_ToTitleScreen_pressed():
    if get_tree().change_scene("res://interfaces/title_screen_menus/title_screen_main.tscn") != OK:
        print("An unexpected error occured when trying to switch to the Title Screen scene")

func _on_Save1_pressed():
    var button_label = $Background/HBoxContainer/VBoxContainer/GridContainer/File1/Save.text
    save_button_pressed(button_label, 0)

func _on_Save2_pressed():
    var button_label = $Background/HBoxContainer/VBoxContainer/GridContainer/File2/Save.text
    save_button_pressed(button_label, 1)

func _on_Save3_pressed():
    var button_label = $Background/HBoxContainer/VBoxContainer/GridContainer/File3/Save.text
    save_button_pressed(button_label, 2)

func _on_Save4_pressed():
    var button_label = $Background/HBoxContainer/VBoxContainer/GridContainer/File4/Save.text
    save_button_pressed(button_label, 3)

func _on_Save5_pressed():
    var button_label = $Background/HBoxContainer/VBoxContainer/GridContainer/File5/Save.text
    save_button_pressed(button_label, 4)

func _on_Save6_pressed():
    var button_label = $Background/HBoxContainer/VBoxContainer/GridContainer/File6/Save.text
    save_button_pressed(button_label, 5)

func _on_Delete1_pressed():
    Game.delete_save(0)
    check_saves()

func _on_Delete2_pressed():
    Game.delete_save(1)
    check_saves()

func _on_Delete3_pressed():
    Game.delete_save(2)
    check_saves()

func _on_Delete4_pressed():
    Game.delete_save(3)
    check_saves()

func _on_Delete5_pressed():
    Game.delete_save(4)
    check_saves()

func _on_Delete6_pressed():
    Game.delete_save(5)
    check_saves()
