function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc')
    state.CastingMode:options('Normal','Resistant','AoE')
    state.IdleMode:options('Normal','PDT')
	state.Weapons:options('None','Dual','Single')

	-- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Blurred Harp +1'
	-- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 1
	
	-- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(false, 'Use Custom Timers')
	
	-- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !q gs c weapons NukeWeapons;gs c update')
	send_command('bind ^q gs c weapons Swords;gs c update')

	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.None = {}
	sets.weapons.Dual = {}
	sets.weapons.Single = {}
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
	
	sets.precast.FC.BardSong = {}

	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong,{})
	sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong,{})
	sets.precast.FC.Lullaby = {}
	sets.precast.FC.Lullaby.Resistant = {}
	sets.precast.FC['Horde Lullaby'] = {}
	sets.precast.FC['Horde Lullaby'].Resistant = {}
	sets.precast.FC['Horde Lullaby'].AoE = {}
	sets.precast.FC['Horde Lullaby II'] = {}
	sets.precast.FC['Horde Lullaby II'].Resistant = {}
	sets.precast.FC['Horde Lullaby II'].AoE = {}
		
	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong,{})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla
		
	
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = {}
	sets.precast.JA.Troubadour = {}
	sets.precast.JA['Soul Voice'] = {}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}
		
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = {}

	-- Gear to enhance certain classes of songs
	sets.midcast.Ballad = {}
	sets.midcast.Lullaby = {}
	sets.midcast.Lullaby.Resistant = {}
	sets.midcast['Horde Lullaby'] = {}
	sets.midcast['Horde Lullaby'].Resistant = {}
	sets.midcast['Horde Lullaby'].AoE = {}
	sets.midcast['Horde Lullaby II'] = {}
	sets.midcast['Horde Lullaby II'].Resistant = {}
	sets.midcast['Horde Lullaby II'].AoE = {}
	sets.midcast.Madrigal = {}
	sets.midcast.Paeon = {}
	sets.midcast.March = {}
	sets.midcast['Honor March'] = set_combine(sets.midcast.March,{range="Marsyas"})
	sets.midcast.Minuet = {}
	sets.midcast.Minne = {}
	sets.midcast.Carol = {}
	sets.midcast["Sentinel's Scherzo"] = {} --feet="Fili Cothurnes +1" Brioso Slippers still provides more Duration
	sets.midcast['Magic Finale'] = {}
	sets.midcast.Mazurka = {}
	

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {}
		
	sets.midcast.SongEffect.DW = {}

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {}

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.SongDebuff.Resistant = {}

	-- Song-specific recast reduction
	sets.midcast.SongRecast = {}
		
	sets.midcast.SongDebuff.DW = {}

	-- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

	-- Other general spells and classes.
	sets.midcast.Cure = {}
		
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
		
	sets.midcast['Enhancing Magic'] = {}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
		
	sets.midcast['Elemental Magic'] = {}
		
	sets.midcast['Elemental Magic'].Resistant = {}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	-- Resting sets
	sets.resting = {}
	
	sets.idle = {}

	sets.idle.PDT = {}
	
	-- Defense sets

	sets.defense.PDT = {}

	sets.defense.MDT = {}

	sets.Kiting = {}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	sets.engaged = {}
	sets.engaged.Acc = {}
	sets.engaged.DW = {}
	sets.engaged.DW.Acc = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WHM' then
        set_macro_page(1, 10)
    elseif player.sub_job == 'DNC' then
        set_macro_page(2, 10)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 10)
    elseif player.sub_job == 'RDM' then
        set_macro_page(4, 10)
    else
        set_macro_page(10, 10)
    end

end