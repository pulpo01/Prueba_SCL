CREATE OR REPLACE PACKAGE BODY        VE_VALIDACLIENTE_PG IS

/*
<Documentación TipoDoc = "package">
 <Elemento Nombre = "VE_VALIDACLIENTE_PG"
           Lenguaje="PL/SQL"
           Fecha="31-08-2005"
           Versión="1.1.0"
           Diseñador="Vladimir Maureira"
           Programador="Vladimir Maureira" Ambiente="DEIMOS_ANDINA">
  <Retorno>NA</Retorno>
  <Descripción> Body de VE_VALIDACLIENTE_PG /Descripción>
   <Parámetros>
   </Parámetros>
 </Elemento>
</Documentación>
*/

CV_error_no_clasif CONSTANT VARCHAR2(20) := 'Error no clasificado';
CV_nom_tabla       CONSTANT ged_codigos.nom_tabla%TYPE:='DESBLOQUEO_PREPAGO';
CV_nom_columna     CONSTANT ged_codigos.nom_columna%TYPE:='PROCESO_EXITOSO';
CV_codmodulo       CONSTANT VARCHAR2(2):='GA';


FUNCTION VE_validaClienteMoroso_FN(EV_cod_cliente   IN ge_clientes.cod_cliente%TYPE,
                                   SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
RETURN BOOLEAN IS
/*
<Documentación TipoDoc = "function">
 <Elemento Nombre = "VE_validaClienteMoroso_FN"
           Lenguaje="PL/SQL"
           Fecha="31-08-2005"
           Versión="1.0.0"
           Diseñador="Vladimir Maureira"
           Programador="Vladimir Maureira"
           Ambiente="DEIMOS_ANDINA">
  <Retorno>NA/Retorno>
   <Descripción> Determina si el cliente es Moroso /Descripción>
    <Parámetros>
     <Entrada>
      <param nom="EV_cod_cliente" Tipo="STRING">Codigo cliente</param>
     </Entrada>
     <Salida>
      <param nom="SV_val_parametro" Tipo="CARACTER">Codigo de Retorno</param>
      <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
      <param nom="SN_num_evento"    Tipo="NUMERICO">Numero de Evento</param>
     </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/
regla_ejecucion  EXCEPTION;
LN_total         NUMBER(14,4);
LV_des_error     ge_errores_pg.DesEvent;
LV_sql           ge_errores_pg.vQuery;
BEGIN
            SN_cod_retorno := 0;
            SN_num_evento  := 0;
            SV_mens_retorno:= '0';

            LV_sql := 'SELECT NVL(SUM(ca.importe_debe - ca.importe_haber),0) total ';
            LV_sql := LV_sql || 'FROM   co_cartera ca ';
            LV_sql := LV_sql || 'WHERE ca.cod_cliente = ' || EV_cod_cliente;
            LV_sql := LV_sql || '  AND   ca.ind_facturado = 1';
            LV_sql := LV_sql || '  AND   ca.fec_vencimie  < TRUNC(SYSDATE)';
            LV_sql := LV_sql || '  AND   ca.cod_tipdocum NOT IN (SELECT TO_NUMBER(co.cod_valor)';
            LV_sql := LV_sql || ' FROM   co_codigos co';
            LV_sql := LV_sql || ' WHERE  co.nom_tabla  = CO_CARTERA ';
            LV_sql := LV_sql || ' AND    co.nom_columna= COD_TIPDOCUM)';

            SELECT
                   NVL(SUM(ca.importe_debe - ca.importe_haber),0) total
            INTO   LN_total
            FROM   co_cartera ca
            WHERE  ca.cod_cliente = EV_cod_cliente
              AND  ca.ind_facturado = 1
              AND  ca.fec_vencimie  < TRUNC(SYSDATE)
              AND  ca.cod_tipdocum NOT IN (SELECT TO_NUMBER(co.cod_valor)
                                           FROM   co_codigos co
                                           WHERE  co.nom_tabla  = 'CO_CARTERA'
                                             AND  co.nom_columna = 'COD_TIPDOCUM');

            IF LN_total > 0 THEN
               SN_cod_retorno := 466; --ERROR_CLIENTE_MOROSO
               RAISE regla_ejecucion;
            ELSE
               RETURN TRUE;
            END IF;
EXCEPTION
  WHEN regla_ejecucion THEN
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;

     LV_des_error  := 'VE_validaClienteMoroso_FN(' || EV_cod_cliente || '); - ' || SQLERRM;
     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDACLIENTE_PG.VE_validaClienteMoroso_FN', LV_sql, SQLCODE, LV_des_error );

     RETURN FALSE;
  WHEN OTHERS THEN
     SN_cod_retorno := 156; --ERROR_GENERAL
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;

    LV_des_error  := 'VE_validaClienteMoroso_FN(' || EV_cod_cliente || '); - ' || SQLERRM;
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', 'Error no clasificado', '1.1', USER,'VE_VALIDACLIENTE_PG.VE_validaClienteMoroso_FN', LV_sql, SQLCODE, LV_des_error );

    RETURN FALSE;
END VE_validaClienteMoroso_FN;

FUNCTION VE_validaClienteVetado_FN(EV_numident      IN  ge_clientes.num_ident%TYPE,
                                   EV_tipident      IN  ge_clientes.cod_tipident%TYPE,
                                   SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
RETURN BOOLEAN IS
/*
<Documentación TipoDoc = "function">
 <Elemento Nombre = "VE_validaClienteVetado_FN"
           Lenguaje="PL/SQL"
           Fecha="31-08-2005"
           Versión="1.0.0"
           Diseñador="Vladimir Maureira"
           Programador="Vladimir Maureira"
           Ambiente="DEIMOS_ANDINA">
  <Retorno>NA/Retorno>
   <Descripción> Determina si el cliente esta en lista negra /Descripción>
    <Parámetros>
     <Entrada>
      <param nom="EV_tipident" Tipo="STRING">Tipo identidad del cliente a verificar</param>
      <param nom="EV_numident" Tipo="STRING">Numero de identidad del cliente a verificar</param>
     </Entrada>
     <Salida>
      <param nom="SV_val_parametro" Tipo="CARACTER">Codigo de Retorno</param>
      <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
      <param nom="SN_num_evento"    Tipo="NUMERICO">Numero de Evento</param>
     </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/
regla_ejecucion  EXCEPTION;
LN_count         NUMBER;
LV_des_error     ge_errores_pg.DesEvent;
LV_sql           ge_errores_pg.vQuery;
BEGIN
            SN_cod_retorno := 0;
            SN_num_evento  := 0;
            SV_mens_retorno:= '0';

            LV_sql := 'SELECT COUNT(1)';
            LV_sql := LV_sql || ' FROM   erd_clientes_vetados ve';
            LV_sql := LV_sql || ' WHERE  ve.num_ident_cliente =' || EV_numident;
            LV_sql := LV_sql || ' AND ve.cod_tipident =' || EV_tipident;
            LV_sql := LV_sql || ' AND SYSDATE BETWEEN ve.fec_modi_h AND NVL(ve.fec_hasta,SYSDATE)';

            SELECT COUNT(1)
            INTO   LN_count
            FROM   erd_clientes_vetados ve
            WHERE  ve.num_ident_cliente = EV_numident
              AND  ve.cod_tipident      = EV_tipident
              AND  SYSDATE BETWEEN ve.fec_modi_h AND NVL(ve.fec_hasta,SYSDATE);

            IF LN_count > 0 THEN
               SN_cod_retorno := 467; --ERROR_CLIENTE_VETADO
               RAISE regla_ejecucion;
            ELSE
               RETURN TRUE;
            END IF;
EXCEPTION
  WHEN regla_ejecucion THEN
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;

     LV_des_error  := 'VE_validaClienteVetado_FN(' || EV_tipident || ',' || EV_numident || '); - ' || SQLERRM;
     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDACLIENTE_PG.VE_validaClienteVetado_FN', LV_sql, SQLCODE, LV_des_error );

     RETURN FALSE;
  WHEN OTHERS THEN
     SN_cod_retorno := 156; --ERROR_GENERAL
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;

     LV_des_error  := 'VE_validaClienteVetado_FN(' || EV_tipident || ',' || EV_numident || '); - ' || SQLERRM;
     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', 'Error no clasificado', '1.1', USER,'VE_VALIDACLIENTE_PG.VE_validaClienteVetado_FN', LV_sql, SQLCODE, LV_des_error );

    RETURN FALSE;
END VE_validaClienteVetado_FN;

PROCEDURE VE_valida_PR(EV_tipident      IN  ge_clientes.cod_tipident%TYPE,
                       EV_numident      IN  ge_clientes.num_ident%TYPE,
                       SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                       SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                       SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
IS
/*
<Documentación TipoDoc = "procedure">
 <Elemento Nombre = "VE_valida_PR"
           Lenguaje="PL/SQL"
           Fecha="16-06-2005"
           Versión="1.1.0"
           Diseñador="Vladimir Maureira"
           Programador="Vladimir Maureira"
           Ambiente="DEIMOS_ANDINA">
  <Retorno>NA/Retorno>
   <Descripción> Determina si un cliente existe en la tabla de clientes ventas o lista negra /Descripción>
    <Parámetros>
     <Entrada>
      <param nom="EV_tipident" Tipo="STRING">Tipo identidad del cliente a verificar</param>
      <param nom="EV_numident" Tipo="STRING">Numero de identidad del cliente a verificar</param>
     </Entrada>
     <Salida>
      <param nom="SV_val_parametro" Tipo="CARACTER">Codigo de Retorno</param>
      <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
      <param nom="SN_num_evento"    Tipo="NUMERICO">Numero de Evento</param>
     </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/

        error_num_ident  EXCEPTION;
        error_ejecucion  EXCEPTION;
        LV_codcliente    ge_clientes.cod_cliente%TYPE;
        LV_sql           ge_errores_pg.vQuery;
        LV_des_error     ge_errores_pg.DesEvent;
        LV_valnit        VARCHAR2(64):='';
        TYPE TYP_cliente IS TABLE OF ge_clientes.cod_cliente%TYPE INDEX BY BINARY_INTEGER;
        C_clientes       TYP_cliente;

        CURSOR clientes_cu (EV_numident IN ge_clientes.num_ident%TYPE,EV_tipident IN ge_clientes.cod_tipident%TYPE)
        IS
        SELECT c.cod_cliente
        FROM   ge_clientes c
        WHERE  c.num_ident   = EV_numident
          AND  c.cod_tipident= EV_tipident;
BEGIN
            SN_cod_retorno :=  0;
            SN_num_evento  :=  0;
            SV_mens_retorno:= '0';

            LV_sql := 'VE_validacion_PG.VE_validanit_FN( ' || EV_numident || ',' || EV_tipident || ')';
            LV_valnit:=VE_validacion_PG.VE_validanit_FN(EV_numident, EV_tipident);
            IF SUBSTR(TRIM(UPPER(LV_valnit)), 1, 5)='ERROR' OR LV_valnit IS NULL THEN
               SN_cod_retorno := 469; -- ERROR_NUM_IDENT
               LV_sql :=LV_valnit;
               RAISE error_num_ident;
            END IF;

            LV_sql := 'SELECT c.cod_cliente';
            LV_sql := LV_sql || ' FROM   ge_clientes c';
            LV_sql := LV_sql || ' WHERE  c.num_ident =' || EV_numident;
            LV_sql := LV_sql || ' AND  c.cod_tipident=' || EV_tipident;

            FOR C_clientes IN clientes_cu (EV_numident,EV_tipident) LOOP
                 IF NOT VE_validaClienteMoroso_FN(C_clientes.cod_cliente,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                    RAISE error_ejecucion;
                 END IF;
            END LOOP;

            IF NOT VE_validaClienteVetado_FN(EV_numident,EV_tipident,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
               RAISE error_ejecucion;
            END IF;

            LV_sql:='VE_RecuperaParametros_Sms_PG.VE_recupera_glosa_FN(' || CV_codmodulo || ',' || CV_nom_tabla || ',' || CV_nom_columna ||')';
            IF NOT VE_RecuperaParametros_Sms_PG.VE_recupera_glosa_FN(CV_codmodulo,CV_nom_tabla,CV_nom_columna,SV_mens_retorno,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
               SN_cod_retorno:=0;
               SV_mens_retorno:=NULL;
               RAISE error_ejecucion;
            END IF;
EXCEPTION
   WHEN error_num_ident THEN
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;

        LV_des_error  := 'VE_valida_PR(' || EV_tipident || ',' || EV_numident || '); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDACLIENTE_PG.VE_valida_PR', LV_sql, SQLCODE, LV_des_error );
   WHEN error_ejecucion THEN
        LV_des_error  := 'VE_valida_PR(' || EV_tipident || ',' || EV_numident || '); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.1', USER,'VE_VALIDACLIENTE_PG.VE_valida_PR', LV_sql, SQLCODE, LV_des_error );

   WHEN OTHERS THEN
        SN_cod_retorno := 156;  -- ERROR General
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;

        LV_des_error  := 'VE_valida_PR(' || EV_tipident || ',' || EV_numident || '); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', 'Error no clasificado', '1.1', USER,'VE_VALIDACLIENTE_PG.VE_valida_PR', LV_sql, SQLCODE, LV_des_error );
END VE_valida_PR;

END VE_VALIDACLIENTE_PG; 
/
SHOW ERRORS
