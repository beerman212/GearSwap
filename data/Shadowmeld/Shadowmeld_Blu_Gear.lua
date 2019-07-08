	function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Fodder','Normal','MinAcc','SomeAcc','Acc','HighAcc','FullAcc')
	state.HybridMode:options('Normal','DTLite','PDT','MDT')
	state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','HighAcc','FullAcc','Fodder')
	state.CastingMode:options('Normal','Resistant','Fodder','Proc')
	state.IdleMode:options('Normal','Sphere','PDT','DTHippo')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Sequence','NaeglingTP','MaxtentiusTP','MagicWeapons','Learning','None')

	state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}

	gear.stp_jse_back = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
	gear.crit_jse_back = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
	gear.wsd_jse_back = {name="Rosmerta's Cape",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	gear.mab_jse_back = {name="Rosmerta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.mnd_atk_jse_cape = {name="Rosmerta's Cape",augments={}}
	
	gear.enhancing_duration_colada = {name="Colada", augments={'Enh. Mag. eff. dur. +4','MND+2','Mag. Acc.+15','"Mag.Atk.Bns."+18',}}
	gear.stp_colada = {name="Colada", augments={'"Store TP"+5','DEX+6','Accuracy+18','Attack+8','DMG:+12',}}

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
	send_command('bind @q gs c weapons MaccWeapons;gs c update')
	send_command('bind ^q gs c weapons Almace;gs c update')
	send_command('bind !q gs c weapons HybridWeapons;gs c update')

	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	sets.buff['Burst Affinity'] = {}
	sets.buff['Chain Affinity'] = {}
	sets.buff.Convergence = {}
	sets.buff.Diffusion = {}
	sets.buff.Enchainment = {}
	sets.buff.Efflux = {back=gear.stp_jse_back}
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

	sets.precast.Step = {ammo="Ginsen",
		head="Dampening Tam",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Telos Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar_wrist_path_a,ring1="Chirich Ring",ring2="Ayanmo Ring",
		back=gear.stp_jse_back,waist="Grunfeld Rope",legs="Carmine Cuisses +1",feet=gear.herculean_boots_ta}

	sets.precast.Flourish1 = {ammo="Ginsen",
		head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Digni. Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Stikini Ring",ring2="Etana Ring",
		back=gear.mab_jse_back,waist="Luminary Sash",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

	-- Fast cast sets for spells

	sets.precast.FC = {main="Colada",sub="Vampirism",ammo="Impatiens",
		head="Amalric Coif +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
		back="Perimede Cape",waist="Witful Belt",legs="Aya. Cosciales +2",feet="Carmine Greaves +1"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan +1"})


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Ginsen",
		head=gear.herculean_helm_strwsd,neck="Fotia Gorget",ear1="Telos Earring",ear2="Cessance Earring",
		body=gear.herculean_vest_dexwsd,hands="Jhakri Cuffs +2",ring1="Epaminondas's Ring",ring2="Shukuyu Ring",
		back=gear.wsd_jse_back,waist="Fotia Belt",legs=gear.herculean_trousers_strwsd,feet="Jhakri Pigaches +2"}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {body="Adhemar Jacket +1",legs="Carmine Cuisses +1"})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS.Acc, {head="Carmine Mask +1"})
	sets.precast.WS.Fodder =  set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = {
		ammo="Ginsen",
		head="Jhakri Coronal +2",neck="Fotial Gorget",ear1="Moonshade Earring",ear2="Regal Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Ilabrat Ring",ring2="Epona's Ring",
		back=gear.mnd_atk_jse_cape,waist="Fotia Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"
	}
	
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {ring2="Chirich Ring"})
	sets.precast.WS['Requiescat'].FullAcc = set_combine(sets.precast.WS['Requiescat'].Acc, {ear1="Telos Earring"})
	sets.precast.WS['Requiescat'].Fodder = set_combine(sets.precast.WS['Requiescat'], {})

	sets.precast.WS['Chant du Cygne'] = {
		ammo="Jakukik Feather",
		head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Mache Earring +1",ear2="Mache Earring +1",
		body="Abnoba Kaftan",hands=gear.adhemar_wrist_path_a,ring1="Ilabrat Ring",ring2="Hetairoi Ring",
		back=gear.crit_jse_back,waist="Fotia Gorget",legs="Samnuha Tights",feet="Aya. Gambieras +2"
	}
	
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {body="Adhemar Jacket +1"})
	sets.precast.WS['Chant du Cygne'].FullAcc = set_combine(sets.precast.WS['Chant du Cygne'].Acc, {head="Carmine Mask +1",ring2="Chirich Ring",feet="Carmine Greaves +1"})
	sets.precast.WS['Chant du Cygne'].Fodder = set_combine(sets.precast.WS['Chant du Cygne'], {})

	sets.precast.WS['Savage Blade'] = {
		ammo="Ginsen",
		head=gear.herculean_helm_strwsd,neck="Caro Necklace",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body=gear.herculean_vest_dexwsd,hands="Jhakri Cuffs +2",ring1="Epaminondas's Ring",ring2="Shukuyu Ring",
		back=gear.wsd_jse_back,waist="Grunfeld Rope",legs=gear.herculean_trousers_strwsd,feet="Jhakri Pigaches +2"
	}

	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {})
	sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS['Savage Blade'].Acc, {})
	sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS['Savage Blade'], {})

	sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS['Chant du Cygne'], {})
	sets.precast.WS['Vorpal Blade'].Acc = set_combine(sets.precast.WS['Chant du Cygne'].Acc, {})
	sets.precast.WS['Vorpal Blade'].FullAcc = set_combine(sets.precast.WS['Chant du Cygne'].FullAcc, {})
	sets.precast.WS['Vorpal Blade'].Fodder = set_combine(sets.precast.WS['Vorpal Blade'], {})

	sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS['Savage Blade'], {})
	sets.precast.WS['Expiacion'].Acc = set_combine(sets.precast.WS['Savage Blade'].Acc, {})
	sets.precast.WS['Expiacion'].FullAcc = set_combine(sets.precast.WS['Savage Blade'].FullAcc, {})
	sets.precast.WS['Expiacion'].Fodder = set_combine(sets.precast.WS['Expiacion'], {})

	sets.precast.WS['Sanguine Blade'] = {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Friomisi Earring",
		body="Amalric Doublet +1",hands="Jhakri Cuffs +2",ring1="Shiva Ring +1",ring2="Archon Ring",
		back=gear.mab_jse_back,waist="Eschan Stone",legs="Amalric Slops +1",feet="Amalric Nails +1"
	}

	sets.precast.WS['Realmrazer'] = sets.precast.WS['Requiescat']
	sets.precast.WS['Black Halo'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Judgement'] = sets.precast.WS['Black Halo']
	sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS['Sanguine Blade'], {ring2="Epaminondas's Ring"})

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

	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

	sets.midcast['Blue Magic'] = {}

	-- Physical Spells --

	sets.midcast['Blue Magic'].Physical = {main="Kaja Sword",sub="Vampirism",ammo="Mavi Tathlum",
		head="Adhemar Bonnet +1",neck="Caro Necklace",ear1="Telos Earring",ear2="Suppanomimi",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Ilabrat Ring",ring2="Ramuh Ring",
		back=gear.wsd_jse_back,waist="Grunfeld Rope",legs="Jhakri Slops +2",feet=gear.herculean_boots_ta}

	sets.midcast['Blue Magic'].Physical.Resistant = set_combine(sets.midcast['Blue Magic'], {sub=gear.stp_colada,ammo="Ginsen",head="Jhakri Coronal +2",ear2="Digni. Earring",feet="Jhakri Pigaches +2"})
	
	sets.midcast['Blue Magic'].Physical.Fodder = set_combine(sets.midcast['Blue Magic'].Physical, {})

	sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {head="Dampening Tam",ear2="Digni. Earring",body="Adhemar Jacket +1",hands=gear.adhemar_wrist_path_a})

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

	sets.midcast['Blue Magic'].Magical = {main="Kaja Rod",sub="Kaja Sword",ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Friomisi Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring",
		back=gear.mab_jse_back,waist=gear.ElementalObi,legs="Amalric Slops +1",feet="Amalric Nails +1"}
		
	sets.midcast['Blue Magic'].Magical.Proc = sets.midcast.FastRecast
	
	sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
		{hands="Jhakri Cuffs +2",ring2="Stikini Ring",waist="Luminary Sash"})

	sets.midcast['Blue Magic'].Magical.Fodder = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {ring2="Stikini Ring"})
	sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.midcast['Blue Magic'].MagicAccuracy = set_combine(sets.midcast['Blue Magic'].Magical, {sub="Sequence",ring2="Stikini Ring",waist="Luminary Sash"})

	sets.midcast['Enfeebling Magic'] = {main="Kaja Rod",sub="Kaja Sword",ammo="Pemphredo Tathlum",
		head="Amalric Coif +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Ayanmo Ring",ring2="Stikini Ring",
		back=gear.mab_jse_back,waist="Luminary Sash",legs="Jhakri Slops +2",feet="Skaoi Boots"}

	sets.midcast['Dark Magic'] = {mmain="Kaja Sword",sub="Colada",ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Evanescense Ring",ring2="Archon Ring",
		back=gear.mab_jse_back,waist="Luminary Sash",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

	sets.midcast['Enhancing Magic'] = {main=gear.enhancing_duration_colada,
		head=gear.telchine_cap_enhancing_duration,neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body=gear.telchine_chas_enhancing_duration,hands=gear.telchine_gloves_enhancing_duration,ring2="Stikini Ring",
		waist="Olympus Sash",legs=gear.telchine_braconi_enhancing_duration,feet=gear.telchine_pigaches_enhancing_duration}

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1",waist="Gishdubar Sash"})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1"})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})

	sets.midcast['Divine Magic'] = {ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",neck="Incanter's Torque",ear1="Regal Earring",ear2="Digni. Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring2="Stikini Ring",
		back=gear.mab_jse_back,waist="Luminary Sash",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

	sets.midcast['Elemental Magic'] = {main="Kaja Rod",sub="Kaja Sword",ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Friomisi Earring",
		body="Jhakri Robe +2",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring",
		back=gear.mab_jse_back,waist=gear.ElementalObi,legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

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
		body="Vedic Coat",hands="Telchine Gloves",ring1="Supershear Ring",ring2="Lebeche Ring",
		back=gear.ElementalCape,waist=gear.ElementalObi,legs="Carmine Cuisses +1",feet="Skaoi Boots"}
					
	sets.midcast['Blue Magic']['Healing Breeze'] = sets.midcast['Blue Magic']['White Wind']

	sets.midcast['Blue Magic'].Healing = set_combine(sets.midcast['Blue Magic']['White Wind'], {})

	--Overwrite certain spells with these peices even if the day matches, because of resource inconsistancies.
	sets.NonElementalCure = {back="Tempered Cape +1",waist="Luminary Sash"}

	sets.midcast['Blue Magic'].SkillBasedBuff = {main="Iris",sub="Iris",ammo="Mavi Tathlum",
		head="Mirage Keffiyeh +2",neck="Incanter's Torque",ear2="Loquac. Earring",
		body="Assim. Jubbah +1",hands="Rawhide Gloves",ring2="Stikini Ring",
		back="Cornflower Cape",waist="Witful Belt",legs="Hashishin Tayt +1",feet="Luhlaza Charuqs +1"}

	sets.midcast['Blue Magic'].Buff = {main="Vampirism",sub=gear.enhancing_duration_colada,ammo="Mavi Tathlum",
		head="Luh. Keffiyeh +1",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Loquac. Earring",
		body="Assim. Jubbah +3",hands="Hashi. Bazu. +1",ring1="Kishar Ring",ring2="Dark Ring",
		back="Aurist's Cape +1",waist="Witful Belt",legs="Lengo Pants",feet="Carmine Greaves +1"}

	sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Blue Magic'].Buff, {head="Amalric Coif +1",waist="Gishdubar Sash"})

	sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {head="Amalric Coif +1"})

	-- Sets to return to when not performing an action.

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Gear for learning spells: +skill and AF hands.
	sets.Learning = {hands="Magus Bazubands"}

	-- Idle sets
	sets.idle = {main="Bolelabunga",ammo="Staunch Tathlum",
		head="Rawhide Mask",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
		body="Jhakri Robe +2",hands="Aya. Manopolas +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.stp_jse_back,waist="Flume Belt",legs="Aya. Cosciales +2",feet="Ahosi Leggings"}

	sets.idle.PDT = set_combine(sets.idle, {head="Aya. Zucchetto +2",body="Ayanmo Corazza +2"})

	-- Resting sets
	sets.resting = sets.idle

	-- Defense sets
	sets.defense.PDT = {ammo="Staunch Tathlum",
		head="Aya. Zucchetto +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		waist="Flume Belt",legs="Aya. Cosciales +2",feet="Ahosi Leggings"}

	sets.defense.MDT = set_combine(sets.defense.PDT, {})

	sets.defense.MEVA = set_combine(sets.defense.MDT, {})

	sets.defense.NukeLock = sets.midcast['Blue Magic'].Magical

	sets.Kiting = {legs="Carmine Cuisses +1"}

	-- Extra Melee sets.  Apply these on top of melee sets.
	sets.Knockback = {}
	sets.MP = {waist="Flume Belt",ear1="Ethereal Earring"}
	sets.MP_Knockback = {}
	sets.SuppaBrutal = {}
	sets.DWEarrings = {}
	sets.DWMax = {ear1="Suppanomimi Earring",ear2="Eabani Earring",body="Adhemar Jacket +1",legs="Carmine Cuisses +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Assault = {ring1="Balrahn's Ring"}
	
	-- Weapons sets
	sets.weapons.Sequence = {main="Sequence",sub=gear.stp_colada}
	sets.weapons.NaeglingTP = {main="Kaja Sword",sub=gear.stp_colada}
	sets.weapons.MaxtentiusTP = {main="Kaja Rod",sub="gear.stp_colada}
	sets.weapons.MagicWeapons = {main="Kaja Rod",sub="Kaja Sword"}
	sets.weapons.Learning = {main=empty,sub=empty}

	-- Engaged sets

	sets.engaged = {ammo="Ginsen",
		head="Adhemar Bonnet +1",neck="Anu Torque",ear1="Telos Earring",ear2="Suppanomimi",
		body="Adhemar Jacket +1",hands=gear.adhemar_wrist_path_a,ring1="Petrov Ring",ring2="Epona's Ring",
		back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_boots_ta}

	sets.engaged.Acc = set_combine(sets.engaged, {head="Dampening Tam",ring1="Chirich Ring"})

	sets.engaged.FullAcc = set_combine(sets.engaged.Acc, {head="Carmine Mask +1",neck="Lissome Necklace",ear2="Digni. Earring",waist="Grunfeld Rope",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"})

	sets.engaged.Fodder = set_combine(sets.engaged, {})

	sets.engaged.DTLite = set_combine(sets.engaged, {neck="Loricate Torque +1",ring1="Defending Ring",ring2=gear.dark_ring_dt,waist="Flume Belt"})

	sets.engaged.PDT = set_combine(sets.engaged.DTLite, {ammo="Staunch Tathlum",head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring2="Gelatinous Ring +1",
		legs="Carmine Cuisses +1",feet="Ahosi Leggings"})

	sets.engaged.MDT = set_combine(sets.engaged, {ammo="Staunch Tathlum",
		head="Aya. Zucchetto +2",ear1="Etiolation Earring",ear2="Eabani Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring2="Purity Ring",
		waist="Flume Belt",legs="Carmine Cuisses +1",feet="Ahosi Leggings"})

	sets.engaged.Acc.DTLite = set_combine(sets.engaged.Acc, {neck="Loricate Torque +1",ring1="Defending Ring",ring2=gear.dark_ring_dt,waist="Flume Belt"})

	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {ammo="Staunch Tathlum",head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring2="Gelatinous Ring +1",
		legs="Carmine Cuisses +1",feet="Ahosi Leggings"})

	sets.engaged.Acc.MDT = set_combine(sets.engaged.Acc, {ammo="Staunch Tathlum",ear1="Etiolation Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring2="Purity Ring",
		waist="Flume Belt",legs="Carmine Cuisses +1",feet="Ahosi Leggings"})

	sets.engaged.FullAcc.DTLite = set_combine(sets.engaged.FullAcc, {neck="Loricate Torque +1",ring1="Defending Ring",ring2=gear.dark_ring_dt,waist="Flume Belt"})

	sets.engaged.FullAcc.PDT = set_combine(sets.engaged.FullAcc, {ammo="Staunch Tathlum",head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring2="Gelatinous Ring +1",
		legs="Carmine Cuisses +1",feet="Ahosi Leggings"})

	sets.engaged.FullAcc.MDT = set_combine(sets.engaged.FullAcc, {ammo="Staunch Tathlum",ear1="Etiolation Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring2="Purity Ring",
		legs="Carmine Cuisses +1",feet="Ahosi Leggings"})

	sets.engaged.Fodder.DTLite = set_combine(sets.engaged.Fodder, {neck="Loricate Torque +1",ring1="Defending Ring",ring2=gear.dark_ring_dt,waist="Flume Belt"})

	sets.engaged.Fodder.PDT = set_combine(sets.engaged.Fodder, {ammo="Staunch Tathlum",head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring2="Gelatinous Ring +1",
		legs="Carmine Cuisses +1",feet="Ahosi Leggings"})

	sets.engaged.Fodder.MDT = set_combine(sets.engaged.Fodder, {})

	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Self_Healing_Club = {waist="Gishdubar Sash"}
	sets.Self_Healing_DWClub = {waist="Gishdubar Sash"}
	sets.Healing_Club = {}
	sets.Healing_DWClub = {}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	sets.MagicBurst = {body="Samnuha Coat",hands="Amalric Gages +1",ring1="Mujin Band",ring2="Locus Ring",feet="Jhakri Pigaches +2"}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	set_macro_page(1, 14)
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

buff_spell_lists.Cleave = {
	{Name='Erratic Flutter',	Buff='Haste',			SpellID=710,	Reapply=false},
	{Name='Battery Charge',		Buff='Refresh',			SpellID=662,	Reapply=false},
	{Name='Refresh',			Buff='Refresh',			SpellID=109,	Reapply=false},
	{Name='Phalanx',			Buff='Phalanx',			SpellID=106,	Reapply=false},
	{Name='Barrier Tusk',		Buff='Phalanx',			SpellID=685,	Reapply=false},
	{Name='Stoneskin',			Buff='Stoneskin',		SpellID=54,		Reapply=false},
	{Name='Diamondhide',		Buff='Stoneskin',		SpellID=632,	Reapply=false},
	{Name='Occultation',		Buff='Blink',			SpellID=679,	Reapply=false},
	{Name='Blink',				Buff='Blink',			SpellID=53,		Reapply=false},
	{Name='Carcharian Verve',	Buff='Aquaveil',		SpellID=745,	Reapply=false},
	{Name='Aquaveil', 			Buff='Aquaveil',		SpellID=55,		Reapply=false},
	{Name='Memento Mori',		Buff='Magic Atk. Boost',SpellID=538,	Reapply=false},
}