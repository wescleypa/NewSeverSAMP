#include "../modules/player/strtock.pwn"

new logado[MAX_PLAYERS] = 0,
tentativas[MAX_PLAYERS] = 0;

public OnPlayerDeath(playerid, killerid, reason)
{
   	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	TogglePlayerSpectating(playerid, false);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	GetPlayerPos(playerid, Player[playerid][dX], Player[playerid][dY], Player[playerid][dZ]);
	GetPlayerFacingAngle(playerid, Player[playerid][dA]);
	Player[playerid][dI] = GetPlayerInterior(playerid);
	
	Salvar(playerid);
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == RegisterPTD[playerid][3]) //campo senha
	{
      ShowPlayerDialog(playerid, DIALOG_REGISTER_TXD, DIALOG_STYLE_INPUT, "Digite uma senha abaixo", " ", "Registrar", "Cancelar");
      CancelSelectTextDraw(playerid);
	}
	else if(playertextid == RegisterPTD[playerid][4]){
		if(strlen(PASS[playerid]) > 24)
		  return ShowPlayerDialog(playerid, DIALOG_REGISTER_TXD, DIALOG_STYLE_INPUT, "Senha muito longa", "\
		  {8A0808}A senha digita é muito longa!,\n\
		  {FFFFFF}A senha escolhida é muito longa, sua senha deve ser menor de 24 caracteres.", "Registrar", "Cancelar");

		else if(strlen(PASS[playerid]) < 8)
		  return ShowPlayerDialog(playerid, DIALOG_REGISTER_TXD, DIALOG_STYLE_INPUT, "Senha muito curta", "\
		  {8A0808}A senha digita é muito curta!,\n\
		  {FFFFFF}A senha escolhida é muito curta, sua senha deve ser maior de 8 caracteres.", "Registrar", "Cancelar");

	if(cadastrando[playerid] != 1){
		GetPlayerName(playerid, name, sizeof(name));
		//Insertando dados no banco
		new sql_insert[300];
		format(sql_insert, sizeof(sql_insert), "\
		INSERT INTO `contas`(`username`, `password`,\
		`money`, `level`, `dX`, `dY`, `dZ`, `dA`, `dI`, `admin`, `genre`) VALUES (\
		'%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%d', '0', '1')", name, PASS[playerid], DEFAULT_MONEY, DEFAULT_LEVEL,
		SpawnX, SpawnY, SpawnZ, SpawnA, SpawnI);
		mysql_query(conexao, sql_insert, false);

		//Fazendo Login
		cache_get_value_name(0, "password", Player[playerid][password]); //Pega senha do usuário
      	CancelSelectTextDraw(playerid);
		for(new i=0; i<10; i++){
		  TextDrawHideForPlayer(playerid, RegisterTD[i]);
		}
		for(new i=0; i<6; i++){
		  PlayerTextDrawHide(playerid, RegisterPTD[playerid][i]);
		}
		ColetaDados(playerid);
	}else{
	   if(!strcmp(Player[playerid][password], PASS[playerid], true, 24)) //Compara a senha do usuário com a digitada
       {
		//Fazendo Login
		cache_get_value_name(0, "password", Player[playerid][password]); //Pega senha do usuário
      	CancelSelectTextDraw(playerid);
		for(new i=0; i<9; i++){
		  TextDrawHideForPlayer(playerid, RegisterTD[i]);
		}
		for(new i=0; i<7; i++){
		  PlayerTextDrawHide(playerid, RegisterPTD[playerid][i]);
		}
		ColetaDados(playerid);
	   }

	   else{
		  if(tentativas[playerid] >= 5){
			new ip[MAX_PLAYERS];
    		GetPlayerIp(playerid, ip[playerid], 30);
			Block(ip[playerid], TIME_BLOCK_LOGIN, "Excesso de tentativas de login");
			Kick(playerid);
		  }else{
			new senhainvalida[MAX_PLAYERS];
			tentativas[playerid]++;
			format(senhainvalida, sizeof(senhainvalida), "A senha digitada e invalida, voce tem mais %d tentativas\n\
			se atingir todas tentativas teras eu acesso bloqueado por %d minutos", (5-tentativas[playerid]), TIME_BLOCK_LOGIN);
			PlayerTextDrawSetString(playerid, RegisterPTD[playerid][6], senhainvalida[playerid]);
			PlayerTextDrawColor(playerid, RegisterPTD[playerid][6], 0xB30404FF);
			PlayerTextDrawBoxColor(playerid, RegisterPTD[playerid][0], 0xB30404FF);
		}
	   }
	}
		
	}
	else if(playertextid == RegisterPTD[playerid][5]){
	  	Send(playerid, -1, "Você foi desconectado porque recusou realizar Login");
		Kick(playerid);
	}

    return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
}

stock Spawn(playerid){ //Spawn player login
	TogglePlayerSpectating(playerid, 0); //Spactate
	TogglePlayerControllable(playerid, 1);
	SpawnPlayer(playerid);
	SetPlayerPos(playerid, Player[playerid][dX], Player[playerid][dY], Player[playerid][dZ]);
	SetPlayerFacingAngle(playerid, Player[playerid][dA]); 
	SetPlayerInterior(playerid, Player[playerid][dI]);
}

stock Salvar(playerid){
	if(logado[playerid] == 0) return 1;

	GetPlayerName(playerid, name, MAX_PLAYER_NAME);

	new sql_update[300];
	format(sql_update, sizeof(sql_update), "UPDATE `%s` SET `money`='%d', `level`='%d',\
	`dI`='%d', `dX`=%f, `dY`=%f, `dZ`=%f, `dA`=%f, `admin`=%d WHERE `username`='%s'", SQL_TABLE_PLAYER, Player[playerid][money],\ 
	Player[playerid][level], Player[playerid][dI], Player[playerid][dX], Player[playerid][dY],\
	Player[playerid][dZ], Player[playerid][dA], Player[playerid][admin], name);
	mysql_query(conexao, sql_update, false);
	return 1;
}

stock ToAdmins(msg[]){
	foreach(new i: Player)
    {
		if(Player[i][admin] >= ADMIN_ADMINISTRADOR){
			SendClientMessage(i, -1, msg);
		}
	}
	return 1;
}

stock SalvarContas(){//Salvamento de contas em geral
	foreach(new i: Player)
    {
		if(logado[i] > 0){
			new namesalvar[MAX_PLAYER_NAME+1], sql_update[300];
			GetPlayerName(i, namesalvar, sizeof(namesalvar));

		format(sql_update, sizeof(sql_update), "UPDATE `%s` SET `money`='%d', `level`='%d',\
		`dI`='%d', `dX`=%f, `dY`=%f, `dZ`=%f, `dA`=%f, `admin`=%d WHERE `username`='%s'", SQL_TABLE_PLAYER, Player[i][money],\ 
		Player[i][level], Player[i][dI], Player[i][dX], Player[i][dY],\
		Player[i][dZ], Player[i][dA], Player[i][admin], namesalvar);
		mysql_query(conexao, sql_update, false);
		}
	}
}

stock Block(ip[], time, reason[]){
	new iip, rr, tt;
	sscanf(ip, "s", iip);
	sscanf(reason, "s", rr);
	blocked[iip] = 1;
	blockedR[iip] = rr;
	blockedT[iip] = time;
return 1;
}

stock LoadMarks(playerid){
 for(new i=0; i<MAX_PLAYERS; i++){
  for(new p=0; p<MAX_PLAYERS; p++){
    if(IsPlayerConnected(i) && IsPlayerConnected(p)){
      if(Player[i][admin] > 0){
        SetPlayerMarkerForPlayer(i, p, GetPlayerColor(p));
      } 
    }
  }             
 }
}

stock SendLocal(playerid, msg[]){
	new str[200];
	new Float:x, float: y, Float: z;
	GetPlayerPos(playerid, x, y, z);

	for(new i=0; i<MAX_PLAYERS; i++){
      if(IsPlayerConnected(i)){
        if(IsPlayerInRangeOfPoint(i, 30.0, x, y, z)){
          format(str, sizeof(str), "%s", msg);
          Send(i, -1, str);
        }
      }
	}
}

stock Ligar(playerid, type[]){
	playerstate[playerid] = GetPlayerState(playerid);
	if(playerstate[playerid] != PLAYER_STATE_DRIVER) return 1;
	vehicleid[playerid] = GetPlayerVehicleID(playerid);

	new str[120];
	//new motor, farol, alarme, portas, capo, portamalas, obj;
	GetVehicleParamsEx(vehicleid[playerid], motor[vehicleid[playerid]], farol[vehicleid[playerid]],
	alarme[vehicleid[playerid]], portas[vehicleid[playerid]], capo[vehicleid[playerid]],
	portamalas[vehicleid[playerid]], objcar[vehicleid[playerid]]);

	if(strcmp(type, "motor", true) == 0){ //ligar motor
	  if(motor[vehicleid[playerid]] == VEHICLE_PARAMS_OFF){//off
		SetVehicleParamsEx(vehicleid[playerid], VEHICLE_PARAMS_ON, farol[vehicleid[playerid]],
		alarme[vehicleid[playerid]], portas[vehicleid[playerid]], capo[vehicleid[playerid]],
		portamalas[vehicleid[playerid]], objcar[vehicleid[playerid]]);
		EngineCar[vehicleid[playerid]] = 1;
		format(str, sizeof(str), "{%s}>> %s girou a chave de ignição e LIGOU o motor do veículo.", Color(2), name);
	  }else{
		SetVehicleParamsEx(vehicleid[playerid], VEHICLE_PARAMS_OFF, farol[vehicleid[playerid]],
		alarme[vehicleid[playerid]], portas[vehicleid[playerid]], capo[vehicleid[playerid]],
		portamalas[vehicleid[playerid]], objcar[vehicleid[playerid]]);
		EngineCar[vehicleid[playerid]] = 0;
		format(str, sizeof(str), "{%s}>> %s girou a chave de ignição e DESLIGOU o motor do veículo.", Color(2), name);
	  }
	}
	SendLocal(playerid, str);
	return 1;
}

stock AdminVehicle(playerid, vehicle, type[]){
	if(Player[playerid][admin] <= PERM_ADMIN_VEHICLE) return ComandoInvalido(playerid);

	new str[120], strP[120], ge[100];
	//new motor, farol, alarme, portas, capo, portamalas, obj;
	GetVehicleParamsEx(vehicle, motor[vehicle], farol[vehicle],
	alarme[vehicle], portas[vehicle], capo[vehicle],
	portamalas[vehicle], objcar[vehicle]);

	GetPlayerName(playerid, name, sizeof(name));

	if(strcmp(type, "motor", true) == 0){
		if(motor[vehicle] == VEHICLE_PARAMS_OFF){//off
			SetVehicleParamsEx(vehicle, VEHICLE_PARAMS_ON, farol[vehicle],
			alarme[vehicle], portas[vehicle], capo[vehicle],
			portamalas[vehicle], objcar[vehicle]);
			EngineCar[vehicle] = 1;
			format(str, sizeof(str), "{%s}[Central] %s %s ligou o motor do veículo %d", Color(1), RankAdmin(Player[playerid][genre],
			Player[playerid][admin]), name, vehicle);
		}else{
			SetVehicleParamsEx(vehicle, VEHICLE_PARAMS_ON, farol[vehicle],
			alarme[vehicle], portas[vehicle], capo[vehicle],
			portamalas[vehicle], objcar[vehicle]);
			EngineCar[vehicle] = 1;
			format(str, sizeof(str), "{%s}[Central] %s %s ligou o motor do veículo %d", Color(1), RankAdmin(Player[playerid][genre],
			Player[playerid][admin]), name, vehicle);
	    }
	}	
}