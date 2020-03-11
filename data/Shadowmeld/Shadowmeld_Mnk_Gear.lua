function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','MaxAcc')
    state.WeaponskillMode:options('Match','Normal','MaxAcc')
    state.HybridMode:options('Normal','SubtleBlow','HybridDT','PDT','MDT')
    state.PhysicalDefenseMode:options('PDT', 'HP')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT')
	state.Weapons:options('Karambit','Godhands')

	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None'}
	
	gear.segomo = {}
	gear.segomo.tp = {}
	gear.segomo.tp.da = {name="Segomo's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}

	gear.segomo.ws = {}
	gear.segomo.ws.smite = {name="Segomo's Mantle",augments={}}
	gear.segomo.ws.tornado = {name="Segomo's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

    update_melee_groups()
	
	-- Additional local binds
	send_command('bind ^` input /ja "Boost" <me>')
	send_command('bind !` input /ja "Perfect Counter" <me>')
	send_command('bind ^backspace input /ja "Mantra" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	
	select_default_macro_book()
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs on use
	sets.precast.JA['Hundred Fists'] = {}
	sets.precast.JA['Boost'] = {}
	sets.precast.JA['Dodge'] = {}
	sets.precast.JA['Focus'] = {}
	sets.precast.JA['Counterstance'] = {}
	sets.precast.JA['Footwork'] = {}
	sets.precast.JA['Formless Strikes'] = {}
	sets.precast.JA['Mantra'] = {
		head="Halitus Helm",neck="Sanctity Necklace",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
		body="Malignance Tabard",hands="Rawhide Gloves",ring1="Ilabrat Ring",ring2="Etana Ring",
		back="Moonbeam Cape",waist="Kasiri Belt",legs="Ryuo Hakama",feet="Ryuo Sune-ate +1"
	}

	sets.precast.JA['Chi Blast'] = {}
	
	sets.precast.JA['Chakra'] = {}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {}
		
	sets.precast.Flourish1 = {}


	-- Fast cast sets for spells
	
	sets.precast.FC = {
		ammo="Impatiens",
		head=gear.herculean.helm.dexwsd,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body=gear.taeon.tabard.fc,hands="Leyline Gloves",ring1="Lebeche Ring",
		legs="Limbo Trousers"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Knobkierrie",
		head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Sherida Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar.wrist.path_b,ring1="Gere Ring",ring2="Niqmaddu Ring",
		back=gear.segomo.ws.tornado,waist="Fotia Belt",legs="Samnuha Tights",feet=gear.herculean.boots.ta_low_acc
	}
	sets.precast.WS.MaxAcc = set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.

	sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {
		body="Abnoba Kaftan",feet="Mummu Gamash. +2"
	})
	sets.precast.WS['Victory Smite'].MaxAcc = set_combine(sets.precast.WS['Victory Smite'], {})

	sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {
		ammo="Aurgelmir Orb",ear1="Moonshade Earring",
	})
	sets.precast.WS['Raging Fists'].MaxAcc = set_combine(sets.precast.WS['Raging Fists'], {})

	sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
		ammo="Aurgelmir Orb",ear1="Mache Earring +1",back=gear.segomo.tp.da
	})
	sets.precast.WS['Shijin Spiral'].MaxAcc = set_combine(sets.precast.WS['Shijin Spiral'], {})

	sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {
		ear1="Moonshade Earring"
	})
	sets.precast.WS['Howling Fist'].MaxAcc = set_combine(sets.precast.WS['Howling Fist'], {})

	sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {
		ear1="Moonshade Earring"
	})
	sets.precast.WS['Tornado Kick'].MaxAcc = set_combine(sets.precast.WS['Tornado Kick'], {})

	sets.precast.WS['Asuran Fist'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Asuran Fist'].MaxAcc = set_combine(sets.precast.WS['Asuran Fist'], {})

	sets.precast.WS["Ascetic's Fury"] = set_combine(sets.precast.WS, {
		body="Abnoba Kaftan",feet="Mummu Gamash +2"
	})
	sets.precast.WS["Ascetic's Fury"].MaxAcc = set_combine(sets.precast.WS["Ascetic's Fury"], {})
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
	
	-- Midcast Sets
	sets.midcast.FastRecast = {}
		
	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
		
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {}
	

	-- Idle sets
	sets.idle = {
		ammo="Staunch Tathlum",
		head="Malignance Chapeau",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Eabani Earring",
		body="Malignance Tabard",hands=gear.herculean.gloves.refresh,ring1="Defending Ring",ring2="Purity Ring",
		back="Moonbeam Cape",waist="Moonbow Belt",legs="Malignance Tights",feet="Ahosi Leggings"
	}

	sets.idle.PDT = {}

	-- Defense sets
	sets.defense.PDT = {}

	sets.defense.HP = {}

	sets.defense.MDT = {}
		
	sets.defense.MEVA = {}

	sets.Kiting = {}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee sets
	sets.engaged = {
		ammo="Aurgelmir Orb",
		head="Adhemar Bonnet +1",neck="Anu Torque",ear1="Telos Earring",ear2="Sherida Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar.wrist.path_b,ring1="Gere Ring",ring2="Niqmaddu Ring",
		back=gear.segomo.tp.da,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean.boots.ta_low_acc
	}
	sets.engaged.MaxAcc = set_combine(sets.engaged, {
		head="Malignance Chapeau",neck="Lissome Torque",
		body="Malignance Tabard",ring1="Chirich Ring",
		waist="Grunfeld Rope",legs="Malignance Tights",feet="Mummu Gamash. +2"
	})

	sets.engaged.SubtleBlow = set_combine(sets.engaged, {})
	sets.engaged.SubtleBlow.MaxAcc = set_combine(sets.engaged.MaxAcc, {})

	sets.engaged.HybridDT = set_combine(sets.engaged, {
		head="Malignance Chapeau",body="Malignance Tabard",legs="Malignance Tights",
	})
	sets.engaged.HybridDT.MaxAcc = set_combine(sets.engaged.MaxAcc, {})

	sets.engaged.PDT = set_combine(sets.engaged.HybridDT, {
		neck="Loricate Torque +1",ring1="Defending Ring",
	})
	sets.engaged.PDT.MaxAcc = set_combine(sets.engaged.HybridDT.MaxAcc, {})

	sets.engaged.MDT = set_combine(sets.engaged.HybridDT, {
		neck="Warder's Charm +1",ear1="Eabani Earring",ring1="Purity Ring"
	})
	sets.engaged.MDT.MaxAcc = set_combine(sets.engaged.HybridDT.MaxAcc, {})

	-- Hundred Fists/Impetus melee set mods
	
	sets.engaged.HF = set_combine(sets.engaged, {})
	sets.engaged.MaxAcc.HF = set_combine(sets.engaged.MaxAcc, {})

	sets.engaged.SubtleBlow.HF = set_combine(sets.engaged.SubtleBlow, {})
	sets.engaged.SubtleBlow.MaxAcc.HF = set_combine(sets.engaged.SubtleBlow.MaxAcc, {})

	sets.engaged.HybridDT.HF = set_combine(sets.engaged.HybridDT, {})
	sets.engaged.HybridDT.MaxAcc.HF = set_combine(sets.engaged.HybridDT.MaxAcc, {})

	sets.engaged.PDT.HF = set_combine(sets.engaged.PDT, {})
	sets.engaged.PDT.MaxAcc.HF = set_combine(sets.engaged.PDT.MaxAcc, {})

	sets.engaged.MDT.HF = set_combine(sets.engaged.SubtleBlow, {})
	sets.engaged.MDT.MaxAcc.HF = set_combine(sets.engaged.MDT.MaxAcc, {})

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
	sets.buff.Impetus = {}
	sets.buff.Footwork = {}
	sets.buff.Boost = {}
	
	sets.FootworkWS = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
    sets.Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {head=gear.herculean.helm.TH,feet=gear.herculean.boots.TH})
	sets.Skillchain = {}
	
	-- Weapons sets
	sets.weapons.Godhands = {main="Godhands"}
	sets.weapons.Karambit = {main="Kaja Knuckles"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(5, 20)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 20)
	elseif player.sub_job == 'THF' then
		set_macro_page(6, 20)
	elseif player.sub_job == 'RUN' then
		set_macro_page(7, 20)
	else
		set_macro_page(1, 20)
	end
end