#include <global> //Includes gerais
//--------  CONFIG	-------//
#include "../gamemodes/config.pwn"
#include "../modules/global/dialogs.pwn"
//--------	Modules -------//
#include "../modules/global/mysql.pwn"
#include "../modules/player/includes.pwn" //players
//
#pragma tabsize 0

main() return print("\n[!] Gamemode iniciada em 10/09/2022 por Wescley Andrade +55 (19) 99187-5201\n\
	e Micael SaydeN\n");

public OnGameModeInit()
{
	if(MYSQL == true) Conecta();
	
    return 1;
}