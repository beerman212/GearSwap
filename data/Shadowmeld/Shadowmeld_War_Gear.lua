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
	state.Weapons:options('Chango','Zulfiqar','Naegling','NaeglingDW')

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
		{name = "Cichol's Mantle", augments = {'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}
	}
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	-- Precast Sets
	
	sets.Enmity = {
		ammo="Aqreqaq Bomblet",
		head="Pummeler's Mask +2",neck="Moonbeam Necklace",ear1="Friomisi Earring",
		body="Souveran Cuirass",hands="Souv. Handsch. +1",ring1="Petrov Ring",ring2="Supershear Ring",
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
	sets.precast.JA['Warcry'] = {head="Agoge Mask +2"}
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

	sets.precast.FC = {ammo="Impatiens",
		neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Odyss. Chestplate",hands="Leyline Gloves",ring1="Defending Ring",ring2="Lebeche Ring",
		back=gear.cichol.tp,waist="Flume Belt +1",legs="Arjuna Breeches",feet="Odyssean Greaves"}

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
		head="Agoge Mask +2",neck="Fotia Gorget",ear1="Lugra Earring +1",ear2="Moonshade Earring",
		body="Pumm. Lorica +3",hands=gear.odyssean.gauntlets.vitwsd,ring1="Shukuyu Ring",ring2="Niqmaddu Ring",
		back=gear.cichol.wsd.str,waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"
	}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

	sets.precast.WS.MaxAcc = set_combine(sets.precast.WS.Acc, {head="Pummeler's Mask +2",hands="Flam. Manopolas +2",ring1="Flamma Ring",legs="Pumm. Cuisses +3"})

	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

	--[[ Great Axe WS ]]
	--[[ Upheaval ]]
	sets.precast.WS["Upheaval"] = set_combine(sets.precast.WS, {back=gear.cichol.wsd.vit,waist="Caudata Belt"})

	sets.precast.WS["Upheaval"].Acc = sets.precast.WS["Upheaval"]
	
	sets.precast.WS["Upheaval"].MaxAcc = set_combine(sets.precast.WS["Upheaval"].Acc, {head="Pummeler's Mask +2",hands="Flam. Manopolas +2",ring1="Flamma Ring",legs="Pumm. Cuisses +3"})

	sets.precast.WS["Upheaval"].Fodder = set_combine(sets.precast.WS["Upheaval"], {})

	--[[ King's Justice ]]
	sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {
		neck="Caro Necklace",waist="Caudata Belt"
	})

	sets.precast.WS["King's Justice"].Acc = sets.precast.WS["King's Justice"]
	
	sets.precast.WS["King's Justice"].MaxAcc = set_combine(sets.precast.WS["King's Justice"].Acc, {ammo="Seeth. Bomblet +1",head="Pummeler's Mask +2",hands="Flam. Manopolas +2",ring1="Flamma Ring",legs="Pumm. Cuisses +3"})

	sets.precast.WS["King's Justice"].Fodder = set_combine(sets.precast.WS["King's Justice"], {})

	--[[ Full Break ]]
	sets.precast.WS["Full Break"] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		neck="Sanctity Necklace",ear2="Digni. Earring",
		hands="Flam. Manopolas +2",ring1="Flamma Ring",
		legs="Flamma Dirs +2",feet="Flam. Gambieras +2"
	})

	sets.precast.WS["Full Break"].Acc = sets.precast.WS["Full Break"]
	
	sets.precast.WS["Full Break"].MaxAcc = set_combine(sets.precast.WS["Full Break"].Acc, {})

	sets.precast.WS["Full Break"].Fodder = set_combine(sets.precast.WS["Full Break"], {})

	--[[ Breaks ]]
	sets.precast.WS["Armor Break"] = sets.precast.WS["Full Break"]
	sets.precast.WS["Shield Break"] = sets.precast.WS["Full Break"]
	sets.precast.WS["Weapon Break"] = sets.precast.WS["Full Break"]

	--[[ Ukko's Fury ]]
	sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {})

	sets.precast.WS["Ukko's Fury"].Acc = sets.precast.WS["Ukko's Fury"]
	
	sets.precast.WS["Ukko's Fury"].MaxAcc = set_combine(sets.precast.WS["Ukko's Fury"].Acc, {})

	sets.precast.WS["Ukko's Fury"].Fodder = set_combine(sets.precast.WS["Ukko's Fury"], {})

	--[[ Raging Rush ]]
	sets.precast.WS["Raging Rush"] = sets.precast.WS["Ukko's Fury"]

	--[[ Fell Cleave ]]
	sets.precast.WS["Fell Cleave"] = set_combine(sets.precast.WS, {})

	sets.precast.WS["Fell Cleave"].Acc = sets.precast.WS["Fell Cleave"]
	
	sets.precast.WS["Fell Cleave"].MaxAcc = set_combine(sets.precast.WS["Fell Cleave"].Acc, {})

	sets.precast.WS["Fell Cleave"].Fodder = set_combine(sets.precast.WS["Fell Cleave"], {})

	--[[ Steel Cyclone ]]
	sets.precast.WS["Steel Cyclone"] = set_combine(sets.precast.WS, {})

	sets.precast.WS["Steel Cyclone"].Acc = sets.precast.WS["Steel Cyclone"]
	
	sets.precast.WS["Steel Cyclone"].MaxAcc = set_combine(sets.precast.WS["Steel Cyclone"].Acc, {})

	sets.precast.WS["Steel Cyclone"].Fodder = set_combine(sets.precast.WS["Steel Cyclone"], {})

	-- sets.precast.WS = {
	-- 	ammo="Knobkierrie",
	-- 	head="Agoge Mask +2",neck="Fotia Gorget",ear1="Lugra Earring +1",ear2="Moonshade Earring",
	-- 	body="Pumm. Lorica +3",hands=gear.odyssean.gauntlets.vitwsd,ring1="Shukuyu Ring",ring2="Niqmaddu Ring",
	-- 	back=gear.cichol.wsd.str,waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"
	-- }
	
	-- sets.precast.WS.Acc = set_combine(sets.precast.WS, {legs="Pumm. Cuisses +3"})
	-- sets.precast.WS.MaxAcc = set_combine(sets.precast.WS, {legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"})
	-- sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})
	
	-- -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.	
	-- sets.precast.WS['Upheaval'] = {
	-- 	ammo="Knobkierrie",
	-- 	head="Agoge Mask +2",neck="Fotia Gorget",ear1="Lugra Earring +1",ear2="Moonshade Earring",
	-- 	body="Pumm. Lorica +3",hands=gear.odyssean.gauntlets.vitwsd,ring1="Shukuyu Ring",ring2="Niqmaddu Ring",
	-- 	back=gear.cichol.wsd.vit,waist="Caudata Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2",
	-- }
	
	-- sets.precast.WS['Upheaval'].Acc = set_combine(sets.precast.WS.Acc, {hands="Flam. Manopolas +2",ring1="Flamma Ring"})
	-- sets.precast.WS['Upheaval'].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {head="Pummeler's Mask +2",hands="Flam. Manopolas +2",ring1="Flamma Ring"})
	-- sets.precast.WS['Upheaval'].Fodder = set_combine(sets.precast.WS.Fodder, {})
		
	-- sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {})
	-- sets.precast.WS["Ukko's Fury"].Acc = set_combine(sets.precast.WS.Acc, {})
	-- sets.precast.WS["Ukko's Fury"].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {})
	-- sets.precast.WS["Ukko's Fury"].Fodder = set_combine(sets.precast.WS.Fodder, {})

	-- sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {
	-- 	neck="Caro Necklace",waist="Grunfeld Rope",legs="Argosy Breeches +1"})
	-- sets.precast.WS["King's Justice"].Acc = set_combine(sets.precast.WS.Acc, {})
	-- sets.precast.WS["King's Justice"].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {hands="Flam. Manopolas +2",ring1="Flamma Ring"})
	-- sets.precast.WS["King's Justice"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	-- sets.precast.WS['Full Break'] = set_combine(sets.precast.WS, {
	-- 	head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear2="Digni. Earring",
	-- 	hands="Flam. Manopolas +2",ring1="Flamma Ring",
	-- 	legs="Flamma Dirs +2",feet="Flam. Gambieras +2"})
	-- sets.precast.WS['Full Break'].Acc = {}
	-- sets.precast.WS['Full Break'].MaxAcc = {}
	-- sets.precast.WS['Full Break'].Fodder = {}
		
	-- sets.precast.WS["Fell Cleave"] = set_combine(sets.precast.WS, {})
	-- sets.precast.WS["Fell Cleave"].Acc = set_combine(sets.precast.WS.Acc, {})
	-- sets.precast.WS["Fell Cleave"].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {})
	-- sets.precast.WS["Fell Cleave"].Fodder = set_combine(sets.precast.WS.Fodder, {})

	-- sets.precast.WS["Steel Cyclone"] = set_combine(sets.precast.WS, {})
	-- sets.precast.WS["Steel Cyclone"].Acc = set_combine(sets.precast.WS.Acc, {})
	-- sets.precast.WS["Steel Cyclone"].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {})
	-- sets.precast.WS["Steel Cyclone"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	-- sets.precast.WS['Armor Break'] = sets.precast.WS['Full Break']
	-- sets.precast.WS['Shield Break'] = sets.precast.WS['Full Break']

	-- sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",
	-- 	head="Flam. Zucchetto +2",
	-- 	body="Argosy Hauberk +1",hands="Argosy Mufflers +1",ring1="Flamma Ring",
	-- 	back=gear.cichol.reso,legs="Argosy Breeches +1",feet="Pumm. Calligae +3"})
	-- sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {})
	-- sets.precast.WS['Resolution'].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {body="Pumm. Lorica +3"})
	-- sets.precast.WS['Resolution'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	-- sets.precast.WS['Ground Strike'] = set_combine(sets.precast.WS, {})
	-- sets.precast.WS['Ground Strike'].Acc = set_combine(sets.precast.WS.Acc, {})
	-- sets.precast.WS['Ground Strike'].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {})
	-- sets.precast.WS['Ground Strike'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	-- sets.precast.WS['Shockwave'] = set_combine(sets.precast.WS, {ammo="Pemphredo Tathlum",
	-- 	head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Gwati Earring",
	-- 	body="Found. Breastplate",hands="Flam. Manopolas +2",ring1="Flamma Ring",
	-- 	waist="Eschan Stone",legs="Flamma Dirs +2",feet="Flam. Gambieras +2"})
	-- sets.precast.WS['Shockwave'].Acc = {}
	-- sets.precast.WS['Shockwave'].MaxAcc = {}
	-- sets.precast.WS['Shockwave'].Fodder = {}

	-- sets.precast.WS['Herculean Slash'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",
	-- 	head="Agoge Mask +2",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
	-- 	ring1="Supershear Ring",
	-- 	back=gear.cichol.wsd.vit,waist="Escha Stone",legs="Agoge Cuisses +2",feet="Pumm. Calligae +3"})
	-- sets.precast.WS['Herculean Slash'].Acc = {}
	-- sets.precast.WS['Herculean Slash'].MaxAcc = {}
	-- sets.precast.WS['Herculean Slash'].Fodder = {}
	
	-- sets.precast.WS['Freezebite'] = sets.precast.WS['Herculean Slash']

	-- sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
	-- 	neck="Caro Necklace",waist="Grunfeld Rope"})
	-- sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
	-- sets.precast.WS['Savage Blade'].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {})
	-- sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	-- sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS.Resolution, {feet="Boii Calligae +1"})
	-- sets.precast.WS['Vorpal Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
	-- sets.precast.WS['Vorpal Blade'].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {feet="Boii Calligae +1"})
	-- sets.precast.WS['Vorpal Blade'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	-- sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",
	-- 	head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
	-- 	hands="Leyline Gloves",ring1="Shiva Ring +1",ring2="Archon Ring",
	-- 	waist="Eschan Stone",legs="Limbo Trousers"})
	-- sets.precast.WS['Sanguine Blade'].Acc = set_combine(sets.precast.WS.Acc, {ear2="Digni. Earring",legs="Agoge Cuisses +2"})
	-- sets.precast.WS['Sanguine Blade'].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {head="Agoge Mask +2",ear1="Dign. Earring",ear2="Gwati Earring",feet="Pumm. Calligae +3"})
	-- sets.precast.WS['Sanguine Blade'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	-- sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",
	-- 	ear1="Telos Earring",ear2="Lugra Earring +1",hands=gear.valorous.mitts.da,ring1="Stikini Ring",
	-- 	back=gear.cichol.reso,feet="Pumm. Calligae +3"
	-- })
	
	-- sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {ring1="Chirich Ring"})
	-- sets.precast.WS['Requiescat'].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {head="Pummeler's Mask +2",ring1="Chirich Ring"})
	-- sets.precast.WS['Requiescat'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	-- sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {})
	-- sets.precast.WS['Ruinator'].Acc = set_combine(sets.precast.WS.Acc, {})
	-- sets.precast.WS['Ruinator'].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {})
	-- sets.precast.WS['Ruinator'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	-- sets.precast.WS['Rampage'] = set_combine(sets.precast.WS, {})
	-- sets.precast.WS['Rampage'].Acc = set_combine(sets.precast.WS.Acc, {})
	-- sets.precast.WS['Rampage'].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {})
	-- sets.precast.WS['Rampage'].Fodder = set_combine(sets.precast.WS.Fodder, {})


	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Telos Earring",ear2="Lugra Earring +1",}
	sets.AccMaxTP = {ear1="Telos Earring",ear2="Lugra Earring +1"}
	sets.AccDayMaxTPWSEars = {ear1="Telos Earring",ear2="Ishvara Earring"}
	sets.DayMaxTPWSEars = {ear1="Telos Earring",ear2="Ishvara Earring",}
	sets.AccDayWSEars = {ear1="Telos Earring",ear2="Moonshade Earring"}
	sets.DayWSEars = {ear1="Ishvara Earring",ear2="Moonshade Earring"}
	
	sets.MaxTP["Upheaval"] = {}
	sets.AccMaxTP["Upheaval"] = {}
	sets.DayMaxTPWSEars["Upheaval"] = {}
	sets.AccDayMaxTPWSEars["Upheaval"] = {}
	sets.DayWSEars["Upheaval"] = {}
	sets.AccDayWSEars["Upheaval"] = {}

	-- Sets to return to when not performing an action.

	-- Idle sets
	sets.idle = {
		ammo="Staunch Tathlum",
		head=gear.valorous.mask.strwsd,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
		body="Hjarrandi Breast.",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonbeam Ring",
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
		
	sets.defense.MEVA = set_combine(sets.defense.MDT, {ear1="Eabani Earring",back="Solemnity Cape",waist="Engraved Belt",feet="Pumm. Calligae +3"})
	sets.defense.MEVA_Charm = set_combine(sets.defense.MEVA, {back="Solemnity Cape",--[[legs="Souv. Diechlings +1"]]})
	sets.defense.MEVA_Death = set_combine(sets.defense.MEVA, {})
	sets.defense.MEVA_Terror = set_combine(sets.defense.MEVA, {feet="Founder's Greaves"})

	sets.Kiting = {}
	sets.Reraise = sets.passive.Twilight
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
     
	-- Engaged sets

	sets.engaged = {
		ammo="Aurgelmir Orb",
		head="Flam. Zucchetto +2",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body=gear.valorous.mail.da,hands="Sulev. Gauntlets +2",ring1="Petrov Ring",ring2="Niqmaddu Ring",
		back=gear.cichol.tp,waist="Ioskeha Belt +1",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"
	}
	sets.engaged.HybridDT = set_combine(sets.engaged, {
		body="Hjarrandi Breast.",hands=gear.valorous.mitts.da,ring1="Moonbeam Ring"
	})
	sets.engaged.PDT = set_combine(sets.engaged.HybridDT, {
		ammo="Staunch Tathlum",head="Hjarrandi Helm",hands="Pumm. Mufflers +2",waist="Tempus Fugit"
	})
	sets.engaged.MDT = set_combine(sets.engaged.HybridDT, {
		head="Hjarrandi Helm",ear1="Odnowa Earring +1",ear2="Odnowa Earring",waist="Tempus Fugit"
	})

	sets.engaged.Mighty = set_combine(sets.engaged, {ammo="Yetshila",ring1="Begrudging Ring",feet="Boii Calligae +1"})
	sets.engaged.Charge = set_combine(sets.engaged, {
		ear1="Telos Earring",body="Hjarrandi Breast.",hands="Emi. Gauntlets +1",legs="Agoge Cuisses +2",feet="Flam. Gambieras +2"
	})
	sets.engaged.Charge.Mighty = set_combine(sets.engaged.Mighty, {ear1="Telos Earring",body="Boii Lorica +1",hands="Emi. Gauntlets +1",legs="Agoge Cuisses +2"})

	-- sets.engaged.HybridDT.Mighty = set_combine(sets.engaged.HybridDT, {})
	-- sets.engaged.HybridDT.Charge = set_combine(sets.engaged.HbyridDT, {})
	-- sets.engaged.HybridDT.Charge.Mighty = set_combine(sets.engaged.HybridDT.Mighty, {})

	sets.engaged.HybridDT.Mighty = set_combine(sets.engaged.HybridDT, {ammo="Yetshila",feet="Boii Calligae +1"})
	sets.engaged.HybridDT.Charge = set_combine(sets.engaged.HbyridDT, {ear1="Telos Earring",hands="Emi. Gauntlets +1",legs="Agoge Cuisses +2"})
	sets.engaged.HybridDT.Charge.Mighty = set_combine(sets.engaged.HybridDT.Mighty, {ear1="Telos Earring",hands="Emi. Gauntlets +1",legs="Agoge Cuisses +2"})

	sets.engaged.PDT.Mighty = set_combine(sets.engaged.PDT, {feet="Boii Calligae +1"})
	sets.engaged.PDT.Charge = set_combine(sets.engaged.PDT, {})
	sets.engaged.PDT.Charge.Mighty = set_combine(sets.engaged.PDT.Mighty, {})

	sets.engaged.MDT.Mighty = set_combine(sets.engaged.MDT, {})
	sets.engaged.MDT.Charge = set_combine(sets.engaged.MDT, {})
	sets.engaged.MDT.Charge.Mighty = set_combine(sets.engaged.MDT.Mighty, {})

	sets.engaged.Acc = sets.engaged
	-- sets.engaged.Acc = set_combine(sets.engaged, {})
	-- sets.engaged.Acc.HybridDT = set_combine(sets.engaged.HybridDT, {})
	-- sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {})
	-- sets.engaged.Acc.MDT = set_combine(sets.engaged.MDT, {})

	sets.engaged.MaxAcc = set_combine(sets.engaged.Acc, {
		ammo="Seeth. Bomblet +1",
		head="Pummeler's Mask +2",ear1="Telos Earring",ear2="Mache Earring +1",
		body="Pumm. Lorica +3",hands="Pumm. Mufflers +2",ring1="Moonbeam Ring"
	})
	sets.engaged.MaxAcc.HybridDT = set_combine(sets.engaged.Acc.HybridDT, {
		ammo="Seeth. Bomblet +1",
		head="Pummeler's Mask +2",ear1="Telos Earring",ear2="Mache Earring +1",
		hands="Pumm. Mufflers +2"
	})
	sets.engaged.MaxAcc.PDT = set_combine(sets.engaged.Acc.PDT, {ear1="Telos Earring",ear2="Mache Earring +1"})
	sets.engaged.MaxAcc.MDT = set_combine(sets.engaged.Acc.MDT, {ammo="Seeth. Bomblet +1",hands="Pumm. Mufflers +2"})

	sets.engaged.MaxAcc.Mighty = set_combine(sets.engaged.MaxAcc, {})
	sets.engaged.MaxAcc.Charge = set_combine(sets.engaged.MaxAcc, {})
	sets.engaged.MaxAcc.Charge.Mighty = set_combine(sets.engaged.MaxAcc.Mighty, {})

	sets.engaged.MaxAcc.HybridDT.Mighty = set_combine(sets.engaged.MaxAcc.HybridDT, {})
	sets.engaged.MaxAcc.HybridDT.Charge = set_combine(sets.engaged.MaxAcc.HybridDT, {})
	sets.engaged.MaxAcc.HybridDT.Charge.Mighty = set_combine(sets.engaged.MaxAcc.HybridDT.Mighty, {})

	sets.engaged.MaxAcc.PDT.Mighty = set_combine(sets.engaged.MaxAcc.PDT, {})
	sets.engaged.MaxAcc.PDT.Charge = set_combine(sets.engaged.MaxAcc.PDT, {})
	sets.engaged.MaxAcc.PDT.Charge.Mighty = set_combine(sets.engaged.MaxAcc.PDT.Mighty, {})

	sets.engaged.MaxAcc.MDT.Mighty = set_combine(sets.engaged.MaxAcc.MDT, {})
	sets.engaged.MaxAcc.MDT.Charge = set_combine(sets.engaged.MaxAcc.MDT, {})
	sets.engaged.MaxAcc.MDT.Charge.Mighty = set_combine(sets.engaged.MaxAcc.MDT.Mighty, {})

	sets.engaged.Fodder = set_combine(sets.engaged, {})
	sets.engaged.Fodder.HybridDT = set_combine(sets.engaged.HybridDT, {})
	sets.engaged.Fodder.PDT = set_combine(sets.engaged.PDT, {})
	sets.engaged.Fodder.MDT = set_combine(sets.engaged.MDT, {})

	sets.engaged.Fencer = set_combine(sets.engaged, {})
	sets.engaged.Fencer.HybridDT = set_combine(sets.engaged.Fencer, {
		body="Hjarrandi Breast.",hands=gear.valorous.mitts.da,ring1="Moonbeam Ring"
	})
	sets.engaged.Fencer.PDT = set_combine(sets.engaged.Fencer.HybridDT, {
		ammo="Staunch Tathlum",head="Hjarrandi Helm",hands="Pumm. Mufflers +2",waist="Tempus Fugit"
	})
	sets.engaged.Fencer.MDT = set_combine(sets.engaged.Fencer.HybridDT, {
		head="Hjarrandi Helm",ear1="Odnowa Earring +1",ear2="Odnowa Earring",waist="Tempus Fugit"
	})

	sets.engaged.Fencer.Mighty = set_combine(sets.engaged.Fencer, {ammo="Yetshila",ring1="Begrudging Ring",feet="Boii Calligae +1"})
	sets.engaged.Fencer.Charge = set_combine(sets.engaged.Fencer, {
		ear1="Telos Earring",body="Hjarrandi Breast.",hands="Emi. Gauntlets +1",legs="Agoge Cuisses +2",feet="Flam. Gambieras +2"
	})
	sets.engaged.Fencer.Charge.Mighty = set_combine(sets.engaged.Fencer.Mighty, {ear1="Telos Earring",body="Boii Lorica +1",hands="Emi. Gauntlets +1",legs="Agoge Cuisses +2"})

	sets.engaged.Fencer.HybridDT.Mighty = set_combine(sets.engaged.Fencer.HybridDT, {ammo="Yetshila",feet="Boii Calligae +1"})
	sets.engaged.Fencer.HybridDT.Charge = set_combine(sets.engaged.Fencer.HbyridDT, {ear1="Telos Earring",hands="Emi. Gauntlets +1",legs="Agoge Cuisses +2"})
	sets.engaged.Fencer.HybridDT.Charge.Mighty = set_combine(sets.engaged.Fencer.HybridDT.Mighty, {ear1="Telos Earring",hands="Emi. Gauntlets +1",legs="Agoge Cuisses +2"})

	sets.engaged.Fencer.PDT.Mighty = set_combine(sets.engaged.Fencer.PDT, {feet="Boii Calligae +1"})
	sets.engaged.Fencer.PDT.Charge = set_combine(sets.engaged.Fencer.PDT, {})
	sets.engaged.Fencer.PDT.Charge.Mighty = set_combine(sets.engaged.Fencer.PDT.Mighty, {})

	sets.engaged.Fencer.MDT.Mighty = set_combine(sets.engaged.Fencer.MDT, {})
	sets.engaged.Fencer.MDT.Charge = set_combine(sets.engaged.Fencer.MDT, {})
	sets.engaged.Fencer.MDT.Charge.Mighty = set_combine(sets.engaged.Fencer.MDT.Mighty, {})

	sets.engaged.Fencer.Acc = set_combine(sets.engaged.Fencer, {})
	sets.engaged.Fencer.Acc.HybridDT = set_combine(sets.engaged.Fencer.HybridDT, {})
	sets.engaged.Fencer.Acc.PDT = set_combine(sets.engaged.Fencer.Acc.PDT, {})
	sets.engaged.Fencer.Acc.MDT = set_combine(sets.engaged.Fencer.Acc.MDT, {})

	sets.engaged.Fencer.MaxAcc = set_combine(sets.engaged.Fencer.Acc, {
		ammo="Seeth. Bomblet +1",
		head="Pummeler's Mask +2",ear1="Telos Earring",ear2="Mache Earring +1",
		body="Pumm. Lorica +3",hands="Pumm. Mufflers +2",ring1="Moonbeam Ring"
	})
	sets.engaged.Fencer.MaxAcc.HybridDT = set_combine(sets.engaged.Fencer.Acc.HybridDT, {
		ammo="Seeth. Bomblet +1",
		head="Pummeler's Mask +2",ear1="Telos Earring",ear2="Mache Earring +1",
		hands="Pumm. Mufflers +2"
	})
	sets.engaged.Fencer.MaxAcc.PDT = set_combine(sets.engaged.Fencer.Acc.PDT, {ear1="Telos Earring",ear2="Mache Earring +1"})
	sets.engaged.Fencer.MaxAcc.MDT = set_combine(sets.engaged.Fencer.Acc.MDT, {ammo="Seeth. Bomblet +1",hands="Pumm. Mufflers +2"})

	sets.engaged.Fencer.Fodder = set_combine(sets.engaged, {})
	sets.engaged.Fencer.Fodder.HybridDT = set_combine(sets.engaged.Fencer.Fodder, {})
	sets.engaged.Fencer.Fodder.PDT = set_combine(sets.engaged.Fencer.Fodder.PDT, {})
	sets.engaged.Fencer.Fodder.MDT = set_combine(sets.engaged.Fencer.Fodder.MDT, {})

	sets.engaged.DW = set_combine(sets.engaged, {ear2="Suppanomimi",hands="Emi. Gauntlets +1"})
	sets.engaged.DW.HybridDT = set_combine(sets.engaged.DW, {
		body="Hjarrandi Breast.",ring1="Moonbeam Ring"
	})
	sets.engaged.DW.PDT = set_combine(sets.engaged.DW.HybridDT, {
		ammo="Staunch Tathlum",head="Hjarrandi Helm",waist="Tempus Fugit",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"
	})
	sets.engaged.DW.MDT = set_combine(sets.engaged.DW.HybridDT, {
		head="Hjarrandi Helm",ear1="Odnowa Earring +1",waist="Tempus Fugit",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"
	})

	sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {})
	sets.engaged.DW.Acc.HybridDT = set_combine(sets.engaged.DW.HybridDT, {})
	sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.DW.Acc.PDT, {})
	sets.engaged.DW.Acc.MDT = set_combine(sets.engaged.DW.Acc.MDT, {})

	sets.engaged.DW.MaxAcc = set_combine(sets.engaged.DW.Acc, {
		ammo="Seeth. Bomblet +1",head="Pummeler's Mask +2",body="Pumm. Lorica +3",ring1="Moonbeam Ring"
	})
	sets.engaged.DW.MaxAcc.HybridDT = set_combine(sets.engaged.DW.Acc.HybridDT, {
		ammo="Seeth. Bomblet +1",head="Pummeler's Mask +2"
	})
	sets.engaged.DW.MaxAcc.PDT = set_combine(sets.engaged.DW.Acc.PDT, {})
	sets.engaged.DW.MaxAcc.MDT = set_combine(sets.engaged.DW.Acc.MDT, {ammo="Seeth. Bomblet +1",feet="Pumm. Calligae +3"})

	sets.engaged.DW.Fodder = set_combine(sets.engaged, {})
	sets.engaged.DW.Fodder.HybridDT = set_combine(sets.engaged.DW.Fodder, {})
	sets.engaged.DW.Fodder.PDT = set_combine(sets.engaged.DW.PDT, {})
	sets.engaged.DW.Fodder.MDT = set_combine(sets.engaged.DW.MDT, {})

	sets.engaged.Unarmed = {}
	
	--Extra Special Sets
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Retaliation = {}
	sets.buff.Restraint = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.MaxDW = {}
	
	-- Weapons sets
	sets.weapons.Chango = {main="Chango",sub="Utu Grip"}
	sets.weapons.Zulfiqar = {main="Zulfiqar",sub="Utu Grip"}
	sets.weapons.Naegling = {main="Naegling",sub="Blurred Shield +1"}
	sets.weapons.NaeglingDW = {main="Naegling",sub="Barbarity"}
	--sets.weapons.KajaAxe = {main="Kaja Axe",sub="Blurred Shield +1"}
	--sets.weapons.KajaAxeDW = {main="Kaja Axe",sub="Firangi"}
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