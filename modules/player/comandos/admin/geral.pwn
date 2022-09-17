#include "../modules/global/spawns.pwn" //Locais de spawn

public OnPlayerCommandText(playerid, cmdtext[])
{
	new idx;
	new cmd[256];
	cmd = strtok(cmdtext, idx);
    return 1;
}
public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
    if(!success) return ComandoInvalido();
    return true;
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
        format(formatmsg, sizeof(formatmsg), "{015EB5}[Central] {FFFFFF}[%s] %s criou o veículo {015EB5}%d", cargo, name, CarAdmin[playerid]);
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

    if(playerid == d)
      return SendClientMessage(playerid, -1, "{B30404}[!] {FFFFFF}Você não pode ir até si mesmo.");

    new Float:IrX[MAX_PLAYERS], Float:IrY[MAX_PLAYERS], Float:IrZ[MAX_PLAYERS], Float:IrA[MAX_PLAYERS], IrI[MAX_PLAYERS];
    GetPlayerPos(d, IrX[d], IrY[d], IrZ[d]);
    GetPlayerFacingAngle(d, IrA[d]);
    IrI[d] = GetPlayerInterior(d);
    //
    SetPlayerPos(playerid, IrX[d], IrY[d], IrZ[d]);
    SetPlayerFacingAngle(playerid, IrA[d]);
    SetPlayerInterior(playerid, IrI[d]);
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
    format(formattextA, sizeof(formattextA), "{%s}[Central] {FFFFFF}[%s] %s foi até [%d]%s.", Color(1), cargo, nameAdmin, d, name);
    //Enviando mensagens
    SendClientMessage(playerid, -1, formattextP);
    SendClientMessage(playerid, -1, formattext);
    if(ADMIN_MSG_IR == true) ToAdmins(formattextA);
    
    LogAdmin(playerid, "cmd", "ir", "");
    return 1;       
    }

    CMD:trazer(playerid, params[]){
        if(logado[playerid] == 0) return 1;
        if(Player[playerid][admin] < ADMIN_DIRETOR) return ComandoInvalido(playerid);

        new d;
        if(sscanf(params, "d[30]", d))
          return SendClientMessage(playerid, -1, "{B30404}[!] {FFFFFF}Use /trazer {FFFFFF}[Player ID]");

        if(logado[d] == 0)
          return SendClientMessage(playerid, -1, "{B30404}[!] {FFFFFF}a pessoa informada está desconectada.");

        if(playerid == d)
          return SendClientMessage(playerid, -1, "{B30404}[!] {FFFFFF}Você não pode trazer a si mesmo.");

        GetPlayerPos(d, pX[d], pY[d], pZ[d]);
        GetPlayerFacingAngle(d, pA[d]);
        pI[d] = GetPlayerInterior(d);
        //
        new Float:aX[MAX_PLAYERS], Float:aY[MAX_PLAYERS], Float:aZ[MAX_PLAYERS], Float:aA[MAX_PLAYERS], aI[MAX_PLAYERS];
        GetPlayerPos(playerid, aX[playerid], aY[playerid], aZ[playerid]);
        GetPlayerFacingAngle(playerid, aA[playerid]);
        aI[playerid] = GetPlayerInterior(playerid);
        //
        SetPlayerPos(d, aX[playerid], aY[playerid], aZ[playerid]);
        SetPlayerFacingAngle(d, aA[playerid]);
        SetPlayerInterior(d, aI[playerid]);
        //
        new cargo[20];
        cargo = RankAdmin(Player[playerid][genre], Player[playerid][admin]);
        new formattext[200], formattextP[200], formattextA[200], name[MAX_PLAYER_NAME+1], nameAdmin[MAX_PLAYER_NAME+1];
        //Coletando nomes
        GetPlayerName(d, name, sizeof(name));
        GetPlayerName(playerid, nameAdmin, sizeof(nameAdmin));
        //
        format(formattextP, sizeof(formattextP), "{%s}>> [%s] %s trouxe você.", Color(0), cargo, nameAdmin);
        format(formattext, sizeof(formattext), "{%s}>> Você trouxe %s. para leva-lo(a) de volta, use /voltar", Color(0), name);
        format(formattextA, sizeof(formattextA), "{%s}[Central] {FFFFFF}[%s] %s puxou [%d]%s.", Color(1), cargo, nameAdmin, d, name);
        trouxe[d] = 1;
        //Enviando mensagens
        SendClientMessage(playerid, -1, formattextP);
        SendClientMessage(playerid, -1, formattext);
        if(ADMIN_MSG_IR == true) ToAdmins(formattextA);
        
        LogAdmin(playerid, "cmd", "trazer", "");
    return 1;    
    }

    CMD:voltar(playerid, params[]){
        if(logado[playerid] == 0) return 1;
        if(Player[playerid][admin] < ADMIN_DIRETOR) return ComandoInvalido(playerid);

        new d;
        if(sscanf(params, "d[30]", d))
          return SendClientMessage(playerid, -1, "{B30404}[!] {FFFFFF}Use /voltar {FFFFFF}[Player ID]");

        if(logado[d] == 0)
          return SendClientMessage(playerid, -1, "{B30404}[!] {FFFFFF}a pessoa informada está desconectada.");

        if(playerid == d)
          return SendClientMessage(playerid, -1, "{B30404}[!] {FFFFFF}Você não pode voltar a si mesmo(a).");

        if(trouxe[d] == 0)
          return SendClientMessage(playerid, -1, "{B30404}[!] {FFFFFF}Esta pessoa não foi puxada por ninguém.");

        SetPlayerPos(d, pX[d], pY[d], pZ[d]);
        SetPlayerFacingAngle(d, pA[d]);
        SetPlayerInterior(d, pI[d]);
        trouxe[d] = 0;

        new cargo[20];
        cargo = RankAdmin(Player[playerid][genre], Player[playerid][admin]);
        new formattext[200], formattextP[200], formattextA[200], name[MAX_PLAYER_NAME+1], nameAdmin[MAX_PLAYER_NAME+1];
        //Coletando nomes
        GetPlayerName(d, name, sizeof(name));
        GetPlayerName(playerid, nameAdmin, sizeof(nameAdmin));
        //
        format(formattextP, sizeof(formattextP), "{%s}>> [%s] %s levou você de volta.", Color(0), cargo, nameAdmin);
        format(formattext, sizeof(formattext), "{%s}>> Você levou %s ao seu local de origem.", Color(0), name);
        format(formattextA, sizeof(formattextA), "{%s}[Central] {FFFFFF}[%s] %s levou [%d]%s ao seu local de origem.", Color(1), cargo, nameAdmin, d, name);
        trouxe[d] = 1;
        //Enviando mensagens
        SendClientMessage(playerid, -1, formattextP);
        SendClientMessage(playerid, -1, formattext);
        if(ADMIN_MSG_IR == true) ToAdmins(formattextA);
        
        LogAdmin(playerid, "cmd", "voltar", "");
     return 1;
    }