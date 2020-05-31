-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal','Acc')
	state.RangedMode:options('Normal','Acc')
	state.WeaponskillMode:options('Match','Normal', 'Acc')
	state.IdleMode:options('Normal', 'PDT')
	state.Weapons:options('None','Single','Dual')
	
	DefaultAmmo = {['Fomalhaut']="Chrono Bullet"}
	U_Shot_Ammo = {['Fomalhaut']="Animkii Bullet"}
	
	gear.tp_ranger_jse_back = {name="Belenus's Cape",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	gear.wsd_ranger_jse_back = {name="Belenus's Cape",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}}
	
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
	--------------------------------------
	-- Precast sets
	--------------------------------------

	
	
	-- Precast sets to enhance JAs
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.precast.JA['Bounty Shot'] = set_combine(sets.TreasureHunter, {})
	sets.precast.JA['Camouflage'] = {}
	sets.precast.JA['Scavenge'] = {}
	sets.precast.JA['Shadowbind'] = {}
	sets.precast.JA['Sharpshot'] = {}
	sets.precast.JA['Double Shot'] = {}


	-- Fast cast sets for spells

    sets.precast.FC = {}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})


	-- Ranged sets (snapshot)
	
	sets.precast.RA = {}
		
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

    sets.midcast.RA = {}
	
    sets.midcast.RA.Acc = {}
		
	--These sets will overlay based on accuracy level, regardless of other options.
	sets.buff.Camouflage = {}
	sets.buff.Camouflage.Acc = {}
	sets.buff['Double Shot'] = {}
	sets.buff['Double Shot'].Acc = {}
	sets.buff.Barrage = {}
	
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
	
    sets.midcast.Utsusemi = sets.midcast.FastRecast
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {}

	-- Idle sets
    sets.idle = {}
    
    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.MDT = {}
		
    sets.defense.MEVA = {}

    sets.Kiting = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	-- Weapons sets
	sets.weapons.Dual = {}
	sets.weapons.None = {}
	sets.weapons.Single = {}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

    -- Normal melee group
    sets.engaged = {}
    
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
	set_macro_page(1, 20)
end
