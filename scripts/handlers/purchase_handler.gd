extends Node

export(Resource) var CUSTO 

# Sibling Nodes
onready var food_hndlr = $"../Food"
onready var custo_hndler = $"../Customer"
onready var ingred_hndler = $"../Ingredient"
onready var waste_hndlr = $"../Waste"

# Adds noise to a float value
func _noisefy(num: float):
    return rand_range(0.95, 1.05) * num

# Handles a customer buying a food item
func start_day() -> void:
    var day_length = rand_range(Game.min_day,Game.max_day)
    var customer_amount = rand_range(Game.min_custo,Game.max_custo)
    var steve_harvey
    var terminal
    var npc_spawner
    if get_tree().current_scene.name == "OnDaylight":
        steve_harvey = get_node("/root/OnDaylight/PauseFrame/SteveHarvey")
        terminal = get_node("/root/OnDaylight/VBoxContainer/HBoxContainer/GameConsole")
        npc_spawner = get_node("/root/OnDaylight/NPCs/Spawner")
    for i in customer_amount:
        var entry =  create_purchase()
        if entry.empty():
            terminal.add_text("No Food!")
        elif get_tree().current_scene.name == "OnDaylight":
            terminal.add_entry(entry)
        
        SoundHandler.get_node("VineBoom").play()
        npc_spawner.spawnNPC()
        steve_harvey.visible = !steve_harvey.visible
         
        var wait = rand_range(0.7, 1.3) * (day_length/customer_amount)
        yield(get_tree().create_timer(wait), "timeout")
    emit_signal("completed")

func create_purchase() -> Dictionary:
    food_hndlr.update_cookable_food()
    
    var customer = custo_hndler.get_rand_customer()
    var food = food_hndlr.get_food(food_hndlr.get_rand_cookable_food())
    
    # Checks if theres any cookable food
    if food == null: 
        return {}
    elif food.empty():
        return {}
    
    ingred_hndler.spend_ingredients(food)
    var entry = create_sold_food(food, customer)
    _add_purchase(entry)
    
    food_hndlr.update_cookable_food()
    
    return entry

func _add_purchase(entry: Dictionary) -> void:
    Game.money += entry.food_payment
    waste_hndlr.add_waste(randi()%2, entry["waste"])
    Game.satisfaction += entry.satisfaction

func create_sold_food(food: Dictionary, customer: Dictionary) -> Dictionary:
    var food_id = food.id
    var food_type = food.type
    var food_payment = food.base_price
    
    var customer_type = customer.type
    var waste_amnt = int(_noisefy(CUSTO.BASE_WASTE * customer.waste_factor))
    var satisfaction_amnt = _noisefy(CUSTO.BASE_SATISFACTION * customer.satisfaction_factor)
    
    var entry = {
        "food_id": food_id,
        "food_type": food_type,
        "food_payment": food_payment,
        "customer": customer_type,
        "waste": waste_amnt,
        "satisfaction": satisfaction_amnt,
    }
    
    Game.sold_food.append(entry)
    
    return entry
