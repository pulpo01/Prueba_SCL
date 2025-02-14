CREATE OR REPLACE PACKAGE BODY PV_AVL_PG AS
----------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_registra_error_pr
         (
         EN_cod_error     IN OUT  ge_errores_pg.CodError,
         EV_cadena_error  IN      ge_errores_pg.vQuery,
         EV_procedimiento IN      VARCHAR2,
            SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
            SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
            SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
         )
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ga_registra_error_fn"
      Lenguaje="PL/SQL"
      Fecha="11-11-2009"
      Versión="1.0"
      Diseñador=""
      Programador=""
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Registra errores</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_error"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="EV_cadena_error"  Tipo="CARACTER">Query que tubo el problema</param>
            <param nom="EV_procedimiento" Tipo="CARACTER">Procedimiento Afectado</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

BEGIN
     SN_cod_retorno  := 0;
     SN_num_evento   := 0;
     SV_mens_retorno := '';

     IF NOT Ge_Errores_Pg.MENSAJEERROR(EN_cod_error,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
     END IF;
     GV_des_error   := EV_procedimiento || ' ' || SQLERRM;
     SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, GV_version, USER, 'pv_ipfija_pg', EV_cadena_error, SQLCODE, GV_des_error );
	 SN_cod_retorno := EN_cod_error;

END pv_registra_error_pr;


----------------------------------------------------------------------------------------------------------------------
PROCEDURE al_modifica_estado_avl_pr(
    EV_num_imei       IN al_seriesavl_to.device_code_imei%TYPE,
    EN_cod_estado_avl IN al_seriesavl_to.ind_provision%TYPE,
    EV_mens_provision IN al_seriesavl_to.mens_provision%TYPE,
    SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento    OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AL_MODIFICA_ESTADO_AVL_PR"
      Lenguaje="PL/SQL"
      Fecha creación="10-11-2009"
      Creado por="Carlos Sellao."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Modifica Estado del Dispositivo AVL en inventario</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_num_imei" Tipo="VARCHAR">Numero de IMEI</param>
            <param nom="EN_cod_estado_avl" Tipo="NUMERICO">Estado a cambiar</param>
            <param nom="EN_mens_provision" Tipo="NUMERICO">Mensaje a grabar</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    V_des_error        ge_errores_pg.DesEvent;
    sSql               ge_errores_pg.vQuery;
    error_update	   EXCEPTION;

BEGIN

    SN_cod_retorno :=  0;
    SN_num_evento  :=  0;
    SV_mens_retorno:= '0';

    sSql := 'UPDATE al_seriesavl_to SET ind_provision = '||EN_cod_estado_avl||',';
    sSql := sSql || ' mens_provision = '||EV_mens_provision;
	sSql := sSql || ' WHERE device_code_imei = '||EV_num_imei;
	sSql := sSql || ' AND ind_provision = '||CN_ind_avlini;

	UPDATE al_seriesavl_to SET 
           ind_provision = EN_cod_estado_avl,
		   mens_provision = EV_mens_provision
	 WHERE device_code_imei = EV_num_imei
	   AND ind_provision = CN_ind_avlini;

	IF SQL%ROWCOUNT <= CN_cero THEN
		RAISE error_update;
	END IF;

EXCEPTION
   WHEN error_update THEN
      SN_cod_retorno := 424;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'al_modifica_estado_avl_pr('||EV_num_imei||','||EN_cod_estado_avl||','||EV_mens_provision||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AVL', SV_mens_retorno, '1.0', USER, 'PV_AVL_PG.al_modifica_estado_avl_pr', sSql, SQLCODE, V_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := 441;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'al_modifica_estado_avl_pr('||EV_num_imei||','||EN_cod_estado_avl||','||EV_mens_provision||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AVL', SV_mens_retorno, '1.0', USER, 'PV_AVL_PG.al_modifica_estado_avl_pr', sSql, SQLCODE, V_des_error );

END al_modifica_estado_avl_pr;

----------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_MARCAR_SERIE_AVL_PR
          (
          EN_num_abonado   IN  icc_movimiento.num_abonado%TYPE,
          EV_num_imei      IN  icc_movimiento.imei%TYPE
          )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_MARCAR_SERIE_AVL_PR"
      Lenguaje="PL/SQL"
      Fecha="11-11-2009"
      Versión="1.0"
      Diseñador="Carlos Sellao"
      Programador="Carlos Sellao"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Marcar Dispositivo AVL como aprovisionado. Cambia estado a 1.</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_abonado"      Tipo="NUMERICO" >Numero de Abonado</param>
            <param nom="EV_num_imei" Tipo="NUMERICO">Numero de IMEI</param>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
error_cambestado   EXCEPTION;

LN_cod_transaccion NUMBER(1);
LV_men_transaccion VARCHAR2(250);
CN_nom_proced      VARCHAR2(23):='pv_marcar_serie_avl_pr';

LN_cantAVL        number(2);

LN_cod_retorno   ge_errores_pg.CodError;
LV_mens_retorno  ge_errores_pg.MsgError;
LN_num_evento    ge_errores_pg.Evento;

        
BEGIN
     LN_cod_retorno  := 0;
     LN_num_evento   := 0;
     LV_mens_retorno := '';

     -- Revisa si hay un servicio AVL en ALTA en BD para el abonado.-
     GV_sSql := 'SELECT count(1)';
     GV_sSql := GV_sSql||' INTO LN_cantAVL';
     GV_sSql := GV_sSql||' FROM ga_servsuplabo';
     GV_sSql := GV_sSql||' WHERE num_abonado = '||TO_CHAR(EN_num_abonado);
     GV_sSql := GV_sSql||' AND cod_servsupl in(SELECT TO_NUMBER(v.valor)';
     GV_sSql := GV_sSql||'   FROM GE_VALORES_DOMINIOS_VW v';
     GV_sSql := GV_sSql||'   WHERE v.COD_DOMINIO  = ''CLIENTEAVL'')';
     GV_sSql := GV_sSql||'   AND ind_estado = '||CN_alta_bd;
       
     SELECT count(1)
     INTO LN_cantAVL
     FROM ga_servsuplabo
     WHERE num_abonado = EN_num_abonado
     AND  cod_servsupl in(SELECT TO_NUMBER(v.valor) 
                          FROM  GE_VALORES_DOMINIOS_VW v
                          WHERE v.COD_DOMINIO  = 'CLIENTEAVL')
     AND ind_estado = CN_alta_bd;

     --Si NO hay servicios AVL en ALTA implica que no aplica. No es Error.-
     IF LN_cantAVL <> 0 THEN

         GV_sSql := 'al_modifica_estado_avl_pr('||EV_num_imei||','||TO_CHAR(CN_ind_avlaprov)||',APROVISIONADO'||')';

         al_modifica_estado_avl_pr(EV_num_imei,CN_ind_avlaprov,'APROVISIONADO', LN_cod_retorno, LV_mens_retorno, LN_num_evento);

         IF LN_cod_retorno <> 0 THEN
            RAISE error_cambestado;
         END IF;
     END IF;

EXCEPTION
     WHEN error_cambestado THEN
          pv_registra_error_pr (CN_err_cambio_estado, GV_sSql, CN_nom_proced, LN_cod_retorno, LV_mens_retorno, LN_num_evento);

     WHEN OTHERS THEN
           pv_registra_error_pr (CN_err_ejecutar_servicio, GV_sSql, CN_nom_proced, LN_cod_retorno, LV_mens_retorno, LN_num_evento);

END PV_MARCAR_SERIE_AVL_PR;

----------------------------------------------------------------------------------------------------------------------
END PV_AVL_PG;
/
SHOW ERRORS
