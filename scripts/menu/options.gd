extends MarginContainer
class_name Options

@export var master_val:Label
@export var music_val:Label
@export var sfx_val:Label

@export var slider_master_val:HSlider
@export var slider_music_val:HSlider
@export var slider_sfx_val:HSlider

func _ready() -> void:
	_on_master_vol_slider_value_changed(slider_master_val.value)
	_on_sfx_vol_slider_value_changed(slider_sfx_val.value)
	_on_music_vol_slider_value_changed(slider_music_val.value)

func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func _on_option_button_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

func _on_master_vol_slider_value_changed(value: float) -> void:
	var bus_index = AudioServer.get_bus_index("Master")
	master_val.text = str("%*d%%" % [3, value])
	AudioServer.set_bus_volume_linear(bus_index, value/100.0)

func _on_music_vol_slider_value_changed(value: float) -> void:
	var bus_index = AudioServer.get_bus_index("Music")
	music_val.text = str("%*d%%" % [3, value])
	AudioServer.set_bus_volume_linear(bus_index, value/100.0)

func _on_sfx_vol_slider_value_changed(value: float) -> void:
	sfx_val.text = str("%*d%%" % [3, value])
	var bus_index = AudioServer.get_bus_index("SFX")
	
	AudioServer.set_bus_volume_linear(bus_index, value/100.0)
