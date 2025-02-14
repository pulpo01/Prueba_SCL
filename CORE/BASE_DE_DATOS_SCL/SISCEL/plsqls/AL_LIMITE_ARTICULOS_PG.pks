CREATE OR REPLACE PACKAGE AL_LIMITE_ARTICULOS_PG IS
/*
<NOMBRE>           : AL_LIMITE_ARTICULOS_PG  .</NOMBRE>
<FECHACREA>        : 31-10-2011<FECHACREA/>
<MODULO >          : Logistica </MODULO >
<AUTOR >       :  Kay Vera</AUTOR >
<VERSION >     : 1.0</VERSION >
<DESCRIPCION>  : Package Proyeccion de Traspaso</DESCRIPCION>
*/

    TYPE refcursor IS REF CURSOR;
    CV_error_no_clasif  CONSTANT VARCHAR2(50):= 'No es posible clasificar el error';
    cn_largoerrtec       CONSTANT NUMBER        := 4000;
    cn_largodesc         CONSTANT NUMBER        := 2000;
    cv_cod_modulo        CONSTANT VARCHAR2 (2)  := 'AL';


                                                  
        PROCEDURE AL_VALIDA_CANTIDAD_LIMITE_PR  (   V_COD_BODEGA        IN  AL_LIMITE_ARTICULO_TD.COD_BODEGA%TYPE, 
                                                    V_COD_ARTICULO      IN  AL_LIMITE_ARTICULO_TD.COD_ARTICULO%TYPE,
                                                    V_COD_USO           IN  AL_LIMITE_ARTICULO_TD.COD_USO%TYPE,
                                                    V_CANT_PROY         OUT NOCOPY AL_LIMITE_ARTICULO_TD.CANTIDAD%TYPE,
                                                    V_CANT_CONS         OUT NOCOPY NUMBER,
                                                    V_CANT_SALDO        OUT NOCOPY AL_LIMITE_ARTICULO_TD.CANTIDAD%TYPE,
                                                    V_NOM_BODEGA        OUT NOCOPY AL_BODEGAS.DES_BODEGA%TYPE,
                                                    V_NOM_ARTICULO      OUT NOCOPY AL_ARTICULOS.DES_ARTICULO%TYPE,
                                                    SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                                    SV_MENS_RETORNO     OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                                    SN_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.EVENTO);   
                                                   
                                                   
        PROCEDURE AL_VALIDA_STOCK_PROYECCION_PR(    V_COD_BODEGA_ORI        IN  AL_LIMITE_ARTICULO_TD.COD_BODEGA%TYPE,
                                                    V_COD_BODEGA_DET        IN  AL_LIMITE_ARTICULO_TD.COD_BODEGA%TYPE,
                                                    V_COD_ARTICULO          IN  AL_LIMITE_ARTICULO_TD.COD_ARTICULO%TYPE,
                                                    V_COD_USO               IN  AL_LIMITE_ARTICULO_TD.COD_USO%TYPE,
                                                    V_TOTAL_STOCK           OUT NOCOPY AL_STOCK.CAN_STOCK%TYPE,
                                                    V_NOM_ARTICULO          OUT NOCOPY AL_ARTICULOS.DES_ARTICULO%TYPE,
                                                    V_CANT_TRANSITO         OUT NOCOPY NUMBER,
                                                    SN_COD_RETORNO          OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                                    SV_MENS_RETORNO         OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                                    SN_NUM_EVENTO           OUT NOCOPY GE_ERRORES_PG.EVENTO); 
                                    


                                                                                          
END;
/
SHOW ERRORS