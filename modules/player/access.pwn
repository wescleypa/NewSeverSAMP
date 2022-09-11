new tentativas[MAX_PLAYERS] = 1;
public OnPlayerConnect(playerid)
{
	//Verificando dados
	new sql_acess[100], name[MAX_PLAYER_NAME + 1];
	GetPlayerName(playerid, name, sizeof(name));
	
	format(sql_acess, sizeof(sql_acess), "SELECT `username`, `password` FROM `%s` WHERE username='%s'", SQL_TABLE_PLAYER, name);
	mysql_query(conexao, sql_acess);

	if(cache_num_rows() > 0){
		cache_get_value_name(0, "password", Player[playerid][senha], 24); //Pega senha do usuário
		new bvindas[50];
		format(bvindas, sizeof(bvindas), "Boas vindas ao %s", SERVER_NAME);
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, bvindas, "\
		{298A08}Notamos que você já possuí visto em nosso País,\n\
		{FFFFFF}portanto, Faça Login digitando sua senha abaixo.", "Entrar", "Cancelar");
	}else{
		new bvindas[50];
		format(bvindas, sizeof(bvindas), "Boas vindas ao %s", SERVER_NAME);
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, bvindas, "\
		{8A0808}Notamos que você já possuí visto em nosso País,\n\
		{FFFFFF}portanto, Registre-se digitando sua senha abaixo.", "Entrar", "Cancelar");
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
  new name[MAX_PLAYER_NAME + 1];
  GetPlayerName(playerid, name, sizeof(name));

  if (dialogid == DIALOG_LOGIN)
  {
  	if(strlen(inputtext) != 0)
    {
       if(!strcmp(Player[playerid][senha], inputtext, true, 24)) //Compara a senha do usuário com a digitada
       {
		SendClientMessage(playerid, -1, "Correto");
	   }else{
		  if(tentativas[playerid] >= 5){
			Kick(playerid);
		  }else{
			new msgerror[300];
			tentativas[playerid] += 1;
			format(msgerror, sizeof(msgerror), "\
			{DF0101}A senha digitada não confere.\n\
			{FFFFFF}Você tem mais {DF0101}%d{FFFFFF} tentativas,\n\
			caso exceda todas tentativas, terá seu acesso bloqueado por segurança.\n\n\
			{0489B1}Deseja tentar novamente ?", (6-tentativas[playerid]));
			ShowPlayerDialog(playerid, DIALOG_LOGIN_ERROR, DIALOG_STYLE_MSGBOX, "ERRO - Dados inválidos", msgerror, "Sim", "Cancelar");
		  }
	   }
    }else{
       
    }
    return 1;
  }
  //Dialog após erro de Login
  else if(dialogid == DIALOG_LOGIN_ERROR){
	if (response)
    {
      new bvindas[50], msgerror[100];
	  format(msgerror, sizeof(msgerror), "\
	  {298A08}Notamos que você já possuí visto em nosso País,\n\
	  {FFFFFF}portanto, Faça Login digitando sua senha abaixo.\n\n\
	  Obs: Note que essa é sua {DF0101}%d°{FFFFFF} tentativa de Login,\n\
	  caso exceda {DF0101}5{FFFFFF}, terá seu acesso bloqueado por segurança.", tentativas[playerid]);

	  format(bvindas, sizeof(bvindas), "%d° Tentativa de Login", tentativas[playerid]);
	  ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, bvindas, msgerror, "Entrar", "Cancelar");
    }
    else 
    {
	  new PlayerText: Expulso = TextDrawCreate(100.0, 100.0, "Expulso!");
      TextDrawShowForPlayer(playerid, Expulso);
      Kick(playerid);
    }
	return 1;
  }     
  return 0;
}