extends Node

@warning_ignore("unused_signal")
signal selectable_selected(selectable: SelectableComponent)

@warning_ignore("unused_signal")
signal strength_total_updated(total: int, full_all: bool)
@warning_ignore("unused_signal")
signal strength_deducted(deduct_amount: int)
@warning_ignore("unused_signal")
signal strength_recovered
