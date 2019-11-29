function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal')
    state.WeaponskillMode:options('Match','Normal')
    state.HybridMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT','Refresh','Reraise')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Passive = M{['description'] = 'Passive Mode','None','Twilight'}
	state.Weapons:options('Ragnorok','Chango','Zulfiqar','Naegling','NaeglingDW','ProcSword','ProcClub','ProcStaff','ProcGreatKatana','ProcDagger','ProcScythe','ProcKatana','ProcPolearm','ProcGreatsword')

	gear.cichol = {}
	gear.cichol.tp = {name="Cichol's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
	gear.cichol.resolution = {name="Cichol's Mantle",augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	gear.cichol.upheaval = {name="Cichol's Mantle",augments={'VIT+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

	gear.aganoshe = {}
	gear.aganoshe.main = {name="Aganoshe",augments={'"Store TP"+5','VIT+14','Accuracy+13','Attack+25','DMG:+20',}}

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !r gs c weapons Ragnorok;gs c update')
	
	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	-- Precast Sets

	sets.Enmity = {
		ammo="Sapience Orb",
		head="Pummeler's Mask +2",ear1="Friomisi Earring",
		hands="Pumm. Mufflers +2",ring1="Petrov Ring",
	}

	sets.Knockback = {}
	sets.passive.Twilight = {--[[head="Twilight Helm",body="Twilight Mail"]]}

	-- Precast sets to enhance JAs
	sets.precast.JA['Berserk'] = {body="Pumm. Lorica +2",back="Cichol's Mantle",feet="Agoge Calligae"}
	sets.precast.JA['Warcry'] = {head="Agoge Mask"}
	sets.precast.JA['Defender'] = {}
	sets.precast.JA['Aggressor'] = {head="Pummeler's Mask +2",body="Agoge Lorica"}
	sets.precast.JA['Mighty Strikes'] = {hands="War. Mufflers +2"}
	sets.precast.JA["Warrior's Charge"] = {legs="War. Cuisses +2"}
	sets.precast.JA['Tomahawk'] = {ammo="Thr. Tomahawk",feet="Agoge Calligae"}
	sets.precast.JA['Retaliation'] = {}
	sets.precast.JA['Restraint'] = {}
	sets.precast.JA['Blood Rage'] = {body="Boii Lorica +1"}
	sets.precast.JA['Brazen Rush'] = {}
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity,{})
					
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
					
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
			
	sets.precast.Step = {}

	sets.precast.Flourish1 = {}
			
	-- Fast cast sets for spells

	sets.precast.FC = {ammo="Sapience Orb",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",hands="Leyline Gloves",feet="Odyssean Greaves"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {waist="Ioskeha Belt",legs="Pumm. Cuisses +2"})

	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
					
	sets.midcast.Cure = {}

	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}
											
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Seething Bomblet",
		head="Flam. Zucchetto +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Flamma Ring",
		back=gear.cichol.resolution,waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Pumm. Calligae +3"
	}

	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS["Resolution"] = {
		ammo="Seething Bomblet",
		head="Flam. Zucchetto +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Flamma Ring",
		back=gear.cichol.resolution,waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Pumm. Calligae +3"
	}

	sets.precast.WS["Resolution"].SomeAcc = {}
	sets.precast.WS["Resolution"].Acc = {}
	sets.precast.WS["Resolution"].FullAcc = {}
	sets.precast.WS["Resolution"].Fodder = {}

	sets.precast.WS["Scourge"] = {
		ammo="Knobkierrie",
		head=gear.odyssean.helm.wsd,neck="Caro Necklace",ear1="Brutal Earring",ear2="Ishvara Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Apate Ring",
		back=gear.cichol.upheaval,waist="Caudata Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"
	}

	sets.precast.WS["Scourge"].SomeAcc = {}
	sets.precast.WS["Scourge"].Acc = {}
	sets.precast.WS["Scourge"].FullAcc = {}
	sets.precast.WS["Scourge"].Fodder = {}

	sets.precast.WS["Ground Strike"] = {
		ammo="Knobkierrie",
		head=gear.odyssean.helm.wsd,neck="Caro Necklace",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Apate Ring",
		back=gear.cichol.upheaval,waist="Caudata Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"
	}

	sets.precast.WS["Ground Strike"].SomeAcc = {}
	sets.precast.WS["Ground Strike"].Acc = {}
	sets.precast.WS["Ground Strike"].FullAcc = {}
	sets.precast.WS["Ground Strike"].Fodder = {}

	sets.precast.WS["Shockwave"] = {
		ammo="Knobkierrie",
		head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear1="Assuage Earring",ear2="Ishvara Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Etana Ring",
		back=gear.cichol.upheaval,waist="Eschan Stone",legs="Flamma Dirs +2",feet="Flam. Gambieras +2"
	}

	sets.precast.WS["Shockwave"].SomeAcc = {}
	sets.precast.WS["Shockwave"].Acc = {}
	sets.precast.WS["Shockwave"].FullAcc = {}
	sets.precast.WS["Shockwave"].Fodder = {}

	sets.precast.WS["Herculean Slash"] = {
		ammo="Pemphredo Tathlum",
		head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Shiva Ring +1",ring2="Shiva Ring",
		back=gear.cichol.resolution,waist="Eschan Stone",legs=gear.valorous.hose.mab,feet="Founder's Greaves"
	}

	sets.precast.WS["Herculean Slash"].SomeAcc = {}
	sets.precast.WS["Herculean Slash"].Acc = {}
	sets.precast.WS["Herculean Slash"].FullAcc = {}
	sets.precast.WS["Herculean Slash"].Fodder = {}

	sets.precast.WS["Upheaval"] = {
		ammo="Seething Bomblet",
		head="Flam. Zucchetto +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Flamma Ring",
		back=gear.cichol.resolution,waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Pumm. Calligae +3"
	}

	sets.precast.WS["Upheaval"].SomeAcc = {}
	sets.precast.WS["Upheaval"].Acc = {}
	sets.precast.WS["Upheaval"].FullAcc = {}
	sets.precast.WS["Upheaval"].Fodder = {}

	sets.precast.WS["King's Justice"] = {
		ammo="Seething Bomblet",
		head="Flam. Zucchetto +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Flamma Ring",
		back=gear.cichol.resolution,waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Pumm. Calligae +3"
	}

	sets.precast.WS["King's Justice"].SomeAcc = {}
	sets.precast.WS["King's Justice"].Acc = {}
	sets.precast.WS["King's Justice"].FullAcc = {}
	sets.precast.WS["King's Justice"].Fodder = {}

	sets.precast.WS["Full Break"] = {
		ammo="Knobkierrie",
		head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear1="Assuage Earring",ear2="Ishvara Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Etana Ring",
		back=gear.cichol.upheaval,waist="Eschan Stone",legs="Flamma Dirs +2",feet="Flam. Gambieras +2"
	}

	sets.precast.WS["Full Break"].SomeAcc = {}
	sets.precast.WS["Full Break"].Acc = {}
	sets.precast.WS["Full Break"].FullAcc = {}
	sets.precast.WS["Full Break"].Fodder = {}

	sets.precast.WS["Fell Cleave"] = {
		ammo="Knobkierrie",
		head=gear.odyssean.helm.wsd,neck="Caro Necklace",ear1="Brutal Earring",ear2="Ishvara Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Apate Ring",
		back=gear.cichol.upheaval,waist="Caudata Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"
	}

	sets.precast.WS["Fell Cleave"].SomeAcc = {}
	sets.precast.WS["Fell Cleave"].Acc = {}
	sets.precast.WS["Fell Cleave"].FullAcc = {}
	sets.precast.WS["Fell Cleave"].Fodder = {}

	sets.precast.WS["Ukko's Fury"] = {
		ammo="Seething Bomblet",
		head="Flam. Zucchetto +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Flamma Ring",
		back=gear.cichol.resolution,waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Pumm. Calligae +3"
	}

	sets.precast.WS["Ukko's Fury"].SomeAcc = {}
	sets.precast.WS["Ukko's Fury"].Acc = {}
	sets.precast.WS["Ukko's Fury"].FullAcc = {}
	sets.precast.WS["Ukko's Fury"].Fodder = {}

	sets.precast.WS["Steel Cyclone"] = {
		ammo="Knobkierrie",
		head=gear.odyssean.helm.wsd,neck="Caro Necklace",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Apate Ring",
		back=gear.cichol.upheaval,waist="Caudata Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"
	}

	sets.precast.WS["Steel Cyclone"].SomeAcc = {}
	sets.precast.WS["Steel Cyclone"].Acc = {}
	sets.precast.WS["Steel Cyclone"].FullAcc = {}
	sets.precast.WS["Steel Cyclone"].Fodder = {}

	sets.precast.WS["Savage Blade"] = {
		ammo="Knobkierrie",
		head=gear.odyssean.helm.wsd,neck="Caro Necklace",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Apate Ring",
		back=gear.cichol.upheaval,waist="Caudata Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"
	}

	sets.precast.WS["Savage Blade"].SomeAcc = {}
	sets.precast.WS["Savage Blade"].Acc = {}
	sets.precast.WS["Savage Blade"].FullAcc = {}
	sets.precast.WS["Savage Blade"].Fodder = {}

	sets.precast.WS["Vorpal Blade"] = {
		ammo="Seething Bomblet",
		head="Flam. Zucchetto +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Flamma Ring",
		back=gear.cichol.resolution,waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Pumm. Calligae +3"
	}

	sets.precast.WS["Vorpal Blade"].SomeAcc = {}
	sets.precast.WS["Vorpal Blade"].Acc = {}
	sets.precast.WS["Vorpal Blade"].FullAcc = {}
	sets.precast.WS["Vorpal Blade"].Fodder = {}

	sets.precast.WS["Sanguine Blade"] = {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Shiva Ring +1",ring2="Archon Ring",
		back=gear.cichol.resolution,waist="Eschan Stone",legs=gear.valorous.hose.mab,feet="Founder's Greaves"
	}

	sets.precast.WS["Sanguine Blade"].SomeAcc = {}
	sets.precast.WS["Sanguine Blade"].Acc = {}
	sets.precast.WS["Sanguine Blade"].FullAcc = {}
	sets.precast.WS["Sanguine Blade"].Fodder = {}

	sets.precast.WS["Requiescat"] = {
		ammo="Seething Bomblet",
		head="Flam. Zucchetto +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Flamma Ring",
		back=gear.cichol.resolution,waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Pumm. Calligae +3"
	}

	sets.precast.WS["Requiescat"].SomeAcc = {}
	sets.precast.WS["Requiescat"].Acc = {}
	sets.precast.WS["Requiescat"].FullAcc = {}
	sets.precast.WS["Requiescat"].Fodder = {}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Brutal Earring",ear2="Cessance Earring"}
	sets.MaxTP["Resolution"] = {ear1="Brutal Earring",ear2="Cessance Earring"}
	sets.MaxTP["Ground Strike"] = {ear1="Brutal Earring",ear2="Ishvara"}
	sets.MaxTP["Upheaval"] = {ear1="Brutal Earring",ear2="Cessance Earring"}
	sets.MaxTP["King's Justice"] = {ear1="Brutal Earring",ear2="Cessance Earring"}
	sets.MaxTP["Steel Cyclone"] = {ear1="Brutal Earring",ear2="Ishvara Earring"}
	sets.MaxTP["Savage Blade"] = {ear1="Brutal Earring",ear2="Ishvara Earring"}
	sets.MaxTP["Vorpal Blade"] = {ear1="Brutal Earring",ear2="Cessance Earring"}
	sets.MaxTP["Requiescat"] = {ear1="Brutal Earring",ear2="Cessance Earring"}

	sets.AccMaxTP = {}
	sets.AccDayMaxTPWSEars = {}
	sets.DayMaxTPWSEars = {}
	sets.AccDayWSEars = {}
	sets.DayWSEars = {}

	-- Sets to return to when not performing an action.
		
	-- Resting sets
	sets.resting = {}
			
	-- Idle sets
	sets.idle = {
		ammo="Staunch Tathlum +1",
		head=gear.valorous.mask.crit,neck="Sanctity Necklace",ear1="Etiolation Earring",ear2="Eabani Earring",
		body="Sulevia's Plate. +1",hands="Pumm. Mufflers +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Solemnity Cape",waist="Flume Belt +1",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2",
	}
		
	sets.idle.Weak = set_combine(sets.idle, sets.passive.Twilight, {})
		
	sets.idle.Reraise = set_combine(sets.idle, sets.passive.Twilight, {})

	-- Defense sets
	sets.defense.PDT = {}
		
	sets.defense.PDTReraise = set_combine(sets.defense.PDT, sets.passive.Twilight, {})

	sets.defense.MDT = {}
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, sets.passive.Twilight, {})
		
	sets.defense.MEVA = {}

	sets.Kiting = {}
	sets.Reraise = sets.passive.Twilight
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Vim Torque"}
		
			-- Engaged sets
	sets.engaged = {}
	sets.engaged.SomeAcc = {}
	sets.engaged.Acc = {}
	sets.engaged.FullAcc = {}
	sets.engaged.Fodder = {}

	sets.engaged.Chango = {
		ammo="Seething Bomblet",
		head="Flam. Zucchetto +2",neck="Clotharius Torque",ear1="Brutal Earring",ear2="Cessance Earring",
		body=gear.valorous.mail.tp,hands="Sulev. Gauntlets +2",ring1="Petrov Ring",ring2="Flamma Ring",
		back=gear.cichol.tp,waist="Ioskeha Belt",legs="Pumm. Cuisses +2",feet="Pumm. Calligae +3"
	}

	sets.engaged.Chango.SomeAcc = {}
	sets.engaged.Chango.Acc = {}
	sets.engaged.Chango.FullAcc = {}
	sets.engaged.Chango.Fodder = {}

	sets.engaged.Ragnorok = {
		ammo="Seething Bomblet",
		head="Flam. Zucchetto +2",neck="Clotharius Torque",ear1="Brutal Earring",ear2="Cessance Earring",
		body=gear.valorous.mail.tp,hands="Sulev. Gauntlets +2",ring1="Petrov Ring",ring2="Flamma Ring",
		back=gear.cichol.tp,waist="Ioskeha Belt",legs="Pumm. Cuisses +2",feet="Pumm. Calligae +3"
	}

	sets.engaged.Ragnorok.SomeAcc = {}
	sets.engaged.Ragnorok.Acc = {}
	sets.engaged.Ragnorok.FullAcc = {}
	sets.engaged.Ragnorok.Fodder = {}

	sets.engaged.Zulfiqar = {
		ammo="Seething Bomblet",
		head="Flam. Zucchetto +2",neck="Clotharius Torque",ear1="Brutal Earring",ear2="Cessance Earring",
		body=gear.valorous.mail.tp,hands="Sulev. Gauntlets +2",ring1="Petrov Ring",ring2="Flamma Ring",
		back=gear.cichol.tp,waist="Ioskeha Belt",legs="Pumm. Cuisses +2",feet="Pumm. Calligae +3"
	}

	sets.engaged.Zulfiqar.SomeAcc = {}
	sets.engaged.Zulfiqar.Acc = {}
	sets.engaged.Zulfiqar.FullAcc = {}
	sets.engaged.Zulfiqar.Fodder = {}

	sets.engaged.Naegling = {
		ammo="Seething Bomblet",
		head="Flam. Zucchetto +2",neck="Clotharius Torque",ear1="Brutal Earring",ear2="Cessance Earring",
		body=gear.valorous.mail.tp,hands="Sulev. Gauntlets +2",ring1="Petrov Ring",ring2="Flamma Ring",
		back=gear.cichol.tp,waist="Ioskeha Belt",legs="Pumm. Cuisses +2",feet="Pumm. Calligae +3"
	}

	sets.engaged.Naegling.SomeAcc = {}
	sets.engaged.Naegling.Acc = {}
	sets.engaged.Naegling.FullAcc = {}
	sets.engaged.Naegling.Fodder = {}

	sets.engaged.Naegling.DW = set_combine(sets.engaged.Naegling, {ear1="Suppanomimi",ear2="Eabani Earring"})

	sets.engaged.Naegling.DW.SomeAcc = {}
	sets.engaged.Naegling.DW.Acc = {}
	sets.engaged.Naegling.DW.FullAcc = {}
	sets.engaged.Naegling.DW.Fodder = {}
	
	--Extra Special Sets
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Retaliation = {}
	sets.buff.Restraint = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.Chango = {main=gear.aganoshe.main,sub="Duplus Grip"}
	sets.weapons.Ragnarok = {main="Ragnorok",sub="Duplus Grip"}
	sets.weapons.Zulfiqar = {main="Zulfiqar",sub="Duplus Grip"}
	sets.weapons.Naegling = {main="Kaja Sword",sub="Blurred Shield"}
	sets.weapons.NaeglingDW = {main="Kaja Sword",sub="Firangi"}
end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'DNC' then
        set_macro_page(2, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 1)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 1)
    else
        set_macro_page(10, 1)
    end
end