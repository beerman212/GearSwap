-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Suppa','DWEarrings','DWMax'}
    state.HybridMode:options('Normal','DTLite','PDT','MDT')
    state.IdleMode:options('Default','Sphere')
    state.MagicalDefenseMode:options('MDT')
	state.OffenseMode:options('Normal', 'SomeAcc','Acc','FullAcc','Fodder')
    state.PhysicalDefenseMode:options('PDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Default','None')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder','Proc')
	
    -- Typically on Job Setup file, but adding for sub lvl 99 -- Comment out when maxed
    state.MainStep = M{['description']='Main Step','Box Step','Quickstep','Feather Step','Stutter Step'}
    state.AltStep = M{['description']='Alt Step','Quickstep','Stutter Step','Feather Step','Box Step'}
    state.UseAltStep = M(true, 'Use Alt Step')
    state.CurrentStep = M{['description']='Current Step', 'Main', 'Alt'}

	state.AutoPrestoMode = M(False, 'Auto Presto Mode')
	state.DanceStance = M{['description']='Dance Stance','None','Saber Dance','Fan Dance'}


	autows = "Rudra's Storm"
	autofood = 'Sublime Sushi'
	
    -- JSE Cape Variants
	gear.senuna_crit = {name="Senuna's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10'}}                         -- DEX Mod Multihit with Crit Chance WSs (e.g. Eviseration)
	gear.senuna_da = {name="Senuna's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10'}}                              -- STR Mod Multihit WSs (e.g. Pyrrhic Kleos)
	gear.senuna_stp = {name="Senuna's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%'}} -- TP
    gear.senuna_wsdp = {name="Senuna's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%'}}                 -- DEX Mod fTP Modified Physical WSs (e.g. Rudra's Storm)
    gear.senuna_wsdm = {name="Senuna's Mantle",augments={'DEX+20','Mag. Acc+20 /Mag. Dmg.+20','DEX+10','Weapon skill damage +10%'}}             -- DEX Mod fTP Modified Physical WSs (e.g. Aeolian Edge)
    
    --[[ Hot Keys where
        @ = Windows Key
        % = Works only when text bar not up.
        $ = Works only when text bar is up.
        ^ = Control Key
        ! = Alt Key
        ~ = Shift Key
        # = Apps Key        ]]
        send_command('bind @` gs c step')                                   -- Windows + `              = 
        send_command('bind ^!@` gs c toggle usealtstep')                    -- Ctrl + Alt + Windows + ` =
        send_command('bind ^@` gs c cycle mainstep')                        -- Ctrl + Windows + `       =   
        send_command('bind !@` gs c cycle altstep')                         -- Alt + Windows + `        =
        send_command('bind ^` input /ja "Saber Dance" <me>')                -- Crtl + `                 = Use Saber Dance on Myself
        send_command('bind !` input /ja "Fan Dance" <me>')                  -- Alt + `                  = Use Fan Dance on Myself
        send_command('bind ^\\\\ input /ja "Chocobo Jig II" <me>')          -- Ctrl + \                 = Use Chocobo Jig II on Myself
        send_command('bind !\\\\ input /ja "Spectral Jig" <me>')            -- Alt + \                  = Use Spectral Jig on Myself
        send_command('bind !backspace input /ja "Reverse Flourish" <me>')   -- Alt + Backspace          = Use Reverse Flourish on Myself
        send_command('bind ^backspace input /ja "No Foot Rise" <me>')       -- Ctrl + Backspace         = Use No Foot Rise on Myself
        send_command('bind %~` gs c cycle SkillchainMode')                  -- ONLY WITH TEXT BAR NOT UP
                                                                            -- Shift + `                = Cycle SkillchainMode

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
------------------------------------------------------------------------------------------------------------------------------------------------------
--[[ Defined Sets
    Gear can be Defined in 1 of 3 ways
        1. Referencing a universal set as defined in the [Charactername].Globals.lua
            e.g. the TreasureHunter set, which usually has the Chaac Belt defined in the Globals because it is equipable by all jobs
            and other job specific gear with TH like Dark Matter enhanced Reisenjima Equipment
        2. Referencing a set defined somewhere in the code above the reference in this lua
            e.g. the Fast Cast Precast sets have been set up by first establishing a baseline Fast Cast set, and then
            building for specific scenarios by starting with the baseline and modifying gear for those scenarios
        3. Within the {} entering individualized equipment locations and the name of the equipment
            simply put, enter the equipment slot name (e.g. Main, Sub, Head, Body...),
                the equals sign (=) and then
                in quotes (""), the name of the equipment
            e.g. {Waist = "Chaac Belt"} as used int the globals for TreasureHunter
        Complete list of Equipment Slots:
        main, sub, range, ammo, head, neck, ear1, ear2, body, hands, ring1, ring2, back, waist, legs, feet      ]]
------------------------------------------------------------------------------------------------------------------------------------------------------
	
    --[[ Weapons Sets establish the Main and Sub slots for state.Weapons:options()
        Can be cycled through using the F7 key in the order defined above in the state.Weapons:options()
        To define in the state.Weapons:options(), type the value below after sets.weapons. within the parenthesis surrounded by apostrophies (')
        e.g. sets.weapons.Default = state.Weapons:options('Default')
        If not defined in the state.Weapons:options() above, it will not be accessible by the F7 cycle hot key          ]]
        sets.weapons.Aeneas = {main="Aeneas",sub="Twashtar"}
        sets.weapons.Default = {main="Bone Knife",sub="Bone Knife"}
        sets.weapons.Tauret = {main="Tauret",sub="Twashtar"}
        sets.weapons.None = {Main=empty,sub=empty}
        sets.weapons.Terpsichore = {main="Terpsichore",sub="Twashtar"}
		
    --[[ Idle Sets establish the gear that will be equipped when no other action is being taken 
        The different modes that can be cycled through as defined in the state.IdleMode:options() of the user_setup
        To define in the state.IdleMode:options(), type the value below after sets.idle. within the parenthesis surrounded by apostrophies (')
        e.g. sets.idle.Default = state.idle:options('Default')
        If not defined in the state.idle:options() above, it will not be accessible by the Windows + F12 cycle hot key          ]]
    sets.idle.Default = {
		ammo=empty,
		head="Raptor Helm",neck="Focus Collar",ear1="Amethyst Earring",ear2="Sardonyx Earring",
		body="Raptor Jerkin",hands="Raptor Gloves",ring1="Bastokan Ring",ring2="Amethyst Ring",
		back="Nexus Cape",waist="Swordbelt",legs="Raptor Trousers",feet="Raptor Ledelsens"}
    sets.idle.Sphere = set_combine(sets.idle, {body="Enforcer's Harness"})
    
    -- Defense sets
    sets.defense.PDT = {}
    sets.defense.MDT = {}
    sets.defense.MEVA = {}
    sets.Kiting = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {}
		
    sets.engaged.DTLite = {}
		
    sets.engaged.SomeAcc = {}
    
	sets.engaged.Acc = {}
		
    sets.engaged.FullAcc = {}

    sets.engaged.Fodder = {}

    sets.engaged.PDT = {}

    sets.engaged.SomeAcc.PDT = {}
		
    sets.engaged.Acc.PDT = {}

    sets.engaged.FullAcc.PDT = {}
		
    sets.engaged.Fodder.PDT = {}

    
    -- Treasure Hunter
    -- Treasure Hunter Mode can be activated/deactivated (set to Tag) using the Ctrl + T Hot Key
    -- Treasure Hunter caps at 4 for non-Thief Jobs and 14 on Thief
    	
	    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
    
    -- Precast Sets
    -- Precast Sets will assess a command and apply this gear before executing and up to the Midcast point
    -- Precast Sets are defined as sets.precast.[Precast Specifier]
    -- [Precast Specifiers]
    -- You may also define specific spells/abilities with a using an additional .[spellname]

    -- Extra Melee sets.  Apply these on top of melee sets.
        sets.Suppa = {}
        sets.DWEarrings = {}
        sets.DWMax = {}
     	
    -- Precast Sets
    
    -- Precast sets to enhance JAs

    sets.precast.JA['No Foot Rise'] = {} --body="Horos Casaque +1"

    sets.precast.JA['Trance'] = {} --head="Horos Tiara +1"
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
		
	sets.Self_Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Samba = {back=gear.stp_jse_back} --head="Maxixi Tiara"

    sets.precast.Jig = {} --legs="Horos Tights", feet="Maxixi Toe Shoes"

    sets.precast.Step = {}
		
    sets.Enmity = {}
		
    sets.precast.JA.Provoke = sets.Enmity

    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] = {}
		
    sets.precast.Flourish1['Animated Flourish'] = sets.Enmity
		
    sets.precast.Flourish1['Desperate Flourish'] = {}

    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = {}

    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Striking Flourish'] = {}
    sets.precast.Flourish3['Climactic Flourish'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Proc = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Rudra's Storm"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {})
	
    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Shark Bite"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Shark Bite"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS["Shark Bite"], {})
	
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Evisceration'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {})
	
    sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Pyrrhic Kleos'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Pyrrhic Kleos'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Pyrrhic Kleos'].Fodder = set_combine(sets.precast.WS['Pyrrhic Kleos'], {})

    sets.precast.WS['Aeolian Edge'] = {}

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
	
    sets.Skillchain = {} --hands="Charis Bangles +2"
    
    
    -- Midcast Sets
    
    sets.midcast.FastRecast = {}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    sets.ExtraRegen = {}
    

    -- Idle sets

    sets.idle = {}
		
    sets.idle.Sphere = set_combine(sets.idle, {})
    
    -- Defense sets

    sets.defense.PDT = {}

    sets.defense.MDT = {}
		
	sets.defense.MEVA = {}

    sets.Kiting = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {}
		
    sets.engaged.DTLite = {}
		
    sets.engaged.SomeAcc = {}
    
	sets.engaged.Acc = {}
		
    sets.engaged.FullAcc = {}

    sets.engaged.Fodder = {}

    sets.engaged.PDT = {}

    sets.engaged.SomeAcc.PDT = {}
		
    sets.engaged.Acc.PDT = {}

    sets.engaged.FullAcc.PDT = {}
		
    sets.engaged.Fodder.PDT = {}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Saber Dance'] = {} --legs="Horos Tights"
    sets.buff['Climactic Flourish'] = {} --head="Charis Tiara +2"
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 19)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 19)
    elseif player.sub_job == 'SAM' then
        set_macro_page(3, 19)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 19)
    else
        set_macro_page(10, 19)
    end
end