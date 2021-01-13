-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal')
    state.HybridMode:options('None','HybridDT')
    state.RangedMode:options('Normal')
    state.WeaponskillMode:options('Match','Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None'}
	state.Weapons:options('Default','DefaultDW')
	state.CompensatorMode:options('Always','300','1000','Never','Always')
	
    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Chrono Bullet" --For MAB WS, do not put single-use bullets here.
    gear.QDbullet = "Chrono Bullet"
    options.ammo_warning_limit = 15

    gear.camulus = {}
    gear.camulus.meleetp = {}
    gear.camulus.rangedtp = {}
    gear.camulus.laststand = {}
    gear.camulus.leaden = {}

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
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

	-- Weapons sets
    sets.weapons.Fomalhaut = {main="Naegling",sub="Nusku Shield",range="Fomalhaut",ammo=gear.RAbullet}
    sets.weapons.FomalhautDW = {main="Naegling",sub="Tauret",range="Fomalhaut",ammo=gear.RAbullet}

    -- sets.weapons.Armageddon = {main="Naegling",sub="Nusku Shield",range="Magnatus"}
    -- sets.weapons.ArmageddonDW = {main="Naegling",sub="Tauret",range="Magnatus"}

    -- Precast Sets

    -- Precast sets to enhance JAs

	sets.precast.JA['Triple Shot'] = {}
    sets.precast.JA['Snake Eye'] = {}
    sets.precast.JA['Wild Card'] = {}
    sets.precast.JA['Random Deal'] = {}
    sets.precast.FoldDoubleBust = {}

    sets.precast.CorsairRoll = {range="Compensator",ring2="Barataria Ring",back=gear.camulus.meleetp}

    sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
    
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {})
    
    sets.precast.CorsairShot = {
        head="Malignance Chapeau",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Malignance Tabard",hands="Carmine Fin. Ga. +1",ring1="Shiva Ring +1",ring2="Ilabrat Ring",
        waist="Eschan Stone",legs=gear.herculean.trousers.magical,feet=gear.herculean.boots.refresh
    }
		
	sets.precast.CorsairShot.Damage = {}
	
    sets.precast.CorsairShot.Proc = {}

    sets.precast.CorsairShot['Light Shot'] = {
        head="Malignance Chapeau",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Shiva Ring +1",ring2="Ilabrat Ring",
        waist="Eschan Stone",legs="Malignance Tights",feet="Mummu Gamash. +2"
    }

    sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
		
	sets.Self_Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        head="Carmine Mask +1",neck="Voltsurge Torque",ear1="Loquac. Earring",ear2="",
        body="Taeon Tabard",hands="Leyline Gloves",ring1="Kishar Ring",
        feet="Carmine Greaves +1",
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.RA = {}
		
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
		
    sets.precast.WS.Acc = {}		
		
    sets.precast.WS.Proc = {}
		
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Savage Blade'] = {
        head=gear.herculean.helm.dexwsd,neck="Caro Necklace",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body=gear.herculean.vest.wsd,hands="Adhemar Wrist +1",ring1="Petrov Ring",ring2="Ilabrat Ring",
        waist="Fotia Belt",legs=gear.herculean.trousers.ma,feet=gear.herculean.boots.wsd
    }
	
    sets.precast.WS['Last Stand'] = {}
	
    sets.precast.WS['Leaden Salute'] = {
        head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Moonshade Earring",
        body="Malignance Tabard",hands="Carmine Fin. Ga. +1",ring1="Shiva Ring +1",ring2="Archon Ring",
        back=gear.camulus.leaden,waist="Eschan Stone",legs=gear.herculean.trousers.magical,feet=gear.herculean.boots.refresh
    }

    sets.precast.WS['Wildfire'] = {}
		
    sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']
    sets.precast.WS['Hot Shot'].Acc = sets.precast.WS['Wildfire'].Acc
		
		--Because omen skillchains.
    sets.precast.WS['Burning Blade'] = {}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring",ear2="Telos Earring"}
    sets.AccMaxTP = {ear1="Ishvara Earring",ear2="Telos Earring"}
    
    sets.MaxTP["Leaden Salute"] = {ear1="Ishvara Earring",ear2="Hecate's Earring"}
    sets.AccMaxTP["Leaden Salute"] = {ear1="Ishvara Earring",ear2="Hecate's Earring"}
        
    -- Midcast Sets
    sets.midcast.FastRecast = {}
        
    -- Specific spells

	sets.midcast.Cure = {}
	
	sets.Self_Healing = {hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    -- Ranged gear
    sets.midcast.RA = {
        head="Malignance Chapeau",neck="Sanctity Necklace",ear1="Telos Earring",ear2="Cessance Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Petrov Ring",ring2="Ilabrat Ring",
        waist="",legs="Malignance Tights",feet="Mummu Gamash. +2",
    }

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {})
		
	sets.buff['Triple Shot'] = {}
    
    -- Sets to return to when not performing an action.
	
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    sets.idle = {
        head="Meghanada Visor +1",neck="Warder's Charm +1",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        waist="Flume Belt +1",legs="Malignance Tights",feet="Meg. Jam. +1"
    }
		
    sets.idle.Refresh = set_combine(sets.idle, {})
    
    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.MDT = {}
		
    sets.defense.MEVA = {}

    sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
    sets.DWMax = {}
    
    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head="Adhemar Bonnet +1",neck="Clotharius Torque",ear1="Telos Earring",ear2="Cessance Earring",
        body="Adhemar Jacket +1",hands="Adhemar Wrist. +1",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Solemnity Cape",waist="Windbuffet Belt +1",legs="Malignance Tights",feet=gear.herculean.boots.qa
    }

    sets.engaged.HybridDT = set_combine(sets.engaged, {head="Malignance Chapeau",hands="Malignance Gloves",ring1="Defending Ring",legs="Malignance Tights"})

    sets.engaged.DW = set_combine(sets.engaged, {ear2="Suppanomimi"})

    sets.engaged.DW.HybridDT = set_combine(sets.engaged.DW, {head="Malignance Chapeau",hands="Malignance Gloves",ring1="Defending Ring",legs="Malignance Tights"})

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'NIN' then
        set_macro_page(1, 17)
    elseif player.sub_job == 'DNC' then
		set_macro_page(2, 17)
    elseif player.sub_job == 'RNG' then
        set_macro_page(3, 17)
    else
        set_macro_page(10, 17)
    end   


end