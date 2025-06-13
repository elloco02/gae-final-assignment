class_name StateMachine

extends Node

@export var initial_state: State

var current_state: State = null
var states: Dictionary = {}

func _ready():
    for child in get_children():
        if child is State:
            states[child.name.to_lower()] = child
            child.on_change.connect(_on_state_change)

    if initial_state:
        initial_state.enter()
        current_state = initial_state


func _process(delta: float):
    if current_state != null:
        current_state._update(delta)


func _physics_process(delta: float):
    if current_state != null:
        current_state._physics_process(delta)


func _on_state_change(calling: State, new_state_name: String):
    if calling != current_state:
        return

    var new_state = states.get(new_state_name.to_lower())
    if !new_state:
        push_error("State not found: " + new_state_name)
        return

    if current_state:
        current_state.exit()

    new_state.enter()
    current_state = new_state