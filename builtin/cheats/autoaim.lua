-- Credits to cora

local function look_nearest()
    if not minetest.localplayer then return end 
    local player = minetest.localplayer
    for k, v in ipairs(minetest.get_objects_inside_radius(player:get_pos(), 7)) do
        if (v:is_player() and v:get_name() ~= minetest.localplayer:get_name()) then
            local pos = v:get_pos()
            pos.y = pos.y - 1
            ws.aim(pos)
            return
        end
    end
end

minetest.register_globalstep(function()
    if minetest.settings:get_bool("autoaim") then
        look_nearest()
    end
end)

minetest.register_cheat("Autoaim", "Combat", "autoaim")
