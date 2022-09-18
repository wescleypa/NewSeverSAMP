new PlayerText:RegisterPTD[MAX_PLAYERS][7];
stock LoadPTextdraw(playerid);
public LoadPTextdraw(playerid){

    RegisterPTD[playerid][0] = CreatePlayerTextDraw(playerid, 313.000000, 169.000000, "_");
    PlayerTextDrawFont(playerid, RegisterPTD[playerid][0], 1);
    PlayerTextDrawLetterSize(playerid, RegisterPTD[playerid][0], 0.600000, 11.050005);
    PlayerTextDrawTextSize(playerid, RegisterPTD[playerid][0], 298.500000, 167.500000);
    PlayerTextDrawSetOutline(playerid, RegisterPTD[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, RegisterPTD[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, RegisterPTD[playerid][0], 2);
    PlayerTextDrawColor(playerid, RegisterPTD[playerid][0], -1);
    PlayerTextDrawBackgroundColor(playerid, RegisterPTD[playerid][0], 255);
    PlayerTextDrawBoxColor(playerid, RegisterPTD[playerid][0], 35689);
    PlayerTextDrawUseBox(playerid, RegisterPTD[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, RegisterPTD[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, RegisterPTD[playerid][0], 0);

    RegisterPTD[playerid][1] = CreatePlayerTextDraw(playerid, 400.000000, 56.000000, "Small SaydeN");
    PlayerTextDrawFont(playerid, RegisterPTD[playerid][1], 3);
    PlayerTextDrawLetterSize(playerid, RegisterPTD[playerid][1], 0.824999, 3.149998);
    PlayerTextDrawTextSize(playerid, RegisterPTD[playerid][1], 395.500000, 17.000000);
    PlayerTextDrawSetOutline(playerid, RegisterPTD[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, RegisterPTD[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, RegisterPTD[playerid][1], 3);
    PlayerTextDrawColor(playerid, RegisterPTD[playerid][1], -1);
    PlayerTextDrawBackgroundColor(playerid, RegisterPTD[playerid][1], 255);
    PlayerTextDrawBoxColor(playerid, RegisterPTD[playerid][1], 50);
    PlayerTextDrawUseBox(playerid, RegisterPTD[playerid][1], 0);
    PlayerTextDrawSetProportional(playerid, RegisterPTD[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, RegisterPTD[playerid][1], 0);

    RegisterPTD[playerid][2] = CreatePlayerTextDraw(playerid, 280.000000, 181.000000, "Ola Small SaydeN");
    PlayerTextDrawFont(playerid, RegisterPTD[playerid][2], 1);
    PlayerTextDrawLetterSize(playerid, RegisterPTD[playerid][2], 0.200000, 1.000000);
    PlayerTextDrawTextSize(playerid, RegisterPTD[playerid][2], 394.500000, 17.000000);
    PlayerTextDrawSetOutline(playerid, RegisterPTD[playerid][2], 0);
    PlayerTextDrawSetShadow(playerid, RegisterPTD[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, RegisterPTD[playerid][2], 1);
    PlayerTextDrawColor(playerid, RegisterPTD[playerid][2], -1);
    PlayerTextDrawBackgroundColor(playerid, RegisterPTD[playerid][2], 255);
    PlayerTextDrawBoxColor(playerid, RegisterPTD[playerid][2], 50);
    PlayerTextDrawUseBox(playerid, RegisterPTD[playerid][2], 0);
    PlayerTextDrawSetProportional(playerid, RegisterPTD[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, RegisterPTD[playerid][2], 0);

    RegisterPTD[playerid][3] = CreatePlayerTextDraw(playerid, 313.000000, 220.000000, "Digite uma senha.");
    PlayerTextDrawFont(playerid, RegisterPTD[playerid][3], 2);
    PlayerTextDrawLetterSize(playerid, RegisterPTD[playerid][3], 0.254167, 1.100000);
    PlayerTextDrawTextSize(playerid, RegisterPTD[playerid][3], 10.000000, 147.500000);
    PlayerTextDrawSetOutline(playerid, RegisterPTD[playerid][3], 0);
    PlayerTextDrawSetShadow(playerid, RegisterPTD[playerid][3], 0);
    PlayerTextDrawAlignment(playerid, RegisterPTD[playerid][3], 2);
    PlayerTextDrawColor(playerid, RegisterPTD[playerid][3], -73);
    PlayerTextDrawBackgroundColor(playerid, RegisterPTD[playerid][3], 255);
    PlayerTextDrawBoxColor(playerid, RegisterPTD[playerid][3], 35634);
    PlayerTextDrawUseBox(playerid, RegisterPTD[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, RegisterPTD[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid, RegisterPTD[playerid][3], 1);

    RegisterPTD[playerid][4] = CreatePlayerTextDraw(playerid, 275.000000, 245.000000, "CONFIRMAR");
    PlayerTextDrawFont(playerid, RegisterPTD[playerid][4], 1);
    PlayerTextDrawLetterSize(playerid, RegisterPTD[playerid][4], 0.225000, 1.049980);
    PlayerTextDrawTextSize(playerid, RegisterPTD[playerid][4], 10.000000, 45.000000);
    PlayerTextDrawSetOutline(playerid, RegisterPTD[playerid][4], 0);
    PlayerTextDrawSetShadow(playerid, RegisterPTD[playerid][4], 0);
    PlayerTextDrawAlignment(playerid, RegisterPTD[playerid][4], 2);
    PlayerTextDrawColor(playerid, RegisterPTD[playerid][4], -1);
    PlayerTextDrawBackgroundColor(playerid, RegisterPTD[playerid][4], 255);
    PlayerTextDrawBoxColor(playerid, RegisterPTD[playerid][4], 9109639);
    PlayerTextDrawUseBox(playerid, RegisterPTD[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, RegisterPTD[playerid][4], 1);
    PlayerTextDrawSetSelectable(playerid, RegisterPTD[playerid][4], 1);

    RegisterPTD[playerid][5] = CreatePlayerTextDraw(playerid, 347.000000, 245.000000, "CANCELAR");
    PlayerTextDrawFont(playerid, RegisterPTD[playerid][5], 1);
    PlayerTextDrawLetterSize(playerid, RegisterPTD[playerid][5], 0.241666, 1.049980);
    PlayerTextDrawTextSize(playerid, RegisterPTD[playerid][5], 10.000000, 45.000000);
    PlayerTextDrawSetOutline(playerid, RegisterPTD[playerid][5], 0);
    PlayerTextDrawSetShadow(playerid, RegisterPTD[playerid][5], 0);
    PlayerTextDrawAlignment(playerid, RegisterPTD[playerid][5], 2);
    PlayerTextDrawColor(playerid, RegisterPTD[playerid][5], -1);
    PlayerTextDrawBackgroundColor(playerid, RegisterPTD[playerid][5], 255);
    PlayerTextDrawBoxColor(playerid, RegisterPTD[playerid][5], -1962934137);
    PlayerTextDrawUseBox(playerid, RegisterPTD[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, RegisterPTD[playerid][5], 1);
    PlayerTextDrawSetSelectable(playerid, RegisterPTD[playerid][5], 1);

    RegisterPTD[playerid][6] = CreatePlayerTextDraw(playerid, 233.000000, 194.000000, "\
    Notamos que voce nao tem visto em nosso pais, portanto, digite uma senha para se registrar.");
    PlayerTextDrawFont(playerid, RegisterPTD[playerid][6], 1);
    PlayerTextDrawLetterSize(playerid, RegisterPTD[playerid][6], 0.200000, 1.000000);
    PlayerTextDrawTextSize(playerid, RegisterPTD[playerid][6], 394.500000, 17.000000);
    PlayerTextDrawSetOutline(playerid, RegisterPTD[playerid][6], 0);
    PlayerTextDrawSetShadow(playerid, RegisterPTD[playerid][6], 0);
    PlayerTextDrawAlignment(playerid, RegisterPTD[playerid][6], 1);
    PlayerTextDrawColor(playerid, RegisterPTD[playerid][6], -1);
    PlayerTextDrawBackgroundColor(playerid, RegisterPTD[playerid][6], 255);
    PlayerTextDrawBoxColor(playerid, RegisterPTD[playerid][6], 50);
    PlayerTextDrawUseBox(playerid, RegisterPTD[playerid][6], 0);
    PlayerTextDrawSetProportional(playerid, RegisterPTD[playerid][6], 1);
    PlayerTextDrawSetSelectable(playerid, RegisterPTD[playerid][6], 0);
}