-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Suppa','DWEarrings','DWMax'}
    state.HybridMode:options('Default','DT','Crit')
    state.IdleMode:options('Default','Sphere')
    state.MagicalDefenseMode:options('MDT')
	state.OffenseMode:options('Default','Acc')
    state.PhysicalDefenseMode:options('PDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Default','None')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder','Proc')
	
    -- Typically on Job Setup file, but adding for sub lvl 99 -- Comment out when level 99
        state.AltStep = M{['description']='Alt Step','Quickstep','Stutter Step','Feather Step','Box Step'}
        state.AutoPrestoMode = M(False,'Auto Presto Mode')
        state.CurrentStep = M{['description']='Current Step','Main','Alt'}
        state.DanceStance = M{['description']='Dance Stance','None','Saber Dance','Fan Dance'}
        state.MainStep = M{['description']='Main Step','Box Step','Quickstep','Feather Step','Stutter Step'}
        state.UseAltStep = M(true, 'Use Alt Step')
    
        autows = "Rudra's Storm"
	    autofood = 'Sublime Sushi'
    
    -- SU5 Weapon
        gear.SetanKober_TP = {name="Setan Kober",augments={'Chance of double damage +50%','Store TP+25','DMG: +5'}}
        gear.SetanKober_JA = {name="Setan Kober",augments={'"Flourish" recast time -25%','"Step" duration +60','DMG: +5'}}

    -- JSE Cape Variants
        gear.senuna_crit = {name="Senuna's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10'}}                         -- DEX Mod Multihit with Crit Chance WSs (e.g. Eviseration)
        gear.senuna_da = {name="Senuna's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10'}}                              -- STR Mod Multihit WSs (e.g. Pyrrhic Kleos)
        gear.senuna_stp = {name="Senuna's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%'}} -- TP
        gear.senuna_waltz = {name="Senuna's Mantle",augments={'CHR+20','CHR+10','"Waltz potency"+10%'}}                                             -- Waltz Potency CHR
        gear.senuna_waltz_self = {name="Senuna's Mantle",augments={'VIT+20','VIT+10','"Waltz potency"+10%'}}                                        -- Waltz Potency Received VIT
        gear.senuna_wsdp = {name="Senuna's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%'}}                 -- DEX Mod fTP Modified Physical WSs (e.g. Rudra's Storm)
        gear.senuna_wsdm = {name="Senuna's Mantle",augments={'DEX+20','Mag. Acc+20 /Mag. Dmg.+20','DEX+10','Weapon skill damage +10%'}}             -- DEX Mod fTP Modified Magical WSs (e.g. Aeolian Edge)
        gear.senuna_wsdp = {name="Senuna's Mantle",augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%'}}                 -- CHR Mod fTP Modified Physical WSs (e.g. Shadowstitch)
        gear.senuna_wsdm = {name="Senuna's Mantle",augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%'}}             -- MND Mod fTP Modified Magical WSs (e.g. Energy Drain/Steal)
    
    --[[ Hot Keys where
            @ = Windows Key
            % = Works only when text bar not up.
            $ = Works only when text bar is up.
            ^ = Control Key
            ! = Alt Key
            ~ = Shift Key
            # = Apps Key                                                                                                            ]]
        send_command('bind @` gs c step')                                   -- Windows + `              = 
        send_command('bind ^!@` gs c toggle usealtstep')                    -- Ctrl + Alt + Windows + ` =
        send_command('bind ^@` gs c cycle mainstep')                        -- Ctrl + Windows + `       = Cycle Main Step  
        send_command('bind !@` gs c cycle altstep')                         -- Alt + Windows + `        = Cycle Alt Step
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
        main, sub, range, ammo, head, neck, ear1, ear2, body, hands, ring1, ring2, back, waist, legs, feet                          ]]
------------------------------------------------------------------------------------------------------------------------------------------------------
	
    --[[ Weapons Sets establish the Main and Sub slots for state.Weapons:options()
            Can be cycled through using the F7 key in the order defined above in the state.Weapons:options()
            To define in the state.Weapons:options(), type the value below after sets.weapons. within the parenthesis surrounded by apostrophies (')
            e.g. sets.weapons.Default = state.Weapons:options('Default')
            If not defined in the state.Weapons:options() above, it will not be accessible by the F7 cycle hot key                  ]]
        sets.weapons.Current = {main="Bone Knife",sub="Bone Knife"}
        sets.weapons.Aeneas = {main="Aeneas",sub="Twashtar"}                    -- Aeonic/Empyrean
        sets.weapons.Tauret = {main="Tauret",sub="Twashtar"}                    -- Ambuscade/Empyrean
        sets.weapons.Terpsichore = {main="Terpsichore",sub="Twashtar"}          -- Mythic/Empyrean
        sets.weapons.SetanKoberTP = {main=gear.SetanKober_TP,sub="Twashtar"}    -- SU5 Path A/Empyrean
		sets.weapons.SetanKoberJA = {main=gear.SetanKober_JA,sub="Twashtar"}    -- SU5 Path C/Empyrean
		
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
    
    --[[ Normal melee group
            TP sets prioritize 1: Multiattack, 2: Store TP, 3: Magic Evasion (to avoid debuffs)
            Accuracy (Acc) sets should prioritize Accuracy over TP set priorities (shoot for 1300 acc)
            Damage Taken (DT) should shoot for 30% PDT and 20% MDT
            Critical Hit Rate (Crit) should prioritize crit rate over all else (e.g. for use to gain beads in Domain Invasion)
                                                                                                                                    ]]
        sets.engaged = {}
        sets.engaged.Acc = {}
        sets.engaged.DT = {}
        sets.engaged.Crit = {}

    --[[ Defense sets
            Defense Sets fall into one of 3 possible categories: Physical (F10), Magical (F11), and Resistance (F12)
            These sets are for emergency use to override current gear with Max Defense focus for the given category
            
            PhysicalDefenseMode is cycled using the Ctrl + F10 hot key
            MagicalDefenseMode is cycled using the Ctrl + F11 hot key
            ResistanceDefenseMode is cycled using the Ctrl + F12 hot key
            
            In order to reset the DefenseMode press the Alt + F12 hot key
            
            DT caps at 50% (shell accounts for 28% of MDT)
            DT II cap caps at 50% but the cumulative DT for DT + DT II cap is 87.5%                                                 ]]
        sets.defense.PDT = {}       
        sets.defense.MDT = {}
        sets.defense.MEVA = {}
        sets.Kiting = {feet="Tandava Crackows"}            -- Toggle using the Alt + F10 hot key -- Obtained in Abyssea - Attowa

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    --[[ Treasure Hunter
            Treasure Hunter Mode can be activated/deactivated (set to Tag) using the Ctrl + T Hot Key
            Treasure Hunter caps at 4 for non-Thief Jobs and 14 on Thief                                                            ]]
    	
	    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
    
    --[[ Precast Sets
        Precast Sets will assess a command and apply this gear before executing and up to the Midcast point
        Precast Sets are defined as sets.precast.Spellname (Spellname only requires [] if there is a space in its name)             ]]

    -- Extra Melee sets.  Apply these on top of melee sets.
        sets.Suppa = {}
        sets.DWEarrings = {}
        sets.DWMax = {}
        sets.MinStepCost = {sub="Setan Kober"}                                                                      -- Setan Kober is SU5 Weapon
        sets.Ranged = {ranged="War Hoop"}                                                                           -- War Hoop is Artifact Weapon (better than 119 options because it is better for waltz)
        
    -- Precast Sets
    
    -- Precast sets to enhance JAs

        sets.precast.Samba = {head="Maxixi Tiara +3",back=gear.senuna_stp}                                          -- + 1 min to Samba Duration
        sets.precast.Jig = {legs="Horos Tights +3",feet="Maxixi Toeshoes +3"}                                       -- Cap is 50% increase to duration, so technically you only need one
        sets.precast.JA['No Foot Rise'] = {body="Horos Casaque +3"}
        sets.precast.JA['Trance'] = {head="Horos Tiara +3"}
    

    --[[ Waltz Sets
            HP Cured = floor((Waltz Potency gear + Waltz Potency Received) × floor(M × (User's CHR + Target's VIT) + B + 2 × (Waltz Job Point Tiers)))
            Building Walts Sets should:
            1. Max out Waltz Potency at 50% and IF on Self, Max out Waltz Potency Received at 30%
            2. Max out CHR and IF casting on self raise VIT where gear allows for higher VIT than CHR                       ]]
        sets.precast.Waltz = {ammo="Light Sachet",                                                                  -- Light Sachet is from Abyssea - Uleguerand
            head="Maxixi Tiara +3",neck="Etoile Gorget +2",ear1="Handler's Earring +1",ear2="Handler's Earring",    -- Maxixi is Artifact Attire, Etoile is JSE Neck, and Handler's are Unity Gear
            body="Maxixi Casaque +3",hands="Regal Gloves",ring1="Carbuncle Ring +1",ring2="Carbuncle Ring +1",      -- Regal Gloves are Omen and Carbuncle are crafted
            back=gear.senuna_waltz,waist="Aristo Belt",legs="Horos Tights +3",feet="Maxixi Toeshoes +3"}            -- Senuna is Abuscade JSE Cape, Aristo Belt is from Abyssea - La Theine, and Horos is Relic Attire
        sets.Self_Waltz = set_combine(sets.precast.Waltz, {ammo="Brigantia Pebble",                                 -- Brigantia Pebble is from Meeble Burrows
            head="Mummu Bonnet +2",hands="Horos Bangles +3",ring1="Regal Ring",ring2="Asklepian Ring",              -- Mummu is Ambuscade Attire, Regal Ring is from Omen, and Asklepian Ring is from Meeble Burrows
            back=gear.senuna_waltz_self,waist="Caudata Belt"})                                                      -- Caudata Belt is from Meeble Burrows
        sets.Waltz_Received = set_combine(sets.Self_Waltz, {neck="Unmoving Collar +1"})                             -- Unmoving Collar is Unity Gear
        sets.precast.Waltz['Healing Waltz'] = {head="Anwig Salade",body="Maxixi Casaque +3"}                        -- Anwig Salade should be augmented with "Waltz" ability delay -2 from A Moogle Kupo d'Etat
        
    --[[ Step Sets
            Steps each cost 100 TP and consist of
            Box Step        -- Level 30 -- Lowers Defence
            Feather Step    -- Level 83 -- Lowers Critical Hit Evasion
            Quickstep       -- Level 20 -- Lowers Evaison
            Stutter Step    -- Level 40 -- Loweres Magic Resistance                                                         ]]
        sets.precast.Step = {hands="Maxixi Bangles +3",feet="Horos Shoes +3"}
		sets.precast.Step['Feather Step'] = {feet="Maculele Toeshoes +1"}                                           -- Maculele is Empyrean Attire
    
    --[[ Flourish Sets
            Flourishes are broken into 3 categories I, II, and III, each having their own timers.                           ]]
        sets.Enmity = {}
    --[[ Flourish I consists of:
            Animated Flourish   -- Level 20 --  Increase Volatile Enmity        -- Uses 1 or 2 Finishing Moves for 1000 or 1500 Volatile Enmity
            Deperate Flourish   -- Level 30 --  Gravity/Lower Evasion           -- Uses 1 Finishing Move for Gravity and -10 Evasion
            Violent Flourish    -- Level 45 --  Stun + Non-Critical Damage      -- Uses 1 Finishing Move, Stun Hit Rate Dependent on Magic Accuracy]]
        sets.precast.JA.Provoke = sets.Enmity
        sets.precast.Flourish1 = {}
        sets.precast.Flourish1['Violent Flourish'] = {body="Horos Casaque +3"}
        sets.precast.Flourish1['Animated Flourish'] = set_combine(sets.Enmity, {})
        sets.precast.Flourish1['Desperate Flourish'] = {}
    --[[ Flourish I consists of:
            Building Flourish   -- Level 20 --  Enhances Potency of next WS     -- Uses 1 to 3 Finishing Moves where
                                1 Finishing Move adds Acc, 2 Finishing Moves adds Acc and Att, and 3 Finishing Moves addes Acc, Att, and Crit
            Reverse Flourish    -- Level 40 --  Convert Finishing Moves to TP   -- Uses 1 to 5 Finishing Moves for 
                                (95+ Reverse Flourish Bonus) × (Finishing Moves) + (Square Mod) × (Finishing Moves)^2 + 30 × (Merit Level)
            Wild Flourish       -- Level 60 --  Starts Skillchain               -- Uses 2 Finishing Moves                   ]]
        sets.precast.Flourish2 = {}
        sets.precast.Flourish2['Reverse Flourish'] = {hands="Maculele Bangles +1",back="Toetapper Mantle"}
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

    --[[ Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
            Generally speaking fTP < 2 would benefit more from Double Attack than WS damage
            Shadowstitch    CHR 100%
            Energy Steal    MND 100%
            Energy Drain    MND 100%
            Wasp Sting      DEX 100%
            Viper Bite      DEX 100%
            Cyclone         DEX 40%
            Eviseration     DEX 50%                 fTP(1.1875) transferred across all hits
            Exenterator     DEX 85%                 fTP(1.0) transferred across all 4 hits
            Rudra's Storm   DEX 80%                 fTP(5,10.19,13)
            Shark Bite      DEX 40%     AGI 40%     2 Fold Attack fTP(4.5,6.8,8.5)
            Dancing Edge    DEX 40%     CHR 40%     fTP(1.1875) transferred across all 5 hits
            Gust Slash      DEX 40%     INT 40%
            Aeolian Edge    DEX 40%     INT 40%     fTP(1.25) transferred across all 5 hits + Crit Rate(10%,25%,50%)
            Pyrrhic Kleos   DEX 40%     STR 40%     4 Fold Attack fTP(1.75) transferred across all 4 hits  ]]
        sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {})
        sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {})
        sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})
        sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {})
        sets.precast.WS['Aeolian Edge'] = {}
        sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	-- Swap to these on Moonshade using WS if at 3000 TP
        sets.MaxTP = {}
        sets.AccMaxTP = {}
        sets.Skillchain = {hands="Maculele Bangles +1"}                                                             -- Maculele is Emyrean Attire
    
    -- Midcast Sets
        sets.midcast.FastRecast = {}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
        sets.resting = {}
        sets.ExtraRegen = {}
    
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
        sets.buff['Saber Dance'] = {} --legs="Horos Tights"
        sets.buff['Climactic Flourish'] = {} --head="Charis Tiara +2"
        sets.buff.Doom = set_combine(sets.buff.Doom, {})
        sets.buff.Sleep = {head="Frenzy Sallat",neck="Opo-opo Necklace",ring2="Nesanica Ring"}
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