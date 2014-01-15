/*	
	For DayZ Epoch
	Addons Credits: Jetski Yanahui by Kol9yN, Zakat, Gerasimow9, YuraPetrov, zGuba, A.Karagod, IceBreakr, Sahbazz
*/

startLoadingScreen ["","RscDisplayLoadCustom"];
cutText ["","BLACK OUT"];
enableSaving [false, false];

//REALLY IMPORTANT VALUES
dayZ_instance =	11;					//The instance
dayzHiveRequest = [];
initialized = false;
dayz_previousID = 0;

//disable greeting menu 
player setVariable ["BIS_noCoreConversations", true];
//disable radio messages to be heard and shown in the left lower corner of the screen
enableRadio false;
// May prevent "how are you civillian?" messages from NPC
enableSentences false;

// DayZ Epoch config
spawnShoremode = 1; // Default = 1 (on shore)
spawnArea= 1500; // Default = 1500
MaxHeliCrashes= 15; // Default = 5
MaxVehicleLimit = 500; // Default = 50
MaxMineVeins = 50;
MaxDynamicDebris = 150; // Default = 100
dayz_MapArea = 14000; // Default = 10000
dayz_maxLocalZombies = 30; // Default = 30 
DefaultMagazines = ["ItemBandage","ItemBandage","ItemPainkiller"]; 
DefaultWeapons = ["ItemFlashlight"]; 
DefaultBackpack = "DZ_Patrol_Pack_EP1"; 
dayz_zedsAttackVehicles = false;
DZE_DeathMsgGlobal = true; 
DZE_DeathMsgTitleText = true; 
DZE_requireplot = 0;
DZE_BuildingLimit = 15000;
DZE_BackpackGuard = false;

dayz_paraSpawn = false;
dayz_minpos = 0; 
dayz_maxpos = 16000;

dayz_sellDistance_vehicle = 10;
dayz_sellDistance_boat = 30;
dayz_sellDistance_air = 40;

dayz_maxAnimals = 4; // Default: 8
dayz_tameDogs = false;
DynamicVehicleDamageLow = 40; // Default: 0
DynamicVehicleDamageHigh = 90; // Default: 100
DynamicVehicleFuelLow = 0;
DynamicVehicleFuelHigh = 50;

EpochEvents = [["any","any","any","any",30,"crash_spawner"],["any","any","any","any",0,"crash_spawner"],["any","any","any","any",15,"supply_drop"]];
dayz_fullMoonNights = false;

//Load in compiled functions
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\variables.sqf";				//Initilize the Variables (IMPORTANT: Must happen very early)
progressLoadingScreen 0.1;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\publicEH.sqf";				//Initilize the publicVariable event handlers
progressLoadingScreen 0.2;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf";	//Functions used by CLIENT for medical
progressLoadingScreen 0.4;
call compile preprocessFileLineNumbers "custom\compiles.sqf";				//Compile regular functions
progressLoadingScreen 0.5;
call compile preprocessFileLineNumbers "server_traders.sqf";				//Compile trader configs
progressLoadingScreen 1.0;

"filmic" setToneMappingParams [0.153, 0.357, 0.231, 0.1573, 0.011, 3.750, 6, 4]; setToneMapping "Filmic";

if (isServer) then {
	call compile preprocessFileLineNumbers "\z\addons\dayz_server\missions\DayZ_Epoch_11.Chernarus\dynamic_vehicle.sqf";
	//Compile vehicle configs
	
	// Add trader citys
	_nil = [] execVM "\z\addons\dayz_server\missions\DayZ_Epoch_11.Chernarus\mission.sqf";
	_serverMonitor = 	[] execVM "\z\addons\dayz_code\system\server_monitor.sqf";
};


if (!isDedicated) then {
	//Conduct map operations
	0 fadeSound 0;
	waitUntil {!isNil "dayz_loadScreenMsg"};
	dayz_loadScreenMsg = (localize "STR_AUTHENTICATING");
	
	//Run the player monitor
	_id = player addEventHandler ["Respawn", {_id = [] spawn player_death;}];
	_playerMonitor = 	[] execVM "\z\addons\dayz_code\system\player_monitor.sqf";	
	
	//anti Hack

	//Lights
	//[0,0,true,true,true,58,280,600,[0.698, 0.556, 0.419],"Generator_DZ",0.1] execVM "\z\addons\dayz_code\compile\local_lights_init.sqf";
	
	// Mission System Markers
	if (!isServer) then {
		[] execVM "debug\addmarkers.sqf";
		[] execVM "debug\addmarkers75.sqf";
	};
	
	[] execVM "SERVICE\service_point.sqf";
	
	// Custom Monitor
	[] execVM "scripts\custom_monitor.sqf";
};


//Start Dynamic Weather
[] execVM "\z\addons\dayz_code\external\DynamicWeatherEffects.sqf";


#include "\z\addons\dayz_code\system\BIS_Effects\init.sqf"

// UPSMON
call compile preprocessFileLineNumbers "addons\UPSMON\scripts\Init_UPSMON.sqf";

// SHK 
call compile preprocessfile "addons\SHK_pos\shk_pos_init.sqf";

// run SAR_AI
[] execVM "addons\SARGE\SAR_AI_init.sqf";

// auto refuell
[] execVM "scripts\kh_actions.sqf"; 

// Name Tags
[] execVM "scripts\cpcnametags.sqf";

// Churches
[] execVM "scripts\hide_churches.sqf";
[] execVM "scripts\churches.sqf";

// Lift und Tow
[] execVM "R3F_ARTY_AND_LOG\init.sqf";	

// Markers
[] execVM "scripts\custom_marker.sqf";

// Safe Zone
[] execVM "scripts\safezone.sqf";

// Custom Menu
[] execVM "scripts\custom_menu.sqf";