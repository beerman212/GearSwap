function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal')
	state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
	state.IdleMode:options('Normal', 'PDT', 'MDT')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Default','Sword','Dual')

	gear.sucellos = {}
	gear.sucellos.enfeeble = {name="Sucellos's Cape",augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10'}}

	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_back = "Toro Cape"
	gear.obi_low_nuke_waist = "Sekhmet Corset"

	gear.obi_high_nuke_back = "Toro Cape"
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
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Precast Sets

	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = {}


	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells

	sets.precast.FC = {
		main="Marin Staff",sub="Clerisy Strap",
		head="Atro. Chapeau +1",ear1="Moonshade Earring",ear2="Loquac. Earring",
		body="Vitiation Tabard",ring1="Kishar Ring",
		back=gear.sucellos.enfeeble,waist="Embla Sash",legs="Aya. Cosciales +2"
	}
		
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
		
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Chant Du Cygne'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Savage Blade'] = {}
		
	sets.precast.WS['Sanguine Blade'] = {}


	-- Midcast Sets

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {}

	-- Gear for Magic Burst mode.
	sets.MagicBurst = {}
	sets.RecoverBurst = {}

	-- Gear for specific elemental nukes.
	sets.element.Wind = {main="Marin Staff"}
	sets.element.Ice = {}
	sets.element.Earth = {}

	sets.midcast.FastRecast = {}

	sets.midcast.Cure = {
		main="Iridal Staff",sub="Clerisy Strap",
		head="Vanya Hood",
		ring1="Janniston Ring",
		legs=gear.chironic.hose.refresh,feet="Vanya Clogs"
	}
		
	sets.midcast.LightWeatherCure = {}
		
		--Cureset for if it's not light weather but is light day.
	sets.midcast.LightDayCure = {}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
		
	sets.midcast.Curaga = sets.midcast.Cure
	sets.Self_Healing = {--[[waist="Gishdubar Sash"]]}
	sets.Cure_Received = {--[[waist="Gishdubar Sash"]]}
	sets.Self_Refresh = {--[[waist="Gishdubar Sash"]]}

	sets.midcast['Enhancing Magic'] = {
		head=gear.telchine.cap.enhancing,
		--[[body="Vitiation Tabard +2",]]hands="Atrophy Gloves +1",
		back=gear.sucellos.enfeeble,waist="Embla Sash",legs=gear.telchine.braconi.enhancing,feet="Estq. Houseaux +1"
	}
	sets.midcast['Enhancing Magic'].skill500 = set_combine(sets.midcast['Enhancing Magic'], {
		head="Umuthi Hat",body="Vitiation Tabard",hands="Vitiation Gloves",legs="Atrophy Tights +1"
	})
	sets.midcast['Enhancing Magic'].skillmax = set_combine(sets.midcast['Enhancing Magic'])

	--Atrophy Gloves are better than Lethargy for me despite the set bonus for duration on others.		
	sets.buff.ComposureOther = {}
		
	--Red Mage enhancing sets are handled in a different way from most, layered on due to the way Composure works
	--Don't set combine a full set with these spells, they should layer on Enhancing Set > Composure (If Applicable) > Spell
	sets.midcast.Refresh = {}
	sets.midcast.Aquaveil = {
		head="Chironic Hat"
	}
	sets.midcast.BarElement = {head="Umuthi Hat",body="Vitiation Tabard",hands="Vitiation Gloves",legs="Atrophy Tights +1"}
	sets.midcast.Stoneskin = {}
	sets.midcast.Protect = sets.Sheltered
	sets.midcast.Shell = sets.Sheltered
	sets.midcast["Phalanx II"] = {}
	sets.midcast.Phalanx = {}
	sets.midcast.Temper = {}

	sets.midcast['Enfeebling Magic'] = {
		main="Marin Staff",sub="Clerisy Strap",ammo="Regal Gem",
		head="Vitiation Chapeau",neck="Imbodla Necklace",ear1="Moonshade Earring",ear2="Snotra Earring",
		body="Atrophy Tabard +1",hands="Aya. Manopolas +1",ring1="Kishar Ring",ring2="Ayanmo Ring",
		back=gear.sucellos.enfeeble,waist="Porous Rope",legs=gear.chironic.hose.enfeeble,feet="Aya. Gambieras +1"
	}
		
	sets.midcast['Enfeebling Magic'].Resistant = {}
		
	sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast['Distract III'] = set_combine(sets.midcast.MndEnfeebles, {})
	sets.midcast['Distract III'].Resistant = set_combine(sets.midcast.MndEnfeebles.Resistant, {})
	sets.midcast['Frazzle III'] = set_combine(sets.midcast.MndEnfeebles, {})
	sets.midcast['Frazzle III'].Resistant = set_combine(sets.midcast.MndEnfeebles.Resistant, {})

	sets.midcast.Silence = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.Silence.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})	

	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {})

	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio III'] = set_combine(sets.midcast['Enfeebling Magic'], {})

	sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast['Slow II'].Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.Dispel = set_combine(sets.midcast['Enfeebling Magic'], {neck="Duelist's Torque"})

	sets.midcast['Elemental Magic'] = {}
		
	sets.midcast['Elemental Magic'].Resistant = {}
		
	sets.midcast['Elemental Magic'].Fodder = {}

	sets.midcast['Elemental Magic'].Proc = {}
		
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder, {})
		
	sets.midcast.Impact = {}

	sets.midcast['Dark Magic'] = {}

	sets.midcast.Drain = {}

	sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Stun = {}
		
	sets.midcast.Stun.Resistant = {}

	-- Sets for special buff conditions on spells.
		
	sets.buff.Saboteur = {}

	sets.HPDown = {}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {}


	-- Idle sets
	sets.idle = {
		main="Bolelabunga",sub="Sors Shield",ammo="Homiliary",
		head="Vitiation Chapeau",neck="Warder's Charm",ear1="Bloodgem Earring",ear2="Loquac. Earring",
		body="Jhakri Robe +2",hands=gear.chironic.gloves.refresh,ring1="Defending Ring",ring2="Ayanmo Ring",
		back=gear.sucellos.enfeeble,waist="Porous Rope",legs=gear.merlinic.shalwar.refresh,feet=gear.chironic.slippers.refresh
	}
		
	sets.idle.PDT = {}
		
	sets.idle.MDT = {}
		
	sets.idle.Weak = {}

	sets.idle.DTHippo = set_combine(sets.idle.PDT, {})

	-- Defense sets
	sets.defense.PDT = {}

	sets.defense.NukeLock = sets.midcast['Elemental Magic']
		
	sets.defense.MDT = {}
		
	sets.defense.MEVA = {}
		
	sets.idle.TPEat = set_combine(sets.idle, {})

	sets.Kiting = {}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Weapons sets
	sets.weapons.Default = {}
	sets.weapons.Sword = {main="Nibiru Blade",sub="Sors Shield"}
	sets.weapons.Dual = {main="Nibiru Blade",sub="Buramenk'ah"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group

	sets.engaged = {
		head="Aya. Zucchetto +2",neck="Clotharius Torque",ear1="Assuage Earring",ear2="",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +1",ring1="Petrov Ring",ring2="",
		back="Atheling Mantle",waist="Olseni Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +1"
	}

	sets.engaged.DW = {}
		
	sets.engaged.PhysicalDef = {}
		
	sets.engaged.MagicalDef = {}

end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == 'DNC' then
		set_macro_page(4, 8)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 8)
	elseif player.sub_job == 'BLM' then
		set_macro_page(2, 8)
	else
		set_macro_page(3, 8)
	end
end