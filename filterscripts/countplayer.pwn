#include <a_samp>
#include <discord-connector>

new CountingPlayer;

forward BotStatus(playerid);
public BotStatus(playerid)
{
	new string[256];
	format(string, sizeof(string), "New Server SAMP com %d pessoas", CountingPlayer);
	DCC_SetBotActivity(string);
}

public OnGameModeInit()
{
       SetTimer("BotStatus", 1000, true);
}

public OnPlayerConnect(playerid)
{
	CountingPlayer++;
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	CountingPlayer--;
    return 1;
}
