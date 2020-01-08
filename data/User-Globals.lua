--This is where functions go that are for all characters that you play.

function user_self_command(commandArgs, eventArgs)
    local command = (table.remove(commandArgs, 1)):lower()

    if command == "lock" and lockstyle then
        eventArgs.handled = true
        lockstyle()
    end
end