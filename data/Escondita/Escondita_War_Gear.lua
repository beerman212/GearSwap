function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','MaxAcc')
    state.WeaponskillMode:options('Match','Normal','MaxAcc')
    state.HybridMode:options('Normal','HybridDT')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT','Refresh','Reraise')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Passive = M{['description'] = 'Passive Mode','None','Twilight'}
	state.Weapons:options('Chango','Zulfiqar','Ragnarok','Naegling','NaeglingDW','Farsha','FarshaDW','ProcSword','ProcClub','ProcStaff','ProcGreatKatana','ProcDagger','ProcScythe','ProcKatana','ProcPolearm','ProcGreatsword')

	gear.cichol = {}
	gear.cichol.tp = {name="Cichol's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
	gear.cichol.resolution = {name="Cichol's Mantle",augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	gear.cichol.upheaval = {name="Cichol's Mantle",augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%'}}
	gear.cichol.justice = {name="Cichol's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}

	gear.aganoshe = {}
	gear.aganoshe.main = {name="Aganoshe",augments={'"Store TP"+5','VIT+14','Accuracy+13','Attack+25','DMG:+20',}}

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !r gs c weapons Ragnarok;gs c update')
	
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
		ammo="Seeth. Bomblet +1",
		head="Flam. Zucchetto +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Flamma Ring",
		back=gear.cichol.resolution,waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Pumm. Calligae +3"
	}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	-- Great Sword
	sets.precast.WS["Resolution"] = set_combine(sets.precast.WS, {
		ear2="Moonshade Earring",
	})

	sets.precast.WS["Scourge"] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head=gear.odyssean.helm.wsd,neck="Caro Necklace",ear2="Ishvara Earring",
		ring2="Apate Ring",
		back=gear.cichol.upheaval,waist="Caudata Belt",feet="Sulev. Leggings +2"
	})

	sets.precast.WS["Ground Strike"] = set_combine(sets.precast.WS["Scourge"], {
		ear1="Moonshade Earring"
	})

	sets.precast.WS["Shockwave"] = {
		ammo="Knobkierrie",
		head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear1="Assuage Earring",ear2="Ishvara Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Etana Ring",
		back=gear.cichol.upheaval,waist="Eschan Stone",legs="Flamma Dirs +2",feet="Flam. Gambieras +2"
	}

	sets.precast.WS["Herculean Slash"] = {
		ammo="Pemphredo Tathlum",
		head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Shiva Ring +1",ring2="Shiva Ring",
		back=gear.cichol.resolution,waist="Eschan Stone",legs=gear.valorous.hose.mab,feet="Founder's Greaves"
	}

	-- Great Axe
	sets.precast.WS["Upheaval"] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Flam. Zucchetto +2",ear1="Thrud Earring",ear2="Moonshade Earring",
		back=gear.cichol.upheaval,feet="Sulev. Leggings +2"
	})

	sets.precast.WS["King's Justice"] = {
		ammo="Seething Bomblet",
		head="Flam. Zucchetto +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Flamma Ring",
		back=gear.cichol.justice,waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Pumm. Calligae +3"
	}

	sets.precast.WS["Full Break"] = {
		ammo="Knobkierrie",
		head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear1="Assuage Earring",ear2="Ishvara Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Etana Ring",
		back=gear.cichol.upheaval,waist="Eschan Stone",legs="Flamma Dirs +2",feet="Flam. Gambieras +2"
	}

	sets.precast.WS["Fell Cleave"] = {
		ammo="Knobkierrie",
		head=gear.odyssean.helm.wsd,neck="Caro Necklace",ear1="Brutal Earring",ear2="Ishvara Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Apate Ring",
		back=gear.cichol.upheaval,waist="Caudata Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"
	}

	sets.precast.WS["Ukko's Fury"] = {
		ammo="Seething Bomblet",
		head="Flam. Zucchetto +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Flamma Ring",
		back=gear.cichol.resolution,waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Pumm. Calligae +3"
	}

	sets.precast.WS["Steel Cyclone"] = {
		ammo="Knobkierrie",
		head=gear.odyssean.helm.wsd,neck="Caro Necklace",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Apate Ring",
		back=gear.cichol.upheaval,waist="Caudata Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"
	}

	sets.precast.WS["Savage Blade"] = {
		ammo="Knobkierrie",
		head=gear.odyssean.helm.wsd,neck="Caro Necklace",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Apate Ring",
		back=gear.cichol.upheaval,waist="Caudata Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"
	}

	sets.precast.WS["Vorpal Blade"] = {
		ammo="Seething Bomblet",
		head="Flam. Zucchetto +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Flamma Ring",
		back=gear.cichol.resolution,waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Pumm. Calligae +3"
	}

	sets.precast.WS["Sanguine Blade"] = {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Shiva Ring +1",ring2="Archon Ring",
		back=gear.cichol.resolution,waist="Eschan Stone",legs=gear.valorous.hose.mab,feet="Founder's Greaves"
	}

	sets.precast.WS["Requiescat"] = {
		ammo="Seething Bomblet",
		head="Flam. Zucchetto +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Flamma Ring",
		back=gear.cichol.resolution,waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Pumm. Calligae +3"
	}

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
	sets.engaged = {
		ammo="Aurgelmir Orb",
		head="Flam. Zucchetto +2",neck="Clotharius Torque",ear1="Brutal Earring",ear2="Cessance Earring",
		body=gear.valorous.mail.tp,hands="Sulev. Gauntlets +2",ring1="Petrov Ring",ring2="Flamma Ring",
		back=gear.cichol.tp,waist="Ioskeha Belt",legs="Pumm. Cuisses +2",feet="Pumm. Calligae +3"
	}
	sets.engaged.HybridDT = set_combine(sets.engaged, {
		ring1="Defending Ring",ring2="Gelatinous Ring +1"
	})

	sets.engaged.MaxAcc = set_combine(sets.engaged, {
		ear1="Zennaroi Earring",body="Pumm. Lorica +2",hands="Pumm. Mufflers +2"
	})
	sets.engaged.MaxAcc.HybridDT = set_combine(sets.engaged.HybridDT, {
		head="Pummeler's Mask +2",ear1="Zennaroi Earring",body="Pumm. Lorica +2",hands="Pumm. Mufflers +2"
	})

	sets.engaged.Ragnarok = set_combine(sets.engaged, {})
	sets.engaged.Ragnarok.HybridDT = set_combine(sets.engaged.Ragnarok, {})

	sets.engaged.Ragnarok.MaxAcc = set_combine(sets.engaged.Ragnarok, {})
	sets.engaged.Ragnarok.MaxAcc.HybridDT = set_combine(sets.engaged.Ragnarok.HybridDT, {})

	-- sets.engaged.Ragnarok = {
	-- 	ammo="Seething Bomblet",
	-- 	head="Flam. Zucchetto +2",neck="Clotharius Torque",ear1="Brutal Earring",ear2="Cessance Earring",
	-- 	body=gear.valorous.mail.tp,hands="Sulev. Gauntlets +2",ring1="Petrov Ring",ring2="Flamma Ring",
	-- 	back=gear.cichol.tp,waist="Ioskeha Belt",legs="Pumm. Cuisses +2",feet="Pumm. Calligae +3"
	-- }
	
	--Extra Special Sets
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Retaliation = {}
	sets.buff.Restraint = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.Chango = {main="Chango",sub="Utu Grip"}
	sets.weapons.Ragnarok = {main="Ragnarok",sub="Utu Grip"}
	sets.weapons.Zulfiqar = {main="Zulfiqar",sub="Utu Grip"}
	sets.weapons.Naegling = {main="Kaja Sword",sub="Blurred Shield"}
	sets.weapons.NaeglingDW = {main="Kaja Sword",sub="Firangi"}
	sets.weapons.Farsha = {main="Splinter",sub="Blurred Shield"}
	sets.weapons.FarshaDW = {main="Splinter",sub="Firangi"}
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