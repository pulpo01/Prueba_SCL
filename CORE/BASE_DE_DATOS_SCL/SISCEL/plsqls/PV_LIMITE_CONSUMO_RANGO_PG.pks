CREATE OR REPLACE PACKAGE PV_LIMITE_CONSUMO_RANGO_PG  IS
    /*****************************************/
    /* POST-VENTA                                            */
    /*****************************************/

   PROCEDURE PV_LIMITE_CONSUMO_RANGO_PR (  VP_PRODUCTO IN NUMBER ,
                                          VP_CLIENTE IN NUMBER ,
                                          VP_ABONADO IN NUMBER ,
                                          VP_CODLIMCO IN VARCHAR2 ,
                                          VP_FECSYS IN DATE ,
                                          VP_IMP_CODLIMCO IN NUMBER ,
                                          VP_PROC IN OUT VARCHAR2 ,
                                          VP_TABLA IN OUT VARCHAR2 ,
                                          VP_ACT IN OUT VARCHAR2 ,
                                          VP_SQLCODE IN OUT VARCHAR2 ,
                                          VP_SQLERRM IN OUT VARCHAR2 ,
                                          VP_ERROR IN OUT VARCHAR2);


END PV_LIMITE_CONSUMO_RANGO_PG; 
/
SHOW ERROR