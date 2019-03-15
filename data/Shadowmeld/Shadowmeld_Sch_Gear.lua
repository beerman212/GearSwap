-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal')
	state.CastingMode:options('Normal','Resistant','Proc','OccultAcumen')
	state.IdleMode:options('Normal', 'PDT', 'TPEat')
	state.HybridMode:options('Normal','PDT')
	state.Weapons:options('None','Akademos','Grioavolr')

	gear.nuke_jse_back = {name="Lugh's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10'}}

	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_waist = "Refoccilation Stone"
	gear.obi_high_nuke_waist = "Refoccilation Stone"

	-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c scholar power')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^q gs c weapons Khatvanga;gs c set CastingMode OccultAcumen')
	send_command('bind !q gs c weapons default;gs c reset CastingMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.
	send_command('bind @^` input /ja "Parsimony" <me>')
	send_command('bind ^backspace input /ma "Stun" <t>')
	send_command('bind !backspace gs c scholar speed')
	send_command('bind @backspace gs c scholar aoe')
	send_command('bind ^= input /ja "Dark Arts" <me>')
	send_command('bind != input /ja "Light Arts" <me>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise III" <me>')

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Precast Sets

	-- Precast sets to enhance JAs

	sets.precast.JA['Tabula Rasa'] = {legs="Peda. Pants +1"}
	sets.precast.JA['Enlightenment'] = {} 

	-- Fast cast sets for spells

	sets.precast.FC = {main=gear.grioavolr_nuke,sub="Clerisy Strap",ammo="Impatiens",
		head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Anhur Robe",hands="Telchine Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
		back="Perimede Cape",waist="Witful Belt",legs=gear.merlinic_shalwar_magical,feet=gear.merlinic_crackows_drain}

	sets.precast.FC.Arts = {}

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear1="Barkaro. Earring"})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty,body="Twilight Cloak"})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS['Myrkr'] = {ammo="Psilomene",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Mendi. Earring",ear2="Loquac. Earring",
		body="Amalric Doublet",hands="Amalric Gages",ring1="Mephitas's Ring",ring2="Lebeche Ring",
		back="Twilight Cape",waist="Luminary Sash",legs=gear.merlinic_shalwar_magical,feet="Skaoi Boots"}

	-- Midcast Sets

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {}

	-- Gear for Magic Burst mode.
	sets.MagicBurst = {main="Akademos",neck="Mizu. Kubikazari",hands="Amalric Gages +1",ring1="Mujin Band",ring2="Locus Ring",feet="Jhakri Pigaches +2"}

	-- Gear for specific elemental nukes.
	sets.element.Wind = {}
	sets.element.Ice = {}
	sets.element.Earth = {}
	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}

	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

	sets.midcast.Cure = {main=gear.gada_enfeebling,sub="Sors Shield",ammo="Psilomene",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Enchntr. Earring +1",ear2="Mendi. Earring",
		body="Vedic Coat",hands="Kaykaus Cuffs",ring1="Kuchekula Ring",ring2="Lebeche Ring",
		waist="Luminary Sash",legs="Chironic Hose",feet="Kaykaus Boots"}

	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {main="Chatoyant Staff",sub="Eletta Grip",back="Twilight Cape",waist="Hachirin-no-Obi"})

	sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {back="Twilight Cape",waist="Hachirin-no-Obi"})

	sets.midcast.Curaga = sets.midcast.Cure

	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

	sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {main=gear.gada_enfeebling,sub="Sors Shield",neck="Malison Medallion",ring1="Sirona's Ring",ring2="Ephedra Ring",feet="Vanya Clogs"})

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Oranyan",sub="Clemency Grip"})

	sets.midcast['Enhancing Magic'] = {main=gear.gada_enhancing,sub="Ammurapi Shield",
		head=gear.telchine_cap_enhancing_duration,neck="Incanter's Torque",ear1="Andoaa Earring",
		body=gear.telchine_chas_enhancing_duration,hands=gear.telchine_gloves_enhancing_duration,ring2="Stikini Ring",
		back="Perimede Cape",waist="Olympus Sash",legs=gear.telchine_braconi_enhancing_duration,feet=gear.telchine_pigaches_enhancing_duration}

	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {main="Bolelabunga",head="Arbatel Bonnet +1",back="Bookworm Cape"})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",waist="Siegel Sash"})

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {feet="Peda. Loafers +1"})

	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Protectra = sets.midcast.Protect

	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Shellra = sets.midcast.Shell


	-- Custom spell classes

	sets.midcast['Enfeebling Magic'] = {main=gear.gada_enfeebling,sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head=gear.merlinic_hood_magical,neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body=gear.merlinic_jubbah_magical,hands="Kaykaus Cuffs",ring1="Kishar Ring",ring2="Stikini Ring",
		back=gear.nuke_jse_back,waist="Luminary Sash",legs=gear.chironic_hose_enfeeble,feet="Skaoi Boots"}

	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})

	sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {hands="Amalric Gages +1"})
	sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

	sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
	head=gear.merlinic_hood_magical,neck="Erra Pendant",ear1="Regal Earring",ear2="Barkaro. Earring",
	body=gear.merlinic_jubbah_magical,hands="Kaykaus Cuffs",ring1="Evanescence Ring",ring2="Stikini Ring",
	back=gear.nuke_jse_back,waist="Luminary Sash",legs=gear.chironic_hose_enfeeble,feet=gear.merlinic_crackows_magical}

	sets.midcast.Kaustra = set_combine(sets.midcast['Dark Magic'], {head="Pixie Hairpin +1",ring2="Archon Ring"})

	sets.midcast.Kaustra.Resistant = set_combine(sets.midcast.Kaustra, {head=gear.merlinic_hood_magical})

	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {head="Pixie Hairpin +1",ring2="Archon Ring",waist="Fucho-no-Obi",feet=gear.merlinic_crackows_drain})

	sets.midcast.Drain.Resistant = set_combine(sets.midcast.Drain, {head=gear.merlinic_hood_magical})

	sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Stun = set_combine(sets.midcast.FastRecast, {})

	sets.midcast.Stun.Resistant = {main="Oranyan",sub="Enki Strap",ammo="Pemphredo Tathlum",
	head="Amalric Coif +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Barkaro. Earring",
	body="Zendik Robe",hands=gear.chironic_enfeeble_hands,ring1="Stikini Ring",ring2="Stikini Ring",
	back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.merlinic_aspir_feet}

	-- Elemental Magic sets are default for handling low-tier nukes.
	sets.midcast['Elemental Magic'] = {main=gear.grioavolr_nuke,sub="Enki Strap",ammo="Pemphredo Tathlum",
		head=gear.merlinic_hood_magical,neck="Sanctity Necklace",ear1="Regal Earring",ear2="Friomisi Earring",
		body=gear.merlinic_jubbah_magical,hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring",
		back=gear.int_matk_jse_cape,waist=gear.ElementalObi,legs=gear.merlinic_shalwar_magical,feet=gear.merlinic_crackows_magical}

	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})

	sets.midcast['Elemental Magic'].Fodder = set_combine(sets.midcast['Elemental Magic'], {})

	sets.midcast['Elemental Magic'].Proc = set_combine(sets.midcast.FastRecast, {main=empty,sub=empty})

	sets.midcast['Elemental Magic'].OccultAcumen =set_combine(sets.midcast['Elemental Magic'], {head="Mallquis Chapeau +2",ring2="Petrov Ring",legs="Perdition Slops"})

	-- Custom refinements for certain nuke tiers
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder, {})

	sets.midcast.Helix = set_combine(sets.midcast['Elemental Magic'], {waist="Refoccilation Stone"})

	sets.midcast.Helix.Resistant = set_combine(sets.midcast['Elemental Magic'], {waist="Refoccilation Stone"})

	sets.midcast.Helix.Proc = set_combine(sets.midcast.FastRecast, {main=empty,sub=empty})

	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'].Resistant, {head=empty,main="Twilight Cloak"})

	sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {head=empty,body="Twilight Cloak"})

	-- Sets to return to when not performing an action.


	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle = {main="Akademos",sub="Eletta Grip",ammo="Homiliary",
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
		body="Jhakri Robe",hands=gear.chironic_gloves_refresh,ring1="Defending Ring",ring2="Gelatinous Ring",
		back="Solemnity Cape",waist="",legs=gear.chironic_hose_refresh,feet=gear.merlinic_crackows_refresh}

	sets.idle.PDT = set_combine(sets.idle, {ammo="Staunch Tathlum",body="Mallquis Saio +2"})

	sets.idle.Hippo = set_combine(sets.idle.PDT, {--[[feet="Hippo. Socks +1"]]})

	sets.idle.Weak = set_combine(sets.idle.PDT, {})

	sets.idle.TPEat = set_combine(sets.idle, {--[[neck="Chrys. Torque"]]})

	-- Resting sets
	sets.resting = set_combine(sets.idle, {})

	-- Defense sets

	sets.defense.PDT = set_combine(sets.idle.PDT, {})

	sets.defense.MDT = set_combine(sets.defense.PDT, {ear2="Eabani Earring",ring2="Purity Ring"})

	sets.defense.MEVA = set_combine(sets.defense.MDT, {})

	sets.Kiting = {--[[feet="Herald's Gaiters"]]}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
	head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
	body="Jhakri Robe +2",hands=gear.merlinic_refresh_hands,ring1="Defending Ring",ring2="Sheltered Ring",
	back="Umbra Cape",waist="Flax Sash",legs="Assid. Pants +1",feet=gear.chironic_refresh_feet}

	sets.engaged.PDT = {main="Terra's Staff", sub="Oneiros Grip",ammo="Staunch Tathlum",
	head="Gende. Caubeen +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
	body="Vrikodara Jupon",hands="Gende. Gages +1",ring1="Defending Ring",ring2="Dark Ring",
	back="Umbra Cape",waist="Flax Sash",legs="Hagondes Pants +1",feet=gear.chironic_refresh_feet}

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Ebullience'] = {head="Arbatel Bonnet +1"}
	sets.buff['Rapture'] = {head="Arbatel Bonnet +1"}
	sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
	sets.buff['Immanence'] = {hands="Arbatel Bracers +1"}
	sets.buff['Penury'] = {legs="Arbatel Pants +1"}
	sets.buff['Parsimony'] = {legs="Arbatel Pants +1"}
	sets.buff['Celerity'] = {feet="Peda. Loafers +1"}
	sets.buff['Alacrity'] = {feet="Peda. Loafers +1"}
	sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}

	sets.HPDown = {head="Pixie Hairpin +1",ear1="Mendicant's Earring",
	body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring2="Mephitas's Ring",
	legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff['Light Arts'] = {} --legs="Academic's Pants +3"
	sets.buff['Dark Arts'] = {} --body="Academic's Gown +3"

	sets.buff.FullSublimation = {}
	sets.buff.PDTSublimation = {}

	-- Weapons sets
	sets.weapons.Akademos = {main="Akademos",sub="Enki Strap"}
	sets.weapons.Grioavolr = {main=gear.grioavolr_nuke,sub="Enki Strap"}
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == 'RDM' then
		set_macro_page(1, 7)
	elseif player.sub_job == 'BLM' then
		set_macro_page(1, 7)
	elseif player.sub_job == 'WHM' then
		set_macro_page(1, 7)
	else
		set_macro_page(1, 7)
	end
end