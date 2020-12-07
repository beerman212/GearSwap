function user_setup()

    -- Options: Override default values	
	state.OffenseMode:options('Normal','Acc','MaxAcc')
    state.HybridMode:options('Normal','HybridDT','Tank','DDTank','NoShellTank')
	state.WeaponskillMode:options('Match','Normal','Acc','MaxAcc')
    state.CastingMode:options('Normal','SIRD')
	state.Passive:options('None','AbsorbMP')
    state.PhysicalDefenseMode:options('PDT','PDT_HP','Tank')
    state.MagicalDefenseMode:options('BDT','MDT_HP')
	state.ResistDefenseMode:options('MEVA','MEVA_HP','Death','Charm')
	state.IdleMode:options('Normal','Tank','KiteTank','DT','Refresh')
	state.Weapons:options('SequenceSacro','NaeglingSacro','SequenceDW','NaeglingDW','Caladbolg','ShiningOne','MalignancePole')
	
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP','Twilight'}
	
	state.Buff.Hasso = buffactive['Hasso'] or false

	gear.rudianos = {}

	gear.colada = {}
	gear.colada.enhancing = {name = "Colada", augments = {'Enh. Mag. eff. dur. +4','MND+2','Mag. Acc.+15','"Mag.Atk.Bns."+18'}}

	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind ^backspace input /ja "Shield Bash" <t>')
	send_command('bind @backspace input /ja "Cover" <stpt>')
	send_command('bind !backspace input /ja "Sentinel" <me>')
	send_command('bind @= input /ja "Chivalry" <me>')
	send_command('bind != input /ja "Palisade" <me>')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind @pause gs c toggle AutoRuneMode')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	
    select_default_macro_book()
    update_defense_mode()
end

function init_gear_sets()
	
	-- Weapons sets
	sets.weapons.SequenceSacro = {main="Sequence",sub="Sacro Bulwark"}
	sets.weapons.NaeglingSacro = {main="Naegling",sub="Sacro Bulwark"}
	sets.weapons.SequenceDW = {main="Sequence",sub="Ternion Dagger +1"}
	sets.weapons.NaeglingDW = {main="Naegling",sub="Ternion Dagger +1"}
	sets.weapons.NaeglingTPBonusDW = {main="Naegling",sub="Machaera +2"}
	sets.weapons.PhysicalTank = {main="Brilliance",sub="Sacro Bulwark"}
	sets.weapons.Pretty = {main="Sequence",sub="Ochain"}

	sets.weapons.Caladbolg = {main="Albion",sub="Duplus Grip"}

	sets.weapons.ShiningOne = {main="Shining One",sub="Duplus Grip"}

	sets.weapons.MalignancePole = {main="Malignance Pole",sub="Duplus Grip"}

	--------------------------------------
	-- Precast sets
	--------------------------------------
	
    sets.Enmity = {
		ammo="Sapience Orb",
		neck="Moonbeam Necklace",ear2="Cryptic Earring",
		body="Souveran Cuirass",hands="Souv. Handsch. +1",ring1="Petrov Ring",ring2="Supershear Ring",
		legs=gear.odyssean.cuisses.stp,feet="Souveran Schuhs +1"
	}
		
    sets.Enmity.SIRD = set_combine(sets.Enmity, {
		ammo="Staunch Tathlum",
		neck="Moonbeam Necklace",
		hands="Regal Gauntlets",
		legs="Carmine Cuisses +1",feet="Odyssean Greaves"
	})
		
    sets.Enmity.DT = {}
		
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.Enmity,{})
    sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity,{})
    sets.precast.JA['Sentinel'] = set_combine(sets.Enmity,{})
    sets.precast.JA['Rampart'] = set_combine(sets.Enmity,{}) --head="Valor Coronet" (Also Vit?)
    sets.precast.JA['Fealty'] = set_combine(sets.Enmity,{})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity,{})
    sets.precast.JA['Cover'] = set_combine(sets.Enmity, {}) --head="Rev. Coronet +1",
	
    sets.precast.JA['Invincible'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['Holy Circle'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['Sentinel'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['Rampart'].DT = set_combine(sets.Enmity.DT,{}) --head="Valor Coronet" (Also Vit?)
    sets.precast.JA['Fealty'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['Divine Emblem'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['Cover'].DT = set_combine(sets.Enmity.DT, {}) --head="Rev. Coronet +1",
	
    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {}

	sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {})		
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	
	sets.precast.JA['Shield Bash'].DT = set_combine(sets.Enmity.DT, {})		
    sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Palisade'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Intervene'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {}
		
	sets.precast.JA['Violent Flourish'] = {}
		
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		main="Vampirism",sub="Sacro Bulwark",ammo="Sapience Orb",
		head="Carmine Mask +1",neck="Orunmila's Torque",ear1="Loquac. Earring",ear2="Enchntr. Earring +1",
		body="Odyss. Chestplate",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Prolix Ring",
		legs="Arjuna Breeches",feet="Carmine Greaves +1"
	}
		
    sets.precast.FC.DT = {}
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
  
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Aurgelmir Orb +1",
		head=gear.valorous.mask.strwsd,neck="Fotia Gorget",ear1="Thrud Earring",ear2="Moonshade Earring",
		body=gear.valorous.mail.strwsd,hands=gear.odyssean.gauntlets.vitwsd,ring1="Regal Ring",ring2="Shukuyu Ring",
		back="",waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"
	}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
		head="Flam. Zucchetto +2",neck="Caro Necklace",ear1="Brutal Earring",ear2="Thrud Earring",
		body="Dagon Breast.",hands="Sulev. Gauntlets +2",ring2="Rufescent Ring",
		waist="Sailfi Belt +1",
	})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
		head="Flam. Zucchetto +2",--[[head="Blistering Sallet +1"]]ear1="Lugra Earring +1",ear2="Lugra Earring",
		body="Hjarrandi Breast.",hands="Flam. Manopolas +2",ring2="Hetairoi Ring",
		legs=gear.valorous.hose.critdamage,feet="Thereoid Greaves"
	})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		neck="Caro Necklace",
		ring2="Rufescent Ring",
		waist="Sailfi Belt +1"
	})
	
	sets.precast.WS['Flat Blade'] = set_combine(sets.precast.WS, {
		head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear2="Dignitary's Earring",
		body="Flamma Korazin +2",hands="Flam. Manopolas +2",ring2="Flamma Ring",
		waist="Eschan Stone",legs="Flamma Dirs +2",feet="Flam. Gambieras +2"
	})

    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",
		body="Found. Breastplate",hands="Carmine Fin. Ga. +1",ring1="Shiva Ring +1",ring2="Archon Ring",
		waist="Eschan Stone",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"
	})

    sets.precast.WS['Atonement'] = set_combine(sets.precast.WS, {
		ammo="Sapience Orb",
		neck="Moonbeam Necklace",ear2="Cryptic Earring",
		body="Souveran Cuirass",hands="Souv. Handsch. +1",ring1="Petrov Ring",ring2="Supershear Ring",
		legs=gear.odyssean.cuisses.stp,feet="Souveran Schuhs +1"
	})

	sets.precast.WS["Vorpal Blade"] = sets.precast.WS["Chant dy Cygne"]
	
	sets.precast.WS["Red Lotus Blade"] = set_combine(sets.precast.WS["Sanguine Blade"], {head="Hjarrandi Helm",ring1="Regal Ring",ring2="Shiva ring +1"})
	sets.precast.WS["Seraph Blade"] = sets.precast.WS["Red Lotus Blade"]

	-- Staff Weaponskills

	sets.precast.WS['Spirits Within'] = sets.precast.WS['Atonement']
	
	-- Greatsword Weaponskills

	sets.precast.WS.Resolution = set_combine(sets.precast.WS, {
		head="Flam. Zucchetto +2",
		body="Dagon Breast.",hands="Sulev. Gauntlets +2",ring2="Flamma Ring",
		feet="Flam. Gambieras +2"
	})

	sets.precast.WS.Torcleaver = set_combine(sets.precast.WS, {waist="Sailfi Belt +1"})
	sets.precast.WS.Shockwave = sets.precast.WS["Flat Blade"]

	-- Polearm Weaponskills

	sets.precast.WS["Impulse Drive"] = set_combine(sets.precast.WS, {})

	sets.precast.WS["Sonic Thrust"] = set_combine(sets.precast.WS, {})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

	sets.DayWSEars = {}
	sets.AccDayWSEars = {}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

    sets.midcast.FastRecast = {}
		
	sets.midcast.FastRecast.DT = {}

    sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Flash.SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Stun.SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})

    sets.midcast.Cure = {}
		
    sets.midcast.Cure.SIRD = {}
		
    sets.midcast.Cure.DT = {}
		
    sets.midcast.Reprisal = {}

	sets.Self_Healing = {}
		
	sets.Self_Healing.SIRD = {}
		
	sets.Self_Healing.DT = {}

	sets.Cure_Received = {hands="Souv. Handsch. +1",feet="Souveran Schuhs +1"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

    sets.midcast['Enhancing Magic'] = {
		main=gear.colada.enhancing,sub="Sacro Bulwark",
		hands="Regal Gauntlets",
	}
		
    sets.midcast['Enhancing Magic'].SIRD = {}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {
		main="Deacon Sword",sub="Sacro Bulwark",
		hands="Souv. Handsch. +1",
		feet="Souveran Schuhs +1"
	})
	sets.midcast.Phalanx.SIRD = set_combine(sets.midcast['Enhancing Magic'].SIRD, {})

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.resting = {}

    -- Idle sets
    sets.idle = {
		ammo="Homiliary",
		head="Hjarrandi Helm",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Odnowa Earring +1",
		body="Volte Haubert",hands="Regal Gauntlets",ring1="Defending Ring",ring2="Moonbeam Ring",
		back="Moonbeam Cape",waist="Asklepian Belt",legs=gear.valorous.hose.dexwsd,feet="Souveran Schuhs +1"
	}
		
    sets.idle.PDT = {}
		
    sets.idle.MDT = {}
		
	sets.idle.Refresh = {}

	sets.idle.Tank = {}
		
	sets.idle.KiteTank = {}
		
    sets.idle.Reraise = {}
		
    sets.idle.Weak = {}
		
	sets.Kiting = {legs="Carmine Cuisses +1"}

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_regen = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {}
    sets.MP = {}
	sets.passive.AbsorbMP = {}
    sets.MP_Knockback = {}
    sets.Twilight = {--[[head="Twilight Helm", body="Twilight Mail"]]}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {head=gear.valorous.mask.TH,hands=gear.valorous.mitts.TH})
	  
    sets.defense.PDT = {
		ammo="Staunch Tathlum",
		head="Hjarrandi Helm",neck="Sanctity Necklace",ear1="Tuisto Earring",ear2="Odnowa Earring +1",
		body="Hjarrandi Breast.",hands="Souv. Handsch. +1",ring1="Regal Ring",ring2="Moonbeam Ring",
		back="Moonbeam Cape",waist="Flume Belt +1",legs="Flamma Dirs",feet="Souveran Schuhs +1"
	}

	sets.defense.MDT = {
		ammo="Staunch Tathlum",
		head="Volte Salade",head="Warder's Charm +1",ear1="Tuisto Earring",ear2="Odnowa Earring +1",
		body="Volte Haubert",hands="Souv. Handsch. +1",ring1="Purity Ring",ring2="Moonbeam Ring",
		back="Moonbeam Cape",waist="Asklepian Belt",legs="Flamma Dirs",feet="Souveran Schuhs +1"
	}

	sets.defense.BDT = {}
		
	sets.defense.Tank = {}
		
	sets.defense.MEVA = {
		ammo="Staunch Tathlum",
		head="Volte Salade",head="Warder's Charm +1",ear1="Eabani Earring",ear2="Odnowa Earring +1",
		body="Volte Haubert",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonbeam Ring",
		back="Moonbeam Cape",waist="Asklepian Belt",legs="Flamma Dirs",feet="Souveran Schuhs +1"
	}
		
	sets.defense.Death = {}
		
	sets.defense.Charm = {}
		
		-- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.OchainMDT = {}
		
    sets.defense.OchainNoShellMDT = {}
		
    sets.defense.AegisMDT = {}
		
    sets.defense.AegisNoShellMDT = {}		

	--------------------------------------
	-- Engaged sets
	--------------------------------------
    
	sets.engaged = {
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",neck="Ainia Collar",ear1="Brutal Earring",ear2="Dedition Earring",
		body="Dagon Breast.",hands="Flam. Manopolas +2",ring1="Petrov Ring",ring2="Moonbeam Ring",
		back="",waist="Sailfi Belt +1",legs=gear.odyssean.cuisses.stp,feet="Flam. Gambieras +2"
	}

	sets.engaged.Acc = set_combine(sets.engaged, {neck="Lissome Necklace",ear2="Telos Earring",ring1="Flamma Ring"})

    sets.engaged.DW = set_combine(sets.engaged, {
		ear2="Suppanomimi",hands="Emi. Gauntlets +1"
	})

	sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {neck="Lissome Necklace",ear1="Suppanomimi",ear2="Telos Earring"})

	sets.engaged.Tank = {}
		
	sets.engaged.BreathTank = {}
		
	sets.engaged.DDTank = {}
		
	sets.engaged.NoShellTank = {}
		
    sets.engaged.Reraise = set_combine(sets.engaged.Tank, sets.Reraise)
		
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {--[[neck="Vim Torque +1"]]}
    sets.buff.Cover = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	set_macro_page(1, 18)
end