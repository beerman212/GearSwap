-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Acc')
    state.CastingMode:options('Normal','Resistant')
    state.IdleMode:options('Normal','PDT','TPEat')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None')

	gear.obi_cure_waist = "Porous Rope"
	gear.obi_cure_back = "Alaunus's Cape"

	gear.obi_nuke_waist = "Sekhmet Corset"
	gear.obi_high_nuke_waist = "Yamabuki-no-Obi"
	gear.obi_nuke_back = "Toro Cape"

	gear.alaunus = {}
	gear.alaunus.fc = {name="Alaunus Cape",augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}

		-- Additional local binds
	send_command('bind ^` input /ma "Arise" <t>')
	send_command('bind !` input /ja "Penury" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` gs c toggle AutoCaress')
	send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
	send_command('bind @backspace input /ma "Aurora Storm" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	send_command('bind !backspace input /ja "Accession" <me>')
	send_command('bind != input /ja "Sublimation" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protectra V" <me>')
	send_command('bind @\\\\ input /ma "Shellra V" <me>')
	send_command('bind !\\\\ input /ma "Reraise IV" <me>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

	-- Weapons sets
	
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {main="Marin Staff",sub="Clerisy Strap",ammo="Incantor Stone",
		head="Haruspex Hat",ear1="Loquac. Earring",
		body="Inyanga Jubbah +2",
		back=gear.alaunus.fc,legs="Aya. Cosciales +2"}
		
    sets.precast.FC.DT = {}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {head="Umuthi Hat"})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Orsn. Pantaln. +2"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
	
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {feet="Hygieia Clogs"})
	
	sets.precast.FC.Cure.DT = {}

    sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.CureSolace = sets.precast.FC.Cure

	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})

    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
		
    sets.precast.WS.Dagan = {}
		
	sets.MaxTP = {}
	sets.MaxTP.Dagan = {}

    --sets.precast.WS['Flash Nova'] = {}

    --sets.precast.WS['Mystic Boon'] = {}

    -- Midcast Sets

    sets.Kiting = {}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}

	-- Conserve Mp set for spells that don't need anything else, for set_combine.
	
	sets.ConserveMP = {}
		
	sets.midcast.Teleport = sets.ConserveMP
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {}
	
    sets.midcast.FastRecast = {}
		
    -- Cure sets

	sets.midcast['Full Cure'] = sets.midcast.FastRecast
	
	sets.midcast.Cure = {main="Iridal Staff",sub="Clerisy Strap",
		head="Vanya Hood",neck="Nodens Gorget",
		body="Orison Bliaud +2",ring2="Janniston Ring",
		back=gear.alaunus.fc,legs="Orsn. Pantaln. +2",feet="Vanya Clogs"}
		
	sets.midcast.CureSolace = sets.midcast.Cure

	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {waist="Light Belt"})

	sets.midcast.LightWeatherCureSolace = sets.midcast.LightWeatherCure
		
	sets.midcast.LightDayCureSolace = sets.midcast.LightWeatherCure

	sets.midcast.LightDayCure = sets.midcast.LightWeatherCure

	sets.midcast.Curaga = sets.midcast.Cure
		
	sets.midcast.LightWeatherCuraga = sets.midcast.LightWeatherCure
		
	sets.midcast.LightDayCuraga = sets.midcast.LightWeatherCure

	sets.midcast.Cure.DT = sets.midcast.Cure
		
	--Melee Curesets are used whenever your Weapons state is set to anything but None.
	sets.midcast.MeleeCure = {}
		
	sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, {waist="Light Belt"})
	sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1",waist="Light Belt"})
	sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1",waist="Light Belt"})
	sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, {waist="Light Belt"})
	sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, {waist="Light Belt"})
	sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, {waist="Light Belt"})

	sets.midcast.CureSolace.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Light Belt"})
	sets.midcast.LightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {waist="Light Belt"})
	sets.midcast.LightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {waist="Light Belt"})
	sets.midcast.LightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Light Belt"})
	sets.midcast.Curaga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Light Belt"})
	sets.midcast.LightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Light Belt"})
	sets.midcast.MeleeCure.DT = set_combine(sets.midcast.Cure.DT, {})
	
	sets.midcast.MeleeCureSolace.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Light Belt"})
	sets.midcast.MeleeLightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {waist="Light Belt"})
	sets.midcast.MeleeLightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {waist="Light Belt"})
	sets.midcast.MeleeLightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Light Belt"})
	sets.midcast.MeleeCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Light Belt"})
	sets.midcast.MeleeLightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Light Belt"})

	sets.midcast.Cursna = {}

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
	sets.midcast['Enhancing Magic'] = {}
	sets.midcast['Enhancing Magic'].skill = {}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], sets.Sheltered, {})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], sets.Sheltered, {})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], sets.Sheltered, {})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], sets.Sheltered, {})
	
	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'].skill, {})
	sets.midcast.BarStatus = set_combine(sets.midcast['Enhancing Magic'].skill, {})
	sets.midcast.BoostStat = set_combine(sets.midcast['Enhancing Magic'].skill, {})

	sets.midcast.Impact = {}
		
	sets.midcast['Elemental Magic'] = {}

	sets.midcast['Elemental Magic'].Resistant = {}

	sets.midcast['Divine Magic'] = {}
		
	sets.midcast.Holy = {}

	sets.midcast['Dark Magic'] = {}

    sets.midcast.Drain = {}

    sets.midcast.Drain.Resistant = {}

    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Stun = {}

	sets.midcast.Stun.Resistant = {}

	sets.midcast['Enfeebling Magic'] = {
		ammo="",
		head="Inyanga Tiara +1",neck="",ear1="",ear2="",
		body="Inyanga Jubbah +2",hands="Inyan. Dastanas +1",ring1="Acumen Ring",ring2="Perception Ring",
		back=gear.alaunus.fc,waist="",legs=gear.chironic.hose.enfeeble,feet="Inyan. Crackows +1"
	}

	sets.midcast['Enfeebling Magic'].Resistant = {}
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {back="Alaunus's Cape"})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {back="Alaunus's Cape",ring1="Stikini Ring"})

    -- Sets to return to when not performing an action.

    -- Resting sets
	sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {}
	sets.idle = {main="Bolelabunga",sub="Sors Shield",ammo="Sihirik",
		head=gear.chironic.hat.refresh,
		body="Artsieq Jubbah",hands=gear.chironic.gloves.refresh,ring1="Defending Ring",ring2="Ayanmo Ring",
		back="Alaunus's Cape",waist="Porous Rope",legs=gear.chironic.hose.refresh,feet=gear.chironic.slippers.refresh}

	sets.idle.PDT = {}
		
    sets.idle.TPEat = set_combine(sets.idle, {})

	sets.idle.Weak = {}

    -- Defense sets

	sets.defense.PDT = {}

	sets.defense.MDT = {}

    sets.defense.MEVA = {}
		
	-- Gear for specific elemental nukes.
	sets.element.Wind = {main="Marin Staff"}
	sets.element.Ice = {main="Ngqoqwanb"}
	sets.element.Earth = {neck="Quanpur Necklace"}

		-- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Basic set for if no TP weapon is defined.
    sets.engaged = {}

    sets.engaged.Acc = {}

	sets.engaged.DW = {}

    sets.engaged.DW.Acc = {}

		-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +1",back="Mending Cape"}

	sets.HPDown = {}

	sets.HPCure = {}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(3, 6)
end