extends Node


signal game_started
signal game_won
signal game_lost

var game: Game = null
var player: Player = null
var HUD: HUD = null
var infuse_controller = null
var game_decided: bool = false
