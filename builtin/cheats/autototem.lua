-- Credits to Lizzy Fleckenstein

local switched_to_totem = 0
local totem_move_action = InventoryAction("move")
totem_move_action:to("current_player", "offhand", 1)
minetest.settings:set_bool("crystalspam", false)
minetest.settings:set_bool("autototem", false)

minetest.register_globalstep(function(dtime)
	local player = minetest.localplayer
	if not player then return end

	if minetest.settings:get_bool("autototem") then
        totem_stack = minetest.get_inventory("current_player").offhand[1]
		if totem_stack and totem_stack:get_name() ~= "mcl_totems:totem" then
			local totem_index = minetest.find_item("mcl_totems:totem")
			if totem_index then
				totem_move_action:from("current_player", "main", totem_index)
				totem_move_action:apply()

			end
		end
	end
end)

minetest.register_cheat("AutoTotem", "Combat", "autototem")
