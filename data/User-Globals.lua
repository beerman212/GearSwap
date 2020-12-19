--This is where functions go that are for all characters that you play.
data.weaponskills.elemental = S{'Wildfire','Leaden Salute','Sanguine Blade','Aeolian Edge','Cataclysm','Trueflight','Tachi: Jinpu','Flash Nova','Seraph Blade','Seraph Strike','Red Lotus Blade','Herculean Slash','Blade: Ei'}
data.jobs.lugra_jobs = S{'WAR','PLD','DRK','BST','SAM','NIN'}

send_command('alias getslips get storage slip* all')
send_command('alias putslips put storage slip* case all')
send_command('alias gearup gs org; wait 5; getslips; wait 5; po swap; wait 40; putslips; wait 5; gs c lock')

function user_self_command(commandArgs, eventArgs)
    if commandArgs[1] == "lock" and lockstyle then
        eventArgs.handled = true
        lockstyle()
    end
end