class_name Island
extends Node2D


@onready var nav_region: NavigationRegion2D = $NavigationRegion
@onready var tree_container: Node2D = $NavigationRegion/Trees
@onready var hq: HQStructure = $NavigationRegion/OtherStructures/HQ
@onready var campfire = $NavigationRegion/OtherStructures/Fire
