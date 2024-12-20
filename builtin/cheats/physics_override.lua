-- Credits to Lizzy Fleckenstein
-- lgpl license

local legit_override

local function get_override_factor(name)
	if minetest.settings:get_bool("override_" .. name) then
		return tonumber(minetest.settings:get("override_" .. name .. "_factor")) or 1
	else
		return 1.0
	end
end

minetest.register_globalstep(function()
	if not legit_override then return end
	local override = table.copy(legit_override)
	override.speed = override.speed * get_override_factor("speed")
	override.jump = override.jump * get_override_factor("jump")
	override.gravity = override.gravity * get_override_factor("gravity")
	minetest.localplayer:set_physics_override(override)
end)

minetest.register_on_recieve_physics_override(function(override)
	legit_override = override
    return true
end) 

minetest.register_cheat("SpeedOverride", "Movement", "override_speed")
minetest.register_cheat("GravityOverride", "Movement", "override_gravity")
minetest.register_cheat("JumpOverride", "Movement", "override_jump")
