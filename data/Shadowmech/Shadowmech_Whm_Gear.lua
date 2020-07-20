-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','MaxAcc')
    state.CastingMode:options('Normal','Resistant')
    state.IdleMode:options('Normal','DT','MEva')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','Club','Staff')
	state.AutoCaress = M(false, 'Auto Caress Mode')

	gear.obi_cure_waist = ""
	gear.obi_cure_back = ""

	gear.obi_nuke_waist = ""
	gear.obi_high_nuke_waist = ""
	gear.obi_nuke_back = ""

	gear.alaunus = {}
	gear.alaunus.fc = {name="Alaunus's Cape",augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+5','"Fast Cast"+10'}}

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
	sets.weapons = {}
	sets.weapons.Club = {main="Queller Rod",sub="Ammurapi Shield"}
	sets.weapons.Staff = {main="Malignance Pole",sub="Kupayopl"}
	sets.weapons.ProcClub = {main="Relic Maul",sub="Ammurapi Shield"}

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
		head="Nahtirah Hat",neck="Cleric's Torque",ear1="Etiolation Earring",ear2="Moonshade Earring",
		body="Inyanga Jubbah +1",hands="Gende. Gages +1",ring1="Kishar Ring",
		back=gear.alaunus.fc,waist="Witful Belt",legs="Artsieq Hose",feet="Regal Pumps +1"
	}
		
    sets.precast.FC.DT = {}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
	
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pant. +1"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
	
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
		feet="Hygieia Clogs"
	})
	
	sets.precast.FC.Cure.DT = {
		feet="Hygieia Clogs"
	}

    sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.CureSolace = sets.precast.FC.Cure

	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {})

	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Ammurapi Shield"})

    -- Precast sets to enhance JAs
	sets.precast.JA.Benediction = {body="Piety Briault"}
	sets.precast.JA.Devotion = {head="Piety Cap"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
		
    sets.precast.WS.Dagan = {}
		
	sets.MaxTP = {}
	sets.MaxTP.Dagan = {}

    --sets.precast.WS['Flash Nova'] = {}

    --sets.precast.WS['Mystic Boon'] = {}

    -- Midcast Sets

    sets.Kiting = {}
	sets.latent_refresh = {waist="Fucho-no-Obi"}
	sets.Sublimation = {waist="Embla Sash"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}

	-- Conserve Mp set for spells that don't need anything else, for set_combine.
	
	sets.ConserveMP = {}
		
	sets.midcast.Teleport = sets.ConserveMP
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {}
	
    sets.midcast.FastRecast = {}
		
    -- Cure sets

	sets.midcast['Full Cure'] = sets.midcast.FastRecast
	
	sets.midcast.Cure = {
		main="Queller Rod",sub="Sors Shield",
		head="Vanya Hood",neck="Cleric's Torque",ear1="Nourish. Earring +1",ear2="Lifestorm Earring",
		body="Theo. Briault +2",hands="Theophany Mitts +2",ring1="Janniston Ring",ring2="Kuchekula Ring",
		back=gear.alaunus.fc,waist="Luminary Sash",legs="Ebers Pant. +1",feet="Piety Duckbills +1"
	}
		
	sets.midcast.CureSolace = set_combine(sets.midcast.Cure, {body="Ebers Bliaud +1",back=gear.alaunus.fc})

	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {main="Iridal Staff",sub="Achaq Grip"})

	sets.midcast.LightWeatherCureSolace = set_combine(sets.midcast.LightWeatherCure, {body="Ebers Bliaud +1",back=gear.alaunus.fc})
		
	sets.midcast.LightDayCureSolace = sets.midcast.CureSolace

	sets.midcast.LightDayCure = sets.midcast.Cure

	sets.midcast.Curaga = sets.midcast.Cure
		
	sets.midcast.LightWeatherCuraga = sets.midcast.LightWeatherCure
		
	sets.midcast.LightDayCuraga = sets.midcast.LightDayCure

	sets.midcast.Cure.DT = sets.midcast.Cure
		
	--Melee Curesets are used whenever your Weapons state is set to anything but None.
	sets.midcast.MeleeCure = {
		head="Vanya Hood",neck="Cleric's Torque",ear1="Nourish. Earring +1",ear2="Lifestorm Earring",
		body="Ebers Bliaud +1",hands="Kaykaus Cuffs",ring1="Janniston Ring",ring2="Kuchekula Ring",
		waist=gear.alaunus.fc,waist="Luminary Sash",legs="Ebers Pant. +1",feet="Piety Duckbills +1"
	}
		
	sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, {})

	sets.midcast.CureSolace.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightDayCure.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.Curaga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeCure.DT = set_combine(sets.midcast.Cure.DT, {})
	
	sets.midcast.MeleeCureSolace.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightDayCure.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {})

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {head="Ebers Cap +1"})

	sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
		neck="Malison Medallion",
		body="Ebers Bliaud +1",hands="Kaykaus Cuffs",ring1="Ephedra Ring",
		legs="Th. Pantaloons +2",feet="Vanya Clogs"
	})

	sets.midcast['Enhancing Magic'] = {
		main=gear.gada.enhancing,sub="Ammurapi Shield",
		head=gear.telchine.cap.enhancing,
		body=gear.telchine.chasuble.enhancing,hands=gear.telchine.gloves.enhancing,
		waist="Embla Sash",feet="Theo. Duckbills +2"
	}
	sets.midcast['Enhancing Magic'].skill = set_combine(sets.midcast['Enhancing Magic'], {
		head="Befouled Crown",ear1="Mimir Earring",ear2="Andoaa Earring",
		hands="Inyan. Dastanas +2",ring2="Stikini Ring",
		back="Mending Cape",legs="Piety Pantaloons"
	})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {feet="Ebers Duckbills +1"})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {head="Chironic Hat"})

	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
		main="Bolelabunga",
		head="Inyanga Tiara +1",
		body="Piety Briault",hands="Ebers Mitts +1",
		legs="Th. Pantaloons +2"
	})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], sets.Sheltered, {})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], sets.Sheltered, {})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], sets.Sheltered, {})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], sets.Sheltered, {})
	
	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'].skill, {
		main="Beneficus",
		head="Ebers Cap +1",
		body="Ebers Bliaud +1",hands="Ebers Mitts +1",
		legs="Piety Pantaloons",feet="Ebers Duckbills +1"
	})
	sets.midcast.BarStatus = set_combine(sets.midcast['Enhancing Magic'].skill, {})
	sets.midcast.BoostStat = set_combine(sets.midcast['Enhancing Magic'].skill, {})

	sets.midcast.Impact = {}
		
	sets.midcast['Elemental Magic'] = {}

	sets.midcast['Elemental Magic'].Resistant = {}

	sets.midcast['Divine Magic'] = {}
		
	sets.midcast.Holy = {}

	sets.midcast['Dark Magic'] = {}

    sets.midcast.Drain = {}

    sets.midcast.Drain.Resistant = {}

    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Stun = {}

	sets.midcast.Stun.Resistant = {}

	sets.midcast['Enfeebling Magic'] = {
		main="Daybreak",sub="Ammurapi Shield",
		head="Theophany Cap +2",neck="Erra Pendant",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Theo. Briault +2",hands="Inyan. Dastanas +2",ring1="Kishar Ring",ring2="Stikini Ring",
		back=gear.alaunus.fc,waist="Luminary Sash",legs=gear.chironic.hose.enfeeble,feet="Theo. Duckbills +2"
	}

	sets.midcast['Enfeebling Magic'].Resistant = {}
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

	sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'], {main="Daybreak",sub="Ammurapi Shield"})

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

    -- Sets to return to when not performing an action.

    -- Resting sets
	sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
		main="Daybreak",sub="Ammurapi Shield",ammo="Homiliary",
		head=gear.chironic.hat.refresh,neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Moonshade Earring",
		body="Theo. Briault +2",hands="Inyan. Dastanas +2",ring1="Ayanmo Ring",ring2="Inyanga Ring",
		legs=gear.chironic.hose.refresh,feet="Inyan. Crackows +1"
	}

	sets.idle.DT = set_combine(sets.idle, {main="Malignance Pole",sub="Kupayopl",ammo="Staunch Tathlum"})
	
	sets.idle.MEva = {}

	sets.idle.Weak = {}

    -- Defense sets

	sets.defense.PDT = {}

	sets.defense.MDT = {}

    sets.defense.MEVA = {}
		
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
	sets.engaged = {
		head="Aya. Zucchetto",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Ayanmo Corazza",hands="Aya. Manopolas +1",ring1="Petrov Ring",ring2="K'ayres Ring",
		waist="Grunfeld Rope",legs="Ayanmo Cosciales",feet="Aya. Gambieras +2"
	}
	sets.engaged.MaxAcc = set_combine(sets.engaged, {})

	sets.engaged.DW = set_combine(sets.engaged, {})
	sets.engaged.DW.MaxAcc = set_combine(sets.engaged.DW, {})

		-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +1",back="Mending Cape"}

	sets.HPDown = {}

	sets.HPCure = {}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})	
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 1)
end