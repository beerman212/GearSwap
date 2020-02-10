-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal','SomeAcc','Acc','MaxAcc','Fodder')
	state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','MaxAcc','Fodder')
	state.HybridMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
	state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT','Refresh','Reraise')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Weapons:options('Trishula')
	state.Passive = M{['description'] = 'Passive Mode','None','MP','Twilight'}
	
	gear.brigantia = {}
	gear.brigantia.stp = {name="Brigantia's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
	gear.brigantia.stardiver = {name="Brigantia's Mantle",augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	gear.brigantia.sonicthrust = {name="Brigantia's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

	select_default_macro_book()

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind ^f11 gs c cycle MagicalDefenseMode')
	send_command('bind @f7 gs c toggle AutoJumpMode')
	send_command('bind @` gs c cycle SkillchainMode')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	sets.Reraise = {--[[head="Twilight Helm",body="Twilight Mail"]]}

	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Angon = {ammo="Angon",hands="Ptero. Fin. G. +1"}
	sets.precast.JA.Jump = {}
	sets.precast.JA['Ancient Circle'] = {}
	sets.precast.JA['High Jump'] = set_combine(sets.precast.JA.Jump, {})
	sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA.Jump, {})
	sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA.Jump, {})
	sets.precast.JA['Super Jump'] = {}
	sets.precast.JA['Spirit Link'] = {}
	sets.precast.JA['Call Wyvern'] = {}
	sets.precast.JA['Deep Breathing'] = {}
	sets.precast.JA['Spirit Surge'] = {}
	sets.precast.JA['Steady Wing'] = {}

	-- Breath sets
	sets.precast.JA['Restoring Breath'] = {}
	sets.precast.JA['Smiting Breath'] = {}
	sets.HealingBreath = {}
	sets.SmitingBreath = {}

	-- Fast cast sets for spells

	sets.precast.FC = {}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.midcast.Cure = {}

	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

	-- Put HP+ gear and the AF head to make healing breath trigger more easily with this set.
	sets.midcast.HB_Trigger = set_combine(sets.midcast.FastRecast, {})

	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined

	sets.precast.WS = {
		ammo="Knobkierrie",
		head=gear.valorous.mask.strwsd,neck="Fotia Gorget",ear1="Sherida Earring",ear2="Ishvara Earring",
		body=gear.valorous.mail.strwsd,hands=gear.valorous.mitts.vitwsd,ring1="Shukuyu Ring",ring2="Niqmaddu Ring",
		back=gear.brigantia.sonicthrust,waist="Fotia Belt",legs="Vishap Brais +2",feet="Sulev. Leggings +2",
	}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.MaxAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
		head="Flam. Zucchetto +2",ear2="Moonshade Earring",
		body=gear.valorous.mail.da,hands="Sulev. Gauntlets +2",ring1="Flamma Ring",
		back=gear.brigantia.stardiver,legs="Sulev. Cuisses +2",feet="Flam. Gambieras +2",
	})
	sets.precast.WS['Stardiver'].SomeAcc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Stardiver'].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {})
	sets.precast.WS['Stardiver'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {
		head="Flam. Zucchetto +2",ear2="Moonshade Earring",
		body="Hjarrandi Breast.",hands="Flam. Manopolas +2",ring1="Begrudging Ring",
		back=gear.brigantia.stardiver,legs="Pelt. Cuissots +1",feet=gear.valorous.greaves.strwsd,
	})
	sets.precast.WS['Drakesbane'].SomeAcc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Drakesbane'].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {})
	sets.precast.WS['Drakesbane'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	sets.precast.WS['Sonic Thrust'] = set_combine(sets.precast.WS, {ear2="Moonshade Earring"})
	sets.precast.WS['Sonic Thrust'].SomeAcc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Sonic Thrust'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Sonic Thrust'].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {})
	sets.precast.WS['Sonic Thrust'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS["Camlann's Torment"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Camlann's Torment"].SomeAcc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Camlann's Torment"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Camlann's Torment"].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {})
	sets.precast.WS["Camlann's Torment"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
	sets.precast.WS["Leg Sweep"] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum"
		head="Flam. Zucchetto +2",ear1="Digni. Earring",
		body="Flam. Korazin +2",hands="Flam. Manopolas +2",ring1="Etana Ring",ring2="Flamma Ring",
		legs="Flamma Dirs +2",feet="Flam. Gambieras +2",
	})
	sets.precast.WS["Leg Sweep"].SomeAcc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Leg Sweep"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Leg Sweep"].MaxAcc = set_combine(sets.precast.WS.MaxAcc, {})
	sets.precast.WS["Leg Sweep"].Fodder = set_combine(sets.precast.WS.Fodder, {})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

	sets.MaxTP

	sets.Gavialis = {head="Gavialis Helm"}

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle = {}

	sets.idle.Refresh = {}

	sets.idle.Weak = set_combine(sets.idle, {})

	sets.idle.Reraise = set_combine(sets.idle, sets.Reraise)

	-- Defense sets
	sets.defense.PDT = {}

	sets.defense.PDTReraise = set_combine(sets.defense.PDT, sets.Reraise, {})

	sets.defense.MDT = {}

	sets.defense.MDTReraise = set_combine(sets.defense.MDT, sets.Reraise, {})

	sets.defense.MEVA = {}

	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {--[[head="Frenzy Sallet"]]}

	-- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.passive.MP = {ear2="Ethereal Earring",waist="Flume Belt"}
	sets.passive.Twilight = sets.Reraise
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	-- Weapons sets
	sets.weapons.Trishula = {main="Trishula",sub="Utu Grip"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group

	sets.engaged = {
		ammo="Aurgelmir Orb",
		head="Flam. Zucchetto +2",neck="Anu Torque",ear1="Sherida Earring",ear2="Dedition Earring",
		body=gear.valorous.mail.da,hands="Sulev. Gauntlets +2",ring1="Petrov Ring",ring2="Niqmaddu Ring",
		back=gear.brigantia.stp,waist="Ioskeha Belt +1",legs=gear.valorous.hose.dexwsd,feet="Flam. Gambieras +2",
	}
	sets.engaged.SomeAcc = {}
	sets.engaged.Acc = {}
	sets.engaged.MaxAcc = {}
	sets.engaged.Fodder = {}

	sets.engaged.PDT = {}
	sets.engaged.SomeAcc.PDT = {}
	sets.engaged.Acc.PDT = {}
	sets.engaged.MaxAcc.PDT = {}
	sets.engaged.Fodder.PDT = {}

	sets.engaged.MaxHaste = set_combine(sets.engaged, {body="Hjarrandi Breast."})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(5, 13)
	elseif player.sub_job == 'SAM' then
		set_macro_page(3, 13)
	elseif player.sub_job == 'BLU' then
		set_macro_page(2, 13)
	else
		set_macro_page(5, 13)
	end
end

function check_haste_level()
	local haste_level = 0
	local ja_haste_level = 0

	if buffactive[33] then -- Haste Spell
		haste_level = 15 * lasthaste
	end

	if buffactive["March"] then
		if buffactive["March"] == 1 then
			haste_level = haste_level + 16
		else
			haste_level = haste_level + 44
		end
	end

	if buffactive[580] then --Geo Haste
		haste_level = haste_level + 30
	end

	haste_level = math.min(43.75, haste_level)

	if pet.isvalid then
		ja_haste_level = ja_haste_level + 10
	end

	if buffactive["Hasso"] then
		ja_haste_level = ja_haste_level + 10
	end

	if buffactive["Last Resort"] then
		ja_haste_level = ja_haste_level + 15
	end

	if buffactive["Haste Samba"] then
		ja_haste_level = ja_haste_level + 5
	end

	if buffactive["Spirit Surge"] then
		ja_haste_level = ja_haste_level + 25
	end

	ja_haste_level = math.min(25, ja_haste_level)

	return ja_haste_level + haste_level
end