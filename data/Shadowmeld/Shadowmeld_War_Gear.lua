function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal','Acc','FullAcc','Fodder')
	state.WeaponskillMode:options('Match','Normal','Acc','FullAcc','Fodder')
	state.HybridMode:options('Normal','Hybrid','Hybrid_HPUp')
	state.PhysicalDefenseMode:options('PDT','PDTMaxHP')
	state.MagicalDefenseMode:options('MDT','MDTMaxHP')
	state.ResistDefenseMode:options('MEVA','MEVA_Charm','MEVA_Death')
	state.IdleMode:options('Normal', 'PDT')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Passive = M{['description'] = 'Passive Mode','None',}
	state.Weapons:options('Chango','Zulfiqar','Naegling','NaeglingDW')

	gear.cichol = {}
	gear.cichol.tp = {name = "Cichol's Mantle", augments = {'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	gear.cichol.reso = {name = "Cichol's Mantle", augments = {'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}

	gear.cichol.wsd = {}
	gear.cichol.wsd.str = {name = "Cichol's Mantle", augments = {'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}
	gear.cichol.wsd.vit = {name = "Cichol's Mantle", augments = {'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !r gs c cycle weapons;gs c update')
	
	select_default_macro_book()
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
		legs="Founder's Cuisses",feet="Souveran Schuhs +1"
	}
	sets.Knockback = {}
	sets.passive.Twilight = {--[[head="Twilight Helm",body="Twilight Mail"]]}
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Berserk'] = {body="Pumm. Lorica +3",back=gear.cichol.tp,feet="Agoge Calligae +1"}
	sets.precast.JA['Warcry'] = {head="Agoge Mask +2"}
	sets.precast.JA['Defender'] = {}
	sets.precast.JA['Aggressor'] = {head="Pummeler's Mask +2",body="Agoge Lorica +1"}
	sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers"}
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
		back=gear.cichol.tp,waist="Flume Belt",legs="Arjuna Breeches",feet="Odyssean Greaves"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC, sets.SIRD, {})
	
	sets.midcast.Utsusemi = set_combine(sets.FastRecast, {})
	
	sets.midcast.Cure = {}
	
	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {hands="Souv. Handsch. +1",waist="Gishdubar Sash",legs="Flamma Dirs +2",feet="Souveran Schuhs +1"}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Knobkierrie",
		head="Agoge Mask +2",neck="Fotia Gorget",ear1="Lugra Earring +1",ear2="Moonshade Earring",
		body="Pumm. Lorica +3",hands=gear.odyssean.gauntlets.vitwsd,ring1="Shukuyu Ring",ring2="Niqmaddu Ring",
		back=gear.cichol.wsd.str,waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"
	}
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {legs="Pumm. Cuisses +3"})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.	
	sets.precast.WS['Upheaval'] = {
		ammo="Knobkierrie",
		head="Agoge Mask +2",neck="Fotia Gorget",ear1="Lugra Earring +1",ear2="Moonshade Earring",
		body="Pumm. Lorica +3",hands=gear.odyssean.gauntlets.vitwsd,ring1="Shukuyu Ring",ring2="Niqmaddu Ring",
		back=gear.cichol.wsd.vit,waist="Caudata Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2",
	}
	
	sets.precast.WS['Upheaval'].Acc = set_combine(sets.precast.WS.Acc, {hands="Flam. Manopolas +2",ring1="Flamma Ring"})
	sets.precast.WS['Upheaval'].FullAcc = set_combine(sets.precast.WS.FullAcc, {head="Pummeler's Mask +2",hands="Flam. Manopolas +2",ring1="Flamma Ring"})
	sets.precast.WS['Upheaval'].Fodder = set_combine(sets.precast.WS.Fodder, {})
		
	sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Ukko's Fury"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Ukko's Fury"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS["Ukko's Fury"].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {
		neck="Caro Necklace",waist="Grunfeld Rope",legs="Argosy Breeches +1"})
	sets.precast.WS["King's Justice"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["King's Justice"].FullAcc = set_combine(sets.precast.WS.FullAcc, {hands="Flam. Manopolas +2",ring1="Flamma Ring"})
	sets.precast.WS["King's Justice"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	sets.precast.WS['Full Break'] = set_combine(sets.precast.WS, {
		head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear2="Digni. Earring",
		hands="Flam. Manopolas +2",ring1="Flamma Ring",
		legs="Flamma Dirs +2",feet="Flam. Gambieras +2"})
	sets.precast.WS['Full Break'].Acc = {}
	sets.precast.WS['Full Break'].FullAcc = {}
	sets.precast.WS['Full Break'].Fodder = {}
		
	sets.precast.WS["Fell Cleave"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Fell Cleave"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Fell Cleave"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS["Fell Cleave"].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS["Steel Cyclone"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Steel Cyclone"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Steel Cyclone"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS["Steel Cyclone"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	sets.precast.WS['Armor Break'] = sets.precast.WS['Full Break']
	sets.precast.WS['Shield Break'] = sets.precast.WS['Full Break']

	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",
		head="Flam. Zucchetto +2",
		body="Argosy Hauberk +1",hands="Argosy Mufflers +1",ring1="Flamma Ring",
		back=gear.cichol.reso,legs="Argosy Breeches +1",feet="Pumm. Calligae +3"})
	sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS.FullAcc, {body="Pumm. Lorica +3"})
	sets.precast.WS['Resolution'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS['Ground Strike'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Ground Strike'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Ground Strike'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Ground Strike'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS['Shockwave'] = set_combine(sets.precast.WS, {ammo="Pemphredo Tathlum",
		head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Gwati Earring",
		body="Found. Breastplate",hands="Flam. Manopolas +2",ring1="Flamma Ring",
		waist="Eschan Stone",legs="Flamma Dirs +2",feet="Flam. Gambieras +2"})
	sets.precast.WS['Shockwave'].Acc = {}
	sets.precast.WS['Shockwave'].FullAcc = {}
	sets.precast.WS['Shockwave'].Fodder = {}

	sets.precast.WS['Herculean Slash'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",
		head="Agoge Mask +2",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		ring1="Supershear Ring",
		back=gear.cichol.wsd.vit,waist="Escha Stone",legs="Agoge Cuisses +2",feet="Pumm. Calligae +3"})
	sets.precast.WS['Herculean Slash'].Acc = {}
	sets.precast.WS['Herculean Slash'].FullAcc = {}
	sets.precast.WS['Herculean Slash'].Fodder = {}
	
	sets.precast.WS['Freezebite'] = sets.precast.WS['Herculean Slash']

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		neck="Caro Necklace",waist="Grunfeld Rope"})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS.Resolution, {feet="Boii Calligae +1"})
	sets.precast.WS['Vorpal Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Vorpal Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {feet="Boii Calligae +1"})
	sets.precast.WS['Vorpal Blade'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		hands="Leyline Gloves",ring1="Shiva Ring +1",ring2="Archon Ring",
		waist="Eschan Stone",legs="Limbo Trousers"})
	sets.precast.WS['Sanguine Blade'].Acc = set_combine(sets.precast.WS.Acc, {ear2="Digni. Earring",legs="Agoge Cuisses +2"})
	sets.precast.WS['Sanguine Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {head="Agoge Mask +2",ear1="Dign. Earring",ear2="Gwati Earring",feet="Pumm. Calligae +3"})
	sets.precast.WS['Sanguine Blade'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ammo="Seeth. Bomblet +1",
		ear1="Telos Earring",ear2="Lugra Earring +1",hands=gear.valorous.mitts.da,ring1="Stikini Ring",
		back=gear.cichol.reso,feet="Pumm. Calligae +3"
	})
	
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {ring1="Chirich Ring"})
	sets.precast.WS['Requiescat'].FullAcc = set_combine(sets.precast.WS.FullAcc, {head="Pummeler's Mask +2",ring1="Chirich Ring"})
	sets.precast.WS['Requiescat'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Ruinator'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Ruinator'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Ruinator'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS['Rampage'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Rampage'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Rampage'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Rampage'].Fodder = set_combine(sets.precast.WS.Fodder, {})


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
		back=gear.cichol.tp,waist="Asklepian Belt",legs="Pumm. Cuisses +3",feet="Souveran Schuhs +1"}
		
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
	sets.engaged = {}
	sets.engaged.DW = {}

	sets.engaged.Chango = {
		--93% DA --> 99% if get War. Bead. +2, 100% if 5% on valorous mail and war. Bead. +2
		ammo="Ginsen",
		head="Flam. Zucchetto +2",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body=gear.valorous.mail.da,hands="Sulev. Gauntlets +2",ring1="Petrov Ring",ring2="Niqmaddu Ring",
		back=gear.cichol.tp,waist="Ioskeha Belt +1",legs="Pumm. Cuisses +3",feet="Pumm. Calligae +3"
	}

	sets.engaged.Chango.Charge = set_combine(sets.engaged.Chango, {
		neck="Ainia Collar",ear1="Telos Earring",ear2="Dedition Earring",
		body="Hjarrandi Breast.",hands=gear.valorous.mitts.da,ring1="Flamma Ring",ring2="Moonbeam Ring",
		legs=gear.odyssean.cuisses.stp
	})
	sets.engaged.Chango.Charge.Mighty = set_combine(sets.engaged.Chango.Charge, {})
	sets.engaged.Chango.Mighty = set_combine(sets.engaged.Chango, {legs=gear.valorous.hose.critdamage,feet=gear.valorous.greaves.strwsd})	

	sets.engaged.Chango.Acc = set_combine(sets.engaged.Chango, {})
	sets.engaged.Chango.Acc.Charge = set_combine(sets.engaged.Chango.Acc, {})
	sets.engaged.Chango.Acc.Charge.Mighty = set_combine(sets.engaged.Chango.Acc.Charge, {})
	sets.engaged.Chango.Acc.Mighty = set_combine(sets.engaged.Chango.Acc, {})

	sets.engaged.Chango.FullAcc = set_combine(sets.engaged.Chango.Acc, {})
	sets.engaged.Chango.FullAcc.Charge = set_combine(sets.engaged.Chango.FullAcc, {})
	sets.engaged.Chango.FullAcc.Charge.Mighty = set_combine(sets.engaged.Chango.FullAcc.Charge, {})
	sets.engaged.Chango.FullAcc.Mighty = set_combine(sets.engaged.Chango.FullAcc, {})

	sets.engaged.Chango.Fodder = set_combine(sets.engaged.Chango, {})
	sets.engaged.Chango.Fodder.Charge = set_combine(sets.engaged.Chango.Charge, {})
	sets.engaged.Chango.Fodder.Charge.Mighty = set_combine(sets.engaged.Chango.Charge.Mighty, {})
	sets.engaged.Chango.Fodder.Mighty = set_combine(sets.engaged.Chango.Mighty, {})

	sets.engaged.Chango.Hybrid = set_combine(sets.engaged.Chango, {
		body="Hjarrandi Breast.",hands=gear.valorous.mitts.da,ring1="Moonbeam Ring"
	})
	sets.engaged.Chango.Hybrid.Charge = set_combine(sets.engaged.Chango.Hybrid, {})
	sets.engaged.Chango.Hybrid.Charge.Mighty = set_combine(sets.engaged.Chango.Hybrid.Charge, {})
	sets.engaged.Chango.Hybrid.Mighty = set_combine(sets.engaged.Chango.Hybrid, {})

	sets.engaged.Chango.Hybrid.Acc = set_combine(sets.engaged.Chango.Hybrid, {})
	sets.engaged.Chango.Hybrid.Acc.Charge = set_combine(sets.engaged.Chango.Hybrid.Acc, {})
	sets.engaged.Chango.Hybrid.Acc.Charge.Mighty = set_combine(sets.engaged.Chango.Hybrid.Acc.Charge, {})
	sets.engaged.Chango.Hybrid.Acc.Mighty = set_combine(sets.engaged.Chango.Hybrid.Acc, {})

	sets.engaged.Chango.Hybrid.FullAcc = set_combine(sets.engaged.Chango.Hybrid.Acc, {})
	sets.engaged.Chango.Hybrid.FullAcc.Charge = set_combine(sets.engaged.Chango.Hybrid.FullAcc, {})
	sets.engaged.Chango.Hybrid.FullAcc.Charge.Mighty = set_combine(sets.engaged.Chango.Hybrid.FullAcc.Charge, {})
	sets.engaged.Chango.Hybrid.FullAcc.Mighty = set_combine(sets.engaged.Chango.Hybrid.FullAcc, {})

	sets.engaged.Chango.Hybrid.Fodder = set_combine(sets.engaged.Chango.Hybrid, {})
	sets.engaged.Chango.Hybrid.Fodder.Charge = set_combine(sets.engaged.Chango.Hybrid.Fodder, {})
	sets.engaged.Chango.Hybrid.Fodder.Charge.Mighty = set_combine(sets.engaged.Chango.Hybrid.Fodder.Charge, {})
	sets.engaged.Chango.Hybrid.Fodder.Mighty = set_combine(sets.engaged.Chango.Hybrid.Fodder, {})

	sets.engaged.Chango.Hybrid_HPUp = set_combine(sets.engaged.Chango, {
		ear1="Odnowa Earring +1",ear2="Odnowa Earring",
		body="Hjarrandi Breast.",hands="Souv. Handsch. +1",ring1="Moonbeam Ring"
	})
	sets.engaged.Chango.Hybrid_HPUp.Charge = set_combine(sets.engaged.Chango.Hybrid_HPUp, {})
	sets.engaged.Chango.Hybrid_HPUp.Charge.Mighty = set_combine(sets.engaged.Chango.Hybrid_HPUp.Charge, {})
	sets.engaged.Chango.Hybrid_HPUp.Mighty = set_combine(sets.engaged.Chango.Hybrid_HPUp, {})

	sets.engaged.Chango.Hybrid_HPUp.Acc = set_combine(sets.engaged.Chango.Hybrid_HPUp, {})
	sets.engaged.Chango.Hybrid_HPUp.Acc.Charge = set_combine(sets.engaged.Chango.Hybrid_HPUp.Acc, {})
	sets.engaged.Chango.Hybrid_HPUp.Acc.Charge.Mighty = set_combine(sets.engaged.Chango.Hybrid_HPUp.Acc.Charge, {})
	sets.engaged.Chango.Hybrid_HPUp.Acc.Mighty = set_combine(sets.engaged.Chango.Hybrid_HPUp.Acc, {})

	sets.engaged.Chango.Hybrid_HPUp.FullAcc = set_combine(sets.engaged.Chango.Hybrid_HPUp.Acc, {})
	sets.engaged.Chango.Hybrid_HPUp.FullAcc.Charge = set_combine(sets.engaged.Chango.Hybrid_HPUp.FullAcc, {})
	sets.engaged.Chango.Hybrid_HPUp.FullAcc.Charge.Mighty = set_combine(sets.engaged.Chango.Hybrid_HPUp.FullAcc.Charge, {})
	sets.engaged.Chango.Hybrid_HPUp.FullAcc.Mighty = set_combine(sets.engaged.Chango.Hybrid_HPUp.FullAcc, {})

	sets.engaged.Chango.Hybrid_HPUp.Fodder = set_combine(sets.engaged.Chango.Hybrid_HPUp, {})
	sets.engaged.Chango.Hybrid_HPUp.Fodder.Charge = set_combine(sets.engaged.Chango.Hybrid_HPUp.Fodder, {})
	sets.engaged.Chango.Hybrid_HPUp.Fodder.Charge.Mighty = set_combine(sets.engaged.Chango.Hybrid_HPUp.Fodder.Charge, {})
	sets.engaged.Chango.Hybrid_HPUp.Fodder.Mighty = set_combine(sets.engaged.Chango.Hybrid_HPUp.Fodder, {})
	

	sets.engaged.Zulfiqar = sets.engaged.Chango
	sets.engaged.Naegling = sets.engaged.Chango
	sets.engaged.NaeglingDW = sets.engaged.Chango
	
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