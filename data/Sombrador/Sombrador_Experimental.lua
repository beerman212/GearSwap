function user_setup()
	-- Options: Override default values
    state.CastingMode:options('Normal','Resistant','Fodder','Proc','OccultAcumen')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','MP','SuppaBrutal','DWEarrings','DWMax'}
    state.HybridMode:options('Normal','DTLite','PDT','MDT')
    state.IdleMode:options('Normal','Sphere','PDT','DTHippo','TPEat','DTHippo')
    state.MagicalDefenseMode:options('MDT')
    state.OffenseMode:options('Fodder','Normal','MinAcc','SomeAcc','Acc','HighAcc','FullAcc')
    state.PhysicalDefenseMode:options('PDT')
    state.ResistDefenseMode:options('MEVA')
    state.Weapons:options('None','Single','Dual')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','HighAcc','FullAcc','Fodder')
    
    --Gear Definitions
	gear.obi_cure_waist = "Luminary Sash"
    gear.obi_nuke_waist = "Yamabuki-no-Obi"
	gear.obi_low_nuke_waist = "Sekhmet Corset"
    gear.obi_high_nuke_waist = "Refoccilation Stone"
    
    --JSE Cape Variants
	gear.senuna_crit = {name="Senuna's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
	gear.senuna_da = {name="Senuna's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
	gear.senuna_mab = {name="Senuna's Mantle",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
    gear.senuna_nuke = {name="Senuna's Mantle",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.senuna_stp = {name="Senuna's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
	gear.senuna_wsd = {name="Senuna's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	
    --[[Hot Keys where
	@ = Windows Key
	% = Works only when text bar not up.
	$ = Works only when text bar is up.
	^ = Control Key
	! = Alt Key
	~ = Shift Key
	# = Apps Key
]]
    --[[Black Mage Hot Keys
        send_command('bind ^` gs c cycle ElementalMode')                    --Ctrl + `              = Cycle ElementalMode
        send_command('bind ~^` gs c cycleback ElementalMode')               --Shift + Ctrl + `      = Cycle Backwards ElementalMode
        send_command('bind ^q gs c weapons Khatvanga;gs c set CastingMode OccultAcumen')
                                                                            --Ctrl + q              = Change to Khatvanga Weapon Set and
                                                                                                --Change to OccultAcumen Casting Mode
        send_command('bind !q gs c weapons Default;gs c reset CastingMode;gs c reset DeathMode;gs c reset MagicBurstMode')
                                                                            --Alt + q               = Change to Default Weapon Set,
                                                                                                --Deactivate DeathMode, and
                                                                                                --Deactivate MagicBurstMode
        send_command('bind !r gs c set DeathMode Single;gs c set MagicBurstMode Single')
        send_command('bind !\\\\ input /ja "Manawell" <me>')                --Alt + \               = Use Manawell on Myself
        send_command('bind !` input /ma "Aspir III" <t>')                   --Alt + `               = Cast Aspir III on Target
        send_command('bind @` gs c cycle MagicBurstMode')                   --Windows + `           = Cycle MagicBurstMode
        send_command('bind @f10 gs c cycle RecoverMode')                    --Windows + F10         = Cycle RecoverMode
        send_command('bind @f9 gs c cycle DeathMode')                       --Windows + F9          = Cycle DeathMode
        send_command('bind @^` input /ja "Parsimony" <me>')                 --Windows + Ctrl + `    = Use Prsimony on Myself
        send_command('bind !pause gs c toggle AutoSubMode')                 --Alt + Pause/Break     = Turn On/Off AutoSubMode (Automatically uses Sublimation and Myrkr)
        send_command('bind ^backspace input /ma "Stun" <t>')                --Ctrl + Backspace      = Cast Stun on Target
        send_command('bind !backspace input /ja "Enmity Douse" <t>')        --Alt + Backspace       = Use Enmity Douse on Target
        send_command('bind @backspace input /ja "Alacrity" <me>')           --Windows + Backspace   = Use Alacrity on Myself
        send_command('bind != input /ja "Light Arts" <me>')                 --Alt + =               = Use Light Arts on Myself
        send_command('bind @= input /ja "Addendum: White" <me>')            --Windows + =           = Use Addendum: White on Myself
        send_command('bind ^delete input /ja "Dark Arts" <me>')             --Ctrl + Delete         = Use Dark Arts on Myself
        send_command('bind !delete input /ja "Addendum: Black" <me>')       --Alt + Delete          = Use Addendum: Black on Myself
        send_command('bind @delete input /ja "Manifestation" <me>')         --Windows + Delete      = Use Manifestation on Myself]]
        
    --Dancer Hot Keys
        send_command('bind @` gs c step')                                   --Windows + `           =                          
        send_command('bind ^!@` gs c toggle usealtstep')
        send_command('bind ^@` gs c cycle mainstep')
        send_command('bind !@` gs c cycle altstep')
        send_command('bind ^` input /ja "Saber Dance" <me>')
        send_command('bind !` input /ja "Fan Dance" <me>')
        send_command('bind ^\\\\ input /ja "Chocobo Jig II" <me>')
        send_command('bind !\\\\ input /ja "Spectral Jig" <me>')
        send_command('bind !backspace input /ja "Reverse Flourish" <me>')
        send_command('bind ^backspace input /ja "No Foot Rise" <me>')
        send_command('bind %~` gs c cycle SkillchainMode')
    




        select_default_macro_book()
end

function init_gear_sets()

------------------------------------------------------------------------------------------------------------------------------------------------------
-- Defined Sets
-- Gear can be Defined in 1 of 3 ways
-- 1. Referencing a universal set as defined in the [Charactername].Globals.lua
    -- e.g. the TreasureHunter set, which usually has the Chaac Belt defined in the Globals because it is equipable by all jobs
    -- and other job specific gear with TH like Dark Matter enhanced Reisenjima Equipment
-- 2. Referencing a set defined somewhere in the code above the reference in this lua
    -- e.g. the Fast Cast Precast sets have been set up by first establishing a baseline Fast Cast set, and then
    -- building for specific scenarios by starting with the baseline and modifying gear for those scenarios
-- 3. within the {} entering individualized equipment locations and the name of the equipment
    -- simply put, enter the equipment slot name (e.g. Main, Sub, Head, Body...) the equals sign (=) and then in quotes ("") the name of the equipment
    -- e.g. {Waist = "Chaac Belt"} as used int the globals for TreasureHunter
    -- Complete list of Equipment Slots:
    -- main, sub, range, ammo, head, neck, ear1, ear2, body, hands, ring1, ring2, back, waist, legs, feet
------------------------------------------------------------------------------------------------------------------------------------------------------
	
    -- Weapons Sets
    -- Can be cycled through using the F7 key in the order defined above in the state.Weapons:options()
    -- To define in the state.Weapons:options(), type the value below after sets.weapons. within the parenthesis surrounded by apostrophies (')
    -- e.g. sets.weapons.Default = state.Weapons:options('Default')
    -- If not defined in the state.Weapons:options() above, it will not be accessible by the F7 cycle hot key
    sets.weapons.Default = {}
    sets.weapons.None = {}
    sets.weapons.Single = {}
    sets.weapons.Dual = {}
    sets.weapons.Magic = {}
	
    -- Treasure Hunter
    -- Treasure Hunter Mode can be activated/deactivated (set to Tag) using the Ctrl + T Hot Key
    -- Treasure Hunter caps at 4 for non-Thief Jobs and 14 on Thief
    	
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
    
    -- Precast Sets
    -- Precast Sets will assess a command and apply this gear before executing and up to the Midcast point
    -- Precast Sets are defined as sets.precast.[Precast Specifier]
    -- [Precast Specifiers]
    -- You may also define specific spells/abilities with a using an additional .[spellname]

    
        -- Precast sets to enhance JAs
        sets.precast.JA['Mana Wall'] = {}

        sets.precast.JA.Manafont = {} -- BLM Relic Body
        
        -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
        sets.precast.JA.Convert = {}


        -- Fast cast sets for spells

        sets.precast.FC = {}
            
        sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
        
        sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

        sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

        sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

        sets.precast.FC.Curaga = sets.precast.FC.Cure
        
        sets.precast.FC.Impact = set_combine(sets.precast.FC, {})

        sets.precast.FC.Death = {}

        -- Weaponskill sets
        -- Default set for any weaponskill that isn't any more specifically defined
        sets.precast.WS = {}

        -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
        sets.precast.WS['Vidohunir'] = {}

        sets.precast.WS['Myrkr'] = {}
            
        sets.MaxTPMyrkr = {}
        
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {}

    sets.midcast.Cure = {}
		
    sets.midcast.LightWeatherCure = {}
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = {}

    sets.midcast.Curaga = sets.midcast.Cure
	
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {})
	
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	sets.midcast['Enhancing Magic'] = {}
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.midcast['Enfeebling Magic'] = {}
		
    sets.midcast['Enfeebling Magic'].Resistant = {}
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

    sets.midcast['Dark Magic'] = {}

    sets.midcast.Drain = {}
    
    sets.midcast.Aspir = sets.midcast.Drain
	
	sets.midcast.Aspir.Death = {}
	
	sets.midcast.Death = {}

    sets.midcast.Stun = {}
		
    sets.midcast.Stun.Resistant = {}

    sets.midcast.BardSong = {}
		
	sets.midcast.Impact = {}
		
    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {}
		
    sets.midcast['Elemental Magic'].Resistant = {}
		
    sets.midcast['Elemental Magic'].Fodder = {}

	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder, {})
	
	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Resistant
		
		-- Minimal damage gear, maximum recast gear for procs.
    sets.midcast['Elemental Magic'].Proc = {}
		
    sets.midcast['Elemental Magic'].OccultAcumen = {}
		
    sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {})
	
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {}
		
    sets.idle.TPEat = set_combine(sets.idle, {})
	sets.idle.DTHippo = set_combine(sets.idle.PDT, {})

	sets.idle.Death = {}

    sets.idle.Weak = {}

    -- Defense sets

    sets.defense.PDT = {}

    sets.defense.MDT = {}
		
    sets.defense.MEVA = {}

	sets.Kiting = {}
    sets.latent_refresh = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	
	sets.HPDown = {}
		
	sets.HPCure = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff['Mana Wall'] = {}
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {}
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {}
	sets.ResistantMagicBurst = {}
	sets.RecoverBurst = {}
	sets.ResistantRecoverBurst = {}
	
	-- Gear for specific elemental nukes.
	sets.element.Wind = {}
	sets.element.Ice = {}
	sets.element.Dark = {}
	sets.element.Earth = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {}

	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
		
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
	if player.sub_job == 'SCH' then
        set_macro_page(1, 20)
    elseif player.sub_job == 'RDM' then
        set_macro_page(2, 20)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 20)
    elseif player.sub_job == 'WHM' then
        set_macro_page(4, 20)
    else
        set_macro_page(10, 20)
    end

end