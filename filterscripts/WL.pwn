//Prefixo
#define DCMD_PREFIX '>' //Prefixo bot (OBS: 1 caractere somente)
#define PREFIX_MSG  ">"  //Prefix q aparece na msg

//------------------------------------------------------------------------------------

//--------------- Bibliotecas ---------------

#include <a_samp>
#include <sscanf2>
#include <discord-connector>
#include <discord-cmd>
#include <Bini>


//------------- Recomendo n mecher... -------------

#define INVISIVEL       INVISIBLE
#define NAO_PERTUBE     DO_NOT_DISTURB
#define AUSENTE         IDLE

#define BOT::%0(%1) \
      forward %0(%1); \
	  public %0(%1)

#define Pasta_WhiteList         "WhiteList/Nicks Aprovados/%s.ini"
#define Pasta_WhiteListID       "WhiteList/ID Usuarios/%s.ini"
#define Local_Config            "WhiteList/configs.ini"

new DCC_Channel:comandos;
new DCC_Channel:aprovarwl;

new atividade;

new DCC_Guild:servidor;
new DCC_Role:cargo;
new DCC_Role:rcargo;


// ------------------------------- Mude como quiser -------------------------------

//Cor do seu Embed
//Veja mais cores em: https://gist.github.com/thomasbnt/b6f455e2c7d743b796917fa3c205f812
#define COR_EMBED   7419530   

//Altere para o link para onde quem clicar sera direcionado.
#define URL_EMBED   "https://discord.gg/FWprtSqPcK"

//Altere o Status do Bot
//Status disponiveis: ONLINE, AUSENTE, NAO_PERTUBE e INVISIVEL
#define STATUS_BOT ONLINE 

//----------------------------------------------------------

BOT::ChecarConfig() {
    DCC_SetBotPresenceStatus(DCC_BotPresenceStatus:STATUS_BOT);

    if(!fexist(Local_Config)) {
        INI_Create(Local_Config);
        INI_WriteString(Local_Config, "Link_Discord", "");
        INI_WriteString(Local_Config, "ID_Server", "");
        INI_WriteString(Local_Config, "ID_Cargo", "");
        INI_WriteString(Local_Config, "ID_RCargo", "");
        INI_WriteString(Local_Config, "Canal_Whitelist", "");
        INI_WriteString(Local_Config, "Canal_RWhitelist", "");
        INI_WriteString(Local_Config, "Nome_Server", "");
        INI_WriteInt(Local_Config, "Atividade_Ativada", 1);
        INI_WriteString(Local_Config, "Atividade", "");
        
        INI_Save();
		print("O ARQ 'configs.ini' nao foi encontrado. O ARQ foi criado com sucesso.");
        print("Preencha o ARQ configs.ini e reinicie o servidor para o bot funcionar.");
    } else {
        atividade = INI_ReadInt(Local_Config, "Atividade_Ativada");
        
        if(atividade == 1) {
            new BotActivity[64];
            format(BotActivity, sizeof BotActivity, "%s", INI_ReadString(Local_Config, "Atividade"));
            DCC_SetBotActivity(BotActivity); } else print("atividade desativada!"); 
    }
    return 1;
}

BOT::CarregarDCC()
{
    new String[DCC_ID_SIZE], String2[DCC_ID_SIZE], String3[DCC_ID_SIZE], String4[DCC_ID_SIZE], String5[DCC_ID_SIZE];
    format(String, sizeof String, "%s", INI_ReadString(Local_Config, "Canal_Whitelist"));
    format(String2, sizeof String2, "%s", INI_ReadString(Local_Config, "Canal_RWhiteList"));
    format(String3, sizeof String3, "%s", INI_ReadString(Local_Config, "ID_Server"));
    format(String4, sizeof String4, "%s", INI_ReadString(Local_Config, "ID_Cargo"));
    format(String5, sizeof String5, "%s", INI_ReadString(Local_Config, "ID_RCargo"));
	aprovarwl = DCC_FindChannelById(String); 
	comandos = DCC_FindChannelById(String2); 
    servidor = DCC_FindGuildById(String3);
    cargo = DCC_FindRoleById(String4);
    rcargo = DCC_FindRoleById(String5);
	return 1;
}

BOT::KickDelay(playerid) {
	Kick(playerid);
	return 1;
}

////////////////////////////////////////////////////////////

#define FILTERSCRIPT
#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
    ChecarConfig();
    CarregarDCC();
	return 1;
}

public OnFilterScriptExit()
{
    INI_Exit();
	return 1;
}

#else

main(){}

#endif

GetName(playerid)
{
	new nome[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nome, sizeof nome);
	return nome;
}

public OnPlayerConnect(playerid)
{
	new ARQ[64];
	format(ARQ, sizeof ARQ, Pasta_WhiteList, GetName(playerid));
	if(!fexist(ARQ)) {
        new Dialog[250];
        format(Dialog, sizeof Dialog, "Bem vindo ao %s!\n\
		Seu nick nao foi encontrado em nossa WhitList. Entre em nosso Discord e faca sua WhiteList para poder logar.\n\
		{3c11d6}Link Discord: %s", INI_ReadString(Local_Config, "Nome_Server"), INI_ReadString(Local_Config, "Link_Discord"));
        ShowPlayerDialog(playerid, 9323, DIALOG_STYLE_MSGBOX, "WhiteList", Dialog, "Ok", #);
		SetTimerEx("KickDelay", 250, false, "i", playerid);
		return 1;
	}		
	return 1;
}

DCMD:wl(user, channel, params[])
{
	if(channel != aprovarwl)
		return 1;

	new Nick[MAX_PLAYER_NAME];
	if(sscanf(params, "s[24]", Nick))
		return DCC_SendChannelEmbedMessage(aprovarwl, DCC_CreateEmbed("WhiteList", "Use "#PREFIX_MSG"wl <Nick>", URL_EMBED, .color = COR_EMBED));

	if(strlen(Nick) < 3 || strlen(Nick) > 24)
			return DCC_SendChannelEmbedMessage(aprovarwl, DCC_CreateEmbed("WhiteList", "Nick invalido! O Nick deve conter de 3 a 24 caracteres.", URL_EMBED, .color = COR_EMBED));

	new ARQ[64], ARQ2[64], ID[DCC_ID_SIZE];
    DCC_GetUserId(user, ID);
    format(ARQ2, sizeof ARQ2, Pasta_WhiteListID, ID);
	format(ARQ, sizeof ARQ, Pasta_WhiteList, Nick);

    if(fexist(ARQ2))
    {
        new anti[MAX_PLAYER_NAME];
        format(anti, sizeof anti, "%s", INI_ReadString(ARQ2, "Nick"));
        DCC_SetGuildMemberNickname(servidor, user, anti);
        DCC_AddGuildMemberRole(servidor, user, cargo);
		DCC_SendChannelEmbedMessage(aprovarwl, DCC_Embed:DCC_CreateEmbed("WhiteList", "Sua Conta de discord ja contem um nick registrado.", URL_EMBED, .color = COR_EMBED)); 
        return 1;
    }
	if(fexist(ARQ))
		return DCC_SendChannelEmbedMessage(aprovarwl, DCC_CreateEmbed("WhiteList", "Este nick já está autorizado.", URL_EMBED, .color = COR_EMBED));
	else {
        new Nome[MAX_PLAYER_NAME];

        INI_Create(ARQ2);
        format(Nome, sizeof Nome, "%s", Nick);
        INI_WriteString(ARQ2, "Nick", Nome);
        INI_Save();

		INI_Create(ARQ);
        new Text[DCC_ID_SIZE];
        format(Text, sizeof Text, "%s", ID);
        INI_WriteString(ARQ, "ID", Text);
        INI_Save();

        
        DCC_SetGuildMemberNickname(servidor, user, Nome);
        DCC_RemoveGuildMemberRole(servidor, user, rcargo);
        DCC_AddGuildMemberRole(servidor, user, cargo);
		DCC_SendChannelEmbedMessage(aprovarwl, DCC_Embed:DCC_CreateEmbed("WhiteList", "WhiteList Aprovada com sucesso", URL_EMBED, .color = COR_EMBED));
	}
	return 1;
}


DCMD:rwl(user, channel, params[])
{
	if(channel != comandos)
		return 1;

	new Nick[MAX_PLAYER_NAME];
	if(sscanf(params, "s[24]", Nick))
		return DCC_SendChannelEmbedMessage(channel, DCC_CreateEmbed("WhiteList", "Use "#PREFIX_MSG"rwl <Nick>", URL_EMBED, .color = COR_EMBED));

	if(strlen(Nick) < 3 || strlen(Nick) > 24)
		return DCC_SendChannelEmbedMessage(channel, DCC_CreateEmbed("WhiteList", "Nick invalido! O Nick deve conter de 3 a 24 caracteres.", URL_EMBED, .color = COR_EMBED));

	new ARQ[64];
	format(ARQ, sizeof ARQ, Pasta_WhiteList, Nick);
	if(fexist(ARQ)) {
        new ARQ2[64], userid[DCC_ID_SIZE];
        format(userid, sizeof userid, "%s", INI_ReadString(ARQ, "ID"));
        DCC_SetGuildMemberNickname(servidor, DCC_User:DCC_FindUserById(userid), "");
        DCC_AddGuildMemberRole(servidor, DCC_User:DCC_FindUserById(userid), rcargo);
        DCC_RemoveGuildMemberRole(servidor, DCC_User:DCC_FindUserById(userid), cargo);
        format(ARQ2, sizeof ARQ2, Pasta_WhiteListID, INI_ReadString(ARQ, "ID"));
        INI_Delete(ARQ2);
        INI_Delete(ARQ);
		DCC_SendChannelEmbedMessage(channel, DCC_CreateEmbed("WhiteList", "O Nick foi retirado da WhiteList com sucesso.", URL_EMBED, .color = COR_EMBED)); }
	else {
		DCC_SendChannelEmbedMessage(channel, DCC_CreateEmbed("WhiteList", "O nick não consta na WhiteList.", URL_EMBED, .color = COR_EMBED));
	}
	return 1;
}
