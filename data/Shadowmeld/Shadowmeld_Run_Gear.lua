function user_setup()

	state.OffenseMode:options('Normal','SomeAcc','Acc','HighAcc','FullAcc')
	state.HybridMode:options('Normal','DTLite','Tank')
	state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','HighAcc','FullAcc')
	state.CastingMode:options('Normal','SIRD','Resistant')
	state.PhysicalDefenseMode:options('PDT', 'PDT_HP')
	state.MagicalDefenseMode:options('MDT','MDT_HP','BDT','BDT_HP')
	state.ResistDefenseMode:options('MEVA','MEVA_HP','Charm')
	state.IdleMode:options('Normal','Tank','KiteTank','Sphere')
	state.Weapons:options('Zulfiqar','Epeolatry','Aettir')
	
	state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP'}

	gear.ogma = {}
	gear.ogma.enmity = {name="Ogma's Cape",augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10',}}
	gear.ogma.da = {name="Ogma's Cape",augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}}
	gear.ogma.resolution = {name="Ogma's Cape",augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
	gear.ogma.dimidiation = {name="Ogma's Cape",augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}

	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^` gs c RuneElement')
	send_command('bind @pause gs c toggle AutoRuneMode')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
	send_command('bind ^\\\\ input /ma "Protect IV" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Crusade" <me>')
	send_command('bind ^backspace input /ja "Lunge" <t>')
	send_command('bind @backspace input /ja "Gambit" <t>')
	send_command('bind !backspace input /ja "Rayke" <t>')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	send_command('bind !r gs c weapons Montante;gs c update')
	
	select_default_macro_book()
	lockstyle:schedule(5)
end

function init_gear_sets()

	sets.Enmity = {
		ammo="Sapience Orb",
		head="Halitus Helm",neck="Moonbeam Necklace",ear2="Friomisi Earring",
		body="Emet Harness +1",hands="Futhark Mitons",ring1="Petrov Ring",ring2="Supershear Ring",
		back=gear.ogma.enmity,waist="Kasiri Belt",legs="Eri. Leg Guards +1",feet="Ahosi Leggings"
	}

	sets.Enmity.SIRD = {
		ammo="Staunch Tathlum",
		head=gear.taeon.chapeau.phalanx,neck="Moonbeam Necklace",ear1="Halasz Earring",ear2="Friomisi Earring",
		bocy=gear.taeon.tabard.phalanx,hands="Rawhide Gloves",ring1="Supershear Ring",ring2="Evanescence Ring",
		back=gear.ogma.enmity,waist="Rumination Sash",legs="Carmine Cuisses +1",feet=gear.taeon.boots.phalanx
	}

	sets.Enmity.DT = {ammo="Staunch Tathlum",
		head="Meghanada Visor +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Eabani Earring",
		body="Emet Harness +1",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Moonbeam Ring",
		back=gear.ogma.enmity,waist="Flume Belt",legs="Eri. Leg Guards +1",feet="Ahosi Leggings"
	}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Item sets.

	-- Precast sets to enhance JAs
	sets.precast.JA['Vallation'] = set_combine(sets.Enmity,{body="Runeist Coat +2",legs="Futhark Trousers +1"})
	sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
	sets.precast.JA['Pflug'] = set_combine(sets.Enmity,{feet="Runeist Boots +2"})
	sets.precast.JA['Battuta'] = set_combine(sets.Enmity,{})
	sets.precast.JA['Liement'] = set_combine(sets.Enmity,{body="Futhark Coat +1"})
	sets.precast.JA['Gambit'] = set_combine(sets.Enmity,{hands="Runeist's Mitons +2"})
	sets.precast.JA['Rayke'] = set_combine(sets.Enmity,{})
	sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity,{body="Futhark Coat"})
	sets.precast.JA['Swordplay'] = set_combine(sets.Enmity,{hands="Futhark Mitons"})
	sets.precast.JA['Embolden'] = set_combine(sets.Enmity,{})
	sets.precast.JA['One For All'] = set_combine(sets.Enmity,{})
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Last Resort'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

	sets.precast.JA['Vallation'].DT = set_combine(sets.Enmity.DT,{body="Runeist Coat +2",legs="Futhark Trousers +1"})
	sets.precast.JA['Valiance'].DT = sets.precast.JA['Vallation'].DT
	sets.precast.JA['Pflug'].DT = set_combine(sets.Enmity.DT,{feet="Runeist Boots +2"})
	sets.precast.JA['Battuta'].DT = set_combine(sets.Enmity.DT,{})
	sets.precast.JA['Liement'].DT = set_combine(sets.Enmity.DT,{body="Futhark Coat"})
	sets.precast.JA['Gambit'].DT = set_combine(sets.Enmity.DT,{hands="Runeist's Mitons +2"})
	sets.precast.JA['Rayke'].DT = set_combine(sets.Enmity.DT,{})
	sets.precast.JA['Elemental Sforzo'].DT = set_combine(sets.Enmity.DT,{body="Futhark Coat"})
	sets.precast.JA['Swordplay'].DT = set_combine(sets.Enmity.DT,{})
	sets.precast.JA['Embolden'].DT = set_combine(sets.Enmity.DT,{})
	sets.precast.JA['One For All'].DT = set_combine(sets.Enmity.DT,{})
	sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Last Resort'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Animated Flourish'].DT = set_combine(sets.Enmity.DT, {})
		
	sets.precast.JA['Lunge'] = {
		ammo="Seeth. Bomblet +1",
		head=gear.herculean.helm.magical,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Samnuha Coat",hands="Carmine Fin. Ga. +1",ring1="Shiva Ring +1",ring2="Shiva Ring",
		back="",waist="Eschan Stone",legs=gear.herculean.trousers.magical,feet=gear.herculean.boots.magical
	}

	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']

	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}
	--sets.element.Earth = {neck="Quanpur Necklace"}

	-- Pulse sets, different stats for different rune modes, stat aligned.
	sets.precast.JA['Vivacious Pulse'] = {neck="Incanter's Torque",ring1="Stikini Ring",legs="Rune. Trousers +2"}
	sets.precast.JA['Vivacious Pulse']['Ignis'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Gelus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Flabra'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tellus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Sulpor'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Unda'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Lux'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tenebrae'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	
	
    -- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Yamarang",
		head="Carmine Mask +1",ear1="Enchntr. Earring +1",
		ring2="Supershear Ring",
		waist="Caudata Belt",legs="Aya. Cosciales +2",feet="Rawhide Boots"}
        
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {}
		
	sets.precast.JA['Violent Flourish'] = {}
		
	-- Fast cast sets for spells
	sets.precast.FC = {ammo="Impatiens",
		head="Rune. Bandeau +2",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body=gear.taeon.tabard.fc,hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
		back="",waist="Flume Belt",legs="Aya. Cosciales +2",feet="Carmine Greaves +1"}

	sets.precast.FC.DT = set_combine(sets.precast.FC, {})
			
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash",legs="Futhark Trousers +1"})
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga beads"})
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	-- Weaponskill sets
	sets.precast.WS = {
		ammo="Knobkierrie",
		head=gear.herculean.helm.strwsd,neck="Caro Necklace",ear1="Moonshade Earring",ear2="Sherida Earring",
		body=gear.herculean.vest.dexwsd,hands="Meg. Gloves +2",ring1="Niqmaddu Ring",ring2="Shukuyu Ring",
		back="",waist="Grunfeld Rope",legs=gear.herculean.trousers.strwsd,feet="Lustra. Leggings +1"
	}
	
	sets.precast.WS.SomeAcc = {}
	sets.precast.WS.Acc = {}
	sets.precast.WS.HighAcc = {}
	sets.precast.WS.FullAcc = {}

	sets.precast.WS['Resolution'] = {
		ammo="Knobkierrie",
		head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Sherida Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar.wrist.path_b,ring1="Niqmaddu Ring",ring2="Epona's Ring",
		back=gear.ogma.resolution,waist="Fotia Belt",legs="Samnuha Tights",feet="Lustra. Leggings +1"
	}

	sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'],{})
	sets.precast.WS['Resolution'].HighAcc = set_combine(sets.precast.WS['Resolution'].Acc,{})
	sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS['Resolution'].HighAcc,{})

	sets.precast.WS['Dimidiation'] = {
		ammo="Knobkierrie",
		head=gear.herculean.helm.dexwsd,neck="Caro Necklace",ear1="Moonshade Earring",ear2="Sherida Earring",
		body=gear.herculean.vest.dexwsd,hands="Meg. Gloves +2",ring1="Niqmaddu Ring",ring2="Ilabrat Ring",
		back=gear.ogma.dimidiation,waist="Grunfeld Rope",legs="Lustr. Subligar +1",feet="Lustra. Leggings +1"
	}
	
	sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS.Acc,{})
	sets.precast.WS['Dimidiation'].HighAcc = set_combine(sets.precast.WS.HighAcc,{})
	sets.precast.WS['Dimidiation'].FullAcc = set_combine(sets.precast.WS.FullAcc,{})
	
	sets.precast.WS['Ground Strike'] = {
		ammo="Knobkierrie",
		head=gear.herculean.helm.strwsd,neck="Caro Necklace",ear1="Moonshade Earring",ear2="Sherida Earring",
		body=gear.herculean.vest.dexwsd,hands="Meg. Gloves +2",ring1="Niqmaddu Ring",ring2="Shukuyu Ring",
		back="",waist="Grunfeld Rope",legs=gear.herculean.trousers.strwsd,feet="Lustra. Leggings +1"
	}
	
	sets.precast.WS['Ground Strike'].Acc = set_combine(sets.precast.WS.Acc,{})
	sets.precast.WS['Ground Strike'].HighAcc = set_combine(sets.precast.WS.HighAcc,{})
	sets.precast.WS['Ground Strike'].FullAcc = set_combine(sets.precast.WS.FullAcc,{})
	
	sets.precast.WS['Herculean Slash'] = set_combine(sets.precast.JA['Lunge'], {})
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.JA['Lunge'], sets.element.Dark, {})
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Brutal Earring"}
	sets.AccMaxTP = {ear1="Telos Earring"}

	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
	sets.midcast.FastRecast = {ammo="Sapience Orb",
		head="Carmine Mask +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body=gear.taeon.tabard.fc,hands="Leyline Gloves",ring1="Kishar Ring",
		back="",waist="Flume Belt",legs="Aya. Cosciales +2",feet="Carmine Greaves +1"
	}

	sets.midcast.FastRecast.DT = set_combine(sets.midcast.FastRecast, {neck="Loricate Torque +1",ring1="Defending Ring",ring2="Moonlight Ring"})

	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast,{
		head="Erilaz Galea +1",neck="Incanter's Torque",ear1="Andoaa Earring",hands="Runeist's Mitons +2",waist="Olympus Sash",legs="Futhark Trousers +1"
	})
	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'],{
		head="Fu. Bandeau +1",body=gear.taeon.tabard.phalanx,hands=gear.taeon.gloves.phalanx,legs=gear.taeon.tights.phalanx,feet=gear.taeon.boots.phalanx
	})
	sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'],{head="Rune. Bandeau +2",body=gear.taeon.tabard.fc}) 
	sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'],{}) 
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
	sets.midcast.Flash = set_combine(sets.midcast.FastRecast, sets.Enmity, {})
	sets.midcast.Foil = set_combine(sets.midcast.FastRecast, sets.Enmity, {})
	sets.midcast.Stun = set_combine(sets.midcast.FastRecast, sets.Enmity, {})
	sets.midcast['Blue Magic'] = set_combine(sets.midcast.FastRecast, sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.midcast.FastRecast, sets.Enmity.SIRD, {})
	sets.midcast.Cocoon = set_combine(sets.midcast.FastRecast, sets.Enmity.SIRD, {})

	sets.midcast.Cure = {ammo="Staunch Tathlum",
		neck="Incanter's Torque",ear1="Mendi. Earring",ear2="Gwati Earring",
		body="Vrikodara Jupon",ring1="Sirona's Ring",ring2="Lebeche Ring",
		back="Solemnity Cape",waist="Luminary Sash",feet="Skaoi Boots"}
		
	sets.midcast['Wild Carrot'] = set_combine(sets.midcast.Cure, {})
		
	sets.Self_Healing = {hands="Buremte Gloves",waist="Gishdubar Sash"}
	sets.Cure_Received = {hands="Buremte Gloves",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	sets.resting = {}

	sets.idle = {ammo='Homiliary',
		head="Rawhide Mask",neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Ethereal Earring",
		body="Runeist's Coat +2",hands=gear.herculean.gloves.refresh,ring1="Defending Ring",ring2="Moonbeam Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Aya. Cosciales +2",feet="Ahosi Leggings"
	}
		
	--sets.idle.Sphere = set_combine(sets.idle,{body="Mekosu. Harness"})
	
	sets.idle.Tank = {
		ammo="Staunch Tathlum",
		head="Dampening Tam",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
		body="Ayanmo Corazza +2",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Moonbeam Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Aya. Cosciales +2",feet="Ahosi Leggings"
	}

	sets.idle.KiteTank = set_combine(sets.idle.Tank, {head="Meghanada Visor +2",legs="Carmine Cuisses +1"})

	sets.idle.Weak = set_combine(sets.idle, {})

	sets.Kiting = {legs="Carmine Cuisses +1"}
	
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

    -- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {}
	sets.MP = {ear2="Ethereal Earring",body="Erilaz Surcoat +1",waist="Flume Belt"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {head=gear.herculean.helm.TH,feet=gear.herculean.boots.TH})
	
	-- Weapons sets
	sets.weapons.Epeolatry = {main="Epeolatry",sub="Utu Grip"}
	sets.weapons.Aettir = {main="Aettir",sub="Utu Grip"}
	--sets.weapons.Lionheart = {main="Lionheart",sub="Utu Grip"}
	sets.weapons.Zulfiqar = {main="Zulfiqar",sub="Utu Grip"}
	sets.weapons.Montante = {main="Montante +1",sub="Utu Grip"}
	--sets.weapons.DualWeapons = {main="Firangi",sub="Reikiko"}
	
	-- Defense Sets
	
	sets.defense.PDT = {
		ammo="Staunch Tathlum",
		head="Meghanada Visor +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Eabani Earring",
		body="Erilaz Surcoat +1",hands="Aya. Manopolas +2",ring1="Defending Ring",ring2="Moonbeam Ring",
		back="Moonbeam Cape",waist="Flume Belt",legs="Eri. Leg Guards +1",feet="Ahosi Leggings"
	}
	
	sets.defense.PDT_HP = set_combine(sets.defense.PDT, {})
				
	sets.defense.MDT = {ammo="Yamarang",
		head="Dampening Tam",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Eabani Earring",
		body="Futhark Coat +1",hands="Leyline Gloves",ring1="Purity Ring",ring2="Moonbeam Ring",
		back="Moonbeam Cape",waist="Engraved Belt",legs="Eri. Leg Guards +1",feet="Erilaz Greaves +1"
	}
	
	sets.defense.MDT_HP = set_combine(sets.defense.MDT, {})
	
	sets.defense.BDT = {}
		
	sets.defense.BDT_HP = {}
	
	sets.defense.MEVA = {
		ammo="Staunch Tathlum",
        head="Erilaz Galea +1",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Eabani Earring",
        body="Runeist's Coat +1",hands="Erilaz Gauntlets +1",ring1="Purity Ring",
        back=gear.ogma.enmity,waist="Engraved Belt",legs="Rune. Trousers +2",feet="Erilaz Greaves +1"
	}
	
	sets.defense.MEVA_HP = {ammo="Staunch Tathlum",
        head="Erilaz Galea +1",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Sanare Earring",
        body="Runeist's Coat +3",hands="Erilaz Gauntlets +1",ring1="Moonbeam Ring",ring2="Moonbeam Ring",
        back=gear.ogma.enmity,waist="Engraved Belt",legs="Rune. Trousers +3",feet="Erilaz Greaves +1"}
		
	sets.defense.Charm = set_combine(sets.defense.MEVA, {back="Solemnity Cape"})
	

	--------------------------------------
	-- Engaged sets
	--------------------------------------
	
	sets.engaged = {
		ammo="Yamarang",
		head="Adhemar Bonnet +1",neck="Anu Torque",ear1="Brutal Earring",ear2="Sherida Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar.wrist.path_b,ring1="Niqmaddu Ring",ring2="Epona's Ring",
		back=gear.ogma.da,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean.boots.ta_low_acc
	}
	
	sets.engaged.SomeAcc = set_combine(sets.engaged, {head="Dampening Tam",feet=gear.herculean.boots.ta})
	sets.engaged.Acc = set_combine(sets.engaged.SomeAcc, {neck="Lissome Necklace",ear1="Telos Earring"})
	sets.engaged.HighAcc = set_combine(sets.engaged.Acc, {})
	sets.engaged.FullAcc = set_combine(sets.engaged.HighAcc, {})
	sets.engaged.DTLite = set_combine(sets.engaged, {})
	
	sets.engaged.SomeAcc.DTLite = set_combine(sets.engaged.SomeAcc, {})
	sets.engaged.Acc.DTLite = set_combine(sets.engaged.Acc, {})
	sets.engaged.HighAcc.DTLite = set_combine(sets.engaged.HighAcc, {})
	sets.engaged.FullAcc.DTLite = set_combine(sets.engaged.FullAcc, {})

	sets.engaged.Tank = {ammo="Staunch Tathlum",
	head="Meghanada Visor +2",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
	body="Futhark Coat +1",hands="Aya. Manopolas +2",ring1="Defending Ring",ring2="Moonbeam Ring",
	back="Shadow Mantle",waist="Kasiri Belt",legs="Eri. Leg Guards +1",feet="Ahosi Leggings"}
	sets.engaged.SomeAcc.Tank = sets.engaged.Tank
	sets.engaged.Acc.Tank = sets.engaged.Tank
	sets.engaged.HighAcc.Tank = sets.engaged.Tank
	sets.engaged.FullAcc.Tank = sets.engaged.Tank
	
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.buff.Battuta = {}
	sets.buff.Embolden = {back="Evasionist's Cape"}
	
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(4, 19)
	elseif player.sub_job == 'RDM' then
		set_macro_page(5, 19)
	elseif player.sub_job == 'SCH' then
		set_macro_page(5, 19)
	elseif player.sub_job == 'BLU' then
		set_macro_page(6, 19)
	elseif player.sub_job == 'WAR' then
		set_macro_page(7, 19)
	elseif player.sub_job == 'SAM' then
		set_macro_page(8, 19)
	elseif player.sub_job == 'DRK' then
		set_macro_page(9, 19)
	elseif player.sub_job == 'NIN' then
		set_macro_page(10, 19)
	else
		set_macro_page(5, 19)
	end
end

function lockstyle()
	windower.chat.input("/lockstyleset 005")
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
				elseif spell_recasts[979] < spell_latency and not have_trust("Selh'teus") then
					windower.send_command('input /ma "Selh\'teus" <me>')
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
				else
					return false
				end
			end
		end
	end
	return false
end

buff_spell_lists.Auto = {--Options for When are: Always, Engaged, Idle, OutOfCombat, Combat
	{Name='Crusade',	Buff='Enmity Boost',	SpellID=476,	When='Combat'},
	--{Name='Temper',		Buff='Multi Strikes',	SpellID=493,	When='Engaged'},
	{Name='Phalanx',	Buff='Phalanx',			SpellID=106,	When='Always'},
	{Name='Refresh',	Buff='Refresh',			SpellID=109,	When='Idle'},
}