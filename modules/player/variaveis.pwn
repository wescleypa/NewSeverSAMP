enum PlayerInfo{
    password,       //senha
    money,          //saldo conta
    level,          //score
    Float: dX,      //Desconectou X
    Float: dY,      //Desconectou Y
    Float: dZ,      //Desconectou Z
    Float: dA,      //Desconectou A
    dI,             //Desconectou Interior
    admin,          //Admin
    genre           //Genero
}
new Player[MAX_PLAYERS][PlayerInfo];
new CarAdmin[MAX_PLAYERS]; //Veículo criado via cmd
new CriouCarAdmin[MAX_PLAYERS]; //Verifica se o admin já criou um veículo

new Float:pX[MAX_PLAYERS], Float:pY[MAX_PLAYERS], Float:pZ[MAX_PLAYERS], Float:pA[MAX_PLAYERS], pI[MAX_PLAYERS],\
trouxe[MAX_PLAYERS] = 0; //cmd admins