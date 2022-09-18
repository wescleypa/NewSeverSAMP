new Text:RegisterTD[9];
stock loadGtextdraw();
public loadGtextdraw(){

    //------------------ REGISTER -------------------------//
    RegisterTD[0] = TextDrawCreate(320.000000, 0.000000, "_");
    TextDrawFont(RegisterTD[0], 1);
    TextDrawLetterSize(RegisterTD[0], 0.154166, 10.450003);
    TextDrawTextSize(RegisterTD[0], 118.500000, 645.500000);
    TextDrawSetOutline(RegisterTD[0], 1);
    TextDrawSetShadow(RegisterTD[0], 0);
    TextDrawAlignment(RegisterTD[0], 2);
    TextDrawColor(RegisterTD[0], -1);
    TextDrawBackgroundColor(RegisterTD[0], 255);
    TextDrawBoxColor(RegisterTD[0], 135);
    TextDrawUseBox(RegisterTD[0], 1);
    TextDrawSetProportional(RegisterTD[0], 1);
    TextDrawSetSelectable(RegisterTD[0], 0);

    RegisterTD[1] = TextDrawCreate(240.000000, 20.000000, "Boa tarde");
    TextDrawFont(RegisterTD[1], 3);
    TextDrawLetterSize(RegisterTD[1], 0.695833, 2.799999);
    TextDrawTextSize(RegisterTD[1], 433.500000, -7.500000);
    TextDrawSetOutline(RegisterTD[1], 1);
    TextDrawSetShadow(RegisterTD[1], 0);
    TextDrawAlignment(RegisterTD[1], 1);
    TextDrawColor(RegisterTD[1], -1);
    TextDrawBackgroundColor(RegisterTD[1], 255);
    TextDrawBoxColor(RegisterTD[1], 50);
    TextDrawUseBox(RegisterTD[1], 0);
    TextDrawSetProportional(RegisterTD[1], 1);
    TextDrawSetSelectable(RegisterTD[1], 0);

    RegisterTD[2] = TextDrawCreate(320.000000, 353.000000, "_");
    TextDrawFont(RegisterTD[2], 1);
    TextDrawLetterSize(RegisterTD[2], 0.162499, 10.400003);
    TextDrawTextSize(RegisterTD[2], 118.500000, 644.500000);
    TextDrawSetOutline(RegisterTD[2], 1);
    TextDrawSetShadow(RegisterTD[2], 0);
    TextDrawAlignment(RegisterTD[2], 2);
    TextDrawColor(RegisterTD[2], -1);
    TextDrawBackgroundColor(RegisterTD[2], 255);
    TextDrawBoxColor(RegisterTD[2], 135);
    TextDrawUseBox(RegisterTD[2], 1);
    TextDrawSetProportional(RegisterTD[2], 0);
    TextDrawSetSelectable(RegisterTD[2], 0);

    RegisterTD[3] = TextDrawCreate(178.000000, 357.000000, "Seja muito bem vindo(a) ao");
    TextDrawFont(RegisterTD[3], 2);
    TextDrawLetterSize(RegisterTD[3], 0.429166, 1.900000);
    TextDrawTextSize(RegisterTD[3], 534.500000, 17.000000);
    TextDrawSetOutline(RegisterTD[3], 1);
    TextDrawSetShadow(RegisterTD[3], 0);
    TextDrawAlignment(RegisterTD[3], 1);
    TextDrawColor(RegisterTD[3], -1);
    TextDrawBackgroundColor(RegisterTD[3], 255);
    TextDrawBoxColor(RegisterTD[3], 50);
    TextDrawUseBox(RegisterTD[3], 0);
    TextDrawSetProportional(RegisterTD[3], 1);
    TextDrawSetSelectable(RegisterTD[3], 0);

    RegisterTD[4] = TextDrawCreate(222.000000, 375.000000, "Brasil SAMP");
    TextDrawFont(RegisterTD[4], 1);
    TextDrawLetterSize(RegisterTD[4], 0.791666, 3.749998);
    TextDrawTextSize(RegisterTD[4], 499.000000, 17.000000);
    TextDrawSetOutline(RegisterTD[4], 1);
    TextDrawSetShadow(RegisterTD[4], 0);
    TextDrawAlignment(RegisterTD[4], 1);
    TextDrawColor(RegisterTD[4], -1);
    TextDrawBackgroundColor(RegisterTD[4], 255);
    TextDrawBoxColor(RegisterTD[4], 50);
    TextDrawUseBox(RegisterTD[4], 0);
    TextDrawSetProportional(RegisterTD[4], 1);
    TextDrawSetSelectable(RegisterTD[4], 0);

    RegisterTD[5] = TextDrawCreate(201.000000, 437.000000, "Todos os direitos reservados a Wescley Andrade & Micael Lopes");
    TextDrawFont(RegisterTD[5], 2);
    TextDrawLetterSize(RegisterTD[5], 0.166666, 0.950000);
    TextDrawTextSize(RegisterTD[5], 459.500000, 27.500000);
    TextDrawSetOutline(RegisterTD[5], 1);
    TextDrawSetShadow(RegisterTD[5], 0);
    TextDrawAlignment(RegisterTD[5], 1);
    TextDrawColor(RegisterTD[5], -1);
    TextDrawBackgroundColor(RegisterTD[5], 255);
    TextDrawBoxColor(RegisterTD[5], 50);
    TextDrawUseBox(RegisterTD[5], 0);
    TextDrawSetProportional(RegisterTD[5], 1);
    TextDrawSetSelectable(RegisterTD[5], 0);

    RegisterTD[6] = TextDrawCreate(577.000000, 20.000000, "00:00");
    TextDrawFont(RegisterTD[6], 3);
    TextDrawLetterSize(RegisterTD[6], 0.554166, 2.449999);
    TextDrawTextSize(RegisterTD[6], 400.000000, 17.000000);
    TextDrawSetOutline(RegisterTD[6], 2);
    TextDrawSetShadow(RegisterTD[6], 0);
    TextDrawAlignment(RegisterTD[6], 2);
    TextDrawColor(RegisterTD[6], -1);
    TextDrawBackgroundColor(RegisterTD[6], 255);
    TextDrawBoxColor(RegisterTD[6], 50);
    TextDrawUseBox(RegisterTD[6], 0);
    TextDrawSetProportional(RegisterTD[6], 1);
    TextDrawSetSelectable(RegisterTD[6], 0);

    RegisterTD[7] = TextDrawCreate(577.000000, 8.000000, "00.00.0000");
    TextDrawFont(RegisterTD[7], 3);
    TextDrawLetterSize(RegisterTD[7], 0.266665, 1.299998);
    TextDrawTextSize(RegisterTD[7], 400.000000, 17.000000);
    TextDrawSetOutline(RegisterTD[7], 2);
    TextDrawSetShadow(RegisterTD[7], 0);
    TextDrawAlignment(RegisterTD[7], 2);
    TextDrawColor(RegisterTD[7], -1);
    TextDrawBackgroundColor(RegisterTD[7], 255);
    TextDrawBoxColor(RegisterTD[7], 50);
    TextDrawUseBox(RegisterTD[7], 0);
    TextDrawSetProportional(RegisterTD[7], 1);
    TextDrawSetSelectable(RegisterTD[7], 0);

    RegisterTD[8] = TextDrawCreate(313.000000, 172.000000, "_");
    TextDrawFont(RegisterTD[8], 1);
    TextDrawLetterSize(RegisterTD[8], 0.799999, 10.500003);
    TextDrawTextSize(RegisterTD[8], 300.500000, 163.000000);
    TextDrawSetOutline(RegisterTD[8], 1);
    TextDrawSetShadow(RegisterTD[8], 0);
    TextDrawAlignment(RegisterTD[8], 2);
    TextDrawColor(RegisterTD[8], -1);
    TextDrawBackgroundColor(RegisterTD[8], 255);
    TextDrawBoxColor(RegisterTD[8], 197);
    TextDrawUseBox(RegisterTD[8], 1);
    TextDrawSetProportional(RegisterTD[8], 1);
    TextDrawSetSelectable(RegisterTD[8], 0);
    //----------------- FIM REGISTER -----------------------//
}