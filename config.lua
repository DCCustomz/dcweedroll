Config = {}

Config.Framework = 'QBCore' -- or ESX

Config.Notify = 'qb' -- or 'qb' or 'esx' or 'custom' (need to add your custom in server.lua) 

Config.RollableItems = { --Items player must have in inventory to iniate the roll up process. Only need 1 of these.
	blunts = {
		'backwood',
		'backwoods_grape',
		'grabbaleaf',
		-- Add more
	},	
	joints = {
		'marleypaper',
		'rawclassic',
		'rawhemp',
		-- Add more
	}
}

Config.UsableItems = {
	['biscotti_gram'] = { -- The item that will get used to initiate the roll up process. Can be anything
		backwood = 'biscotti_blunt', --Item needed to roll up this item as a blunt, along with the item player will recieve when finished
		backwoods_grape = 'biscotti_blunt', --Item needed to roll up this item as a grabbajoint, along with the item player will recieve when finished
		grabbaleaf = 'biscotti_blunt', --Item needed to roll up this item as a grabbajoint, along with the item player will recieve when finished
		marleypaper = 'biscotti_joint', --Item needed to roll up this item as a joint, along with the item player will recieve when finished
		rawpaper = 'biscotti_joint', --Item needed to roll up this item as a joint, along with the item player will recieve when finished
		rawhemp = 'biscotti_joint', --Item needed to roll up this item as a joint, along with the item player will recieve when finished
	},
	-- Add the rest of your items here	
}
