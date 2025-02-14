CREATE OR REPLACE PACKAGE FA_DCTO_CLTE_SP_PG
/*
<Documentaci�n TipoDoc = "Package">
   <Elemento Nombre = "FA_DCTO_CLTE_SP_PG"
          Lenguaje="PL/SQL"
          Fecha="19-02-2007"
          Versi�n="1.0"
          Dise�ador=""
          Programador="Javier Garcia"
          Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripci�n>Package encargado de actualizar la tabla FA_DCTOS_SERV_REC_TD</Descripci�n>
      <Par�metros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Par�metros>
</Elemento>
</Documentaci�n>
*/
IS
   cv_error_no_clasif      VARCHAR2 (50) := 'No es posible clasificar el error';
   cv_cod_modulo           VARCHAR2 (2)  := 'FA';
   cv_version              VARCHAR2 (2)  := '1';


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




   PROCEDURE FA_DCTOS_SERV_REC_TD_I_PR (REGISTRO            IN FA_DCTOS_SERV_REC_TD%ROWTYPE,
                                                                                SN_Cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_Mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_Num_evento       OUT NOCOPY ge_errores_pg.evento
                                                                    );

   PROCEDURE FA_DCTOS_SERV_REC_TD_U_PR (ED_Fec_desdedcto        IN DATE,
                                                                        ED_Fec_hastadcto        IN DATE,
                                                                                REGISTRO                        IN FA_DCTOS_SERV_REC_TD%ROWTYPE,
                                                                                SN_Cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                                SV_Mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                                SN_Num_evento       OUT NOCOPY ge_errores_pg.evento);

   PROCEDURE FA_DCTOS_SERV_REC_TD_S_PR (EN_Cod_cliente      IN FA_DCTOS_SERV_REC_TD.COD_CLIENTE%TYPE,
                                                                            ED_Fec_vigencia     IN DATE,
                                                                    REGISTRO                    OUT NOCOPY FA_DCTOS_SERV_REC_TD%ROWTYPE,
                                                                                SR_Row_Id                       OUT NOCOPY ROWID,
                                                                                SN_Cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                                SV_Mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                                SN_Num_evento       OUT NOCOPY ge_errores_pg.evento);

   PROCEDURE FA_DCTOS_SERV_REC_TD_D_PR (EN_Cod_cliente      IN FA_DCTOS_SERV_REC_TD.COD_CLIENTE%TYPE,
                                                                            ED_Fec_vigencia     IN DATE,
                                                                                SN_Cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                                SV_Mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                                SN_Num_evento       OUT NOCOPY ge_errores_pg.evento);



END FA_DCTO_CLTE_SP_PG;
/
SHOW ERRORS
