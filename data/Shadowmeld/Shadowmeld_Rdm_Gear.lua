function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal','Acc','Fodder')
	state.HybridMode:options('Normal', 'PDT', 'MDT')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
	state.IdleMode:options('Normal', 'PDT', 'MDT')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.AutoBuffMode:options('Off','AutoSavage','AutoCygne','AutoHeal','AutoNuke')

	state.Weapons:options('None','Melee','MeleeBow','MeleeDW','MeleeDWBow')
	state.MainHandWeapons = M{['description'] = 'Main Hand Weapons', 'Naegling','Almace','Sequence','Kaja Knife','Maxentius'}
	state.Shields = M{['description'] = 'Shields', 'Sacro Bulwark', 'Ammurapi Shield', 'Genmei Shield'}
	state.OffhandWeapons = M{['description'] = 'Offhand Weapons', 'Ternion Dagger +1', 'Kaja Knife', 'Naegling'}

	state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
	
	gear.sucellos = {}
	gear.sucellos.stp = {name = "Sucellos's Cape", augments = {'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
	gear.sucellos.wsd = {name = "Sucellos's Cape", augments = {'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	gear.sucellos.cdc = {name = "Sucellos's Cape", augments = {'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}}
	gear.sucellos.enfeeble = {name = "Sucellos's Cape", augments = {'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}
	gear.sucellos.mab = {name = "Sucellos's Cape", augments = {'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}

	gear.colada = {}
	gear.colada.enhancing = {name = "Colada", augments = {'Enh. Mag. eff. dur. +4','MND+2','Mag. Acc.+15','"Mag.Atk.Bns."+18',}}
	gear.colada.refresh1 = {name="Colada",augments={}}
	gear.colada.refresh2 = {name="Colada",augments={}}
	
	gear.obi_cure_back = gear.sucellos.enfeeble
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_back = gear.sucellos.mab
	gear.obi_low_nuke_waist = "Refoccilation Stone"

	gear.obi_high_nuke_back = gear.sucellos.mab
	gear.obi_high_nuke_waist = "Refoccilation Stone"

		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` input /ja "Accession" <me>')
	send_command('bind ^backspace input /ja "Saboteur" <me>')
	send_command('bind !backspace input /ja "Spontaneity" <t>')
	send_command('bind @backspace input /ja "Composure" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind != input /ja "Penury" <me>')
	send_command('bind @= input /ja "Parsimony" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise" <me>')
	send_command('bind @f10 gs c cycle RecoverMode')
	
	select_default_macro_book()
	--lockstyle:schedule(5)
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = {body="Viti. Tabard +3"}	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {ammo="Impatiens",
		head="Atro. Chapeau +2",neck="Loricate Torque +1",ear1="Malignance Earring",ear2="Etiolation Earring",
		body="Viti. Tabard +3",hands="Aya. Manopolas +2",ring1="Defending Ring",ring2="Lebeche Ring",
		back="Perimede Cape",waist="Witful Belt",legs="Aya. Cosciales +2",feet="Carmine Greaves +1"}
		
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {
		head=empty,neck="Orunmila's Torque",ear2="Enchntr. Earring +1",
		body="Twilight Cloak",hands="Leyline Gloves",ring1="Kishar Ring",
		back=gear.sucellos.enfeeble})
       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Aurgelmir Orb",
		head="Viti. Chapeau +2",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Sherida Earring",
		body="Viti. Tabard +3",hands="Jhakri Cuffs +2",ring1="Rufescent Ring",ring2="Shukuyu Ring",
		back=gear.sucellos.wsd,waist="Fotia Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = {
		ammo="Regal Gem",
		head="Viti. Chapeau +2",neck="Fotia Gorget",ear1="Regal Earring",ear2="Moonshade Earring",
		body="Viti. Tabard +3",hands="Atrophy Gloves +2",ring1="Hetairoi Ring",ring2="Shukuyu Ring",
		back=gear.sucellos.enfeeble,waist="Fotia Belt",legs="Jhakri Slops +2",feet="Carmine Greaves +1"
	}
		
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {ammo="Aurgelmir Orb",head="Carmine Mask +1",ring1="Chirich Ring",ring2="Ilabrat Ring",back=gear.sucellos.stp})
	sets.precast.WS['Requiescat'].Fodder = set_combine(sets.precast.WS['Requiescat'], {})
		
	sets.precast.WS['Chant du Cygne'] = {
		ammo="Yetshila",
		head="Jhakri Coronal +2",neck="Fotia Gorget",ear1="Mache Earring +1",ear2="Sherida Earring",
		body="Viti. Tabard +3",hands=gear.taeon.gloves.cdc,ring1="Begrudging Ring",ring2="Ilabrat Ring",
		back=gear.sucellos.cdc,waist="Fotia Belt",legs=gear.taeon.tights.cdc,feet="Jhakri Pigaches +2"
	}
		
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {ammo="Aurgelmir Orb",head="Carmine Mask +1",hands="Jhakri Cuffs +2",legs="Carmine Cuisses +1"})
	sets.precast.WS['Chant du Cygne'].Fodder = set_combine(sets.precast.WS['Chant du Cygne'], {})
		
	sets.precast.WS['Savage Blade'] = {
		ammo="Regal Gem",
		head="Viti. Chapeau +2",neck="Caro Necklace",ear1="Regal Earring",ear2="Moonshade Earring",
		body="Viti. Tabard +3",hands="Jhakri Cuffs +2",ring1="Rufescent Ring",ring2="Shukuyu Ring",
		back=gear.sucellos.wsd,waist="Grunfeld Rope",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"
	}
	
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {ear1="Regal Earring",ear2="Moonshade Earring",hands="Atrophy Gloves +2",ring2="Ilabrat Ring",legs="Carmine Cuisses +1"})
	sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS['Savage Blade'], {})
		
	sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Malignance Earring",
		body="Amalric Doublet +1",hands="Jhakri Cuffs +2",ring1="Freke Ring",ring2="Archon Ring",
		back=gear.sucellos.mab,waist="Refoccilation Stone",legs="Amalric Slops +1",feet="Amalric Nails +1"}

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS['Chant du Cygne'], {})
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Chant du Cygne'].Acc, {})
	
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS.Acc, {})
	
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2", neck="Sanctity Necklace",ear1="Regal Earring", ear2="Malignance Earring",
		body="Jhakri Robe +2", hands="Jhakri Cuffs +2",ring1="Freke Ring",ring2="Shiva Ring +1",
		back=gear.sucellos.mab,waist="Refoccilation Stone",legs=gear.merlinic.shalwar.magical,feet="Jhakri Pigaches +2"})
	
	sets.precast.WS['Energy Drain'] = set_combine(sets.precast.WS['Sanguine Blade'], {ammo="Regal Gem",})

	sets.precast.WS['Empyreal Arrow'] = {
		ammo="",
		head="Malignance Chapeau",neck="Marked Gorget",ear1="Telos Earring",ear2="Enervating Earring",
		body="Malignance Tabard",hands="",ring1="",ring2="",
		back=gear.sucellos.stp,waist="Yemaya Belt",legs="Malignance Tights",feet=""
	}
	
	sets.MaxTP = {}
	sets.AccMaxTP = {}
	
	sets.MaxTP["Savage Blade"] = {ear1="Regal Earring",ear2="Ishvara Earring"}
	sets.AccMaxTP["Savage Blade"] = {ear1="Regal Earring",ear2="Telos Earring"}
	
	-- Midcast Sets

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {}
	
	-- Gear for Magic Burst mode.
	sets.MagicBurst = {head="Ea Hat",neck="Mizu. Kubikazari",body="Ea Houppelande",hands="Amalric Gages +1",ring1="Mujin Band",legs="Ea Slops",feet="Jhakri Pigaches +2"}
	
	sets.RecoverBurst = set_combine(sets.MagicBurst, {})
	
	-- Gear for specific elemental nukes.
	sets.element.Wind = {}
	sets.element.Ice = {}
	sets.element.Earth = {}
	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}

	sets.midcast.FastRecast = set_combine(sets.precast.FC, {hands="Leyline Gloves"})

	sets.midcast.Cure = {ammo="Regal Gem",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Enchntr. Earring +1",ear2="Mendi. Earring",
		body="Viti. Tabard +3",hands="Kaykaus Cuffs",ring2="Lebeche Earring",
		back=gear.sucellos.enfeeble,waist="Luminary Sash",legs="Atrophy Tights +2",feet="Vanya Clogs"}
	
	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {main="Chatoyant Staff",sub="Enki Strap",
		hands="Leyline Gloves",back="Twilight Cape",waist="Hachirin-no-Obi",})
	
	--Cureset for if it's not light weather but is light day.
	sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {back="Twilight Cape",waist="Hachirin-no-Obi"})
		
	sets.midcast.Cursna =  set_combine(sets.midcast.FastRecast, {neck="Malison Medallion",body="Viti. Tabard +3",ring1="Ephedra Ring",ring2="Sirona's Ring",legs="Atrophy Tights +2",feet="Vanya Clogs"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
		
	sets.midcast.Curaga = sets.midcast.Cure
	sets.Self_Healing = {body="Vrikodara Jupon",hands="Buremte Gloves",waist="Gishdubar Sash"}
	sets.Cure_Received = {hands="Buremte Gloves",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	sets.Self_Phalanx = {head=gear.taeon.chapeau.phalanx,body=gear.taeon.tabard.phalanx,hands=gear.taeon.gloves.phalanx,legs=gear.taeon.tights.phalanx,feet=gear.taeon.boots.phalanx}

	sets.midcast['Enhancing Magic'] = {main=gear.colada.enhancing,sub="Ammurapi Shield",
		head=gear.telchine.cap.enhancing,neck="Duelist's Torque",ear1="Andoaa Earring",
		body="Viti. Tabard +3",hands="Atrophy Gloves +2",ring2="Stikini Ring",
		back="Ghostfyre Cape",waist="Olympus Sash",legs=gear.telchine.braconi.enhancing,feet="Leth. Houseaux +1"}

	--Atrophy Gloves are better than Lethargy for me despite the set bonus for duration on others.		
	sets.buff.ComposureOther = {head="Leth. Chappel +1",
		body="Lethargy Sayon +1",
		legs="Leth. Fuseau +1",feet="Leth. Houseaux +1"}
		
	--Red Mage enhancing sets are handled in a different way from most, layered on due to the way Composure works
	--Don't set combine a full set with these spells, they should layer on Enhancing Set > Composure (If Applicable) > Spell
	sets.midcast.Refresh = {head="Amalric Coif +1",body="Atrophy Tabard +2",legs="Leth. Fuseau +1"}
	sets.midcast.Aquaveil = {head="Amalric Coif +1"}
	sets.midcast.BarElement = {}
	sets.midcast.Stoneskin = {neck="Nodens Gorget",waist="Siegel Sash"}
	sets.midcast.Protect = {ring2="Sheltered Ring"}
	sets.midcast.Shell = {ring2="Sheltered Ring"}
	sets.midcast.Enspell = {head="Befouled Crown",neck="Incanter's Torque",hands="Viti. Gloves +1",legs="Atrophy Tights +2"}
	sets.midcast.Temper = {head="Befouled Crown",neck="Incanter's Torque",hands="Viti. Gloves +1",legs="Atrophy Tights +2"}
	sets.midcast['Temper II'] = {head="Befouled Crown",neck="Incanter's Torque",hands="Viti. Gloves +1",legs="Atrophy Tights +2"}
	sets.midcast.Phalanx = {head=gear.taeon.chapeau.phalanx,body=gear.taeon.tabard.phalanx,hands=gear.taeon.gloves.phalanx,legs=gear.taeon.tights.phalanx,feet=gear.taeon.boots.phalanx}

	sets.midcast['Enfeebling Magic'] = {
		main="Naegling",sub="Ammurapi Shield",range="Kaja Bow",ammo=empty,
		head="Atro. Chapeau +2",neck="Duelist's Torque",ear1="Regal Earring",ear2="Malignance Earring",
		body="Atrophy Tabard +2",hands="Kaykaus Cuffs",ring1="Kishar Ring",ring2="Stikini Ring",
		back=gear.sucellos.enfeeble,waist="Luminary Sash",legs=gear.chironic.hose.enfeeble,feet="Vitiation Boots +3"
	}

	sets.midcast['Enfeebling Magic'].PreserveTP = {range=empty,ammo="Regal Gem"}
	sets.midcast['Enfeebling Magic'].Potency = {range=empty,ammo="Regal Gem",neck="Duelist's Torque",body="Lethargy Sayon +1",back=gear.sucellos.enfeeble,feet="Vitiation Boots +2"}
	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})

	sets.midcast['Enfeebling Magic'].MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], sets.midcast['Enfeebling Magic'].Potency, {head="Viti. Chapeau +2"})
	sets.midcast['Enfeebling Magic'].MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].MndEnfeebles, sets.midcast['Enfeebling Magic'].Potency, {})

	sets.midcast['Enfeebling Magic'].IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], sets.midcast['Enfeebling Magic'].Potency, {hands="Jhakri Cuffs +2",back=gear.sucellos.mab})
	sets.midcast['Enfeebling Magic'].IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].IntEnfeebles, {back=gear.sucellos.mab})

	sets.midcast['Distract III'] = set_combine(sets.midcast['Enfeebling Magic'].MndEnfeebles, {
		main=gear.grioavolr.enfeeble,sub="Enki Strap",waist="Rumination Sash"
	})
	sets.midcast['Distract III'].Resistant = set_combine(sets.midcast['Enfeebling Magic'].MndEnfeebles.Resistant, {})

	sets.midcast['Frazzle II'] = sets.midcast['Enfeebling Magic'].Resistant
	sets.midcast['Frazzle III'] = sets.midcast['Distract III']

	sets.midcast.Silence = sets.midcast['Enfeebling Magic']
	sets.midcast.Bind = sets.midcast['Enfeebling Magic']
	sets.midcast.Break = sets.midcast['Enfeebling Magic']
	sets.midcast.Sleep = sets.midcast['Enfeebling Magic']
	sets.midcast['Sleep II'] = sets.midcast['Enfeebling Magic']
	sets.midcast.Sleepga = sets.midcast['Enfeebling Magic']

	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia III'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter, sets.midcast['Enfeebling Magic'].Potency, {})
	sets.midcast['Bio III'] = sets.midcast['Dia III']
	
	sets.midcast['Poison'] = set_combine(sets.midcast['Enfeebling Magic'], sets.midcast['Enfeebling Magic'].Potency, {})
	sets.midcast['Poison'].Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, sets.midcast['Enfeebling Magic'].Potency, {})
	sets.midcast['Poison II'] = set_combine(sets.midcast['Poison'], {head="Viti. Chapeau +2"})
	sets.midcast['Poison II'].Resistant = set_combine(sets.midcast['Poison'].Resistant, {head="Viti. Chapeau +2"})

	sets.midcast.Gravity = set_combine(sets.midcast['Enfeebling Magic'], sets.midcast['Enfeebling Magic'].Potency, {})
	sets.midcast.Gravity.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, sets.midcast['Enfeebling Magic'].Potency, {})
	sets.midcast['Gravity II'] = set_combine(sets.midcast.Gravity, {})
	sets.midcast['Gravity II'].Resistant = set_combine(sets.midcast.Gravity.Resistant, {})

	sets.midcast.Inundation = set_combine(sets.midcast.FastRecast, {ring1="Kishar Ring"})
	sets.midcast.Dispel = set_combine(sets.midcast['Enfeebling Magic'], {ring1="Archon Ring"})
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast['Elemental Magic'] = {main=gear.grioavolr.nuke,sub="Enki Strap",ammo="Pemphredo Tathlum",
		head=gear.merlinic.hood.magical,neck="Sanctity Necklace",ear1="Regal Earring",ear2="Malignance Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Freke Ring",ring2="Shiva Ring +1",
		back=gear.sucellos.mab,waist=gear.ElementalObi,legs="Amalric Slops +1",feet="Amalric Nails +1"}
		
	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		main="Naegling",sub="Ammurapi Shield",body=gear.merlinic.jubbah.magical,legs=gear.merlinic.shalwar.magical,feet=gear.merlinic.crackows.magical
	})
	
	sets.midcast['Elemental Magic'].Fodder = set_combine(sets.midcast['Elemental Magic'], {})

	sets.midcast['Elemental Magic'].Proc = set_combine(sets.midcast.FastRecast, {})
		
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
		
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'].Resistant, {
		head=empty,body="Twilight Cloak"})

	sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Ammurapi Shield",range="Kaja Bow",ammo=empty,
		head="Atro. Chapeau +2",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Atrophy Tabard +2",hands="Amalric Gages +1",ring1="Evanescence Ring",ring2="Stikini Ring",
		back=gear.sucellos.mab,waist="Luminary Sash",legs=gear.chironic.hose.enfeeble,feet=gear.merlinic.crackows.drain
	}

	sets.midcast['Dark Magic'].PreserveTP = {range=empty,ammo="Regal Gem"}

	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {waist="Fucho-no-obi",feet=gear.merlinic.crackows.drain})

	sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Stun = set_combine(sets.midcast.FastRecast, {main="Rubicundity",sub="Ammurapi Shield",})
		
	sets.midcast.Stun.Resistant = sets.midcast['Dark Magic']

	-- Ranged Attack sets
	sets.midcast.RA = {
		ammo="",
		head="Malignance Chapeau",neck="Marked Gorget",ear1="Telos Earring",ear2="Enervating Earring",
		body="Malignance Tabard",hands="",ring1="",ring2="",
		back=gear.sucellos.stp,waist="Yemaya Belt",legs="Malignance Tights",feet=""
	}

	-- Sets for special buff conditions on spells.
		
	sets.buff.Saboteur = {hands="Leth. Gantherots +1"}
	
	sets.HPDown = {head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring2="Mephitas's Ring",
		legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Sets to return to when not performing an action.	

	-- Idle sets
	sets.idle = {
		main="Bolelabunga",sub="Sacro Bulwark",ammo="Homiliary",
		head="Viti. Chapeau +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
		body="Jhakri Robe +2",hands=gear.chironic.gloves.refresh,ring1="Defending Ring",ring2="Dark Ring",
		back="Moonbeam Cape",waist="Flume Belt +1",legs=gear.chironic.hose.refresh,feet=gear.merlinic.crackows.refresh
	}
	
	sets.idle.PDT = set_combine(sets.idle, {
		ammo="Staunch Tathlum",ring2="Gelatinous Ring +1",legs="Malignance Tights"
	})
	
	sets.idle.MDT = set_combine(sets.idle, {
		neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
		ring2="Purity Ring",legs="Malignance Tights"
	})
		
	sets.idle.Weak = set_combine(sets.idle.PDT, {})
	
	-- Resting sets
	sets.resting = sets.idle
		
	-- Defense sets
	sets.defense.PDT = {
		ammo="Staunch Tathlum",
		head="Malignance Chapeau",neck="Loricate Torque +1",
		body="Malignance Tabard",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		waist="Flume Belt +1",legs="Malignance Tights"
	}

	sets.defense.NukeLock = sets.midcast['Elemental Magic']
		
	sets.defense.MDT = {
		ammo="Staunch Tathlum",
		head="Malignance Chapeau",neck="Warder's Charm",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
		body="Malignance Tabard",hands="",ring1="Defending Ring",ring2="Purity Ring",
		back="Moonbeam Cape",waist="",legs="Malignance Tights",feet=""
	}
		
	sets.defense.MEVA = set_combine(sets.defense.MDT, {head="Ea Hat",body="Ea Houppelande"})
		
	sets.idle.TPEat = set_combine(sets.idle, {
		--neck="Chrys. Torque"
	})

	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.Sublimation = {}
	
	-- Weapons sets
	sets.weapons.SequenceAmmurapi = {main="Sequence",sub="Ammurapi Shield"}
	sets.weapons.SequenceGenmei = {main="Sequence",sub="Genmei Shield"}
	sets.weapons.SequenceSacro = {main="Sequence",sub="Sacro Bulwark"}
	sets.weapons.NaeglingAmmurapi = {main="Naegling",sub="Ammurapi Shield"}
	sets.weapons.NaeglingGenmei = {main="Naegling",sub="Genmei Shield"}
	sets.weapons.NaeglingSacro = {main="Naegling",sub="Sacro Bulwark"}
	sets.weapons.DualSequence = {main="Sequence",sub="Kaja Knife"}
	sets.weapons.DualNaegling = {main="Naegling",sub="Kaja Knife"}
	sets.weapons.DualTauret = {main="Kaja Knife",sub="Ternion Dagger +1"}

	sets.weapons.Naegling = {main="Naegling",sub=gear.meleeShield}
	sets.weapons.NaeglingBow = {main="Naegling",sub=gear.meleeShield,range="Kaja Bow"}
	sets.weapons.Almace = {main="Almace",sub=gear.meleeShield}
	sets.weapons.AlmaceBow = {main="Almace",sub=gear.meleeShield,range="Kaja Bow"}
	sets.weapons.Sequence = {main="Sequence",sub=gear.meleeShield}
	sets.weapons.SequenceBow = {main="Sequence",sub=gear.meleeShield,range="Kaja Bow"}
	sets.weapons.Tauret = {main="Tauret",sub=gear.meleeShield}
	sets.weapons.TauretBow = {main="Tauret",sub=gear.meleeShield,range="Kaja Bow"}
	sets.weapons.Maxentius = {main="Maxentius",sub=gear.meleeShield}
	sets.weapons.MaxentiusBow = {main="Maxentius",sub=gear.meleeShield,range="Kaja Bow"}

	sets.weapons.Melee = {main=state.MainHandWeapons.value,sub=state.Shields.value}
	sets.weapons.MeleeBow = {main=state.MainHandWeapons.value,sub=state.Shields.value,range="Kaja Bow"}
	sets.weapons.MeleeDW = {main=state.MainHandWeapons.value,sub=state.OffhandWeapons.value}
	sets.weapons.MeleeDWBow = {main=state.MainHandWeapons.value,sub=state.OffhandWeapons.value,range="Kaja Bow"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {
		ammo="Aurgelmir Orb",
		head="Malignance Chapeau",neck="Anu Torque",ear1="Telos Earring",ear2="Sherida Earring",
		body="Malignance Tabard",hands="Taeon Gloves",ring1="Hetairoi Ring",ring2="Ilabrat Ring",
		back=gear.sucellos.stp,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Carmine Greaves +1"
	}
	sets.engaged.PDT = set_combine(sets.engaged, {
		neck="Loricate Torque +1",ring1="Defending Ring"
	})
	sets.engaged.MDT = set_combine(sets.engaged, {
		neck="Warder's Charm +1",ring1="Purity Ring"
	})

	sets.engaged.Enspell = set_combine(sets.engaged, {})
	sets.engaged.Enspell2 = set_combine(sets.engaged, {})

	sets.engaged.PDT.Enspell = set_combine(sets.engaged.PDT, {})
	sets.engaged.PDT.Enspell2 = set_combine(sets.engaged.PDT, {})

	sets.engaged.MDT.Enspell = set_combine(sets.engaged.MDT, {})
	sets.engaged.MDT.Enspell2 = set_combine(sets.engaged.MDT, {})
		
	sets.engaged.Acc = set_combine(sets.engaged, {
		head="Carmine Mask +1",neck="Lissome Torque",
		hands="Aya. Manopolas +2",ring1="Chirich Ring",
		waist="Grunfeld Rope",legs="Carmine Cuisses +1"
	})
	sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {
		hands="Aya. Manopolas +2",waist="Grunfeld Rope"
	})
	sets.engaged.Acc.MDT = set_combine(sets.engaged.MDT, {
		hands="Aya.Manopolas +2",waist="Grunfeld Rope"
	})
	
	sets.engaged.DW = {
		ammo="Aurgelmir Orb",
		head="Malignance Chapeau", neck="Anu Torque", ear1="Suppanomimi",ear2="Sherida Earring",
		body="Malignance Tabard",hands="Taeon Gloves",ring1="Hetairoi Ring",ring2="Ilabrat Ring",
		back=gear.sucellos.stp,waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"
	}
	sets.engaged.DW.PDT = set_combine(sets.engaged.DW, {
		neck="Loricate Torque +1",ring1="Defending Ring", ring2="Gelatinous Ring +1"
	})
	sets.engaged.DW.MDT = set_combine(sets.engaged.DW, {
		neck="Warder's Charm +1",ring1="Defending Ring",ring2="Purity Ring"
	})

	sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
		neck="Lissome Necklace",hands="Aya. Manopolas +2",ring1="Chirich Ring",waist="Grunfeld Rope"
	})
	sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.DW.PDT, {
		hands="Aya. Manopolas +2",waist="Grunfeld Rope"
	})
	sets.engaged.DW.Acc.MDT = set_combine(sets.engaged.DW.MDT, {
		hands="Aya. Manopolas +2",waist="Grunfeld Rope"
	})
end

buff_spell_lists.AutoHeal = {
	{Name='Haste II',		Buff='Haste',		SpellID=511,	When='Always'},
	{Name='Refresh III',	Buff='Refresh',		SpellID=894,	When='Always'},
	{Name='Phalanx',		Buff='Phalanx',		SpellID=106,	When='Always'},
	{Name='Aquaveil',		Buff='Aquaveil',	SpellID=55,		When='Always'},
	{Name='Aurorastorm',	Buff='Aurorastorm',	SpellID=119,	When='Idle'},
	{Name='Gain-MND',		Buff='MND Boost',	SpellID=490,	When='Always'},
	{Name='Reraise',		Buff='Reraise',		SpellID=135,	When='Always'},
}

buff_spell_lists.AutoSavage = {
	{Name='Haste II',		Buff='Haste',		SpellID=511,	When='Always'},
	{Name='Refresh III',	Buff='Refresh',		SpellID=894,	When='Always'},
	{Name='Phalanx',		Buff='Phalanx',		SpellID=106,	When='Always'},
	{Name='Aquaveil',		Buff='Aquaveil',	SpellID=55,		When='Always'},
	{Name="Temper II",		Buff='Multi Strikes',SpellID=895,	When='Always'},
	{Name='Gain-STR',		Buff='STR Boost',	SpellID=486,	When="Always"},
}

buff_spell_lists.AutoCygne = {
	{Name='Haste II',		Buff='Haste',		SpellID=511,	When='Always'},
	{Name='Refresh III',	Buff='Refresh',		SpellID=894,	When='Always'},
	{Name='Phalanx',		Buff='Phalanx',		SpellID=106,	When='Always'},
	{Name='Aquaveil',		Buff='Aquaveil',	SpellID=55,		When='Always'},
	{Name="Temper II",		Buff='Multi Strikes',SpellID=895,	When='Always'},
	{Name='Gain-DEX',		Buff='DEX Boost',	SpellID=487,	When="Always"},
}

buff_spell_lists.AutoNuke = {
	{Name='Haste II',		Buff='Haste',		SpellID=511,	When='Always'},
	{Name='Refresh III',	Buff='Refresh',		SpellID=894,	When='Always'},
	{Name='Phalanx',		Buff='Phalanx',		SpellID=106,	When='Always'},
	{Name='Aquaveil',		Buff='Aquaveil',	SpellID=55,		When='Always'},
	{Name='Gain-INT',		Buff='INT Boost',	SpellID=490,	When='Always'},
	{Name='Klimaform',		Buff='Klimaform',	SpellID=287,	When='Always'}
}

buff_spell_lists.Default = {
	{Name='Refresh III',	Buff='Refresh',		SpellID=894,	Reapply=false},
	{Name='Haste II',		Buff='Haste',		SpellID=511,	Reapply=false},
	{Name='Phalanx',		Buff='Phalanx',		SpellID=106,	Reapply=false},
	{Name='Stoneskin',		Buff='Stoneskin',	SpellID=54,		Reapply=false},
	{Name='Shell V',		Buff='Shell',		SpellID=52,		Reapply=false},
	{Name='Protect V',		Buff='Protect',		SpellID=47,		Reapply=false},
	{Name='Klimaform',		Buff='Klimaform',	SpellID=287,	Reapply=false}
}

buff_spell_lists.MageHeal = {
	{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
	{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
	{Name='Aquaveil',		Buff='Aquaveil',		SpellID=55,		Reapply=false},
	{Name='Phalanx',		Buff='Phalanx',			SpellID=106,	Reapply=false},
	{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		Reapply=false},
	{Name='Gain-MND',		Buff='MND Boost',		SpellID=490,	Reapply=false},
	{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
	{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
	{Name='Klimaform',		Buff='Klimaform',		SpellID=287,	Reapply=false},
	{Name='Aurorastorm', 	Buff='Aurorastorm', 	SpellID=119, 	Reapply=false},
}

buff_spell_lists.MageDebuff = {
	{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
	{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
	{Name='Aquaveil',		Buff='Aquaveil',		SpellID=55,		Reapply=false},
	{Name='Phalanx',		Buff='Phalanx',			SpellID=106,	Reapply=false},
	{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		Reapply=false},
	{Name='Blink',			Buff='Blink',			SpellID=53,		Reapply=false},
	{Name='Gain-MND',		Buff='MND Boost',		SpellID=490,	Reapply=false},
	{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
	{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
	{Name='Klimaform',		Buff='Klimaform',		SpellID=287,	Reapply=false},
}

buff_spell_lists.MageNuke = {
	{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
	{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
	{Name='Aquaveil',		Buff='Aquaveil',		SpellID=55,		Reapply=false},
	{Name='Phalanx',		Buff='Phalanx',			SpellID=106,	Reapply=false},
	{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		Reapply=false},
	{Name='Blink',			Buff='Blink',			SpellID=53,		Reapply=false},
	{Name='Gain-INT',		Buff='INT Boost',		SpellID=490,	Reapply=false},
	{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
	{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
	{Name='Klimaform',		Buff='Klimaform',		SpellID=287,	Reapply=false},
}

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	set_macro_page(1, 5)
end

function lockstyle()
	windower.chat.input("/lockstyleset 001")
end

function user_job_post_midcast(spell, spellMap, eventArgs)
	if S{'Enfeebling Magic','Dark Magic','Elemental Magic'}:contains(spell.skill) and sets.midcast[spell.skill].PreserveTP then
		if state.Weapons and state.Weapons.value ~= 'None' and not S{'Kaja Bow','Ullr'}:contains(sets.weapons[state.Weapons.value].range) then
			equip(sets.midcast[spell.skill].PreserveTP)
		end
	end
end

function user_aftercast(spell, spellMap, eventArgs)
	if not spell.interrupted then
		if spell.skill == "Enfeebling Magic" and state.UseCustomTimers.value then
			local custom_durations = {
				["Slow"] = 180,
				["Slow II"] = 180,
				["Sleep II"] = 90,
				["Sleepga"] = 60,
				["Sleepga II"] = 90,
				["Frazzle"] = 300,
				["Frazzle II"] = 300,
				["Frazzle III"] = 300,
				["Distract"] = 300,
				["Distract II"] = 300,
				["Distract III"] = 300,
				["Addle II"] = 180,
				["Dia III"] = 180,
				--["Gravity II"] = 75,
			}

			local spell_info = res.spells[spell.recast_id]
			local casting_set = get_midcast_set(spell, spellMap)

			if buffactive["Saboteur"] then
				casting_set = set_combine(casting_set, sets.buff.Saboteur)
			end

			--casting_set = standardize_set(casting_set)
			
			local duration = custom_durations[spell.name] or spell_info.duration or 0
			local saboteur_modifier = get_saboteur_modifier(casting_set)
			local composure_modifier = get_composure_modifier(casting_set)
			local duration_modifier = get_enfeebling_modifier(casting_set)
			local aug_duration_modifier = get_duelist_torque_modifier(casting_set)
			local duration_bonus = get_enfeebling_duration_from_merits(casting_set) + get_enfeebling_duration_from_jp()

			windower.add_to_chat("Spell: " .. spell.name)
			windower.add_to_chat("Base Duration: " .. duration)
			windower.add_to_chat("Saboteur Bonus: " .. saboteur_modifier)
			windower.add_to_chat("Base Duration Increase: " .. duration_bonus)
			windower.add_to_chat("Duration Bonus From Gear: " .. duration_modifier)
			windower.add_to_chat("Duration Bonus From Augmented Gear: " .. aug_duration_modifier)
			windower.add_to_chat("Duration Bonus From Composure: " .. composure_modifier)

			if duration > 0 then
				local calculated_duration = math.floor(math.floor(math.floor((math.floor((duration * saboteur_modifier / 100)) + duration_bonus) * duration_modifier / 100) * composure_modifier / 100) * aug_duration_modifier / 100)
				local debuff_icon = "spells/00220.png"

				windower.add_to_chat("Calculated Duration: " .. calculated_duration)
				send_command('@timers c "'..spell.english..' ['..spell.target.name..']" ' .. calculated_duration .. ' down '.. debuff_icon)
			end

			eventArgs.handled = true
		end
	end
end

function get_saboteur_modifier(casting_set)
	local saboteur_modifier = 100

	if buffactive["Saboteur"] then
		if casting_set.hands == "Leth. Gantherots +1" then
			saboteur_modifier = 212
		elseif casting_set.hands == "Leth. Gantherots" then
			saboteur_modifier = 211
		elseif casting_set.hands == "Estq. Ganthrt. +2" then
			saboteur_modifier = 210
		elseif casting_set.hands == "Estq. Canthrt. +1" then
			saboteur_modifier = 205
		else
			saboteur_modifier = 200
		end
	end

	return saboteur_modifier
end

function get_enfeebling_modifier(casting_set)
	local duration_modifier = 100

	if S{casting_set.ring1, casting_set.ring2, casting_set.left_ring, casting_set.right_ring}:contains("Kishar Ring") then duration_modifier = duration_modifier + 10 end
	if casting_set.hands == "Regal Cuffs" then duration_modifier = duration_modifier + 20 end

	return duration_modifier
end

function get_enfeebling_duration_from_merits(casting_set)
	local duration_bonus = 0
	local enfeebling_duration_merits = windower.ffxi.get_player().merits.enfeebling_magic_duration or 0

	if enfeebling_duration_merits > 0 then
		duration_bonus = enfeebling_duration_merits * 6

		if S{"Viti. Chapeau +3","Viti. Chapeau +2","Viti. Chapeau +1","Vitiation Chapeau"}:contains(casting_set.head) then
			duration_bonus = duration_bonus + (enfeebling_duration_merits * 3)
		end
	end

	return duration_bonus
end

function get_enfeebling_duration_from_jp()
	local enfeebling_duration_jps = windower.ffxi.get_player().job_points[string.lower(player.main_job)].enfeebling_magic_duration or 0
	local stymie_duration_jps = windower.ffxi.get_player().job_points[string.lower(player.main_job)].stymie_effect or 0
	local duration_bonus = enfeebling_duration_jps

	if buffactive["Stymie"] then
		duration_bonus = duration_bonus + stymie_duration_jps
	end

	return duration_bonus
end

function get_composure_modifier(casting_set)
	local duration_modifier = 100
	local empy_count = 0

	if buffactive["Composure"] then

		if type(casting_set.head) == 'table' then
			if casting_set.head.name:startswith("Leth") then empy_count = empy_count + 1 end
		else
			if casting_set.head:startswith("Leth") then empy_count = empy_count + 1 end
		end

		if type(casting_set.body) == 'table' then
			if casting_set.body.name:startswith("Leth") then empy_count = empy_count + 1 end
		else
			if casting_set.body:startswith("Leth") then empy_count = empy_count + 1 end
		end

		if type(casting_set.hands) == 'table' then
			if casting_set.hands.name:startswith("Leth") then empy_count = empy_count + 1 end
		else
			if casting_set.hands:startswith("Leth") then empy_count = empy_count + 1 end
		end

		if type(casting_set.legs) == 'table' then
			if casting_set.legs.name:startswith("Leth") then empy_count = empy_count + 1 end
		else
			if casting_set.legs:startswith("Leth") then empy_count = empy_count + 1 end
		end

		if type(casting_set.feet) == 'table' then
			if casting_set.feet.name:startswith("Leth") then empy_count = empy_count + 1 end
		else
			if casting_set.feet:startswith("Leth") then empy_count = empy_count + 1 end
		end

		if empy_count == 2 then duration_modifier = 110
		elseif empy_count == 3 then duration_modifier = 120
		elseif empy_count == 4 then duration_modifier = 135
		elseif empy_count == 5 then duration_modifier = 150
		end

	end

	return duration_modifier
end

function get_duelist_torque_modifier(casting_set)
	if type(casting_set.neck) == "table" then
		return casting_set.neck.name == "Duelist's Torque" and 114 or 100
	else
		return casting_set.neck == "Duelist's Torque" and 114 or 0
	end
end

function user_job_self_command(commandArgs,eventArgs)
	local commandToHandle = commandArgs[1]

	if commandToHandle == 'cyclemain' then
		eventArgs.handled = true
		handle_cycle({'MainHandWeapons'})
		--state.MainHandWeapons:cycle()

		if state.MainHandWeapons.value == state.OffhandWeapons.value then
			handle_cycle({'OffhandWeapons'})
			--state.OffhandWeapons:cycle()
		end

		reset_all_weapon_sets(state.MainHandWeapons.value, state.Shields.value, state.OffhandWeapons.value)
		handle_weapons(state.Weapons.value)
	elseif commandToHandle == 'cycleshield' then
		eventArgs.handled = true
		handle_cycle({'Shields'})
		--state.Shields:cycle()

		reset_all_weapon_sets(state.MainHandWeapons.value, state.Shields.value, state.OffhandWeapons.value)
		handle_weapons(state.Weapons.value)
	elseif commandToHandle == 'cycleoffhand' then
		eventArgs.handled = true
		handle_cycle({'OffhandWeapons'})
		--state.OffhandWeapons:cycle()

		if state.MainHandWeapons.value == state.OffhandWeapons.value then
			handle_cycle({'OffhandWeapons'})
			--state.OffhandWeapons:cycle()
		end

		reset_all_weapon_sets(state.MainHandWeapons.value, state.Shields.value, state.OffhandWeapons.value)
		handle_weapons(state.Weapons.value)
	end
end

function reset_all_weapon_sets(mainhand, shield, offhand)
	sets.weapons.Melee = set_combine(sets.weapons.Melee, {main=mainhand,sub=shield})
	sets.weapons.MeleeBow = set_combine(sets.weapons.Melee, {main=mainhand,sub=shield})
	sets.weapons.MeleeDW = set_combine(sets.weapons.Melee, {main=mainhand,sub=offhand})
	sets.weapons.MeleeDWBow = set_combine(sets.weapons.Melee, {main=mainhand,sub=offhand})
end