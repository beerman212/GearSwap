--This is where functions go that are for all characters that you play.

function user_self_command(commandArgs, eventArgs)
    if commandArgs[1] == "lock" and lockstyle then
        eventArgs.handled = true
        lockstyle()
    end
end

function extra_user_customize_idle_set(idleSet)
    if state.RPMode and state.RPMode.value == true and world.area:startswith('Dynamis') and world.area:endswith('[D]') then
        idleSet = set_combine(idleSet, sets.RP or {})
    end
end

function extra_user_customize_melee_set(meleeSet)
    if state.RPMode and state.RPMode.value == true and world.area:startswith('Dynamis') and world.area:endswith('[D]') then
        meleeSet = set_combine(meleeSet, sets.RP or {})
    end
end

function user_state_change(stateField, newValue, oldValue)
    if stateField == 'RPMode' and state.RPMode and sets.RP then
        if newValue == true then
            enable(main,sub,range,neck)
            equip(sets.RP)
            disable(main,sub,range,neck)
        else
            enable(main,sub,range,neck)
        end
    end
end