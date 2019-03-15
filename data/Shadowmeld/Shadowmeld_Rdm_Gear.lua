function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal', 'PDT', 'MDT', 'TPEat','DTHippo')
    state.PhysicalDefenseMode:options('PDT', 'NukeLock')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','Sequence','DualWeapons')
	
	gear.stp_jse_cape = {name = "Sucellos's Cape", augments = {'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
	gear.str_wsd_jse_cape = {name = "Sucellos's Cape", augments = {'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	gear.dex_crit_jse_cape = {name = "Sucellos's Cape", augments = {'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}}
	gear.int_matk_jse_cape = {name = "Sucellos's Cape", augments = {'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}
	gear.mnd_fc_jse_cape = {name = "Sucellos's Cape", augments = {'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
	
	gear.colada_enhancing = {name = "Colada", augments = {'Enh. Mag. eff. dur. +4','MND+2','Mag. Acc.+15','"Mag.Atk.Bns."+18',}}
	gear.colada_refresh = {}
	
	gear.obi_cure_back = gear.mnd_fc_jse_cape
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_back = gear.int_matk_jse_cape
	gear.obi_low_nuke_waist = "Refoccilation Stone"

	gear.obi_high_nuke_back = gear.int_matk_jse_cape
	gear.obi_high_nuke_waist = "Refoccilation Stone"

		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` input /ja "Accession" <me>')
	send_command('bind ^backspace input /ja "Saboteur" <me>')
	send_command('bind !backspace input /ja "Spontaneity" <t>')
	send_command('bind @backspace input /ja "Composure" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind != input /ja "Penury" <me>')
	send_command('bind @= input /ja "Parsimony" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise" <me>')
	send_command('bind @f10 gs c cycle RecoverMode')
	
	select_default_macro_book()
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = {body="Viti. Tabard +3"}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {ammo="Impatiens",
		head="Atro. Chapeau +2",neck="Loricate Torque +1",ear1="Enchntr. Earring +1",ear2="Etiolation Earring",
		body="Viti. Tabard +3",hands="Aya. Manopolas +2",ring1="Defending Ring",ring2="Lebeche Ring",
		back="Perimede Cape",waist="Witful Belt",legs="Aya. Cosciales +2",feet="Carmine Greaves +1"}
		
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {
		head=empty,neck="Voltsurge Torque",ear2="Loquac. Earring",
		body="Twilight Cloak",hands="Leyline Gloves",ring1="Kishar Ring",
		back=gear.mnd_fc_jse_cape})
       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Ginsen",
		head="Viti. Chapeau +2",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Sherida Earring",
		body="Viti. Tabard +3",hands="Jhakri Cuffs +2",ring1="Epaminondas's Ring",ring2="Shukuyu Ring",
		back=gear.str_wsd_jse_cape,waist="Fotia Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ammo="Regal Gem",
		ear1="Telos Earring",ring1="Stikini Ring"})
		
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {ammo="Regal Gem",ear1="Telos Earring",ring1="Ilabrat Ring",ring2="Jhakri Ring"})
	
	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {ammo="Yetshila",
		head="Aya. Zucchetto +2",ear1="Telos Earring",
		hands="Taeon Gloves",ring1="Ilabrat Ring",ring2="Ramuh Ring",
		back=gear.dex_crit_jse_cape,legs="Taeon Tights",feet="Aya. Gambieras +2"})
		
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {
		hands="Aya. Manopolas +2",legs="Aya. Cosciales +2"})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {ammo="Regal Gem",
		neck="Caro Necklace",ear1="Moonshade Earring",waist="Grunfeld Rope"})
	
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
		ring2="Ilabrat Ring"})
		
	sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Friomisi Earring",
		body=gear.merlinic_jubbah_magical,hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Archon Ring",
		back=gear.int_matk_jse_cape,waist="Eshcan Stone",legs=gear.merlinic_shalwar_magical,feet=gear.merlinic_crackows_magical}

	
	-- Midcast Sets

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.chironic_treasure_feet})
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {}
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {head="Ea Hat",neck="Mizu. Kubikazari",body="Ea Houppelande",hands="Amalric Gages +1",ring1="Mujin Band",legs="Ea Slops",feet="Jhakri Pigaches +2"}
	
	sets.RecoverBurst = set_combine(sets.MagicBurst, {})
	
	-- Gear for specific elemental nukes.
	sets.element.Wind = {}
	sets.element.Ice = {}
	sets.element.Earth = {}

	sets.midcast.FastRecast = set_combine(sets.precast.FC, {hands="Leyline Gloves"})

    sets.midcast.Cure = {ammo="Regal Gem",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Enchntr. Earring +1",ear2="Mendi. Earring",
		body="Viti. Tabard +3",hands="Kaykaus Cuffs",ring2="Lebeche Earring",
		back=gear.mnd_fc_jse_cape,waist="Luminary Sash",legs="Atrophy Tights +2",feet="Vanya Clogs"}
		
    sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {main="Chatoyant Staff",sub="Enki Strap",
		hands="Leyline Gloves",back="Twilight Cape",waist="Hachirin-no-Obi",})
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {back="Twilight Cape",waist="Hachirin-no-Obi"})
		
	sets.midcast.Cursna =  set_combine(sets.midcast.FastRecast, {neck="Malison Medallion",body="Viti. Tabard +3",ring1="Ephedra Ring",ring2="Sirona's Ring",legs="Atrophy Tights +2",feet="Vanya Clogs"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
		
	sets.midcast.Curaga = sets.midcast.Cure
	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

	sets.midcast['Enhancing Magic'] = {main=gear.colada_enhancing,sub="Ammurapi Shield",
		head=gear.telchine_cap_enhancing_duration,neck="Duelist's Torque",ear1="Andoaa Earring",
		body="Viti. Tabard +3",hands="Atrophy Gloves +2",ring2="Stikini Ring",
		back="Ghostfyre Cape",waist="Olympus Sash",legs=gear.telchine_braconi_enhancing_duration,feet="Leth. Houseaux +1"}

	--Atrophy Gloves are better than Lethargy for me despite the set bonus for duration on others.		
	sets.buff.ComposureOther = {head="Leth. Chappel +1",
		body="Lethargy Sayon +1",
		legs="Leth. Fuseau +1",feet="Leth. Houseaux +1"}
		
	--Red Mage enhancing sets are handled in a different way from most, layered on due to the way Composure works
	--Don't set combine a full set with these spells, they should layer on Enhancing Set > Composure (If Applicable) > Spell
	sets.midcast.Refresh = {body="Atrophy Tabard +2",legs="Leth. Fuseau +1"}
	sets.midcast.Aquaveil = {}
	sets.midcast.BarElement = {}
	sets.midcast.Stoneskin = {neck="Nodens Gorget",waist="Siegel Sash"}
	sets.midcast.Protect = {ring2="Sheltered Ring"}
	sets.midcast.Shell = {ring2="Sheltered Ring"}
	sets.midcast.Enspell = {head="Befouled Crown",neck="Incanter's Torque",hands="Viti. Gloves +2",legs="Atrophy Tights +2"}
	sets.midcast.Temper = {head="Befouled Crown",neck="Incanter's Torque",hands="Viti. Gloves +2",legs="Atrophy Tights +2"}
	sets.midcast['Temper II'] = {head="Befouled Crown",neck="Incanter's Torque",hands="Viti. Gloves +2",legs="Atrophy Tights +2"}
	
	sets.midcast['Enfeebling Magic'] = {main="Kaja Sword",sub="Ammurapi Shield",range="Kaja Bow",ammo=empty,
		head="Atro. Chapeau +2",neck="Duelist's Torque",ear1="Regal Earring",ear2="Digni. Earring",
		body="Atrophy Tabard +2",hands="Kaykaus Cuffs",ring1="Kishar Ring",ring2="Stikini Ring",
		back=gear.mnd_fc_jse_cape,waist="Luminary Sash",legs=gear.chironic_hose_enfeeble,feet="Skaoi Boots"}
		
	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {
		main=gear.grioavolr_enfeebling,sub="Enki Strap",range=empty,sub="Regal Gem",
		head="Viti. Chapeau +2",body="Leth. Sayon +1",back=gear.int_matk_jse_cape,waist="Rumination Sash"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {
		main=gear.grioavolr_enfeebling,sub="Enki Strap",range=empty,sub="Regal Gem",
		head="Viti. Chapeau +2",body="Leth. Sayon +1",back=gear.int_matk_jse_cape,waist="Rumination Sash"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {
		main=gear.grioavolr_enfeebling,sub="Enki Strap",range=empty,sub="Regal Gem",
		head="Viti. Chapeau +2",body="Leth. Sayon +1"})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {
		main=gear.grioavolr_enfeebling,sub="Enki Strap",range=empty,sub="Regal Gem",
		head="Viti. Chapeau +2",body="Leth. Sayon +1"})
	
	sets.midcast['Distract III'] = set_combine(sets.midcast.MndEnfeebles, {})
	sets.midcast['Distract III'].Resistant = set_combine(sets.midcast.MndEnfeebles.Resistant, {})
	
	sets.midcast['Frazzle II'] = sets.midcast['Enfeebling Magic']
	sets.midcast['Frazzle II'].Resistant = sets.midcast['Enfeebling Magic'].Resistant
	
	sets.midcast['Frazzle III'] = set_combine(sets.midcast.MndEnfeebles, {})
	sets.midcast['Frazzle III'].Resistant = set_combine(sets.midcast.MndEnfeebles.Resistant, {})
	
	sets.midcast.Silence = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.Silence.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})	
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Viti. Chapeau +1",waist="Chaac Belt"})
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio III'] = set_combine(sets.midcast['Enfeebling Magic'], {})

	sets.midcast['Slow II'] = set_combine(sets.midcast.MndEnfeebles, {head="Viti. Chapeau +1"})
	sets.midcast['Slow II'].Resistant = set_combine(sets.midcast.MndEnfeebles.Resistant, {head="Viti. Chapeau +1"})
	
	sets.midcast['Paralyze II'] = set_combine(sets.midcast.MndEnfeebles, {feet="Vitiation Boots +1"})
	sets.midcast['Paralyze II'].Resistant = set_combine(sets.midcast.MndEnfeebles.Resistant, {feet="Vitiation Boots +1"})
	
	sets.midcast['Poison'] = set_combine(sets.midcast.IntEnfeebles, {})
	sets.midcast['Poison'].Resistant = set_combine(sets.midcast.IntEnfeebles.Resistant, {})
	sets.midcast['Poison II'] = set_combine(sets.midcast.IntEnfeebles, {})
	sets.midcast['Poison II'].Resistant = set_combine(sets.midcast.IntEnfeebles.Resistant, {})
	
    sets.midcast['Elemental Magic'] = {main=gear.grioavolr_nuke,sub="Enki Strap",ammo="Pemphredo Tathlum",
		head=gear.merlinic_hood_magical,neck="Sanctity Necklace",ear1="Regal Earring",ear2="Friomisi Earring",
		body=gear.merlinic_jubbah_magical,hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring",
		back=gear.int_matk_jse_cape,waist="Refoccilation Stone",legs=gear.merlinic_shalwar_magical,feet=gear.merlinic_crackows_magical}
		
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})
		
    sets.midcast['Elemental Magic'].Fodder = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast['Elemental Magic'].Proc = set_combine(sets.midcast.FastRecast, {})
		
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
		
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'].Resistant, {
		head=empty,body="Twilight Cloak"})

	sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Ammurapi Shield",range="Kaja Bow",ammo=empty,
		head="Atro. Chapeau +2",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Atrophy Tabard +2",hands="Amalric Gages +1",ring1="Evanescence Ring",ring2="Stikini Ring",
		back=gear.int_matk_jse_cape,waist="Luminary Sash",legs=gear.chironic_hose_enfeeble,feet=gear.merlinic_crackows_magical}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {waist="Fucho-no-obi",feet=gear.merlinic_crackows_drain})

	sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Stun = set_combine(sets.midcast.FastRecast, {main="Rubicundity",sub="Ammurapi Shield",})
		
	sets.midcast.Stun.Resistant = sets.midcast['Dark Magic']

	-- Sets for special buff conditions on spells.
		
	sets.buff.Saboteur = {hands="Leth. Gantherots +1"}
	
	sets.HPDown = {head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring2="Mephitas's Ring",
		legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Sets to return to when not performing an action.	

	-- Idle sets
	sets.idle = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
		head="Viti. Chapeau +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
		body="Jhakri Robe +2",hands=gear.chironic_gloves_refresh,ring1="Defending Ring",ring2="Dark Ring",
		back="Solemnity Cape",waist="Flume Belt",legs=gear.chironic_hose_refresh,feet=gear.merlinic_crackows_refresh}
		
	sets.idle.PDT = set_combine(sets.idle, {ammo="Staunch Tathlum",
		head="Aya. Zucchetto +2",body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring2="Gelatinous Ring +1",
		feet="Aya. Gambieras +2"})
		
	sets.idle.MDT = set_combine(sets.idle, {ammo="Staunch Tathlum",hands="Atrophy Gloves +2",legs="Ea Slops",feet="Amalric Nails"})
		
	sets.idle.Weak = set_combine(sets.idle, {})
	
	sets.idle.DTHippo = set_combine(sets.idle.PDT, {})
	
	-- Resting sets
	sets.resting = sets.idle
		
	-- Defense sets
	sets.defense.PDT = set_combine(sets.idle.PDT, {})

	sets.defense.NukeLock = sets.midcast['Elemental Magic']
		
	sets.defense.MDT = set_combine(sets.idle.MDT, {})
		
    sets.defense.MEVA = set_combine(sets.defense.MDT, {head="Ea Hat",body="Ea Houppelande"})
		
	sets.idle.TPEat = set_combine(sets.idle, {
		--neck="Chrys. Torque"
	})

	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	-- Weapons sets
	sets.weapons.Sequence = {main="Sequence",sub="Ammurapi Shield"}
	sets.weapons.DualWeapons = {main="Sequence",sub="Ternion Dagger +1"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
--	sets.engaged = {ammo="Ginsen",
--		head="Aya. Zucchetto +2",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
--		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",ring2="Ilabrat Ring",
--		back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"}

	sets.engaged = {ammo="Ginsen",
		head="Aya. Zucchetto +2",neck="Anu Torque",ear1="Telos Earring",ear2="Sherida Earring",
		body="Ayanmo Corazza +2",hands="Taeon Gloves",ring1="Petrov Ring",ring2="Ilabrat Ring",
		back=gear.stp_jse_cape,waist="Windbuffet Belt +1",legs="Taeon Tights",feet="Carmine Greaves +1"}
		
	sets.engaged.Acc = set_combine(sets.engaged, {
		head="Carmine Mask +1",neck="Lissome Torque",
		hands="Aya. Manopolas +2",ring1="Chirich Ring",
		waist="Grunfeld Rope",legs="Carmine Cuisses +1"})

	sets.engaged.DW = set_combine(sets.engaged, {ear1="Suppanomimi",legs="Carmine Cuisses +1"})
	sets.engaged.DW.Acc = set_combine(sets.engaged.Acc, {ear1="Suppanomimi"})
		
	sets.engaged.PhysicalDef = set_combine(sets.engaged, {
		neck="Loricate Torque +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.stp_jse_cape,waist="Flume Belt"})
		
	sets.engaged.MagicalDef = set_combine(sets.engaged, {
		ammo="Staunch Tathlum",neck="Loricate Torque +1",ring1="Defending Ring",ring2=gear.dark_ring_dt})

end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	set_macro_page(1, 5)
end