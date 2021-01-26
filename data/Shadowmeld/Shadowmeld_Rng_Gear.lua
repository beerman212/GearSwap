-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal','Acc')
	state.RangedMode:options('Normal','Acc','EnmityDown')
	state.WeaponskillMode:options('Match','Normal', 'Acc','EnmityDown')
	state.IdleMode:options('Normal', 'PDT')
	
	select_default_weapons()
	
	WeaponType =  {
		['Ataktos'] = "Gun",
		['Anarchy +2'] = "Gun",
		['Armageddon'] = "Gun",
		['Fomalhaut'] = "Gun",
		['Magnatus'] = "Gun",
		['Fail-Not'] = "Bow",
		['Accipiter'] = "Bow",
		['Astrild'] = "Bow",
		['Gandiva'] = "Bow",
		['Kestrel'] = "Bow",
		['Sparrow'] = "Bow",
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
	gear.belenus.stp = {}
	gear.belenus.stp.ranged = {name="Belenus's Cape",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	gear.belenus.stp.melee = {name = "Belenus's Cape", augments = {'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}}

	gear.belenus.wsd = {}
	gear.belenus.wsd.ranged = {name = "Belenus's Cape", augments = {'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
	gear.belenus.wsd.trueflight = {name = "Belenus's Cape", augments = {'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	gear.belenus.jishnu = {name = "Belenus's Cape", augments = {'DEX+20','Rng.Acc.+20 Rng.Atk.+20','Crit.hit rate+10',}}
	gear.belenus.snapshot = {name = "Belenus's Cape", augments = {'"Snapshot"+10',}}

	gear.malevolence = {}
	gear.malevolence.primary = {name = "Malevolence", augments = {'INT+2','Mag. Acc.+3','"Mag.Atk.Bns."+3'}}
	gear.malevolence.secondary = {name = "Malevolence", augments = {'INT+4','Mag. Acc.+10','"Fast Cast"+3'}}
	
	-- Additional local binds
	send_command('bind !` input /ra <t>')
	send_command('bind !backspace input /ja "Bounty Shot" <t>')
	send_command('bind @f7 gs c toggle RngHelper')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !r gs c cycle weapons;gs c update')
	send_command('bind ^q gs c weapons SingleWeapon;gs c update')

	organizer_items = {
		"Remedy",
		"Holy Water",
		"Panacea",
		"Sublime Sushi",
		"Red Curry Bun",
		"Grape Daifuku",
		"Chrono Bullet",
		"Chrono Arrow",
	}
	
	select_default_macro_book()

end

-- Set up all gear sets.
function init_gear_sets()
	
	-- Weapons sets	
	sets.weapons.MeleeSword = {main="Naegling",sub="Nusku Shield",range="Accipiter"}
	sets.weapons.MeleeSwordDW = {main="Naegling",sub="Ternion Dagger +1",range="Accipiter"}
	sets.weapons.MeleeAxe = {main="Dolichenus",sub="Nusku Shield",range="Fomalhaut"}
	sets.weapons.MeleeAxeDW = {main="Dolichenus",sub="Ternion Dagger +1",range="Fomalhaut"}

	sets.weapons.Fomalhaut = {main="Perun +1",sub="Nusku Shield",range="Fomalhaut"}
	sets.weapons.FomalhautDW = {main="Perun +1",sub="Kustawi +1",range="Fomalhaut"}
	sets.weapons.Gastraphetes = {main=gear.malevolence.primary,sub="Nusku Shield"}
	sets.weapons.GastraphetesDW = {main=gear.malevolence.primary,sub=gear.malevolence.secondary}
	sets.weapons.FailNot = {main="Perun +1",sub="Nusku Shield",range="Fail-Not"}
	sets.weapons.FailNotDW = {main="Perun +1",sub="Kustawi +1",range="Fail-Not"}

	sets.weapons.Armageddon = {main="Dolichenus",sub="Nusku Shield",range="Magnatus"}
	sets.weapons.ArmageddonDW = {main="Dolichenus",sub="Ternion Dagger +1",range="Magnatus"}
	sets.weapons.Gandiva = {main="Perun +1",sub="Nusku Shield",range="Astrild"}
	sets.weapons.GandivaDW = {main="Perun +1",sub="Kustawi +1",range="Astrild"}

	--------------------------------------
	-- Precast sets
	--------------------------------------	
	
	-- Precast sets to enhance JAs
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {head=gear.herculean.helm.TH,feet=gear.herculean.boots.TH})
	sets.precast.JA['Bounty Shot'] = set_combine(sets.TreasureHunter, {hands="Amini Glove. +1"})
	sets.precast.JA['Camouflage'] = {body="Orion Jerkin +2"}
	sets.precast.JA['Scavenge'] = {feet="Orion Socks +2"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +2"}
	sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +2"}
	sets.precast.JA['Double Shot'] = {back=gear.belenus.stp.melee}


	-- Fast cast sets for spells

	sets.precast.FC = {
		head="Carmine Mask +1",neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Defending Ring",ring2="Lebeche Ring",
		back=gear.belenus.stp.melee,waist="Flume Belt +1",legs="Limbo Trousers",feet="Carmine Greaves +1"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


	-- Ranged sets (snapshot)
	
	sets.precast.RA = {
		head=gear.taeon.chapeau.snapshot,
		body="Oshosi Vest",hands="Carmine Fin. Ga. +1",
		back=gear.belenus.snapshot,waist="Impulse Belt",legs="Adhemar Kecks",feet="Meg. Jam. +2"
	}
		
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {body="Amini Caban +1",waist="Yemaya Belt"})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, sets.precast.RA.Flurry, {head="Arcadian Beret +2",waist="Impulse Belt",feet="Pursuer's Gaiters"})

	sets.precast.RA.MeleeSword = {
		head=gear.taeon.chapeau.snapshot,
		body="Oshosi Vest",hands="Carmine Fin. Ga. +1",
		back=gear.belenus.snapshot,waist="Impulse Belt",legs="Adhemar Kecks"
	}


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Orion Beret +3",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body=gear.herculean.vest.agiwsd,hands="Meg. Gloves +2",ring1="Regal Ring",ring2="Dingir Ring",
		back=gear.belenus.wsd.ranged,waist="Fotia Belt",legs="Arc. Braccae +3",feet="Meg. Jam. +2"
	}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {body="Orion Jerkin +2"})
	sets.precast.WS.EnmityDown = set_combine(sets.precast.WS, {})

	sets.precast.WS.MaxTP = {ear1="Ishvara Earring",ear2="Telos Earring"}
	sets.precast.WS.Acc.MaxTP = {ear1="Enervating Earring",ear2="Telos Earring"}
	sets.precast.WS.EnmityDown.MaxTP = sets.precast.WS.MaxTP

	sets.MaxTP = {ear1="Ishvara Earring",ear2="Telos Earring"}
	sets.AccMaxTP = {ear1="Enervating Earring",ear2="Telos Earring"}

	--[[ Gun/Xbow ]]
	-- sets.precast.WS.WSName = set_combine(sets.precast.WS, {})
	-- sets.precast.WS.WSName.Acc = set_combine(sets.precast.WS.WSName, {})
	-- sets.precast.WS.WSName.EnmityDown = set_combine(sets.precast.WS.WSName.Acc, {})

	-- sets.MaxTP.WSName = {}
	-- sets.AccMaxTP.WSName = {}

	sets.precast.WS["Last Stand"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Last Stand"].Acc = set_combine(sets.precast.WS["Last Stand"], {body="Orion Jerkin +2"})
	sets.precast.WS["Last Stand"].EnmityDown = set_combine(sets.precast.WS["Last Stand"], {})

	sets.precast.WS["Last Stand"].MaxTP = sets.precast.WS.MaxTP
	sets.precast.WS["Last Stand"].Acc.MaxTP = sets.precast.WS.Acc.MaxTP
	sets.precast.WS["Last Stand"].EnmityDown.MaxTP = sets.precast.WS.EnmityDown

	sets.precast.WS.Wildfire = set_combine(sets.precast.WS, {
		head=gear.herculean.helm.magical,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Samnuha Coat",hands="Carmine Fin. Ga. +1",
		back=gear.belenus.wsd.trueflight,waist="Eschan Stone",legs=gear.herculean.trousers.magical,feet=gear.herculean.boots.magical
	})
	sets.precast.WS.Wildfire.Acc = set_combine(sets.precast.WS.Wildfire, {ear2="Digni. Earring",hands=gear.herculean.gloves.magical})
	
	sets.precast.WS.Trueflight = set_combine(sets.precast.WS.Wildfire, {ear2="Moonshade Earring"})
	sets.precast.WS.Trueflight.Acc = set_combine(sets.precast.WS.Trueflight, {hands=gear.herculean.gloves.magical})

	sets.precast.WS.Trueflight.MaxTP = {ear1="Friomisi Earring",ear2="Hecate's Earring"}
	sets.precast.WS.Trueflight.Acc.MaxTP = {ear1="Friomisi Earring",ear2="Digni. Earring"}

	sets.MaxTP.Trueflight = {ear1="Friomisi Earring",ear2="Hecate's Earring"}
	sets.AccMaxTP.Trueflight = {ear1="Friomisi Earring",ear2="Digni. Earring"}
	
	sets.precast.WS['Hot Shot'] = set_combine(sets.precast.WS, {ear1="Friomisi Earring",hands="Carmine Fin. Ga. +1"})
	sets.precast.WS['Hot Shot'].Acc = set_combine(sets.precast.WS['Hot Shot'], {hands=gear.herculean.gloves.magical})

	sets.precast.WS["Hot Shot"].MaxTP = {ear1="Friomisi Earring",ear2="Ishvara Earring"}
	sets.precast.WS["Hot Shot"].Acc.MaxTP = {ear1="Ishvara Earring",ear2="Telos Earring"}
	
	--[[ Bow ]]
	sets.precast.WS["Jishnu's Radiance"] = set_combine(sets.precast.WS, {
		head="Adhemar Bonnet +1",ear1="Odr Earring",
		body="Meg. Cuirie +2",hands="Mummu Wrists +2",ring2="Mummu Ring",
		back=gear.belenus.jishnu,legs="Darraigner's Brais",feet="Thereoid Greaves"
	})
	sets.precast.WS["Jishnu's Radiance"].Acc = set_combine(sets.precast.WS["Jishnu's Radiance"], {head="Malignance Chapeau",legs="Mummu Kecks +2",feet="Osh. Leggings +1"})
	sets.precast.WS["Jishnu's Radiance"].EnmityDown = set_combine(sets.precast.WS["Jishnu's Radiance"], {feet="Osh. Leggings +1"})

	sets.precast.WS["Jishnu's Radiance"].MaxTP = {ear1="Sherida Earring",ear2="Odr Earring"}
	sets.precast.WS["Jishnu's Radiance"].Acc.MaxTP = {ear1="Telos Earring",ear2="Odr Earring"}
	sets.precast.WS["Jishnu's Radiance"].EnmityDown.MaxTP = {ear1="Odr Earring",ear2="Enervating Earring"}

	sets.MaxTP["Jishnu's Radiance"] = {ear1="Sherida Earring",ear2="Odr Earring"}
	sets.AccMaxTP["Jishnu's Radiance"] = {ear1="Odr Earring",ear2="Telos Earring"}
	
	sets.precast.WS["Refulgent Arrow"] = set_combine(sets.precast.WS, {legs=gear.herculean.trousers.strwsd})
	sets.precast.WS["Refulgent Arrow"].Acc = set_combine(sets.precast.WS["Refulgent Arrow"], {body="Orion Jerkin +2",legs="Meg. Chausses +2"})
	sets.precast.WS["Refulgent Arrow"].EnmityDown = set_combine(sets.precast.WS["Refulgent Arrow"], {})
	
	sets.precast.WS["Apex Arrow"] = set_combine(sets.precast.WS, {ear1="Ishvara Earring"})
	sets.precast.WS["Apex Arrow"].Acc = set_combine(sets.precast.WS["Apex Arrow"], {body="Orion Jerkin +2"})
	sets.precast.WS["Apex Arrow"].EnmityDown = set_combine(sets.precast.WS["Apex Arrow"], {})

	--[[ Axe ]]
	sets.precast.WS.Decimation = set_combine(sets.precast.WS, {
		head="Adhemar Bonnet +1",ear1="Sherida Earring",ear2="Brutal Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar.wrist.path_b,ring1="Regal Ring",ring2="Epona's Ring",
		back=gear.belenus.stp.melee,legs="Meg. Chausses +2",feet=gear.herculean.boots.ta_low_acc
	})
	sets.precast.WS.Decimation.Acc = set_combine(sets.precast.WS.Decimation, {feet=gear.herculean.boots.ta})

	sets.precast.WS.Ruinator = sets.precast.WS.Decimation

	--[[ Sword ]]
	sets.precast.WS["Savage Blade"] = set_combine(sets.precast.WS, {
		neck="Caro Necklace",
		body=gear.herculean.vest.dexwsd,ring2="Rufescent Ring",
		back=gear.belenus.stp.melee,waist="Sailfi Belt +1",gear.herculean.trousers.strwsd
	})
	sets.precast.WS["Savage Blade"].Acc = set_combine(sets.precast.WS["Savage Blade"], {body="Meg. Cuirie +2"})

	sets.MaxTP["Savage Blade"] = {ear1="Sherida Earring",ear2="Ishvara Earring"}
	sets.AccMaxTP["Savage Blade"] = {ear1="Sherida Earring",ear2="Mache Earring +1"}

	--[[ Dagger ]]
	-- sets.precast.WS.Evisceration = set_combine(sets.precast.WS, {})
	-- sets.precast.WS.Evisceration.Acc = set_combine(sets.precast.WS.Evisceration, {})
	-- sets.precast.WS.Evisceration.EnmityDown = set_combine(sets.precast.WS.Evisceration.Acc, {})

	-- sets.MaxTP.Evisceration = {}
	-- sets.AccMaxTP.Evisceration = {}

	-- sets.precast.WS["Aeolian Edge"] = set_combine(sets.precast.WS, {})
	-- sets.precast.WS["Aeolian Edge"].Acc = set_combine(sets.precast.WS["Aeolian Edge"], {})
	-- sets.precast.WS["Aeolian Edge"].EnmityDown = set_combine(sets.precast.WS["Aeolian Edge"].Acc, {})

	-- sets.MaxTP["Aeolian Edge"] = {}
	-- sets.AccMaxTP["Aeolian Edge"] = {}

	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})
		
	-- Ranged sets
	sets.midcast.RA = {
		head="Arcadian Beret +2",neck="Iskur Gorget",ear1="Telos Earring",ear2="Dedition Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring",ring2="Ilabrat Ring",
		back=gear.belenus.stp.ranged,waist="Yemaya Belt",legs="Malignance Tights",feet="Malignance Boots"
	}

	sets.midcast.RA.Overkill = set_combine(sets.midcast.RA, {})
	sets.midcast.RA["Double Shot"] = set_combine(sets.midcast.RA, {body="Arc. Jerkin +3",hands="Oshosi Gloves +1",legs="Osh. Trousers +1",feet="Osh. Leggings +1"})

	sets.midcast.RA.AM = set_combine(sets.midcast.RA, {
		head="Meghanada Visor +2",ear2="Odr Earring",
		body="Meg. Cuirie +2",hands="Mummu Wrists +2",ring2="Begrudging Ring",
		back=gear.belenus.jishnu,waist="Kwahu Kachina Belt",legs="Darraigner's Brais",feet="Osh. Leggings +1"
	})
	sets.midcast.RA.AM.Overkill = set_combine(sets.midcast.RA.AM, {})
	sets.midcast.RA.AM["Double Shot"] = set_combine(sets.midcast.RA.AM, {head="Oshosi Mask +1",body="Arc. Jerkin +3",legs="Osh. Trousers +1"})

	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {ear2="Enervating Earring",body="Orion Jerkin +2",ring1="Regal Ring",ring2="Mummu Ring",feet="Osh. Leggings +1"})

	sets.midcast.RA.Acc.Overkill = set_combine(sets.midcast.RA.Acc, {})
	sets.midcast.RA.Acc["Double Shot"] = set_combine(sets.midcast.RA.Acc, {hands="Oshosi Gloves +1",legs="Osh. Trousers +1",feet="Osh. Leggings +1"})

	sets.midcast.RA.Acc.AM = set_combine(sets.midcast.RA.Acc, {})
	sets.midcast.RA.Acc.AM.Overkill = set_combine(sets.midcast.RA.Acc.AM, {})
	sets.midcast.RA.Acc.AM['Double Shot'] = set_combine(sets.midcast.RA.Acc.AM, {})

	sets.midcast.RA.EnmityDown = set_combine(sets.midcast.RA, {ear2="Enervating Earring",body="Orion Jerkin +2",legs="Adhemar Kecks",feet="Osh. Leggings +1"})

	sets.midcast.RA.EnmityDown.Overkill = set_combine(sets.midcast.RA.EnmityDown, {})
	sets.midcast.RA.EnmityDown["Double Shot"] = set_combine(sets.midcast.RA.EnmityDown, {hands="Oshosi Gloves +1",legs="Osh. Trousers +1",feet="Osh. Leggings +1"})

	sets.midcast.RA.EnmityDown.AM = set_combine(sets.midcast.RA.EnmityDown, {ear1="Odr Earring",hands="Mummu Wrists +2",back=gear.belenus.jishnu,waist="Kwahu Kachina Belt",legs="Darraigner's Brais"})
	sets.midcast.RA.EnmityDown.AM.Overkill = set_combine(sets.midcast.RA.EnmityDown.AM, {})
	sets.midcast.RA.EnmityDown.AM['Double Shot'] = set_combine(sets.midcast.RA.EnmityDown.AM, {head="Oshosi Mask +1",legs="Osh. Trousers +1"})
		
	--These sets will overlay based on accuracy level, regardless of other options.
	sets.buff.Camouflage = {body="Orion Jerkin +2"}
	sets.buff.Camouflage.Acc = {}
	sets.buff['Double Shot'] = {body="Arc. Jerkin +3",back=gear.belenus.stp.ranged}
	sets.buff['Double Shot'].Acc = {body="Arc. Jerkin +3",back=gear.belenus.stp.ranged}
	sets.buff.Barrage = {hands="Orion Bracers +2"}
	
	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}
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
		head="Malignance Chapeau",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.belenus.stp.melee,waist="Flume Belt +1",legs="Malignance Tights",feet="Malignance Boots"
	}
			
	-- Defense sets
	sets.defense.PDT = {
		head="Malignance Chapeau",ear2="Odnowa Earring +1",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.belenus.stp.melee,legs="Malignance Tights",feet="Malignance Boots"
	}

	sets.defense.MDT = {
		head="Malignance Chapeau",neck="Warder's Charm +1",ear1="Tuisto Earring",ear2="Odnowa Earring +1",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Purity Ring",ring2="Gelatinous Ring +1",
		back=gear.belenus.stp.melee,legs="Malignance Tights",feet="Malignance Boots"
	}

	sets.defense.MEVA = {
		head="Malignance Chapeau",neck="Warder's Charm +1",ear1="Eabani Earring",ear2="Odnowa Earring +1",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Purity Ring",ring2="Gelatinous Ring +1",
		back=gear.belenus.stp.melee,legs="Malignance Tights",feet="Malignance Boots"
	}

	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.Kiting.DWMax = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Normal melee group
	sets.engaged = {
		head="Adhemar Bonnet +1",neck="Iskur Gorget",ear1="Sherida Earring",ear2="Dedition Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar.wrist.path_a,ring1="Petrov Ring",ring2="Epona's Ring",
		back=gear.belenus.stp.melee,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean.boots.ta_low_acc
	}

	sets.engaged.HybridDT = set_combine(sets.engaged, {
		head="Malignance Chapeau",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",
		legs="Malignance Tights",feet="Malignance Boots"
	})

	sets.engaged.Acc = set_combine(sets.engaged, {neck="Lissome Necklace",ear2="Telos Earring",feet=gear.herculean.boots.ta})
	sets.engaged.Acc.HybridDT = set_combine(sets.engaged.HybridDT, {neck="Lissome Necklace",ear2="Telos Earring",feet=gear.herculean.boots.ta})

	sets.engaged.EnmityDown = set_combine(sets.engaged.Acc, {
		head="Carmine Mask +1",ear2="Mache Earring +1",
		ring1="Chirich Ring",ring2="Mummu Ring",
		waist="Grunfeld Rope",legs="Malignance Tights",feet="Mummu Gamash. +2"
	})
	sets.engaged.EnmityDown.HybridDT = set_combine(sets.engaged.Acc.HybridDT, {
		ear2="Mache Earring +1",
		ring2="Mummu Ring",
		waist="Grunfeld Rope",feet="Mummu Gamash. +2"
	})

	sets.engaged.DW = set_combine(sets.engaged, {ear2="Suppanomimi"})
	sets.engaged.DW.HybridDT = set_combine(sets.engaged.DW, {
		head="Malignance Chapeau",neck="Loricate Torque +1",
		hands="Malignance Gloves",ring1="Defending Ring",
		legs="Malignance Tights",feet="Malignance Boots"
	})

	sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {head="Malignance Chapeau",neck="Lissome Necklace",feet=gear.herculean.boots.ta})
	sets.engaged.DW.Acc.HybridDT = set_combine(sets.engaged.DW.HybridDT, {feet=gear.herculean.boots.ta})

	sets.engaged.DW.EnmityDown = set_combine(sets.engaged.DW.Acc, {
		head="Carmine Mask +1",
		ring1="Chirich Ring",ring2="Mummu Ring",
		waist="Grunfeld Rope",legs="Malignance Tights",feet="Mummu Gamash. +2"
	})
	sets.engaged.DW.EnmityDown.HybridDT = set_combine(sets.engaged.DW.Acc.HybridDT, {
		hands="Malignance Gloves",ring2="Mummu Ring",
		waist="Grunfeld Rope",legs="Malignance Tights",feet="Mummu Gamash. +2"
	})

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 12)
end

function lockstyle()
	windower.chat.input("/lockstyleset 013")
end

function select_default_weapons()
	if not S{"NIN","DNC"}:contains(player.sub_job) then
		state.Weapons:options('MeleeSword','MeleeAxe','Fomalhaut','Gastraphetes','FailNot','Armageddon','Gandiva')
	else
		state.Weapons:options('MeleeSwordDW','MeleeAxeDW','FomalhautDW','GastraphetesDW','FailNotDW','ArmageddonDW','GandivaDW')
	end
end

function get_macic_ws_ammo()
	return MagicWSAmmo[player.equipment.range] ~= nil and MagicWSAmmo[player.equipment.range] or DefaultAmmo[player.equipment.main] or "Orichalc. Bullet" or nil
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        if state.Buff['Camouflage'] and sets.buff.Camouflage then
            if sets.buff['Camouflage'][state.RangedMode.value] then
                equip(sets.buff['Camouflage'][state.RangedMode.value])
            else
                equip(sets.buff['Camouflage'])
            end
        end
        
        if state.Buff.Barrage and sets.buff.Barrage then
            equip(sets.buff.Barrage)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff:contains('Aftermath') or buff == "Double Shot" or buff == "Overkill" then
		classes.CustomRangedGroups:clear()

		if player.equipment.range then
			if (player.equipment.range == 'Armageddon' and (buffactive['Aftermath: Lv.1'] or buffactive['Aftermath: Lv.2'] or buffactive['Aftermath: Lv.3']))
			or (player.equipment.range == 'Gandiva' and (buffactive['Aftermath: Lv.1'] or buffactive['Aftermath: Lv.2'] or buffactive['Aftermath: Lv.3']))
			or (player.equipment.range == "Gastraphetes" and state.Buff['Aftermath: Lv.3'])
			or (player.equipment.range == "Annihilator" and state.Buff['Aftermath'])
			or (player.equipment.range == "Yoichinoyumi" and state.Buff['Aftermath']) then
				classes.CustomRangedGroups:append('AM')
			end
		end

		if buffactive["Overkill"] then
			classes.CustomRangedGroups:append('Overkill')
		end

		if buffactive["Double Shot"] and not buffactive['Overkill'] then
			classes.CustomRangedGroups:append('Double Shot')
		end
	end
end