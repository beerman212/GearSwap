-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal','PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder')
	state.IdleMode:options('Normal', 'Sphere')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Suppa','DWEarrings','DWMax'}
	state.AmbushMode = M(false, 'Ambush Mode')

	gear.da_jse_back = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	gear.wsd_jse_back = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind !` input /ra <t>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f10 gs c toggle AmbushMode')
	send_command('bind ^backspace gs c weapons Throwing;gs c update')
	send_command('bind !backspace input /ja "Hide" <me>')
	send_command('bind !r gs c weapons MagicWeapons;gs c update')
	send_command('bind ^\\\\ input /ja "Despoil" <t>')
	send_command('bind !\\\\ input /ja "Mug" <t>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
    sets.ExtraRegen = {}
    sets.Kiting = {}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
	
    sets.buff['Sneak Attack'] = {}
    sets.buff['Trick Attack'] = {}
		
    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
	sets.Suppa = {}
	sets.DWEarrings = {}
	sets.DWMax = {}
	sets.Ambush = {} --body="Plunderer's Vest +1"
	
	-- Weapons sets
    sets.weapons.None = {}
    sets.weapons.Aeneas = {main="Aeneas",sub="Taming Sari"}
	sets.weapons.LowBuff = {main="Aeneas",sub="Blurred Knife +1"}
	sets.weapons.MagicWeapons = {main="Malevolence",sub="Malevolence"}
	sets.weapons.Throwing = {main="Aeneas",sub="Taming Sari",range="Comet Tail",ammo=empty}
	
    -- Actions we want to use to tag TH.
    sets.precast.Step = {}
		
    sets.precast.JA['Violent Flourish'] = {}
		
	sets.precast.JA['Animated Flourish'] = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {} --head="Skulker's Bonnet"
    sets.precast.JA['Accomplice'] = {} --head="Skulker's Bonnet"
    sets.precast.JA['Flee'] = {} --feet="Pillager's Poulaines +1"
    sets.precast.JA['Hide'] = {} --body="Pillager's Vest +1"
    sets.precast.JA['Conspirator'] = {} --body="Skulker's Vest"
    sets.precast.JA['Steal'] = {}
	sets.precast.JA['Mug'] = {}
    sets.precast.JA['Despoil'] = {}
    sets.precast.JA['Perfect Dodge'] = {}
    sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

	sets.Self_Waltz = {}
		
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})


    -- Ranged snapshot gear
    sets.precast.RA = {range="Comet Tail"}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Rudra's Storm"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {})
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {})
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {})

    sets.precast.WS["Mandalic Stab"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Mandalic Stab"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["Mandalic Stab"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Mandalic Stab"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Mandalic Stab"].Fodder = set_combine(sets.precast.WS["Mandalic Stab"], {})
    sets.precast.WS["Mandalic Stab"].SA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {})
    sets.precast.WS["Mandalic Stab"].TA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {})
    sets.precast.WS["Mandalic Stab"].SATA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {})

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Shark Bite"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Shark Bite"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS["Shark Bite"], {})
    sets.precast.WS["Shark Bite"].SA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {})
    sets.precast.WS["Shark Bite"].TA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {})
    sets.precast.WS["Shark Bite"].SATA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {})
	
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Evisceration'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})

    sets.precast.WS['Last Stand'] = {}

    sets.precast.WS['Aeolian Edge'] = {}

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {}

    -- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

    -- Ranged gear

    sets.midcast.RA = {}

    sets.midcast.RA.Acc = {}

    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Meg. Cuirie +2",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Sheltered Ring",
        back="Moonlight Cape",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_dt_feet}
		
    sets.idle.Sphere = set_combine(sets.idle, {})

    sets.idle.Weak = set_combine(sets.idle, {})

	sets.DayIdle = {}
	sets.NightIdle = {}

    -- Defense sets

    sets.defense.PDT = {}

    sets.defense.MDT = {}
		
	sets.defense.MEVA = {}


    --------------------------------------
    -- Melee sets  
    --------------------------------------

    -- Normal melee group
    sets.engaged = {}
		
    sets.engaged.SomeAcc = {}
    
	sets.engaged.Acc = {}
		
    sets.engaged.FullAcc = {}

    sets.engaged.Fodder = {}

    sets.engaged.PDT = {}

    sets.engaged.SomeAcc.PDT = {}
		
    sets.engaged.Acc.PDT = {}

    sets.engaged.FullAcc.PDT = {}
		
    sets.engaged.Fodder.PDT = {}
		
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 6)
    elseif player.sub_job == 'DNC' then
        set_macro_page(2, 6)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 6)
    else
        set_macro_page(10, 6)
    end
end