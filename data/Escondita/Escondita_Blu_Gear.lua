function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Fodder','Normal','Acc','FullAcc')
	state.HybridMode:options('Normal','DTLite','PDT','MDT')
    state.WeaponskillMode:options('Match','Normal','Acc','FullAcc','Fodder')
    state.CastingMode:options('Normal','Resistant','Fodder','Proc')
    state.IdleMode:options('Normal','Sphere','PDT','DTHippo')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('TizonaTPBonus','TizonaAcc','Almace','Club','NaeglingTPBonus','NaeglingAcc','MagicWeapons','Learning','None')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','MP','SuppaBrutal','DWEarrings','DWMax'}

	gear.rosmerta = {}
	gear.rosmerta.stp = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
	gear.rosmerta.cdc = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
	gear.rosmerta.wsd = {name="Rosmerta's Cape",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	gear.rosmerta.mab = {name="Rosmerta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
	gear.rosmerta.fc = {name = "Rosmerta's Cape", augments = {'"Fast Cast"+10',}}

	gear.colada = {}
	gear.colada.da = {name="Colada",augments={'"Dbl.Atk."+4','STR+3','Accuracy+4','Attack+18','DMG:+11'}}

	gear.obi_cure_waist = "Luminary Sash"
	gear.obi_nuke_waist = "Yamabuki-no-Obi"

	-- Additional local binds
	send_command('bind ^` input /ja "Chain Affinity" <me>')
	send_command('bind @` input /ja "Efflux" <me>')
	send_command('bind !` input /ja "Burst Affinity" <me>')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	send_command('bind ^backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Mighty Guard" <me>')
	send_command('bind !backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Carcharian Verve" <me>')
	send_command('bind @backspace input /ja "Convergence" <me>')
	send_command('bind @f10 gs c toggle LearningMode')
	send_command('bind ^@!` gs c cycle MagicBurstMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !@^f7 gs c toggle AutoWSMode')
	send_command('bind !r gs c weapons MagicWeapons;gs c update')
	send_command('bind @q gs c weapons MaccWeapons;gs c update')
	send_command('bind ^q gs c weapons Almace;gs c update')
	send_command('bind !q gs c weapons HybridWeapons;gs c update')

	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	sets.buff['Burst Affinity'] = {feet="Hashishin Basmak"}
	sets.buff['Chain Affinity'] = {feet="Assim. Charuqs +2"}
	sets.buff.Convergence = {head="Luhlaza Keffiyeh"}
	sets.buff.Diffusion = {feet="Luhlaza Charuqs"}
	sets.buff.Enchainment = {}
	sets.buff.Efflux = {back=gear.rosmerta.stp}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	sets.HPDown = {
		head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",
		back=gear.rosmerta.stp,legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"
	}

	-- Precast Sets

	-- Precast sets to enhance JAs
	sets.precast.JA['Azure Lore'] = {hands="Luhlaza Bazubands"}


	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {}

	sets.precast.Flourish1 = {
		ammo="Falcon Eye",
		head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Digni. Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Cornflower Cape",waist="Olseni Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"
	}

	-- Fast cast sets for spells

	sets.precast.FC = {
		ammo="Sapience Orb",
		head=gear.herculean.helm.dexwsd,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		hands="Leyline Gloves",ring1="Kishar Ring",
		back=gear.rosmerta.fc,waist="Channeler's Stone",legs="Aya. Cosciales +2",feet="Amalric Nails"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan"})


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Aurgelmir Orb",
		head=gear.herculean.helm.dexwsd,neck="Fotia Gorget",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Assim. Jubbah +3",hands="Jhakri Cuffs +2",ring1="Rajas Ring",ring2="Apate Ring",
		back=gear.rosmerta.wsd,waist="Fotia Belt",legs="Jhakri Slops +1",feet=gear.herculean.boots.wsd
	}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

	sets.precast.WS.FullAcc = set_combine(sets.precast.WS.Acc, {})

	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
		head="Jhakri Coronal +2",ear2="Regal Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring="Ilabrat Ring",ring2="Ayanmo Ring",
		back=gear.rosmerta.stp,legs="Jhakri Slops +1",feet="Aya. Gambieras +2"
	})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {})
	sets.precast.WS['Requiescat'].FullAcc = set_combine(sets.precast.WS['Requiescat'].Acc, {})
	sets.precast.WS['Requiescat'].Fodder = set_combine(sets.precast.WS['Requiescat'], {})

	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Realmrazer'].Acc = set_combine(sets.precast.WS['Realmrazer'], {})
	sets.precast.WS['Realmrazer'].FullAcc = set_combine(sets.precast.WS['Realmrazer'].Acc, {})
	sets.precast.WS['Realmrazer'].Fodder = set_combine(sets.precast.WS['Realmrazer'], {})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
		head="Adhemar Bonnet +1",ear1="Odr Earring",ear2="Moonshade Earring",
		body="Adhemar Jacket +1",hands="Adhemar Wrist. +1",ring1="Ilabrat Ring",ring2="Rajas Ring",
		back=gear.rosmerta.cdc,legs="Samnuha Tights",feet="Aya. Gambieras +2"
	})
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {})
	sets.precast.WS['Chant du Cygne'].FullAcc = set_combine(sets.precast.WS['Chant du Cygne'].Acc, {})
	sets.precast.WS['Chant du Cygne'].Fodder = set_combine(sets.precast.WS['Chant du Cygne'], {})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {neck="Caro Necklace",ear1="Moonshade Earring",ear2="Regal Earring"})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {})
	sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS['Savage Blade'].Acc, {})
	sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS['Savage Blade'], {})

	sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Vorpal Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Vorpal Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Vorpal Blade'].Fodder = set_combine(sets.precast.WS['Vorpal Blade'], {})

	sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS, {neck="Caro Necklace",ear2="Regal Earring"})
	sets.precast.WS['Expiacion'].Acc = set_combine(sets.precast.WS['Expiacion'], {})
	sets.precast.WS['Expiacion'].FullAcc = set_combine(sets.precast.WS['Expiacion'].Acc, {})
	sets.precast.WS['Expiacion'].Fodder = set_combine(sets.precast.WS['Expiacion'], {})

	sets.precast.WS['Sanguine Blade'] = {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Friomisi Earring",
		body="Assim. Jubbah +3",hands="Amalric Gages +1",ring1="",ring2="",
		back=gear.rosmerta.wsd,waist="Eschan Stone",legs=gear.herculean.trousers.magical,feet="Jhakri Pigaches +1"
	}

	sets.precast.WS['Flash Nova'] = {}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring"}
	sets.AccMaxTP = {ear1="Regal Earring",ear2="Telos Earring"}

	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

	sets.midcast['Blue Magic'] = {}

	-- Physical Spells --

	sets.midcast['Blue Magic'].Physical = {
		main="Naegling",sub="Colada",ammo="Falcon Eye",
		head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Assuage Earring",
		body="Jhakri Robe +2", hands="Jhakri Cuffs +2",ring1="Ramuh Ring",ring2="Apate Ring",
		back=gear.rosmerta.wsd,waist="Eschan Stone",legs="Samnuha Tights",feet="Jhakri Pigaches +1"
	}

	sets.midcast['Blue Magic'].Physical.Resistant = set_combine(sets.midcast['Blue Magic'].Physical, {
		body="Assim. Jubbah +3",back=gear.rosmerta.stp,legs="Jhakri Slops +1"})

	sets.midcast['Blue Magic'].Physical.Fodder = set_combine(sets.midcast['Blue Magic'].Physical, {})

	sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {})

	sets.midcast['Blue Magic'].PhysicalAcc.Resistant = set_combine(sets.midcast['Blue Magic'].PhysicalAcc, {})
	sets.midcast['Blue Magic'].PhysicalAcc.Fodder = sets.midcast['Blue Magic'].Fodder

	sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalStr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalStr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalDex.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalDex.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalVit.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalVit.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalAgi.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalAgi.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalInt.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalInt.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalMnd.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalMnd.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalChr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalChr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalHP.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalHP.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})


	-- Magical Spells --

	sets.midcast['Blue Magic'].Magical = {
		main="Naegling",sub="Nibiru Cudgel",ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Friomisi Earring",
		body="Jhakri Robe +2",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring",
		back=gear.rosmerta.mab,waist=gear.ElementalObi,legs=gear.herculean.trousers.magical,feet="Amalric Nails"
	}
					 
	sets.midcast['Blue Magic'].Magical.Proc = set_combine(sets.midcast['Blue Magic'].Magical, sets.midcast.FastRecast, {})
					 
	sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
		{hands="Jhakri Cuffs +2",ring2="Stikini Ring",waist="Eschan Stone"})

	sets.midcast['Blue Magic'].Magical.Fodder = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {ring2="Stikini Ring"})
	sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.midcast['Blue Magic'].MagicAccuracy = set_combine(sets.midcast['Blue Magic'].Magical, {
		neck="Erra Pendant",ear2="Hermetic Earring",
		hands="Jhakri Cuffs +2",ring2="Stikini Ring",
		feet="Jhakri Pigaches +1"})

	sets.midcast['Enfeebling Magic'] = {
		main="Naegling",sub="Nibiru Cudgel",ammo="Pemphredo Tathlum",
		head="Assim. Keffiyeh +2",neck="Erra Pendant",ear1="Regal Earring",ear2="Hermetic Earring",
		body="Assim. Jubba +3",hands="Regal Cuffs",ring1="Etana Ring",ring2="Stikini Ring",
		back=gear.rosmerta.mab,waist="Luminary Sash",legs="Psycloth Lappas",feet="Aya. Gambieras +2"
	}

	sets.midcast['Dark Magic'] = {
		main="Naegling",sub="Nibiru Cudgel",ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Evanescense Ring",ring2="Stikini Ring",
		back=gear.rosmerta.mab,waist="Luminary Sash",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"
	}

	sets.midcast['Enhancing Magic'] = {
		head=gear.telchine.cap.enhancing,
		body=gear.telchine.chasuble.enhancing,hands=gear.telchine.gloves.enhancing,
		legs=gear.telchine.braconi.enhancing,feet=gear.telchine.pigaches.enhancing}

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {waist="Gishdubar Sash"})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {hands="Regal Cuffs"})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})

	sets.midcast['Divine Magic'] = {
		ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",neck="Incanter's Torque",ear1="Regal Earring",ear2="Hermetic Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Shiva Ring +1",ring2="Stikini Ring",
		back=gear.rosmerta.mab,waist="Luminary Sash",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"
	}

	sets.midcast['Elemental Magic'] = {
		main="Naegling",sub="Nibiru Cudgel",ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Friomisi Earring",
		body="Jhakri Robe +2",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring",
		back=gear.rosmerta.mab,waist=gear.ElementalObi,legs=gear.herculean.trousers.magical,feet="Jhakri Pigaches +1"
	}

	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})

	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Resistant

	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}
	sets.element.Earth = {}
	sets.element.Light = {} --ring2="Weatherspoon Ring"

	sets.midcast.Cure = {
		main="Nibiru Cudgel",sub="Nibiru Cudgel",ammo="Pemphredo Tathlum",
		head="Carmine Mask +1",neck="Incanter's Torque",ear1="Etiolation Earring",ear2="Mendi. Earring",
		body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Janniston Ring",ring2="Haoma's Ring",
		back=gear.ElementalCape,waist=gear.ElementalObi,legs="Carmine Cuisses +1",feet="Medium's Sabots"
	}

	-- Breath Spells --

	sets.midcast['Blue Magic'].Breath = {
		ammo="Mavi Tathlum",
		head="Luh. Keffiyeh +1",neck="Mavi Scarf",ear1="Regal Earring",ear2="Digni. Earring",
		body="Assim. Jubbah +3",hands="Luh. Bazubands +1",ring1="Kunaji Ring",ring2="Meridian Ring",
		back="Cornflower Cape",legs="Hashishin Tayt +1",feet="Luhlaza Charuqs +1"
	}

	-- Physical Added Effect Spells most notably "Stun" spells --

	sets.midcast['Blue Magic'].Stun = {
		main="Naegling",sub="Nibiru Cudgel",ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",neck="Erra Pendant",ear1="Regal Earring",ear2="Hermetic Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Jhakri Ring",ring2="Stikini Ring",
		back="Cornflower Cape",waist="Luminary Sash",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"
	}

	sets.midcast['Blue Magic'].Stun.Resistant = set_combine(sets.midcast['Blue Magic'].Stun, {
		ammo="Falcon Eye"})

	sets.midcast['Blue Magic'].Stun.Fodder = sets.midcast['Blue Magic'].Stun

	-- Other Specific Spells --

	sets.midcast['Blue Magic']['White Wind'] = {ammo="Mavi Tathlum",
		ear2="Mendi. Earring",
		hands="Telchine Gloves",
		back=gear.ElementalCape,waist=gear.ElementalObi}
					
	sets.midcast['Blue Magic']['Healing Breeze'] = sets.midcast['Blue Magic']['White Wind']

	sets.midcast['Blue Magic'].Healing = {
		neck="Incanter's Torque",ear1="Etiolation Earring",ear2="Mendi. Earring",
		hands="Telchine Gloves",
		back=gear.ElementalCape,waist=gear.ElementalObi}

	--Overwrite certain spells with these peices even if the day matches, because of resource inconsistancies.
	sets.NonElementalCure = {back="Tempered Cape +1",waist="Luminary Sash"}

	sets.midcast['Blue Magic'].SkillBasedBuff = {ammo="Mavi Tathlum",
		head="Luhlaza Keffiyeh",neck="Incanter's Torque",
		body="Assim. Jubbah +3",ring2="Stikini Ring",
		back="Cornflower Cape",legs="Mavi Tayt +2",feet="Luhlaza Charuqs"}

	sets.midcast['Blue Magic'].Buff = {}

	sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Blue Magic'].Buff, {waist="Gishdubar Sash"})

	sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {})

	-- Sets to return to when not performing an action.

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Gear for learning spells: +skill and AF hands.
	sets.Learning = {hands="Assim. Bazu. +2"}
	
	-- Idle sets
	sets.idle = {
		ammo="Staunch Tathlum +1",
		head=gear.herculean.helm.refresh,neck="Twilight Torque",ear1="Etiolation Earring",
		body="Jhakri Robe +2",hands=gear.herculean.gloves.refresh,ring1="Defending Ring",ring2="Warden's Ring",
		back=gear.rosmerta.stp,waist="Flume Belt +1",legs="Aya. Cosciales +2",feet=gear.herculean.boots.refresh
	}

	sets.idle.Sphere = set_combine(sets.idle, {})

	sets.idle.PDT = set_combine(sets.idle, {})

	sets.idle.DTHippo = set_combine(sets.idle.PDT, {})

	-- Resting sets
	sets.resting = sets.idle


	-- Defense sets
	sets.defense.PDT = {}

	sets.defense.MDT = {}

	sets.defense.MEVA = {}

	sets.defense.NukeLock = sets.midcast['Blue Magic'].Magical

	sets.Kiting = {legs="Carmine Cuisses +1"}

    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
    sets.MP = {waist="Flume Belt +1",ear1="Suppanomimi", ear2="Ethereal Earring"}
    sets.MP_Knockback = {}
	sets.SuppaBrutal = {ear1="Suppanomimi", ear2="Brutal Earring"}
	sets.DWEarrings = {ear1="Suppanomimi",ear2="Eabani Earring"}
	sets.DWMax = {ear1="Suppanomimi",ear2="Eabani Earring",body="Adhemar Jacket +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.herculean.boots.th})
	sets.Assault = {ring1="Balrahn's Ring"}
	
	-- Weapons sets
	sets.weapons.TizonaTPBonus = {main="Tizona",sub="Thibron"}
	sets.weapons.TizonaAcc = {main="Tizona",sub="Naegling"}
	sets.weapons.Almace = {main="Almace",sub="Naegling"}
	sets.weapons.Club = {main="Kaja Rod",sub="Naegling"}
	sets.weapons.NaeglingTPBonus = {main="Naegling",sub="Thibron"}
	sets.weapons.NaeglingAcc = {main="Naegling",sub=gear.colada.da}
	sets.weapons.MagicWeapons = {main="Naegling",sub="Kaja Rod"}
	sets.weapons.Club = {main="Kaja Rod",sub="Naegling"}
	sets.weapons.Learning = {main=empty,sub=empty}

	-- Engaged sets

	sets.engaged = {
		ammo="Aurgelmir Orb",
		head="Adhemar Bonnet +1",neck="Clotharius Torque",ear1="Suppanomimi",ear2="Cessance Earring",
		body="Adhemar Jacket +1",hands="Adhemar Wrist. +1",ring1="Petrov Ring",ring2="Epona's Ring",
		back=gear.rosmerta.stp,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Aya. Gambieras +2"
	}

	sets.engaged.AM = set_combine(sets.engaged, {})

	sets.engaged.FullAcc = set_combine(sets.engaged.Acc, {
		hands="Adhemar Wrist. +1",ring1="Ilabrat Ring",legs="Carmine Cuisses +1"
	})

	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Self_Healing_Club = {waist="Gishdubar Sash"}
	sets.Self_Healing_DWClub = {waist="Gishdubar Sash"}
	sets.Healing_Club = {}
	sets.Healing_DWClub = {}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	sets.MagicBurst = {body="Samnuha Coat",hands="Amalric Gages +1"}
	sets.Phalanx_Recieved = {legs=gear.herculean.trousers.phalanx}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1, 16)
	elseif player.sub_job == 'NIN' then
		set_macro_page(2, 16)
	elseif player.sub_job == 'WAR' then
		set_macro_page(3, 16)
	elseif player.sub_job == 'RUN' then
		set_macro_page(4, 16)
	elseif player.sub_job == 'THF' then
		set_macro_page(5, 16)
	elseif player.sub_job == 'RDM' then
		set_macro_page(6, 16)
	else
		set_macro_page(10, 16)
	end
end

--Job Specific Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not areas.Cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()

				if spell_recasts[981] < spell_latency and not have_trust("Sylvie") then
					windower.chat.input('/ma "Sylvie (UC)" <me>')
					tickdelay = (framerate * 3)
					return true
				elseif spell_recasts[952] < spell_latency and not have_trust("Koru-Moru") then
					windower.chat.input('/ma "Koru-Moru" <me>')
					tickdelay = (framerate * 3)
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.chat.input('/ma "Qultada" <me>')
					tickdelay = (framerate * 3)
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.chat.input('/ma "Ulmia" <me>')
					tickdelay = (framerate * 3)
					return true
				elseif spell_recasts[979] < spell_latency and not have_trust("Selh'teus") then
					windower.chat.input('/ma "Selh\'teus" <me>')
					tickdelay = (framerate * 3)
					return true
				else
					return false
				end
			end
		end
	end
	return false
end

buff_spell_lists = {
	Auto = {--Options for When are: Always, Engaged, Idle, OutOfCombat, Combat
		{Name='Erratic Flutter',	Buff='Haste',			SpellID=710,	When='Always'},
		{Name='Battery Charge',		Buff='Refresh',			SpellID=662,	When='Always'},
		{Name='Refresh',			Buff='Refresh',			SpellID=109,	When='Always'},
		{Name='Nat. Meditation',	Buff='Attack Boost',	SpellID=700,	When='Engaged'},
		--{Name='Mighty Guard',		Buff='Mighty Guard',	SpellID=750,	When='Combat'},
		{Name='Phalanx',			Buff='Phalanx',			SpellID=106,	When='Combat'},
		{Name='Barrier Tusk',		Buff='Phalanx',			SpellID=685,	When='Combat'},
		},
	
	Default = {
		{Name='Erratic Flutter',	Buff='Haste',			SpellID=710,	Reapply=false},
		{Name='Battery Charge',		Buff='Refresh',			SpellID=662,	Reapply=false},
		{Name='Refresh',			Buff='Refresh',			SpellID=109,	Reapply=false},
		{Name='Phalanx',			Buff='Phalanx',			SpellID=106,	Reapply=false},
		{Name='Barrier Tusk',		Buff='Phalanx',			SpellID=685,	Reapply=false},
		{Name='Stoneskin',			Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Occultation',		Buff='Blink',			SpellID=679,	Reapply=false},
		{Name='Blink',				Buff='Blink',			SpellID=53,		Reapply=false},
		--{Name='Mighty Guard',		Buff='Mighty Guard',	SpellID=750,	Reapply=false},
		{Name='Nat. Meditation',	Buff='Attack Boost',	SpellID=700,	Reapply=false},
	},
	
	Cleave = {
		{Name='Erratic Flutter',	Buff='Haste',			SpellID=710,	Reapply=false},
		{Name='Battery Charge',		Buff='Refresh',			SpellID=662,	Reapply=false},
		{Name='Refresh',			Buff='Refresh',			SpellID=109,	Reapply=false},
		{Name='Phalanx',			Buff='Phalanx',			SpellID=106,	Reapply=false},
		{Name='Barrier Tusk',		Buff='Phalanx',			SpellID=685,	Reapply=false},
		{Name='Stoneskin',			Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Occultation',		Buff='Blink',			SpellID=679,	Reapply=false},
		{Name='Blink',				Buff='Blink',			SpellID=53,		Reapply=false},
		--{Name='Carcharian Verve',	Buff='Aquaveil',		SpellID=745,	Reapply=false},
		{Name='Memento Mori',		Buff='Magic Atk. Boost',SpellID=538,	Reapply=false},
	},
}