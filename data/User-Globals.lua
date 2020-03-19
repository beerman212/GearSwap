--This is where functions go that are for all characters that you play.

function user_self_command(commandArgs, eventArgs)
    if commandArgs[1] == "lock" and lockstyle then
        eventArgs.handled = true
        lockstyle()
    elseif commandArgs[1] == "skillcure" then
        skillcure()
    elseif commandArgs[1] == "skillenhance" then
        skillenhance()
    -- elseif commandArgs[1] == "getslips" then
    --     eventArgs.handled = true

    -- elseif commandArgs[1] == "putslips" then
    --     eventArgs.handled = true

    end
end

-- function extra_user_customize_idle_set(idleSet)
--     if state.RPMode and state.RPMode.value == true and world.area:startswith('Dynamis') and world.area:endswith('[D]') then
--         idleSet = set_combine(idleSet, sets.RP or {})
--     end
-- end

-- function extra_user_customize_melee_set(meleeSet)
--     if state.RPMode and state.RPMode.value == true and world.area:startswith('Dynamis') and world.area:endswith('[D]') then
--         meleeSet = set_combine(meleeSet, sets.RP or {})
--     end
-- end

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

function skillcure()
    if buffactive.Refresh then
        windower.chat.input('/ma "Cure" <me>')
        coroutine.schedule(skillcure, 8)
    else
        windower.chat.input('/ma "Refresh" <me>')
        coroutine.schedule(skillcure, 12)
    end
    
end

function skillenhance()
    if not buffactive.Refresh then
        windower.chat.input('/ma "Refresh" <me>')
        coroutine.schedule(skillenhance, 12)
    elseif buffactive.Barstone then
        windower.chat.input('/ma "Barfira" <me>')
        coroutine.schedule(skillenhance, 6)
    elseif buffactive.Barfire then
        windower.chat.input('/ma "Barwatera" <me>')
        coroutine.schedule(skillenhance, 6)
    else
        windower.chat.input('/ma "Barstonra" <me>')
        coroutine.schedule(skillenhance, 6)
    end
end