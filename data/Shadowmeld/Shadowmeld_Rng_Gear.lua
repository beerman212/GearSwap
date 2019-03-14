-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal','Acc')
	state.RangedMode:options('Normal','Acc')
	state.WeaponskillMode:options('Match','Normal', 'Acc')
	state.IdleMode:options('Normal', 'PDT')
	
	select_default_weapons()
	
	DefaultAmmo = {['Fomalhaut']="Chrono Bullet",['Fail-Not']="Chrono Arrow"}
	U_Shot_Ammo = {['Fomalhaut']="Animkii Bullet"}
	MagicWSAmmo = {['Fomalhaut']="Orichalc. Bullet"}
	
	gear.tp_ranger_jse_back = {name="Belenus's Cape",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	gear.wsd_ranger_jse_back = {name="Belenus's Cape",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}}
	gear.da_jse_back = {name = "Belenus's Cape", augments = {'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}}
	gear.stp_ranged_jse_back = {name = "Belenus's Cape", augments = {'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	gear.wsd_ranged_jse_back = {name = "Belenus's Cape", augments = {'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
	gear.wsd_magic_jse_back = {name = "Belenus's Cape", augments = {'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	gear.crit_ranged_jse_back = {name = "Belenus's Cape", augments = {'DEX+20','Rng.Acc.+20 Rng.Atk.+20','Crit.hit rate+10',}}
	gear.snapshot_jse_back = {name = "Belenus's Cape", augments = {'"Snapshot"+10',}}
	
	-- Additional local binds
	send_command('bind !` input /ra <t>')
	send_command('bind !backspace input /ja "Bounty Shot" <t>')
	send_command('bind @f7 gs c toggle RngHelper')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !r gs c cycle weapons;gs c update')
	send_command('bind ^q gs c weapons SingleWeapon;gs c update')
	
	select_default_macro_book()

end

-- Set up all gear sets.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	
	
	-- Precast sets to enhance JAs
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.precast.JA['Bounty Shot'] = set_combine(sets.TreasureHunter, {hands="Amini Glove. +1"})
	sets.precast.JA['Camouflage'] = {body="Orion Jerkin +2"}
	sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +2"}
	sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +2"}
	sets.precast.JA['Double Shot'] = {back=gear.da_jse_back}


	-- Fast cast sets for spells

	sets.precast.FC = {
		head="Carmine Mask +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Defending Ring",ring2="Lebeche Ring",
		back=gear.da_jse_back,waist="Flume Belt",legs="Limbo Trousers",feet="Carmine Greaves +1"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


	-- Ranged sets (snapshot)
	
	sets.precast.RA = {
		head=gear.taeon_chapeau_snapshot,
		body="Oshosi Vest",hands="Carmine Fin. Ga. +1",
		back=gear.snapshot_jse_back,waist="Impulse Belt",legs="Adhemar Kecks",feet="Meg. Jam. +2"}
		
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {body="Amini Caban +1",waist="Yemaya Belt"})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, sets.precast.RA.Flurry, {head="Arcadian Beret +2",waist="Impulse Belt",feet="Pursuer's Gaiters"})


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Orion Beret +2",neck="Fotia Gorget",ear1="Telos Earring",ear2="Moonshade Earring",
		body=gear.herculean_vest_agiwsd,hands="Meg. Gloves +2",ring1="Epaminondas's Ring",ring2="Dingir Ring",
		back=gear.agi_wsd_jse_back,waist="Fotia Belt",legs="Meg. Chausses +2",feet=gear.herculean_boots_agiwsd}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {body="Orion Jerkin +2",feet="Meg. Jam. +2"})

	-- Gun/Xbow
	sets.precast.WS["Last Stand"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Last Stand"].Acc = set_combine(sets.precast.WS["Last Stand"], {body="Orion Jerkin +2",feet="Meg. Jam. +2"})

	sets.precast.WS['Wildfire'] = {ammo=get_macic_ws_ammo(),
		head=gear.herculean_helm_magical,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Samnuha Coat",hands="Carmine Fin. Ga. +1",ring1="Epaminondas's Ring",ring2="Dingir Ring",
		back=gear.wsd_magic_jse_back,waist="Eschan Stone",legs=gear.herculean_trousers_magical,feet=gear.herculean_boots_magical}

	sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS.Wildfire, {ear2="Digni. Earring",hands="Leyline Gloves"})
	
	sets.precast.WS['Trueflight'] = set_combine(sets.precast.WS.Wildfire, {ear2="Moonshade Earring"})

	sets.precast.WS['Trueflight'].Acc = set_combine(sets.precast.WS.Trueflight, {hands="Leyline Gloves"})
	
	sets.precast.WS['Hot Shot'] = set_combine(sets.precast.WS, {ear1="Friomisi Earring",hands="Carmine Fin. Ga. +1"})
	sets.precast.WS['Hot Shot'].Acc = set_combine(sets.precast.WS['Hot Shot'], {hands="Leyline Gloves"})
	
	-- Bow
	sets.precast.WS["Jishnu's Radiance"] = set_combine(sets.precast.WS, {
		head="Adhemar Bonnet +1",ear1="Sherida Earring",
		body="Meg. Cuirie +2",hands="Mummu Wrists +2",ring2="Ilabrat Ring",
		back=gear.crit_ranged_jse_back,legs="Darraigner's Brais",feet="Adhe. Gamashes +1"
	})
	sets.precast.WS["Jishnu's Radiance"].Acc = set_combine(sets.precast.WS["Jishnu's Radiance"], {
		head="Orion Beret +2",legs=gear.herculean_trousers_ranged_crit,feet="Meg. Jam. +2"})
	
	sets.precast.WS["Refulgent Arrow"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Refulgent Arrow"].Acc = set_combine(sets.precast.WS["Refulgent Arrow"], {})
	
	sets.precast.WS["Apex Arrow"] = set_combine(sets.precast.WS, {ear1="Ishvara Earring"})
	sets.precast.WS["Apex Arrow"].Acc = set_combine(sets.precast.WS["Apex Arrow"], {
		ear1="Telos Earring",body="Orion Jerkin +2",feet="Meg. Jam. +2"})
	
	sets.precast.WS.Decimation = set_combine(sets.precast.WS, {
		head="Adhemar Bonnet +1",ear2="Sherida Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar_wrist_path_a,ring1="Shukuyu Ring",ring2="Ilabrat Ring",
		back=gear.da_jse_back,legs="Meg. Chausses +2",feet=gear.herculean_boots_ta})
	sets.precast.WS.Decimation.Acc = set_combine(sets.precast.WS.Decimation, {
		head="Carmine Mask +1",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"})
	
	sets.precast.WS.Evisceration = set_combine(sets.precast.WS, {
		head="Adhemar Bonnet +1",ear1="Sherida Earring",
		body="Abnoba Kaftan",hands=gear.adhemar_wrist_path_a,ring1="Ilabrat Ring",ring2="Mummu Ring",
		back=gear.da_jse_back,legs="Samnuha Tights",feet="Mummu Gamashes +2"})
	sets.precast.WS.Evisceration.Acc = set_combine(sets.precast.WS.Evisceration, {
		head="Carmine Mask +1",body="Meg. Cuirie +2",legs="Carmine Cuisses +1"})
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear2="Enervating Earring"}
	sets.AccMaxTP = {ear2="Enervating Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.Trueflight = {}
	sets.Trueflight.MaxTP = {ear2="Hecate's Earring"}
	sets.Trueflight.AccMaxTP = {ear2="Digni. Earring"}
	
	sets.Evisceration = {}
	sets.Evisceration.MaxTP = {ear1="Telos Earring",ear2="Sherida Earring"}

	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})
		
	-- Ranged sets

	sets.midcast.RA = {
		head="Arcadian Beret +2",neck="Iskur Gorget",ear1="Telos Earring",ear2="Enervating Earring",
		body="Oshosi Vest",hands=gear.adhemar_wrist_path_c,ring1="Ilabrat Ring",ring2="Dingir Ring",
		back=gear.stp_ranged_jse_back,waist="Yemaya Belt",legs="Adhemar Kecks",feet="Adhe. Gamashes +1"}

	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		ear2="Enervating Earring",
		body="Orion Jerkin +2",ring1="Mummu Ring",
		waist="Kwahu Kachina Belt",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"})
		
	--These sets will overlay based on accuracy level, regardless of other options.
	sets.buff.Camouflage = {body="Orion Jerkin +2"}
	sets.buff.Camouflage.Acc = {}
	sets.buff['Double Shot'] = {body="Oshosi Vest",back=gear.stp_ranged_jse_back}
	sets.buff['Double Shot'].Acc = {body="Oshosi Vest",back=gear.stp_ranged_jse_back}
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
		head="Dampening Tam",neck="Loricate Torque +1",ear2="Genmei Earring",
		body="Meg. Cuirie +2",hands="Meghanada Gloves +2",ring1="Defending Ring",ring2=gear.dark_ring_dt,
		back=gear.da_jse_back,waist="Flume Belt",legs="Mummu Kecks +2",feet="Ahosi Leggings"}
			
			-- Defense sets
	sets.defense.PDT = {
		head="Meghanada Visor +2",neck="Loricate Torque +1",ear2="Genmei Earring",
		body="Meg. Cuirie +2",hands="Meghanada Gloves +2",ring1="Defending Ring",ring2="Gelatinous Ring",
		back=gear.da_jse_back,waist="Flume Belt",legs="Mummu Kecks +2",feet="Ahosi Leggings"}

	sets.defense.MDT = {
		head="Dampening Tam",neck="Loricate Torque +1",
		body="Mummu Jacket +2",hands="Mummu Wrists +2",ring1="Defending Ring",ring2="Dark Ring",
		back=gear.da_jse_back,waist="Flume Belt",legs="Mummu Kecks +2",feet="Ahosi Leggings"}

	sets.defense.MEVA = {
		head="Mummu Bonnet +2",neck="Loricate Torque +1",
		body="Mummu Jacket +2",hands="Mummu Wrists +2",ring1="Defending Ring",ring2="Dark Ring",
		back=gear.da_jse_back,waist="Flume Belt",legs="Mummu Kecks +2",feet="Ahosi Leggings"}

	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.Kiting.DWMax = {ear1="Suppanomimi",body="Adhemar Jacket +1",hands="Floral Gauntlets",waist="Patentia Sash",legs="Carmine Cuisses +1",feet="Rawhide Boots"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	-- Weapons sets	
	sets.weapons.Default = {main="Perun +1",sub="Nusku Shield",range="Fomalhaut",ammo=DefaultAmmo.Fomalhaut}
	sets.weapons.MagicRanged = {main="Malevolence",sub="Nusku Shield",range="Fomalhaut",ammo=DefaultAmmo.Fomalhaut}
	sets.weapons.MagicMelee = {main="Kaja Knife",sub="Nusku Shield",range="Fomalhaut",ammo=DefaultAmmo.Fomalhaut}
	sets.weapons.Jinshus = {main="Perun +1",sub="Nusku Shield",range="Vijaya Bow",ammo=DefaultAmmo["Fail-Not"]}
	sets.weapons.DaggerTPBonus = {main="Kaja Knife",sub="Nusku Shield",range="Anarchy +2",ammo=DefaultAmmo.Fomalhaut}
	sets.weapons.AxeTPBonus = {main="Kaja Axe",sub="Nusku Shield",range="Anarchy +2",ammo=DefaultAmmo.Fomalhaut}
	
	sets.weapons.DefaultDW = {main="Perun +1",sub="Perun",range="Fomalhaut",ammo=DefaultAmmo.Fomalhaut}
	sets.weapons.MagicRangedDW = {main="Malevolence",sub="Malevolence",range="Fomalhaut",ammo=DefaultAmmo.Fomalhaut}
	sets.weapons.MagicMeleeDW = {main="Kaja Knife",sub="Malevolence",range="Fomalhaut",ammo=DefaultAmmo.Fomalhaut}
	sets.weapons.DaggerTPBonusDW = {main="Kaja Knife",sub="Ternion Dagger +1",range="Anarchy +2",ammo=DefaultAmmo.Fomalhaut}
	sets.weapons.AxeTPBonusDW = {main="Kaja Axe",sub="Vampirism",range="Anarchy +2",ammo=DefaultAmmo.Fomalhaut}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Normal melee group
	sets.engaged = {
		head="Adhemar Bonnet +1",neck="Iskur Gorget",ear1="Telos Earring",ear2="Sherida Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar_wrist_path_a,ring1="Petrov Ring",ring2="Epona's Ring",
		back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_boots_ta}

	sets.engaged.Acc = {
		head="Carmine Mask +1",neck="Lissome Necklace",ear1="Telos Earring",ear2="Sherida Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar_wrist_path_a,ring1="Chirich Ring",ring2="Epona's Ring",
		back=gear.da_jse_back,waist="Grunfeld Rope",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"}

	sets.engaged.DW = {
		head="Adhemar Bonnet +1",neck="Iskur Gorget",ear1="Suppanomimi",ear2="Sherida Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar_wrist_path_a,ring1="Petrov Ring",ring2="Epona's Ring",
		back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_boots_ta}

	sets.engaged.DW.Acc = {
		head="Carmine Mask +1",neck="Lissome Necklace",ear1="Telos Earring",ear2="Sherida Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar_wrist_path_a,ring1="Chirich Ring",ring2="Epona's Ring",
		back=gear.da_jse_back,waist="Grunfeld Rope",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 12)
end

function select_default_weapons()
	if not S{"NIN","DNC"}:contains(player.sub_job) then
		state.Weapons:options('Default','MagicRanged','MagicMelee','DaggerTPBonus')
	else
		state.Weapons:options('DefaultDW','MagicRangedDW','MagicMeleeDW','DaggerTPBonusDW')
	end
end

function get_macic_ws_ammo()
	return MagicWSAmmo[player.equipment.range] ~= nil and MagicWSAmmo[player.equipment.range] or DefaultAmmo[player.equipment.main] or nil
end
