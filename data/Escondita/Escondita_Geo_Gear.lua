function user_setup()

	-- Options: Override default values
    state.OffenseMode:options('Normal')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal', 'PDT', 'TPEat')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock', 'GeoLock', 'PetPDT')
	state.MagicalDefenseMode:options('MDT', 'NukeLock')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','Nehushtan','DualWeapons')

	gear.nantosuelta = {}
	gear.nantosuelta.mab = {name="Nantosuelta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10'}}
	gear.nantosuelta.idle = {name="Nantosuelta's Cape",augments={'HP+60','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10'}}
	
	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_back = gear.nantosuelta.mab
	gear.obi_low_nuke_waist = "Sekhmet Corset"

	gear.obi_high_nuke_back = gear.nantosuelta.mab
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
	
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = {body="Bagua Tunic"}
	sets.precast.JA['Life Cycle'] = {body="Geo. Tunic +2",back=gear.nantosuelta.idle}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals"}
	sets.precast.JA['Mending Halation'] = {legs="Bagua Pants"}
	sets.precast.JA['Full Circle'] = {head="Azimuth Hood",hands="Bagua Mitaines"}
	
	-- Indi Duration in slots that would normally have skill here to make entrust more efficient.
	sets.buff.Entrust = {}
	
	-- Fast cast sets for spells

	sets.precast.FC = {main=gear.grioavolr.nuke,sub="Clerisy Strap",range="Dunna",ammo=empty,
		head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		hands="Volte Gloves",ring2="Kishar Ring",
		back="Lifestream Cape",waist="Channeler's Stone",legs="Geo. Pants +2",feet=gear.merlinic.crackows.refresh}

	sets.precast.FC.Geomancy = set_combine(sets.precast.FC, {range="Dunna",ammo=empty})
	
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear2="Barkaro. Earring",hands="Bagua Mitaines"})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Serenity",sub="Clerisy Strap"})
		
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

    sets.midcast.FastRecast = set_combine(sets.precast.FC, {body="Mallquis Saio +2",ring1="Defending Ring"})

	sets.midcast.Geomancy = {main="Idris",sub="Genbu's Shield",range="Dunna",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Mendi. Earring",
		body="Vedic Coat",hands="Geo. Mitaines +2",ring1="Defending Ring",ring2="Dark Ring",
		back="Lifestream Cape",waist="Luminary Sash",legs="Vanya Slops",feet="Amalric Nails"}


	--Extra Indi duration as long as you can keep your 900 skill cap.
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {legs="Bagua Pants",feet="Azimuth Gaiters"})
		
    sets.midcast.Cure = {main="Serenity",sub="Enki Strap",
        head="Vanya Hood",neck="Incanter's Torque",ear1="Regal Earring",ear2="Mendi. Earring",
        body="Zendik Robe",hands="Telchine Gloves",
        waist="Luminary Sash",legs="Geo. Pants +2",feet="Vanya Clogs"}
		
    sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {back="Twilight Cape",waist="Hachirin-no-Obi"})
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {back="Twilight Cape",waist="Hachirin-no-Obi"})

    sets.midcast.Curaga = sets.midcast.Cure

	sets.midcast.Cursna =  {neck="Incanter's Torque",feet="Vanya Clogs"}
	
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
	
    sets.midcast['Elemental Magic'] = {main=gear.grioavolr.nuke,sub="Enki Grip",ammo="Pemphredo Tathlum",
        head=gear.merlinic.hood.magical,neck="Sanctity Necklace",ear1="Regal Earring",ear2="Barkaro. Earring",
        body="Jhakri Robe +2",hands="Amalric Gages +1",ring1="Jhakri Ring",ring2="Snow Ring",
        back=gear.nantosuelta.mab,waist=gear.ElementalObi,legs=gear.merlinic.shalwar.magical,feet="Amalric Nails"}

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})
		
    sets.midcast['Elemental Magic'].Fodder = set_combine(sets.midcast['Elemental Magic'], {})

	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder, {})
		
	sets.midcast['Dark Magic'] = {head="Geo. Galero +2",neck="Erra Pendant",ear2="Regal Earring",
		body="Geomancy Tunic +2",hands="Geo. Mitaines +2",ring1="Evanescence Ring",
		back=gear.nantosuelta.mab,waist="Luminary Sash",legs="Azimuth Tights",feet="Geo. Sandals +2"}

	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], 
		{head="Pixie Hairpin +1",ring1="Evanescence Ring",ring2="Archon Ring",waist="Fucho-no-Obi",feet=gear.merlinic.crackows.drain})

	sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Stun = set_combine(sets.midcast.FastRecast, {})
		
	sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun, {})

		
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'].Resistant, {head=empty,body="Twilight Cloak"})
		
	sets.midcast['Enfeebling Magic'] = {
		head="Geo. Galero +2",neck="Erra Pendant",ear1="Regal Earring",ear2="Barkaro. Earring",
		body="Geomancy Tunic +2",hands="Regal Cuffs",ring1="Jhakri Ring",ring2="Kishar Ring",
		back=gear.nantosuelta.mab,waist="Luminary Sash",legs="Psycloth Lappas",feet="Geo. Sandals +2"}
		
	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {hands="Geo. Mitaines +2"})
		
	sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {hands="Amalric Gages +1"})
	sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {hands="Amalric Gages +1"})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {range=empty,ammo="Pemphredo Tathlum"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {range=empty,head="Pemphredo Tathlum"})
	
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})
		
	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {ammo="Pemphredo Tathlum",
		head=gear.telchine.cap.enhancing,neck="Incanter's Torque",ear1="Mendi. Earring",
		body=gear.telchine.chasuble.enhancing,hands=gear.telchine.gloves.enhancing,
		waist="Olympus Sash",legs=gear.telchine.braconi.enhancing,feet=gear.telchine.pigaches.enhancing})
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {hands="Regal Cuffs"})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})

	-- Gear for specific elemental nukes.
	sets.element.Wind = {main="Marin Staff"}
	sets.element.Ice = {}
	sets.element.Earth = {}

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Idle sets

	sets.idle = {main="Bolelabunga",sub="Genbu's Shield",range="Dunna",
		head="Befouled Crown",neck="Twilight Torque",ear1="Enchntr. Earring +1",ear2="Eabani Earring",
		body="Jhakri Robe +2",hands=gear.merlinic.dastanas.refresh,ring1="Defending Ring",ring2="Warden's Ring",
		back=gear.nantosuelta.idle,waist="Fucho-no-Obi",legs="Assid. Pants +1",feet=gear.merlinic.crackows.refresh}
		
	sets.idle.PDT = set_combine(sets.idle, 
		{body="Mallquis Saio +2",hands="Geo. Mitaines +2",back="Solemnity Cape",legs=gear.merlinic.shalwar.magical,feet="Azimuth Gaiters"})
		
	--sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque"})

	-- .Pet sets are for when Luopan is present.
	sets.idle.Pet = set_combine(sets.idle, 
		{main="Idris",head="Azimuth Hood",hands="Geo. Mitaines +2",back=gear.nantosuelta.idle,feet="Azimuth Gaiters"})

	sets.idle.PDT.Pet = set_combine(sets.idle.PDT, 
		{main="Idris",head="Azimuth Hood",hands="Geo. Mitaines +2",back=gear.nantosuelta.idle,feet="Azimuth Gaiters"})

	-- .Indi sets are for when an Indi-spell is active.
	sets.idle.Indi = set_combine(sets.idle, {})
	sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {}) 
	sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {}) 
	sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {})

	sets.idle.Weak = set_combine(sets.idle, {})

	-- Resting sets
	sets.resting = set_combine(sets.idle, {})
		
	-- Defense sets
	
	sets.defense.PDT = set_combine(sets.idle.PDT, {})

	sets.defense.MDT = set_combine(sets.defense.PDT, {ring2="Purity Ring"})

	sets.defense.MEVA = set_combine(sets.defense.MDT, {})

	sets.defense.PetPDT = sets.idle.PDT.Pet

	sets.defense.NukeLock = sets.midcast['Elemental Magic']
	
	sets.defense.GeoLock = sets.midcast.Geomancy.Indi

	sets.Kiting = {
		--feet="Herald's Gaiters"
	}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	sets.HPDown = {head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
	
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
    sets.MagicBurst = {feet="Jhakri Pigaches +1"}
	sets.RecoverBurst = {feet="Jhakri Pigaches +1"}

	-- Weapons sets
	sets.weapons.Nehushtan = {}
	sets.weapons.DualWeapons = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(4, 5)
end