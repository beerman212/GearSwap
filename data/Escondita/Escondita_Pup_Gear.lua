-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Acc','FullAcc','Fodder')
    state.HybridMode:options('Pet','DT','Normal')
    state.WeaponskillMode:options('Match','Normal','Acc','FullAcc','Fodder')
    state.PhysicalDefenseMode:options('PDT')
	state.IdleMode:options('Normal','PDT','Refresh')
    state.Weapons:options('None','Ohtas','Denouments')
    state.PetMode:options('None','Melee','Ranged','HybridRanged','Tank','LightTank','Magic','Heal','Nuke','Overdrive')

    -- Default/Automatic maneuvers for each pet mode.  Define at least 3.
	defaultManeuvers = {
		Melee = {
			{Name='Fire Maneuver', 	  Amount=1},
			{Name='Thunder Maneuver', Amount=1},
			{Name='Wind Maneuver', 	  Amount=1},
			{Name='Light Maneuver',	  Amount=0},
		},
		Ranged = {
			{Name='Wind Maneuver', 	  Amount=1},
			{Name='Fire Maneuver',	  Amount=1},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Thunder Maneuver', Amount=0},
		},
		Tank = {
			{Name='Earth Maneuver',	  Amount=1},
			{Name='Fire Maneuver',	  Amount=1},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Dark Maneuver',	  Amount=0},
		},
		LightTank = {
			{Name='Earth Maneuver',	  Amount=1},
			{Name='Fire Maneuver',	  Amount=1},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Dark Maneuver',	  Amount=0},
		},
		Magic = {
			{Name='Light Maneuver',	  Amount=1},
			{Name='Ice Maneuver',	  Amount=1},
			{Name='Dark Maneuver',	  Amount=1},
			{Name='Earth Maneuver',	  Amount=0},
		},
		Heal = {
			{Name='Light Maneuver',	  Amount=2},
			{Name='Dark Maneuver',	  Amount=1},
			{Name='Water Maneuver',	  Amount=0},
			{Name='Earth Maneuver',	  Amount=0},
		},
		Nuke = {
			{Name='Ice Maneuver',	  Amount=2},
			{Name='Dark Maneuver',	  Amount=1},
			{Name='Water Maneuver',	  Amount=0},
			{Name='Earth Maneuver',	  Amount=0},
        },
        Overdrive = {
            {Name='Wind Maneuver', 	  Amount=1},
			{Name='Fire Maneuver',	  Amount=1},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Thunder Maneuver', Amount=0},
        },
	}

    deactivatehpp = 100
    
    gear.visucius_mantle = {}
    gear.visucius_mantle.pet_engaged = {name="Visucius's Mantle",augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+17 Attack+17','Pet: Haste+10',}}
    gear.visucius_mantle.pet_casting = {name="Visucius's Mantle",augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Accuracy+20 Attack+20','Pet: Haste+10',}}
    gear.visucius_mantle.pet_idle = {name="Visucius's Mantle",augments={}}
    gear.visucius_mantle.master_tp = {name="Visucius's Mantle",augments={}}
    gear.visucius_mantle.master_ws = {name="Visucius's Mantle",augments={}}

    sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.herculean_boots_th})
	
    select_default_macro_book()
	
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f8 gs c toggle AutoPuppetMode')
	send_command('bind @f7 gs c toggle AutoRepairMode')
end

-- Define sets used by this job file.
function init_gear_sets()
    
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    
    -- Precast sets to enhance JAs
    sets.precast.JA['Overdrive'] = {body="Pantin Tobe +2"}
    sets.precast.JA['Tactical Switch'] = {}
    sets.precast.JA['Repair'] = {ammo="Automat. Oil +3",body="Foire Tobe +1",feet="Foire Bab. +1"}
	sets.precast.JA['Maintenance'] = {ammo="Automat. Oil +3"}

    sets.precast.JA.Maneuver = {
        main="Midnights",
        neck="Bfn. Collar +1",ear1="Burana Earring",
        body="Karagoz Farsetto",hands="Foire Dastanas +1",
        back=gear.visucius_mantle.pet_engaged
    }

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}     
    sets.precast.Waltz['Healing Waltz'] = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
	sets.precast.WS.Acc = {}
	sets.precast.WS.FullAcc = {}
	sets.precast.WS.Fodder = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Victory Smite'] = {} -- 4x Hit, 80% STR, Chance to Crit
    sets.precast.WS['Victory Smite'].Acc = {}
	sets.precast.WS['Victory Smite'].FullAcc = {}
	sets.precast.WS['Victory Smite'].Fodder = {}
	
    sets.precast.WS['Stringing Pummel'] = {} -- 6x Hit, 32% STR/VIT, Chance to Crit
    sets.precast.WS['Stringing Pummel'].Acc = {}
	sets.precast.WS['Stringing Pummel'].FullAcc = {}
	sets.precast.WS['Stringing Pummel'].Fodder = {}

    sets.precast.WS['Shijin Spiral'] = {} -- 5x Hit, 73-85% DEX, Plague/tp
    sets.precast.WS['Shijin Spiral'].Acc = {}
	sets.precast.WS['Shijin Spiral'].FullAcc = {}
	sets.precast.WS['Shijin Spiral'].Fodder = {}
	
    sets.precast.WS['Asuran Fists'] = {} -- 8x Hit, 15% STR/VIT, Acc/tp
    sets.precast.WS['Asuran Fists'].Acc = {}
	sets.precast.WS['Asuran Fists'].FullAcc = {}
	sets.precast.WS['Asuran Fists'].Fodder = {}
	
    sets.precast.WS['Dragon Kick'] = {} -- 1x Hit, 50% STR/VIT, ftp/tp
    sets.precast.WS['Dragon Kick'].Acc = {}
	sets.precast.WS['Dragon Kick'].FullAcc = {}
	sets.precast.WS['Dragon Kick'].Fodder = {}

    sets.precast.WS['Tornado Kick'] = {} -- 3x Hit, 40% STR/VIT, ftp/tp
    sets.precast.WS['Tornado Kick'].Acc = {}
	sets.precast.WS['Tornado Kick'].FullAcc = {}
	sets.precast.WS['Tornado Kick'].Fodder = {}
	
    sets.precast.WS['Raging Fists'] = {} -- 5x Hit, 30% STR/DEX, ftp/tp (1st Hit)
    sets.precast.WS['Raging Fists'].Acc = {}
	sets.precast.WS['Raging Fists'].FullAcc = {}
	sets.precast.WS['Raging Fists'].Fodder = {}
	
    sets.precast.WS['Howling Fist'] = {} -- 1x Hit, 50% VIT 20% STR, ftp/tp
    sets.precast.WS['Howling Fist'].Acc = {}
	sets.precast.WS['Howling Fist'].FullAcc = {}
	sets.precast.WS['Howling Fist'].Fodder = {}
	
    sets.precast.WS['Backhand Blow'] = {} -- 1x Hit, 50% STR/DEX, crit/tp
    sets.precast.WS['Backhand Blow'].Acc = {}
	sets.precast.WS['Backhand Blow'].FullAcc = {}
	sets.precast.WS['Backhand Blow'].Fodder = {}
	
    sets.precast.WS['Spinning Attack'] = {} -- 1x AoE hit, 100% STR, radius/tp
    sets.precast.WS['Spinning Attack'].Acc = {}
	sets.precast.WS['Spinning Attack'].FullAcc = {}
	sets.precast.WS['Spinning Attack'].Fodder = {}
	
    sets.precast.WS['Shoulder Tackle'] = {} -- 1x Hit, 100% VIT, stun chance/tp
    sets.precast.WS['Shoulder Tackle'].Acc = {}
	sets.precast.WS['Shoulder Tackle'].FullAcc = {}
	sets.precast.WS['Shoulder Tackle'].Fodder = {}
    -- Midcast Sets

    sets.midcast.FastRecast = {}
        
	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
		
    -- Midcast sets for pet actions
    sets.midcast.Pet.Cure = {}
	sets.midcast.Pet['Enfeebling Magic'] = {}
    sets.midcast.Pet['Elemental Magic'] = {}
    sets.midcast.Pet.PetEnmityGear = {}
	sets.midcast.Pet.PetWSGear = {
        range="Animator P",ammo="Automat. Oil +3",
        head="Tali'ah Turban +1",neck="Empathy Necklace",ear1="Rimeice Earring",ear2="Enmerkar Earring",
        body="Tali'ah Manteel +1",hands="Tali'ah Gages +1",
        back=gear.visucius_mantle.pet_engaged,waist="Ukko Sash",legs="Tali'ah Sera. +1",feet="Tali'ah Crackows +1"
    }
	
    sets.midcast.Pet.PetWSGear.Ranged = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Melee = set_combine(sets.midcast.Pet.PetWSGear, {head=gear.taeon.chapeau.pup,body=gear.taeon.tabard.pup,hands=gear.taeon.gloves.pup,feet=gear.taeon.boots.pup})
	sets.midcast.Pet.PetWSGear.Tank = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.LightTank = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Magic = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Heal = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Nuke = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Overdrive = set_combine(sets.midcast.Pet.PetWSGear, {
        head=gear.taeon.chapeau.pup,body=gear.taeon.tabard.pup,hands=gear.taeon.gloves.pup,feet=gear.taeon.boots.pup
    })
    
	-- Currently broken, preserved in case of future functionality.
	-- sets.midcast.Pet.WeaponSkill = {}

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}  

    -- Idle sets
    sets.idle = {}
		
	sets.idle.Refresh = {}
		
    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet = {main="Midnights",head="Pantin Taj +2",neck="Empath Necklace",ear1="Burana Earring"}

    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = {
        main="Ohtas",range="Animator P",ammo="Automat. Oil +3",
        head="Tali'ah Turban +1",neck="Empath Necklace",ear1="Rimeice Earring",ear2="Enmerkar Earring",
        body="Tali'ah Manteel +1",hands="Tali'ah Gages +1",
        back=gear.visucius_mantle.pet_engaged,waist="Ukko Sash",legs="Tali'ah Sera. +1",feet="Tali'ah Crackows +1"
    }

    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.Melee = set_combine(sets.idle.Pet.Engaged, {main="Midnights",head=gear.taeon.chapeau.pup,body=gear.taeon.tabard.pup,hands=gear.taeon.gloves.pup,feet=gear.taeon.boots.pup})
	sets.idle.Pet.Engaged.Tank = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.LightTank = set_combine(sets.idle.Pet.Engaged, {})
    sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.Heal = sets.idle.Pet.Engaged.Magic
    sets.idle.Pet.Engaged.Nuke = sets.idle.Pet.Engaged.Magic
    sets.idle.Pet.Engaged.Overdrive = set_combine(sets.idle.Pet.Engaged, {
        main="Midnights",head=gear.taeon.chapeau.pup,body=gear.taeon.tabard.pup,hands=gear.taeon.gloves.pup,feet=gear.taeon.boots.pup
    })


    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.MDT = {}
		
    sets.defense.MEVA = {}

    sets.Kiting = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {}
    sets.engaged.Acc = {}
    sets.engaged.FullAcc = {}
    sets.engaged.Fodder = {}
    
    sets.engaged.DT = {}
    sets.engaged.Acc.DT = {}
    sets.engaged.FullAcc.DT = {}
    sets.engaged.Fodder.DT = {}
    
    sets.engaged.Pet = {}
    sets.engaged.Acc.Pet = {}
    sets.engaged.FullAcc.Pet = {}
    sets.engaged.Fodder.Pet = {}
		
	-- Weapons sets
    sets.weapons.Ohtas = {main="Ohtas",range="Animator P"}
    sets.weapons.Denouments = {main="Denouments",range="Animator P"}
    sets.weapons.Midnights = {main="Midnights",range="Animator P"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 20)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 20)
    elseif player.sub_job == 'THF' then
        set_macro_page(2, 20)
    else
        set_macro_page(2, 20)
    end
end