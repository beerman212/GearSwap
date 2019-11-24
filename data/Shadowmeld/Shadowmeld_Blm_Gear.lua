function user_setup()
	-- Options: Override default values
	state.CastingMode:options('Normal','Resistant','Fodder','Proc','OccultAcumen')
	state.OffenseMode:options('Normal')
	state.IdleMode:options('Normal', 'PDT')
	state.Weapons:options('None','NukeWeapons','DeathWeapons')

	gear.obi_cure_waist = "Witful Belt"
	gear.obi_low_nuke_waist = "Refoccilation Stone"
	gear.obi_high_nuke_waist = "Refoccilation Stone"

	gear.taranus = {}
	gear.taranus.mab = {name="Taranus's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}

	-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode') 
	send_command('bind ~^` gs c cycleback ElementalMode') --Robbiewobbie's idea
	send_command('bind ^q gs c weapons Khatvanga;gs c set CastingMode OccultAcumen')
	send_command('bind !q gs c weapons default;gs c reset CastingMode;gs c reset DeathMode;gs c reset MagicBurstMode')
	send_command('bind !r gs c set DeathMode Single;gs c set MagicBurstMode Single')
	send_command('bind !\\\\ input /ja "Manawell" <me>')
	send_command('bind !` input /ma "Aspir III" <t>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f9 gs c cycle DeathMode')
	send_command('bind @^` input /ja "Parsimony" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.
	send_command('bind ^backspace input /ma "Stun" <t>')
	send_command('bind !backspace input /ja "Enmity Douse" <t>')
	send_command('bind @backspace input /ja "Alacrity" <me>')
	send_command('bind != input /ja "Light Arts" <me>')
	send_command('bind @= input /ja "Addendum: White" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')

	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.NukeWeapons = {main="Lathi",sub="Enki Strap"}
	sets.weapons.DeathWeapons = {main=gear.grioavolr.nuke,sub="Enki Strap"}


	-- Treasure Hunter

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	---- Precast Sets ----

	-- Precast sets to enhance JAs
	sets.precast.JA['Mana Wall'] = {back=gear.taranus.mab,feet="Wicce Sabots +1"}

	sets.precast.JA.Manafont = {} --body="Sorcerer's Coat +2"

	-- equip to maximize HP (for Tarus) and minimize MP loss before using convert
	sets.precast.JA.Convert = {}


	-- Fast cast sets for spells

	sets.precast.FC = {main=gear.grioavolr.nuke,sub="Clerisy Strap",ammo="Impatiens",
		head="Amalric Coif +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		body="Anhur Robe",hands=gear.telchine.gloves.enhancing,ring1="Kishar Ring",ring2="Lebeche Ring",
		back="Perimede Cape",waist="Witful Belt",legs=gear.merlinic.shalwar.magical,feet=gear.merlinic.crackows.drain}

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ring1="Defending Ring",ring2="Kishar Ring",back=gear.taranus.mab,waist="Channeler's Stone"})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Serenity",sub="Clerisy Strap +1",body="Heka's Kalasiris"})

	sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})

	sets.precast.FC.Death = {main="Lathi",sub="Enki Strap",ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Barkaro. Earring",ear2="Regal Earring",
		body=gear.merlinic.jubbah.magical,hands="Amalric Gages",ring1="Mephitas's Ring",ring2="Archon Ring",
		back=gear.taranus.mab,waist="Refoccilation Stone",legs="Spae. Tonban +2",feet=gear.merlinic.crackows.magical}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Dosis Tathlum",
		head="Hagondes Hat +1",neck="Saevus Pendant +1",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back=gear.taranus.mab,waist="Fotia Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Vidohunir'] = {ammo="Dosis Tathlum",
		head="Hagondes Hat +1",neck="Saevus Pendant +1",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Zendik Robe",hands="Hagondes Cuffs +1",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back=gear.taranus.mab,waist="Fotia Belt",legs="Hagondes Pants +1",feet=gear.merlinic.nuke_feet}

	sets.precast.WS['Myrkr'] = {ammo="Psilomene",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Mendi. Earring",ear2="Loquac. Earring",
		body="Amalric Doublet",hands="Amalric Gages",ring1="Mephitas's Ring",ring2="Lebeche Ring",
		back="Twilight Cape",waist="Luminary Sash",legs="Spae. Tonban +2",feet="Skaoi Boots"}


	---- Midcast Sets ----

	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

	sets.midcast.Cure = {main=gear.gada.enfeebling,sub="Sors Shield",ammo="Psilomene",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Mendi. Earring",ear2="Etiolation Earring",
		body="Vedic Robe",hands="Telchine Gloves",ring1="Sirona's Ring",ring2="Lebeche Ring",
		waist="Witful Belt",feet="Vanya Clogs"}

	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {main="Chatoyant Staff",sub="Enki Strap",neck="Nodens Gorget",back="Twilight Cape",waist="Hachirin-no-Obi"})

	--Cureset for if it's not light weather but is light day.
	sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {back="Twilight Cape",waist="Hachirin-no-Obi"})

	sets.midcast.Curaga = sets.midcast.Cure

	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {main=gear.gada.enfeebling,sub="Sors Shield",
	neck="Malison Medallion",ring1="Sirona's Ring",ring2="Ephedra Ring",feet="Vanya Clogs"})

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	sets.midcast['Enhancing Magic'] = {main=gear.gada.enhancing,sub="Ammurapi Shield",
		head=gear.telchine.cap.enhancing,neck="Incanter's Torque",ear1="Andoaa Earring",
		body=gear.telchine.chasuble.enhancing,hands=gear.telchine.gloves.enhancing,ring2="Stikini Ring",
		back="Perimede Cape",waist="Olympus Sash",legs=gear.telchine.braconi.enhancing,feet=gear.telchine.pigaches.enhancing}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",waist="Siegel Sash"})

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.midcast['Enfeebling Magic'] = {main=gear.gada.enfeebling,sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head=gear.merlinic.hood.magical,neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Spaekona's Coat +2",hands="Amalric Gages +1",ring1="Kishar Ring",ring2="Stikini Ring",
		back=gear.taranus.mab,waist="Luminary Sash",legs="Spae. Tonban +2",feet="Skaoi Boots"}

	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})

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

	sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head=gear.merlinic.hood.magical,neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body=gear.merlinic.jubbah.magical,hands="Amalric Gages +1",ring1="Evanescence Ring",ring2="Stikini Ring",
		back="Perimede Cape",waist="Luminary Sash",legs="Spae. Tonban +2",feet=gear.merlinic.crackows.magical}

	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		main="Rubicundity",head="Pixie Hairpin +1",neck="Erra Pendant",ring1="Evanescence Ring",waist="Fucho-no-Obi",legs="Spae. Tonban +2",feet=gear.merlinic.crackows.drain
	})

	sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast.Aspir.Death = set_combine(sets.midcast.Aspir, {main=gear.grioavolr.nuke,sub="Enki Strap",ammo="Psilomene",neck="Sanctity Necklace",hands="Amalric Gages",ring1="Mephitas's Ring"})

	sets.midcast.Death = {main=gear.grioavolr.nuke,sub="Enki Strap",ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Barkaro. Earring",
		body=gear.merlinic.jubbah.magical,hands="Amalric Gages",ring1="Mephitas's Band",ring2="Archon Ring",
		back=gear.taranus.mab,waist=gear.ElementalObi,legs="Spae. Tonban +2",feet=gear.merlinic.crackows.magical}

	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {main=gear.grioavolr.nuke,sub="Clerisy Strap",ammo="Sapience Orb",neck="Voltsurge Torque",ring1="Kishar Ring",back=gear.taranus.mab,waist="Witful Belt"})

	sets.midcast.Stun.Resistant = set_combine(sets.midcast['Dark Magic'], {})

	sets.midcast.BardSong = set_combine(sets.midcast.FastRecast, {})

	-- Elemental Magic sets

	sets.midcast['Elemental Magic'] = {main="Lathi",sub="Enki Strap",ammo="Pemphredo Tathlum",
		head=gear.merlinic.hood.magical,neck="Sanctity Necklace",ear1="Regal Earring",ear2="Malignance Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Freke Ring",ring2="Shiva Ring +1",
		back=gear.taranus.mab,waist=gear.ElementalObi,legs="Amalric Slops +1",feet="Amalric Nails +1"}

	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		main=gear.grioavolr.nuke,body=gear.merlinic.jubbah.magical,legs=gear.merlinic.shalwar.magical,feet=gear.merlinic.crackows.magical
	})

	sets.midcast['Elemental Magic'].Fodder = set_combine(sets.midcast['Elemental Magic'], {})

	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {main=gear.grioavolr.nuke})
	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].HighTierNuke, {})

	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Resistant

	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'].Resistant, {head=empty,body="Twilight Cloak"})

	-- Minimal damage gear, maximum recast gear for procs.
	sets.midcast['Elemental Magic'].Proc = set_combine(sets.midcast.FastRecast, {main=empty,sub=empty})

	sets.midcast['Elemental Magic'].OccultAcumen = {head="Mallquis Chapeau +2",ring1="Rajas Ring",ring2="Petrov Ring",legs="Perdition Slops"}

	sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {head=empty,body="Twilight Cloak"})

	-- Sets to return to when not performing an action.

	-- Idle sets

	-- Normal refresh idle set
	sets.idle = {main="Lathi",sub="Eletta Grip",ammo="Staunch Tathlum",
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
		body="Jhakri Robe +2",hands=gear.merlinic.dastanas.refresh,ring1="Defending Ring",ring2=gear.dark_ring.dt,
		back="Solemnity Cape",waist="Luminary Sash",legs=gear.merlinic.shalwar.refresh,feet=gear.merlinic.crackows.refresh}

	-- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
	sets.idle.PDT = set_combine(sets.idle, {body="Mallquis Saio +2",ring2="Gelatinous Ring +1"})

	sets.idle.TPEat = set_combine(sets.idle, {--[[neck="Chrys. Torque"]]})
	sets.idle.DTHippo = set_combine(sets.idle.PDT, {--[[feet="Hippo. Socks +1"]]})

	sets.idle.Death = {main=gear.grioavolr.nuke,sub="Enki Strap",ammo="Pemphredo Tathlum",
	head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Barkaro. Earring",ear2="Friomisi Earring",
	body=gear.merlinic.jubbah.magical,hands="Amalric Gages",ring1="Mephitas's Ring",ring2="Archon Ring",
	back=gear.taranus.mab,waist="Refoccilation Stone",legs="Spae. Tonban +2",feet=gear.merlinic.crackows.refresh}

	sets.idle.Weak = set_combine(sets.idle, {})

	-- Resting sets
	sets.resting = set_combine(sets.idle, {})

	-- Defense sets

	sets.defense.PDT = set_combine(sets.idle.PDT, {})

	sets.defense.MDT = set_combine(sets.defense.PDT, {})

	sets.defense.MEVA = set_combine(sets.defense.MDT, {})

	sets.Kiting = {--[[feet="Herald's Gaiters"]]}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.

	sets.HPDown = {}

	sets.HPCure = {}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff['Mana Wall'] = {back=gear.taranus.mab,feet="Wicce Sabots +1"}

	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Spaekona's Coat +2"}
	-- Gear for Magic Burst mode.
	sets.MagicBurst = {head="Ea Hat",neck="Mizu. Kubikazari",body="Ea Houppelande",hands="Amalric Gages +1",ring1="Mujin Band",ring2="Shiva Ring +1",legs="Ea Slops",feet="Jhakri Pigaches +2"}
	sets.ResistantMagicBurst = {head="Ea Hat",body="Ea Houppelande",hands="Amalric Gages +1",ring1="Mujin Band",ring2="Shiva Ring +1",legs="Ea Slops",feet="Jhakri Pigaches +2"}
	sets.RecoverBurst = {head="Ea Hat",neck="Mizu. Kubikazari",body="Spaekona's Coat +2",hands="Amalric Gages +1",ring1="Mujin Band",ring2="Shiva Ring +1",legs="Ea Slops",feet="Jhakri Pigaches +2"}
	sets.ResistantRecoverBurst = {head="Ea Hat",neck="Mizu. Kubikazari",body="Spaekona's Coat +2",hands="Amalric Gages +1",ring1="Mujin Band",ring2="Shiva Ring +1",legs="Ea Slops",feet="Jhakri Pigaches +2"}

	-- Gear for specific elemental nukes.
	sets.element.Wind = {}
	sets.element.Ice = {}
	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}
	sets.element.Earth = {}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {ammo="Staunch Tathlum",
		head="Jhakri Coronal +2",neck="Lissome Necklace",ear1="Telos Earring",ear2="Cessance Earring",
		body="Jhakri Robe +2",hands="Jhakri Cufs +2",ring1="Petrov Ring",ring2="Chirich Ring",
		legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

end

	-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 9)
end