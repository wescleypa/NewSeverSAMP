#include "../modules/player/strtock.pwn"
#include "../modules/player/variaveis.pwn"

public OnPlayerCommandText(playerid, cmdtext[])
{
	new idx;
	new cmd[256];
	
	cmd = strtok(cmdtext, idx);

	if(strcmp(cmd, "/yadayada", true) == 0) {
    	return 1;
	}

	if (!strcmp(cmdtext, "/ip"))
    {
        new dest[22];
        NetStats_GetIpPort(playerid, dest, sizeof(dest));

        new szString[144];
        format(szString, sizeof(szString), "Your current IP and port: %s.", dest);
        SendClientMessage(playerid, -1, szString);
    }

	return 0;
}

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
	new name[MAX_PLAYER_NAME+1];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	GetPlayerPos(playerid, Player[playerid][dX], Player[playerid][dY], Player[playerid][dZ]);
	GetPlayerFacingAngle(playerid, Player[playerid][dA]);
	Player[playerid][dI] = GetPlayerInterior(playerid);
	
	Salvar(playerid);
}

stock Spawn(playerid){
	SetPlayerPos(playerid, Player[playerid][dX], Player[playerid][dY], Player[playerid][dZ]);
	SetPlayerFacingAngle(playerid, Player[playerid][dZ]); 
	SetPlayerInterior(playerid, Player[playerid][dI]);
}

stock Salvar(playerid){
	new name[MAX_PLAYER_NAME+1];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);

	new sql_update[300];
	format(sql_update, sizeof(sql_update), "UPDATE `%s` SET `money`='%d', `level`='%d',\
	`dI`='%d', `dX`=%f, `dY`=%f, `dZ`=%f, `dA`=%f WHERE `username`='%s'", SQL_TABLE_PLAYER, Player[playerid][money], 
	Player[playerid][level], Player[playerid][dI], Player[playerid][dX], Player[playerid][dY],
	Player[playerid][dZ], Player[playerid][dA], name);
	mysql_query(conexao, sql_update, false);

	new tt[200];
	format(tt, sizeof(tt), "%f %f %f %s", Player[playerid][dX], Player[playerid][dY], Player[playerid][dZ], name);
	print(tt);
}

