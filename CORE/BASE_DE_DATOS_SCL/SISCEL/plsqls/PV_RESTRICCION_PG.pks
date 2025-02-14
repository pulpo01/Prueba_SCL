CREATE OR REPLACE PACKAGE Pv_restriccion_pg AS
/*
<Documentaci¥n TipoDoc = "Package">
   <Elemento Nombre = "PV_RESTRICCION_PG"
          Lenguaje="PL/SQL"
          Fecha="20-08-2008"
          Versi¥n="1.0"
          Dise¿ador=""
          Programador="Orlando Cabezas"
          Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripci¥n>Package que contiene las validaciones que se aplican por el modelo de restricciones.</Descripci¥n>
      <Par¿metros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Par¿metros>
</Elemento>
</Documentaci¥n>
*/



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_VALPLANSERTEC_WEB_PR(EV_PARAM_ENTRADA  IN  VARCHAR2,
                                  SV_RESULTADO      OUT NOCOPY VARCHAR2,
                                  SV_MENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VALTECNO_PRODUCTO_PR(EV_PARAM_ENTRADA  IN  VARCHAR2,
                                  SV_RESULTADO      OUT NOCOPY VARCHAR2,
                                  SV_MENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_ABO_CLIENTE_PR(EV_PARAM_ENTRADA  IN  VARCHAR2,
                                SV_RESULTADO      OUT NOCOPY VARCHAR2,
                                SV_MENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_ABO_CLI_CON_OSPENDIENTES(EV_PARAM_ENTRADA  IN  VARCHAR2,
                                      SV_RESULTADO      OUT NOCOPY VARCHAR2,
                                      SV_MENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VALTECNO_CLIABO_PR(EV_PARAM_ENTRADA  IN  VARCHAR2,
                                  SV_RESULTADO      OUT NOCOPY VARCHAR2,
                                  SV_MENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_ANTIGUEDAD_RENOVACION_PR (EV_PARAM_ENTRADA  IN  VARCHAR2,
                                  SV_RESULTADO      OUT NOCOPY VARCHAR2,
                                  SV_MENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_CENTRAL_PR  (EV_PARAM_ENTRADA  IN  VARCHAR2,
                                  SV_RESULTADO      OUT NOCOPY VARCHAR2,
                                  SV_MENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_GRUPOPRES_ABO_PR  (EV_PARAM_ENTRADA  IN  VARCHAR2,
                                  SV_RESULTADO      OUT NOCOPY VARCHAR2,
                                  SV_MENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_GRUPOPRES_ORIDES_PR  (EV_PARAM_ENTRADA  IN  VARCHAR2,
                                  SV_RESULTADO      OUT NOCOPY VARCHAR2,
                                  SV_MENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_NUMERO_PILOTO_PR  (EV_PARAM_ENTRADA  IN  VARCHAR2,
                                  SV_RESULTADO      OUT NOCOPY VARCHAR2,
                                  SV_MENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_CICLOS_CONTRA_ASOCIA_PR  (EV_PARAM_ENTRADA  IN  VARCHAR2,
                                  SV_RESULTADO      OUT NOCOPY VARCHAR2,
                                  SV_MENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_CLIE_CONTRA_NO_ASOC_PR  (EV_PARAM_ENTRADA  IN  VARCHAR2,
                                  SV_RESULTADO      OUT NOCOPY VARCHAR2,
                                  SV_MENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_SSASIS911_CONTRA_PR  (EV_PARAM_ENTRADA  IN  VARCHAR2,
                                  SV_RESULTADO      OUT NOCOPY VARCHAR2,
                                  SV_MENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_VAL_PERM_MIGR_PREP_PR(
                                   EV_param_entrada IN  VARCHAR2,
                                   SV_RESULTADO     OUT NOCOPY VARCHAR2,
                                   SV_MENSAJE       OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE
);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_VAL_PERM_MIGR_PRE_POS_PR(
                                   EV_param_entrada IN  VARCHAR2,
                                   SV_RESULTADO     OUT NOCOPY VARCHAR2,
                                   SV_MENSAJE       OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE
);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_VAL_PERM_CAMBPLAN_MAYMEN_PR(
                                        EV_PARAM_ENTRADA IN  VARCHAR2,
                                        SV_RESULTADO     OUT NOCOPY VARCHAR2,
                                        SV_MENSAJE       OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE
);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_PERM_MIGR_PLANTARIF_PR(
                                   EV_param_entrada IN  VARCHAR2,
                                   SV_RESULTADO     OUT NOCOPY VARCHAR2,
                                   SV_MENSAJE       OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE
);
------------------------------------------------------------------------------------------------------------------------------------
END Pv_restriccion_pg; 
/
SHOW ERRORS
