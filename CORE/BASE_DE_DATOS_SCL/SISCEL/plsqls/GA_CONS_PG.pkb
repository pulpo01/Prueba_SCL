CREATE OR REPLACE PACKAGE BODY GA_CONS_PG
IS

FUNCTION ga_valida_formato_fecha_FN (
   EV_formato_fec    IN      VARCHAR2,
   SN_cod_retorno     OUT NOCOPY  ge_errores_pg.CodError,
   SV_mens_retorno    OUT NOCOPY  ge_errores_pg.MsgError,
   SN_num_evento      OUT NOCOPY  ge_errores_pg.Evento

)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_VALIDA_FORMATO_FECHA_FN"
      Lenguaje="PL/SQL"
      Fecha creación="26-12-2004"
      Creado por="Carlos Navarro H. - Marcelo Godoy S."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Valida Formato de Fecha</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_formato_fec" Tipo="NUMERICO">Formato de Fecha</param>
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
   V_des_error  ge_errores_pg.DesEvent;
   sSql         ge_errores_pg.vQuery;
   V_fecha      DATE;

BEGIN

   SN_cod_retorno := '0';
   SN_num_evento  := 0;
   sSql := 'TO_DATE(TO_CHAR(sysdate, EV_formato_fec),EV_formato_fec)';
   V_fecha := TO_DATE(TO_CHAR(SYSDATE, EV_formato_fec),EV_formato_fec);
   RETURN TRUE;

EXCEPTION

   WHEN OTHERS THEN
      SN_cod_retorno := '143';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error :=SUBSTR('ga_valida_formato_fecha_fn('||EV_formato_fec||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'ga_valida_formato_fecha_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE;

END ga_valida_formato_fecha_fn;


FUNCTION ga_valida_existabonado_fn (
   EN_num_celular    IN          ga_abocel.num_celular%TYPE,
   SN_num_abonado    OUT NOCOPY  ga_abocel.num_abonado%TYPE,
   SN_cod_retorno    OUT NOCOPY  ge_errores_pg.CodError,
   SV_mens_retorno   OUT NOCOPY  ge_errores_pg.MsgError,
   SN_num_evento     OUT NOCOPY  ge_errores_pg.Evento,
   SV_comportamiento IN VARCHAR2 DEFAULT 'NO'

)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_VALIDA_EXISTABONADO_FN"
      Lenguaje="PL/SQL"
      Fecha creación="29-12-2004"
      Creado por="Carlos Navarro H. - Marcelo Godoy S."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Validar la existencia de un Abonado y que este no este en baja</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SN_num_abonado"     Tipo="NUMERICO">Numero de Abonado</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="NUMERICO">Numero de Evento</param>
            <param nom="SV_comportamiento"      Tipo="CARACTER">Comportamiento de la función</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
   RETURN BOOLEAN
AS
   CURSOR abonados_cu (EN_num_celular ga_abocel.num_celular%TYPE)
   IS
      SELECT   abo.cod_situacion, abo.fec_alta, abo.num_abonado
         FROM ga_aboamist abo
         WHERE num_celular = EN_num_celular
      UNION
      SELECT   abo.cod_situacion, abo.fec_alta, abo.num_abonado
         FROM ga_abocel abo
         WHERE num_celular = EN_num_celular
      ORDER BY fec_alta DESC;

   error_abonado_baja       EXCEPTION;
   error_no_abonado         EXCEPTION;
   error_parametro_celular  EXCEPTION;
   error_val_celular        EXCEPTION;
   regaboando               BOOLEAN;
   V_des_error              ge_errores_pg.DesEvent;
   sSql                     ge_errores_pg.vQuery;
   N_codretorno             ge_errores_td.cod_msgerror%TYPE;
   V_mens_retorno           ge_errores_td.det_msgerror%TYPE;
BEGIN

   SN_cod_retorno := '0';
   SN_num_evento  := 0;

   IF SV_comportamiento<>'NO' THEN
        sSql := 'SELECT abo.cod_situacion, abo.fec_alta, abo.num_abonado';
        sSql := sSql || ' FROM ga_aboamist abo';
        sSql := sSql || ' WHERE num_celular = ' || EN_num_celular;
        sSql := sSql || ' UNION';
        sSql := sSql || ' SELECT   abo.cod_situacion, abo.fec_alta, abo.num_abonado';
        sSql := sSql || ' FROM ga_abocel abo';
        sSql := sSql || ' WHERE num_celular = ' || EN_num_celular;
        sSql := sSql || ' ORDER BY fec_alta DESC;';

        regaboando := FALSE ;

        FOR abonados IN abonados_cu (EN_num_celular) LOOP
           regaboando := TRUE ;

           IF abonados.cod_situacion = CV_abonado_en_baja THEN
              RAISE error_abonado_baja;
           ELSE
              SN_num_abonado := abonados.num_abonado;
              SN_cod_retorno := 0;
              RETURN TRUE ;
              EXIT;
           END IF;
         END LOOP;

         IF NOT regaboando THEN
            RAISE error_no_abonado;
         END IF;
   ELSE
     IF EN_num_celular IS NULL THEN
        RAISE error_parametro_celular;
     END IF;

     IF ge_validaciones_pg.ge_valida_num_celular_fn(EN_num_celular, N_codretorno, V_mens_retorno, SN_num_evento) THEN
        sSql := 'SELECT abo.cod_situacion, abo.fec_alta, abo.num_abonado';
        sSql := sSql || ' FROM ga_aboamist abo';
        sSql := sSql || ' WHERE num_celular = ' || EN_num_celular;
        sSql := sSql || ' UNION';
        sSql := sSql || ' SELECT   abo.cod_situacion, abo.fec_alta, abo.num_abonado';
        sSql := sSql || ' FROM ga_abocel abo';
        sSql := sSql || ' WHERE num_celular = ' || EN_num_celular;
        sSql := sSql || ' ORDER BY fec_alta DESC;';
        regaboando := FALSE ;
        FOR abonados IN abonados_cu (EN_num_celular) LOOP
           regaboando := TRUE ;

           IF abonados.cod_situacion = CV_abonado_en_baja THEN
              RAISE error_abonado_baja;
           ELSE
              SN_num_abonado := abonados.num_abonado;
              SN_cod_retorno := 0;
              RETURN TRUE ;
              EXIT;
           END IF;
         END LOOP;
         IF NOT regaboando THEN
            RAISE error_no_abonado;
         END IF;
     ELSE
        RAISE error_val_celular;
     END IF;
   END IF;
EXCEPTION

   WHEN error_val_celular THEN
      SN_cod_retorno  := N_codretorno;
      SV_mens_retorno := V_mens_retorno;
      V_des_error := SUBSTR('ga_valida_existabonado_fn('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
  	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'ga_valida_existabonado_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE ;

   WHEN error_parametro_celular THEN
      SN_cod_retorno := '142';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := SUBSTR('ga_valida_existabonado_fn('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
  	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'ga_valida_existabonado_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE ;

   WHEN error_no_abonado THEN
      SN_cod_retorno := '144';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := SUBSTR('ga_valida_existabonado_fn('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
  	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'ga_valida_existabonado_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE ;

   WHEN error_abonado_baja THEN
      SN_cod_retorno := '146';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := SUBSTR('ga_valida_existabonado_fn('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
  	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'ga_valida_existabonado_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := '145';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := SUBSTR('ga_valida_existabonado_fn('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
  	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'ga_valida_existabonado_fn', sSql, SQLCODE, V_des_error );
      RETURN FALSE;

END ga_valida_existabonado_fn;


PROCEDURE ga_cons_facturas_pr (
      EN_num_celular   IN       ga_abocel.num_celular%TYPE,
      EV_formato_fec   IN       VARCHAR2,
      EN_cantfacturas  IN       NUMBER,
      SC_fact_clie     OUT NOCOPY      refcursor,
      SN_cod_retorno     OUT NOCOPY  ge_errores_pg.CodError,
      SV_mens_retorno    OUT NOCOPY  ge_errores_pg.MsgError,
      SN_num_evento      OUT NOCOPY  ge_errores_pg.Evento

)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONS_FACTURAS_PR"
      Lenguaje="PL/SQL"
      Fecha creación="26-12-2004"
      Creado por="Carlos Navarro H. - Marcelo Godoy S."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Mostrar 3 últimas facturas del cliente a partir del número celular</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
            <param nom="EV_formato_fec" Tipo="CARACTER">Formato Fecha y Hora</param>
         </Entrada>
         <Salida>
            <param nom="SC_fact_clie"       Tipo="Cursor">Cursor Facturas Clientes</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   error_abonado           EXCEPTION;
   error_parametro_celular EXCEPTION;
   error_parametro_fecha   EXCEPTION;
   error_formato_fecha     EXCEPTION;
   N_codretorno            ge_errores_td.cod_msgerror%TYPE;
   V_mens_retorno          ge_errores_td.det_msgerror%TYPE;
   LN_num_abonado          ga_abocel.num_abonado%TYPE;
   V_des_error             ge_errores_pg.DesEvent;
   sSql                    ge_errores_pg.vQuery;

BEGIN

   SN_cod_retorno := '0';
   SN_num_evento  := 0;
   N_codretorno    := '0';

   OPEN SC_fact_clie FOR
   SELECT NULL num_folio, NULL fec_emision, NULL fec_vencimiento, NULL fec_pago, NULL tot_pagar, NULL des_tipdocum, NULL estado
     FROM DUAL
   WHERE ROWNUM = 0;

   IF EN_num_celular IS NULL THEN
         RAISE error_parametro_celular;
   END IF;

   IF EV_formato_fec IS NULL THEN
         RAISE error_parametro_fecha;
   ELSE
      IF NOT ga_valida_formato_fecha_fn (EV_formato_fec, N_codretorno, V_mens_retorno, SN_num_evento) THEN
         RAISE error_formato_fecha;
      END IF;
	NULL;

   END IF;

   sSql :=SUBSTR('ga_valida_existabonado_fn('||EN_num_celular||'); - '||SQLERRM,1,CN_largoquery);

   IF  ga_valida_existabonado_fn (EN_num_celular, LN_num_abonado, N_codretorno, V_mens_retorno, SN_num_evento) THEN

       sSql :=SUBSTR('SELECT num_folio, TO_CHAR (fec_emision, ' || EV_formato_fec || ') AS fec_emision,'
               || ' TO_CHAR (fec_vencimie, ' || EV_formato_fec || ') AS fec_vencimiento,'
       		   || ' TO_CHAR (fec_pago, veformato) AS fec_pago, tot_pagar, des_tipdocum, estado'
       		   || ' FROM (SELECT   fahist.num_folio, fahist.fec_emision,'
       		   || ' fahist.fec_vencimie, cocan.fec_pago,'
       		   || ' fahist.tot_pagar, tipdoc.des_tipdocum,'
       		   || ' ''PAGADA'''
       		   || ' AS estado'
       		   || ' FROM fa_histdocu fahist,'
       		   || ' ga_abocel abo,'
       		   || ' co_cancelados cocan,'
       		   || ' ge_tipdocumen tipdoc'
       		   || ' WHERE fahist.cod_cliente = abo.cod_cliente'
       		   || ' AND abo.num_abonado = ' ||LN_num_abonado
       		   || ' AND fahist.num_secuenci = cocan.num_secuenci'
       		   || ' AND fahist.cod_tipdocum = cocan.cod_tipdocum'
       		   || ' AND fahist.cod_centremi = cocan.cod_centremi'
       		   || ' AND fahist.cod_vendedor_agente ='
	      	   || ' cocan.cod_vendedor_agente'
       		   || ' AND fahist.letra = cocan.letra'
       		   || ' AND fahist.cod_tipdocum = tipdoc.cod_tipdocum'
       		   || ' AND fahist.num_folio NOT IN ('
       		   || ' SELECT cocar.num_folio'
       		   || ' FROM co_cartera cocar'
       		   || ' WHERE cocar.num_folio = fahist.num_folio)'
       		   || ' UNION'
       		   || ' SELECT DISTINCT fahist.num_folio, fahist.fec_emision,'
       		   || ' fahist.fec_vencimie, cocar.fec_pago,'
       		   || ' fahist.tot_pagar, tipdoc.des_tipdocum,'
       		   ||' ''VENCIDA'''
       		   || ' AS estado'
       		   || ' FROM fa_histdocu fahist,'
       		   || ' ga_abocel abo,'
      		   || ' co_cartera cocar,'
       		   || ' ge_tipdocumen tipdoc'
       		   || ' WHERE fahist.cod_cliente = abo.cod_cliente'
       		   || ' AND abo.num_abonado = ' || LN_num_abonado
       		   || ' AND fahist.num_secuenci = cocar.num_secuenci'
       		   || ' AND fahist.cod_tipdocum = cocar.cod_tipdocum'
       		   || ' AND fahist.cod_centremi = cocar.cod_centremi'
      		   || ' AND fahist.cod_vendedor_agente ='
       		   || ' cocar.cod_vendedor_agente'
       		   || ' AND fahist.letra = cocar.letra'
       		   || ' AND fahist.cod_tipdocum = tipdoc.cod_tipdocum'
       		   || ' AND fahist.fec_vencimie < SYSDATE'
       		   || ' UNION'
       		   || ' SELECT DISTINCT fahist.num_folio, fahist.fec_emision,'
       		   || ' fahist.fec_vencimie, cocar.fec_pago,'
       		   || ' fahist.tot_pagar, tipdoc.des_tipdocum,'
       		   ||' ''VIGENTE'''
       		   || ' AS estado'
       		   || ' FROM fa_histdocu fahist,'
       		   || ' ga_abocel abo,'
       		   || ' co_cartera cocar,'
       		   || ' ge_tipdocumen tipdoc'
       		   || ' WHERE fahist.cod_cliente = abo.cod_cliente'
       		   || ' AND abo.num_abonado = ' || LN_num_abonado
       		 	|| ' AND fahist.num_secuenci = cocar.num_secuenci'
       			|| ' AND fahist.cod_tipdocum = cocar.cod_tipdocum'
       			|| ' AND fahist.cod_centremi = cocar.cod_centremi'
       			|| ' AND fahist.cod_vendedor_agente ='
       			|| ' cocar.cod_vendedor_agente'
       			|| ' AND fahist.letra = cocar.letra'
       			|| ' AND fahist.cod_tipdocum = tipdoc.cod_tipdocum'
       		|| ' AND fahist.fec_vencimie >= SYSDATE'
       		|| ' ORDER BY fec_emision DESC)'
       		|| ' WHERE ROWNUM <= '||EN_cantfacturas||'; - '||SQLERRM,1,CN_largoquery);

     CLOSE SC_fact_clie;
      OPEN SC_fact_clie FOR
         SELECT num_folio, TO_CHAR (fec_emision, EV_formato_fec) AS fec_emision,
                TO_CHAR (fec_vencimie, EV_formato_fec) AS fec_vencimiento,
                TO_CHAR (fec_pago, EV_formato_fec) AS fec_pago, tot_pagar, des_tipdocum, estado
           FROM (SELECT   fahist.num_folio, fahist.fec_emision,
                          fahist.fec_vencimie, cocan.fec_pago,
                          fahist.tot_pagar, tipdoc.des_tipdocum,
                          'PAGADA'
                                AS estado
                     FROM fa_histdocu fahist,
                          ga_abocel abo,
                          co_cancelados cocan,
                          ge_tipdocumen tipdoc
                    WHERE fahist.cod_cliente = abo.cod_cliente
                      AND abo.num_abonado = LN_num_abonado
                      AND fahist.num_secuenci = cocan.num_secuenci
                      AND fahist.cod_tipdocum = cocan.cod_tipdocum
                      AND fahist.cod_centremi = cocan.cod_centremi
                      AND fahist.cod_vendedor_agente = cocan.cod_vendedor_agente
                      AND fahist.letra = cocan.letra
                      AND fahist.cod_tipdocum = tipdoc.cod_tipdocum
                      AND fahist.num_folio NOT IN (
                                     SELECT cocar.num_folio
                                       FROM co_cartera cocar
                                      WHERE cocar.num_folio = fahist.num_folio)
                 UNION
                 SELECT DISTINCT fahist.num_folio, fahist.fec_emision,
                                 fahist.fec_vencimie, cocar.fec_pago,
                                 fahist.tot_pagar, tipdoc.des_tipdocum,
                                 'VENCIDA'
                                       AS estado
                            FROM fa_histdocu fahist,
                                 ga_abocel abo,
                                 co_cartera cocar,
                                 ge_tipdocumen tipdoc
                           WHERE fahist.cod_cliente = abo.cod_cliente
                             AND abo.num_abonado = LN_num_abonado
                             AND fahist.num_secuenci = cocar.num_secuenci
                             AND fahist.cod_tipdocum = cocar.cod_tipdocum
                             AND fahist.cod_centremi = cocar.cod_centremi
                             AND fahist.cod_vendedor_agente =
                                                    cocar.cod_vendedor_agente
                             AND fahist.letra = cocar.letra
                             AND fahist.cod_tipdocum = tipdoc.cod_tipdocum
                             AND fahist.fec_vencimie < SYSDATE
                 UNION
                 SELECT DISTINCT fahist.num_folio, fahist.fec_emision,
                                 fahist.fec_vencimie, cocar.fec_pago,
                                 fahist.tot_pagar, tipdoc.des_tipdocum,
                                 'VIGENTE'
                                       AS estado
                            FROM fa_histdocu fahist,
                                 ga_abocel abo,
                                 co_cartera cocar,
                                 ge_tipdocumen tipdoc
                           WHERE fahist.cod_cliente = abo.cod_cliente
                             AND abo.num_abonado = LN_num_abonado
                             AND fahist.num_secuenci = cocar.num_secuenci
                             AND fahist.cod_tipdocum = cocar.cod_tipdocum
                             AND fahist.cod_centremi = cocar.cod_centremi
                             AND fahist.cod_vendedor_agente =
                                                    cocar.cod_vendedor_agente
                             AND fahist.letra = cocar.letra
                             AND fahist.cod_tipdocum = tipdoc.cod_tipdocum
                             AND fahist.fec_vencimie >= SYSDATE
                        ORDER BY fec_emision DESC)
         WHERE ROWNUM <= EN_cantfacturas;
   ELSE
      RAISE error_abonado;
   END IF;

EXCEPTION

   WHEN error_parametro_celular THEN
      SN_cod_retorno := '142';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error :=SUBSTR('ga_cons_facturas_pr('||EN_num_celular||', '||EV_formato_fec||'); - ' || SQLERRM,1,CN_largoerrtec);
  	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'ga_cons_facturas_pr', sSql, SQLCODE, V_des_error );

   WHEN error_parametro_fecha THEN
      SN_cod_retorno := '143';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error :=SUBSTR('ga_cons_facturas_pr('||EN_num_celular||', '||EV_formato_fec||'); - ' || SQLERRM,1,CN_largoerrtec);
  	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'ga_cons_facturas_pr', sSql, SQLCODE, V_des_error );

   WHEN error_formato_fecha THEN
      SN_cod_retorno  := N_codretorno;
      SV_mens_retorno := V_mens_retorno;
      V_des_error :=SUBSTR('ga_cons_facturas_pr('||EN_num_celular||', '||EV_formato_fec||'); - ' || SQLERRM,1,CN_largoerrtec);
  	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento,CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'ga_cons_facturas_pr', sSql, SQLCODE, V_des_error );

   WHEN error_abonado THEN
      SN_cod_retorno  := N_codretorno;
      SV_mens_retorno := V_mens_retorno;
      V_des_error :=SUBSTR('ga_cons_facturas_pr('||EN_num_celular||', '||EV_formato_fec||'); - ' || SQLERRM,1,CN_largoerrtec);
  	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'ga_cons_facturas_pr', sSql, SQLCODE, V_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := '151';
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error :=SUBSTR('ga_cons_facturas_pr('||EN_num_celular||', '||EV_formato_fec||'); - ' || SQLERRM,1,CN_largoerrtec);
  	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'ga_cons_facturas_pr', sSql, SQLCODE, V_des_error );

END ga_cons_facturas_pr;

END GA_CONS_PG;
/
SHOW ERRORS
