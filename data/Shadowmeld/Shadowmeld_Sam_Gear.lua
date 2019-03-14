-- Setup vars that are user-dependent.
function user_setup()
	state.OffenseMode:options('Normal','Zanhasso', 'Kenhasso', 'TripleAttack', 'MidAcc','MaxAcc')
	state.HybridMode:options('Normal','DTLite','PDT')
	state.WeaponskillMode:options('Match','Normal','MidAcc','MaxAcc','Proc')
	state.RangedMode:options('Normal', 'Acc')
	state.PhysicalDefenseMode:options('PDT','PDTReraise')
	state.MagicalDefenseMode:options('MDT','MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'Reraise')
	state.Weapons:options('Dojikiri','ProcWeapon')

	gear.str_ws_jse_back = {name = "Smertrios's Mantle", augments = {'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	gear.dex_da_jse_back = {name = "Smertrios's Mantle", augments = {'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	
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
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Meditate = {head="Wakido Kabuto +3",hands="Sakonji Kote",back=gear.str_ws_jse_back}
	sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +3"}
	sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote"}
	sets.precast.JA['Sekkanoki'] = {hands="Kasuga Kote +1"}
	sets.precast.JA['Sengikori'] = {feet="Kas. Sune-Ate +1"}
	
	sets.precast.Step = {
		ammo="Ginsen",
		head="Wakido Kabuto +3",neck="Moonbeam Nodowa",ear1="Telos Earring",ear2="Digni. Earring",
		body="Wakido Domaru +3",hands="Wakido Kote +3",ring1="Flamma Ring",ring2="Chirich Ring",
		back=gear.dex_da_jse_back,waist="Grunfeld Rope",legs="Wakido Haidate +3",feet="Flam. Gambieras +2"}
	sets.precast.JA['Violent Flourish'] = {
		ammo="Pemphredo Tathlum",
		head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Telos Earring",
		body="Sakonji Domaru +3",hands="Flam. Manopolas +2",ring1="Flamma Ring",ring2="Chirich Ring",
		back=gear.str_ws_jse_back,waist="Eschan Stone",legs="Wakido Haidate +3",feet="Flam. Gambieras +2"}

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
		head=gear.valorous_mask_wsd,neck="Fotia Gorget",ear1="Lugra Earring +1",ear2="Moonshade Earring",
		body="Sakonji Domaru +3",hands=gear.valorous_mitts_wsd,ring1="Epaminondas's Ring",ring2="Niqmaddu Ring",
		back=gear.str_ws_jse_back,waist="Fotia Belt",legs="Wakido Haidate +3",feet=gear.valorous_greaves_wsd}
		
	sets.precast.WS.MidAcc = set_combine(sets.precast.WS, {head="Wakido Kabuto +3"})
	sets.precast.WS.MaxAcc = set_combine(sets.precast.WS, {
		head="Wakido Kabuto +3",ear2="Cessance Earring",
		hands="Wakido Kote +3",
		feet="Flam. Gambieras +2"})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})
	
	sets.precast.WS.Proc = {ammo="Hasty Pinion +1",
		head="Flam. Zucchetto +2",neck="Moonbeam Nodowa",ear1="Telos Earring",ear2="Cessance Earring",
		body="Wakido Domaru +3",hands="Flam. Manopolas +2",ring1="Flamma Ring",ring2="Chirich Ring",
		back=gear.dex_da_jse_back,waist="Fotia Belt",legs="Wakido Haidate +3",feet="Flam. Gambieras +2"}
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Tachi: Fudo'].MidAcc = set_combine(sets.precast.WS.MidAcc, {})
	sets.precast.WS['Tachi: Fudo'].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {})
	sets.precast.WS['Tachi: Fudo'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {
		head="Flam. Zucchetto +2",
		hands=gear.valorous_mitts_da,ring1="Flamma Ring"})
	sets.precast.WS['Tachi: Shoha'].MidAcc = set_combine(sets.precast.WS.MidAcc, {feet="Flam. Gambieras +2"})
	sets.precast.WS['Tachi: Shoha'].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {})
	sets.precast.WS['Tachi: Shoha'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {
		ammo="Paeapua",
		head="Flam. Zucchetto +2",neck="Caro Necklace",ear2="Cessance Earring",
		body="Ken. Samue +1",hands=gear.valorous_mitts_da,ring1="Flamma Ring",
		waist="Grunfeld Rope",legs="Ken. Hakama +1",feet="Flam. Gambieras +2",
	})
	sets.precast.WS['Tachi: Rana'].MidAcc = set_combine(sets.precast.WS.MidAcc, {})
	sets.precast.WS['Tachi: Rana'].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {})
	sets.precast.WS['Tachi: Rana'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Tachi: Kasha'].MidAcc = set_combine(sets.precast.WS.MidAcc, {})
	sets.precast.WS['Tachi: Kasha'].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {})
	sets.precast.WS['Tachi: Kasha'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Tachi: Gekko'].MidAcc = set_combine(sets.precast.WS.MidAcc, {})
	sets.precast.WS['Tachi: Gekko'].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {})
	sets.precast.WS['Tachi: Gekko'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Tachi: Yukikaze'].MidAcc = set_combine(sets.precast.WS.MidAcc, {})
	sets.precast.WS['Tachi: Yukikaze'].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {})
	sets.precast.WS['Tachi: Yukikaze'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear2="Digni. Earring",
		hands="Flam. Manopolas +2",ring1="Flamma Ring",
		waist="Eschan Stone",feet="Flam. Gambieras +2"})

	sets.precast.WS['Tachi: Hobaku'] = sets.precast.WS['Tachi: Ageha']
	
	sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {
		neck="Sanctity Necklace",ear1="Friomisi Earring",
		hands="Founder's Gauntlets",feet="Founder's Greaves"})

	sets.precast.WS['Apex Arrow'] = {--[[
			head="Ynglinga Sallet",neck="Fotia Gorget",ear1="Clearview Earring",ear2="Moonshade Earring",
			body="Kyujutsugi",hands="Buremte Gloves",ring1="Ilabrat Ring",ring2="Regal Ring",
			back=gear.ws_jse_back,waist="Fotia Belt",legs="Wakido Haidate +3",feet="Waki. Sune-Ate +1"]]}
	
	sets.precast.WS['Apex Arrow'].MidAcc = set_combine(sets.precast.WS['Apex Arrow'], {})
	sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {})
	sets.precast.WS['Apex Arrow'].MaxAcc = set_combine(sets.precast.WS['Apex Arrow'], {})
	sets.precast.WS['Apex Arrow'].Fodder = set_combine(sets.precast.WS['Apex Arrow'], {})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Lugra Earring +1",ear2="Ishvara Earring",}
	sets.AccMaxTP = {ear1="Telos Earring",ear2="Lugra Earring +1"}
	sets.AccDayMaxTPWSEars = {ear1="Telos Earring",ear2="Cessance Earring"}
	sets.DayMaxTPWSEars = {ear1="Telos Earring",ear2="Ishvara Earring",}
	sets.AccDayWSEars = {ear1="Telos Earring",ear2="Moonshade Earring"}
	sets.DayWSEars = {ear1="Ishvara Earring",ear2="Moonshade Earring",}
	
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
		body="Wakido Domaru +3",hands=gear.valorous_mitts_da,ring1="Defending Ring",ring2="Dark Ring",
		back=gear.dex_da_jse_back,waist="Flume Belt",legs="Ryuo Hakama",feet=gear.valorous_greaves_strwsd}
		
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
		back=gear.dex_da_jse_back,waist="Flume Belt",legs="Ryuo Hakama",feet=gear.valorous_greaves_wsd}

  sets.defense.PDTReraise = set_combine(sets.defense.PDT, sets.Reraise)
		
	sets.defense.MDT = {
		ammo="Staunch Tathlum",
		neck="Loricate Torque +1",
		body="Wakido Domaru +3",hands="Leyline Gloves",ring1="Defending Ring",ring2=gear.dark_ring_dt,
		back="Solemnity Cape",legs="Ken. Hakama +1",feet=gear.valorous_greaves_wsd}
		
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
		body="Kasuga Domaru +1",hands=gear.valorous_mitts_da,ring1="Petrov Ring",ring2="Niqmaddu Ring",
		back=gear.dex_da_jse_back,waist="Ioskeha Belt +1",legs="Ryuo Hakama",feet="Ryuo Sune-Ate +1"}
	sets.engaged.Zanhasso = set_combine(sets.engaged, {})
	sets.engaged.Kenhasso = set_combine(sets.engaged, {body="Ken. Samue +1",legs="Ken. Hakama +1",})
	sets.engaged.TripleAttack = set_combine(sets.engaged, {
		ammo="Paeapua",
		body="Ken. Samue +1",ring1="Hetairoi Ring",
		legs="Ken. Hakama +1",feet="Flam. Gambieras +2"})
	sets.engaged.MidAcc = set_combine(sets.engaged, {ring1="Flamma Ring",legs="Ken. Hakama +1",})
	sets.engaged.MaxAcc = set_combine(sets.engaged, sets.engaged.MidAcc, {
		head="Wakido Kabuto +3",ear2="Digni. Earring",
		body="Wakido Domaru +3",hands="Wakido Kote +3",
		legs="Wakido Haidate +3",feet="Flam. Gambieras +2"})
	sets.engaged.Fodder = set_combine(sets.engaged, {})
	
	sets.engaged.PDT = set_combine(sets.engaged, sets.defense.PDT, {})
	sets.engaged.Zanhasso.PDT = set_combine(sets.engaged.Zanhasso, sets.defense.PDT, {})
	sets.engaged.Kenhasso.PDT = set_combine(sets.engaged.Kenhasso, sets.defense.PDT, {})
	sets.engaged.TripleAttack.PDT = set_combine(sets.engaged.TripleAttack, sets.defense.PDT, {})
	sets.engaged.MidAcc.PDT = set_combine(sets.engaged.MidAcc, sets.defense.PDT, {})
	sets.engaged.MaxAcc.PDT = set_combine(sets.engaged.MaxAcc, sets.defense.PDT, {})
	sets.engaged.Fodder.PDT = set_combine(sets.engaged.Fodder, sets.defense.PDT, {})
	
	sets.engaged.DTLite = set_combine(sets.engaged, {ammo="Staunch Tathlum",body="Wakido Domaru +3",ring1="Defending Ring",})
	sets.engaged.Zanhasso.DTLite = set_combine(sets.engaged.Zanhasso, {ammo="Staunch Tathlum",body="Wakido Domaru +3",ring1="Defending Ring",})
	sets.engaged.Kenhasso.DTLite = set_combine(sets.engaged.Kenhasso, {ammo="Staunch Tathlum",body="Wakido Domaru +3",ring1="Defending Ring",})
	sets.engaged.TripleAttack.DTLite = set_combine(sets.engaged.TripleAttack, {ammo="Staunch Tathlum",body="Wakido Domaru +3",ring1="Defending Ring",})
	sets.engaged.MidAcc.DTLite = set_combine(sets.engaged.MidAcc, {ammo="Staunch Tathlum",body="Wakido Domaru +3",ring1="Defending Ring",})
	sets.engaged.MaxAcc.DTLite = set_combine(sets.engaged.MaxAcc, {ammo="Staunch Tathlum",body="Wakido Domaru +3",ring1="Defending Ring",})
	sets.engaged.Fodder.DTLite = set_combine(sets.engaged.Fodder, {ammo="Staunch Tathlum",body="Wakido Domaru +3",ring1="Defending Ring",})

	sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
	sets.engaged.Zanhasso.Reraise = set_combine(sets.engaged.Zanhasso, sets.Reraise)
	sets.engaged.Kenhasso.Reraise = set_combine(sets.engaged.Kenhasso, sets.Reraise)
	sets.engaged.TripleAttack.Reraise = set_combine(sets.engaged.TripleAttack, sets.Reraise)
	sets.engaged.MidAcc.Reraise = set_combine(sets.engaged.MidAcc, sets.Reraise)			
	sets.engaged.MaxAcc.Reraise = set_combine(sets.engaged.MaxAcc, sets.Reraise)		
	sets.engaged.Fodder.Reraise = set_combine(sets.engaged.Fodder, sets.Reraise)		

	-- Weapons sets
	sets.weapons.Dojikiri = {main="Dojikiri Yasutsuna",sub="Utu Grip"}
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
        set_macro_page(3, 1)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(10, 1)
    elseif player.sub_job == 'THF' then
        set_macro_page(2, 1)
    else
        set_macro_page(1, 1)
    end
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