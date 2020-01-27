-- Setup vars that are user-dependent.
function user_setup()
	state.OffenseMode:options('Normal','Acc','MaxAcc','Fodder')
	state.HybridMode:options('Zanshin','Kendatsuba','HybridDT','PDT','MDT')
	state.WeaponskillMode:options('Match','Normal','Acc','MaxAcc','Proc')
	state.RangedMode:options('Normal', 'Acc')
	state.PhysicalDefenseMode:options('PDT','PDTReraise')
	state.MagicalDefenseMode:options('MDT','MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'Reraise')
	state.Weapons:options('Dojikiri','ProcWeapon')

	gear.smertrios = {}
	gear.smertrios.wsd = {name = "Smertrios's Mantle", augments = {'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	gear.smertrios.da = {name = "Smertrios's Mantle", augments = {'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	
	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind !backspace input /ja "Third Eye" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !@^` gs c cycle Stance')
	send_command('bind !r gs c set skipprocweapons false;gs c weapons ProcWeapon;gs c set WeaponskillMode Proc;gs c update')
	send_command('bind ^r !r gs c set skipprocweapons true;gs c weapons Default;gs c set WeaponskillMode Normal;gs c update')
	send_command('bind ^q gs c weapons Bow;gs c update')

	select_default_macro_book()
	--lockstyle:schedule(5)
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Meditate = {head="Wakido Kabuto +3",hands="Sakonji Kote",back=gear.smertrios.wsd}
	sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +3"}
	sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote"}
	sets.precast.JA['Sekkanoki'] = {hands="Kasuga Kote +1"}
	sets.precast.JA['Sengikori'] = {feet="Kas. Sune-Ate +1"}
	
	sets.precast.Step = {
		ammo="Ginsen",
		head="Wakido Kabuto +3",neck="Moonbeam Nodowa",ear1="Telos Earring",ear2="Digni. Earring",
		body="Wakido Domaru +3",hands="Wakido Kote +3",ring1="Flamma Ring",ring2="Chirich Ring",
		back=gear.smertrios.da,waist="Grunfeld Rope",legs="Wakido Haidate +3",feet="Flam. Gambieras +2"}
	sets.precast.JA['Violent Flourish'] = {
		ammo="Pemphredo Tathlum",
		head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Telos Earring",
		body="Sakonji Domaru +3",hands="Flam. Manopolas +2",ring1="Flamma Ring",ring2="Chirich Ring",
		back=gear.smertrios.wsd,waist="Eschan Stone",legs="Wakido Haidate +3",feet="Flam. Gambieras +2"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {--[[
		head="Flam. Zucchetto +2",
		body="Tartarus Platemail",hands="Flam. Manopolas +2",ring1="Asklepian Ring",ring2="Valseur's Ring",
		waist="Chaac Belt",legs="Wakido Haidate +3",feet="Sak. Sune-Ate +1"]]}
        
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC = {
		ammo="Sapience Orb",
		neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		hands="Leyline Gloves",ring1="Lebeche Ring",
		legs="Arjuna Breeches"}
		
	sets.precast.FC.Utsusemi = {neck="Magoraga Beads"}
	 
	-- Ranged snapshot gear
	sets.precast.RA = {}
	   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Knobkierrie",
		head=gear.valorous.mask.strwsd,neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body="Sakonji Domaru +3",hands=gear.valorous.mitts.vitwsd,ring1="Shukuyu Ring",ring2="Niqmaddu Ring",
		back=gear.smertrios.wsd,waist="Fotia Belt",legs="Wakido Haidate +3",feet=gear.valorous.greaves.strwsd
	}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.MaxAcc = set_combine(sets.precast.WS.Acc, {
		head="Wakido Kabuto +3",ear1="Lugra Earring +1",
		hands="Wakido Kote +3",ring1="Flamma Ring",
		feet="Flam. Gambieras +2"
	})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})
	sets.precast.WS.Proc = {}

	--[[ Tachi: Fudo ]]
	sets.precast.WS["Tachi: Fudo"] = set_combine(sets.precast.WS, {neck="Caro Necklace"})
	sets.precast.WS["Tachi: Fudo"].Acc = set_combine(sets.precast.WS.Acc, {neck="Caro Necklace"})
	sets.precast.WS["Tachi: Fudo"].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {
		head="Wakido Kabuto +3",neck="Caro Necklace",ear1="Lugra Earring +1",ear2="Mache Earring +1",
		hands="Wakido Kote +3",ring1="Flamma Ring",
		feet="Flam. Gambieras +2"
	})
	sets.precast.WS["Tachi: Fudo"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	sets.precast.WS["Tachi: Fudo"].Proc = set_combine(sets.precast.WS.Proc, {})

	sets.precast.WS["Tachi: Kasha"] = sets.precast.WS["Tachi: Fudo"]
	sets.precast.WS["Tachi: Gekko"] = sets.precast.WS["Tachi: Fudo"]
	sets.precast.WS["Tachi: Yukikaze"] = sets.precast.WS["Tachi: Fudo"]

	--[[ Tachi: Shoha ]]
	sets.precast.WS["Tachi: Shoha"] = set_combine(sets.precast.WS, {
		head="Flam. Zucchetto +2",ear1="Lugra Earring +1",
		ring1="Flamma Ring"
		waist="Ioskeha Belt +1",feet="Flam. Gambieras +2"
	})
	sets.precast.WS["Tachi: Shoha"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Tachi: Shoha"].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {
		head="Flam. Zucchetto +2",ear1="Mache Earring +1",
		hands="Wakido Kote +3",ring1="Flamma Ring",
		waist="Ioskeha Belt +1",feet="Flam. Gambieras +2"
	})
	sets.precast.WS["Tachi: Shoha"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	sets.precast.WS["Tachi: Shoha"].Proc = set_combine(sets.precast.WS.Proc, {})

	sets.precast.WS["Tachi: Enpi"] = sets.precast.WS["Tachi: Shoha"]

	--[[ Tachi: Rana ]]
	sets.precast.WS["Tachi: Rana"] = set_combine(sets.precast.WS, {
		head="Flam. Zucchetto +2",ear1="Lugra Earring +1",ear2="Lugra Earring",
		body=gear.valorous.mail.da,hands=gear.valorous.mitts.da,ring1="Flamma Ring",
		waist="Ioskeha Belt +1",legs=gear.valorous.hose.dexwsd,feet="Flam. Gambieras +2"
	})
	sets.precast.WS["Tachi: Rana"].Acc = set_combine(sets.precast.WS.Acc, {
		head="Flam. Zucchetto +2",ear1="Lugra Earring +1",ear2="Lugra Earring",
		body=gear.valorous.mail.da,hands=gear.valorous.mitts.da,ring1="Flamma Ring",
		waist="Ioskeha Belt +1",legs=gear.valorous.hose.dexwsd,feet="Flam. Gambieras +2"
	})
	sets.precast.WS["Tachi: Rana"].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {
		head="Flam. Zucchetto +2",ear1="Lugra Earring +1",ear2="Mache Earring +1",
		body="Wakido Domaru +3",hands="Wakido Kote +3",ring1="Flamma Ring",
		waist="Ioskeha Belt +1",feet="Flam. Gambieras +2"
	})
	sets.precast.WS["Tachi: Rana"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	sets.precast.WS["Tachi: Rana"].Proc = set_combine(sets.precast.WS.Proc, {})

	--[[ Tachi: Ageha ]]
	sets.precast.WS["Tachi: Ageha"] = set_combine(sets.precast.WS, {
		head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear1="Digni. Earring",
		hands="Flam. Manopolas +2",ring1="Flamma Ring",
		legs="Flamma Dirs +2",feet="Flam. Gambieras +2"
	})
	sets.precast.WS["Tachi: Ageha"].Acc = set_combine(sets.precast.WS.Acc, {
		head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear1="Digni. Earring",
		hands="Flam. Manopolas +2",ring1="Flamma Ring",
		legs="Flamma Dirs +2",feet="Flam. Gambieras +2"
	})
	sets.precast.WS["Tachi: Ageha"].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {
		head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear1="Digni. Earring",
		hands="Flam. Manopolas +2",ring1="Flamma Ring",
		legs="Flamma Dirs +2",feet="Flam. Gambieras +2"
	})
	sets.precast.WS["Tachi: Ageha"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	sets.precast.WS["Tachi: Ageha"].Proc = set_combine(sets.precast.WS.Proc, {})

	--[[ Tachi: Jinpu ]]
	sets.precast.WS["Tachi: Jinpu"] = set_combine(sets.precast.WS, {
		hands="Founder's Gauntlets",feet="Founder's Greaves"
	})
	sets.precast.WS["Tachi: Jinpu"].Acc = set_combine(sets.precast.WS.Acc, {
		hands="Founder's Gauntlets",feet="Founder's Greaves"
	})
	sets.precast.WS["Tachi: Jinpu"].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {
		hands="Founder's Gauntlets",feet="Founder's Greaves"
	})
	sets.precast.WS["Tachi: Jinpu"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	sets.precast.WS["Tachi: Jinpu"].Proc = set_combine(sets.precast.WS.Proc, {})

	sets.precast.WS["Tachi: Goten"] = sets.precast.WS["Tachi: Jinpu"]
	sets.precast.WS["Tachi: Kagero"] = sets.precast.WS["Tachi: Jinpu"]
	sets.precast.WS["Tachi: Koki"] = sets.precast.WS["Tachi: Jinpu"]

	--[[ Tachi: Hobaku ]]
	sets.precast.WS["Tachi: Hobaku"] = set_combine(sets.precast.WS, {
		head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear1="Digni. Earring",
		hands="Flam. Manopolas +2",ring1="Flamma Ring",
		legs="Flamma Dirs +2",feet="Flam. Gambieras +2"
	})
	sets.precast.WS["Tachi: Hobaku"].Acc = set_combine(sets.precast.WS.Acc, {
		head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear1="Digni. Earring",
		hands="Flam. Manopolas +2",ring1="Flamma Ring",
		legs="Flamma Dirs +2",feet="Flam. Gambieras +2"
	})
	sets.precast.WS["Tachi: Hobaku"].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {
		head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear1="Digni. Earring",
		hands="Flam. Manopolas +2",ring1="Flamma Ring",
		legs="Flamma Dirs +2",feet="Flam. Gambieras +2"
	})
	sets.precast.WS["Tachi: Hobaku"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	sets.precast.WS["Tachi: Hobaku"].Proc = set_combine(sets.precast.WS.Proc, {})

	-- sets.precast.WS['Apex Arrow'] = {--[[
	-- 		head="Ynglinga Sallet",neck="Fotia Gorget",ear1="Clearview Earring",ear2="Moonshade Earring",
	-- 		body="Kyujutsugi",hands="Buremte Gloves",ring1="Ilabrat Ring",ring2="Regal Ring",
	-- 		back=gear.ws_jse_back,waist="Fotia Belt",legs="Wakido Haidate +3",feet="Waki. Sune-Ate +1"]]}
	
	-- sets.precast.WS['Apex Arrow'].MidAcc = set_combine(sets.precast.WS['Apex Arrow'], {})
	-- sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {})
	-- sets.precast.WS['Apex Arrow'].MaxAcc = set_combine(sets.precast.WS['Apex Arrow'], {})
	-- sets.precast.WS['Apex Arrow'].Fodder = set_combine(sets.precast.WS['Apex Arrow'], {})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Lugra Earring +1",ear2="Ishvara Earring"}
	sets.MaxTP["Tachi: Shoha"] = {ear1="Lugra Earring +1",ear2="Lugra Earring"}
	sets.MaxTP["Tachi: Enpi"] = sets.MaxTP["Tachi: Shoha"]

	sets.AccMaxTP = {ear1="Telos Earring",ear2="Lugra Earring +1"}
	sets.AccMaxTP["Tachi: Shoha"] = {ear1="Lugra Earring +1",ear2="Mache Earring +1"}
	sets.AccMaxTP["Tachi: Enpi"] = sets.AccMaxTP["Tachi: Shoha"]

	sets.DayWSEars = {ear1="Mache Earring +1",ear2="Moonshade Earring"}
	sets.DayWSEars["Tachi: Shoha"] = {ear1="Brutal Earring",ear2="Moonshade Earring"}
	sets.DayWSEars["Tachi: Enpi"] = sets.DayWSEars["Tachi: Shoha"]
	sets.DayWSEars["Tachi: Rana"] = {ear1="Mache Earring +1",ear2="Brutal Earring"}

	sets.AccDayWSEars = {ear1="Telos Earring",ear2="Mache Earring +1"}
	sets.AccDayWSEars["Tachi: Shoha"] = {ear1="Telos Earring",ear2="Mache Earring +1"}
	sets.AccDayWSEars["Tachi: Enpi"] = sets.AccDayWSEars["Tachi: Shoha"]
	sets.AccDayWSEars["Tachi: Rana"] = {ear1="Telos Earring",ear2="Mache Earring +1"}

	sets.DayMaxTPWSEars = {ear1="Mache Earring +1",ear2="Ishvara Earring"}
	sets.DayMaxTPWSEars["Tachi: Shoha"] = {ear1="Brutal Earring",ear2="Mache Earring +1"}
	sets.DayMaxTPWSEars["Tachi: Enpi"] = sets.DayMaxTPWSEars["Tachi: Shoha"]

	sets.AccDayMaxTPWSEars = {ear1="Telos Earring",ear2="Mache Earring +1"}
	sets.AccDayMaxTPWSEars = {ear1="Telos Earring",ear2="Mache Earring +1"}
	sets.AccDayMaxTPWSEars["Tachi: Enpi"] = sets.AccDayMaxTPWSEars["Tachi: Shoha"]
	
	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{})
		
	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
	
		
	-- Ranged gear
	sets.midcast.RA = {--[[
		head="Flam. Zucchetto +2",neck="Ocachi Gorget",ear1="Clearview Earring",ear2="Neritic Earring",
		body="Kyujutsugi",hands="Buremte Gloves",ring1="Ilabrat Ring",ring2="Regal Ring",
		back="Buquwik Cape",waist="Flax Sash",legs="Wakido Haidate +3",feet="Waki. Sune-Ate +1"]]}

	sets.midcast.RA.Acc = {--[[
		head="Flam. Zucchetto +2",neck="Combatant's Torque",ear1="Clearview Earring",ear2="Neritic Earring",
		body="Kyujutsugi",hands="Buremte Gloves",ring1="Ilabrat Ring",ring2="Regal Ring",
		back="Buquwik Cape",waist="Flax Sash",legs="Wakido Haidate +3",feet="Waki. Sune-Ate +1"]]}

    
    -- Sets to return to when not performing an action.

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	
	sets.Kiting = {
		--feet="Danzo Sune-ate"
	}

  	sets.Reraise = {
		--head="Twilight Helm",body="Twilight Mail"
	}
	
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {}
	
	sets.idle = {
		ammo="Staunch Tathlum",
		head="Wakido Kabuto +3",neck="Loricate Torque +1",ear1="Enchntr. Earring +1",ear2="Genmei Earring",
		body="Wakido Domaru +3",hands=gear.valorous.mitts.da,ring1="Defending Ring",ring2="Dark Ring",
		back=gear.smertrios.da,waist="Flume Belt",legs="Ryuo Hakama",feet=gear.valorous.greaves.strwsd}
		
	sets.idle.Reraise = set_combine(sets.idle, sets.Reraise)

	sets.idle.Weak = set_combine(sets.idle, sets.Reraise, sets.Kiting)
	
	sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
	
	sets.DayIdle = {}
	sets.NightIdle = {}
  
	-- Resting sets
	sets.resting = set_combine(sets.idle, {})
		
    -- Defense sets
	sets.defense.PDT = {
		ammo="Staunch Tathlum",
		neck="Loricate Torque +1",ear2="Genmei Earring",
		body="Wakido Domaru +3",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.smertrios.da,waist="Flume Belt",legs="Ryuo Hakama",feet=gear.valorous.greaves.wsd}

  sets.defense.PDTReraise = set_combine(sets.defense.PDT, sets.Reraise)
		
	sets.defense.MDT = {
		ammo="Staunch Tathlum",
		neck="Loricate Torque +1",
		body="Wakido Domaru +3",hands="Leyline Gloves",ring1="Defending Ring",ring2=gear.dark_ring.dt,
		back="Solemnity Cape",legs="Ken. Hakama +1",feet=gear.valorous.greaves.wsd}
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, sets.Reraise)
	
	sets.defense.MEVA = set_combine(sets.defense.MDT, {
		body="Ken. Samue +1",
		feet="Flam. Gambieras +2"})

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	-- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
	sets.engaged = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",neck="Moonbeam Nodowa",ear1="Telos Earring",ear2="Cessance Earring",
		body=gear.valorous.mail.da,hands=gear.valorous.mitts.da,ring1="Petrov Ring",ring2="Niqmaddu Ring",
		back=gear.smertrios.da,waist="Ioskeha Belt +1",legs="Ryuo Hakama",feet="Ryuo Sune-Ate +1"
	}
	sets.engaged.Zanshin = set_combine(sets.engaged, {body="Kasuga Domaru +1"})
	sets.engaged.Kendatsuba = set_combine(sets.engaged, {})
	sets.engaged.HybridDT = set_combine(sets.engaged, {body="Wakido Domaru +3",ring1="Defending Ring"})
	sets.engaged.PDT = set_combine(sets.engaged.HybridDT, {ammo="Staunch Tathlum",neck="Loricate Torque +1",ear2="Genmei Earring",ring2="Gelatinous Ring +1",feet=gear.valorous.greaves.strwsd})
	sets.engaged.MDT = set_combine(sets.engaged.HybridDT, {ammo="Staunch Tathlum",ear2="Odnowa Earring +1"})

	sets.engaged.Acc = set_combine(sets.engaged, {})
	sets.engaged.Acc.Zanshin = set_combine(sets.engaged.Zanshin, {})
	sets.engaged.Acc.Kendatsuba = set_combine(sets.engaged.Kendatsuba, {})
	sets.engaged.Acc.HybridDT = set_combine(sets.engaged.HybridDT, {})
	sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {})
	sets.engaged.Acc.MDT = set_combine(sets.engaged.MDT, {})
	
	sets.engaged.MaxAcc = set_combine(sets.engaged.Acc, {
		head="Wakido Kabuto +3",ear2="Mache Earring +1",
		body="Wakido Domaru +3",hands="Wakido Kote +3",ring1="Flamma Ring",
		legs="Wakido Haidate +3",feet="Flam. Gambieras +2"
	})
	sets.engaged.MaxAcc.Zanshin = set_combine(sets.engaged.Acc.Zanshin, {
		head="Wakido Kabuto +3",ear2="Mache Earring +1",
		hands="Wakido Kote +3",ring1="Chirich Ring",
		legs="Wakido Haidate +3"
	})
	sets.engaged.MaxAcc.Kendatsuba = set_combine(sets.engaged.Acc.Kendatsuba, {})
	sets.engaged.MaxAcc.HybridDT = set_combine(sets.engaged.Acc.HybridDT, {
		head="Wakido Kabuto +3",ear2="Mache Earring +1",
		hands="Wakido Kote +3",feet="Flam. Gambieras +2"
	})
	sets.engaged.MaxAcc.PDT = set_combine(sets.engaged.PDT, {
		head="Wakido Kabuto +3",hands="Wakido Kote +3",
	})
	sets.engaged.MaxAcc.MDT = set_combine(sets.engaged.MDT, {
		head="Wakido Kabuto +3",hands="Wakido Kote +3",legs="Wakido Haidate +3",feet="Flam. Gambieras +2"
	})

	sets.engaged.Fodder = set_combine(sets.engaged, {})
	sets.engaged.Fodder.Zanshin = set_combine(sets.engaged.Zanshin, {})
	sets.engaged.Fodder.Kendatsuba = set_combine(sets.engaged.Kendatsuba, {})
	sets.engaged.Fodder.HybridDT = set_combine(sets.engaged.HybridDT, {})
	sets.engaged.Fodder.PDT = set_combine(sets.engaged.PDT, {})
	sets.engaged.Fodder.MDT = set_combine(sets.engaged.MDT, {})	

	-- Weapons sets
	sets.weapons.Dojikiri = {main="Dojikiri Yasutsuna",sub="Utu Grip"}
	sets.weapons.Masamune = {main="Masamune",sub="Utu Grip"}
	sets.weapons.ShiningOne = {main="Shining One",sub="Utu Grip"}
	sets.weapons.ProcWeapon = {main="Soboro Sukehiro",sub="Utu Grip"}
	--sets.weapons.Bow = {main="Norifusa +1",sub="Utu Grip",range="Cibitshavore",ammo="Eminent Arrow"}
	
	-- Buff sets
	sets.Cure_Received = {waist="Gishdubar Sash",legs="Flamma Dirs +2"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {--[[neck="Vim Torque +1"]]}
	sets.buff.Hasso = {hands="Wakido Kote +3"}
	sets.buff['Third Eye'] = {} --legs="Sakonji Haidate +3"
	sets.buff.Sekkanoki = {hands="Kasuga Kote +1"}
	sets.buff.Sengikori = {feet="Kas. Sune-Ate +1"}
	sets.buff['Meikyo Shisui'] = {feet="Sak. Sune-Ate +1"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 2)
    else
        set_macro_page(1, 2)
	end

end

function lockstyle()
	windower.chat.input("/lockstyleset 002")
end

--Job Specific Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not areas.Cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()
			
				if spell_recasts[980] < spell_latency and not have_trust("Yoran-Oran") then
					windower.send_command('input /ma "Yoran-Oran (UC)" <me>')
					tickdelay = (framerate * 3)
					return true
				elseif spell_recasts[952] < spell_latency and not have_trust("Koru-Moru") then
					windower.send_command('input /ma "Koru-Moru" <me>')
					tickdelay = (framerate * 3)
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.send_command('input /ma "Qultada" <me>')
					tickdelay = (framerate * 3)
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
					tickdelay = (framerate * 3)
					return true
				elseif spell_recasts[979] < spell_latency and not have_trust("Selh'teus") then
					windower.send_command('input /ma "Selh\'teus" <me>')
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