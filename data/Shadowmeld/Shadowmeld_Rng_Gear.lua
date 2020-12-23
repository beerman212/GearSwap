-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal','Acc')
	state.RangedMode:options('Normal','Acc')
	state.WeaponskillMode:options('Match','Normal', 'Acc')
	state.IdleMode:options('Normal', 'PDT')
	
	select_default_weapons()
	
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
	gear.belenus.stp = {}
	gear.belenus.stp.ranged = {name="Belenus's Cape",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	gear.belenus.stp.melee = {name = "Belenus's Cape", augments = {'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}}

	gear.belenus.wsd = {}
	gear.belenus.wsd.ranged = {name = "Belenus's Cape", augments = {'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
	gear.belenus.wsd.trueflight = {name = "Belenus's Cape", augments = {'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	gear.belenus.jishnu = {name = "Belenus's Cape", augments = {'DEX+20','Rng.Acc.+20 Rng.Atk.+20','Crit.hit rate+10',}}
	gear.belenus.snapshot = {name = "Belenus's Cape", augments = {'"Snapshot"+10',}}

	gear.malevolence = {}
	gear.malevolence.maxaug1 = {name = "Malevolence", augments = {'INT+2','Mag. Acc.+3','"Mag.Atk.Bns."+3'}}
	gear.malevolence.maxaug2 = {name = "Malevolence", augments = {'INT+5'}}
	
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
	}
	
	select_default_macro_book()

end

-- Set up all gear sets.
function init_gear_sets()
	
	-- Weapons sets	
	sets.weapons.MeleeSword = {main="Naegling",sub="Nusku Shield",range="Anarchy +2"}
	sets.weapons.MeleeSwordDW = {main="Naegling",sub="Ternion Dagger +1",range="Anarchy +2"}
	sets.weapons.MeleeAxe = {main="Dolichenus",sub="Nusku Shield",range="Fomalhaut"}
	sets.weapons.MeleeAxeDW = {main="Dolichenus",sub="Ternion Dagger +1",range="Fomalhaut"}

	sets.weapons.Fomalhaut = {main="Perun +1",sub="Nusku Shield",range="Fomalhaut"}
	sets.weapons.FomalhautDW = {main="Perun +1",sub="Kustawi +1",range="Fomalhaut"}
	sets.weapons.Gastraphetes = {main=gear.malevolence.maxaug1,sub="Nusku Shield"}
	sets.weapons.GastraphetesDW = {main=gear.malevolence.maxaug1,sub=gear.malevolence.maxaug2}
	sets.weapons.FailNot = {main="Perun +1",sub="Nusku Shield",range="Fail-Not"}
	sets.weapons.FailNotDW = {main="Perun +1",sub="Kustawi +1",range="Fail-Not"}

	sets.weapons.Armageddon = {main="Dolichenus",sub="Nusku Shield",range="Magnatus"}
	sets.weapons.ArmageddonDW = {main="Dolichenus",sub="Ternion Dagger +1",range="Magnatus"}
	sets.weapons.Gandiva = {main="Perun +1",sub="Nusku Shield",range="Sparrow"}
	sets.weapons.GandivaDW = {main="Perun +1",sub="Kustawi +1",range="Sparrow"}

	sets.weapons.TPBonusTrial = {main="Gramk's Axe",sub="Nusku Shield",range="Sparrowhawk"}
	sets.weapons.TPBonusTrialDW = {main="Gramk's Axe",sub="Dullahan Axe",range="Sparrowhawk"}

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
		back=gear.belenus.stp.melee,waist="Flume Belt",legs="Limbo Trousers",feet="Carmine Greaves +1"
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


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Orion Beret +3",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body=gear.herculean.vest.agiwsd,hands="Meg. Gloves +2",ring1="Regal Ring",ring2="Dingir Ring",
		back=gear.belenus.wsd.ranged,waist="Fotia Belt",legs="Meg. Chausses +2",feet="Meg. Jam. +2"
	}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {body="Orion Jerkin +2"})
	sets.precast.WS.MaxAcc = set_combine(sets.precast.WS.Acc, {})

	sets.MaxTP = {ear1="Ishvara Earring",ear2="Telos Earring"}
	sets.AccMaxTP = {ear1="Enervating Earring",ear2="Telos Earring"}

	--[[ Gun/Xbow ]]
	-- sets.precast.WS.WSName = set_combine(sets.precast.WS, {})
	-- sets.precast.WS.WSName.Acc = set_combine(sets.precast.WS.WSName, {})
	-- sets.precast.WS.WSName.MaxAcc = set_combine(sets.precast.WS.WSName.Acc, {})

	-- sets.MaxTP.WSName = {}
	-- sets.AccMaxTP.WSName = {}

	sets.precast.WS["Last Stand"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Last Stand"].Acc = set_combine(sets.precast.WS["Last Stand"], {body="Orion Jerkin +2"})
	sets.precast.WS["Last Stand"].MaxAcc = set_combine(sets.precast.WS["Last Stand"].Acc, {})

	sets.precast.WS.Wildfire = set_combine(sets.precast.WS, {
		head=gear.herculean.helm.magical,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Samnuha Coat",hands="Carmine Fin. Ga. +1",
		back=gear.belenus.wsd.trueflight,waist="Eschan Stone",legs=gear.herculean.trousers.magical,feet=gear.herculean.boots.magical
	})
	sets.precast.WS.Wildfire.Acc = set_combine(sets.precast.WS.Wildfire, {ear2="Digni. Earring",hands=gear.herculean.gloves.magical})
	sets.precast.WS.Wildfire.MaxAcc = set_combine(sets.precast.WS.Wildfire.Acc, {})
	
	sets.precast.WS.Trueflight = set_combine(sets.precast.WS.Wildfire, {ear2="Moonshade Earring"})
	sets.precast.WS.Trueflight.Acc = set_combine(sets.precast.WS.Trueflight, {hands=gear.herculean.gloves.magical})
	sets.precast.WS.Trueflight.MaxAcc = set_combine(sets.precast.WS.Trueflight.Acc, {})

	sets.MaxTP.Trueflight = {ear1="Friomisi Earring",ear2="Hecate's Earring"}
	sets.AccMaxTP.Trueflight = {ear1="Friomisi Earring",ear2="Digni. Earring"}
	
	sets.precast.WS['Hot Shot'] = set_combine(sets.precast.WS, {ear1="Friomisi Earring",hands="Carmine Fin. Ga. +1"})
	sets.precast.WS['Hot Shot'].Acc = set_combine(sets.precast.WS['Hot Shot'], {hands=gear.herculean.gloves.magical})
	sets.precast.WS['Hot Shot'].Acc = set_combine(sets.precast.WS['Hot Shot'], {hands=gear.herculean.gloves.magical})
	
	--[[ Bow ]]
	sets.precast.WS["Jishnu's Radiance"] = set_combine(sets.precast.WS, {
		head="Adhemar Bonnet +1",ear1="Odr Earring",
		body="Meg. Cuirie +2",hands="Mummu Wrists +2",ring2="Ilabrat Ring",
		back=gear.belenus.jishnu,legs="Darraigner's Brais",feet="Mummu Gamash. +2"
	})
	sets.precast.WS["Jishnu's Radiance"].Acc = set_combine(sets.precast.WS["Jishnu's Radiance"], {head="Malignance Chapeau"})
	sets.precast.WS["Jishnu's Radiance"].MaxAcc = set_combine(sets.precast.WS["Jishnu's Radiance"].Acc, {legs=gear.herculean.trousers.ranged_crit})

	sets.MaxTP["Jishnu's Radiance"] = {ear1="Sherida Earring",ear2="Odr Earring"}
	sets.AccMaxTP["Jishnu's Radiance"] = {ear1="Odr Earring",ear2="Telos Earring"}
	
	sets.precast.WS["Refulgent Arrow"] = set_combine(sets.precast.WS, {legs=gear.herculean.trousers.strwsd})
	sets.precast.WS["Refulgent Arrow"].Acc = set_combine(sets.precast.WS["Refulgent Arrow"], {body="Orion Jerkin +2",legs="Meg. Chausses +2"})
	sets.precast.WS["Refulgent Arrow"].MaxAcc = set_combine(sets.precast.WS["Refulgent Arrow"].Acc, {})
	
	sets.precast.WS["Apex Arrow"] = set_combine(sets.precast.WS, {ear1="Ishvara Earring"})
	sets.precast.WS["Apex Arrow"].Acc = set_combine(sets.precast.WS["Apex Arrow"], {body="Orion Jerkin +2"})
	sets.precast.WS["Apex Arrow"].MaxAcc = set_combine(sets.precast.WS["Apex Arrow"].Acc, {})

	sets.precast.WS["Dulling Arrow"] = {
		head="Malignance Chapeau",neck="Anu Torque",ear1="Sherida Earring",ear2="Enervating Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Regal Earring",ring2="Mummu Earring",
		back=gear.belenus.stp.ranged,waist="Kwahu Kachina Belt",legs="Malignance Tights",feet="Mummu Gamash. +2"
	}

	sets.precast.WS["Blast Arrow"] = sets.precast.WS["Dulling Arrow"]
	sets.precast.WS["Arching Arrow"] = sets.precast.WS["Dulling Arrow"]
	sets.precast.WS["Empyreal Arrow"] = sets.precast.WS["Dulling Arrow"]

	--[[ Axe ]]
	sets.precast.WS.Decimation = set_combine(sets.precast.WS, {
		head="Adhemar Bonnet +1",ear1="Sherida Earring",ear2="Brutal Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar.wrist.path_b,ring1="Regal Ring",ring2="Epona's Ring",
		back=gear.belenus.stp.melee,legs="Meg. Chausses +2",feet=gear.herculean.boots.ta_low_acc
	})
	sets.precast.WS.Decimation.Acc = set_combine(sets.precast.WS.Decimation, {feet=gear.herculean.boots.ta})
	sets.precast.WS.Decimation.MaxAcc = set_combine(sets.precast.WS.Decimation.Acc, {
		head="Malignance Chapeau",ear2="Telos Earring",
		hands=gear.adhemar.wrist.path_a,ring2="Ilabrat Ring",
		feet="Meg. Jam. +2"
	})

	sets.precast.WS.Ruinator = sets.precast.WS.Decimation

	--[[ Sword ]]
	sets.precast.WS["Savage Blade"] = set_combine(sets.precast.WS, {
		neck="Caro Necklace",
		body=gear.herculean.vest.dexwsd,ring2="Rufescent Ring",
		back=gear.belenus.stp.melee,waist="Sailfi Belt +1",gear.herculean.trousers.strwsd
	})
	sets.precast.WS["Savage Blade"].Acc = set_combine(sets.precast.WS["Savage Blade"], {body="Meg. Cuirie +2"})
	sets.precast.WS["Savage Blade"].MaxAcc = set_combine(sets.precast.WS["Savage Blade"].Acc, {})

	sets.MaxTP["Savage Blade"] = {ear1="Sherida Earring",ear2="Ishvara Earring"}
	sets.AccMaxTP["Savage Blade"] = {ear1="Sherida Earring",ear2="Mache Earring +1"}

	--[[ Dagger ]]
	-- sets.precast.WS.Evisceration = set_combine(sets.precast.WS, {})
	-- sets.precast.WS.Evisceration.Acc = set_combine(sets.precast.WS.Evisceration, {})
	-- sets.precast.WS.Evisceration.MaxAcc = set_combine(sets.precast.WS.Evisceration.Acc, {})

	-- sets.MaxTP.Evisceration = {}
	-- sets.AccMaxTP.Evisceration = {}

	-- sets.precast.WS["Aeolian Edge"] = set_combine(sets.precast.WS, {})
	-- sets.precast.WS["Aeolian Edge"].Acc = set_combine(sets.precast.WS["Aeolian Edge"], {})
	-- sets.precast.WS["Aeolian Edge"].MaxAcc = set_combine(sets.precast.WS["Aeolian Edge"].Acc, {})

	-- sets.MaxTP["Aeolian Edge"] = {}
	-- sets.AccMaxTP["Aeolian Edge"] = {}

	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})
		
	-- Ranged sets
	sets.midcast.RA = {
		head="Arcadian Beret +2",neck="Iskur Gorget",ear1="Telos Earring",ear2="Enervating Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Regal Ring",ring2="Ilabrat Ring",
		back=gear.belenus.stp.ranged,waist="Yemaya Belt",legs="Malignance Tights",feet="Adhe. Gamashes +1"
	}

	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		body="Orion Jerkin +2",ring2="Mummu Ring",waist="Kwahu Kachina Belt",feet="Mummu Gamash. +2"
	})
		
	--These sets will overlay based on accuracy level, regardless of other options.
	sets.buff.Camouflage = {body="Orion Jerkin +2"}
	sets.buff.Camouflage.Acc = {}
	sets.buff['Double Shot'] = {body="Oshosi Vest",back=gear.belenus.stp.ranged}
	sets.buff['Double Shot'].Acc = {body="Oshosi Vest",back=gear.belenus.stp.ranged}
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
		back=gear.belenus.stp.melee,waist="Flume Belt",legs="Malignance Tights",feet="Ahosi Leggings"
	}
			
	-- Defense sets
	sets.defense.PDT = {
		head="Malignance Chapeau",ear2="Odnowa Earring +1",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.belenus.stp.melee,legs="Malignance Tights"
	}

	sets.defense.MDT = {
		head="Malignance Chapeau",neck="Warder's Charm +1",ear1="Tuisto Earring",ear2="Odnowa Earring +1",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Purity Ring",ring2="Gelatinous Ring +1",
		back=gear.belenus.stp.melee,legs="Malignance Tights"
	}

	sets.defense.MEVA = {
		head="Malignance Chapeau",neck="Warder's Charm +1",ear1="Eabani Earring",ear2="Odnowa Earring +1",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Purity Ring",ring2="Gelatinous Ring +1",
		back=gear.belenus.stp.melee,legs="Malignance Tights",feet="Ahosi Leggings",
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
		legs="Malignance Tights"
	})

	sets.engaged.Acc = set_combine(sets.engaged, {neck="Lissome Necklace",ear2="Telos Earring",feet=gear.herculean.boots.ta})
	sets.engaged.Acc.HybridDT = set_combine(sets.engaged.HybridDT, {neck="Lissome Necklace",ear2="Telos Earring",feet=gear.herculean.boots.ta})

	sets.engaged.MaxAcc = set_combine(sets.engaged.Acc, {
		head="Carmine Mask +1",ear2="Mache Earring +1",
		ring1="Chirich Ring",ring2="Mummu Ring",
		waist="Grunfeld Rope",legs="Malignance Tights",feet="Mummu Gamash. +2"
	})
	sets.engaged.MaxAcc.HybridDT = set_combine(sets.engaged.Acc.HybridDT, {
		ear2="Mache Earring +1",
		ring2="Mummu Ring",
		waist="Grunfeld Rope",feet="Mummu Gamash. +2"
	})

	sets.engaged.DW = set_combine(sets.engaged, {ear2="Suppanomimi"})
	sets.engaged.DW.HybridDT = set_combine(sets.engaged.DW, {
		head="Malignance Chapeau",neck="Loricate Torque +1",
		hands="Malignance Gloves",ring1="Defending Ring",
		legs="Malignance Tights"
	})

	sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {head="Malignance Chapeau",neck="Lissome Necklace",feet=gear.herculean.boots.ta})
	sets.engaged.DW.Acc.HybridDT = set_combine(sets.engaged.DW.HybridDT, {feet=gear.herculean.boots.ta})

	sets.engaged.DW.MaxAcc = set_combine(sets.engaged.DW.Acc, {
		head="Carmine Mask +1",
		ring1="Chirich Ring",ring2="Mummu Ring",
		waist="Grunfeld Rope",legs="Malignance Tights",feet="Mummu Gamash. +2"
	})
	sets.engaged.DW.MaxAcc.HybridDT = set_combine(sets.engaged.DW.Acc.HybridDT, {
		hands="Malginance Gloves",ring2="Mummu Ring",
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
		state.Weapons:options('MeleeSword','MeleeAxe','Fomalhaut','Gastraphetes','FailNot','Armageddon','Gandiva','TPBonusTrial')
	else
		state.Weapons:options('MeleeSwordDW','MeleeAxeDW','FomalhautDW','GastraphetesDW','FailNotDW','ArmageddonDW','GandivaDW','TPBonusTrialDW')
	end
end

function get_macic_ws_ammo()
	return MagicWSAmmo[player.equipment.range] ~= nil and MagicWSAmmo[player.equipment.range] or DefaultAmmo[player.equipment.main] or "Orichalc. Bullet" or nil
end
