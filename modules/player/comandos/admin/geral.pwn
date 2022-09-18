#include "../modules/global/spawns.pwn" //Locais de spawn


public OnPlayerCommandText(playerid, cmdtext[])
{
	new idx;
	new cmd[256];
	
	cmd = strtok(cmdtext, idx);
    return 1;
}


    CMD:criarveiculo(playerid, params[]) { //Criar veículo
  
        if(logado[playerid] == 0) return 1;
        if(Player[playerid][admin] < 1) return ComandoInvalido(playerid);
        new CarModel, Cor[2], Float:X, Float:Y, Float:Z, Float:A;
        if(GetPlayerInterior(playerid) != 0) 
            return SendClientMessage(playerid, -1, "{B30404}[!] {FFFFFF}Você não pode criar um veículo dentro de interior");
        if(sscanf(params, "dD(-1)D(-1)[32]", CarModel, Cor[0], Cor[1]))
            return SendClientMessage(playerid, -1,  "{B30404}[!] {FFFFFF}Use {015EB5}/criarveiculo {FFFFFF}[Modelo] [Cor 1] [Cor 2]");

        if(Cor[0] < 0 || Cor[1] > 255)
            return SendClientMessage(playerid, -1,  "{B30404}[!] {FFFFFF}O número da cor deve ser entre 0 à 255.");     
        if(CarModel < 400 || CarModel > 611)
            return SendClientMessage(playerid, -1,  "{B30404}[!] {FFFFFF}Modelo inexistente.");
        
        GetPlayerPos(playerid, X, Y, Z);
        GetPlayerFacingAngle(playerid, A);

        if(CriouCarAdmin[playerid] > 0){ DestroyVehicle(CarAdmin[playerid]); }

        CarAdmin[playerid] = CreateVehicle(CarModel, X, Y, Z, A, Cor[0], Cor[1], -1);
        SetVehicleVirtualWorld(CarAdmin[playerid], GetPlayerVirtualWorld(playerid));
        LinkVehicleToInterior(CarAdmin[playerid], GetPlayerInterior(playerid));
        PutPlayerInVehicle(playerid, CarAdmin[playerid], 0);
        CriouCarAdmin[playerid] = 1;

        new cargo[30], name[MAX_PLAYER_NAME+1];
        GetPlayerName(playerid, name, sizeof(name));
        cargo = RankAdmin(Player[playerid][genre], Player[playerid][admin]);
        new formatmsg[120];
        format(formatmsg, sizeof(formatmsg), "{015EB5}[Central] [%s] %s {FFFFFF}criou o veículo {015EB5}%d", cargo, name, CarAdmin[playerid]);
        ToAdmins(formatmsg);

        LogAdmin(playerid, "cmd", "criarveiculo", "");
    return 1;
    }

    CMD:destruirveiculo(playerid, params[]){
      if(logado[playerid] == 0) return 1;
      if(Player[playerid][admin] < 3) return ComandoInvalido(playerid);
      new CarID;
      if(sscanf(params, "d[20]", CarID))
            return SendClientMessage(playerid, -1, "{B30404}[!] {FFFFFF}Use {015EB5}/destruirveiculo {FFFFFF}[ID]");

      DestroyVehicle(CarID);
      LogAdmin(playerid, "cmd", "destruirveiculo", "");

      new cargo[30], name[MAX_PLAYER_NAME+1];
      GetPlayerName(playerid, name, sizeof(name));
      cargo = RankAdmin(Player[playerid][genre], Player[playerid][admin]);
      new formatmsg[120];
      format(formatmsg, sizeof(formatmsg), "{015EB5}[Central] {%s}[%s] %s {FFFFFF}destruiu o veículo {015EB5}%d",
      ColorAdmin(Player[playerid][admin]), cargo, name, CarID);
      ToAdmins(formatmsg);
     return 1;
    }

    CMD:ls(playerid){ //Vai até Los Santos
        if(logado[playerid] == 0) return 1;
        if(Player[playerid][admin] < 1) return ComandoInvalido(playerid);
        ToSpawn(playerid, ls);
        return 1;
    }

    CMD:lv(playerid){ //Vai até Las Venturas
        if(logado[playerid] == 0) return 1;
        if(Player[playerid][admin] < 1) return ComandoInvalido(playerid);
        ToSpawn(playerid, lv);
        return 1;
    }
    CMD:sf(playerid){ //Vai até San Fierro
        if(logado[playerid] == 0) return 1;
        if(Player[playerid][admin] < 1) return ComandoInvalido(playerid);
        ToSpawn(playerid, sf);
        return 1;
    }
    CMD:pos(playerid, params[]){ 
    if(logado[playerid] == 0) return 1;
        new para, nivel;

        if(Player[playerid][admin] < ADMIN_DIRETOR) return ComandoInvalido(playerid);

    new Float:X,Float:Y,Float:Z,Float:R, Veh = GetPlayerVehicleID(playerid);
    if(!IsPlayerInAnyVehicle(playerid))
    {
        GetPlayerPos(playerid, X,Y,Z);
        GetPlayerFacingAngle(playerid, R);
    }
    else
    {
        GetVehiclePos(Veh, X,Y,Z);
        GetVehicleZAngle(Veh, R);
    }
    new mensagem[120];
   format(mensagem, sizeof(mensagem), "X: %f, Y: %f, Z: %f, A: %f", X, Y, Z, R);
   SendClientMessage(playerid, -1, mensagem);
  
    return 1;
}

    CMD:setaradmin(playerid, params[]){ //Promove alguém à admin
        if(logado[playerid] == 0) return 1;
        new para, nivel;

        if(Player[playerid][admin] < ADMIN_DIRETOR) return ComandoInvalido(playerid);

        if(sscanf(params, "dd[40]", para, nivel))
          return SendClientMessage(playerid, -1, "{B30404}[!] {FFFFFF}Use /setaradmin {FFFFFF}[ID] [Level]");
        if(Player[playerid][admin] < ADMIN_OWNER && nivel > ADMIN_SUPERVISOR)
        {
          new ate[100];
          format(ate, sizeof(ate), "{B30404}[!] {FFFFFF}Você só pode setar até o level %d", ADMIN_SUPERVISOR);
          SendClientMessage(playerid, -1, ate);
        } 

        if(playerid == para)
          return  SendClientMessage(playerid, -1, "{B30404}[!] {FFFFFF}Você não pode promover à si mesmo.");

        Player[para][admin] = nivel;
        new msgadminsetou[120], msgadminsetou2[120], cargo[20],\
        cargo2[20], name[MAX_PLAYER_NAME+1], namequem[MAX_PLAYER_NAME+1];

        GetPlayerName(playerid, name, sizeof(name));  //Nome do responsável
        GetPlayerName(para, namequem, sizeof(namequem));  //Nome do receptor

        cargo = RankAdmin(Player[playerid][genre], Player[playerid][admin]);
        cargo2 = RankAdmin(Player[playerid][genre], nivel);

        format(msgadminsetou, sizeof(msgadminsetou), "{015EB5}[Server]{FFFFFF} %s promoveu você à {%s}%s{FFFFFF}, obrigado por fazer parte da equipe :D", 
        name, ColorAdmin(nivel), cargo2);
        SendClientMessage(para, -1, msgadminsetou);

        format(msgadminsetou2, sizeof(msgadminsetou2), "{015EB5}[Server]{FFFFFF} Você promoveu %s à {%s}%s", namequem, ColorAdmin(nivel), cargo2);
        SendClientMessage(playerid, -1, msgadminsetou2);  

        new formatmsg[120];
        format(formatmsg, sizeof(formatmsg), "{015EB5}[Central] {%s}[%s] %s {FFFFFF}promoveu {015EB5}%s {FFFFFF}à {%s}%s",
        ColorAdmin(Player[playerid][admin]), cargo, name,
        namequem, ColorAdmin(nivel), cargo2);
        ToAdmins(formatmsg);
        LogAdmin(playerid, "cmd", "reiniciar", namequem);
        return 1;
    }

    CMD:reiniciar(playerid, params[]){ //Reinicia servidor
    if(logado[playerid] == 0) return 1;
    if(Player[playerid][admin] < ADMIN_DIRETOR) return ComandoInvalido(playerid);

    new s, aviso[120], avisoT[120];
    if(sscanf(params, "d[40]", s))
      return SendClientMessage(playerid, -1, "{B30404}[!] {FFFFFF}Use /gmx {FFFFFF}[Segundos]");

    if(s < 15) return SendClientMessage(playerid, -1, "{B30404}[!] {FFFFFF}O mínimo permitido é de {B30404}15{FFFFFF} segundos");
    format(aviso, sizeof(aviso), "{B30404}[ATENÇÃO] {FFFFFF}O servidor será reiniciado em %d segundos", s);
    SendClientMessageToAll(-1, aviso);
    
    format(avisoT, sizeof(avisoT), "~r~ATENCAO~n~ ~w~O servidor sera reiniciado em~r~ %d ~w~segundos", s);
    GameTextForAll(avisoT, 5000, 3 );
    gmxagora = true;
    Reiniciar(s);
    //Log
    new log[250], name[MAX_PLAYER_NAME+1];
            GetPlayerName(playerid, name, sizeof(name));  //Nome do responsável

    format(log, sizeof(log), "[CMD] %s usou o comando /reiniciar", name);
    LogAdmin(playerid, "cmd", "reiniciar", "");
    return 1;
    }   

    CMD:ir(playerid, params[]){
    if(logado[playerid] == 0) return 1;
    if(Player[playerid][admin] < ADMIN_DIRETOR) return ComandoInvalido(playerid);

    new d;
    if(sscanf(params, "d[30]", d))
      return SendClientMessage(playerid, -1, "{B30404}[!] {FFFFFF}Use /ir {FFFFFF}[Player ID]");

    if(logado[d] == 0)
      return SendClientMessage(playerid, -1, "{B30404}[!] {FFFFFF}a pessoa informada está desconectada.");

    new Float:IrX, Float:IrY, Float:IrZ, Float:IrA, IrI;
    GetPlayerPos(d, IrX, IrY, IrZ);
    GetPlayerFacingAngle(d, IrA);
    IrI = GetPlayerInterior(d);
    //
    SetPlayerPos(playerid, IrX, IrY, IrZ);
    SetPlayerFacingAngle(playerid, IrA);
    SetPlayerInterior(playerid, IrI);
    //
    new cargo[20];
    cargo = RankAdmin(Player[playerid][genre], Player[playerid][admin]);
    new formattext[200], formattextP[200], formattextA[200], name[MAX_PLAYER_NAME+1], nameAdmin[MAX_PLAYER_NAME+1];
    //Coletando nomes
    GetPlayerName(d, name, sizeof(name));
    GetPlayerName(playerid, nameAdmin, sizeof(nameAdmin));
    //
    format(formattextP, sizeof(formattextP), "{%s}>> [%s] %s veio até você.", Color(0), cargo, nameAdmin);
    format(formattext, sizeof(formattext), "{%s}>> Você foi até %s", Color(0), name);
    format(formattextA, sizeof(formattextA), "{%s}[Central] {FFFFFF}%s %s foi até [%d]%s.", Color(1), cargo, nameAdmin, d, name);
    //Enviando mensagens
    SendClientMessage(playerid, -1, formattextP);
    SendClientMessage(playerid, -1, formattext);
    ToAdmins(formattextA);
    return 1;       
    }
   