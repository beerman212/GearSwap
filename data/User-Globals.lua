--This is where functions go that are for all characters that you play.

function user_self_command(commandArgs, eventArgs)
    if commandArgs[1] == "lock" and lockstyle then
        eventArgs.handled = true
        lockstyle()
    end
end