function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc','MaxAcc')
    state.WeaponskillMode:options('Match','Normal','MaxAcc')
    state.HybridMode:options('Normal','HybridDT','Crit','SubtleBlow')
    state.PhysicalDefenseMode:options('PDT', 'HP')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT')
	state.Weapons:options('Godhands','Malignance')

	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None'}
	
	gear.segomo = {}
	gear.segomo.tp = {}
	gear.segomo.tp.da = {name="Segomo's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%'}}

	gear.segomo.ws = {}
	gear.segomo.ws.smite = {name="Segomo's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10'}}
	gear.segomo.ws.tornado = {name="Segomo's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}
	

    update_melee_groups()
	
	-- Additional local binds
	send_command('bind ^` input /ja "Boost" <me>')
	send_command('bind !` input /ja "Perfect Counter" <me>')
	send_command('bind ^backspace input /ja "Mantra" <me>')
	send_command('bind @` gs c cycle SkillchainMode')

	organizer_items = {
		"Remedy",
		"Holy Water",
		"Panacea",
		"Sublime Sushi",
		"Red Curry Bun",
		"Grape Daifuku"
	}
	
	select_default_macro_book()
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	-- Weapons sets
	sets.weapons.Godhands = {main="Godhands"}
	sets.weapons.Malignance = {main="Malignance Pole",sub="Duplus Grip"}
	sets.weapons.Verethragna = {main="Mantis"}

	-- Precast Sets
	
	-- Precast sets to enhance JAs on use
	sets.precast.JA['Hundred Fists'] = {legs="Hes. Hose +2"}
	sets.precast.JA['Boost'] = {hands="Anchor. Gloves +2"}
	sets.precast.JA['Dodge'] = {feet="Anch. Gaiters +3"}
	sets.precast.JA['Focus'] = {head="Anchor. Crown +1"}
	sets.precast.JA['Counterstance'] = {}
	sets.precast.JA['Footwork'] = {feet="Bhikku Gaiters +1"}
	sets.precast.JA['Formless Strikes'] = {body="Hes. Cyclas"}
	sets.precast.JA['Mantra'] = {
		head="Halitus Helm",neck="Sanctity Necklace",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
		body="Malignance Tabard",hands="Rawhide Gloves",ring1="Ilabrat Ring",ring2="Etana Ring",
		back="Moonbeam Cape",waist="Kasiri Belt",legs="Ryuo Hakama",feet="Hes. Gaiters +1"
	}

	sets.precast.JA['Chi Blast'] = {
		head="Hes. Crown +1"
	}
	
	sets.precast.JA['Chakra'] = {body="Anch. Cyclas +1",hands="Hes. Gloves +1"}

	sets.precast.JA.Pflug = {
		ammo="Sapience Orb",
		head="Halitus Helm",neck="Warder's Charm +1",ear2="Cryptic Earring",
		body="Emet Harness +1",ring1="Petrov Ring",ring2="Supershear Ring",
		waist="Kasiri Belt",feet="Ahosi Leggings"
	}
	sets.precast.JA.Vallation = sets.precast.JA.Pflug
	sets.precast.JA.Swordplay = sets.precast.JA.Pflug

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {}
		
	sets.precast.Flourish1 = {}


	-- Fast cast sets for spells
	
	sets.precast.FC = {
		ammo="Impatiens",
		head=gear.herculean.helm.dexwsd,neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body=gear.taeon.tabard.fc,hands="Leyline Gloves",ring1="Lebeche Ring",
		legs="Limbo Trousers"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Aurgelmir Orb +1",
		head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Sherida Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar.wrist.path_a,ring1="Gere Ring",ring2="Niqmaddu Ring",
		back=gear.segomo.ws.tornado,waist="Moonbow Belt +1",legs="Samnuha Tights",feet=gear.herculean.boots.ta_low_acc
	}
	sets.precast.WS.MaxAcc = set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.

	sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {
		body="Ken. Samue +1",feet="Mummu Gamash. +2",back=gear.segomo.ws.smite
	})
	sets.precast.WS['Victory Smite'].MaxAcc = set_combine(sets.precast.WS['Victory Smite'], {})

	sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {
		ear1="Moonshade Earring",
		body="Ken. Samue +1",
		legs="Ken. Hakama +1"
	})
	sets.precast.WS['Raging Fists'].MaxAcc = set_combine(sets.precast.WS['Raging Fists'], {})

	sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
		ear1="Mache Earring +1",back=gear.segomo.tp.da
	})
	sets.precast.WS['Shijin Spiral'].MaxAcc = set_combine(sets.precast.WS['Shijin Spiral'], {})

	sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",ear1="Moonshade Earring",hands="Anchor. Gloves +2"
	})
	sets.precast.WS['Howling Fist'].MaxAcc = set_combine(sets.precast.WS['Howling Fist'], {})

	sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",neck="Monk's Nodowa",ear1="Moonshade Earring",hands="Anchor. Gloves +2",legs="Hes. Hose +2",feet="Anch. Gaiters +3"
	})
	sets.precast.WS['Tornado Kick'].MaxAcc = set_combine(sets.precast.WS['Tornado Kick'], {})

	sets.precast.WS['Dragon Kick'] = sets.precast.WS['Tornado Kick']

	sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {
		head="Hiza. Somen　+2",ear1="Telos Earring",
		body="Hiza. Haramaki +2",hands="Anchor. Gloves +2",ring1="Regal Ring",
		legs="Hiza. Hizayoroi +2",feet="Hiza. Sune-Ate +2"
	})
	sets.precast.WS['Asuran Fists'].MaxAcc = set_combine(sets.precast.WS['Asuran Fist'], {})

	sets.precast.WS["Ascetic's Fury"] = set_combine(sets.precast.WS, {
		body="Abnoba Kaftan",feet="Mummu Gamash. +2"
	})
	sets.precast.WS["Ascetic's Fury"].MaxAcc = set_combine(sets.precast.WS["Ascetic's Fury"], {})
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
	
	-- Midcast Sets
	sets.midcast.FastRecast = {}
		
	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
		
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {}
	

	-- Idle sets
	sets.idle = {
		ammo="Staunch Tathlum",
		head="Malignance Chapeau",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Eabani Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Purity Ring",
		back="Moonbeam Cape",waist="Moonbow Belt +1",legs="Malignance Tights",feet="Ahosi Leggings"
	}

	sets.idle.PDT = {}

	-- Defense sets
	sets.defense.PDT = {}

	sets.defense.HP = {}

	sets.defense.MDT = {}
		
	sets.defense.MEVA = {}

	sets.Kiting = {}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee sets
	sets.engaged = {
		ammo="Aurgelmir Orb +1",
		head="Adhemar Bonnet +1",neck="Monk's Nodowa",ear1="Brutal Earring",ear2="Sherida Earring",
		body="Ken. Samue +1",hands=gear.adhemar.wrist.path_a,ring1="Gere Ring",ring2="Niqmaddu Ring",
		back=gear.segomo.tp.da,waist="Moonbow Belt +1",legs="Hes. Hose +2",feet="Anch. Gaiters +3"
	}
	sets.engaged.HybridDT = set_combine(sets.engaged, {
		head="Malignance Chapeau",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",
		legs="Malignance Tights",feet="Malignance Boots"
	})
	sets.engaged.SubtleBlow = set_combine(sets.engaged, {})
	sets.engaged.Crit = set_combine(sets.engaged, {})

	sets.engaged.Acc = set_combine(sets.engaged, {
		head="Ken. Jinpachi +1",ear1="Telos Earring",
	})
	sets.engaged.Acc.HybridDT = set_combine(sets.engaged.HybridDT, {})
	sets.engaged.Acc.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})
	sets.engaged.Acc.Crit = set_combine(sets.engaged.Crit, {})

	sets.engaged.MaxAcc = set_combine(sets.engaged.Acc, {})
	sets.engaged.MaxAcc.HybridDT = set_combine(sets.engaged.Acc.HybridDT, {})
	sets.engaged.MaxAcc.SubtleBlow = set_combine(sets.engaged.Acc.SubtleBlow, {})
	sets.engaged.MaxAcc.Crit = set_combine(sets.engaged.Acc.Crit, {})

	sets.engaged.Godhands = set_combine(sets.engaged, {})
	sets.engaged.Godhands.HybridDT = set_combine(sets.engaged.Godhands, {})
	sets.engaged.Godhands.SubtleBlow = set_combine(sets.engaged.Godhands, {})
	sets.engaged.Godhands.Crit = set_combine(sets.engaged.Godhands, {})

	sets.engaged.Godhands.Acc = set_combine(sets.engaged.Godhands, {})
	sets.engaged.Godhands.Acc.HybridDT = set_combine(sets.engaged.Godhands.HybridDT, {})
	sets.engaged.Godhands.Acc.SubtleBlow = set_combine(sets.engaged.Godhands.SubtleBlow, {})
	sets.engaged.Godhands.Acc.Crit = set_combine(sets.engaged.Godhands.Crit, {})

	sets.engaged.Godhands.MaxAcc = set_combine(sets.engaged.Godhands.Acc, {})
	sets.engaged.Godhands.MaxAcc.HybridDT = set_combine(sets.engaged.Godhands.Acc.HybridDT, {})
	sets.engaged.Godhands.MaxAcc.SubtleBlow = set_combine(sets.engaged.Godhands.Acc.SubtleBlow, {})
	sets.engaged.Godhands.MaxAcc.Crit = set_combine(sets.engaged.Godhands.Acc.Crit, {})

	-- sets.engaged = {
	-- 	ammo="Aurgelmir Orb +1",
	-- 	head="Adhemar Bonnet +1",neck="Monk's Nodowa",ear1="Mache Earring +1",ear2="Sherida Earring",
	-- 	body="Ken. Samue +1",hands=gear.adhemar.wrist.path_a,ring1="Gere Ring",ring2="Niqmaddu Ring",
	-- 	back=gear.segomo.tp.da,waist="Moonbow Belt +1",legs="Hes. Hose +2",feet="Anch. Gaiters +3"
	-- }

	-- sets.engaged.Acc = set_combine(sets.engaged, {
	-- 	neck = "Monk's Nodowa"
	-- })
	-- sets.engaged.MaxAcc = set_combine(sets.engaged, {
	-- 	head="Malignance Chapeau",neck="Monk's Nodowa",
	-- 	body="Malignance Tabard",ring1="Chirich Ring",
	-- 	legs="Malignance Tights"
	-- })

	-- sets.engaged.SubtleBlow = set_combine(sets.engaged, {})
	-- sets.engaged.SubtleBlow.MaxAcc = set_combine(sets.engaged.MaxAcc, {})

	-- sets.engaged.HybridDT = set_combine(sets.engaged, {
	-- 	head="Malignance Chapeau",body="Malignance Tabard",hands="Malignance Gloves",legs="Malignance Tights",
	-- })
	-- sets.engaged.HybridDT.MaxAcc = set_combine(sets.engaged.MaxAcc, {})

	-- sets.engaged.PDT = set_combine(sets.engaged.HybridDT, {
	-- 	neck="Loricate Torque +1",ring1="Defending Ring",
	-- })
	-- sets.engaged.PDT.MaxAcc = set_combine(sets.engaged.HybridDT.MaxAcc, {})

	-- sets.engaged.MDT = set_combine(sets.engaged.HybridDT, {
	-- 	neck="Warder's Charm +1",ear1="Eabani Earring",ring1="Purity Ring"
	-- })
	-- sets.engaged.MDT.MaxAcc = set_combine(sets.engaged.HybridDT.MaxAcc, {})

	-- Hundred Fists/Impetus melee set mods
	
	-- sets.engaged.HF = set_combine(sets.engaged, {})
	-- sets.engaged.MaxAcc.HF = set_combine(sets.engaged.MaxAcc, {})

	-- sets.engaged.SubtleBlow.HF = set_combine(sets.engaged.SubtleBlow, {})
	-- sets.engaged.SubtleBlow.MaxAcc.HF = set_combine(sets.engaged.SubtleBlow.MaxAcc, {})

	-- sets.engaged.HybridDT.HF = set_combine(sets.engaged.HybridDT, {})
	-- sets.engaged.HybridDT.MaxAcc.HF = set_combine(sets.engaged.HybridDT.MaxAcc, {})

	-- sets.engaged.PDT.HF = set_combine(sets.engaged.PDT, {})
	-- sets.engaged.PDT.MaxAcc.HF = set_combine(sets.engaged.PDT.MaxAcc, {})

	-- sets.engaged.MDT.HF = set_combine(sets.engaged.SubtleBlow, {})
	-- sets.engaged.MDT.MaxAcc.HF = set_combine(sets.engaged.MDT.MaxAcc, {})

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
	sets.buff.Impetus = {body="Bhikku Cyclas +1"}
	sets.buff.Footwork = {}
	sets.buff.Boost = {}
	
	sets.FootworkWS = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
    sets.Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {head=gear.herculean.helm.TH,feet=gear.herculean.boots.TH})
	sets.Skillchain = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	set_macro_page(1, 20)
end

function custom_ws(spell, spellMap, eventArgs)
	if state.Buff.Impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
		if sets.buff.ImpetusWS then
			equip(sets.buff.ImpetusWS)
		else
			equip(sets.buff.Impetus)
		end
	elseif buffactive.Footwork and (spell.english == "Dragon Kick" or spell.english == "Tornado Kick") then
		equip(sets.FootworkWS)
	end
end

function custom_post_precast(spell, spellMap, eventArgs)
	if spell.english == 'Boost' and not (player.in_combat or being_attacked or player.status == 'Engaged') and sets.precast.JA.Boost.OutOfCombat then
		equip(sets.precast.JA.Boost.OutOfCombat)
	end
end

function lockstyle()
	windower.chat.input("/lockstyleset 009")
end