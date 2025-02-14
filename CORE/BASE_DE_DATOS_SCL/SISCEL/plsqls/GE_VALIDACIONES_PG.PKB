CREATE OR REPLACE PACKAGE BODY GE_VALIDACIONES_PG
IS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Inicio modificacion by SAQL/Soporte 11/11/2005 - RA-200511010012
FUNCTION GE_VALIDA_SITUACION_CELULAR_FN(
   EN_num_celular in ga_aboamist.num_celular%type,
   SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
)
RETURN BOOLEAN
AS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "GE_VALIDA_SITUACION_CELULAR_FN" Lenguaje="PL/SQL" Fecha="11-11-2005" Versión="1.0" Diseñador="Sebastian Quevedo L." Programador="Sebastian Quevedo L." Ambiente="BD">
<Retorno>BOOLEAN</Retorno>
<Descripción>Funcion para validar que el celular no se encuentre activado</Descripción>
<Parámetros>
   <Entrada>
      <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
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

   vCantidad number;
   vRetorno boolean;
BEGIN
   SN_cod_retorno := '0';
   SV_mens_retorno := '';
   SN_num_evento := 0;
   vCantidad := '0';
   vRetorno := FALSE;

   SELECT COUNT(1) INTO vCantidad
   FROM GA_ABOAMIST
   WHERE NUM_CELULAR = EN_num_celular
   AND COD_SITUACION NOT IN ('BAP','BAA')
   /* Inicio modificacion by SAQL/Soporte 23/11/2005 - RA-200511010012 */
   AND COD_CLIENTE <> COD_CLIENTE_DIST;
   /* Fin modificacion by SAQL/Soporte 23/11/2005 - RA-200511010012 */

   IF vCantidad > 0 THEN
      vRetorno := TRUE;
      SN_cod_retorno := '1';
      SV_mens_retorno := 'CELULAR YA SE ENCUENTRA ACTIVADO';
   END IF;
   RETURN vRetorno;
END GE_VALIDA_SITUACION_CELULAR_FN;
-- Fin modificacion by SAQL/Soporte 11/11/2005 - RA-200511010012
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ge_valida_num_celular_fn (
   EN_num_celular     IN   		   ga_abocel.num_celular%TYPE,
   SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_valida_num_celular_fn"
      Lenguaje="PL/SQL"
      Fecha="26-04-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Valida Largo Numero Celular</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
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
RETURN  BOOLEAN
AS
   error_largo             EXCEPTION ;
   N_codretorno             ge_errores_td.cod_msgerror%TYPE;
   V_des_error               ge_errores_pg.DesEvent;
   sSql                            ge_errores_pg.vQuery;
   V_val_parametro       ged_parametros.val_parametro%TYPE;
   V_mens_retorno        ge_errores_td.det_msgerror%TYPE;

BEGIN

   SN_cod_retorno := '0';
   SN_num_evento  := 0;
   N_codretorno   := '0';

   sSql:=NULL;
   IF EN_num_celular IS NULL THEN
   	  sSql:='Numero celular es nulo';
      RAISE  error_largo;
   END  IF;

   IF ge_obtiene_gedparametros_fn('LARGO_N_CELULAR', 'GE', 1, V_val_parametro, N_codretorno, V_mens_retorno, SN_num_evento) THEN
      IF TO_NUMBER(V_val_parametro) = LENGTH(EN_num_celular) THEN
         RETURN  TRUE;
      ELSE
          sSql:='Largo Numero celular no corresponde.';
	      RAISE  error_largo;
      END  IF;
   ELSE
      IF N_codretorno = '0' THEN
         RAISE  error_largo;
      END  IF;
   END  IF;

   RETURN  TRUE;


EXCEPTION
   WHEN  error_largo THEN
      SN_cod_retorno := '303'; -- Nuevo Error
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END  IF;
      V_des_error := SUBSTR('error_largo: ge_valida_num_celular_fn('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_num_celular_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;

   WHEN  OTHERS   THEN
      SN_cod_retorno := '303'; --Nuevo Error
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END  IF;
      V_des_error := SUBSTR('Others: ge_valida_num_celular_fn('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_num_celular_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END  ge_valida_num_celular_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_ciclo_fn (
   EN_num_celular   IN           ga_abocel.num_celular%TYPE,
   EN_cod_cliente   IN           ga_abocel.cod_cliente%TYPE,
   EN_num_abonado   IN           ga_abocel.num_abonado%TYPE,
   EN_cod_ciclo     IN           ga_abocel.cod_ciclo%TYPE,
   SN_cod_ciclfact  OUT NOCOPY   fa_ciclfact.cod_ciclfact%TYPE,
   SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_valida_ciclo_fn"
      Lenguaje="PL/SQL"
      Fecha="27-04-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Valida ciclo de facturación de un abonado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
            <param nom="EN_cod_cliente"     Tipo="NUMERICO">Codigo del Cliente</param>
            <param nom="EN_num_abonado"     Tipo="NUMERICO">Secuencia nro del abonado</param>
            <param nom="EN_cod_ciclo"       Tipo="NUMERICO">Codigo ciclo facturacion</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_ciclfact"       Tipo="NUMERICO">Codigo del ciclo de facturación</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN  BOOLEAN
AS

   N_codretorno             ge_errores_td.cod_msgerror%TYPE;
   V_des_error              ge_errores_pg.DesEvent;
   sSql                     ge_errores_pg.vQuery;
   V_val_parametro          ged_parametros.val_parametro%TYPE;
   LN_dato					NUMBER;

BEGIN
   SN_cod_retorno:= '0';
   SN_num_evento:= 0;
   SN_cod_ciclfact:=NULL;
   LN_dato:=NULL;

   sSql := 'SELECT ciclo.cod_ciclfac';
   sSql := sSql || ' FROM fa_ciclfact ciclo';
   sSql := sSql || ' WHERE ciclo.cod_ciclo='||EN_cod_ciclo;
   sSql := sSql || ' AND SYSDATE BETWEEN ciclo.FEC_DESDEOCARGOS AND ciclo.FEC_HASTAOCARGOS;';

   SELECT ciclo.cod_ciclfact INTO SN_cod_ciclfact
	 FROM fa_ciclfact ciclo
    WHERE ciclo.cod_ciclo=EN_cod_ciclo
	  AND SYSDATE BETWEEN ciclo.FEC_DESDEOCARGOS AND ciclo.FEC_HASTAOCARGOS;

   sSql := 'SELECT 1';
   sSql := sSql || ' FROM ga_infaccel infac';
   sSql := sSql || ' WHERE infac.cod_cliente='||EN_cod_cliente;
   sSql := sSql || ' AND infac.num_abonado='||EN_num_abonado;
   sSql := sSql || ' AND infac.ind_actuac=1';
   sSql := sSql || ' AND infac.cod_ciclfact='||SN_cod_ciclfact;

   SELECT 1 INTO LN_dato
	 FROM ga_infaccel infac
    WHERE infac.cod_cliente=EN_cod_cliente
	  AND infac.num_abonado=EN_num_abonado
	  AND infac.ind_actuac=1
	  AND infac.cod_ciclfact=SN_cod_ciclfact;

   RETURN  TRUE;

EXCEPTION
WHEN  NO_DATA_FOUND   THEN
      SN_cod_retorno := '310'; -- Nuevo Error
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END  IF;
      V_des_error :=SUBSTR('NO_DATA_FOUND  : ge_valida_ciclo_fn('||EN_num_celular||','||
	  			     EN_cod_cliente||'.'||EN_num_abonado||','||EN_cod_ciclo||'); - ' || SQLERRM,1,CN_largoerrtec);
 	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_ciclo_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
WHEN  OTHERS   THEN
      SN_cod_retorno := '302'; -- Nuevo Error
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END  IF;
      V_des_error :=SUBSTR('others  : ge_valida_ciclo_fn('||EN_num_celular||','||
	  			     EN_cod_cliente||'.'||EN_num_abonado||','||EN_cod_ciclo||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_ciclo_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END  ge_valida_ciclo_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_situacion_abo_fn  (
   EN_num_celular    IN           ga_abocel.num_celular%TYPE,
   EV_cod_situacion  IN           ga_abocel.cod_situacion%TYPE,
   SN_cod_retorno    OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno   OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento     OUT NOCOPY   ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_valida_situacion_abo_fn"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Validar situacion del abonado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
            <param nom="EV_cod_situacion"    Tipo="CARACTER">Situacion a validar</param>
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
RETURN  BOOLEAN
AS
        V_des_error  ge_errores_pg.DesEvent;
        sSql         ge_errores_pg.vQuery;
 	    SN_num_abonado    ga_abocel.num_abonado%TYPE;
		SN_cod_cliente    ga_abocel.cod_cliente%TYPE;
		SN_cod_producto   ga_abocel.cod_producto%TYPE;
		SV_cod_situacion  ga_abocel.cod_situacion%TYPE;
 		SV_tip_plantarif  ga_abocel.tip_plantarif%TYPE;
		SV_cod_plantarif  ga_abocel.cod_plantarif%TYPE;
		SV_num_serie      ga_abocel.num_serie%TYPE;
		SN_cod_ciclo	  ga_abocel.cod_ciclo%TYPE;
		SV_tecnologia     ga_abocel.cod_tecnologia%TYPE;
		SV_num_imei       ga_abocel.num_imei%TYPE;
		SV_num_min_mdn    ga_abocel.num_min_mdn%TYPE;
		SV_cod_password   ga_abocel.cod_password%TYPE;
		SV_num_min        ga_abocel.num_min%TYPE;
		SV_tip_terminal   ga_abocel.tip_terminal%TYPE;
		SV_num_seriehex   ga_abocel.num_seriehex%TYPE;
		SV_num_seriemec   ga_abocel.num_seriemec%TYPE;
		SV_tipo_abonado   VARCHAR2(10);
		SN_cod_cuenta	    ga_abocel.cod_cuenta%TYPE;
		error_ejecucion     EXCEPTION ;
		LN_num_transaccion 	ga_transacabo.num_transaccion%TYPE;
		LN_cod_retorno      ga_transacabo.cod_retorno%TYPE;
		LV_des_cadena		ga_transacabo.des_cadena%TYPE;
		LV_ejec_rest	    VARCHAR2(500);

    BEGIN
		SN_cod_retorno := '0';
        SN_num_evento  := 0;

		--Inicializar variables
 	    SN_num_abonado:=NULL;
		SN_cod_cliente:=NULL;
		SN_cod_producto:=NULL;
		SV_cod_situacion:=NULL;
 		SV_tip_plantarif:=NULL;
		SV_cod_plantarif:=NULL;
		SV_num_serie:=NULL;
		SN_cod_ciclo:=NULL;
		SV_tecnologia:=NULL;
		SV_num_imei:=NULL;
		SV_num_min_mdn:=NULL;
		SV_cod_password:=NULL;
		SV_num_min:=NULL;
		SV_tip_terminal:=NULL;
		SV_num_seriehex:=NULL;
		SV_num_seriemec:=NULL;
		SV_tipo_abonado:=NULL;
		SN_cod_cuenta:=NULL;

        -- 1.- Validar si numero celular cumple con el largo definido...
		sSql:='ge_validaciones_pg.ge_valida_num_celular_fn('||EN_num_celular||','||SN_COD_RETORNO||','||SV_MENS_RETORNO||','||SN_NUM_EVENTO||');';
        IF NOT ge_validaciones_pg.ge_valida_num_celular_fn(EN_num_celular,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
	       SN_cod_retorno := '303';
           RAISE  error_ejecucion;
        END IF;

		--Validar que suscriptor exista.....
		sSql:=SUBSTR('GA_CONS_PG.ga_valida_existeabonado_fn('||EN_num_celular||') - '||SQLERRM,1,CN_largoquery);
		IF NOT GA_CONS_PG.ga_valida_existabonado_fn(EN_num_celular,SN_num_abonado,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
           RAISE  error_ejecucion;
        END IF;

/* Inicio - 29-06-2005 - Eliminar restricción sólo postpago....
        --Validar restricción-
		LV_ejec_rest:=EN_num_celular||'|';
		sSql:='SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL';
		SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL;
		PV_PR_EJECUTA_RESTRICCION(LN_num_transaccion,CV_cod_modulo,1,CV_actuacion,'EXECUTE',LV_ejec_rest);

		LN_cod_retorno:=NULL;
		LV_des_cadena:=NULL;
		sSql:='SELECT COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena '||
		      'FROM  GA_TRANSACABO '||
			  'WHERE  NUM_TRANSACCION='||LN_num_transaccion;
		SELECT  COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena
		  FROM  GA_TRANSACABO
		 WHERE  NUM_TRANSACCION=LN_num_transaccion;
		IF LN_cod_retorno<>0 THEN
           SN_cod_retorno := '314'; -- Nuevo Error
		   sSql:=LV_des_cadena;
		   RAISE error_ejecucion;
		END IF;
 Fin - 29-06-2005 */

		sSql:='LENGTH(TRIM(EV_cod_situacion)) IS NULL';
		IF LENGTH(TRIM(EV_cod_situacion)) IS NULL THEN
           SN_cod_retorno := '302';
		   RAISE  error_ejecucion;
		END IF;

        -- Ejecutar procedimiento que obtiene datos del abonado, entre ellos la serie...
        sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR('||EN_num_celular||','||SN_num_abonado||','||SN_cod_cliente||','||SN_cod_producto||','||SV_cod_situacion||','||SV_tip_plantarif||','
		      ||SV_cod_plantarif||','||SV_num_serie||','||SN_cod_ciclo||','||SV_tecnologia||','||SV_num_imei||','
			  ||SV_num_min_mdn||','||SV_num_min_mdn||','||SV_cod_password||','||SV_num_min||','
			  ||SV_tip_terminal||','||SV_num_seriehex||','||SV_num_seriemec||','||SV_tipo_abonado||','
			  ||SN_cod_cuenta||','||SN_cod_retorno||','
			  ||SV_mens_retorno||','||SN_num_evento||');',1,CN_largoquery);
	    GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR(EN_num_celular, SN_num_abonado,
		   SN_cod_cliente, SN_cod_producto, SV_cod_situacion,SV_tip_plantarif,
		   SV_cod_plantarif, SV_num_serie, SN_cod_ciclo,
		   SV_tecnologia,SV_num_imei, SV_num_min_mdn, SV_cod_password, SV_num_min,
		   SV_tip_terminal,SV_num_seriehex, SV_num_seriemec,SV_tipo_abonado,SN_cod_cuenta,
		   SN_cod_retorno,SV_mens_retorno, SN_num_evento);
		IF SN_cod_retorno <> 0 THEN  -- no hay datos
		   RAISE  error_ejecucion;
		END  IF;
		IF SN_cod_cliente IS NULL THEN
	       SN_cod_retorno := '146';
		   RAISE  error_ejecucion;
		END IF;
		IF EV_cod_situacion<>SV_cod_situacion THEN
		   RETURN  FALSE;
		END  IF;
        RETURN  TRUE;

EXCEPTION
   WHEN  error_ejecucion THEN
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END  IF;
      V_des_error := SUBSTR('error_ejecucion: ge_valida_situacion_abo_fn('||EN_num_celular||', '||EV_cod_situacion||'); - ' || SQLERRM,1,CN_largoerrtec);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_situacion_abo_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;

   WHEN  OTHERS   THEN
      SN_cod_retorno := '302';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END  IF;
      V_des_error := SUBSTR('Others: ge_valida_situacion_abo_fn('||EN_num_celular||', '||EV_cod_situacion||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_situacion_abo_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END  ge_valida_situacion_abo_fn;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_obtiene_gedparametros_fn (
   EV_nom_parametro  IN           ged_parametros.nom_parametro%TYPE,
   EV_nom_modulo     IN           ged_parametros.cod_modulo%TYPE,
   EN_cod_producto   IN           ged_parametros.cod_producto%TYPE,
   SV_val_parametro  OUT NOCOPY   ged_parametros.val_parametro%TYPE,
   SN_cod_retorno    OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno   OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento     OUT NOCOPY   ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ga_obtiene_gedparametros_fn"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtiene datos desde la GED_PARAMETROS</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_nom_parametro" Tipo="CARACTER">Nombre del parametro</param>
            <param nom="EV_nom_modulo" Tipo="CARACTER">Nombre del modulo, no es obligatorio</param>
            <param nom="EN_cod_producto" Tipo="NUMERICO">Codigo del producto no es obligatorio</param>
         </Entrada>
         <Salida>
            <param nom="SV_val_parametro"       Tipo="CARACTER">Valor del parametro</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN  BOOLEAN
AS
   V_des_error              ge_errores_pg.DesEvent;
   sSql                     ge_errores_pg.vQuery;

BEGIN
   SN_cod_retorno := '0';
   SN_num_evento  := 0;
   SV_val_parametro:=NULL;

   sSql:= 'SELECT VAL_PARAMETRO FROM GED_PARAMETROS WHERE NOM_PARAMETRO='''||EV_nom_parametro||'';
   sSql:= sSql||''' AND COD_MODULO= ''' || EV_nom_modulo || '''';
   sSql:= sSql||' AND COD_PRODUCTO='||EN_cod_producto;
   SELECT VAL_PARAMETRO INTO SV_val_parametro
   FROM GED_PARAMETROS
   WHERE NOM_PARAMETRO=EV_nom_parametro
   AND COD_MODULO=EV_nom_modulo
   AND COD_PRODUCTO=EN_cod_producto;

   RETURN  TRUE;

EXCEPTION
WHEN  NO_DATA_FOUND   THEN
      SN_cod_retorno := '302';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END  IF;
      V_des_error:=SUBSTR('NO_DATA_FOUND : ga_obtiene_gedparametros_fn('||EV_nom_parametro||','||EV_nom_modulo||','||EN_cod_producto||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ga_obtiene_gedparametros_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;

WHEN  OTHERS   THEN
      SN_cod_retorno := '302';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END  IF;
      V_des_error:=SUBSTR('OTHERS  : ga_obtiene_gedparametros_fn('||EV_nom_parametro||','||EV_nom_modulo||','||EN_cod_producto||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ga_obtiene_gedparametros_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END  ge_obtiene_gedparametros_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_desbloqueo_fn (
   EN_num_celular   IN           ga_abocel.num_celular%TYPE,
   SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_valida_desbloqueo_fn"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Validar si abonado prepago requiere desbloqueo con personalización o no</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
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
RETURN  BOOLEAN
AS
        V_des_error  ge_errores_pg.DesEvent;
        sSql         ge_errores_pg.vQuery;
		LN_dato      NUMBER;

        BEGIN
   	    --Inicializar variables
		SN_cod_retorno := '0';
        SN_num_evento  := 0;
		LN_dato:=NULL;

        sSql:='SELECT 1 FROM ga_aboamist prepago'||
			  ' WHERE prepago.num_celular='||EN_num_celular||
			  '	AND prepago.cod_cliente = prepago.cod_cliente_dist;';

  	   SELECT 1 INTO LN_dato
	     FROM ga_aboamist prepago
		WHERE prepago.num_celular = EN_num_celular
		AND prepago.cod_cliente = prepago.cod_cliente_dist;

	    RETURN  TRUE;

EXCEPTION
WHEN  NO_DATA_FOUND THEN
      RETURN  FALSE;

WHEN  OTHERS   THEN
      SN_cod_retorno := '302';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END  IF;
      V_des_error := SUBSTR('error_ejecucion: ge_valida_desbloqueo_fn('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_desbloqueo_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END  ge_valida_desbloqueo_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_existe_cliente_fn (
   EN_cod_cliente   IN			 ge_clientes.cod_cliente%TYPE,
   SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_valida_existe_cliente_fn"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Validar si existe un cliente prepago.</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente"       Tipo="NUMERICO">Codigo de cliente. Retorna NULL si no existe/param>
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
RETURN  BOOLEAN
AS
        V_des_error     ge_errores_pg.DesEvent;
        sSql            ge_errores_pg.vQuery;
		LN_cod_cliente  ge_clientes.cod_cliente%TYPE;

BEGIN
   	    --Inicializar variables
		SN_cod_retorno := '0';
        SN_num_evento  := 0;
		LN_cod_cliente:=NULL;

        sSql:='SELECT cli.cod_cliente FROM ge_clientes cli'||
	          ' WHERE cli.cod_cliente='||EN_cod_cliente||' cli.ind_alta=''M''';

        SELECT cli.cod_cliente INTO LN_cod_cliente
	    FROM ge_clientes cli
	    WHERE cli.cod_cliente=EN_cod_cliente
		AND cli.ind_alta='M';

		RETURN  TRUE;

EXCEPTION
WHEN  NO_DATA_FOUND THEN
      SN_cod_retorno := '302';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END  IF;
      V_des_error := SUBSTR('others: ge_valida_existe_cliente_fn('||EN_cod_cliente||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_existe_cliente_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;

WHEN  OTHERS   THEN
      SN_cod_retorno := '302';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END  IF;
      V_des_error := SUBSTR('others: ge_valida_existe_cliente_fn('||EN_cod_cliente||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_existe_cliente_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END  ge_valida_existe_cliente_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_cons_ss_mensajeria_fn (
   EN_num_abonado   IN           ga_abocel.num_abonado%TYPE,
   EV_cod_servicio  IN           ga_servsuplabo.cod_servicio%TYPE,
   SN_cod_servsupl  OUT NOCOPY   ga_servsuplabo.cod_servsupl%TYPE,
   SN_cod_nivel     OUT NOCOPY   ga_servsuplabo.cod_nivel%TYPE,
   SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_cons_ss_mensajeria_fn"
      Lenguaje="PL/SQL"
      Fecha="29-04-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Validar si existe un servicio.</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero del abonado</param>
            <param nom="EV_cod_servicio" Tipo="NUMERICO">Codigo comercial del servicio a consultar</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_servsupl"       Tipo="NUMERICO">Codigo del servicio suplementario en centrales</param>
            <param nom="SN_cod_nivel"       Tipo="NUMERICO">Nivel  del servicio suplementario para centrales</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN  BOOLEAN
AS

		V_des_error  ge_errores_pg.DesEvent;
        sSql         ge_errores_pg.vQuery;

        BEGIN

   	    --Inicializar variables
		SN_cod_retorno := '0';
        SN_num_evento  := 0;
		SN_cod_servsupl:=NULL;
		SN_cod_nivel:=NULL;

        sSql:='SELECT ss.cod_servsupl, ss.cod_nivel '||
			  ' FROM ga_servsuplabo ss '||
			  ' WHERE ss.num_abonado='||EN_num_abonado||
	          ' AND ss.cod_servicio='||EV_cod_servicio||
	          ' AND ss.fec_bajabd IS NULL';

	    SELECT ss.cod_servsupl, ss.cod_nivel
		   INTO SN_cod_servsupl,SN_cod_nivel
	    FROM ga_servsuplabo ss
	    WHERE ss.num_abonado=EN_num_abonado
	    AND ss.cod_servicio=EV_cod_servicio
		AND ss.fec_bajabd IS NULL;

		RETURN  TRUE;

EXCEPTION
WHEN  NO_DATA_FOUND THEN
      RETURN  FALSE;
WHEN  OTHERS   THEN
      SN_cod_retorno := '302';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END  IF;
      V_des_error :=SUBSTR('Others: ge_cons_ss_mensajeria_fn('||EN_num_abonado||','||EV_cod_servicio||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_existe_cliente_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END  ge_cons_ss_mensajeria_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_recupera_tiporserv_fn (
   EV_cod_os 		  IN           ci_tiporserv.cod_os%TYPE,
   SV_descripcion 	  OUT NOCOPY   ci_tiporserv.descripcion%TYPE,
   SV_cod_tipmodi 	  OUT NOCOPY   ci_tiporserv.cod_tipmodi%TYPE,
   SV_grupo 	   	  OUT NOCOPY   ci_tiporserv.grupo%TYPE,
   SV_nom_exe 	   	  OUT NOCOPY   ci_tiporserv.nom_exe%TYPE,
   SV_menu    	   	  OUT NOCOPY   ci_tiporserv.menu%TYPE,
   SV_cod_aplic   	  OUT NOCOPY   ci_tiporserv.cod_aplic%TYPE,
   SN_tip_ooss        OUT NOCOPY   ci_tiporserv.tip_ooss%TYPE,
   SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_recupera_tiporserv_fn"
      Lenguaje="PL/SQL"
      Fecha="30-04-2005"
      Versión="1.0"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Recupera informacion de una orden de servicio</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_os" Tipo="CARACTER">Codigo de Orden de Servicio</param>
         </Entrada>
         <Salida>
            <param nom="SV_descripcion" Tipo="CARACTER">Descripcion de la Orden de Servicio</param>
            <param nom="SV_cod_tipmodi" Tipo="CARACTER">Codigo de Tipo Modificacion</param>
            <param nom="SV_grupo" Tipo="CARACTER">Grupo</param>
            <param nom="SV_nom_exe" Tipo="CARACTER">NOmbre Ejecutable</param>
            <param nom="SV_menu" Tipo="CARACTER">Menu</param>
            <param nom="SV_cod_aplic" Tipo="CARACTER">Codigo Aplicacion</param>
            <param nom="SN_tip_ooss" Tipo="CARACTER">Tipo orden de servicio</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
IS
   V_des_error  ge_errores_pg.DesEvent;
   sSql         ge_errores_pg.vQuery;
BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= 0;

	sSql :=SUBSTR('SELECT descripcion, cod_tipmodi, grupo, nom_exe, menu, cod_aplic, tip_ooss'||
         ' INTO SV_descripcion, SV_cod_tipmodi, SV_grupo, SV_nom_exe, SV_menu, SV_cod_aplic, SN_tip_ooss'||
	     ' FROM ci_tiporserv'||
	     ' WHERE cod_os = ' || EV_cod_os,1,CN_largoquery);


    SELECT descripcion, cod_tipmodi, grupo, nom_exe, menu, cod_aplic, tip_ooss
	INTO   SV_descripcion, SV_cod_tipmodi, SV_grupo, SV_nom_exe, SV_menu, SV_cod_aplic, SN_tip_ooss
	FROM   ci_tiporserv
	WHERE  cod_os = EV_cod_os;

	RETURN TRUE;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := '302';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error :=SUBSTR('others: ge_recupera_tiporserv_fn('||EV_cod_os||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'ge_recupera_tiporserv_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE;

END ge_recupera_tiporserv_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_registra_ooss_fn(EN_cod_os         IN  ci_orserv.cod_os%TYPE,
                             EV_producto       IN  ci_orserv.producto%TYPE,
                             EN_tip_inter      IN  ci_orserv.tip_inter%TYPE,
                             EN_cod_inter      IN  ci_orserv.cod_inter%TYPE,
                             EV_usuario        IN  ci_orserv.usuario%TYPE,
                             EV_comentario     IN  ci_orserv.comentario%TYPE,
                             EN_num_cargo      IN  ci_orserv.num_cargo%TYPE,
                             EV_cod_modulo     IN  ci_orserv.cod_modulo%TYPE,
                             EN_id_gestor      IN  ci_orserv.id_gestor%TYPE,
                             EN_num_movimiento IN  ci_orserv.num_movimiento%TYPE,
                             EN_cod_estado     IN  ci_orserv.cod_estado%TYPE,
	   	  		  			 SN_numooss        OUT NOCOPY ci_orserv.num_os%TYPE,
							 SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
   							 SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
   							 SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_registra_ooss_fn"
      Lenguaje="PL/SQL"
      Fecha="20-04-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>GENERA UNA OOSS PARA CAMBIO DE DIRECCION</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_os"          Tipo="NUMERICO">Código de OOSS</param>
            <param nom="EV_producto"        Tipo="NUMERICO">Código de producto</param>
            <param nom="EN_tip_inter"       Tipo="NUMERICO"></param>
            <param nom="EN_cod_inter"       Tipo="NUMERICO"></param>
            <param nom="EV_usuario"         Tipo="NUMERICO">codigo de usuario</param>
            <param nom="EV_comentario"      Tipo="NUMERICO">Comentario</param>
            <param nom="EN_num_cargo"       Tipo="NUMERICO">numero de cargo</param>
            <param nom="EV_cod_modulo"      Tipo="NUMERICO">Código de modulo</param>
            <param nom="EN_id_gestor"       Tipo="NUMERICO">Identificador de Gestro</param>
            <param nom="EN_num_movimiento"  Tipo="NUMERICO">Numero de Movimineto</param>
            <param nom="EN_cod_estado"      Tipo="NUMERICO">Código de Estado</param>
         </Entrada>
         <Salida>
            <param nom="SN_numooss"    Tipo="NUMERICO">Numero de Orden de Servicio</param>
            <param nom="SN_NUMOOSS"    Tipo="CARACTER">Número de Orden de Servicio</param>
            <param nom="SN_CODERROR"    Tipo="NUMERICO">Código de error</param>
            <param nom="SV_DESERROR"    Tipo="CARACTER">Descripción de error</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
    IS
        V_des_error      ge_errores_pg.DesEvent;
        sSql             ge_errores_pg.vQuery;
    BEGIN

	    SN_cod_retorno := '0';
        SN_num_evento  := 0;

        SELECT ci_seq_numos.NEXTVAL
        INTO   SN_numooss
        FROM DUAL;


		sSql:=SUBSTR('INSERT INTO ci_orserv'||
              ' (num_os, cod_os, producto, tip_inter, cod_inter, usuario, fecha, comentario, num_cargo,'||
			  ' cod_modulo, id_gestor, num_movimiento, cod_estado) VALUES ('||
			   SN_numooss||','||EN_cod_os||','||EV_producto||','||EN_tip_inter||','||EN_cod_inter||','||
			   EV_usuario||','|| SYSDATE||','||EV_comentario||','||EN_num_cargo||','||
			   EV_cod_modulo||','||EN_id_gestor||','||EN_num_movimiento||','||EN_cod_estado||');',1,CN_largoquery);

        INSERT INTO ci_orserv
        (num_os, cod_os, producto, tip_inter, cod_inter, usuario, FECHA, comentario, num_cargo, cod_modulo, id_gestor, num_movimiento, cod_estado)
        VALUES
        (SN_numooss, EN_cod_os, EV_producto, EN_tip_inter, EN_cod_inter, EV_usuario, SYSDATE, EV_comentario, EN_num_cargo, EV_cod_modulo, EN_id_gestor, EN_num_movimiento, EN_cod_estado);

        RETURN TRUE;

        EXCEPTION
            WHEN OTHERS THEN
                SN_cod_retorno := '302';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := SUBSTR('others: ge_registra_ooss_fn('||EN_cod_os||', '||EV_producto||', '||EN_tip_inter||', '||EN_cod_inter||', '||EV_usuario||', '||EV_comentario||', '||EN_num_cargo||', '||EV_cod_modulo||', '||EN_id_gestor||', '||EN_num_movimiento||', '||EN_cod_estado||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'ge_registra_ooss_fn', sSql, SQLCODE, V_des_error );
                ROLLBACK;
				RETURN FALSE;

END ge_registra_ooss_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_regprovciucom_fn (
   EV_cod_region     IN           ge_regiones.cod_region%TYPE,
   EV_cod_provincia  IN           ge_provincias.cod_provincia%TYPE,
   EV_cod_ciudad     IN           ge_ciudades.cod_ciudad%TYPE,
   EV_cod_comuna     IN           ge_comunas.cod_comuna%TYPE,
   SN_cod_retorno    OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno   OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento     OUT NOCOPY   ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_valida_regprovciucom_fn"
      Lenguaje="PL/SQL"
      Fecha="21-06-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Valida si existe relacion entre region-provincia-ciudad-comuna</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_region" Tipo="CARACTER">codigo de region</param>
            <param nom="EV_cod_provincia" Tipo="CARACTER">codigo de provincia</param>
            <param nom="EV_cod_ciudad" Tipo="CARACTER">codigo de ciudad</param>
            <param nom="EV_cod_comuna" Tipo="CARACTER">codigo de comuna</param>
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
RETURN BOOLEAN
AS
   V_des_error              ge_errores_pg.DesEvent;
   sSql                     ge_errores_pg.vQuery;
   LV_cod_region			ge_regiones.cod_region%TYPE;


BEGIN
      SN_cod_retorno := '0';
      SN_num_evento  :=  0;
 	  LV_cod_region:=NULL;
	  sSql:=SUBSTR('SELECT COD_REGION FROM GE_CIUCOM CIUCOM '||
	        'WHERE CIUCOM.COD_REGION='||EV_cod_region||
	        'AND CIUCOM.COD_PROVINCIA='||EV_cod_provincia||
		    'AND CIUCOM.COD_CIUDAD='||EV_cod_ciudad||
		    'AND CIUCOM.COD_COMUNA='||EV_cod_comuna,1,CN_largoquery);

	  SELECT  COD_REGION INTO LV_cod_region
		FROM  GE_CIUCOM CIUCOM
	   WHERE  CIUCOM.COD_REGION=EV_cod_region
	     AND  CIUCOM.COD_PROVINCIA=EV_cod_provincia
		 AND  CIUCOM.COD_CIUDAD=EV_cod_ciudad
		 AND  CIUCOM.COD_COMUNA=EV_cod_comuna;

       RETURN TRUE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := '327';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END IF;
      V_des_error := SUBSTR('no_data_found: ge_valida_regprovciucom_fn('||EV_cod_region||','||EV_cod_provincia||','||EV_cod_ciudad||','||EV_cod_comuna||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento :=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_regprovcomciu_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
WHEN OTHERS THEN
      SN_cod_retorno := '327';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END IF;
      V_des_error := SUBSTR('others: ge_valida_regprovciucom_fn('||EV_cod_region||','||EV_cod_provincia||','||EV_cod_ciudad||','||EV_cod_comuna||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento :=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_regprovcomciu_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END ge_valida_regprovciucom_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_region_fn (
   EV_cod_region     IN           ge_regiones.cod_region%TYPE,
   SN_cod_retorno    OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno   OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento     OUT NOCOPY   ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_valida_region_fn "
      Lenguaje="PL/SQL"
      Fecha="03-05-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Valida que exista region consultada</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_region" Tipo="CARACTER">codigo de region</param>
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
RETURN BOOLEAN
AS
   V_des_error              ge_errores_pg.DesEvent;
   sSql                     ge_errores_pg.vQuery;
   LV_des_region			ge_regiones.des_region%TYPE;


BEGIN
      SN_cod_retorno := '0';
      SN_num_evento  :=  0;
 	  LV_des_region:=NULL;
	  sSql:='SELECT DES_REGION into LV_des_region FROM GE_REGIONES WHERE COD_REGION='||EV_cod_region;
	  SELECT  DES_REGION INTO LV_des_region
		FROM  GE_REGIONES
	   WHERE COD_REGION=EV_cod_region;

       RETURN TRUE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := '304';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END IF;
      V_des_error := SUBSTR('no_data_found: ge_valida_region_fn('||EV_cod_region||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento :=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_region_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
WHEN OTHERS THEN
      SN_cod_retorno := '304';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END IF;
      V_des_error := SUBSTR('others: ge_valida_region_fn('||EV_cod_region||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento :=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_region_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END ge_valida_region_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_provincia_fn (
   EV_cod_provincia  IN           ge_provincias.cod_provincia%TYPE,
   SN_cod_retorno    OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno   OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento     OUT NOCOPY   ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_valida_provincia_fn "
      Lenguaje="PL/SQL"
      Fecha="03-05-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Valida que exista provincia consultada</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_provincia" Tipo="CARACTER">codigo de provincia</param>
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
RETURN BOOLEAN
AS
   V_des_error              ge_errores_pg.DesEvent;
   sSql                     ge_errores_pg.vQuery;
   LV_cod_region		ge_provincias.cod_region%TYPE;


BEGIN
       SN_cod_retorno := '0';
       SN_num_evento  :=  0;
 	   LV_cod_region:=NULL;
	   sSql:='SELECT COD_REGION into LV_cod_region FROM GE_PROVINCIAS WHERE COD_PROVINCIA='||EV_cod_provincia;
	   SELECT  COD_REGION INTO LV_cod_region
	     FROM  GE_PROVINCIAS
	    WHERE COD_PROVINCIA=EV_cod_provincia;

       RETURN TRUE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := '305';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END IF;
      V_des_error := SUBSTR('no_data_found: ge_valida_provincia_fn('||EV_cod_provincia||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento :=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_provincia_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
WHEN TOO_MANY_ROWS THEN
       RETURN TRUE;
WHEN OTHERS THEN
      SN_cod_retorno := '305';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END IF;
      V_des_error := SUBSTR('others: ge_valida_provincia_fn('||EV_cod_provincia||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento :=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_provincia_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END ge_valida_provincia_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_comuna_fn (
   EV_cod_comuna    IN          ge_comunas.cod_comuna%TYPE,
   SN_cod_retorno   OUT NOCOPY  ge_errores_pg.CodError,
   SV_mens_retorno  OUT NOCOPY  ge_errores_pg.MsgError,
   SN_num_evento    OUT NOCOPY  ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_valida_comuna_fn""
      Lenguaje="PL/SQL"
      Fecha="03-05-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Valida que exista comuna consultada</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_comuna" Tipo="CARACTER">codigo de comuna</param>
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
RETURN BOOLEAN
AS
   V_des_error              ge_errores_pg.DesEvent;
   sSql                     ge_errores_pg.vQuery;
   LV_cod_provincia			ge_comunas.cod_provincia%TYPE;


BEGIN
      SN_cod_retorno := '0';
      SN_num_evento  :=  0;
 	  LV_cod_provincia:=NULL;
	  sSql:='SELECT COD_PROVINCIA into LV_cod_provincia FROM GE_COMUNAS WHERE COD_COMUNA='||EV_cod_comuna;
      SELECT  COD_PROVINCIA INTO LV_cod_provincia
       FROM  GE_COMUNAS
	   WHERE COD_COMUNA=EV_cod_comuna;
       RETURN TRUE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := '307';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END IF;
      V_des_error := SUBSTR('no_data_found: ge_valida_comuna_fn('||EV_cod_comuna||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento :=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_comuna_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
WHEN OTHERS THEN
      SN_cod_retorno := '307';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END IF;
      V_des_error := SUBSTR('others: ge_valida_comuna_fn('||EV_cod_comuna||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento :=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_comuna_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END ge_valida_comuna_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_ciudad_fn (
   EV_cod_ciudad    IN           ge_ciudades.cod_ciudad%TYPE,
   SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_valida_ciudad_fn""
      Lenguaje="PL/SQL"
      Fecha="03-05-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Valida que exista ciudad consultada</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_ciudad" Tipo="CARACTER">codigo de ciudad</param>
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
RETURN BOOLEAN
AS
   V_des_error              ge_errores_pg.DesEvent;
   sSql                     ge_errores_pg.vQuery;
   LV_cod_provincia			ge_ciudades.cod_provincia%TYPE;


BEGIN
          SN_cod_retorno := '0';
	      SN_num_evento  :=  0;
		  LV_cod_provincia:=NULL;
		  sSql:='SELECT COD_PROVINCIA into LV_cod_provincia FROM GE_CIUDADES WHERE COD_CIUDAD='||EV_cod_ciudad;
		     SELECT  COD_PROVINCIA INTO LV_cod_provincia
		       FROM  GE_CIUDADES
			   WHERE COD_CIUDAD=EV_cod_ciudad;
		           RETURN TRUE; --XO-200509150675 - 167/09/2005  - JJR.-

EXCEPTION
WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := '320';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END IF;
      V_des_error := SUBSTR('no_data_found: ge_valida_ciudad_fn('||EV_cod_ciudad||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento :=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_ciudad_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
WHEN TOO_MANY_ROWS THEN
       RETURN TRUE;
WHEN OTHERS THEN
      SN_cod_retorno := '320';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END IF;
      V_des_error := SUBSTR('others: ge_valida_ciudad_fn('||EV_cod_ciudad||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento :=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_ciudad_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END ge_valida_ciudad_fn;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_ident_cuenta_fn (
   EV_cod_tipident    IN  		   ge_clientes.cod_tipident%TYPE,
   EV_num_ident       IN  		   ge_clientes.num_ident%TYPE,
   SN_cod_cuenta	  OUT NOCOPY   GA_CUENTAS.cod_cuenta%TYPE,
   SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_valida_ident_cuenta_fn"
      Lenguaje="PL/SQL"
      Fecha="06-04-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Valida que exista alguna identificacion en la ga_cuentas</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_tipident" Tipo="CARACTER">Codigo tipo de identificacion</param>
            <param nom="EV_num_ident" Tipo="CARACTER">Numero de identificacion</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_cuenta"       Tipo="NUMERICO">Codigo de la cuenta asociada</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
   V_des_error              ge_errores_pg.DesEvent;
   sSql                     ge_errores_pg.vQuery;
   V_val_parametro          ged_parametros.val_parametro%TYPE;
   existeabonado		    BOOLEAN;
   LN_cod_cliente           ga_abocel.cod_cliente%TYPE;

BEGIN
   sSql := ' SELECT cuentas.cod_cuenta ';
   sSql := sSql || ' FROM ga_cuentas cuentas';
   sSql := sSql || ' WHERE cuentas.cod_tipident='||EV_cod_tipident;
   sSql := sSql || ' AND cuentas.num_ident='||EV_num_ident;

   SN_cod_retorno := '0';
   SN_num_evento  := 0;
   SN_cod_cuenta:=NULL;

   SELECT cuentas.cod_cuenta INTO SN_cod_cuenta
	 FROM GA_CUENTAS cuentas
    WHERE cuentas.cod_tipident=EV_cod_tipident
	  AND cuentas.num_ident=EV_num_ident;

   RETURN TRUE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
      RETURN  FALSE;
WHEN OTHERS THEN
      SN_cod_retorno := '302';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := SUBSTR('others: ge_valida_ident_cuenta_fn('||EV_cod_tipident||','||EV_num_ident||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_ident_cuenta_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END ge_valida_ident_cuenta_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_obtiene_ciclofact_fn (EN_cod_ciclo     IN         ga_abocel.cod_ciclo%TYPE,
		 					   SN_cod_ciclfact  OUT NOCOPY fa_ciclfact.cod_ciclfact%TYPE,
							   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
   							   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
   							   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_obtiene_ciclofact_fn"
	  Lenguaje="PL/SQL"
      Fecha="09-05-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtener fa_ciclfact de un ciclo</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_ciclo" Tipo="NUMERICO">Codigo del ciclo</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_ciclfact" Tipo="NUMERICO">Codigo ciclo de facturación</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>

         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
V_des_error   ge_errores_pg.DesEvent;
sSql          ge_errores_pg.vQuery;
BEGIN
	 SN_cod_retorno := '0';
     SN_num_evento  := 0;
	 SN_cod_ciclfact:=0;

	 sSql:=' SELECT  A.COD_CICLFACT '||
		   ' FROM  FA_CICLFACT A '||
		   ' WHERE  A.COD_CICLO='||EN_COD_CICLO||
		   ' AND  SYSDATE BETWEEN A.FEC_DESDELLAM AND A.FEC_HASTALLAM';

	   SELECT  A.COD_CICLFACT
		 INTO  SN_cod_ciclfact
		 FROM  FA_CICLFACT A
		WHERE  A.COD_CICLO=EN_COD_CICLO
		  AND  SYSDATE BETWEEN A.FEC_DESDELLAM AND  A.FEC_HASTALLAM;
	   RETURN TRUE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := '310';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := substr('no_data_found: ge_obtiene_ciclofact_fn ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_obtiene_ciclofact_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
WHEN OTHERS THEN
      SN_cod_retorno := '302';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := substr('others: ge_obtiene_ciclofact_fn ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_obtiene_ciclofact_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END ge_obtiene_ciclofact_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_obtiene_codcen_fn (
   EN_num_abonado     IN           ga_abocel.num_abonado%TYPE,
   SN_cod_central	  OUT NOCOPY   ga_abocel.cod_central%TYPE,
   SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_obtiene_codcen_fn"
	  Lenguaje="PL/SQL"
      Fecha="18-05-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtener codigo de central de abonado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero de abonado</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_central" Tipo="NUMERICO">Codigo de la central</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>

         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
V_des_error   ge_errores_pg.DesEvent;
sSql          ge_errores_pg.vQuery;
BEGIN
	 SN_cod_retorno := '0';
     SN_num_evento  := 0;
	 SN_cod_central:=0;

	 sSql:='SELECT  a.cod_central '||
		   ' FROM  GA_ABOCEL a '||
		   ' WHERE  a.num_abonado='||EN_num_abonado||
		   ' UNION '||
	   	   ' SELECT  a.cod_central '||
		   ' FROM  GA_ABOAMIST a '||
		   ' WHERE  a.num_abonado='||EN_num_abonado;


	   SELECT  a.cod_central
		 INTO  SN_cod_central
		 FROM  GA_ABOCEL a
		WHERE  a.num_abonado=EN_num_abonado
		UNION
	   SELECT  a.cod_central
		 FROM  GA_ABOAMIST a
		WHERE  a.num_abonado=EN_num_abonado;

	   RETURN TRUE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := '302';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := substr('no_data_found: ge_obtiene_codcen_fn('||EN_num_abonado||')'|| SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'ge_obtiene_codcen_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
WHEN OTHERS THEN
      SN_cod_retorno := '302';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := substr('others: ge_obtiene_codcen_fn('||EN_num_abonado||')'|| SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'ge_obtiene_codcen_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END ge_obtiene_codcen_fn;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_tipdir_fn (
   EV_cod_tipdir      IN  ge_tipdireccion.cod_tipdireccion%TYPE,
   SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_valida_tipdir_fn"
      Lenguaje="PL/SQL"
      Fecha="02-06-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Valida que exista codigo de tipo de dirección en la base de datos</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_tipdir" Tipo="CARACTER">Código del tipo de direccion a modificar</param>
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
RETURN BOOLEAN
AS
   V_des_error              ge_errores_pg.DesEvent;
   sSql                     ge_errores_pg.vQuery;
   V_val_parametro          ged_parametros.val_parametro%TYPE;
   existeabonado		    BOOLEAN;
   LV_des_tipdireccion      ge_tipdireccion.des_tipdireccion%TYPE;

BEGIN
   sSql := 'SELECT des_tipdireccion';
   sSql := sSql || ' FROM ge_tipdireccion  tipos_dir';
   sSql := sSql || ' WHERE tipos_dir.cod_tipdireccion=''' || EV_cod_tipdir ||'''';

   SN_cod_retorno := '0';
   SN_num_evento  := 0;
   LV_des_tipdireccion:=NULL;

   SELECT des_tipdireccion INTO LV_des_tipdireccion
	 FROM ge_tipdireccion  tipos_dir
    WHERE tipos_dir.cod_tipdireccion=EV_cod_tipdir;

   RETURN TRUE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := '313';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END IF;
      V_des_error := SUBSTR('no_data_found: ge_valida_tipdir_fn('||EV_cod_tipdir||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento :=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_tipdir_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
WHEN OTHERS THEN
      SN_cod_retorno := '313';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := SUBSTR('others: ge_valida_tipdir_fn('||EV_cod_tipdir||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_tipdir_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END ge_valida_tipdir_fn;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_icc_pend_celular_fn (
   EN_num_celular    IN           ga_abocel.num_celular%TYPE,
   SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_valida_icc_pend_celular_fn"
      Lenguaje="PL/SQL"
      Fecha="21-06-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Valida si el celular posee un movimiento pendiente </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
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
RETURN BOOLEAN
AS
   V_des_error              ge_errores_pg.DesEvent;
   sSql                     ge_errores_pg.vQuery;
   LN_num_movimiento        icc_movimiento.num_movimiento%TYPE;
BEGIN
   SN_cod_retorno:=0;
   SN_num_evento:=0;
   LN_num_movimiento:=NULL;

   sSql := 'SELECT NUM_MOVIMIENTO';
   sSql := sSql || ' FROM ICC_MOVIMIENTO ICC_MOV';
   sSql := sSql || ' WHERE ICC_MOV.NUM_CELULAR='|| EN_num_celular;

   SELECT NUM_MOVIMIENTO INTO LN_num_movimiento
   FROM ICC_MOVIMIENTO ICC_MOV
   WHERE ICC_MOV.NUM_CELULAR=EN_num_celular;
   RETURN TRUE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
      RETURN  FALSE;
WHEN OTHERS THEN
      SN_cod_retorno := '316';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := SUBSTR('others: ge_valida_icc_pend_celular_fn('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'ge_valida_icc_pend_celular_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END ge_valida_icc_pend_celular_fn;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ge_valida_existe_usuamist_fn (
   EN_num_abonado     IN           ga_abocel.num_abonado%TYPE,
   SN_cod_usuario     OUT NOCOPY   ga_usuamist.cod_usuario%TYPE,
   SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_valida_existe_usuamist_fn"
      Lenguaje="PL/SQL"
      Fecha="21-06-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Valida si para el abonado existe un usuario asociado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero de abonado</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_usuario"       Tipo="NUMERICO">Codigo de usuario</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
   V_des_error              ge_errores_pg.DesEvent;
   sSql                     ge_errores_pg.vQuery;
BEGIN
   SN_cod_retorno:=0;
   SN_num_evento:=0;
   SN_cod_usuario:=NULL;

   sSql:='SELECT  COD_USUARIO FROM GA_USUAMIST usuario '||
   		 ' WHERE usuario.num_abonado='||EN_num_abonado;


   SELECT COD_USUARIO INTO SN_cod_usuario
   FROM GA_USUAMIST usuario
   WHERE usuario.num_abonado=EN_num_abonado;
   RETURN TRUE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
      RETURN  FALSE;
WHEN OTHERS THEN
      SN_cod_retorno := '302';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := SUBSTR('others: ge_valida_existe_usuamist_fn('||EN_num_abonado||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'ge_valida_existe_usuamist_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END ge_valida_existe_usuamist_fn;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END  GE_VALIDACIONES_PG;
/
SHOW ERRORS
