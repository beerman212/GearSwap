function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Fodder','Normal','Acc','MaxAcc')
	state.HybridMode:options('Normal','HybridDT','PDT','MDT')
	state.WeaponskillMode:options('Match','Normal','Acc','MaxAcc','Fodder')
	state.CastingMode:options('Normal','Resistant','Fodder','Proc')
	state.IdleMode:options('Normal','PDT')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Sequence','MaxentiusTP','NaeglingTP','MagicWeapons','Learning','None')

	state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','TreasureHunter'}
	
	info.th_ma_ids = S{33, 34, 584}

	gear.rosmerta = {}
	gear.rosmerta.stp = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	gear.rosmerta.cdc = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
	gear.rosmerta.wsd = {name="Rosmerta's Cape",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	gear.rosmerta.mab = {name="Rosmerta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.rosmerta.req = {name="Rosmerta's Cape",augments={'MND+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	
	gear.colada = {}
	gear.colada.enhancing = {name="Colada", augments={'Enh. Mag. eff. dur. +4','MND+2','Mag. Acc.+15','"Mag.Atk.Bns."+18',}}
	gear.colada.stp = {name="Colada", augments={'"Store TP"+5','DEX+6','Accuracy+18','Attack+8','DMG:+12',}}

	gear.obi_cure_waist = "Luminary Sash"
	gear.obi_nuke_waist = "Eschan Stone"

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
	send_command('bind @q gs c weapons NaeglingTP;gs c update')
	send_command('bind ^q gs c weapons MaxentiusTP;gs c update')
	send_command('bind !q gs c weapons Learning;gs c update')

	select_default_macro_book()
	--lockstyle:schedule(5)
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	sets.buff['Burst Affinity'] = {feet="Hashi. Basmak +1"}
	sets.buff['Chain Affinity'] = {feet="Assim. Charuqs +2"}
	sets.buff.Convergence = {head="Luh. Keffiyeh +2"}
	sets.buff.Diffusion = {feet="Luhlaza Charuqs +1"}
	sets.buff.Enchainment = {}
	sets.buff.Efflux = {back=gear.rosmerta.stp,legs="Hashishin Tayt +1"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	sets.HPDown = {head="Pixie Hairpin +1",ear1="Mendi. Earring",ear2="Evans Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Mephitas's Ring",
		legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

	-- Precast Sets

	-- Precast sets to enhance JAs
	sets.precast.JA['Azure Lore'] = {hands="Luh. Bazubands +1"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {legs="Dashing Subligar"}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {ammo="Aurgelmir Orb",
		head="Carmine Mask +1",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Telos Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar.wrist.path_b,ring1="Chirich Ring",ring2="Ayanmo Ring",
		back=gear.rosmerta.stp,waist="Grunfeld Rope",legs="Carmine Cuisses +1",feet="Jhakri Pigaches +2"}

	sets.precast.Flourish1 = {ammo="Aurgelmir Orb",
		head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Digni. Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Stikini Ring",ring2="Etana Ring",
		back=gear.rosmerta.mab,waist="Luminary Sash",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

	-- Fast cast sets for spells

	sets.precast.FC = {main="Colada",sub="Vampirism",ammo="Impatiens",
		head="Amalric Coif +1",neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body=gear.taeon.tabard.fc,hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
		back="Perimede Cape",waist="Witful Belt",legs="Aya. Cosciales +2",feet="Carmine Greaves +1"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan +1"})


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Aurgelmir Orb",
		head=gear.herculean.helm.strwsd,neck="Fotia Gorget",ear1="Telos Earring",ear2="Cessance Earring",
		body=gear.herculean.vest.dexwsd,hands="Jhakri Cuffs +2",ring1="Shukuyu Ring",ring2="Ilabrat Ring",
		back=gear.rosmerta.wsd,waist="Fotia Belt",legs=gear.herculean.trousers.strwsd,feet="Jhakri Pigaches +2"}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {body="Adhemar Jacket +1",legs="Carmine Cuisses +1"})
	sets.precast.WS.MaxAcc = set_combine(sets.precast.WS.Acc, {head="Carmine Mask +1"})
	sets.precast.WS.Fodder =  set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = {
		ammo="Aurgelmir Orb",
		head="Jhakri Coronal +2",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Regal Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Ilabrat Ring",ring2="Epona's Ring",
		back=gear.rosmerta.req,waist="Fotia Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"
	}
	
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {ring2="Chirich Ring"})
	sets.precast.WS['Requiescat'].MaxAcc = set_combine(sets.precast.WS['Requiescat'].Acc, {ear1="Telos Earring"})
	sets.precast.WS['Requiescat'].Fodder = set_combine(sets.precast.WS['Requiescat'], {})

	sets.precast.WS['Chant du Cygne'] = {
		ammo="Jukukik Feather",
		head="Adhemar Bonnet +1",neck="Mirage Stole +1",ear1="Mache Earring +1",ear2="Mache Earring +1",
		body="Abnoba Kaftan",hands=gear.adhemar.wrist.path_b,ring1="Begrudging Ring",ring2="Epona's Ring",
		back=gear.rosmerta.cdc,waist="Fotia Belt",legs="Samnuha Tights",feet="Thereoid Greaves"
	}
	
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {body="Adhemar Jacket +1"})
	sets.precast.WS['Chant du Cygne'].MaxAcc = set_combine(sets.precast.WS['Chant du Cygne'].Acc, {head="Carmine Mask +1",ring2="Chirich Ring",feet="Carmine Greaves +1"})
	sets.precast.WS['Chant du Cygne'].Fodder = set_combine(sets.precast.WS['Chant du Cygne'], {})

	sets.precast.WS['Savage Blade'] = {
		ammo="Aurgelmir Orb",
		head=gear.herculean.helm.strwsd,neck="Mirage Stole +1",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body="Assim. Jubbah +2",hands="Jhakri Cuffs +2",ring1="Shukuyu Ring",ring2="Rufescent Ring",
		back=gear.rosmerta.wsd,waist="Grunfeld Rope",legs=gear.herculean.trousers.strwsd,feet="Jhakri Pigaches +2"
	}

	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {})
	sets.precast.WS['Savage Blade'].MaxAcc = set_combine(sets.precast.WS['Savage Blade'].Acc, {})
	sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS['Savage Blade'], {})

	sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS['Chant du Cygne'], {})
	sets.precast.WS['Vorpal Blade'].Acc = set_combine(sets.precast.WS['Chant du Cygne'].Acc, {})
	sets.precast.WS['Vorpal Blade'].MaxAcc = set_combine(sets.precast.WS['Chant du Cygne'].MaxAcc, {})
	sets.precast.WS['Vorpal Blade'].Fodder = set_combine(sets.precast.WS['Vorpal Blade'], {})

	sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS['Savage Blade'], {})
	sets.precast.WS['Expiacion'].Acc = set_combine(sets.precast.WS['Savage Blade'].Acc, {})
	sets.precast.WS['Expiacion'].MaxAcc = set_combine(sets.precast.WS['Savage Blade'].MaxAcc, {})
	sets.precast.WS['Expiacion'].Fodder = set_combine(sets.precast.WS['Expiacion'], {})

	sets.precast.WS['Sanguine Blade'] = {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Friomisi Earring",
		body="Amalric Doublet +1",hands="Jhakri Cuffs +2",ring1="Shiva Ring +1",ring2="Archon Ring",
		back=gear.rosmerta.mab,waist="Eschan Stone",legs="Amalric Slops +1",feet="Amalric Nails +1"
	}

	sets.precast.WS['Realmrazer'] = sets.precast.WS['Requiescat']
	
	sets.precast.WS['Black Halo'] = {
		ammo="Aurgelmir Orb",
		head=gear.herculean.helm.strwsd,neck="Mirage Stole +1",ear1="Regal Earring",ear2="Moonshade Earring",
		body="Assim. Jubbah +2",hands="Jhakri Cuffs +2",ring1="Shukuyu Ring",ring2="Rufescent Ring",
		back=gear.rosmerta.wsd,waist="Grunfeld Rope",legs=gear.herculean.trousers.strwsd,feet="Carmine Cuisses +1"
	}
	
	sets.precast.WS['Black Halo'].Acc = set_combine(sets.precast.WS['Black Halo'], {})
	sets.precast.WS['Black Halo'].MaxAcc = set_combine(sets.precast.WS['Black Halo'].Acc, {})
	sets.precast.WS['Black Halo'].Fodder = set_combine(sets.precast.WS['Black Halo'], {})
	
	sets.precast.WS['Judgement'] = sets.precast.WS['Black Halo']
	sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS['Sanguine Blade'], {ring2="Shiva Ring"})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Telos Earring",ear2="Cessance Earring"}
	sets.AccMaxTP = {ear1="Telos Earring",ear2="Regal Earring"}
	
	sets.MaxTP["Requiescat"] = {ear1="Telos Earring",ear2="Regal Earring"}
	sets.AccMaxTP["Requiescat"] = {ear1="Mache Earring +1",ear2="Regal Earring"}
	sets.MaxTP["Savage Blade"] = {ear1="Ishvara Earring",ear2="Regal Earring"}
	sets.AccMaxTP["Savage Blade"] = {ear1="Telos Earring",ear2="Mache Earring +1"}
	sets.MaxTP["Expiacion"] = {ear1="Ishvara Earring",ear2="Regal Earring"}
	sets.AccMaxTP["Expiacion"] = {ear1="Mache Earring +1",ear2="Regal Earring"}
	
	sets.MaxTP["Realmrazer"] = {}
	sets.AccMaxTP["Realmrazer"] = {}
	sets.MaxTP["Black Halo"] = {ear1="Ishvara Earring",ear2="Regal Earring"}
	sets.AccMaxTP["Black Halo"] = {ear1="Telos Earring",ear2="Regal Earring"}

	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

	sets.midcast['Blue Magic'] = set_combine(sets.midcast.FastRecast, {hands="Hashi. Bazu. +1"})

	-- Physical Spells --

	sets.midcast['Blue Magic'].Physical = {main="Naegling",sub="Vampirism",ammo="Mavi Tathlum",
		head="Adhemar Bonnet +1",neck="Caro Necklace",ear1="Telos Earring",ear2="Suppanomimi",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Ilabrat Ring",ring2="Chirich Ring",
		back=gear.wsd_jse_back,waist="Grunfeld Rope",legs="Jhakri Slops +2",feet=gear.herculean.boots.ta}

	sets.midcast['Blue Magic'].Physical.Resistant = set_combine(sets.midcast['Blue Magic'], {sub=gear.colada.stp,ammo="Aurgelmir Orb",head="Jhakri Coronal +2",ear2="Digni. Earring",feet="Jhakri Pigaches +2"})
	
	sets.midcast['Blue Magic'].Physical.Fodder = set_combine(sets.midcast['Blue Magic'].Physical, {})

	sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {head="Dampening Tam",ear2="Digni. Earring",body="Adhemar Jacket +1",hands=gear.adhemar.wrist.path_b})

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

	sets.midcast['Blue Magic'].Magical = {main="Maxentius",sub="Naegling",ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Friomisi Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring",
		back=gear.rosmerta.mab,waist=gear.ElementalObi,legs="Amalric Slops +1",feet="Amalric Nails +1"}
		
	sets.midcast['Blue Magic'].Magical.Proc = sets.midcast.FastRecast
	
	sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
		{hands="Jhakri Cuffs +2",ring2="Stikini Ring",waist="Luminary Sash"})

	sets.midcast['Blue Magic'].Magical.Fodder = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {ring2="Stikini Ring"})
	sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.midcast['Blue Magic'].MagicAccuracy = set_combine(sets.midcast['Blue Magic'].Magical, {
		head="Amalric Coif +1",neck="Mirage Stole +1",ear2="Digni. Earring",
		hands="Aya. Manopolas +2",ring1="Kishar Ring",ring2="Stikini Ring",
		waist="Luminary Sash",legs="Malignance Tights",feet="Jhakri Pigaches +2"
	})

	sets.midcast['Enfeebling Magic'] = {main="Maxentius",sub="Naegling",ammo="Pemphredo Tathlum",
		head="Amalric Coif +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Ayanmo Ring",ring2="Stikini Ring",
		back=gear.rosmerta.mab,waist="Luminary Sash",legs="Jhakri Slops +2",feet="Skaoi Boots"}

	sets.midcast['Dark Magic'] = {mmain="Naegling",sub="Colada",ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Evanescence Ring",ring2="Archon Ring",
		back=gear.rosmerta.mab,waist="Luminary Sash",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

	sets.midcast['Enhancing Magic'] = {main=gear.colada.enhancing,
		head=gear.telchine.cap.enhancing,neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body=gear.telchine.chasuble.enhancing,hands=gear.telchine.gloves.enhancing,ring2="Stikini Ring",
		waist="Olympus Sash",legs=gear.telchine.braconi.enhancing,feet=gear.telchine.pigaches.enhancing}

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1",waist="Gishdubar Sash"})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1"})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {head=gear.taeon.chapeau.phalanx,body=gear.taeon.tabard.phalanx,hands=gear.taeon.gloves.phalanx,legs=gear.taeon.tights.phalanx,feet=gear.taeon.boots.phalanx})

	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})

	sets.midcast['Divine Magic'] = {ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",neck="Incanter's Torque",ear1="Regal Earring",ear2="Digni. Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring2="Stikini Ring",
		back=gear.rosmerta.mab,waist="Luminary Sash",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

	sets.midcast['Elemental Magic'] = {main="Maxentius",sub="Naegling",ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Friomisi Earring",
		body="Jhakri Robe +2",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring",
		back=gear.rosmerta.mab,waist=gear.ElementalObi,legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})

	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Resistant

	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}
	sets.element.Earth = {}
	sets.element.Light = {} --ring2="Weatherspoon Ring"

	sets.midcast.Cure = {ammo="Pemphredo Tathlum",
		head="Carmine Mask +1",neck="Incanter's Torque",ear1="Etiolation Earring",ear2="Mendi. Earring",
		body="Vedic Coat",hands="Telchine Gloves",ring1="Sirona's Ring",ring2="Lebeche Ring",
		back=gear.ElementalCape,waist=gear.ElementalObi,legs="Carmine Cuisses +1",feet="Carmine Greaves +1"}

	-- Breath Spells --

	sets.midcast['Blue Magic'].Breath = set_combine(sets.midcast['Blue Magic'].Magical, {})

	-- Physical Added Effect Spells most notably "Stun" spells --

	sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].Physical, {ammo="Pemphredo Tathlum",
		head="Amalric Coif +1",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Digni. Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Ayanmo Ring",ring2="Stikini Ring",
		back="Cornflower Cape",waist="Eschan Stone",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"})

	sets.midcast['Blue Magic'].Stun.Resistant = set_combine(sets.midcast['Blue Magic'].Stun, {})

	sets.midcast['Blue Magic'].Stun.Fodder = sets.midcast['Blue Magic'].Stun

	-- Other Specific Spells --

	sets.midcast['Blue Magic']['White Wind'] = {ammo="Mavi Tathlum",
		head="Carmine Mask +1",neck="Sanctity Necklace",ear2="Mendi. Earring",
		body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Supershear Ring",ring2="Lebeche Ring",
		back=gear.ElementalCape,waist=gear.ElementalObi,legs="Carmine Cuisses +1",feet="Skaoi Boots"}
					
	sets.midcast['Blue Magic']['Healing Breeze'] = sets.midcast['Blue Magic']['White Wind']

	sets.midcast['Blue Magic'].Healing = set_combine(sets.midcast['Blue Magic']['White Wind'], {})

	sets.midcast['Blue Magic']['Sheep Song'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {head=gear.herculean.helm.TH,feet=gear.herculean.boots.TH})
	
	--Overwrite certain spells with these peices even if the day matches, because of resource inconsistancies.
	sets.NonElementalCure = {back="Solemnity Cape",waist="Luminary Sash"}

	sets.midcast['Blue Magic'].SkillBasedBuff = {main="Iris",sub="Iris",ammo="Mavi Tathlum",
		head="Luhlaza Keffiyeh",neck="Mirage Stole +1",ear2="Loquac. Earring",
		body="Assim. Jubbah +2",hands="Rawhide Gloves",ring2="Stikini Ring",
		back="Cornflower Cape",waist="Witful Belt",legs="Hashishin Tayt +1",feet="Luhlaza Charuqs"}

	sets.midcast['Blue Magic'].Buff = {main="Vampirism",sub=gear.colada.enhancing,ammo="Mavi Tathlum",
		head="Luhlaza Keffiyeh",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Loquac. Earring",
		body="Assim. Jubbah +2",hands="Hashi. Bazu. +1",ring1="Kishar Ring",ring2="Dark Ring",
		back=gear.rosmerta.stp,waist="Witful Belt",legs="Aya. Cosciales +2",feet="Carmine Greaves +1"}

	sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Blue Magic'].Buff, {head="Amalric Coif +1",waist="Gishdubar Sash"})

	sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {head="Amalric Coif +1"})

	-- Sets to return to when not performing an action.

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Gear for learning spells: +skill and AF hands.
	sets.Learning = {hands="Assim. Bazu. +2"}

	-- Idle sets
	sets.idle = {main="Bolelabunga",sub="Medeina Kilij",ammo="Staunch Tathlum",
		head="Rawhide Mask",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
		body="Jhakri Robe +2",hands=gear.herculean.gloves.refresh,ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.rosmerta.stp,waist="Flume Belt +1",legs="Malignance Tights",feet=gear.herculean.boots.refresh
	}

	sets.idle.PDT = set_combine(sets.idle, {head="Malignance Chapeau",legs="Malignance Tights"})

	-- Resting sets
	sets.resting = sets.idle

	-- Defense sets
	sets.defense.PDT = {
		ammo="Staunch Tathlum",
		head="Malignance Chapeau",
		body="Malignance Tabard",hands="Assim. Bazu. +2",ring1="Defending Ring",
		back=gear.rosmerta.stp,legs="Malignance Tights",feet="Ahosi Leggings"
	}

	sets.defense.MDT = {
		head="Malignance Chapeau",neck="Warder's Charm +1",ear2="Eabani Earring",
		body="Malignance Tabard",ring1="Defending Ring",ring2="Purity Ring",
		legs="Malignance Tights",feet="Ahosi Leggings"
	}

	sets.defense.MEVA = set_combine(sets.defense.MDT, {
		ammo="Staunch Tathlum",ear1="Etiolation Earring",hands="Leyline Gloves"
	})

	sets.defense.NukeLock = sets.midcast['Blue Magic'].Magical

	sets.Kiting = {legs="Carmine Cuisses +1"}

	-- Extra Melee sets.  Apply these on top of melee sets.
	sets.Knockback = {}
	sets.MP = {waist="Flume Belt +1",ear1="Ethereal Earring"}
	sets.DWMax = {ear1="Suppanomimi",ear2="Eabani Earring",body="Adhemar Jacket +1",legs="Carmine Cuisses +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {head=gear.herculean.helm.TH,feet=gear.herculean.boots.TH})
	
	-- Weapons sets
	sets.weapons.Sequence = {main="Sequence",sub="Naegling"}
	sets.weapons.NaeglingTP = {main="Naegling",sub=gear.colada.stp}
	sets.weapons.MaxentiusTP = {main="Maxentius",sub=gear.colada.stp}
	sets.weapons.MagicWeapons = {main="Maxentius",sub="Naegling"}
	sets.weapons.Learning = {main=empty,sub=empty}

	-- Engaged sets

	sets.engaged = {
		ammo="Aurgelmir Orb",
		head="Adhemar Bonnet +1",neck="Mirage Stole +1",ear1="Suppanomimi",ear2="Cessance Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar.wrist.path_b,ring1="Petrov Ring",ring2="Epona's Ring",
		back=gear.rosmerta.stp,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean.boots.ta_low_acc
	}
	sets.engaged.HybridDT = set_combine(sets.engaged, {
		head="Malignance Chapeau",legs="Malignance Tights"
	})
	sets.engaged.PDT = set_combine(sets.engaged.HybridDT, {
		ammo="Staunch Tathlum",hands="Assim. Bazu. +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
	})
	sets.engaged.MDT = set_combine(sets.engaged.HybridDT, {
		ring1="Defending Ring",ring2="Purity Ring",feet="Ahosi Leggings"
	})

	sets.engaged.Acc = set_combine(sets.engaged, {
		head="Malignance Chapeau",ring1="Chirich Ring",feet=gear.herculean.boots.ta
	})
	sets.engaged.Acc.HybridDT = set_combine(sets.engaged.HybridDT, {
		ear2="Telos Earring",ring1="Chirich Ring",ring2="Ilabrat Ring",feet=gear.herculean.boots.ta
	})
	sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {ammo="Falcon Eye",ear2="Telos Earring",waist="Grunfeld Rope",feet=gear.herculean.boots.ta})
	sets.engaged.Acc.MDT = set_combine(sets.engaged.MDT, {ammo="Falcon Eye",ear2="Telos Earring",waist="Grunfeld Rope"})

	sets.engaged.MaxAcc = set_combine(sets.engaged.Acc, {
		head="Carmine Mask +1",neck="Lissome Necklace",ear2="Telos Earring",
		waist="Grunfeld Rope",legs="Malignance Tights",feet="Carmine Greaves +1"
	})
	sets.engaged.MaxAcc.HybridDT = set_combine(sets.engaged.Acc.HybridDT, {ammo="Falcon Eye",waist="Grunfeld Rope",feet="Aya. Gambieras +2"})
	sets.engaged.MaxAcc.PDT = set_combine(sets.engaged.Acc.PDT, {})
	sets.engaged.MaxAcc.MDT = set_combine(sets.engaged.Acc.MDT, {})

	sets.engaged.Fodder = set_combine(sets.engaged, {
		ear2="Dedition Earring"
	})
	sets.engaged.Fodder.HybridDT = set_combine(sets.engaged.HybridDT, {ear2="Dedition Earring"})
	sets.engaged.Fodder.PDT = set_combine(sets.engaged.PDT, {ear2="Dedition Earring"})
	sets.engaged.Fodder.MDT = set_combine(sets.engaged.MDT, {ear2="Dedition Earring"})

	sets.Self_Healing = {hands="Buremte Gloves",waist="Gishdubar Sash"}
	sets.Self_Healing_Club = {hands="Buremte Gloves",waist="Gishdubar Sash"}
	sets.Self_Healing_DWClub = {hands="Buremte Gloves",waist="Gishdubar Sash"}
	sets.Healing_Club = {}
	sets.Healing_DWClub = {}
	sets.Cure_Received = {hands="Buremte Gloves",waist="Gishdubar Sash"}
	sets.Self_Refresh = {head="Amalric Coif +1",hands="Buremte Gloves",waist="Gishdubar Sash"}
	sets.MagicBurst = {body="Samnuha Coat",hands="Amalric Gages +1",ring1="Mujin Band",ring2="Locus Ring",feet="Jhakri Pigaches +2"}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	set_macro_page(1, 14)
end

function lockstyle()
	windower.chat.input("/lockstyleset 006")
end

--Job Specific Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not areas.Cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()

				if spell_recasts[980] < spell_latency and not have_trust("Yoran-Oran") then
					windower.chat.input('/ma "Yoran-Oran (UC)" <me>')
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
		{Name='Battery Charge',		Buff='Refresh',			SpellID=662,	When='Idle'},
		{Name='Refresh',			Buff='Refresh',			SpellID=109,	When='Idle'},
		{Name='Nat. Meditation',	Buff='Attack Boost',	SpellID=700,	When='Engaged'},
		--{Name='Mighty Guard',		Buff='Mighty Guard',	SpellID=750,	When='Combat'},
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
		{Name='Diamondhide',		Buff='Stoneskin',		SpellID=632,	Reapply=false},
		{Name='Occultation',		Buff='Blink',			SpellID=679,	Reapply=false},
		{Name='Blink',				Buff='Blink',			SpellID=53,		Reapply=false},
		--{Name='Carcharian Verve',	Buff='Aquaveil',		SpellID=745,	Reapply=false},
		{Name='Aquaveil', 			Buff='Aquaveil',		SpellID=55,		Reapply=false},
		{Name='Cocoon',				Buff='Defense Boost',	SpellID=547,	Reapply=false},
		{Name='Memento Mori',		Buff='Magic Atk. Boost',SpellID=538,	Reapply=false},
	},
}