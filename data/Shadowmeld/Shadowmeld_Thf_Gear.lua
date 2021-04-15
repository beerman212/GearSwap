-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal','Acc','MaxAcc')
	state.HybridMode:options('Normal','HybridDT','Crit')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Match','Normal','Acc','MaxAcc')
	state.IdleMode:options('Normal', 'Sphere')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('TauretSari','AeneasSari')

	state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.AmbushMode = M(false, 'Ambush Mode')

	gear.toutatis = {}
	gear.toutatis.stp = {name = "Toutatis's Cape", augments = {'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}}
	gear.toutatis.wsd = {name = "Toutatis's Cape", augments = {'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}
	gear.toutatis.crit = {name = "Toutatis's Cape", augments = {'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}}

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

	organizer_items = {
		"Remedy",
		"Holy Water",
		"Panacea",
		"Sublime Sushi",
		"Red Curry Bun",
		"Grape Daifuku"
	}

	select_default_macro_book()
	--lockstyle:schedule(5)
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Special sets (required by rules)
	--------------------------------------

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {head=gear.herculean.helm.TH,hands="Plun. Armlets +1",feet="Skulk. Poulaines +1"})
	sets.ExtraRegen = {}
	sets.Kiting = {feet="Pill. Poulaines +1"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}

	sets.buff['Sneak Attack'] = {}
	sets.buff['Trick Attack'] = {}

	-- Extra Melee sets.  Apply these on top of melee sets.
	sets.Knockback = {}
	sets.Suppa = {}
	sets.DWEarrings = {}
	sets.DWMax = {ear1="Suppanomimi",body="Adhemar Jacket +1",hands="Floral Gauntlets",feet="Rawhide Boots"}
	sets.Ambush = {body="Plunderer's Vest +3"}
	
	-- Weapons sets
	sets.weapons.AeneasSari = {main="Aeneas",sub="Taming Sari"}
	sets.weapons.AeneasKaja = {main="Aeneas",sub="Tauret"}
	sets.weapons.AeneasCento = {main="Aeneas",sub="Fusetto +1"}
	sets.weapons.TauretSari = {main="Tauret",sub="Taming Sari"}
	
	-- Actions we want to use to tag TH.
	sets.precast.Step = set_combine(sets.TreasureHunter, {
		ammo="Yamarang",
		neck="Sanctity Necklace",ear1="Telos Earring",ear2="Mache Earring +1",
		body="Pillager's Vest +2",ring1="Gere Ring",ring2="Chirich Ring",
		back=gear.toutatis.stp,legs="Pill. Culottes +2"
	})

	sets.precast.JA['Violent Flourish'] = sets.precast.Step
		
	sets.precast.JA['Animated Flourish'] = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Collaborator'] = {head = "Skulker's Bonnet +1"}
	sets.precast.JA['Accomplice'] = {head = "Skulker's Bonnet +1"}
	sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +1"}
	sets.precast.JA['Hide'] = {body="Pillager's Vest +2"}
	sets.precast.JA['Conspirator'] = {body="Skulker's Vest +1"}
	sets.precast.JA['Steal'] = {head="Plun. Bonnet",hands="Pill. Armlets +1"}
	sets.precast.JA['Mug'] = {
		ammo="Jukukik Feather",
		head="Plun. Bonnet",neck="Caro Necklace",ear1="Mache Earring +1",ear2="Mache Earring +1",
		body="Plunderer's Vest +3",hands="Mummu Wrists +2",ring1="Ilabrat Ring",ring2="Mummu Ring",
		back=gear.toutatis.wsd,waist="Grunfeld Rope",legs="Samnuha Tights",feet="Mummu Gamash. +2"
	}
	sets.precast.JA['Despoil'] = {legs="Skulker's Culottes",feet="Skulk. Poulaines +1"}
	sets.precast.JA['Perfect Dodge'] = {hands="Plun. Armlets +1"}
	sets.precast.JA['Feint'] = {legs="Plun. Culottes"}

	sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
	sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Yamarang",
		head="Mummu Bonnet +2",neck="Loricate Torque +1",
		ring1="Defending Ring",ring2="Gelatinous Ring +1",
		feet="Rawhide Boots"}

	sets.Self_Waltz = {head="Mummu Bonnet +2"}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}


	-- Fast cast sets for spells
	sets.precast.FC = {
		ammo="Impatiens",
		head=gear.herculean.helm.magical,neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring2="Lebeche Ring",
		legs="Limbo Trousers"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


	-- Ranged snapshot gear
	sets.precast.RA = {--[[range="Comet Tail"]]}


	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Seeth. Bomblet +1",
		head="Pill. Bonnet +2",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Ishvara Earring",
		body=gear.herculean.vest.dexwsd,hands="Meg. Gloves +2",ring1="Gere Ring",ring2="Ilabrat Ring",
		back=gear.toutatis.wsd,waist="Fotia Belt",legs="Lustr. Subligar +1",feet="Lustra. Leggings +1"
	}
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {body="Adhemar Jacket +1",})
	sets.precast.WS.MaxAcc = set_combine(sets.precast.WS, {body="Adhemar Jacket +1",legs="Pill. Culottes +2",feet="Meg. Chausses +2"})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS["Rudra's Storm"] = {
		ammo="Seeth. Bomblet +1",
		head="Pill. Bonnet +2",neck="Caro Necklace",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body=gear.herculean.vest.dexwsd,hands="Meg. Gloves +2",ring1="Gere Ring",ring2="Ilabrat Ring",
		back=gear.toutatis.wsd,waist="Grunfeld Rope",legs="Lustr. Subligar +1",feet="Lustra. Leggings +1"
	}
	
	sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {ear1="Mache Earring +1"})
	sets.precast.WS["Rudra's Storm"].MaxAcc = set_combine(sets.precast.WS["Rudra's Storm"].Acc, {body="Pillager's Vest +2",legs="Pill. Culottes +2"})
	sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Yetshila",body="Plunderer's Vest +3",legs="Pill. Culottes +2"})
	sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Yetshila",body="Plunderer's Vest +3",legs="Pill. Culottes +2"})
	sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Yetshila",body="Plunderer's Vest +3",legs="Pill. Culottes +2"})

	sets.precast.WS["Mandalic Stab"] = sets.precast.WS["Rudra's Storm"]

	sets.precast.WS["Shark Bite"] = {
		ammo="Seeth. Bomblet +1",
		head="Pill. Bonnet +2",neck="Caro Necklace",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body=gear.herculean.vest.dexwsd,hands="Meg. Gloves +2",ring1="Gere Ring",ring2="Ilabrat Ring",
		back=gear.toutatis.wsd,waist="Grunfeld Rope",legs="Lustr. Subligar +1",feet="Lustra. Leggings +1"
	}
	
	sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS["Shark Bite"], {})
	sets.precast.WS["Shark Bite"].MaxAcc = set_combine(sets.precast.WS["Shark Bite"].Acc, {})
	sets.precast.WS["Shark Bite"].SA = set_combine(sets.precast.WS["Shark Bite"], {ammo="Yetshila",body="Plunderer's Vest +3",legs="Pill. Culottes +2"})
	sets.precast.WS["Shark Bite"].TA = set_combine(sets.precast.WS["Shark Bite"], {ammo="Yetshila",body="Plunderer's Vest +3",legs="Pill. Culottes +2"})
	sets.precast.WS["Shark Bite"].SATA = set_combine(sets.precast.WS["Shark Bite"], {ammo="Yetshila",body="Plunderer's Vest +3",legs="Pill. Culottes +2"})

	sets.precast.WS['Evisceration'] = {
		ammo="Yetshila",
		head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Odr Earring",ear2="Moonshade Earring",
		body="Plunderer's Vest +3",hands=gear.adhemar.wrist.path_a,ring1="Begrudging Ring",ring2="Ilabrat Ring",
		back=gear.toutatis.crit,waist="Fotia Belt",legs="Pill. Culottes +2",feet="Mummu Gamash. +2"
	}
	
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})
	sets.precast.WS['Evisceration'].MaxAcc = set_combine(sets.precast.WS['Evisceration'].Acc, {ammo="Seeth. Bomblet +1",ear2="Mache Earring +1",body="Pillager's Vest +2",ring1="Moonbeam Ring"})
	sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'], {})
	sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'], {})
	sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'], {})

	sets.precast.WS['Exenterator'] = {
		ammo="Seeth. Bomblet +1",
		head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Telos Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar.wrist.path_a,ring1="Gere Ring",ring2="Epona's Ring",
		back=gear.toutatis.stp,waist="Fotia Gorget",legs="Meg. Chausses +2",feet="Mummu Gamash. +2"
	}
	
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {})
	sets.precast.WS['Exenterator'].MaxAcc = set_combine(sets.precast.WS['Exenterator'].Acc, {})
	sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'], {})
	sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'], {})
	sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'], {})

	sets.precast.WS['Last Stand'] = {
		head="Mummu Bonnet +2",neck="Fotia Gorget",ear1="Enervating Earring",ear2="Telos Earring",
		body="Mummu Jacket +2",hands="Mummu Wrists +2",ring1="Dingir Ring",ring2="Ilabrat Ring",
		back=gear.toutatis.wsd,waist="Fotia Belt",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"}

	sets.precast.WS['Aeolian Edge'] = {
		ammo="Seeth. Bomblet +1",
		head=gear.herculean.helm.magical,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring",
		back=gear.toutatis.wsd,waist="Eschan Stone",legs=gear.herculean.trousers.magical,feet=gear.herculean.boots.magical
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
	sets.midcast['Horde Lullaby II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {head=gear.taeon.chapeau.phalanx,body=gear.taeon.tabard.phalanx,hands=gear.taeon.gloves.phalanx,legs=gear.taeon.tights.phalanx,feet=gear.taeon.boots.phalanx})

	-- Ranged gear

	sets.midcast.RA = {
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Telos Earring",ear2="Enervating Earring",
		body="Malignance Tabard",hands=gear.adhemar.wrist.path_c,ring1="Dingir Ring",ring2="Ilabrat Ring",
		back=gear.toutatis.stp,waist="Yemaya Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		ring2="Mummu Ring"
	})

	--------------------------------------
	-- Idle/resting/defense sets
	--------------------------------------

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle = {
		ammo="Staunch Tathlum",
		head="Malignance Chapeau",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Eabani Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Moonbeam Ring",
		back=gear.toutatis.stp,waist="Engraved Belt",legs="Malignance Tights",feet="Turms Leggings"
	}

	sets.idle.Sphere = set_combine(sets.idle, {})

	sets.idle.Weak = set_combine(sets.idle, {})

	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Resting sets
	sets.resting = sets.idle

	-- Defense sets

	sets.defense.PDT = {
		ammo="Staunch Tathlum",
		head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Moonbeam Ring",ring2="Purity Ring",
		back=gear.toutatis.stp,waist="Flume Belt +1",legs="Malignance Tights",feet="Malignance Boots"
	}

	sets.defense.MDT = {
		ammo="Yamarang",
		head="Malignance Chapeau",neck="Warder's Charm +1",ear1="Eabani Earring",ear2="Odnowa Earring +1",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Moonbeam Ring",ring2="Purity Ring",
		back="Moonbeam Cape",waist="Engraved Belt",legs="Malignance Tights",feet="Malignance Boots"
	}

	sets.defense.MEVA = {
		ammo="Staunch Tathlum",
		head="Malignance Chapeau",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Eabani Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Purity Ring",
		back="Solemnity Cape",waist="Engraved Belt",legs="Malignance Tights",feet="Malignance Boots"
	}


	--------------------------------------
	-- Melee sets  
	--------------------------------------

	-- Normal melee group
	sets.engaged = {
		ammo="Aurgelmir Orb +1",
		head="Adhemar Bonnet +1",neck="Anu Torque",ear1="Sherida Earring",ear2="Telos Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar.wrist.path_a,ring1="Gere Ring",ring2="Epona's Ring",
		back=gear.toutatis.stp,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean.boots.ta_low_acc
	}
	sets.engaged.Crit = set_combine(sets.engaged, {
		ammo="Yetshila",ring2="Hetairoi Ring",back=gear.toutatis.crit,feet="Mummu Gamash. +2"
	})

	sets.engaged.HybridDT = set_combine(sets.engaged, {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",
		waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"
	})

	sets.engaged.Acc = set_combine(sets.engaged, {
		head="Dampening Tam",ring1="Chirich Ring",ring2="Moonbeam Ring",feet=gear.herculean.boots.ta
	})
	sets.engaged.Acc.Crit = set_combine(sets.engaged.Crit, {
		ammo="Yamarang",neck="Lissome Necklace",ring1="Moonbeam Ring",waist="Grunfeld Rope"
	})
	sets.engaged.Acc.HybridDT = set_combine(sets.engaged.HybridDT, {})
	

	sets.engaged.MaxAcc = set_combine(sets.engaged.Acc, {
		head="Pill. Bonnet +2",neck="Lissome Necklace",
		waist="Grunfeld Rope",legs="Pill. Culottes +2",feet="Mummu Gamash. +2"
	})
	sets.engaged.MaxAcc.Crit = set_combine(sets.engaged.Acc.Crit, {
		head="Pill. Bonnet +2",back=gear.toutatis.stp,legs="Pill. Culottes +2"
	})
	sets.engaged.MaxAcc.HybridDT = set_combine(sets.engaged.Acc.HybridDT, {})
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

function lockstyle()
	windower.chat.input("/lockstyleset 007")
end