//Define locais
enum Locais{
    ls, //Los Santos
    lv  //Las Venturas
}

stock ToSpawn(playerid, local){
    if(local == ls){
      SetPlayerPos(playerid, 1482.1118, -1677.4886, 14.0469);
      SetPlayerFacingAngle(playerid, 176.2255);
      SetPlayerInterior(playerid, 0);
    }else if(local == lv){
      SetPlayerPos(playerid, 1690.5522, 1453.8761, 10.7662);
      SetPlayerFacingAngle(playerid, 269.2406);
      SetPlayerInterior(playerid, 0);
    }
    return 1;
}