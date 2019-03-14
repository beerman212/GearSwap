-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Acc')
    state.CastingMode:options('Normal','Resistant')
    state.IdleMode:options('Normal','PDT','TPEat')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','DualWeapons','MeleeWeapons')
	
	gear.stp_jse_cape = {name = "Alaunus's Cape", augments = {'MND+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	gear.mnd_wsd_jse_cape = {name = "Alaunus's Cape", augments = {'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}}
	gear.fc_jse_cape = {name = "Alaunus's Cape", augments = {'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}

	gear.obi_cure_waist = "Luminary Sash"
	gear.obi_cure_back = gear.fc_jse_cape

	gear.obi_nuke_waist = "Eschan Stone"
	gear.obi_high_nuke_waist = "Eschan Stone"
	gear.obi_nuke_back = gear.fc_jse_cape

		-- Additional local binds
	send_command('bind ^` input /ma "Arise" <t>')
	send_command('bind !` input /ja "Penury" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` gs c toggle AutoCaress')
	send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
	send_command('bind @backspace input /ma "Aurora Storm" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	send_command('bind !backspace input /ja "Accession" <me>')
	send_command('bind != input /ja "Sublimation" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protectra V" <me>')
	send_command('bind @\\\\ input /ma "Shellra V" <me>')
	send_command('bind !\\\\ input /ma "Reraise IV" <me>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

	-- Weapons sets
	sets.weapons.MeleeWeapons = {main="Izcalli",sub="Ammurapi Shield"}
	sets.weapons.DualWeapons = {main="Izcalli",sub="Sindri"}
	
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {main=gear.grioavolr_nuke,sub="Clerisy Strap",ammo="Sapience Orb",
		head="Nahtirah Hat",neck="Cleric's Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
		back=gear.fc_jse_cape,waist="Channeler's Stone",legs="Aya. Cosciales +2",feet="Navon Crackows"}
		
    sets.precast.FC.DT = set_combine(sets.precast.FC, {})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pant. +1"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
	
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {})
	
	sets.precast.FC.Cure.DT = set_combine(sets.precast.FC.DT, {legs="Ebers Pant. +1"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.CureSolace = sets.precast.FC.Cure

	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})

    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault +2"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {head="Nahtirah Hat",body="Piety Briault +1",hands="Telchine Gloves"}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		head="Aya. Zucchetto +2",neck="Fotia Gorget",ear1="Telos Earring",ear2="Ishvara Earring",
		body="Piety Briault +2",hands="Aya. Manopolas +2",ring1="Epaminondas's Ring",ring2="Ayanmo Ring",
		back=gear.mnd_wsd_jse_cape,waist="Fotia Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}
		
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {ear1="Moonshade Earring"})
	sets.precast.WS['Black Halo'].Acc = set_combine(sets.precast.WS.Acc, {ear2="Moonshade Earring"})
	
	sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS, {ear2="Moonshade Earring",ring1="Hetairoi Ring",back=gear.stp_jse_cape})
	sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS.Acc, {ear2="Moonshade Earring",ring1="Ilabrat Ring",back=gear.stp_jse_cape})
	
	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {ear2="Cessance Earring",ring1="Ilabrat Ring"})
	sets.precast.WS['Realmrazer'].Acc = set_combine(sets.precast.WS.Acc, {ear2="Cessance Earring",ring1="Ilabrat Ring"})
	
	sets.precast.WS['Dagan'] = {ammo="Psilomene",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Etiolation Earring",ear2="Mendi. Earring",
		body="Ebers Bliaud +1",hands="Theophany Mitts +2",ear1="Ilabrat Ring",ear2="Mephitas's Ring",
		back="Twilight Cape",waist="Luminary Sash",legs="Piety Pantaln. +1",feet="Theo. Duckbills +3"}
		
	sets.precast.WS['Flash Nova'] = {ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Friomisi Earring",
		body="Vedic Coat",hands="Theophany Mitts +2",
		back=gear.fc_jse_cape,waist="Refoccilation Stone",legs=gear.chironic_hose_enfeeble,feet="Navon Crackows"}

    sets.precast.WS['Mystic Boon'] = set_combine(sets.precast.WS, {head="Inyanga Tiara +2",feet="Theo. Duckbills +3"})
	sets.precast.WS['Mystic Boon'].Acc = set_combine(sets.precast.WS.Acc, {})
	
	sets.MaxTP = {}
	sets.AccMaxTP = {}

    -- Midcast Sets

    sets.Kiting = {}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

	-- Conserve Mp set for spells that don't need anything else, for set_combine.
	
	sets.ConserveMP = {main=gear.grioavolr_nuke,sub="Clerisy Strap",ammo="Pemphredo Tathlum",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Mendi. Earring",ear2="Gwati Earring",
		body="Vedic Coat",hands="Fanatic Gloves",
		back="Solemnity Cape",waist="Luminary Sash",feet="Kaykaus Boots"}
		
	sets.midcast.Teleport = sets.ConserveMP
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {neck="Mizu. Kubikazari",ring1="Mujin Band",ring2="Locus Ring"}
	
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {})
		
    -- Cure sets

	sets.midcast['Full Cure'] = sets.midcast.FastRecast
	
	sets.midcast.Cure = {main="Queller Rod",sub="Sors Shield",ammo="Pemphredo Tathlum",
		head="Vanya Hood",neck="Cleric's Torque",ear1="Glorious Earring",ear2="Mendi. Earring",
		body="Theo. Briault +2",hands="Theophany Mitts +2",ring1="Defending Ring",ring2=gear.dark_ring_dt,
		back=gear.fc_jse_cape,waist="Luminary Sash",legs="Ebers Pant. +1",feet="Kaykaus Boots"}
		
	sets.midcast.CureSolace = set_combine(sets.midcast.Cure, {body="Ebers Bliaud +1"})

	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {main="Chatoyant Staff",sub="Enki Strap",ring2="Lebeche Ring"})

	sets.midcast.LightWeatherCureSolace = set_combine(sets.midcast.LightWeatherCure, {ammo="Psilomene",body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
		
	sets.midcast.LightDayCureSolace = set_combine(sets.midcast.CureSolace, {waist="Hachirin-no-Obi"})

	sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {waist="Hachirin-no-Obi"})

	sets.midcast.Curaga = sets.midcast.Cure
		
	sets.midcast.LightWeatherCuraga = sets.midcast.LightWeatherCure
		
	sets.midcast.LightDayCuraga = sets.midcast.LightDayCure

	sets.midcast.Cure.DT = set_combine(sets.midcast.Cure, 
		{sub="Genmei Shield",ammo="Staunch Tathlum",ring2="Lebeche Ring"})
		
	--Melee Curesets are used whenever your Weapons state is set to anything but None.
	sets.midcast.MeleeCure = {ammo="Psilomene",
		head="Vanya Hood",neck="Cleric's Torque",ear1="Glorious Earring",ear2="Mendi. Earring",
		body="Theo. Briault +2",hands="Theophany Mitts +2",ring1="Defending Ring",ring2=gear.dark_ring_dt,
		body=gear.fc_jse_cape,waist="Luminary Sash",legs="Ebers Pant. +1",feet="Kaykaus Boots"}
		
	sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1",ring2="Lebeche Ring"})
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1",ring2="Lebeche Ring",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1",ring2="Lebeche Ring",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})

	sets.midcast.CureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1"})
	sets.midcast.LightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.Curaga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCure.DT = set_combine(sets.midcast.Cure.DT, {})
	
	sets.midcast.MeleeCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1"})
	sets.midcast.MeleeLightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})

	sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {main="Yagrush",sub="Genmei Shield",
		neck="Malison Medallion",
		body="Ebers Bliaud +1",hands="Fanatic Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
		back=gear.fc_jse_cape,legs="Th. Pant. +2",feet="Vanya Clogs"})

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Yagrush",sub="Genmei Shield"})

    -- 83 total Enhancing Magic Skill; caps with Light Arts
	sets.midcast['Enhancing Magic'] = {main=gear.gada_enhancing,sub="Ammurapi Shield",
		head=gear.telchine_cap_enhancing_duration,neck="Incanter's Torque",ear1="Andoaa Earring",
		body=gear.telchine_chas_enhancing_duration,hands=gear.telchine_gloves_enhancing_duration,ring2="Stikini Ring",
		back="Mending Cape",waist="Olympus Sash",legs=gear.telchine_braconi_enhancing_duration,feet="Theo. Duckbills +3"}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",waist="Siegel Sash"})

	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {feet="Ebers Duckbills +1"})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {main="Bolelabunga",head="Inyanga Tiara +2",body="Piety Briault +2",hands="Ebers Mitts +1",legs="Th. Pant. +2",})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",feet="Piety Duckbills +1"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",feet="Piety Duckbills +1"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",legs="Piety Pantaln. +1"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",legs="Piety Pantaln. +1"})
	
	-- Need to find 8 more skill
	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {main="Benificus",
		head="Ebers Cap +1",
		body="Ebers Bliaud +1",hands="Ebers Mitts +1",
		legs="Piety Pantaln. +1",feet="Ebers Boots +1"})
		
	sets.midcast['Elemental Magic'] = {main=gear.gada_enfeeble,sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Inyanga Tiara +2",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Vedic Coat",hands="Fanatic Gloves",ring1="Kishar Ring",ring2="Inyanga Ring",
		back=gear.fc_jse_cape,waist="Luminary Sash",legs=gear.chironic_hose_enfeeble,feet="Theo. Duckbills +3"}

	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})
		
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

	sets.midcast['Divine Magic'] = {main=gear.gada_enfeeble, sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Inyanga Tiara +2",neck="Jokushu Chain",ear1="Regal Earring",ear2="Digni. Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Kishar Ring",ring2="Stikini Ring",
		back=gear.fc_jse_cape,waist="Luminary Sash",legs="Th. Pantaloons +2",feet="Theo. Duckbills +3"}
		
	sets.midcast.Holy = set_combine(sets.midcast['Divine Magic'], {main=grioavolr_nuke,sub="Enki Strap",
		neck="Sanctity Necklace",ear2="Friomisi Earring",
		body="Vedic Coat",waist="Eschan Stone",legs=gear.chironic_hose_enfeeble,feet="Navon Crackows"})
	
	sets.midcast.Banish = set_combine(sets.midcast.Holy, {neck="Jokushu Chain",hands="Fanatic Gloves"})
	
	sets.midcast.Flash = set_combine(sets.midcast['Divine Magic'], {})

	sets.midcast['Dark Magic'] = {main="Rubicundity", sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Inyanga Tiara +2",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Inyanga Jubbah +2",hands="Inyan. Dastanas +2",ring1="Evanescence Ring",ring2="Archon Ring",
		back=gear.fc_jse_cape,waist="Luminary Sash",legs="Th. Pantaloons +2",feet="Theo. Duckbills +3"}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {head="Pixie Hairpin +1",waist="Fucho-no-Obi"})

    sets.midcast.Drain.Resistant = set_combine(sets.midcast.Drain, {head="Inyanga Tiara +2"})

    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

	sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun, {})

	sets.midcast['Enfeebling Magic'] = {main=gear.gada_enfeebling,sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Inyanga Tiara +2",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Theophany Briault +2",hands="Inyan. Dastanas +2",ring1="Kishar Ring",ring2="Stikini Ring",
		back=gear.fc_jse_cape,waist="Luminary Sash",legs=gear.chironic_hose_enfeeble,feet="Theo. Duckbills +2"}

	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {waist="Channeler's Stone"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {waist="Channeler's Stone"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

    -- Sets to return to when not performing an action.

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {main="Queller Rod",sub="Genmei Shield",ammo="Homiliary",
		head="Inyanga Tiara +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
		body="Piety Briault +2",hands=gear.chironic_gloves_refresh,ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.stp_jse_cape,waist="Fucho-no-Obi",legs=gear.chironic_hose_refresh,feet="Inyan. Crackows +2"}

	sets.idle.PDT = set_combine(sets.idle, {main="Mafic Cudgel",body="Inyanga Jubbah +2"})
		
    sets.idle.TPEat = set_combine(sets.idle, {
		--neck="Chrys. Torque"
	})

	sets.idle.Weak = sets.idle.PDT

	-- Resting sets
	sets.resting = sets.idle
		
    -- Defense sets

	sets.defense.PDT = {ammo="Staunch Tathlum",
		head="Aya. Zucchetto +2",neck="Loricate Torque +1",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.stp_jse_cape,legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}

	sets.defense.MDT = {ammo="Staunch Tathlum",
		head="Inyanga Tiara +2",neck="Loricate Torque +1",
		body="Inyanga Jubbah +2",hands="Inyan. Dastanas +2",ring1="Defending Ring",ring2="Inyanga Ring",
		back=gear.fc_jse_cape,feet="Inyan. Crackows +2"}

    sets.defense.MEVA = set_combine(sets.defense.MDT, {ear1="Etiolation Earring"})
		
	-- Gear for specific elemental nukes.
	sets.element.Wind = {}
	sets.element.Ice = {}
	sets.element.Earth = {}

		-- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Basic set for if no TP weapon is defined.
    sets.engaged = {ammo="Staunch Tathlum",
        head="Aya. Zucchetto +2",neck="Lissome Necklace",ear1="Telos Earring",ear2="Cessance Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",Ring2="Ilabrat Ring",
        back=gear.stp_jse_cape,waist="Windbuffet Belt +1",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}

    sets.engaged.Acc = set_combine(sets.engaged, {})

	sets.engaged.DW = set_combine(sets.engaged, {ear2="Suppanomimi"})

    sets.engaged.DW.Acc = set_combine(sets.engaged.Acc, {ear2="Suppanomimi"})

		-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +1",back="Mending Cape"}

	sets.HPDown = {}

	sets.HPCure = {}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 4)
end