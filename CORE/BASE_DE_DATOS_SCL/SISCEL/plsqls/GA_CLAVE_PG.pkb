CREATE OR REPLACE PACKAGE BODY        ga_clave_pg

AS

-----------------------------------------------------------------------------------------------------
FUNCTION ga_valida_clave_fn(EV_clave          IN VARCHAR2,
                            SN_cod_retorno    OUT NOCOPY NUMBER,
                            SV_mens_retorno   OUT NOCOPY VARCHAR2,
                            SN_num_evento     OUT NOCOPY NUMBER
                           ) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_VALIDA_CLAVE_FN"
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador="Carlos Navarro - Marcelo Godoy"
      Programador="Carlos Navarro - Marcelo Godoy"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Validacion de clave</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_clave" Tipo="CARACTER">clave a validar</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

   LV_des_error 		ge_errores_pg.DesEvent;
   LV_sSql        		ge_errores_pg.vQuery;
   Numero               NUMBER;
   error_clave          EXCEPTION;
BEGIN
   SN_num_evento   := 0;
   SN_cod_retorno  := 0;
   SV_mens_retorno := '';

   IF LENGTH(TRIM(EV_clave)) < 4 THEN
      RAISE error_clave;
   END IF;

   Numero := TO_NUMBER(EV_clave);

   RETURN TRUE;

   EXCEPTION
      WHEN error_clave THEN
	 	  SN_cod_retorno := 1151;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
		  LV_des_error := 'ga_valida_clave_fn('||EV_clave||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_valida_clave_fn', LV_sSql, SN_cod_retorno, LV_des_error);
          RETURN FALSE;

      WHEN OTHERS THEN
	 	  SN_cod_retorno := 1151;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
		  LV_des_error := 'ga_valida_clave_fn('||EV_clave||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_valida_clave_fn', LV_sSql, SN_cod_retorno, LV_des_error);
          RETURN FALSE;

END ga_valida_clave_fn;

-----------------------------------------------------------------------------------------------------

FUNCTION ga_obtiene_descodigo_fn( EV_cod_modulo  IN VARCHAR2,
                               EV_nom_tabla      IN VARCHAR2,
                               EV_nom_columna    IN VARCHAR2,
                               EV_cod_valor      IN VARCHAR2,
                               SV_des_codigo     OUT NOCOPY VARCHAR2,
                               SN_cod_retorno    OUT NOCOPY NUMBER,
                               SV_mens_retorno   OUT NOCOPY VARCHAR2,
                               SN_num_evento     OUT NOCOPY NUMBER ) RETURN BOOLEAN
IS
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_OBTIENE_DESCODIGO_FN"
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Diego Mejías Z."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar los atributos mas comunmente consultados del abonado COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_modulo" Tipo="CARACTER">Modulo</param>
			<param nom="EV_nom_tabla" 	Tipo="CARACTER">Tabla</param>
			<param nom="EV_nom_columna" Tipo="CARACTER">Columna</param>
			<param nom="EV_cod_valor" 	Tipo="CARACTER">Codigo</param>
         </Entrada>
         <Salida>
            <param nom="SV_des_codigo"     Tipo="CARACTER">Descripcion codigo</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
LV_des_error 		ge_errores_pg.DesEvent;
LV_sSql        		ge_errores_pg.vQuery;

BEGIN
   SN_num_evento   := 0;
   SN_cod_retorno  := 0;
   SV_mens_retorno := '';

   LV_sSql := '   SELECT des_valor ';
   LV_sSql := LV_sSql||' FROM ged_codigos';
   LV_sSql := LV_sSql||' WHERE cod_modulo = '||EV_cod_modulo;
   LV_sSql := LV_sSql||'   AND nom_tabla  = '||EV_nom_tabla;
   LV_sSql := LV_sSql||'   AND nom_columna= '||EV_nom_columna;
   LV_sSql := LV_sSql||'   AND cod_valor  = '||EV_cod_valor;

   SELECT gc.des_valor
     INTO SV_des_codigo
     FROM ged_codigos gc
    WHERE gc.cod_modulo  = EV_cod_modulo
      AND gc.nom_tabla   = EV_nom_tabla
      AND gc.nom_columna = EV_nom_columna
      AND gc.cod_valor   = EV_cod_valor;
   RETURN TRUE;

   EXCEPTION
      WHEN OTHERS THEN
	 	  SN_cod_retorno := 282;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
		  LV_des_error := 'ga_obtiene_descodigo('||EV_nom_columna||',SN_cod_retorno='||SN_cod_retorno||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_desbloqueo_clave_pr', LV_sSql, SN_cod_retorno, LV_des_error);
          RETURN FALSE;

END ga_obtiene_descodigo_fn;

-----------------------------------------------------------------------------------------------------
PROCEDURE ga_modifica_abonado_pr (EV_clave        IN ga_abocel.cod_password%TYPE,
                                  EN_num_abonado  IN ga_abocel.num_abonado%TYPE,
                                  EV_cod_tipmodi  IN ga_modabocel.cod_tipmodi%TYPE,
                                  EV_tip_terminal IN ga_abocel.tip_terminal%TYPE,
                                  EV_serie        IN ga_abocel.num_serie%TYPE,
                                  EV_numseriehex  IN ga_abocel.num_seriehex%TYPE,
                                  EV_seriemec     IN ga_abocel.num_seriemec%TYPE,
                                  EV_tipo_abonado IN VARCHAR2,
                                  SN_cod_retorno  OUT NOCOPY   ge_errores_pg.CodError,
                                  SV_mens_retorno OUT NOCOPY   ge_errores_pg.MsgError,
                                  SN_num_evento   OUT NOCOPY   ge_errores_pg.Evento
                                  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_MODIFICA_ABONADO_PR"
      Lenguaje="PL/SQL"
      Fecha="27-04-2005"
      Versión="1.0"
      Diseñador="Diego Mejias"
      Programador="Karem Fernandez"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio que actualiza clave del abonado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_clave"               Tipo="CARACTER">Nueva Contraseña web del abonado</param>
            <param nom="EN_num_abonado"     Tipo="NUMERICO">Secuencia nro del abonado</param>
            <param nom="EV_cod_tipmodi"    Tipo="CARACTER">Tipo de modIFicacion</param>
            <param nom="EV_tip_terminal"    Tipo="CARACTER">Tipo de terminal</param>
            <param nom="EV_serie"           Tipo="CARACTER">Numero de serie decimal</param>
            <param nom="EV_numseriehex"    Tipo="CARACTER">Numero de serie hexadecimal</param>
            <param nom="EV_seriemec"    Tipo="CARACTER">Numero de serie mecanico</param>
            <param nom="EV_tipo_abonado"    Tipo="CARACTER">Tipo de Abonado PREPAGO, POSTPAGO</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   LV_des_error ge_errores_pg.DesEvent;
   LV_sSql      ge_errores_pg.vQuery;
BEGIN
   SN_num_evento   := 0;
   SN_cod_retorno  := 0;
   SV_mens_retorno := '';

   -- 1.- Actualizar clave del abonado...
   --IF EV_tipo_abonado = CN_abonado_pospago THEN -- COL|45656|05-11-2007|SAQL
   IF EV_TIPO_ABONADO IN (CN_ABONADO_POSPAGO, CN_ABONADO_HIBRIDO) THEN -- COL|45656|05-11-2007|SAQL

      LV_sSql:='UPDATE ga_abocel SET cod_password='||EV_clave
             ||' WHERE num_abonado='||EN_num_abonado;

      UPDATE ga_abocel
         SET cod_password = EV_clave
       WHERE num_abonado = EN_num_abonado;

   ELSIF EV_tipo_abonado = cn_abonado_prepago THEN

      LV_sSql := 'UPDATE ga_aboamist SET cod_password='||EV_clave
              || ' WHERE num_abonado='||EN_num_abonado;

      UPDATE ga_aboamist
         SET cod_password = EV_clave
       WHERE num_abonado = EN_num_abonado;

   END IF;

   -- 2.- Insertar registro en modificaciones para abonado..
   LV_sSql := 'INSERT INTO ga_modabocel '
           || '(num_abonado,cod_tipmodi,fec_modifica, nom_usuarora,tip_terminal,num_serie,num_seriehex,num_seriemec) '
           || 'VALUES '
           || '('||EN_num_abonado||','||EV_cod_tipmodi||',SYSDATE,'||USER||','||EV_tip_terminal||','||EV_serie||','||EV_numseriehex||','
           ||EV_seriemec||')';

   INSERT INTO ga_modabocel
               (num_abonado, cod_tipmodi, fec_modifica, nom_usuarora, tip_terminal, num_serie, num_seriehex, num_seriemec)
        VALUES (en_num_abonado, ev_cod_tipmodi, SYSDATE, USER, ev_tip_terminal, ev_serie, ev_numseriehex, ev_seriemec);

   EXCEPTION
      WHEN OTHERS  THEN
         SN_cod_retorno := 302;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasIF;
         END IF;
         LV_des_error := SUBSTR('ga_modifica_abonado_pr('||EV_clave||','||EN_num_abonado||','||EV_cod_tipmodi||','
                        ||EV_tip_terminal||','||EV_serie||','||EV_numseriehex||','||EV_seriemec||'); - ' || SQLERRM,1,CN_largoerrtec);
         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
         SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ABONADOS_PG.GA_MODIFICA_ABONADO_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END ga_modifica_abonado_pr;

-----------------------------------------------------------------------------------------------------
PROCEDURE ga_cambio_clave_pr(
		  				  EN_num_celular  IN  NUMBER,
						  EV_clave		  IN  VARCHAR2,
						  EV_clave_new	  IN  VARCHAR2,
						  SN_cod_retorno  OUT NOCOPY NUMBER,
						  SV_mens_retorno OUT NOCOPY VARCHAR2,
						  SN_num_evento   OUT NOCOPY NUMBER
		  				 )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CAMBIO_CLAVE_PR"
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Diego Mejías Z."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar los atributos mas comunmente consultados del abonado COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
			<param nom="EV_clave" 		Tipo="NUMERICO">Clave actual del Abonado</param>
			<param nom="EV_clave_new" 	Tipo="NUMERICO">Nueva clave del Abonado</param>
         </Entrada>
         <Salida>
            ram>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
   LV_cod_grupo          al_tecnologia.cod_grupo%TYPE;
   LV_val_grupo_gsm	     al_tecnologia.cod_grupo%TYPE;
   LN_cod_atencion       NUMBER(3):= 505;
   LV_cod_oficina        ge_oficinas.cod_oficina%TYPE;

   LV_des_error 		 ge_errores_pg.DesEvent;
   LV_sSql        		 ge_errores_pg.vQuery;
   
   --LV_Cod_Categoria        varchar2(10); reversa incidencia
   
   error_ejecucion	     EXCEPTION;
   error_clave_entrada   EXCEPTION;
   error_clave_nueva     EXCEPTION;
   error_parametros      EXCEPTION;
   error_clave_bloqueada EXCEPTION;
BEGIN
   SN_num_evento   := 0;
   SN_cod_retorno  := 0;
   SV_mens_retorno := '';

   IF EN_num_celular IS NULL OR EV_clave IS NULL OR EV_clave_new IS NULL THEN
      RAISE  error_parametros;
   END IF;


   IF NOT ga_valida_clave_fn(EV_clave_new, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE error_ejecucion;
   END IF;

   IF NOT ga_segmentacion_pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave,
					                       GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnología, GV_cod_perfil, GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei,
 					                       GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado, GN_cod_producto,
 					                       GV_nom_responsable, GV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE error_ejecucion;
   END IF;

   IF TO_NUMBER(GV_cod_clave) < 1 THEN
      RAISE  error_clave_bloqueada;
   END IF;

   IF GV_cod_clave  <> EV_clave THEN
      RAISE  error_clave_entrada;
   END IF;

   LV_sSql:='ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn('||GV_cod_tecnología||');';
   LV_cod_grupo:=ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(GV_cod_tecnología);

   IF TRIM(LV_cod_grupo)='ERROR' THEN
      RAISE  error_parametros;
   END IF;

	  	-- Coloca descripcion de acuerdo al tipo de Abonado 1=Prepago 2=Pospago 3=Hibrido --
   IF NOT ga_obtiene_descodigo_fn  ('GE','TA_PLANTARIF','COD_TIPLAN', GV_tip_abonado, GV_des_tipabonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE error_parametros;
   END IF;

		-- Obtiene descripcion de tecnologia del abonado --
   LV_val_grupo_gsm := ge_fn_devvalparam(CV_cod_modulo, CN_cod_producto, CV_param_grupo_gsm);
   IF LV_val_grupo_gsm = 'ERROR' THEN
      RAISE error_parametros;
   END IF;

   IF LV_cod_grupo = LV_val_grupo_gsm  THEN  --Si grupo tecnologico es GSM ....
      GV_num_serie    := GV_num_imei;
   END IF;

   -- Encargado de modificar clave
   ga_modifica_abonado_pr(EV_clave_new, GN_num_abonado, CV_cod_actuacion, GV_tip_terminal, GV_num_serie, GV_num_seriehex, GV_num_seriemec, GV_tip_abonado,
   					      SN_cod_retorno, SV_mens_retorno, SN_num_evento );
   IF SN_cod_retorno <> 0 THEN
       RAISE error_ejecucion;
   END IF;

   COMMIT;

EXCEPTION
   WHEN error_parametros THEN
      SN_cod_retorno := 98;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_cambio_clave_pr('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_cambio_clave_pr', LV_sSql, SN_cod_retorno, LV_des_error );
      ROLLBACK;

   WHEN error_clave_entrada THEN
      SN_cod_retorno := 1150;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_cambio_clave_pr('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_cambio_clave_pr', LV_sSql, SN_cod_retorno, LV_des_error );
      ROLLBACK;

   WHEN error_clave_nueva THEN
      SN_cod_retorno := 1151;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_cambio_clave_pr('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_cambio_clave_pr', LV_sSql, SN_cod_retorno, LV_des_error );
      ROLLBACK;

   WHEN error_clave_bloqueada THEN
      SN_cod_retorno := 1152;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_cambio_clave_pr('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_cambio_clave_pr', LV_sSql, SN_cod_retorno, LV_des_error );
      ROLLBACK;

   WHEN error_ejecucion THEN
      LV_des_error := 'ga_cambio_clave_pr('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_cambio_clave_pr', LV_sSql, SN_cod_retorno, LV_des_error );
      ROLLBACK;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_cambio_clave_pr('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_cambio_clave_pr', LV_sSql, SN_cod_retorno, LV_des_error );
      ROLLBACK;

END ga_cambio_clave_pr;

-----------------------------------------------------------------------------------------------------
PROCEDURE ga_bloqueo_clave_pr(
   	  		EN_num_celular  IN  NUMBER,
			EV_clave	    IN  VARCHAR2,
			SN_cod_retorno  OUT NOCOPY NUMBER,
			SV_mens_retorno OUT NOCOPY VARCHAR2,
			SN_num_evento  	OUT NOCOPY NUMBER )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_BLOQUEO_CLAVE_PR"
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Rubén Dagach"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que bloquear clave internet del abonado -- COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
			<param nom="EV_clave" 		Tipo="NUMERICO">Clave actual del Abonado</param>
         </Entrada>
         <Salida>
            ram>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
   LV_cod_grupo         al_tecnologia.cod_grupo%TYPE;
   LV_val_grupo_gsm	    al_tecnologia.cod_grupo%TYPE;
   LV_cod_oficina       ge_oficinas.cod_oficina%TYPE;
   LN_cod_atencion      NUMBER(3) := 506;

   --LV_Cod_Categoria     varchar2(10); reversa incidencia
   
   LV_des_error 		ge_errores_pg.DesEvent;
   LV_sSql        		ge_errores_pg.vQuery;
   error_ejecucion	    EXCEPTION;
   error_clave_entrada  EXCEPTION;
   error_parametros     EXCEPTION;
   clave_bloqueada		EXCEPTION;
BEGIN
   SN_num_evento   := 0;
   SN_cod_retorno  := 0;
   SV_mens_retorno := '';

   IF EN_num_celular IS NULL OR TRIM(TO_CHAR(EV_clave)) =  '' OR EV_clave IS NULL THEN
      RAISE error_parametros;
   END IF;

   IF NOT ga_segmentacion_pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave,
					                       GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnología, GV_cod_perfil, GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei,
 					                       GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado, GN_cod_producto,
 					                       GV_nom_responsable, GV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE error_ejecucion;
   END IF;

   IF GV_cod_clave = CV_clave_bloqueada THEN
   	  RAISE clave_bloqueada;
   END IF;

   IF GV_cod_clave  <> EV_clave THEN
      RAISE  error_clave_entrada;
   END IF;


   LV_sSql:='ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn('||GV_cod_tecnología||');';
   LV_cod_grupo:=GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(GV_cod_tecnología);

   IF TRIM(LV_cod_grupo)= 'ERROR' THEN
   	  SN_cod_retorno := 258;
      RAISE  error_ejecucion;
   END IF;

      -- Coloca descripcion de acuerdo al tipo de Abonado 1=Prepago 2=Pospago 3=Hibrido --
   IF NOT ga_obtiene_descodigo_fn  ('GE','TA_PLANTARIF','COD_TIPLAN', GV_tip_abonado, GV_des_tipabonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE error_parametros;
   END IF;

	  -- Verifica tecnologia del abonado --
   LV_val_grupo_gsm := ge_fn_devvalparam(CV_cod_modulo, CN_cod_producto, CV_param_grupo_gsm);
   IF LV_val_grupo_gsm = 'ERROR' THEN
   	  SN_cod_retorno := 258;
      RAISE error_parametros;
   END IF;

   IF LV_cod_grupo = LV_val_grupo_gsm  THEN  --Si grupo tecnologico es GSM ....
      GV_num_serie    := GV_num_imei;
   END IF;

	 -- Package y procedimiento encargados de modificar clave
   ga_modifica_abonado_pr(CV_clave_bloqueada, GN_num_abonado, CV_cod_actuacion, GV_tip_terminal, GV_num_serie, GV_num_seriehex, GV_num_seriemec, GV_tip_abonado,
						  SN_cod_retorno, SV_mens_retorno, SN_num_evento );
   IF SN_cod_retorno <> 0 THEN
      RAISE error_ejecucion;
   END IF;

   COMMIT;

EXCEPTION

   WHEN error_parametros THEN
      SN_cod_retorno := 98;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_bloqueo_clave_pr('||EN_num_celular||','||EV_clave||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_clave_pg.ga_bloqueo_clave_pr', LV_sSql, SN_cod_retorno, LV_des_error );
      ROLLBACK;

   WHEN error_clave_entrada THEN
      SN_cod_retorno := 1150;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_bloqueo_clave_pr('||EN_num_celular||','||EV_clave||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_bloqueo_clave_pr', LV_sSql, SN_cod_retorno, LV_des_error );
      ROLLBACK;

   WHEN error_ejecucion THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_bloqueo_clave_pr('||EN_num_celular||','||EV_clave||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_bloqueo_clave_pr', LV_sSql, SN_cod_retorno, LV_des_error );
      ROLLBACK;

   WHEN clave_bloqueada THEN
      SN_cod_retorno := 1152;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_bloqueo_clave_pr('||EN_num_celular||','||EV_clave||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_bloqueo_clave_pr', LV_sSql, SN_cod_retorno, LV_des_error );
      ROLLBACK;

   WHEN OTHERS THEN
      SN_cod_retorno := 302;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_bloqueo_clave_pr('||EN_num_celular||','||EV_clave||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_bloqueo_clave_pr', LV_sSql, SN_cod_retorno, LV_des_error );
      ROLLBACK;

END ga_bloqueo_clave_pr;

-----------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_clave_pr (
				        EN_num_celular    IN  NUMBER,
						SN_clave	      OUT NOCOPY NUMBER,
						SV_tip_tarifario  OUT NOCOPY VARCHAR2,
						SN_estado_cliente OUT NOCOPY NUMBER,
						SN_ind_prepago    OUT NOCOPY NUMBER,
						SN_cod_retorno    OUT NOCOPY NUMBER,
						SV_mens_retorno   OUT NOCOPY VARCHAR2,
						SN_num_evento  	  OUT NOCOPY NUMBER )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GGA_CONSULTA_CLAVE_PR"
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Rubén Dagach"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite consultar clave internet del abonado --- COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            ram>
			<param nom="SN_clave"     		Tipo="NUMERICO">Clave del abonado</param>
            <param nom="SV_tip_tarifario"   Tipo="CARACTER">Plan tarifario</param>
            <param nom="SN_estado_cliente"  Tipo="NUMERICO>Estado del Cliente</param>
            <param nom="SN_ind_prepago"     Tipo="NUMERICO">Indicador prepago</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

 IS
   LV_cod_grupo       al_tecnologia.cod_grupo%TYPE;
   LV_val_grupo_gsm	al_tecnologia.cod_grupo%TYPE;
   LN_cod_atencion    NUMBER(3) := 508;
   LV_cod_oficina     ge_oficinas.cod_oficina%TYPE;
   
   --LV_Cod_Categoria   varchar2(10); reversa incidencia 

   LV_des_error 		ge_errores_pg.DesEvent;
   LV_sSql        	ge_errores_pg.vQuery;
   error_ejecucion	EXCEPTION;
   error_parametros	EXCEPTION;
   error_clave_bloqueada EXCEPTION; -- XO-200510050803 - 07/10/2005 - jjr.-
BEGIN
   SN_num_evento   := 0;
   SN_cod_retorno  := 0;
   SV_mens_retorno := '';
   SN_estado_cliente:=0;

   IF EN_num_celular IS NULL THEN
      RAISE error_parametros;
   END IF;

   IF NOT ga_segmentacion_pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave,
					                       GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnología, GV_cod_perfil, GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei,
 					                       GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado, GN_cod_producto,
 					                       GV_nom_responsable, GV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE error_ejecucion;
   END IF;

   SN_estado_cliente:=1;

-- inicio XO-200510050803 - 07/10/2005 - jjr.-

   IF TO_NUMBER(GV_cod_clave) < 1 THEN
      RAISE  error_clave_bloqueada;
   END IF;
-- Fin XO-200510050803 - 07/10/2005 - jjr.-

   LV_sSql:='ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn('||GV_cod_tecnología||');';
   LV_cod_grupo:=GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(GV_cod_tecnología);
   IF TRIM(LV_cod_grupo)= 'ERROR' THEN
 	  RAISE  error_ejecucion;
   END IF;

  	  -- Coloca descripcion de acuerdo al tipo de Abonado 1=Prepago 2=Pospago 3=Hibrido --
   IF NOT ga_obtiene_descodigo_fn  ('GE','TA_PLANTARIF','COD_TIPLAN', GV_tip_abonado, GV_des_tipabonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE error_parametros;
   END IF;

	  -- Verifica tecnologia del abonado --
   LV_val_grupo_gsm := ge_fn_devvalparam(CV_cod_modulo, CN_cod_producto, CV_param_grupo_gsm);
   IF LV_val_grupo_gsm = 'ERROR' THEN
      RAISE error_parametros;
   END IF;

   IF LV_cod_grupo = LV_val_grupo_gsm  THEN  --Si grupo tecnologico es GSM ....
      GV_num_serie    := GV_num_imei;
   END IF;

	  -- Retorno de valores
   SN_clave:=GV_cod_clave;
   SV_tip_tarifario:=GV_tip_plantarif;

      -- Colocamos descripcion de acuerdo al tipo de Abonado 1=Prepago 2=Pospago
   IF CN_abonado_prepago = TO_NUMBER(GV_tip_abonado) THEN
      SN_ind_prepago :=1;   -- prepago
   ELSE
      SN_ind_prepago :=0;   -- pospago
   END IF;

EXCEPTION
   WHEN error_parametros THEN
      SN_cod_retorno := 98;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_consulta_clave_pr('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_consulta_clave_pr', LV_sSql, SN_cod_retorno, LV_des_error );

   WHEN error_ejecucion THEN
      LV_des_error := 'ga_consulta_clave_pr('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_consulta_clave_pr', LV_sSql, SN_cod_retorno, LV_des_error );

-- inicio XO-200510050803 - 07/10/2005 - jjr.-
   WHEN error_clave_bloqueada THEN
      SN_cod_retorno := 1152;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_consulta_clave_pr('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_cambio_clave_pr', LV_sSql, SN_cod_retorno, LV_des_error );
-- Fin XO-200510050803 - 07/10/2005 - jjr.-

   WHEN OTHERS THEN
      SN_cod_retorno := 302;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_consulta_clave_pr', LV_sSql, SN_cod_retorno, LV_des_error );
      LV_des_error := 'ga_consulta_clave_pr('||EN_num_celular||'); - ' || SQLERRM;

END ga_consulta_clave_pr;

-----------------------------------------------------------------------------------------------------
PROCEDURE ga_desbloqueo_clave_pr (
			        EN_num_celular  IN  NUMBER,
					EV_clave 		IN VARCHAR2,
					SN_cod_retorno  OUT NOCOPY NUMBER,
					SV_mens_retorno OUT NOCOPY VARCHAR2,
					SN_num_evento  	OUT NOCOPY NUMBER )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_DESBLOQUEO_CLAVE_PR"
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Rubén Dagach"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite desbloquear clave internet del abonado -- COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
			<param nom="EV_clave" 		Tipo="NUMERICO">Clave actual del Abonado</param>
         </Entrada>
         <Salida>
            ram>
			<param nom="SN_clave_ori" 	    Tipo="NUMERICO">Nueva clave del Abonado</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

 IS
   LV_cod_grupo       al_tecnologia.cod_grupo%TYPE;
   LV_val_grupo_gsm	  al_tecnologia.cod_grupo%TYPE;
   LN_cod_atencion    NUMBER(3) := 507;
   LV_cod_oficina     ge_oficinas.cod_oficina%TYPE;
   LN_clave_ori		  ga_abocel.COD_PASSWORD%TYPE;
   
   --LV_Cod_Categoria   varchar2(10); reversa incidencia

   V_des_error 		  ge_errores_pg.DesEvent;
   LV_sSql        	  ge_errores_pg.vQuery;
   error_ejecucion	  EXCEPTION;
   error_parametros	  EXCEPTION;
   clave_no_bloqueada EXCEPTION;
BEGIN
   SN_num_evento   := 0;
   SN_cod_retorno  := 0;
   SV_mens_retorno := '';

   IF EN_num_celular IS NULL OR TRIM(TO_CHAR(EV_clave)) =  '' OR EV_clave IS NULL THEN
      RAISE error_parametros;
   END IF;

   IF NOT ga_segmentacion_pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave,
					                       GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnología, GV_cod_perfil, GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei,
 					                       GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado, GN_cod_producto,
 					                       GV_nom_responsable, GV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE error_ejecucion;
   END IF;

   IF GV_cod_clave <> CV_clave_bloqueada THEN
   	  RAISE clave_no_bloqueada;
   END IF;

   LV_sSql:='ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn('||GV_cod_tecnología||');';
   LV_cod_grupo:=ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(GV_cod_tecnología);
   IF TRIM(LV_cod_grupo)= 'ERROR' THEN
      RAISE  error_ejecucion;
   END IF;

 	  -- Coloca descripcion de acuerdo al tipo de Abonado 1=Prepago 2=Pospago 3=Hibrido --
   IF NOT ga_obtiene_descodigo_fn  ('GE','TA_PLANTARIF','COD_TIPLAN', GV_tip_abonado, GV_des_tipabonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE error_parametros;
   END IF;

  -- Verifica tecnologia del abonado --
   LV_val_grupo_gsm := ge_fn_devvalparam(CV_cod_modulo, CN_cod_producto, CV_param_grupo_gsm);
   IF LV_val_grupo_gsm = 'ERROR' THEN
	  RAISE error_parametros;
   END IF;

   IF LV_cod_grupo = LV_val_grupo_gsm  THEN  --Si grupo tecnologico es GSM ....
      GV_num_serie    := GV_num_imei;
      LN_clave_ori :=SUBSTR(GV_num_imei,LENGTH(GV_num_imei)-3,4); -- sacar los ultimos 4 digitos
   ELSE
      LN_clave_ori:=SUBSTR(GV_num_serie,LENGTH(GV_num_serie)-3,4);
   END IF;


  -- Encargado de modificar clave
   ga_modifica_abonado_pr( LN_clave_ori, GN_num_abonado, CV_cod_actuacion, GV_tip_terminal, GV_num_serie, GV_num_seriehex, GV_num_seriemec, GV_tip_abonado,
	  					   SN_cod_retorno, SV_mens_retorno, SN_num_evento );
   IF SN_cod_retorno <> 0 THEN
      RAISE error_ejecucion;
   END IF;

   COMMIT;

EXCEPTION
   WHEN error_parametros THEN
      SN_cod_retorno := 98;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_desbloqueo_clave_p('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_desbloqueo_clave_p', LV_sSql, SN_cod_retorno, V_des_error );
      ROLLBACK;

   WHEN clave_no_bloqueada THEN
      SN_cod_retorno := 197;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_desbloqueo_clave_p('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_desbloqueo_clave_p', LV_sSql, SN_cod_retorno, V_des_error );
      ROLLBACK;

   WHEN error_ejecucion THEN
      V_des_error := 'ga_desbloqueo_clave_p('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_desbloqueo_clave_pr', LV_sSql, SN_cod_retorno, V_des_error );
      ROLLBACK;

   WHEN OTHERS THEN
      SN_cod_retorno := 302;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_desbloqueo_clave_p('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version, USER, 'ga_clave_pg.ga_desbloqueo_clave_pr', LV_sSql, SN_cod_retorno, V_des_error );
      ROLLBACK;

END ga_desbloqueo_clave_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ga_clave_pg;
/
SHOW ERRORS
