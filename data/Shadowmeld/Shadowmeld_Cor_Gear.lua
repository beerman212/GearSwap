-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal','Acc', 'FullAcc','Crit')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Match','Normal', 'Acc','Proc')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'PDT', 'Refresh')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMax'}
	select_default_weapons()
	state.CompensatorMode:options('300','1000','Never','Always')
	
	gear.RAbullet = "Chrono Bullet"
	gear.WSbullet = "Chrono Bullet"
	gear.MAbullet = "Orichalc. Bullet" --For MAB WS, do not put single-use bullets here.
	gear.QDbullet = "Animikii Bullet"
	options.ammo_warning_limit = 15

	gear.camulus = {}
	gear.camulus.stp = {}
	gear.camulus.stp.melee = {name = "Camulus's Mantle", augments = {'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
	gear.camulus.stp.ranged = {name = "Camulus's Mantle", augments = {'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}

	gear.camulus.wsd = {}
	gear.camulus.wsd.melee = {name = "Camulus's Mantle", augments = {'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	gear.camulus.wsd.ranged = {name = "Camulus's Mantle", augments = {'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Weapon skill damage +10%',}}
	gear.camulus.wsd.mab = {name = "Camulus's Mantle", augments = {'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}}
	gear.camulus.snapshot = {name = "Camulus's Mantle", augments = {'"Snapshot"+10',}}

	-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c elemental quickdraw')

	send_command('bind ^backspace input /ja "Double-up" <me>')
	send_command('bind @backspace input /ja "Snake Eye" <me>')
	send_command('bind !backspace input /ja "Fold" <me>')
	send_command('bind ^@!backspace input /ja "Crooked Cards" <me>')

	send_command('bind ^\\\\ input /ja "Random Deal" <me>')
	send_command('bind !\\\\ input /ja "Bolter\'s Roll" <me>')
	send_command('bind ^@!\\\\ gs c toggle LuzafRing')
	send_command('bind @f7 gs c toggle RngHelper')

	send_command('bind !r gs c weapons SingleWeapon;gs c update')
	send_command('bind @q gs c weapons MaccWeapons;gs c update')
	send_command('bind ^q gs c weapons DualRangedWeapons;gs c update')
	send_command('bind !q gs c weapons SavageWeapons;gs c update')
	send_command('bind @pause roller roll')

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

	sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +1"}
	sets.precast.JA['Snake Eye'] = {legs="Lanun Trews"}
	sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
	sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}
	sets.precast.FoldDoubleBust = {hands="Lanun Gants +1"}

	sets.precast.CorsairRoll = {
		range="Compensator",
		head="Lanun Tricorne +2",neck="Regal Necklace",ear2="Genmei Earring",
		body="Meg. Cuirie +2",hands="Chasseur's Gants",ring1="Defending Ring",ring2="Dark Ring",
		back=gear.camulus.stp.melee,waist="Flume Belt",legs="Mummu Kecks +2",feet="Ahosi Leggings"}

	sets.precast.LuzafRing = {ring2="Luzaf's Ring"}

	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes"})
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chass. Bottes +1"})
	sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne +1"})
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +1"})
	sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants"})
    
	sets.precast.CorsairShot = {ammo=gear.QDbullet,
		head=gear.herculean.helm.magical,neck="Iskur Gorget",ear1="Telos Earring",ear2="Enervating Earring",
		body="Mummu Jacket +2",hands="Leyline Gloves",ring1="Ilabrat Ring",ring2="Petrov Ring",
		back=gear.camulus.stp.ranged,waist="Kwahu Kachina Belt",legs="Chas. Culottes",feet="Carmine Greaves +1"}
		
	sets.precast.CorsairShot.Damage = set_combine(sets.precast.CorsairShot, {
		neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Lanun Frac +3",hands="Carmine Fin. Ga. +1",ring1="Shiva Ring +1",ring2="Dingir Ring",
		back=gear.camulus.wsd.mab,waist="Eschan Stone",legs=gear.herculean.trousers.magical,feet="Lanun Bottes +3"})
	
	sets.precast.CorsairShot.Proc = {ammo=gear.RAbullet,
		head="Wh. Rarab Cap +1",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Sanare Earring",
		body="Emet Harness +1",hands=gear.herculean.gloves.magical,ring1="Defending Ring",ring2="Dark Ring",
		back="Moonlight Cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Chass. Bottes +1"}

	sets.precast.CorsairShot['Light Shot'] = {ammo=gear.QDbullet,
		head="Carmine Mask +1",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Gwati Earring",
		body="Mummu Jacket +2",hands="Leyline Gloves",ring1="Stikini Ring",ring2="Dingir Ring",
		back=gear.camulus.wsd.mab,waist="Eschan Stone",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"}

	sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {feet="Chass. Bottes +1"})

    -- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Carmine Mask +1",neck="Loricate Torque +1",ear2="Genmei Earring",
		body="Lanun Frac +3",hands="Carmine Fin. Ga. +1",ring1="Defending Ring",ring2="Dark Ring",
		back=gear.camulus.stp.melee,waist="Flume Belt",legs="Mummu Kecks +2",feet="Rawhide Boots"}
		
	sets.Self_Waltz = {head="Mummu Bonnet +2",}
        
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
    
	sets.precast.FC = {
		head="Carmine Mask +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
		back=gear.camulus.stp.melee,waist="Flume Belt",legs="Limbo Trousers",feet="Carmine Greaves +1"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear2="Mendi. Earring"})

	sets.precast.RA = {ammo=gear.RAbullet,
		head="Taeon Chapeau",
		body="Oshosi Vest",hands="Carmine Fin. Ga. +1",
		back=gear.camulus.snapshot,waist="Impulse Belt",legs="Adhemar Kecks",feet="Meg. Jam. +2"}
		
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {body="Laksa. Frac +3",waist="Yemaya Belt"})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {head="Chass. Tricorne +1",waist="Impulse Belt",feet="Pursuer's Gaiters"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Lanun Tricorne +2",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body="Laksa. Frac +3",hands="Meg. Gloves +2",ring1="Epaminondas's Ring",ring2="Shukuyu Ring",
		back=gear.camulus.wsd.melee,waist="Fotia Belt",legs=gear.herculean.trousers.strwsd,feet="Lanun Bottes +3"}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		ear1="Meghanada Visor +2",
		body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring2="Ilabrat Ring",
		back=gear.camulus.wsd.melee,waist="Grunfeld Rope",legs="Carmine Cuisses +1",feet="Lanun Bottes +3"})	
		
	sets.precast.WS.Proc = set_combine(sets.precast.WS, {
		head="Carmine Mask +1",ear2="Digni. Earring",
		body="Mummu Jacket +2",hands="Floral Gauntlets",ring1="Ilabrat Ring",ring2="Ramuh Ring",
		back=gear.camulus.stp.melee,waist="Grunfeld Rope",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"})
		
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
		head="Carmine Mask +1",ear1="Telos Earring",
		body="Meg. Cuirie +2",ring1="Stikini Ring",ring2="Ilabrat Ring",
		legs="Meg. Chausses +2",feet="Carmine Greaves +1"})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {ear2="Digni. Earring",legs="Carmine Cuisses +1"})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {head=gear.herculean.helm.strwsd,neck="Caro Necklace",waist="Grunfeld Rope"})

	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
		head="Carmine Mask +1",body="Meg. Cuirie +2",legs="Carmine Cuisses +1"})

	sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, 
		{ammo=gear.WSbullet,ring2="Dingir Ring",back=gear.camulus.wsd.ranged,legs="Meg. Chausses +2"})

	sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], 
		{head="Meghanada Visor +2",neck="Iskur Gorget",ear1="Telos Earring",})
		
	sets.precast.WS['Detonator'] = sets.precast.WS['Last Stand']
	sets.precast.WS['Detonator'].Acc = sets.precast.WS['Last Stand'].Acc
	sets.precast.WS['Slug Shot'] = sets.precast.WS['Last Stand']
	sets.precast.WS['Slug Shot'].Acc = sets.precast.WS['Last Stand'].Acc
	sets.precast.WS['Numbing Shot'] = sets.precast.WS['Last Stand']
	sets.precast.WS['Numbing Shot'].Acc = sets.precast.WS['Last Stand'].Acc
	sets.precast.WS['Sniper Shot'] = sets.precast.WS['Last Stand']
	sets.precast.WS['Sniper Shot'].Acc = sets.precast.WS['Last Stand'].Acc
	sets.precast.WS['Split Shot'] = sets.precast.WS['Last Stand']
	sets.precast.WS['Split Shot'].Acc = sets.precast.WS['Last Stand'].Acc
	
	sets.precast.WS['Leaden Salute'] = {ammo=gear.MAbullet,
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Moonshade Earring",
		body="Lanun Frac +3",hands="Carmine Fin. Ga. +1",ring1="Dingir Ring",ring2="Archon Ring",
		back=gear.camulus.wsd.mab,waist="Eschan Stone",legs=gear.herculean.trousers.magical,feet="Lanun Bottes +3"}

	sets.precast.WS['Leaden Salute'].Acc = set_combine(sets.precast.WS['Leaden Salute'], 
		{head=gear.herculean.helm.magical,hands="Leyline Gloves"})

	sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS['Leaden Salute'], 
		{head=gear.herculean.helm.magical,ring2="Ilabrat Ring"})

	sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS['Wildfire'], 
		{hands="Leyline Gloves"})

	sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']
	sets.precast.WS['Hot Shot'].Acc = sets.precast.WS['Wildfire'].Acc
		
		--Because omen skillchains.
	sets.precast.WS['Burning Blade'] = {
		head="Meghanada Visor +2",neck="Loricate Torque +1",ear1="Genmei Earring",
		body="Meg. Cuirie +2",hands=gear.adhemar.wrist.path_b,ring1="Defending Ring",ring2="Dark Ring",
		back=gear.camulus.stp.melee,waist="Flume Belt",legs="Meg. Chausses +2",feet="Ahosi Leggings"}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Telos Earring",ear2="Ishvara Earring"}
	sets.AccMaxTP = {ear1="Telos Earring",ear2="Digni. Earring"}
	
	sets.MagicalMaxTP = {ear2="Hecate's Earring"}
	sets.MagicalAccMaxTP = {ear2="Digni. Earring"}
	
	sets.RangedMaxTP = {ear1="Telos Earring",ear2="Ishvara Earring"}
	sets.RangedAccMaxTP = {ear1="Telos Earring",ear2="Enervating Earring"}
        
	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})
        
	-- Specific spells

	sets.midcast.Cure = {
		head="Carmine Mask +1",neck="Loricate Torque +1",ear1="Enchntr. Earring +1",ear2="Mendi. Earring",
		body="Lanun Frac +3",hands="Leyline Gloves",ring1="Stikini Ring",ring2="Lebeche Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"}

	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

	sets.midcast.Utsusemi = sets.midcast.FastRecast

	-- Ranged gear
	sets.midcast.RA = {ammo=gear.RAbullet,
		head="Meghanada Visor +2",neck="Iskur Gorget",ear1="Telos Earring",ear2="Enervating Earring",
		body="Oshosi Vest",hands=gear.adhemar.wrist.path_c,ring1="Dingir Ring",ring2="Ilabrat Ring",
		back=gear.camulus.stp.ranged,waist="Yemaya Belt",legs="Adhemar Kecks",feet="Adhe. Gamashes +1"}

	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		body="Laksa. Frac +3",ring2="Mummu Ring",waist="Kwahu Kachina Belt",legs="Mummu Kecks +2",feet="Meg. Jam. +2"})
		
	sets.buff['Triple Shot'] = {body="Chasseur's Frac +1"}
    
	-- Sets to return to when not performing an action.

	sets.DayIdle = {}
	sets.NightIdle = {}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    
	
    

	-- Idle sets
	sets.idle = {ammo=gear.RAbullet,
		head="Dampening Tam",neck="Loricate Torque +1",ear1="Enchntr. Earring +1",ear2="Genmei Earring",
		body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Dark Ring",
		back=gear.camulus.stp.melee,waist="Flume Belt",legs="Mummu Kecks +2",feet="Ahosi Leggings"}
		
	sets.idle.Refresh = set_combine(sets.idle, {})
    
	-- Defense sets
	sets.defense.PDT = set_combine(sets.idle, {head="Dampening Tam"})

	sets.defense.MDT = {
		head="Dampening Tam",neck="Loricate Torque +1",
		body="Mummu Jacket +2",hands="Mummu Wrists +2",ring1="Defending Ring",ring2="Dark Ring",
		back=gear.camulus.wsd.melee,waist="Flume Belt",legs="Mummu Kecks +2",feet="Ahosi Leggings"}

	sets.defense.MEVA = {
		head="Mummu Bonnet +2",neck="Loricate Torque +1",
		body="Mummu Jacket +2",hands="Mummu Wrists +2",ring1="Defending Ring",ring2="Dark Ring",
		back=gear.camulus.wsd.melee,waist="Flume Belt",legs="Mummu Kecks +2",feet="Ahosi Leggings"}

	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.DWMax = {ear1="Suppanomimi",body="Adhemar Jacket +1",hands="Floral Gauntlets",legs="Carmine Cuisses +1",feet="Rawhide Boots"}
	
	-- Resting sets
	sets.resting = sets.idle

	-- Weapons sets
	sets.weapons.Default = {main="Naegling",sub="Nusku Shield",range="Fomalhaut",ammo=RAbullet}
	sets.weapons.RangedLastStand = {main="Fettering Blade",sub="Nusku Shield",range="Fomalhaut",ammo=RAbullet}
	sets.weapons.RangedLeaden = {main="Fettering Blade",sub="Nusku Shield",range="Fomalhaut",ammo=RAbullet}
	sets.weapons.SavageTPBonus = {main="Naegling",sub="Nusku Shield",range="Anarchy +2"}
	sets.weapons.EviscerationTPBonus = {main="Kaja Knife",sub="Nusku Shield",range="Anarchy +2"}
	
	sets.weapons.DefaultDW = {main="Naegling",sub="Kaja Knife",range="Fomalhaut",ammo=RAbullet}
	sets.weapons.RangedLastStandDW = {main="Kustawi +1",sub="Fettering Blade",range="Fomalhaut",ammo=RAbullet}
	sets.weapons.RangedLeadenDW = {main="Naegling",sub="Fettering Blade",range="Fomalhaut",ammo=RAbullet}
	sets.weapons.SavageDW = {main="Naegling",sub="Blurred Knife +1",range="Anarchy +2"}
	sets.weapons.EviscerationDW = {main="Kaja Knife",sub="Blurred Knife +1",range="Anarchy +2"}
	
	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {
		head="Adhemar Bonnet +1",neck="Iskur Gorget",ear1="Telos Earring",ear2="Cessance Earring",
		body="Adhemar Jacket +1",hands=gear.adhemar.wrist.path_b,ring1="Petrov Ring",ring2="Epona's Ring",
		back=gear.camulus.stp.melee,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean.boots.ta}

	sets.engaged.Acc = set_combine(sets.engaged, {
		head="Carmine Mask +1",neck="Decimus Torque",
		waist="Grunfeld Rope",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"})
		
	sets.engaged.Crit = set_combine(sets.engaged, {ring1="Hetairoi Ring",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"})

	sets.engaged.DW = set_combine(sets.engaged, {ear2="Suppanomimi",})

	sets.engaged.DW.Acc = set_combine(sets.engaged.DW, 
		{head="Carmine Mask +1",ear2="Cessance Earring",waist="Grunfeld Rope",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"})
		
	sets.engaged.DW.Crit = set_combine(sets.engaged.DW,
		{ring1="Hetairoi Ring",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"})

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'NIN' then
        set_macro_page(1, 6)
    elseif player.sub_job == 'DNC' then
		set_macro_page(1, 6)
    elseif player.sub_job == 'RNG' then
        set_macro_page(1, 6)
    else
        set_macro_page(1, 6)
    end   
end

function lockstyle()
	windower.chat.input("/lockstyleset 008")
end

function select_default_weapons()
	if not S{"NIN", "DNC"}:contains(player.sub_job) then
		state.Weapons:options("Default","RangedLastStand","RangedLeaden","SavageTPBonus","EviscerationTPBonus")
	else
		state.Weapons:options("DefaultDW","RangedLastStandDW","RangedLeadenDW","SavageDW","EviscerationDW")
	end
end