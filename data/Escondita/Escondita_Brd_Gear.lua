function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal','Acc')
	state.CastingMode:options('Normal','Resistant','AoE')
	state.IdleMode:options('Normal','PDT')
	state.Weapons:options('None','Refresh','DualWeapons')

	-- Adjust this if using the Terpander (new +song instrument)
	info.ExtraSongInstrument = 'Daurdabla'
	-- How many extra songs we can keep from Daurdabla/Terpander
	info.ExtraSongs = 2

	gear.intarabus = {}
	gear.intarabus.tp = {name = "Intarabus's Cape", augments = {'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
	gear.intarabus.wsd = {name = "Intarabus's Cape", augments = {'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}
	gear.intarabus.macc = {name = "Intarabus's Cape", augments = {'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}
	
	gear.linos = {}
	gear.linos.multiattack = {name = "Linos", augments = {'Accuracy+20','"Dbl.Atk."+2','DEX+8',}}
	
	-- Set this to false if you don't want to use custom timers.
	state.UseCustomTimers = M(false, 'Use Custom Timers')

	-- Additional local binds
	send_command('bind ^` gs c cycle ExtraSongsMode')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !q gs c weapons NukeWeapons;gs c update')
	send_command('bind ^q gs c weapons Swords;gs c update')

	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets	
	sets.weapons.Refresh = {main="Sangoma",sub="Genbu's Shield"}
	sets.weapons.DualWeapons = {main="Sangoma",sub="Taming Sari"}
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {
		main="Kali",sub="Genbu's Shield",
		head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",hands="Leyline Gloves",ring1="Kishar Ring",
		back=gear.intarabus.macc,waist="Channeler's Stone",legs="Aya. Cosciales +2"}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {feet="Vanya Clogs"})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
	
	sets.precast.FC.BardSong = set_combine(sets.precast.FC, {range="Gjallarhorn"})

	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong,{range="Gjallarhorn"})
	sets.precast.FC['Magic Finale'] = set_combine(sets.precast.FC.BardSong,{range="Gjallarhorn"})
	sets.precast.FC['Horde Lullaby'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC['Horde Lullaby'].Resistant = set_combine(sets.precast.FC.BardSong,{range="Gjallarhorn"})
	sets.precast.FC['Horde Lullaby'].AoE = set_combine(sets.precast.FC.BardSong,{range="Terpander"})
	sets.precast.FC['Horde Lullaby II'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC['Horde Lullaby II'].Resistant = set_combine(sets.precast.FC.BardSong,{range="Gjallarhorn"})
	sets.precast.FC['Horde Lullaby II'].AoE = set_combine(sets.precast.FC.BardSong,{range="Terpander"})
		
	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla
		
	
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = {feet="Bihu Slippers"}
	sets.precast.JA.Troubadour = {body="Bihu Justaucorps"}
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {range=gear.linos.multiattack,
		head="Aya. Zucchetto +2",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Ilabrat Ring",ring2="Apate Ring",
		back=gear.intarabus.wsd,waist="Fotia Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +1"}
		
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Telos Earring",ear2="Ishvara Earring",}
	sets.AccMaxTP = {ear1="Telos Earring",ear2="Cessance Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

	-- Gear to enhance certain classes of songs.  No instruments added here since Gjallarhorn is being used.
	sets.midcast.Ballad = {legs="Fili Rhingrave"}
	sets.midcast.Lullaby = {hands="Brioso Cuffs +2"}
	sets.midcast['Horde Lullaby'] = {range="Marsyas"}
	sets.midcast['Horde Lullaby'].Resistant = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby'].AoE = {range="Daurdabla"}
	sets.midcast['Horde Lullaby II'] = {range="Marsyas"}
	sets.midcast['Horde Lullaby II'].Resistant = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby II'].AoE = {range="Daurdabla"}
	sets.midcast.Madrigal = {head="Fili Calot",back=gear.intarabus.macc}
	sets.midcast.Paeon = {range="Daurdabla",neck="Voltsurge Torque"}
	sets.midcast.March = {hands="Fili Manchettes"}
	sets.midcast['Honor March'] = set_combine(sets.midcast.March,{range="Marsyas"})
	sets.midcast.Minuet = {body="Fili Hongreline +1"}
	sets.midcast.Minne = {}
	sets.midcast.Carol = {}
	sets.midcast["Sentinel's Scherzo"] = {} --feet="Fili Cothurnes +1" Brioso Slippers still provides more Duration
	sets.midcast['Magic Finale'] = {}
	sets.midcast.Mazurka = {range="Marsyas"}
	

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {main="Kali",sub="Genmei Shield",range="Gjallarhorn",ammo=empty,
		head="Fili Calot",neck="Mnbw. Whistle +1",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Fili Hongreline +1",hands="Inyan. Dastanas +2",ring1="Kishar Ring",ring2="Stikini Ring",
		back=gear.intarabus.macc,legs="Inyanga Shalwar +2",feet="Brioso Slippers +3"}
		
	sets.midcast.SongEffect.DW = {}

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {main="Kali",sub="Genbu's Shield",range="Marsyas",ammo=empty,
		head="Aya. Zucchetto +2",neck="Mnbw. Whistle +1",ear1="Enchntr. Earring +1",ear2="Regal Earring",
		body="Fili Hongreline +1",hands="Inyan. Dastanas +2",ring1="Kishar Ring",ring2="Stikini Ring",
		back=gear.intarabus.macc,waist="Luminary Sash",legs="Inyanga Shalwar +2",feet="Brioso Slippers +3"}

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.SongDebuff.Resistant = {main="Kali",sub="Genbu's Shield",range="Gjallarhorn",ammo=empty,
		head="Brioso Roundlet +2",neck="Mnbw. Whistle +1",ear1="Enchntr. Earring +1",ear2="Regal Earring",
		body="Brioso Justau. +2",hands="Inyan. Dastanas +2",ring1="Kishar Ring",ring2="Stikini Ring",
		back=gear.intarabus.macc,waist="Luminary Sash",legs="Inyanga Shalwar +2",feet="Aya. Gambieras +1"}

	-- Song-specific recast reduction
	sets.midcast.SongRecast = set_combine(sets.midcast.FastRecast, {range="Daurdabla",ammo=empty})
		
	sets.midcast.SongDebuff.DW = {}

	-- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

	-- Other general spells and classes.
	sets.midcast.Cure = {main="Serenity",sub="Enki Strap",ammo="Pemphredo Tathlum",
		head="Vanya Hood",neck="Incanter's Torque",ear2="Mendi. Earring",
		ring2="Sirona's Ring",
		back="Tempered Cape +1",feet="Vanya Clogs"}
		
	sets.midcast.Curaga = sets.midcast.Cure
		
	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
		
	sets.midcast['Enhancing Magic'] = {main="Serenity",sub="Clerisy Grip",
		head=gear.telchine.cap.enhancing,neck="Incanter's Torque",
		body=gear.telchine.chas.enhancing,hands=gear.telchine.gloves.enhancing,ring2="Stikini Ring",
		back="Perimede Cape",waist="Olympus Sash",legs=gear.telchine.braconi.enhancing,feet=gear.telchine.pigaches.enhancing}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
		
	sets.midcast['Elemental Magic'] = {}
		
	sets.midcast['Elemental Magic'].Resistant = {}
		
	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Fodder
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
		ring1="Haoma's Ring",ring2="Haoma's Ring",waist="Witful Belt",feet="Vanya Clogs"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	
	
	-- Idle sets
	sets.idle = {main="Sangoma",sub="Genbu's Shield",range=gear.linos.multiattack,ammo=empty,
		head="Inyanga Tiara +2",neck="Twilight Torque",
		body="Inyanga Jubbah +2",hands="Inyan. Dastanas +2",ring1="Defending Ring",ring2="Dark Ring",
		back=gear.intarabus.tp,waist="Flume Belt +1",legs="Inyanga Shalwar +2",feet=gear.chironic.slippers.refresh}

	sets.idle.PDT = set_combine(sets.idle, {})
	
	-- Defense sets

	sets.defense.PDT = set_combine(sets.idle, {})

	sets.defense.MDT = set_combine(sets.idle, {})

	sets.Kiting = {feet="Fili Cothurnes +1"}

	-- Resting sets
	sets.resting = sets.idle
		
	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	sets.engaged = {main="Sangoma",sub="Genbu's Shield",range=gear.linos.multiattack,ammo=empty,
		head="Aya. Zucchetto +2",neck="Clotharius Torque",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",ring2="Ilabrat Ring",
		back=gear.intarabus.tp,waist="Windbuffet Belt +1",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}
	sets.engaged.Acc = set_combine(sets.engaged, {})
		
	sets.engaged.DW = {main="Sangoma",sub="Skinflayer",range=gear.linos.multiattack,ammo=empty,
		head="Aya. Zucchetto +2",neck="Clotharius Torque",ear1="Suppanomimi",ear2="Eabani Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",ring2="Ilabrat Ring",
		back=gear.intarabus.tp,waist="Windbuffet Belt +1",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}
	sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(10, 10)
end