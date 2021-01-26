function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal','MaxAcc','Fodder')
	state.WeaponskillMode:options('Match','Normal','MaxAcc','Fodder')
	state.HybridMode:options('Normal','HybridDT','PDT','MDT')
	state.PhysicalDefenseMode:options('PDT','PDTMaxHP')
	state.MagicalDefenseMode:options('MDT','MDTMaxHP')
	state.ResistDefenseMode:options('MEVA','MEVA_Charm','MEVA_Death')
	state.IdleMode:options('Normal', 'PDT')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Passive = M{['description'] = 'Passive Mode','None'}
	state.Weapons:options('Chango','Zulfiqar','Naegling','NaeglingDW','Farsha','FarshaDW','Ukonvasara')

	gear.cichol = {}
	gear.cichol.tp = {name = "Cichol's Mantle", augments = {'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	gear.cichol.reso = {name = "Cichol's Mantle", augments = {'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}

	gear.cichol.wsd = {}
	gear.cichol.wsd.str = {name = "Cichol's Mantle", augments = {'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	gear.cichol.wsd.vit = {name = "Cichol's Mantle", augments = {'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !r gs c cycle weapons;gs c update')
	
	select_default_macro_book()
	--lockstyle:schedule(5)

	organizer_items = {
		{name = "Cichol's Mantle", augments = {'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		{name = "Cichol's Mantle", augments = {'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
		"Sublime Sushi",
		"Red Curry Bun",
		"Abdhaljs Seal",
		"Remedy",
		"Holy Water",
		"Grape Daifuku"
	}
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.Chango = {main="Chango",sub="Utu Grip"}
	sets.weapons.Zulfiqar = {main="Zulfiqar",sub="Utu Grip"}
	sets.weapons.Naegling = {main="Naegling",sub="Blurred Shield +1"}
	sets.weapons.NaeglingDW = {main="Naegling",sub="Barbarity"}
	sets.weapons.Dolichenus = {main="Dolichenus",sub="Blurred Shield +1"}
	sets.weapons.DolichenusDW = {main="Dolichenus",sub="Firangi"}
	sets.weapons.Farsha = {main="Bonebiter",sub="Blurred Shield +1"}
	sets.weapons.FarshaDW = {main="Bonebiter",sub="Firangi"}
	sets.weapons.Ukonvasara = {main="Sagaris",sub="Utu Grip"}
	
	-- Precast Sets
	
	sets.Enmity = {
		ammo="Aqreqaq Bomblet",
		head="Pummeler's Mask +2",neck="Moonbeam Necklace",ear1="Friomisi Earring",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Petrov Ring",ring2="Supershear Ring",
		legs=gear.odyssean.cuisses.stp,feet="Souveran Schuhs +1"
	}
	sets.SIRD = {
		ammo="Staunch Tathlum",
		--[[head="Souv. Schaller +1",]]neck="Moonbeam Necklace",
		--[[hands="Eschite Gauntlets",]]
		--[[legs="Founder's Cuisses",]]feet="Souveran Schuhs +1"
	}
	sets.Knockback = {}
	sets.passive.Twilight = {--[[head="Twilight Helm",body="Twilight Mail"]]}
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Berserk'] = {body="Pumm. Lorica +3",back=gear.cichol.tp,feet="Agoge Calligae +1"}
	sets.precast.JA['Warcry'] = {head="Agoge Mask +3"}
	sets.precast.JA['Defender'] = {}
	sets.precast.JA['Aggressor'] = {head="Pummeler's Mask +2",body="Agoge Lorica +1"}
	sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers +1"}
	sets.precast.JA["Warrior's Charge"] = {legs="Agoge Cuisses +2"}
	sets.precast.JA['Tomahawk'] = {ammo="Thr. Tomahawk",feet="Agoge Calligae +1"}
	sets.precast.JA['Retaliation'] = {}
	sets.precast.JA['Restraint'] = {}
	sets.precast.JA['Blood Rage'] = {body="Rvg. Lorica +2"}
	sets.precast.JA['Brazen Rush'] = {}
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity,{})
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
	
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	sets.precast.Step = {}
	
	sets.precast.Flourish1 = {}
	
	-- Fast cast sets for spells

	sets.precast.FC = {
		ammo="Impatiens",
		neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Odyss. Chestplate",hands="Leyline Gloves",ring1="Defending Ring",ring2="Lebeche Ring",
		back=gear.cichol.tp,waist="Flume Belt +1",legs="Arjuna Breeches",feet="Odyssean Greaves"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC, sets.SIRD, {})
	
	sets.midcast.Utsusemi = set_combine(sets.FastRecast, {})
	
	sets.midcast.Cure = {}
	
	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {hands="Souv. Handsch. +1",waist="Gishdubar Sash",legs="Flamma Dirs +2",feet="Souveran Schuhs +1"}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Knobkierrie",
		head="Agoge Mask +3",neck="War. Beads +2",ear1="Thrud Earring",ear2="Moonshade Earring",
		body="Pumm. Lorica +3",hands=gear.odyssean.gauntlets.vitwsd,ring1="Regal Ring",ring2="Niqmaddu Ring",
		back=gear.cichol.wsd.str,waist="Sailfi Belt +1",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"
	}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {hands="Flam. Manopolas +2"})

	sets.precast.WS.MaxAcc = set_combine(sets.precast.WS.Acc, {head="Pummeler's Mask +2",legs="Pumm. Cuisses +3"})

	sets.MaxTP = {ear1="Lugra Earring +1",ear2="Thrud Earring"}
	sets.AccMaxTP = {ear1="Lugra Earring +1",ear2="Thrud Earring"}
	sets.DayWSEars = {ear1="Thrud Earring",ear2="Moonshade Earring"}
	sets.AccDayWSEars = {ear1="Thrud Earring",ear2="Moonshade Earring"}
	sets.DayMaxTPWSEars = {ear1="Lugra Earring +1",ear2="Thrud Earring"}
	sets.AccDayMaxTPWSEars = {ear1="Thrud Earring",ear2="Mache Earring +1"}

	--[[ Great Axe WS ]]
	--[[ Upheaval ]]
	sets.precast.WS.Upheaval = set_combine(sets.precast.WS, {back=gear.cichol.wsd.vit})
	sets.precast.WS.Upheaval.Acc = set_combine(sets.precast.WS.Upheaval, {hands="Sulev. Gauntlets +2"})
	sets.precast.WS.Upheaval.MaxAcc = set_combine(sets.precast.WS.Upheaval.Acc, {})

	--[[ King's Justice ]]
	sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["King's Justice"].Acc = set_combine(sets.precast.WS["King's Justice"], {hands="Sulev. Gauntlets +2"})
	sets.precast.WS["King's Justice"].MaxAcc = set_combine(sets.precast.WS["King's Justice"].Acc, {})

	--[[ Full Break ]]
	sets.precast.WS["Full Break"] = set_combine(sets.precast.WS, {
		neck="Sanctity Necklace",hands="Flam. Manopolas +2",legs="Flamma Dirs +2",feet="Flam. Gambieras +2"
	})
	sets.precast.WS["Full Break"].Acc = set_combine(sets.precast.WS["Full Break"], {})
	sets.precast.WS["Full Break"].MaxAcc = set_combine(sets.precast.WS["Full Break"].Acc, {})

	--[[ Breaks ]]
	sets.precast.WS["Armor Break"] = sets.precast.WS["Full Break"]
	sets.precast.WS["Shield Break"] = sets.precast.WS["Full Break"]
	sets.precast.WS["Weapon Break"] = sets.precast.WS["Full Break"]

	--[[ Ukko's Fury ]]
	sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {
		ammo="Yetshila",ear1="Lugra Earring +1",body="Hjarrandi Breast.",hands="Flam. Manopolas +2",feet="Boii Calligae +1"
	})
	sets.precast.WS["Ukko's Fury"].Acc = set_combine(sets.precast.WS["Ukko's Fury"], {})
	sets.precast.WS["Ukko's Fury"].MaxAcc = set_combine(sets.precast.WS["Ukko's Fury"].Acc, {})

	sets.MaxTP["Ukko's Fury"] = {ear1="Lugra Earring +1",ear2="Lugra Earring"}
	sets.AccMaxTP["Ukko's Fury"] = {ear1="Lugra Earring +1",ear2="Lugra Earring"}
	sets.DayWSEars["Ukko's Fury"] = {ear1="Lugra Earring +1",ear2="Moonshade Earring"}
	sets.AccDayWSEars["Ukko's Fury"] = {ear1="Lugra Earring +1",ear2="Moonshade Earring"}
	sets.DayMaxTPWSEars["Ukko's Fury"] = {ear1="Lugra Earring +1",ear2="Thrud Earring"}
	sets.AccDayMaxTPWSEars["Ukko's Fury"] = {ear1="Lugra Earring +1",ear2="Thrud Earring"}

	--[[ Raging Rush ]]
	sets.precast.WS["Raging Rush"] = sets.precast.WS["Ukko's Fury"]

	sets.MaxTP["Raging Rush"] = sets.MaxTP["Ukko's Fury"]
	sets.AccMaxTP["Raging Rush"] = sets.AccMaxTP["Ukko's Fury"]
	sets.DayWSEars["Raging Rush"] = sets.DayWSEars["Ukko's Fury"]
	sets.AccDayWSEars["Raging Rush"] = sets.AccDayWSEars["Ukko's Fury"]
	sets.DayMaxTPWSEars["Raging Rush"] = sets.DayMaxTPWSEars["Ukko's Fury"]
	sets.AccDayMaxTPWSEars["Raging Rush"] = sets.AccDayMaxTPWSEars["Ukko's Fury"]

	--[[ Fell Cleave ]]
	sets.precast.WS["Fell Cleave"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Fell Cleave"].Acc = set_combine(sets.precast.WS["Fell Cleave"], {})	
	sets.precast.WS["Fell Cleave"].MaxAcc = set_combine(sets.precast.WS["Fell Cleave"].Acc, {})

	--[[ Steel Cyclone ]]
	sets.precast.WS["Steel Cyclone"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Steel Cyclone"].Acc = set_combine(sets.precast.WS["Steel Cyclone"], {})
	sets.precast.WS["Steel Cyclone"].MaxAcc = set_combine(sets.precast.WS["Steel Cyclone"].Acc, {})

	--[[ Great Sword ]]
	--[[ Resolution ]]
	sets.precast.WS.Resolution = set_combine(sets.precast.WS, {
		ammo="Seeth. Bomblet +1",
		head="Flam. Zucchetto +2",neck="Fotia Gorget",ear1="Lugra Earring +1",
		body="Argosy Hauberk +1",hands="Argosy Mufflers +1",
		back=gear.cichol.reso,waist="Fotia Belt",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"
	})
	sets.precast.WS.Resolution.Acc = set_combine(sets.precast.WS.Resolution, {})
	sets.precast.WS.Resolution.MaxAcc = set_combine(sets.precast.WS.Resolution.Acc, {})

	sets.MaxTP.Resolution = {ear1="Lugra Earring +1",ear2="Lugra Earring"}
	sets.AccMaxTP.Resolution = {ear1="Lugra Earring +1",ear2="Lugra Earring"}
	sets.DayWSEars.Resolution = {ear1="Lugra Earring +1",ear2="Thrud Earring"}
	sets.AccDayWSEars.Resolution = {ear1="Lugra Earring +1",ear2="Thrud Earring"}
	sets.DayMaxTPWSEars.Resolution = {ear1="Lugra Earring +1",ear2="Thrud Earring"}
	sets.AccDayMaxTPWSEars.Resolution = {ear1="Lugra Earring +1",ear2="Thrud Earring"}

	--[[ Ground Strike ]]
	sets.precast.WS["Ground Strike"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Ground Strike"].Acc = set_combine(sets.precast.WS["Ground Strike"], {})
	sets.precast.WS["Ground Strike"].MaxAcc = set_combine(sets.precast.WS["Ground Strike"].Acc, {})

	--[[ Herculean Slash ]]
	sets.precast.WS["Herculean Slash"] = set_combine(sets.precast.WS, {
		neck="Baetyl Pendant",ear1="Friomisi Earring",
		body="Found. Breastplate",hands=gear.odyssean.gauntlets.magicwsd,ring2="Shiva Ring +1",
		waist="Eschan Stone",legs="Flamma Dirs +2",gear.valorous.greaves.magicwsd
	})
	sets.precast.WS["Herculean Slash"].Acc = set_combine(sets.precast.WS["Herculean Slash"], {})
	sets.precast.WS["Herculean Slash"].MaxAcc = set_combine(sets.precast.WS["Herculean Slash"].Acc, {})

	sets.MaxTP["Herculean Slash"] = {ear1="Friomisi Earring",ear2="Thrud Earring"}
	sets.AccMaxTP["Herculean Slash"] = {ear1="Friomisi Earring",ear2="Thrud Earring"}
	sets.DayWSEars["Herculean Slash"] = {ear1="Friomisi Earring",ear2="Thrud Earring"}
	sets.AccDayWSEars["Herculean Slash"] = {ear1="Friomisi Earring",ear2="Thrud Earring"}
	sets.DayMaxTPWSEars["Herculean Slash"] = {ear1="Friomisi Earring",ear2="Thrud Earring"}
	sets.AccDayMaxTPWSEars["Herculean Slash"] = {ear1="Friomisi Earring",ear2="Thrud Earring"}

	--[[ Shockwave ]]
	sets.precast.WS["Shockwave"] = sets.precast.WS["Full Break"]

	--[[ Sword ]]
	--[[ Savage Blade ]]
	sets.precast.WS["Savage Blade"] = sets.precast.WS["King's Justice"]
	
	--[[ Vorpal Blade ]]
	sets.precast.WS["Vorpal Blade"] = sets.precast.WS["Ukko's Fury"]

	sets.MaxTP["Vorpal Blade"] = sets.MaxTP["Ukko's Fury"]
	sets.AccMaxTP["Vorpal Blade"] = sets.AccMaxTP["Ukko's Fury"]
	sets.DayWSEars["Vorpal Blade"] = sets.DayWSEars["Ukko's Fury"]
	sets.AccDayWSEars["Vorpal Blade"] = sets.AccDayWSEars["Ukko's Fury"]
	sets.DayMaxTPWSEars["Vorpal Blade"] = sets.DayMaxTPWSEars["Ukko's Fury"]
	sets.AccDayMaxTPWSEars["Vorpal Blade"] = sets.AccDayMaxTPWSEars["Ukko's Fury"]
	
	--[[ Sanguine Blade ]]
	sets.precast.WS["Sanguine Blade"] = set_combine(sets.precast.WS["Herculean Slash"], {head="Pixie Hairpin +1",ring2="Archon Ring"})
	sets.precast.WS["Sanguine Blade"].Acc = set_combine(sets.precast.WS["Sanguine Blade"], {})
	sets.precast.WS["Sanguine Blade"].MaxAcc = set_combine(sets.precast.WS["Sanguine Blade"].Acc, {})

	sets.MaxTP["Sanguine Blade"] = sets.MaxTP["Herculean Slash"]
	sets.AccMaxTP["Sanguine Blade"] = sets.AccMaxTP["Herculean Slash"]
	sets.DayWSEars["Sanguine Blade"] = sets.DayWSEars["Herculean Slash"]
	sets.AccDayWSEars["Sanguine Blade"] = sets.AccDayWSEars["Herculean Slash"]
	sets.DayMaxTPWSEars["Sanguine Blade"] = sets.DayMaxTPWSEars["Herculean Slash"]
	sets.AccDayMaxTPWSEars["Sanguine Blade"] = sets.AccDayMaxTPWSEars["Herculean Slash"]
	
	--[[ Red Lotus Blade ]]
	sets.precast.WS["Red Lotus Blade"] = sets.precast.WS["Herculean Slash"]

	sets.MaxTP["Red Lotus Blade"] = sets.MaxTP["Herculean Slash"]
	sets.AccMaxTP["Red Lotus Blade"] = sets.AccMaxTP["Herculean Slash"]
	sets.DayWSEars["Red Lotus Blade"] = sets.DayWSEars["Herculean Slash"]
	sets.AccDayWSEars["Red Lotus Blade"] = sets.AccDayWSEars["Herculean Slash"]
	sets.DayMaxTPWSEars["Red Lotus Blade"] = sets.DayMaxTPWSEars["Herculean Slash"]
	sets.AccDayMaxTPWSEars["Red Lotus Blade"] = sets.AccDayMaxTPWSEars["Herculean Slash"]
	
	--[[ Requiescat ]]
	sets.precast.WS.Requiescat = set_combine(sets.precast.WS, {
		head="Hjarrandi Helm",neck="Fotia Gorget",ear1="Lugra Earring +1",
		body="Dagon Breast.",hands="Sulev. Gauntlets +2",
		waist="Fotia Belt",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"
	})
	sets.precast.WS.Requiescat.Acc = set_combine(sets.precast.WS.Requiescat, {})
	sets.precast.WS.Requiescat.MaxAcc = set_combine(sets.precast.WS.Requiescat.Acc, {})

	sets.MaxTP.Requiescat = {ear1="Lugra Earring +1",ear2="Lugra Earring"}
	sets.AccMaxTP.Requiescat = {ear1="Lugra Earring +1",ear2="Lugra Earring"}
	sets.DayWSEars.Requiescat = {ear1="Lugra Earring +1",ear2="Moonshade Earring"}
	sets.AccDayWSEars.Requiescat = {ear1="Lugra Earring +1",ear2="Moonshade Earring"}
	sets.DayMaxTPWSEars.Requiescat = {ear1="Brutal Earring",ear2="Lugra Earring +1"}
	sets.AccDayMaxTPWSEars.Requiescat = {ear1="Lugra Earring +1",ear2="Telos Earring"}

	-- Axe
	--[[ Decimation ]]
	sets.precast.WS.Decimation = sets.precast.WS.Resolution

	sets.MaxTP.Decimation = sets.MaxTP.Resolution
	sets.AccMaxTP.Decimation = sets.AccMaxTP.Resolution
	sets.DayWSEars.Decimation = sets.DayWSEars.Resolution
	sets.AccDayWSEars.Decimation = sets.AccDayWSEars.Resolution
	sets.DayMaxTPWSEars.Decimation = sets.DayMaxTPWSEars.Resolution
	sets.AccDayMaxTPWSEars.Decimation = sets.AccDayMaxTPWSEars.Resolution

	--[[ Ruinator ]]
	sets.precast.WS.Ruinator = sets.precast.WS.Resolution

	sets.MaxTP.Ruinator = sets.MaxTP.Resolution
	sets.AccMaxTP.Ruinator = sets.AccMaxTP.Resolution
	sets.DayWSEars.Ruinator = sets.DayWSEars.Resolution
	sets.AccDayWSEars.Ruinator = sets.AccDayWSEars.Resolution
	sets.DayMaxTPWSEars.Ruinator = sets.DayMaxTPWSEars.Resolution
	sets.AccDayMaxTPWSEars.Ruinator = sets.AccDayMaxTPWSEars.Resolution

	--[[ Calamity ]]
	sets.precast.WS.Calamity = sets.precast.WS["King's Justice"]

	--[[ Mistral Axe ]]
	sets.precast.WS["Savage Blade"] = sets.precast.WS["King's Justice"]

	--[[ Cloud Splitter ]]
	sets.precast.WS.Cloudsplitter = sets.precast.WS["Herculean Slash"]

	sets.MaxTP.Cloudsplitter = sets.MaxTP["Herculean Slash"]
	sets.AccMaxTP.Cloudsplitter = sets.AccMaxTP["Herculean Slash"]
	sets.DayWSEars.Cloudsplitter = sets.DayWSEars["Herculean Slash"]
	sets.AccDayWSEars.Cloudsplitter = sets.AccDayWSEars["Herculean Slash"]
	sets.DayMaxTPWSEars.Cloudsplitter = sets.DayMaxTPWSEars["Herculean Slash"]
	sets.AccDayMaxTPWSEars.Cloudsplitter = sets.AccDayMaxTPWSEars["Herculean Slash"]

	-- Shining One
	--[[ Impulse Drive ]]
	sets.precast.WS["Impulse Drive"] = sets.precast.WS["King's Justice"]

	--[[ Stardiver ]]
	sets.precast.WS.Stardiver = sets.precast.WS.Resolution

	sets.MaxTP.Stardiver = sets.MaxTP.Resolution
	sets.AccMaxTP.Stardiver = sets.AccMaxTP.Resolution
	sets.DayWSEars.Stardiver = sets.DayWSEars.Resolution
	sets.AccDayWSEars.Stardiver = sets.AccDayWSEars.Resolution
	sets.DayMaxTPWSEars.Stardiver = sets.DayMaxTPWSEars.Resolution
	sets.AccDayMaxTPWSEars.Stardiver = sets.AccDayMaxTPWSEars.Resolution

	--[[ Sonic Thrust ]]
	sets.precast.WS["Sonic Thrust"] = sets.precast.WS["King's Justice"]

	-- Sets to return to when not performing an action.

	-- Idle sets
	sets.idle = {
		ammo="Staunch Tathlum",
		head=gear.valorous.mask.strwsd,neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
		body="Volte Haubert",hands="Souv. Handsch. +1",ring1="Moonbeam Ring",ring2="Defending Ring",
		back=gear.cichol.tp,waist="Asklepian Belt",legs="Pumm. Cuisses +3",feet="Souveran Schuhs +1"
	}
		
	sets.idle.Weak = set_combine(sets.idle, sets.passive.Twilight, {})
		
	sets.idle.Reraise = set_combine(sets.idle, sets.passive.Twilight, {})
	
	-- Resting sets
	sets.resting = sets.idle
	
	-- Defense sets
	sets.defense.PDT = {
		ammo="Staunch Tathlum",
		neck="Loricate Torque +1",
		body="Hjarrandi Breast.",hands="Pumm. Mufflers +2",ring1="Moonbeam Ring",
		back=gear.cichol.tp,legs="Pumm. Cuisses +3",feet="Souveran Schuhs +1"
	}
		
	sets.defense.PDTMaxHP = set_combine(sets.defense.PDT, {
		head="Hjarrandi Helm",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
		hands="Souv. Handsch. +1",ring2="Supershear Ring",
		back="Moonbeam Cape"
	})
		
	sets.defense.PDTReraise = set_combine(sets.defense.PDT, sets.passive.Twilight, {})

	sets.defense.MDT = {
		ammo="Staunch Tathlum",
		head="Founder's Corona",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
		body="Hjarrandi Breast.",hands="Souv. Handsch. +1",ring1="Moonbeam Ring",ring2="Purity Ring",
		back="Moonbeam Cape",waist="Asklepian Belt",legs="Pumm. Cuisses +3",feet=gear.valorous.greaves.strwsd,
	}
		
	sets.defense.MDTMaxHP = set_combine(sets.defense.MDT, {ear2="Odnowa Earring",feet="Souveran Schuhs +1"})
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, sets.passive.Twilight, {})
		
	sets.defense.MEVA = set_combine(sets.defense.MDT, {ear1="Eabani Earring",body="Volte Haubert",back="Solemnity Cape",waist="Engraved Belt",feet="Pumm. Calligae +3"})
	sets.defense.MEVA_Charm = set_combine(sets.defense.MEVA, {back="Solemnity Cape",--[[legs="Souv. Diechlings +1"]]})
	sets.defense.MEVA_Death = set_combine(sets.defense.MEVA, {})
	sets.defense.MEVA_Terror = set_combine(sets.defense.MEVA, {feet="Founder's Greaves"})

	sets.Kiting = {}
	sets.Reraise = sets.passive.Twilight
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
     
	-- Engaged sets

	-- Default Builds
	sets.engaged = {
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",neck="War. Beads +2",ear1="Brutal Earring",ear2="Dedition Earring",
		body=gear.valorous.mail.da,hands="Sulev. Gauntlets +2",ring1="Petrov Ring",ring2="Niqmaddu Ring",
		back=gear.cichol.tp,waist="Sailfi Belt +1",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"
	}
	sets.engaged.HybridDT = set_combine(sets.engaged, {})
	
	sets.engaged.Acc = set_combine(sets.engaged, {ear2="Telos Earring",waist="Ioskeha Belt +1"})
	sets.engaged.Acc.HybridDT = set_combine(sets.engaged.HybridDT, {})

	sets.engaged.MaxAcc = set_combine(sets.engaged.Acc, {ear1="Cessance Earring",ring1="Regal Ring"})
	sets.engaged.MaxAcc.HybridDT = set_combine(sets.engaged.Acc.HybridDT, {})

	-- Fencer Builds
	sets.engaged.Fencer = set_combine(sets.engaged, {})
	sets.engaged.Fencer.HybridDT = set_combine(sets.engaged.Fencer, {})
	
	sets.engaged.Fencer.Acc = set_combine(sets.engaged.Fencer, {})
	sets.engaged.Fencer.Acc.HybridDT = set_combine(sets.engaged.Fencer.HybridDT, {})

	sets.engaged.Fencer.MaxAcc = set_combine(sets.engaged.Fencer.Acc, {})
	sets.engaged.Fencer.MaxAcc.HybridDT = set_combine(sets.engaged.Fencer.Acc.HybridDT, {})

	-- DW Builds
	sets.engaged.DW = set_combine(sets.engaged, {ear1="Suppanomimi",hands="Emi. Gauntlets +1"})
	sets.engaged.DW.HybridDT = set_combine(sets.engaged.DW, {})
	
	sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {})
	sets.engaged.DW.Acc.HybridDT = set_combine(sets.engaged.DW.HybridDT, {})

	sets.engaged.DW.MaxAcc = set_combine(sets.engaged.DW.Acc, {})
	sets.engaged.DW.MaxAcc.HybridDT = set_combine(sets.engaged.DW.Acc.HybridDT, {})
	
	--Extra Special Sets
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Retaliation = {}
	sets.buff.Restraint = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {head=gear.valorous.mask.TH,hands=gear.valorous.mitts.TH})
	sets.MaxDW = {}
	
	
end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 3)
    else
        set_macro_page(1, 3)
	end
	
end

function lockstyle()
	windower.chat.input("/lockstyleset 003")
end