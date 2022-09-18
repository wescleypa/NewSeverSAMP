//Jetpack adm e player
CMD:jetpack(playerid){
    if(Player[playerid][admin] <= 0) return ComandoInvalido();
    new msg[200];
    GetPlayerName(playerid, name, sizeof(name));
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    for(new i=0; i<MAX_PLAYERS; i++){
        if(IsPlayerConnected(i)){
            if(IsPlayerInRangeOfPoint(i, 30.0, x, y, z)){
                format(msg, sizeof(msg), "{%s}>> %s pegou sua mochila a jato.", Color(2), name);
                Send(i, -1, msg);
            }
        }
    }
    SetPlayerSpecialAction(playerid, 2);
    return 1;
}

CMD:ligar(playerid, params[]){
    if(logado[playerid] <= 0) return 1;
    if(!IsPlayerInAnyVehicle(playerid)) return 1;
    new s;
    if(sscanf(params, "s[50]", s))
        return SendClientMessage(playerid, -1, "{B30404}[!] {FFFFFF}Use /ligar [tipo] --> Tipos: [motor, farol]");

    Ligar(playerid, params);
    return 1;
}