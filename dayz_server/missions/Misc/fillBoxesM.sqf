_crate = _this select 0;

_crate setVariable ["permaLoot",true];

clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;

_crate addMagazineCargoGlobal ["ItemBandage", 10];
_crate addMagazineCargoGlobal ["ItemMorphine", 10];
_crate addMagazineCargoGlobal ["ItemEpinephrine", 10];
_crate addMagazineCargoGlobal ["ItemPainkiller", 15];
_crate addMagazineCargoGlobal ["ItemWaterbottle", 10];
_crate addMagazineCargoGlobal ["FoodCanBakedBeans", 25];
_crate addMagazineCargoGlobal ["ItemAntibiotic", 10];
_crate addMagazineCargoGlobal ["ItemBloodbag", 15];