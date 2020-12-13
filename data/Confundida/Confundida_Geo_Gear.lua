function user_setup()

	-- Options: Override default values
    state.OffenseMode:options('Normal')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal', 'DT', 'TPEat')
	state.PhysicalDefenseMode:options('DT', 'NukeLock', 'GeoLock', 'PetDT')
	state.MagicalDefenseMode:options('MDT', 'NukeLock')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None')

	gear.nantosuelta = {}
	gear.nantosuelta.petregen = {name="Nantosuelta's Cape",augments={'HP+60','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10'}}
	
	gear.obi_cure_back = ""
	gear.obi_cure_waist = ""

	gear.obi_low_nuke_back = ""
	gear.obi_low_nuke_waist = "Refoccilation Stone"

	gear.obi_high_nuke_back = ""
	gear.obi_high_nuke_waist = "Refoccilation Stone"
	
	autoindi = "Haste"
	autogeo = "Frailty"
	
	-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` input /ja "Full Circle" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind ^backspace input /ja "Entrust" <me>')
	send_command('bind !backspace input /ja "Life Cycle" <me>')
	send_command('bind @backspace input /ma "Sleep II" <t>')
	send_command('bind ^delete input /ma "Aspir III" <t>')
	send_command('bind @delete input /ma "Sleep" <t>')
	
	indi_duration = 290
	
	select_default_macro_book()
end

function init_gear_sets()

	-- Weapons sets
	sets.weapons.Idris = {main="Idris",sub="Sors Shield"}
	sets.weapons.IdrisDW = {main="Idris",sub="Tokko Rod"}
	
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = {body="Bagua Tunic +1"}
	sets.precast.JA['Life Cycle'] = {body="Geo. Tunic +1",back=gear.nantosuelta.petregen}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +1"}
	sets.precast.JA['Mending Halation'] = {legs="Bagua Pants +1"}
	sets.precast.JA['Full Circle'] = {head="Azimuth Hood"}
	
	-- Indi Duration in slots that would normally have skill here to make entrust more efficient.
	sets.buff.Entrust = {}
	
	-- Relic hat for Blaze of Glory HP increase.
	sets.buff['Blaze of Glory'] = {}
	
	-- Fast cast sets for spells

	sets.precast.FC = {
		main="Grioavolr",sub="Clerisy Strap",range="Dunna",ammo=empty,
		head=gear.merlinic.hood.mdmg,ear1="Moonshade Earring",ear2="Loquac. Earring",
		ring1="Kishar Ring",
		back="Lifestream Cape",waist="Embla Sash",legs="Geo. Pants +1"
	}

	sets.precast.FC.Geomancy = set_combine(sets.precast.FC, {range="Dunna",ammo=empty})
	
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
		
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {head="Umuthi Hat"})

	sets.precast.FC.Impact = {}
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

    sets.midcast.FastRecast = {}

	sets.midcast.Geomancy = {
		main="Idris",range="Dunna",
		head="Azimuth Hood",neck="Bagua Charm",ear2="Gwati Earring",
		body="Bagua Tunic +1",hands="Geo. Mitaines +1",
		legs="Azimuth Tights",feet="Azimuth Gaiters"
	}


	--Extra Indi duration as long as you can keep your 900 skill cap.
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {back="Lifestream Cape",legs="Bagua Pants +1",feet="Azimuth Gaiters"})
		
    sets.midcast.Cure = {
		main="Daybreak",sub="Sors Shield",
		head="Vanya Hood",neck="Henic Torque",
		ring1="Janniston Ring",ring2="Kuchekula Ring",
	}
		
    sets.midcast.LightWeatherCure = {}
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = {}

    sets.midcast.Curaga = sets.midcast.Cure

	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {})
	
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Grioavolr",sub="Clemency Grip"})
	
    sets.midcast['Elemental Magic'] = {
		main="Grioavolr",sub="Clerisy Strap",
		head="Jhakri Coronal +1",neck="Bagua Charm",ear1="Hecate's Earring",ear2="Gwati Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Acumen Ring",ring2="Mephitas's Ring",
		back="",waist=gear.ElementalObi,legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"
	}

    sets.midcast['Elemental Magic'].Resistant = {}
		
    sets.midcast['Elemental Magic'].Fodder = {}

	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder, {})
		
    sets.midcast['Dark Magic'] = {}
		
    sets.midcast.Drain = {
		main="Grioavolr",sub="Clerisy Strap",
		head="Bagua Galero +1",neck="Bagua Charm",ear2="Gwati Earring",
		body="Geo. Tunic +1",hands="Jhakri Cuffs +2",ring1="Excelsis Ring",ring2="Mephitas's Ring",
		waist="Fucho-no-Obi",legs="Azimuth Tights",feet="Jhakri Pigaches +1"
	}
    
    sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Stun = {}
		
	sets.midcast.Stun.Resistant = {}
		
	sets.midcast.Impact = {}
		
	sets.midcast['Enfeebling Magic'] = {
		main="Daybreak",sub="Sors Shield",range="Dunna",
		head="Jhakri Coronal +1",neck="Bagua Charm",ear2="Gwati Earring",
		body="Jhakri Robe +2",hands="Azimuth Gloves",ring1="Perception Ring",ring2="",
		back="",waist="Rumination Sash",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"
	}
		
	sets.midcast['Enfeebling Magic'].Resistant = {}
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})
		
	sets.midcast['Enhancing Magic'] = {
		head=gear.telchine.cap.enhancing,
		body=gear.telchine.chasuble.enhancing,hands=gear.telchine.gloves.enhancing,
		waist="Embla Sash",legs=gear.telchine.braconi.enhancing,feet=gear.telchine.pigaches.enhancing
	}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear1="Andoaa Earring"})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring1="Sheltered Ring"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring1="Sheltered Ring"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring1="Sheltered Ring"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring1="Sheltered Ring"})

	-- Gear for specific elemental nukes.
	sets.element.Wind = {main="Marin Staff"}
	sets.element.Ice = {}
	sets.element.Earth = {}

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Resting sets
	sets.resting = {}

	-- Idle sets

	sets.idle = {
		main="Daybreak",sub="Sors Shield",range="Dunna",ammo=empty,
		head=gear.merlinic.hood.refresh,neck="Warder's Charm",
		body="Jhakri Robe +2",hands="Bagua Mitaines +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		legs=gear.merlinic.shalwar.refresh,feet="Azimuth Gaiters"
	}
		
	sets.idle.DT = set_combine(sets.idle, {
		main="Malignance Pole",sub="Clerisy Strap"
		--body="Mallquis Saio +2"
	})
		
	sets.idle.TPEat = set_combine(sets.idle, {})

	-- .Pet sets are for when Luopan is present.
	sets.idle.Pet = {
		main="Idris",sub="Sors Shield",range="Dunna",ammo=empty,
		head="Azimuth Hood",
		hands="Geo. Mitaines +1",
		back=gear.nantosuelta.petregen,feet="Bagua Sandals +1"
	}

	--[[ Ideal Set
	sets.idle.Pet = {
		main="Idris",sub="Genmei Shield",range="Dunna",ammo=empty,
		head="Azimuth Hood +1",neck="Bagua Charm",ear1="Etiolation Earring",ear2="Eabani Earring",
		body="Shamash Robe",hands="Geo. Mitaines +3",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.nantosuelta.petregen,waist="Isa Belt",legs=gear.merlinic.shalwar.refresh,feet="Azimuth Gaiters +1"
	}
	]]
	sets.idle.DT.Pet = {}

	-- .Indi sets are for when an Indi-spell is active.
	sets.idle.Indi = set_combine(sets.idle, {})
	sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {}) 
	sets.idle.DT.Indi = set_combine(sets.idle.DT, {}) 
	sets.idle.DT.Pet.Indi = set_combine(sets.idle.DT.Pet, {})

	sets.idle.Weak = {}

	-- Defense sets
	
	sets.defense.DT = {}

	sets.defense.MDT = {}
		
    sets.defense.MEVA = {}
		
	sets.defense.PetDT = sets.idle.DT.Pet
		
	sets.defense.NukeLock = sets.midcast['Elemental Magic']
	
	sets.defense.GeoLock = sets.midcast.Geomancy.Indi

	sets.Kiting = {feet="Geomancy Sandals"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	sets.HPDown = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {}
		
	sets.engaged.DW = {}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {}
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {}
	sets.RecoverBurst = {}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(4, 10)
end