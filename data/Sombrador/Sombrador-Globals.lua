--Place for settings and custom functions to work across one characters, all jobs.
--Extra user functions to change how gearswap functions across jobs.

--Time Related Settings:
--To determine your offset the first time, uncomment time_offset and set time_test to true,
--Once you see delay numbers start spamming your chat, (Must be outside of town.)
--(Also you can't have Commitment or Dedication Buffs) then Equip to ring1 and use "Capacity Ring",
--(Not a Trizek or Calibur ring, "specifically Capacity Ring") your time_offset should appear in chat.
--Set time_offset to the number mentioned in your chat and reload.
--If the number spammed in your chat matches up with the seconds remaining on
--your Capacity Ring's recast, your time_offset is correct, set time_test to false and reload.

--time_offset = 0
time_test = false
latency = .75

--If this is set to true it will prevent you from casting shadows when you have more up than that spell would generate.
conserveshadows = false

--Display related settings.
state.DisplayMode = M(true, 'Display Mode') --Set this to false if you don't want to display modes at the bottom of your screen.
--Uncomment the settings below and change the values to edit the display's look.
--displayx = 3
--displayy = 1062
displayfont = 'Times New Roman'
--displaysize = 12
--displaybold = true
--displaybg = 0
--displaystroke = 2
--displaytransparancy = 192
--state.DisplayColors = {
    -- h='\\cs(255, 0, 0)', -- Red for active booleans and non-default modals
    -- w='\\cs(255,255,255)', -- White for labels and default modals
    -- n='\\cs(192,192,192)', -- White for labels and default modals
    -- s='\\cs(96,96,96)' -- Gray for inactive booleans
--}

--Options for automation.
state.ReEquip 		  		= M(true, 'ReEquip Mode')		--Set this to false if you don't want to equip your current Weapon set when you aren't wearing any weapons.
state.AutoArts 		  		= M(false, 'AutoArts') 		 	--Set this to false if you don't want to automatically try to keep up Solace/Arts.
state.CancelStoneskin 		= M(true, 'Cancel Stone Skin') 	--Set this to false if you don't want to automatically cancel stoneskin when you're slept.
state.SkipProcWeapons 		= M(true, 'Skip Proc Weapons') 	--Set this to false if you want to display weapon sets fulltime rather than just Aby/Voidwatch.
state.NotifyBuffs	  		= M(false, 'Notify Buffs') 	 	--Set this to true if you want to notify your party when you recieve a specific buff/debuff. (List Below)

--[[Binds you may want to change.
	Bind special characters.
	@ = Windows Key
	% = Works only when text bar not up.
	$ = Works only when text bar is up.
	^ = Control Key
	! = Alt Key
	~ = Shift Key
	# = Apps Key
]]

send_command('bind !@^f7 gs c toggle AutoWSMode') 			--Alt + Windows + Ctrl + F7 			= Turns AutoWSMode On and Off
send_command('bind !^f7 gs c toggle AutoFoodMode') 			--Alt + Ctrl + F7 						= Turns AutoFoodMode On and Off
send_command('bind f7 gs c cycle Weapons') 					--F7									= Cycle through Weapons Sets
send_command('bind @f8 gs c toggle AutoNukeMode') 			--Windows + F8 							= Turns AutoNukeMode On and Off
send_command('bind ^f8 gs c toggle AutoStunMode') 			--Ctrl + F8								= Turns AutoStunMode On and Off
send_command('bind !f8 gs c toggle AutoDefenseMode') 		--Alt + F8								= Turns AutoDefenseMode On and Off
send_command('bind ^@!f8 gs c toggle AutoTrustMode') 		--Ctrl + Windows + Alt + F8				= Turns AutoTrustMode On and Off
send_command('bind @pause gs c toggle AutoBuffMode') 		--Windows + Pause/Break					= Turns AutoBuffMode On and Off
send_command('bind @scrolllock gs c cycle Passive') 		--Windows + Scroll Lock					= ???
send_command('bind f9 gs c cycle OffenseMode') 				--F9									= Cycle through OffenseModes (e.g. Accuracy)
send_command('bind ^f9 gs c cycle HybridMode') 				--Ctrl + F9								= Cycle through HybridModes (e.g. PDT, Physical Damage Taken)
send_command('bind @f9 gs c cycle RangedMode') 				--Windows + F9							= Cycle through RangedModes (e.g. Accuracy)
send_command('bind !f9 gs c cycle WeaponskillMode') 		--Alt + F9								= Allows automatic weaponskilling if the job is setup to handle it
send_command('bind f10 gs c set DefenseMode Physical') 		--F10									= Turns your physical defense set on
send_command('bind ^f10 gs c cycle PhysicalDefenseMode') 	--Ctrl + F10							= Changes your physical defense set
send_command('bind !f10 gs c toggle Kiting') 				--Alt + F10								= Keeps your kiting gear on
send_command('bind f11 gs c set DefenseMode Magical') 		--F11 									= Turns your magical defense set on
send_command('bind ^f11 gs c cycle MagicalDefenseMode') 	--Ctrl + F11							= Changes your magical defense set
send_command('bind @f11 gs c cycle CastingMode') 			--Windows + F11 						= Changes your castingmode options such as magic accuracy
send_command('bind !f11 gs c cycle ExtraMeleeMode') 		--Alt + F11								= Adds another set layered on top of your engaged set
send_command('bind ^f12 gs c cycle ResistDefenseMode') 		--Crtl + F12							= Changes your resist defense set
send_command('bind f12 gs c set DefenseMode Resist') 		--F12									= Turns your resist defense set on
send_command('bind @f12 gs c cycle IdleMode') 				--Windows + F12							= Changes your idle mode options such as refresh
send_command('bind !f12 gs c reset DefenseMode') 			--Alt + F12								= Turns your defensive mode off
send_command('bind ^@!f12 gs reload') 						--Ctrl + Windows + Alt + F12			= Reloads gearswap
send_command('bind pause gs c update user') 				--Pause/Break							= Runs a quick check to make sure you have the right gear on and checks variables
send_command('bind ^@!pause gs org') 						--Ctrl + Windows + Alt + Pause/Break	= Runs organizer
send_command('bind ^@!backspace gs c buffup') 				--Ctrl + Windows + Alt + Backspace		= Buffup macro because buffs are love
send_command('bind ^r gs c weapons Default') 				--Ctrl + r								= Resets Weapon Sets to Default
send_command('bind ^z gs c toggle Capacity') 				--Ctrl + z								= Turns CapacityMode On and Off
send_command('bind ^y gs c toggle AutoCleanupMode') 		--Ctrl + y								= Uses certain items and tries to clean up inventory
send_command('bind ^t gs c cycle treasuremode') 			--Ctrl + t								= Turns TreasureMode On and Off
send_command('bind !t input /target <bt>') 					--Alt + t								= Targets the battle target
send_command('bind ^o fillmode') 							--Ctrl + o 								= Lets you see through walls
send_command('bind @m gs c mount Red Crab')					--Windows + m							= Mount and Unmount Default Mount
send_command('bind @~m send @all gs c mount Raptor')		--Windows + Shift + m					= All Logged in Characters Mount and Unmount Default Mount

NotifyBuffs = S{'doom','petrification'}

bayld_items = {'Tlalpoloani','Macoquetza','Camatlatia','Icoyoca','Tlamini','Suijingiri Kanemitsu',
'Zoquittihuitz','Quauhpilli Helm','Chocaliztli Mask','Xux Hat','Quauhpilli Gloves','Xux Trousers',
'Chocaliztli Boots','Maochinoli','Xiutleato','Hatxiik','Kuakuakait','Azukinagamitsu','Atetepeyorg',
'Kaquljaan','Ajjub Bow','Baqil Staff','Ixtab','Tamaxchi','Otomi Helm','Otomi Gloves','Kaabnax Hat',
'Kaabnax Trousers','Ejekamal Mask','Ejekamal Boots','Quiahuiz Helm','Quiahuiz Trousers','Uk\'uxkaj Cap'}