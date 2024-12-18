-- Thanks j45 for designing the original code for placing blocks around a player

local spam_mode = 1

local function cryspam_player(pos)
    if spam_mode == 1 then
        minetest.switch_to_item("mcl_core:obsidian")
        minetest.place_node(vector.add(pos, {x = 0, y = -1, z = 0}))
        
        minetest.switch_to_item("mcl_end:crystal")
        if not minetest.place_node(vector.add(pos, {x = 0, y = -1, z = 0})) then
            minetest.dig_node(vector.add(pos, {x = 0, y = -1, z = 0}))
        spam_mode = 2
        minetest.after(0.5, function()
            spam_mode = 1 
        end)
        end
    end
end

minetest.register_globalstep(function()
    local player = minetest.localplayer

    if minetest.settings:get_bool("crystalspam") then
       if not minetest.settings:get_bool("autototem") then
        local message = minetest.colorize("#696969", "[CrystalSpam]:") .. 
                        minetest.colorize("#FFFFFF", " Turning AutoTotem on for a more secure usage of this CSM.")
        ws.dcm(message)
        minetest.settings:set_bool("autototem", true)
    end
        for _, obj in ipairs(minetest.get_objects_inside_radius(player:get_pos(), 7)) do
            local cryspam_object = true
            
            if obj:is_local_player() or not obj:is_player() then
                cryspam_object = false
            end

            if cryspam_object then
                cryspam_player(obj:get_pos())
            end

            if obj:get_item_textures() == "mcl_end_crystal.png" then
                obj:punch()
            end
        end
    end
end)

minetest.register_cheat("CrystalSpam", "Combat", "crystalspam")
