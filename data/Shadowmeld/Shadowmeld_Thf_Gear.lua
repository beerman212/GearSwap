-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal','Acc','FullAcc','Fodder')
	state.HybridMode:options('Normal','PDT')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Match','Normal','Acc','FullAcc','Fodder')
	state.IdleMode:options('Normal', 'Sphere')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('AeneasSari','AeneasKaja','AeneasCento','TauretSari')

	state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Suppa','DWEarrings','DWMax'}
	state.AmbushMode = M(false, 'Ambush Mode')

	gear.dex_stp_jse_back = {name = "Toutatis's Cape", augments = {'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}}
	gear.dex_wsd_jse_back = {name = "Toutatis's Cape", augments = {'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}
	gear.dex_crit_jse_back = {name = "Toutatis's Cape", augments = {'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}}

	-- Additional local binds
	send_command('bind ^` input /ja "Flee" <me>')
	send_command('bind !` input /ra <t>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f10 gs c toggle AmbushMode')
	send_command('bind ^backspace gs c weapons Throwing;gs c update')
	send_command('bind !backspace input /ja "Hide" <me>')
	send_command('bind !r gs c weapons MagicWeapons;gs c update')
	send_command('bind ^\\\\ input /ja "Despoil" <t>')
	send_command('bind !\\\\ input /ja "Mug" <t>')

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Special sets (required by rules)
	--------------------------------------

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {hands="Plunderer's Armlets +1",feet="Skulk. Poulaines +1"})
	sets.ExtraRegen = {}
	sets.Kiting = {feet="Pillager's Poulaines"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}

	sets.buff['Sneak Attack'] = {}
	sets.buff['Trick Attack'] = {}

	-- Extra Melee sets.  Apply these on top of melee sets.
	sets.Knockback = {}
	sets.Suppa = {}
	sets.DWEarrings = {}
	sets.DWMax = {ear1="Suppanomimi",body="Adhemar Jacket +1",hands="Floral Gauntlets",waist="Patentia Sash",feet="Rawhide Boots"}
	sets.Ambush = {}
	
	-- Weapons sets
	sets.weapons.AeneasSari = {main="Aeneas",sub="Taming Sari"}
	sets.weapons.AeneasKaja = {main="Aeneas",sub="Kaja Knife"}
	sets.weapons.AeneasCento = {main="Aeneas",sub="Fusetto +1"}
	sets.weapons.TauretSari = {main="Kaja Knife",sub="Taming Sari"}
	
	-- Actions we want to use to tag TH.
	sets.precast.Step = {ammo="Yamarang",
		head="Pill. Bonnet +2",neck="Sanctity Necklace",ear1="Telos Earring",ear2="Digni. Earring",
		body="Pillager's Vest +2",hands=gear.adhemar_wrist_path_a,ring1="Ramuh Ring",ring2="Chirich Ring",
		back=gear.dex_stp_jse_back,waist="Grunfeld Rope",legs="Pill. Culottes +2",feet=gear.herculean_boots_ta}

	sets.precast.JA['Violent Flourish'] = sets.precast.Step
		
	sets.precast.JA['Animated Flourish'] = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Collaborator'] = {head = "Skulker's Bonnet +1"}
	sets.precast.JA['Accomplice'] = {head = "Skulker's Bonnet +1"}
	sets.precast.JA['Flee'] = {feet="Pillager's Poulaines"}
	sets.precast.JA['Hide'] = {body="Pillager's Vest +2"}
	sets.precast.JA['Conspirator'] = {} --body="Skulker's Vest"
	sets.precast.JA['Steal'] = {hands="Pill. Armlets +1"}
	sets.precast.JA['Mug'] = {}
	sets.precast.JA['Despoil'] = {legs="Skulker's Culottes",feet="Skulk. Poulaines"}
	sets.precast.JA['Perfect Dodge'] = {hands="Plun. Armlets +1"}
	sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}

	sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
	sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Yamarang",
		head="Mummu Bonnet +2",neck="Loricate Torque +1",
		ring1="Defending Ring",ring2=gear.dark_ring_dt,
		feet="Rawhide Boots"}

	sets.Self_Waltz = {head="Mummu Bonnet +2"}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}


	-- Fast cast sets for spells
	sets.precast.FC = {ammo="Impatiens",
		head=gear.herculean_helm_magical,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring2="Lebeche Ring",
		legs="Limbo Trousers"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


	-- Ranged snapshot gear
	sets.precast.RA = {--[[range="Comet Tail"]]}


	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Seeth. Bomblet +1",
		head="Pill. Bonnet +2",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Ishvara Earring",
		body=gear.herculean_vest_dexwsd,hands="Meg. Gloves +2",ring1="Epaminondas's Ring",ring2="Ilabrat Ring",
		back=gear.dex_wsd_jse_back,waist="Fotia Belt",legs="Lustr. Subligar +1",feet="Lustra. Leggings +1"
	}
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {body="Adhemar Jacket +1",})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {body="Adhemar Jacket +1",legs="Pill. Culottes +2",feet="Meg. Chausses +2"})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS["Rudra's Storm"] = {
		ammo="Seeth. Bomblet +1",
		head="Pill. Bonnet +2",neck="Caro Necklace",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body=gear.herculean_vest_dexwsd,hands="Meg. Gloves +2",ring1="Epaminondas's Ring",ring2="Ilabrat Ring",
		back=gear.dex_wsd_jse_back,waist="Grunfeld Rope",legs="Lustr. Subligar +1",feet="Lustra.Leggings +1"
	}
	
	sets.precast.WS["Rudra's Storm"].Acc = set_combine(ets.precast.WS["Rudra's Storm"], {ear1="Mache Earring +1"})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS["Rudra's Storm"].Acc, {body="Pillager's Vest +2",legs="Pill. Culottes +2"})
	sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {ammo="Yetshila",body="Meg. Cuirie +2",legs="Pill. Culottes +2"})
	sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {ammo="Yetshila",body="Meg. Cuirie +2",legs="Pill. Culottes +2"})
	sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {ammo="Yetshila",body="Meg. Cuirie +2",legs="Pill. Culottes +2"})

	sets.precast.WS["Mandalic Stab"] = sets.precast.WS["Rudra's Storm"]

	sets.precast.WS["Shark Bite"] = {
		ammo="Seeth. Bomblet +1",
		head="Pill. Bonnet +2",neck="Caro Necklace",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body=gear.herculean_vest_dexwsd,hands="Meg. Gloves +2",ring1="Epaminondas's Ring",ring2="Ilabrat Ring",
		back=gear.dex_wsd_jse_back,waist="Grunfeld Rope",legs="Lustr. Subligar +1",feet="Lustra.Leggings +1"
	}
	
	sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS["Shark Bite"], {})
	sets.precast.WS["Shark Bite"].FullAcc = set_combine(sets.precast.WS["Shark Bite"].Acc, {})
	sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS["Shark Bite"], {})
	sets.precast.WS["Shark Bite"].SA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {ammo="Yetshila",body="Meg. Cuirie +2",legs="Pill. Culottes +2"})
	sets.precast.WS["Shark Bite"].TA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {ammo="Yetshila",body="Meg. Cuirie +2",legs="Pill. Culottes +2"})
	sets.precast.WS["Shark Bite"].SATA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {ammo="Yetshila",body="Meg. Cuirie +2",legs="Pill. Culottes +2"})

	--sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Yetshila",head="Adhemar Bonnet +1",ear2="Moonshade Earring",body="Abnoba Kaftan",hands="Mummu Wrists +2",ring1="Hetairoi Ring",legs="Pill. Culottes +2",feet="Mummu Gamash. +2"})
	sets.precast.WS['Evisceration'] = {
		ammo="Yetshila",
		head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Mache Earring +1",ear2="Moonshade Earring",
		body="Abnoba Kaftan",hands=gear.adhemar_wrist_path_a,ring1="Hetairoi Ring",ring2="Ilabrat Ring",
		back=gear.dex_crit_jse_back,waist="Fotia Belt",legs="Pill. Culottes +2",feet="Mummu Gamash. +2"
	}
	
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {body="Meg. Cuirie +2"})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS['Evisceration'].Acc, {ammo="Seeth. Bomblet +1",ear2="Mache Earring +1",body="Pillager's Vest +2",ring1="Moonbeam Ring"})
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {})
	sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})
	sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})
	sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})

	--sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {head="Adhemar Bonnet +1",ear2="Telos Earring",body="Adhemar Jacket +1",hands=gear.adhemar_wrist_path_a,ring1="Mummu Ring",back=gear.dex_stp_jse_back,legs="Meg. Chausses +2",feet="Mummu Gamash. +2"})
	sets.precast.WS['Exenterator'] = {
		ammo="Seeth. Bomblet +1",
		head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Telos Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar_wrist_path_a,ring1="Gere Ring",ring2="Epona's Ring",
		back=gear.dex_stp_jse_back,waist="Fotia Gorget",legs="Meg. Chausses +2",feet="Mummu Gamash. +2"
	}
	
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {})
	sets.precast.WS['Exenterator'].FullAcc = set_combine(sets.precast.WS['Exenterator'].Acc, {})
	sets.precast.WS['Exenterator'].Fodder = set_combine(sets.precast.WS['Exenterator'], {})
	sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Fodder, {})
	sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Fodder, {})
	sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].Fodder, {})

	sets.precast.WS['Last Stand'] = {
		head="Mummu Bonnet +2",neck="Fotia Gorget",ear1="Enervating Earring",ear2="Telos Earring",
		body="Mummu Jacket +2",hands="Mummu Wrists +2",ring1="Dingir Ring",ring2="Ilabrat Ring",
		back=gear.dex_wsd_jse_back,waist="Fotia Belt",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"}

	sets.precast.WS['Aeolian Edge'] = {
		ammo="Seeth. Bomblet +1",
		head=gear.herculean_helm_magical,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring",
		back=gear.dex_wsd_jse_back,waist="Eschan Stone",legs=gear.herculean_trousers_magical,feet=gear.herculean_boots_magical
	}

	sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Sherida Earring",ear2="Ishvara Earring"}
	sets.AccMaxTP = {ear1="Sherida Earring",ear2="Telos Earring"}
	sets.MaxTP["Rudra's Storm"] = {ear1="Ishvara Earring",ear2="Mache Earring +1"}
	sets.AccMaxTP["Rudra's Storm"] = {ear1={name="Mache Earring +1",order=1},ear2={name="Mache Earring +1", order=15}}

	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Horde Lullaby'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

	-- Ranged gear

	sets.midcast.RA = {
		head="Mummu Bonnet +2",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
		body="Mummu Jacket +2",hands="Mummu Wrists +2",ring1="Dingir Ring",ring2="Ilabrat Ring",
		back=gear.dex_stp_jse_back,waist="Yemaya Belt",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"}

	sets.midcast.RA.Acc = {
		head="Mummu Bonnet +2",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
		body="Mummu Jacket +2",hands="Mummu Wrists +2",ring1="Dingir Ring",ring2="Ilabrat Ring",
		back=gear.dex_stp_jse_back,waist="Yemaya Belt",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"}

	--------------------------------------
	-- Idle/resting/defense sets
	--------------------------------------

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle = {
		ammo="Staunch Tathlum",
		head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Eabani Earring",
		body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Purity Ring",
		back=gear.dex_stp_jse_back,waist="Flume Belt",legs="Mummu Kecks +2",feet="Meg. Jam. +2"
	}

	sets.idle.Sphere = set_combine(sets.idle, {})

	sets.idle.Weak = set_combine(sets.idle, {})

	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Resting sets
	sets.resting = sets.idle

	-- Defense sets

	sets.defense.PDT = {ammo="Staunch Tathlum",
	head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
	body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Purity Ring",
	back=gear.dex_stp_jse_back,waist="Flume Belt",legs="Mummu Kecks +2",feet="Meg. Jam. +2"}

	sets.defense.MDT = {ammo="Staunch Tathlum",
	head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
	body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Purity Ring",
	back=gear.dex_stp_jse_back,waist="Flume Belt",legs="Mummu Kecks +2",feet="Meg. Jam. +2"}

	sets.defense.MEVA = {ammo="Staunch Tathlum",
	head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
	body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Purity Ring",
	back=gear.dex_stp_jse_back,waist="Flume Belt",legs="Mummu Kecks +2",feet="Meg. Jam. +2"}


	--------------------------------------
	-- Melee sets  
	--------------------------------------

	-- Normal melee group
	sets.engaged = {
		ammo="Yamarang",
		head="Adhemar Bonnet +1",neck="Anu Torque",ear1="Sherida Earring",ear2="Telos Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar_wrist_path_a,ring1="Gere Ring",ring2="Epona's Ring",
		back=gear.dex_stp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_boots_ta
	}

	sets.engaged.Acc = set_combine(sets.engaged, {ring1="Chirich Ring",ring2="Moonbeam Ring"})

	sets.engaged.FullAcc = set_combine(sets.engaged.Acc, {head="Pill. Bonnet +2",neck="Lissome Necklace",ring1="Chirich Ring",ring2="Moonbeam Ring"})

	sets.engaged.Fodder = set_combine(sets.engaged, {})

	sets.engaged.PDT = set_combine(sets.engaged, {ring1="Defending Ring",ring2="Moonbeam Ring",back=gear.dex_stp_jse_back})

	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {ring1="Defending Ring",ring2="Moonbeam Ring",back=gear.dex_stp_jse_back})

	sets.engaged.FullAcc.PDT = set_combine(sets.engaged.FullAcc, {ring1="Defending Ring",ring2="Moonbeam Ring",back=gear.dex_stp_jse_back})

	sets.engaged.Fodder.PDT = set_combine(sets.engaged.Fodder, {ring1="Defending Ring",ring2="Moonbeam Ring",back=gear.dex_stp_jse_back})
		
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 1)
    else
        set_macro_page(1, 1)
    end
end