PlayerStandard = PlayerStandard or class(PlayerMovementState)
--percentage chance to stumble/trip from 0 to 100, i suggest below 0.25%
local trip_chance = (0.25 / 100)

Hooks:PostHook(PlayerStandard, "_update_movement", "UpdateMovement", function(self, t, dt)
    if self._running and math.random() <= trip_chance then
        if not self._state_data.ducking then
            self:_start_action_ducking(t)
        end
        self._ext_damage:damage_simple({
            variant = "delayed_tick",
            damage = self._ext_damage:get_real_armor()
        })
        self._ext_damage:damage_simple({
            variant = "delayed_tick",
            damage = self._ext_damage:get_real_health() * 0.1 + 1
        })
        self._ext_damage:_regenerate_armor(true)
    end
end)