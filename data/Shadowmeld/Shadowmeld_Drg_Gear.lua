-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal','SomeAcc','Acc','MaxAcc','Fodder')
	state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','MaxAcc','Fodder')
	state.HybridMode:options('Normal','MaxHaste')
	state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
	state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT','Refresh','Reraise')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Weapons:options('Trishula','Shining One','Quint Spear')
	state.Passive = M{['description'] = 'Passive Mode','None','MP','Twilight'}
	
	gear.brigantia = {}
	gear.brigantia.stp = {name="Brigantia's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
	gear.brigantia.stardiver = {name="Brigantia's Mantle",augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	gear.brigantia.sonicthrust = {name="Brigantia's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

	organizer_items = {
		"Remedy",
		"Holy Water",
		"Panacea",
		"Sublime Sushi",
		"Red Curry Bun",
	}

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
	sets.precast.JA.Jump = {
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",neck="Anu Torque",ear1="Sherida Earring",ear2="Telos Earring",
		body="Vishap Mail +2",hands="Flam. Manopolas +2",ring1="Petrov Ring",ring2="Niqmaddu Ring",
		back=gear.brigantia.stp,waist="Ioskeha Belt +1",legs="Sulev. Cuisses +2",feet="Flam. Gambieras +2"
	}
	sets.precast.JA['Ancient Circle'] = {}
	sets.precast.JA['High Jump'] = set_combine(sets.precast.JA.Jump, {legs="Vishap Brais +2"})
	sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA.Jump, {legs="Pelt. Cuissots +1"})
	sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA.Jump, {legs="Pelt. Cuissots +1",feet="Pelt. Schyn. +1"})
	sets.precast.JA['Super Jump'] = {}
	sets.precast.JA['Spirit Link'] = {head="Vishap Armet +1",hands="Pel. Vambraces +1",feet="Ptero. Greaves +1"}
	sets.precast.JA['Call Wyvern'] = {body="Ptero. Mail +1"}
	sets.precast.JA['Deep Breathing'] = {}
	sets.precast.JA['Spirit Surge'] = {}
	sets.precast.JA['Steady Wing'] = {}

	-- Breath sets
	sets.precast.JA['Restoring Breath'] = {head="Ptero. Armet +1",back="Updraft Mantle",legs="Vishap Brais +2",feet="Ptero. Greaves +1"}
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
		head=gear.valorous.mask.strwsd,neck="Fotia Gorget",ear1="Sherida Earring",ear2="Thrud Earring",
		body=gear.valorous.mail.strwsd,hands="Ptero. Fin. G. +2",ring1="Regal Ring",ring2="Niqmaddu Ring",
		back=gear.brigantia.sonicthrust,waist="Fotia Belt",legs="Vishap Brais +3",feet="Sulev. Leggings +2",
	}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.MaxAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",ear2="Moonshade Earring",
		body="Dagon Breast.",hands="Sulev. Gauntlets +2",
		back=gear.brigantia.stardiver,legs="Sulev. Cuisses +2",feet="Flam. Gambieras +2",
	})

	sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		body="Hjarrandi Breast.",hands="Flam. Manopolas +2",
		back=gear.brigantia.stardiver,legs="Pelt. Cuissots +1",feet="Thereoid Greaves",
	})
	
	sets.precast.WS['Sonic Thrust'] = set_combine(sets.precast.WS, {ear2="Moonshade Earring"})

	sets.precast.WS["Camlann's Torment"] = set_combine(sets.precast.WS, {ear1="Ishvara Earring",waist="Caudata Belt"})
	
	sets.precast.WS["Leg Sweep"] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Flam. Zucchetto +2",ear1="Digni. Earring",
		body="Flamma Korazin +2",hands="Flam. Manopolas +2",ring1="Etana Ring",ring2="Flamma Ring",
		legs="Flamma Dirs +2",feet="Flam. Gambieras +2",
	})

	sets.precast.WS["Impulse Drive"] = set_combine(sets.precast.WS, {body="Hjarrandi Breast."})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

	sets.Gavialis = {head="Gavialis Helm"}

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle = {
		ammo="Staunch Tathlum",
		head=gear.valorous.mask.strwsd,neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Eabani Earring",
		body="Hjarrandi Breast.",hands="Sulev. Gauntlets +2",ring1="Defending Ring",ring2="Moonbeam Ring",
		back=gear.brigantia.stp,waist="Flume Belt +1",legs="Ptero. Brais +1",feet="Sulev. Leggings +2"
	}

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
	sets.passive.MP = {ear2="Ethereal Earring",waist="Flume Belt +1"}
	sets.passive.Twilight = sets.Reraise
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {head=gear.valorous.mask.TH,hands=gear.valorous.mitts.TH})

	-- Weapons sets
	sets.weapons.Trishula = {main="Trishula",sub="Utu Grip"}
	sets.weapons["Shining One"] = {main="Shining One",sub="Utu Grip"}
	sets.weapons["Quint Spear"] = {main="Quint Spear",sub="Utu Grip"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group

	sets.engaged = {
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",neck="Anu Torque",ear1="Sherida Earring",ear2="Dedition Earring",
		body="Dagon Breast.",hands="Sulev. Gauntlets +2",ring1="Petrov Ring",ring2="Niqmaddu Ring",
		back=gear.brigantia.stp,waist="Ioskeha Belt +1",legs="Sulev. Cuisses +2",feet="Flam. Gambieras +2",
	}

	sets.engaged.DTHybrid = set_combine(sets.engaged, {})

	sets.engaged.MaxHaste = set_combine(sets.engaged, {body="Hjarrandi Breast.",legs="Flamma Dirs +2"})
end

function user_job_aftercast(spell, spellMap, eventArgs)
	if pet.isvalid and pet.hpp < 50 then
		send_command("wait 3;spiritlink")
	end

	if not pet.isvalid and windower.ffxi.get_ability_recasts()[163] == 0 and player.status == 'Engaged' then
		send_command("wait 3;callwyvern")
	end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(5, 11)
	elseif player.sub_job == 'SAM' then
		set_macro_page(1, 11)
	elseif player.sub_job == 'BLU' then
		set_macro_page(2, 11)
	else
		set_macro_page(5, 11)
	end
end

function custom_post_precast(spell, spellMap, eventArgs)
	if spell.type == 'JobAbility' and spell.english:endswith('Jump') then
		if sets.precast.JA[spell.english] and sets.precast.JA[spell.english][state.OffenseMode.value] then
			equip(sets.precast.JA[spell.english][state.OffenseMode.value])
		end
	end		
end