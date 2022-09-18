public OnPlayerConnect(playerid)
{
	LoadMarks(playerid);
	new sql_acess[100],
	strola[MAX_PLAYERS];
	GetPlayerName(playerid, name, sizeof(name));

	new ip[MAX_PLAYERS];
    GetPlayerIp(playerid, ip[playerid], 30);

	for(new i; i < 10; i++) Send(playerid,-1,""); //clear chat
	LoadPTextdraw(playerid); //Load textdraws
	TogglePlayerSpectating(playerid, 1); //Spactate
	SetSpawnInfo(playerid, 0, 0, Player[playerid][dX],\
	Player[playerid][dY], Player[playerid][dZ], Player[playerid][dA], 0, 0, 0, 0, 0, 0); //Não mexa
	
	//Verificando dados

	format(sql_acess, sizeof(sql_acess), "SELECT `username`, `password` FROM `%s` WHERE username='%s'", SQL_TABLE_PLAYER, name);
	mysql_query(conexao, sql_acess);

		format(strola[playerid], sizeof(strola), "Ola %s", name);
		PlayerTextDrawSetString(playerid, RegisterPTD[playerid][1], name);
		PlayerTextDrawSetString(playerid, RegisterPTD[playerid][2], strola[playerid]);
		TextDrawSetString(RegisterTD[4], SERVER_NAME);
	if(cache_num_rows() > 0){
		cache_get_value_name(0, "password", Player[playerid][password], 24); //Pega senha do usuário
		PlayerTextDrawSetString(playerid, RegisterPTD[playerid][6], "\
		Notamos que voce ja tem visto em nosso pais, portanto, digite sua senha abaixo");
		PlayerTextDrawSetString(playerid, RegisterPTD[playerid][4], "ENTRAR");
		cadastrando[playerid] = 1;
	}else{		
		cadastrando[playerid] = 2;
	}
	for(new i=0; i<9; i++){
		TextDrawShowForPlayer(playerid, RegisterTD[i]);
	}
	for(new i=0; i<7; i++){
		PlayerTextDrawShow(playerid, RegisterPTD[playerid][i]);
		SelectTextDraw(playerid, 0x015EB5FF);
	}
		InterpolateCameraPos(playerid, DEFAULT_CAMERA_X, DEFAULT_CAMERA_Y, DEFAULT_CAMERA_Z,\
		DEFAULT_CAMERA_X_2, DEFAULT_CAMERA_Y_2, DEFAULT_CAMERA_Z_2, 30000, CAMERA_MOVE);

	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
  GetPlayerName(playerid, name, sizeof(name));

  //Dialog Register TXD
  if(dialogid == DIALOG_REGISTER_TXD){
	if(!response)
	  return SelectTextDraw(playerid, 0x015EB5FF);
	  
	else if(strlen(inputtext) > 24)
	  return ShowPlayerDialog(playerid, DIALOG_REGISTER_TXD, DIALOG_STYLE_INPUT, "Senha muito longa", "\
	  {8A0808}A senha digita é muito longa!,\n\
	  {FFFFFF}A senha escolhida é muito longa, sua senha deve ser menor de 24 caracteres.", "Registrar", "Cancelar");

	else if(strlen(inputtext) < 8)
	  return ShowPlayerDialog(playerid, DIALOG_REGISTER_TXD, DIALOG_STYLE_INPUT, "Senha muito curta", "\
	  {8A0808}A senha digita é muito curta!,\n\
	  {FFFFFF}A senha escolhida é muito curta, sua senha deve ser maior de 8 caracteres.", "Registrar", "Cancelar");
	
	else if(response && strlen(inputtext) >= 8)
	{ 
		sscanf(inputtext, "s", PASS[playerid]);
		PlayerTextDrawSetString(playerid, RegisterPTD[playerid][3], PASS[playerid]);
	    SelectTextDraw(playerid, 0x015EB5FF);
	}
  return 1;
  } 

  return 0;
}

ColetaDados(playerid){

	new sql_acess[300];
	GetPlayerName(playerid, name, sizeof(name));

	format(sql_acess, sizeof(sql_acess), "SELECT *\
    FROM `%s` WHERE username='%s'", SQL_TABLE_PLAYER, name);
	mysql_query(conexao, sql_acess);

	//Coletando dados do usuário
	cache_get_value_int(0, "money", Player[playerid][money]); //Pega dinheiro do usuário
	cache_get_value_int(0, "level", Player[playerid][level]); //Pega dinheiro do usuário
	cache_get_value_float(0, "dX", Player[playerid][dX]); //Pega a posição X que o usuário desconectou
	cache_get_value_float(0, "dY", Player[playerid][dY]); //Pega a posição Y que o usuário desconectou
	cache_get_value_float(0, "dZ", Player[playerid][dZ]); //Pega a posição Z que o usuário desconectou
	cache_get_value_float(0, "dA", Player[playerid][dA]); //Pega a posição A que o usuário desconectou
	cache_get_value_int(0, "dI", Player[playerid][dI]); //Pega o interior que o usuário desconectou
	cache_get_value_int(0, "admin", Player[playerid][admin]); //Pega o nível de admin do usuário
	cache_get_value_int(0, "genre", Player[playerid][genre]); //Pega o nível de admin do usuário
	//
	//Seta dados do usuário
	SetaDados(playerid);
}

SetaDados(playerid){
	SetSpawnInfo(playerid, 0, 0, Player[playerid][dX],\
	Player[playerid][dY], Player[playerid][dZ], Player[playerid][dA], 0, 0, 0, 0, 0, 0); //Não mexa

	GivePlayerMoney(playerid, Player[playerid][money]);
	SetPlayerScore(playerid, Player[playerid][level]);
	
	Spawn(playerid);
	logado[playerid] = 1;
}



//if(dest != "127.0.0.1") return exit();