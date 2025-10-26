@abstract
extends CanvasLayer
class_name ITransition

@warning_ignore("unused_signal")
signal faded_out
@warning_ignore("unused_signal")
signal faded_in

@abstract func fade_out() -> void
@abstract func fade_in() -> void
