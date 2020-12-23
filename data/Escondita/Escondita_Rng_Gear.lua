-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal','Acc')
	state.RangedMode:options('Normal','Acc')
	state.WeaponskillMode:options('Match','Normal', 'Acc')
	state.IdleMode:options('Normal', 'PDT')
	state.Weapons:options('Gandiva','GandivaDW','Armageddon','ArmageddonDW','TPBonusTrial','TPBonusTrialDW')
	
	WeaponType =  {
		['Ataktos'] = "Gun",
		['Anarchy +2'] = "Gun",
		['Armageddon'] = "Gun",
		['Fomalhaut'] = "Gun",
		['Magnatus'] = "Gun",
		['Fail-Not'] = "Bow",
		['Astrild'] = "Bow",
		['Gandiva'] = "Bow",
		['Kestrel'] = "Bow",
		['Sparrow'] = "Bow",
		['Sparrowhawk'] = "TPBow",
		['Sparrowhawk +1'] = "TPBow",
		['Sparrowhawk +2'] = "TPBow",
		['Gastraphetes'] = "Crossbow"
	}

	DefaultAmmo = {
		['Bow']  = {
			['Default'] = "Chrono Arrow",
			['WS'] = "Chrono Arrow",
			['Acc'] = "Chrono Arrow",
			['Magic'] = "Chrono Arrow",
			['MagicAcc'] = "Chrono Arrow",
			['Unlimited'] = "Hauksbok Arrow",
			['MagicUnlimited'] ="Hauksbok Arrow",
			['MagicAccUnlimited'] ="Hauksbok Arrow"
		},
		['TPBow']  = {
			['Default'] = "Wooden Arrow",
			['WS'] = "Wooden Arrow",
			['Acc'] = "Wooden Arrow",
			['Magic'] = "Wooden Arrow",
			['MagicAcc'] = "Wooden Arrow",
			['Unlimited'] = "Wooden Arrow",
			['MagicUnlimited'] ="Wooden Arrow",
			['MagicAccUnlimited'] ="Wooden Arrow"
		},				
		['Gun']  = {
			['Default'] = "Chrono Bullet",
			['WS'] = "Chrono Bullet",
			['Acc'] = "Chrono Bullet",
			['Magic'] = "Orichalc. Bullet",
			['MagicAcc'] = "Orichalc. Bullet",
			['Unlimited'] = "Hauksbok Bullet",
			['MagicUnlimited'] = "Hauksbok Bullet",
			['MagicAccUnlimited'] ="Animikii Bullet"
		},					
		['Crossbow'] = {
			['Default'] = "Eminent Bolt",
			['WS'] = "Eminent Bolt",
			['Acc'] = "Eminent Bolt",
			['Magic'] = "Eminent Bolt",
			['MagicAcc'] = "Eminent Bolt",
			['Unlimited'] = "Hauksbok Bolt",
			['MagicUnlimited'] = "Hauksbok Bolt",
			['MagicAccUnlimited'] ="Hauksbok Bolt"
		}
	}
	
	gear.belenus = {}
	
	    -- Additional local binds
    send_command('bind !` input /ra <t>')
	send_command('bind !backspace input /ja "Bounty Shot" <t>')
	send_command('bind @f7 gs c toggle RngHelper')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !r gs c weapons MagicWeapons;gs c update')
	send_command('bind ^q gs c weapons SingleWeapon;gs c update')
	
	select_default_macro_book()

end

-- Set up all gear sets.
function init_gear_sets()
	
	-- Weapons sets
	sets.weapons.DualWeapons = {main="Kustawi +1",sub="Kustawi",range="Fomalhaut",ammo="Chrono Bullet"}
	sets.weapons.Default = {main="Kustawi +1",sub="Nusku Shield",range="Fomalhaut",ammo="Chrono Bullet"}
	sets.weapons.DualMagicWeapons = {main="Malevolence",sub="Malevolence",range="Fomalhaut",ammo="Chrono Bullet"}

	sets.weapons.Gandiva = {main="Tauret",sub="Nusku Shield",range="Sparrow",ammo=""}
	sets.weapons.GandivaDW = {main="Tauret",sub="Ternion Dagger",range="Sparrow",ammo=""}
	sets.weapons.Armageddon = {main="Tauret",sub="Nusku Shield",range="Magnatus",ammo=DefaultAmmo.Fomalhaut}
	sets.weapons.ArmageddonDW = {main="Tauret",sub="Ternion Dagger",range="Magnatus",ammo=DefaultAmmo.Fomalhaut}

	sets.weapons.TPBonusTrial = {main="Qutrub Knife",sub="Nusku Shield",range="Sparrowhawk"}
	sets.weapons.TPBonusTrialDW = {main="Qutrub Knife",sub="Excalipoor II",range="Sparrowhawk"}

	--------------------------------------
	-- Precast sets
	--------------------------------------	
	
	-- Precast sets to enhance JAs
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.precast.JA['Bounty Shot'] = set_combine(sets.TreasureHunter, {hands="Amini Glove. +1"})
	sets.precast.JA['Camouflage'] = {body="Orion Jerkin +1"}
	sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +1"}
	sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +1"}
	sets.precast.JA['Double Shot'] = {back=gear.tp_ranger_jse_back}


	-- Fast cast sets for spells

    sets.precast.FC = {
        head="Carmine Mask +1",neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Prolix Ring",ring2="Lebeche Ring",
        back="Moonlight Cape",waist="Flume Belt",legs="Rawhide Trousers",feet="Carmine Greaves +1"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})


	-- Ranged sets (snapshot)
	
	sets.precast.RA = {feet="Meg. Jam +1"}
		
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {})


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    sets.precast.WS.Acc = {}

    sets.precast.WS['Wildfire'] = {}

    sets.precast.WS['Wildfire'].Acc = {}
		
    sets.precast.WS['Trueflight'] = {}

    sets.precast.WS['Trueflight'].Acc = {}
		
	sets.precast.WS["Dulling Arrow"] = {
		head="Malignance Chapeau",neck="Anu Torque",ear1="Sherida Earring",ear2="Enervating Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Regal Earring",ring2="Mummu Earring",
		waist="Kwahu Kachina Belt",legs="Malignance Tights",feet="Mummu Gamash. +2"
	}
	
	sets.precast.WS["Blast Arrow"] = sets.precast.WS["Dulling Arrow"]
	sets.precast.WS["Arching Arrow"] = sets.precast.WS["Dulling Arrow"]
	sets.precast.WS["Empyreal Arrow"] = sets.precast.WS["Dulling Arrow"]
		
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
    sets.midcast.FastRecast = {}
		
	-- Ranged sets

    sets.midcast.RA = {
        head="Malignance Chapeau",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Regal Ring",ring2="Dingir Ring",
		legs="Malignance Tights",feet="Mummu Gamash. +1"
	}
	
    sets.midcast.RA.Acc = {}
		
	--These sets will overlay based on accuracy level, regardless of other options.
	sets.buff.Camouflage = {body="Orion Jerkin +1"}
	sets.buff.Camouflage.Acc = {}
	sets.buff['Double Shot'] = {back=gear.tp_ranger_jse_back}
	sets.buff['Double Shot'].Acc = {}
	sets.buff.Barrage = {hands="Orion Bracers +1"}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
    sets.midcast.Utsusemi = sets.midcast.FastRecast
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {}

	-- Idle sets
    sets.idle = {
        head="Malignance Chapeau",neck="Loricate Torque +1",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		waist="Flume Belt +1",legs="Malignance Tights",feet=gear.herculean.boots.qa
	}
    
    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.MDT = {}
		
    sets.defense.MEVA = {}

    sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

    -- Normal melee group
    sets.engaged = {
		head="Adhemar Bonnet +1",neck="Iskur Gorget",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Adhemar Jacket +1",hands="Adhemar Wrist. +1",ring1="Epona's Ring",ring2="Petrov Ring",
		waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean.boots.qa
	}
    
    sets.engaged.Acc = {}

    sets.engaged.DW = {}
    
    sets.engaged.DW.Acc = {}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(8, 20)
end
