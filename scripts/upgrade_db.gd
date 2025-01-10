extends Node

const ICON_PATH = "res://Textures/Items/Upgrades/"
const WEAPON_PATH = "res://Textures/Items/Weapons/"
const UPGRADES = {
	"fireball1": {
		"icon": WEAPON_PATH + "sorcerer_fireball.png",
		"displayname": "Fireball",
		"details": "Fireball, thats it.",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"fireball2": {
		"icon": WEAPON_PATH + "sorcerer_fireball.png",
		"displayname": "Fireball",
		"details": "Your hands warmed up,+1 additional fireball.",
		"level": "Level: 2",
		"prerequisite": ["fireball1"],
		"type": "weapon"
	},
	"fireball3": {
		"icon": WEAPON_PATH + "sorcerer_fireball.png",
		"displayname": "Fireball",
		"details": "Feeling pyro today,now pass through another enemy and do + 3 damage.",
		"level": "Level: 3",
		"prerequisite": ["fireball2"],
		"type": "weapon"
	},
	"fireball4": {
		"icon": WEAPON_PATH + "sorcerer_fireball.png",
		"displayname": "Fireball",
		"details": "Master of pyro taught you how to fire fireball, +2 additional fireball.",
		"level": "Level: 4",
		"prerequisite": ["fireball3"],
		"type": "weapon"
	},
	"staff1": {
		"icon": WEAPON_PATH + "sorcerer_staff.png",
		"displayname": "Sorcerer Staff",
		"details": "A magical (somehow) staff will follow you attacking enemies in a straight line",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"staff2": {
		"icon": WEAPON_PATH + "sorcerer_staff.png",
		"displayname": "Sorcerer Staff",
		"details": "The staff loved you, will now attack an additional enemy per attack",
		"level": "Level: 2",
		"prerequisite": ["staff1"],
		"type": "weapon"
	},
	"staff3": {
		"icon": WEAPON_PATH + "sorcerer_staff.png",
		"displayname": "Sorcerer Staff",
		"details": "The staff feels protective today,attack another enemy",
		"level": "Level: 3",
		"prerequisite": ["staff2"],
		"type": "weapon"
	},
	"staff4": {
		"icon": WEAPON_PATH + "sorcerer_staff.png",
		"displayname": "Sorcerer Staff",
		"details": "The staff becomes very aggressive,+5 damage and +20% knockback",
		"level": "Level: 4",
		"prerequisite": ["staff3"],
		"type": "weapon"
	},
	"nebula1": {
		"icon": WEAPON_PATH + "nebula.png",
		"displayname": "Nebula",
		"details": "Space cloud with cosmic power,randomly goes of your direction",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"nebula2": {
		"icon": WEAPON_PATH + "nebula.png",
		"displayname": "Nebula",
		"details": "You learned how to control clouds,an additional Nebula is created",
		"level": "Level: 2",
		"prerequisite": ["nebula1"],
		"type": "weapon"
	},
	"nebula3": {
		"icon": WEAPON_PATH + "nebula.png",
		"displayname": "Nebula",
		"details": "You get used to use this power, cooldown reduced by 0.5 seconds.",
		"level": "Level: 3",
		"prerequisite": ["nebula2"],
		"type": "weapon"
	},
	"nebula4": {
		"icon": WEAPON_PATH + "nebula.png",
		"displayname": "Nebula",
		"details": "Became master of cosmic powers,another nebula created,+25% knockback",
		"level": "Level: 4",
		"prerequisite": ["nebula3"],
		"type": "weapon"
	}, 
	"armor1": {
		"icon": ICON_PATH + "armor.png",
		"displayname": "Armor",
		"details": "Little defence not that bad,reduces damage by 1 point",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"armor2": {
		"icon": ICON_PATH + "armor.png",
		"displayname": "Armor",
		"details": "Time to gear up,reduces damage by an additional 1 point",
		"level": "Level: 2",
		"prerequisite": ["armor1"],
		"type": "upgrade"
	},
	"armor3": {
		"icon": ICON_PATH + "armor.png",
		"displayname": "Armor",
		"details": "Medieval stuff showed up here,reduces damage by an additional 1 point",
		"level": "Level: 3",
		"prerequisite": ["armor2"],
		"type": "upgrade"
	},
	"armor4": {
		"icon": ICON_PATH + "armor.png",
		"displayname": "Armor",
		"details": "Okay time to go heavy,reduces damage by an additional 1 point",
		"level": "Level: 4",
		"prerequisite": ["armor3"],
		"type": "upgrade"
	},
	"speed1": {
		"icon": ICON_PATH + "boots.png",
		"displayname": "Speed",
		"details": "Running matters,Movement speed increased by 10 units",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"speed2": {
		"icon": ICON_PATH + "boots.png",
		"displayname": "Speed",
		"details": "Are you going to race with cheetahs?Movement speed increased by 18 units",
		"level": "Level: 2",
		"prerequisite": ["speed1"],
		"type": "upgrade"
	},
	"speed3": {
		"icon": ICON_PATH + "boots.png",
		"displayname": "Speed",
		"details": "Nearly speed of light there,movement speed increased by 25 units",
		"level": "Level: 3",
		"prerequisite": ["speed2"],
		"type": "upgrade"
	},
	"speed4": {
		"icon": ICON_PATH + "boots.png",
		"displayname": "Speed",
		"details": "Now you need to wait for light to catch you,movement speed increased by 30 units",
		"level": "Level: 4",
		"prerequisite": ["speed3"],
		"type": "upgrade"
	},
	"expand1": {
		"icon": ICON_PATH + "expand.png",
		"displayname": "Expansion Spell",
		"details": "Bulk session,increases spell size by +%10(base)",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"expand2": {
		"icon": ICON_PATH + "expand.png",
		"displayname": "Expansion Spell",
		"details": "Getting bigger,increases spell size by +%10(base)",
		"level": "Level: 2",
		"prerequisite": ["expand1"],
		"type": "upgrade"
	},
	"expand3": {
		"icon": ICON_PATH + "expand.png",
		"displayname": "Expansion Spell",
		"details": "Sometimes size matters,increases spell size by +%10(base)",
		"level": "Level: 3",
		"prerequisite": ["expand2"],
		"type": "upgrade"
	},
	"expand4": {
		"icon": ICON_PATH + "expand.png",
		"displayname": "Expansion Spell",
		"details": "Thats enough for acceptable size,increases spell size by +%10(base)",
		"level": "Level: 4",
		"prerequisite": ["expand3"],
		"type": "upgrade"
	},
	"scroll1": {
		"icon": ICON_PATH + "cooldown.png",
		"displayname": "Scroll",
		"details": "Started to read something,cooldown reduced by %5",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"scroll2": {
		"icon": ICON_PATH + "cooldown.png",
		"displayname": "Scroll",
		"details": "You are a good reader,cooldown reduced by %5",
		"level": "Level: 2",
		"prerequisite": ["scroll1"],
		"type": "upgrade"
	},
	"scroll3": {
		"icon": ICON_PATH + "cooldown.png",
		"displayname": "Scroll",
		"details": "Pages goes like rivers,cooldown reduced by %5",
		"level": "Level: 3",
		"prerequisite": ["scroll2"],
		"type": "upgrade"
	},
	"scroll4": {
		"icon": ICON_PATH + "cooldown.png",
		"displayname": "Scroll",
		"details": "You do not need eyes to read anymore,cooldown reduced by %5",
		"level": "Level: 4",
		"prerequisite": ["scroll3"],
		"type": "upgrade"
	},
	"ring1": {
		"icon": ICON_PATH + "additional.png",
		"displayname": "Ring",
		"details": "Your spells now spawn 1 more additional attack,more is better!",
		"level": "Level: 1",
		"prerequisite": ["fireball4","nebula4","staff4"],
		"type": "upgrade"
	},
	"ring2": {
		"icon": ICON_PATH + "additional.png",
		"displayname": "Ring",
		"details": "Your spells now spawn an additional attack,more more is more better!",
		"level": "Level: 2",
		"prerequisite": ["ring1","fireball4","nebula4","staff4"],
		"type": "upgrade"
	},
		"firebreath1": {
		"icon": WEAPON_PATH + "firebreath.png",
		"displayname": "Fire Breath",
		"details": "A fire comes out of your body from one direction(like a fart).",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	
		"firebreath2": {
		"icon": WEAPON_PATH + "firebreath.png",
		"displayname": "Fire Breath",
		"details": "Adds 1 more direction(finally mouth-like) .",
		"level": "Level: 2",
		"prerequisite": ["firebreath1"],
		"type": "weapon"
	},
		"firebreath3": {
		"icon": WEAPON_PATH + "firebreath.png",
		"displayname": "Fire Breath",
		"details": "Adds 1 more direction(no comment) .",
		"level": "Level: 3",
		"prerequisite": ["firebreath2"],
		"type": "weapon"
	},
		"firebreath4": {
		"icon": WEAPON_PATH + "firebreath.png",
		"displayname": "Fire Breath",
		"details": "Adds 1 more direction.",
		"level": "Level: 4",
		"prerequisite": ["firebreath3"],
		"type": "weapon"
	},
		"collector1": {
		"icon": ICON_PATH + "collectors_hand.png",
		"displayname": "Collector's Hand",
		"details": "Increases the pickup range by %25",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
		"collector2": {
		"icon": ICON_PATH + "collectors_hand.png",
		"displayname": "Collector's Hand",
		"details": "Increases the pickup range by %35",
		"level": "Level: 2",
		"prerequisite": ["collector1"],
		"type": "upgrade"
	},
		"collector3": {
		"icon": ICON_PATH + "collectors_hand.png",
		"displayname": "Collector's Hand",
		"details": "Increases the pickup range by %50",
		"level": "Level: 3",
		"prerequisite": ["collector2"],
		"type": "upgrade"
	},
		"skull1": {
		"icon": WEAPON_PATH + "skull.png",
		"displayname": "Skull Chamber",
		"details": "A skull rotating around your orbit,that's cool.",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
		"skull2": {
		"icon": WEAPON_PATH + "skull.png",
		"displayname": "Skull Chamber",
		"details": "Another skull added your orbit, size and damage increased 25%.",
		"level": "Level: 2",
		"prerequisite": ["skull1"],
		"type": "weapon"
	},
		"skull3": {
		"icon": WEAPON_PATH + "skull.png",
		"displayname": "Skull Chamber",
		"details": "Another skull added your orbit, size and damage increased 25%.",
		"level": "Level: 3",
		"prerequisite": ["skull2"],
		"type": "weapon"
	},
		"skull4": {
		"icon": WEAPON_PATH + "skull.png",
		"displayname": "Skull Chamber",
		"details": "Another skull added your orbit, size and damage increased 25%.",
		"level": "Level: 4",
		"prerequisite": ["skull3"],
		"type": "weapon"
	},
		"thirdeye1": {
		"icon": ICON_PATH + "thirdeye.png",
		"displayname": "Third Eye",
		"details": "Expands your vision little bit and reduces cooldown by %5.",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
		"thirdeye2": {
		"icon": ICON_PATH + "thirdeye.png",
		"displayname": "Third Eye",
		"details": "Expands your vision little bit and reduces cooldown by %5.",
		"level": "Level: 2",
		"prerequisite": ["thirdeye1"],
		"type": "upgrade"
	},
		"thirdeye3": {
		"icon": ICON_PATH + "thirdeye.png",
		"displayname": "Third Eye",
		"details": "Expands your vision little bit and reduces cooldown by %5.",
		"level": "Level: 3",
		"prerequisite": ["thirdeye2"],
		"type": "upgrade"
	},
		"thirdeye4": {
		"icon": ICON_PATH + "thirdeye.png",
		"displayname": "Third Eye",
		"details": "Expands your vision little bit and reduces cooldown by %5.",
		"level": "Level: 4",
		"prerequisite": ["thirdeye3"],
		"type": "upgrade"
	},
		"food": {
		"icon": ICON_PATH + "burger.png",
		"displayname": "Burger",
		"details": "An ancient developer food gives you 30 health",
		"level": "",
		"prerequisite": [],
		"type": "item"
	},
}
