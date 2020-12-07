-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Acc','MaxAcc')
    state.HybridMode:options('Normal','HybridDT')
    state.RangedMode:options('Normal','Acc')
    state.WeaponskillMode:options('Match','Normal','MaxAcc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Sphere')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Heishi','HeishiCrit')
	
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None','SuppaBrutal','DWEarrings','DWMax'}
    
    gear.andartia = {}
    gear.andartia.tp = {}
    gear.andartia.tp.da = {name="Andartia's Mantle",augments={'DEX+20','Accuracy+20 Attack+20'}}

    gear.kanaria = {}
    gear.kanaria.ta = {name="Kanaria",augments={'"Triple Atk."+3','STR+7','Accuracy+6','DMG:+13'}}
    gear.kanaria.critdamage = {name="Kanaria",augments={'Crit. hit damage +6%','AGI+9','Accuracy+23','Attack+14','DMG:+10'}}
	
	send_command('bind ^` input /ja "Innin" <me>')
    send_command('bind !` input /ja "Yonin" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	
	utsusemi_cancel_delay = .3
	utsusemi_ni_cancel_delay = .06
	
    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

	-- Weapons sets
    sets.weapons.Heishi = {main="Heishi Shorinken",sub=gear.kanaria.ta}
    sets.weapons.HeishiCrit = {main="Heishi Shorinken",sub=gear.kanaria.critdamage}

    --------------------------------------
    -- Precast sets
    --------------------------------------

    sets.Enmity = {
        ammo="Aqreqaq Bomblet",
        neck="Moonbeam Necklace",ear1="Friomisi Earring",ear2="Cryptic Earring",
        body="Emet Harness +1",ring1="Petrov Ring",ring2="Supershear Ring",
        waist="Kasiri Belt",feet="Ahosi Leggings"
    }
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {}
    sets.precast.JA['Futae'] = {}
    sets.precast.JA['Sange'] = {}
	sets.precast.JA['Provoke'] = sets.Enmity
	sets.precast.JA['Warcry'] = sets.Enmity

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
	
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {}

    sets.precast.Flourish1 = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        ammo="Impatiens",
        head=gear.herculean.helm.strwsd,neck="Orunmila's Torque",ear1="Loquac. Earring",ear2="Enchntr. Earring +1",
        body=gear.taeon.tabard.fc,hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
        back="Moonbeam Cape",legs="Arjuna Breeches",feet="Ryuo Sune-Ate +1"
    }
		
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
	sets.precast.FC.Shadows = set_combine(sets.precast.FC.Utsusemi, {})

    -- Snapshot for ranged
    sets.precast.RA = {
        head=gear.taeon.chapeau.snapshot,
        body=gear.taeon.tabard.snapshot,
        waist="Yemaya Belt",legs="Adhemar Kecks",feet="Adhe. Gamashes +1"
    }

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Aurgelmir Orb +1",
        head="Hachiya Hatsu. +2",neck="Fotia Gorget",ear1="Lugra Earring +1",ear2="Lugra Earring",
        body=gear.herculean.vest.dexwsd,hands=gear.adhemar.wrist.path_b,ring1="Regal Ring",ring2="Ilabrat Ring",
        gear.andartia.tp.da,waist="Fotia Belt",legs="Hiza. Hizayoroi +2",feet="Hiza. Sune-Ate +2"
    }
	
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, {
        ammo="Yetshila",
        head="Adhemar Bonnet +1",ear2="Odr Earring",
        body="Abnoba Kaftan",hands="Mummu Wrists +2",ring2="Mummu Ring",
        feet="Mummu Gamash. +2"
    })
	
	sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS['Blade: Jin'], {
        neck="Caro Necklace",ear2="Odr Earring",waist="Sailfi Belt +1"
    })

    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {
        head="Adhemar Bonnet +1",ear2="Moonshade Earring",
        body="Adhemar Jacket +1",
        legs="Samnuha Tights",feet=gear.herculean.boots.ta_low_acc
    })

    sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, {
        neck="Caro Necklace",ear2="Moonshade Earring",waist="Sailfi Belt +1"
    })

    sets.precast.WS['Blade: Chi'] = set_combine(sets.precast.WS, {
        ammo="Seeth. Bomblet +1",
        head=gear.herculean.helm.magical,neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Moonshade Earring",
        body="Samnuha Coat",hands=gear.herculean.gloves.magical,ring1="Dingir Ring",ring2="Shiva Ring +1",
        legs=gear.herculean.trousers.magical,feet=gear.herculean.boots.magical
    })

    sets.precast.WS['Blade: To'] = sets.precast.WS['Blade: Chi']
    sets.precast.WS['Blade: Teki'] = sets.precast.WS['Blade: Chi']

    sets.precast.WS['Blade: Ei'] = set_combine(sets.precast.WS['Blade: Chi'], {
        head="Pixie Hairpin +1",ring2="Archon Ring"
    })
	
    sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Blade: Chi']

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
	sets.AccDayMaxTPWSEars = {}
	sets.DayMaxTPWSEars = {}
	sets.AccDayWSEars = {}
    sets.DayWSEars = {}
    
    sets.DayWSEars["Blade: Jin"] = {ear1="Mache Earring +1",ear2="Odr Earring"}
    
    sets.DayWSEars["Blade: Hi"] = {ear1="Ishvara Earring",ear2="Odr Earring"}

    sets.MaxTP["Blade: Shun"] = {ear1="Lugra Earring +1",ear2="Lugra Earring"}
    sets.DayWSEars["Blade: Shun"] = {ear1="Mache Earring +1",ear2="Moonshade Earring"}
    sets.DayMaxTPWSEars["Blade: Shun"] = {ear1="Mache Earring +1",ear2="Odr Earring"}

    sets.MaxTP["Blade: Ten"] = {ear1="Lugra Earring +1",ear2="Ishvara Earring"}
    sets.DayWSEars["Blade: Ten"] = {ear1="Ishvara Earring",ear2="Moonshade Earring"}
    sets.DayMaxTPWSEars["Blade: Ten"] = {ear1="Ishvara Earring",ear2="Odr Earring"}

    sets.MaxTP["Blade: Chi"] = {ear1="Friomisi Earring",ear2="Ishvara Earring"}

    sets.MaxTP["Blade: To"] = sets.MaxTP["Blade: Chi"]
    sets.MaxTP["Blade: Teki"] = sets.MaxTP["Blade: Chi"]
    sets.MaxTP["Blade: Ei"] = sets.MaxTP["Blade: Chi"]

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

    sets.midcast.ElementalNinjutsu = {
        ammo="Seeth. Bomblet +1",
        head=gear.herculean.helm.magical,neck="Baetyl Pendant",ear1="Friomisi Earring",
        body="Samnuha Coat",hands=gear.herculean.gloves.magical,ring1="Dingir Ring",ring2="Shiva Ring +1",
        waist="Eschan Stone",legs=gear.herculean.trousers.magical,feet=gear.herculean.boots.magical
    }
		
    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.ElementalNinjutsu, {})
	
	sets.MagicBurst = {}
	
	sets.element.Earth = {}

    sets.midcast.NinjutsuDebuff = {
        ammo="Yamarang",
        head="Malignance Chapeau",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Gwati Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Regal Ring",ring2="Stikini Ring",
        waist="Eschan Stone",legs="Malignance Tights",feet="Hachiya Kyahan +2"
    }

    sets.midcast.NinjutsuBuff = set_combine(sets.midcast.FastRecast, {})
	
    sets.midcast.Utsusemi = set_combine(sets.midcast.NinjutsuBuff, {back=gear.andartia.tp.da,feet="Iga Kyahan +2"})

    sets.midcast.RA = {
        head="Malignance Chapeau",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Hachiya Tekko +2",ring1="Regal Ring",ring2="Dingir Ring",
        waist="Yemaya Belt",legs="Malignance Tights",feet="Mummu Gamash. +2",
    }
		
    sets.midcast.RA.Acc = {}

    sets.Self_Phalanx = {
        head=gear.taeon.chapeau.phalanx,
        body=gear.taeon.tabard.phalanx,hands=gear.taeon.gloves.phalanx,
        legs=gear.taeon.tights.phalanx,feet=gear.taeon.boots.phalanx
    }

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Idle sets
    sets.idle = {
        ammo="Staunch Tathlum",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
        body="Hiza. Haramaki +2",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Moonbeam Cape",waist="Flume Belt +1",legs="Malignance Tights",feet="Ahosi Leggings"
    }

    sets.idle.PDT = {}
		
    sets.idle.Sphere = set_combine(sets.idle, {})
		
    sets.idle.Weak = {}
    
    -- Resting sets
    sets.resting = sets.idle
    
    -- Defense sets
    sets.defense.Evasion = {}

    sets.defense.PDT = {}

    sets.defense.MDT = {}
		
	sets.defense.MEVA = {}


    sets.Kiting = {--[[feet="Danzo Sune-Ate"]]}
	sets.DuskKiting = {feet="Hachiya Kyahan +2"}
	sets.DuskIdle = {}
	sets.DayIdle = {}
	sets.NightIdle = {}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        ammo="Aurgelmir Orb +1",
        head="Adhemar Bonnet +1",neck="Iskur Gorget",ear1="Brutal Earring",ear2="Dedition Earring",
        body="Malignance Tabard",hands=gear.adhemar.wrist.path_a,ring1="Gere Ring",ring2="Epona's Ring",
        back=gear.andartia.tp.da,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean.boots.ta_low_acc
    }

    sets.engaged.HybridDT = set_combine(sets.engaged, {
        head="Malignance Chapeau",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gere Ring",legs="Malignance Tights"
    })

    sets.engaged.Acc = set_combine(sets.engaged, {
        ear1="Telos Earring",ear2="Cessance Earring",ring2="Chirich Ring",feet=gear.herculean.boots.ta
    })

    sets.engaged.Acc.HybridDT = set_combine(sets.engaged.HybridDT, {})
		
    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {}
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff.Yonin = {}
    sets.buff.Innin = {}
	
    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
	sets.SuppaBrutal = {}
	sets.DWEarrings = {}
	sets.DWMax = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {head=gear.herculean.helm.TH,feet=gear.herculean.boots.TH})
	sets.Skillchain = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 13)
end

function lockstyle()
	windower.chat.input("/lockstyleset 012")
end