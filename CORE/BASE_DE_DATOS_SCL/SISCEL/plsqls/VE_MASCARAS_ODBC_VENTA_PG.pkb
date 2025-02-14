CREATE OR REPLACE PACKAGE BODY VE_mascaras_odbc_venta_PG AS
-------------------------------------------------------------------
PROCEDURE VE_MASK_NP_ORIGENVENTA_PR
(EN_numtrans IN ga_transacabo.num_transaccion%TYPE,
 EN_numserie IN al_series.num_serie%TYPE,
 EN_tipproc  IN PLS_INTEGER
)
/*
<Documentación
  TipoDoc = "PROCEDURE">
   <Elemento
      Nombre = "VE_MASK_NP_ORIGENVENTA_PR"
      Lenguaje="PL/SQL"
      Fecha="08-09-2006"
      Versión="1.0"
      Diseñador="Roberto Pérez"
          Programador="Roberto Pérez"
      Ambiente Desarrollo="DEIMOS_COL>
      <Retorno>NA</Retorno>
      <Descripción>Mascara que llama al pl origen venta/Descripción>
      <Parámetros>
            <Entrada>
                                <param nom="EV_numtrasnsacc" Tipo="CARACTER">Numero de transaccion</param>
                        <param nom="EN_numserie" Tipo="NUMERICO">Numero serie</param>
                </Entrada>
                <Salida>
            </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

IS

        LV_coduso   al_usos.cod_uso%TYPE;
        LV_desuso   al_usos.des_uso%TYPE;
        LV_codart   al_articulos.cod_articulo%TYPE;
        LV_desart   al_articulos.des_articulo%TYPE;
        LV_deserror VARCHAR2(100);
        LV_codretorno ga_transacabo.cod_retorno%TYPE;
        LV_desretorno ga_transacabo.des_cadena%TYPE;
BEGIN

        NP_TRANSACCIONES_WEB_PG.NP_ORIGENVENTA_PR(EN_numserie, EN_tipproc, LV_coduso, LV_desuso, LV_codart, LV_desart, LV_deserror);

        IF LV_coduso IS NOT NULL AND LV_desuso IS NOT NULL AND LV_codart IS NOT NULL AND LV_desart IS NOT NULL THEN
           LV_codretorno:=0;
           LV_desretorno:=LV_coduso || '/' || LV_desuso || '/' || LV_codart || '/' || LV_desart;
        ELSE
           LV_codretorno:=1;
           LV_desretorno:=LV_deserror;
        END IF;

        INSERT INTO ga_transacabo (num_transaccion, cod_retorno, des_cadena)
        VALUES (EN_numtrans, LV_codretorno, LV_desretorno);

        EXCEPTION
        WHEN OTHERS THEN
                 RAISE_APPLICATION_ERROR (-20100,'<MASK_NP_ORIGENVENTA_PR>, Error Oracle: ' || TO_CHAR(SQLCODE) || chr(13) || ' Error : ' || SQLERRM);

END VE_MASK_NP_ORIGENVENTA_PR;

-----------------------------------------------------------------------------------------------------------------
PROCEDURE VE_MASK_ACTIVA_NUMPERS_PR (EN_numtrans    IN ga_transacabo.num_transaccion%TYPE,
                                                                         EV_num_celular IN VARCHAR2,
                                                                         EV_cod_prog    IN VARCHAR2)
/*
<Documentación
  TipoDoc = "PROCEDURE">
   <Elemento
      Nombre = "VE_MASK_ACTIVA_NUMPERS_PR"
      Lenguaje="PL/SQL"
      Fecha="08-09-2006"
      Versión="1.0"
      Diseñador="Roberto Pérez"
          Programador="Roberto Pérez"
      Ambiente Desarrollo="DEIMOS_COL>
      <Retorno>NA</Retorno>
      <Descripción>Mascara que llama al pl que valida numero de personal/Descripción>
      <Parámetros>
            <Entrada>
                                <param nom="EV_numtrasnsacc" Tipo="CARACTER">Numero de transaccion</param>
                        <param nom="EN_num_celular" Tipo="NUMERICO">Numero celular</param>
                                <param nom="EV_cod_prog" Tipo="CARACTER">codigo programa</param>
                </Entrada>
                <Salida>
            </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LN_cod_retorno    GE_ERRORES_PG.CodError:=0;
        LV_mens_retorno   GE_ERRORES_PG.MsgError;
        LN_num_evento     GE_ERRORES_PG.Evento;

BEGIN

        GA_NUMCEL_PERSONAL_PG.GA_VAL_ACTIV_NUMPERS_PR( EV_num_celular, EV_cod_prog, LN_cod_retorno, LN_num_evento, LV_mens_retorno );
    INSERT INTO ga_transacabo (num_transaccion, cod_retorno, des_cadena)
        VALUES (EN_numtrans, LN_cod_retorno, LV_mens_retorno);

        EXCEPTION
        WHEN OTHERS THEN
                 RAISE_APPLICATION_ERROR (-20100,'<VE_MASK_ACTIVA_NUMPERS_PR>, Error Oracle: ' || TO_CHAR(SQLCODE) || chr(13) || ' Error : ' || SQLERRM);

END VE_MASK_ACTIVA_NUMPERS_PR;

PROCEDURE VE_MASK_ACTIVA_NUMPERSONAL_PR(EV_numtrasnsacc  IN ga_transacabo.num_transaccion%TYPE,
                                                                                                                  EV_num_cel_pers        IN VARCHAR2,
                                                                                          EV_num_cel_corp        IN VARCHAR2,
                                                                                          EN_num_movimiento      IN icc_movimiento.num_movant%TYPE,
                                                                                          EV_cod_prog            IN VARCHAR2
                                                                                                                 )
/*
<Documentación
  TipoDoc = "PROCEDURE">
   <Elemento
      Nombre = "VE_MASK_ACTIVA_NUMPERSONAL_PR"
      Lenguaje="PL/SQL"
      Fecha="08-09-2006"
      Versión="1.0"
      Diseñador="Roberto Pérez"
          Programador="Roberto Pérez"
      Ambiente Desarrollo="DEIMOS_COL>
      <Retorno>NA</Retorno>
      <Descripción>Mascara que llama la insercion de numero personal/Descripción>
      <Parámetros>
            <Entrada>
                                <param nom="EV_numtrasnsacc" Tipo="CARACTER">Numero de transaccion</param>
                        <param nom="EV_num_cel_pers" Tipo="CARACTER">Numero celular personal</param>
                        <param nom="EV_num_cel_corp" Tipo="CARACTER">Numero celular corporativo</param>
                        <param nom="EN_num_movimiento" Tipo="NUMERICO">Numero Movimiento</param>
                                <param nom="EV_cod_prog" Tipo="CARACTER">Código de  Programa</param>
                </Entrada>
                <Salida>
            </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

LN_p_correlativo        NUMBER;
LN_cod_retorno      INTEGER;
LN_num_evento           INTEGER;
LV_msg_retorno          VARCHAR2(100);
BEGIN

  GA_NUMCEL_PERSONAL_PG.GA_ACTIVA_NUMPERSONAL_PR(EV_num_cel_pers, EV_num_cel_corp,
                                                                                 EN_num_movimiento, EV_cod_prog, LN_p_correlativo,
                                                                                                 LN_cod_retorno,LN_num_evento, LV_msg_retorno);

  INSERT INTO ga_transacabo (num_transaccion, cod_retorno, des_cadena)
  VALUES (EV_numtrasnsacc, LN_cod_retorno, LV_msg_retorno);

EXCEPTION
                 WHEN OTHERS THEN
                          RAISE_APPLICATION_ERROR (-20100,'<VE_MASK_ACTIVA_NUMPERSONAL_PR>, Error Oracle: ' || TO_CHAR(SQLCODE) || chr(13) || ' Error : ' || SQLERRM);

END VE_MASK_ACTIVA_NUMPERSONAL_PR;


END VE_mascaras_odbc_venta_PG;
/
SHOW ERRORS
