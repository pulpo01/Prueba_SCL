CREATE OR REPLACE PACKAGE BODY pv_anula_siniestro_sb_pg
IS
--------------------------------------------------------------------------------------
--  pv_anula_siniestro_sb_pg  Version 1.1  COL-70901|24-11-2008|DVG
--------------------------------------------------------------------------------------

 FUNCTION pv_recupera_datos_siniestro_fn (
    eso_ga_siniestros  IN OUT NOCOPY  ga_siniestros_qt,
    SN_cod_retorno     OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      OUT NOCOPY  ge_errores_pg.evento) RETURN BOOLEAN
 AS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_ChequeaTerminal_pr';
    ret                      BOOLEAN := FALSE;
  BEGIN

      LV_sSql := 'SELECT num_abonado, cod_causa, cod_estado, num_terminal,'
 	          || ' num_serie, fec_siniestro, cod_servicio, cod_cargobasico,'
 	          || ' fec_formaliza, fec_anula, fec_restituc, num_constpol,'
 	          || ' num_solliq, num_serierep, ind_susp, tip_terminal'
 	          || ' FROM ga_siniestros'
 	          || ' WHERE num_siniestro = '||eso_ga_siniestros.num_siniestro;

    SELECT num_abonado, cod_causa, cod_estado, num_terminal,
	       num_serie, fec_siniestro, cod_servicio, cod_cargobasico,
		   fec_formaliza, fec_anula, fec_restituc, num_constpol,
		   num_solliq, num_serierep, ind_susp, tip_terminal
	INTO eso_ga_siniestros.num_abonado, eso_ga_siniestros.cod_causa, eso_ga_siniestros.cod_estado, eso_ga_siniestros.num_terminal,
	     eso_ga_siniestros.num_serie, eso_ga_siniestros.fec_siniestro, eso_ga_siniestros.cod_servicio, eso_ga_siniestros.cod_cargobasico,
		 eso_ga_siniestros.fec_formaliza, eso_ga_siniestros.fec_anula, eso_ga_siniestros.fec_restituc, eso_ga_siniestros.num_constpol,
		 eso_ga_siniestros.num_solliq, eso_ga_siniestros.num_serierep, eso_ga_siniestros.ind_susp, eso_ga_siniestros.tip_terminal
	FROM ga_siniestros
    WHERE num_siniestro = eso_ga_siniestros.num_siniestro;

	RETURN TRUE;

 EXCEPTION
    WHEN OTHERS THEN
	     SN_cod_retorno := 999;
	     SV_mens_retorno := 'Error al recuperar datos de siniestro ';
		 LV_des_error   := 'pv_anula_siniestro_sb_pg.pv_recupera_datos_siniestro_fn'||'); - ' || SQLERRM;
	     SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AVISO_SINIESTRO_WEB_PG.PV_RECUPERA_ESTADO_OOSS_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		 RETURN FALSE;

 END pv_recupera_datos_siniestro_fn;


--------------------------------------------------------------------------------------


PROCEDURE grabaError(
    EV_NombrePL              IN             VARCHAR2,
    EV_param                 IN             PV_ANULA_SINIESTRO_OT,
    LV_sSql                  IN             ge_errores_pg.vQuery,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento,
    EB_EjecutaRaise          IN BOOLEAN  DEFAULT TRUE)
    IS
        LV_des_error         ge_errores_pg.DesEvent;
        objStr               VARCHAR2(4000) := '';  --Objeto que contiene un string con el contenido del objeto;
    BEGIN
        SN_cod_retorno := cn_def_retorno;
        SV_mens_retorno := cv_def_error;

        IF(NOT EV_param IS NULL) THEN
           objStr := EV_param.to_debug();
        END IF;

        LV_des_error   := EV_NombrePL || '(); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, EV_NombrePL, objStr || LV_sSQL, SN_cod_retorno, LV_des_error );

        IF(EB_EjecutaRaise = TRUE) THEN
           RAISE_APPLICATION_ERROR(raise_err_def, SV_mens_retorno);
        END IF;

 END grabaError;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
FUNCTION PV_INS_CI_ORSERV_FN      (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento) RETURN BOOLEAN
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'PV_INS_CI_ORSERV_FN';
  BEGIN

    LV_sSql :=
    'INSERT INTO CI_ORSERV ' ||
    '(NUM_OS, COD_OS, PRODUCTO, TIP_INTER, COD_INTER, USUARIO, FECHA, COMENTARIO)' ||
   ' VALUES '  ||
	'(' ||
   		  EV_param.num_ooss  || ','  ||
		  EV_param.cod_ooss  || ','  ||
   		  '1,'  ||
  		  '1,' ||
		  EV_param.num_abonado || ','  ||
		  EV_param.nom_usuario  || ','  ||
		  SYSDATE   || ','  ||
		  EV_param.obs_detalle || ','  ||
	 ');';

	INSERT INTO CI_ORSERV
   ( NUM_OS, COD_OS, PRODUCTO, TIP_INTER, COD_INTER, USUARIO, FECHA, COMENTARIO)
    VALUES
	(
   		  EV_param.num_ooss,
		  EV_param.cod_ooss,
   		  1,
  		  1,
		  EV_param.num_abonado,
		  EV_param.nom_usuario    ,
		  SYSDATE,
		  EV_param.obs_detalle
	 );

	 RETURN TRUE;

 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, EV_param, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
 	 RETURN FALSE;

 END PV_INS_CI_ORSERV_FN   ;
--------------------------------------------------------------------------------------
FUNCTION PV_REC_DATOS_SINIESTROS_FN      (
      eo_dat_abo        IN                PV_DATOS_ABO_QT,
      sv_cursor         OUT               vcursor,
      sn_cod_retorno    OUT NOCOPY        ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY        ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY        ge_errores_pg.evento) RETURN BOOLEAN
IS
    LV_des_error      ge_errores_pg.DesEvent;
    LV_sSql           ge_errores_pg.vQuery;

    BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

    LV_sSql:='SELECT  A.NUM_SINIESTRO, B.COD_ESTADO,C.DES_ESTADO,A.COD_CAUSA,D.DES_CAUSA,';
    LV_sSql:=LV_sSql||' A.FEC_SINIESTRO,A.FEC_FORMALIZA,A.FEC_ANULA,A.FEC_RESTITUC,';
    LV_sSql:=LV_sSql||' A.NUM_CONSTPOL,B.OBS_DETALLE,A.COD_ESTADO,A.NUM_SERIE,';
    LV_sSql:=LV_sSql||' NVL(E.DES_TERMINAL,''TERMINAL TDMA'') DES_TERMINAL ';
    LV_sSql:=LV_sSql||' FROM  GA_SINIESTROS A, GA_DETSINIE B, GA_ESTADOSIN C, GA_CAUSINIE D,';
    LV_sSql:=LV_sSql||' AL_TIPOS_TERMINALES E ';
    LV_sSql:=LV_sSql||' WHERE B.COD_ESTADO = C.COD_ESTADO AND A.NUM_SINIESTRO = B.NUM_SINIESTRO';
    LV_sSql:=LV_sSql||' AND A.COD_CAUSA = D.COD_CAUSA AND A.COD_PRODUCTO = D.COD_PRODUCTO';
    LV_sSql:=LV_sSql||' AND   A.COD_PRODUCTO   = '||cv_prod_celular;
    LV_sSql:=LV_sSql||' AND   A.NUM_ABONADO    = '||eo_dat_abo.num_abonado;
    LV_sSql:=LV_sSql||' AND   A.TIP_TERMINAL = E.TIP_TERMINAL (+) AND A.COD_PRODUCTO = E.COD_PRODUCTO (+)';
    LV_sSql:=LV_sSql||' ORDER BY A.NUM_SINIESTRO, B.FEC_DETALLE, A.FEC_FORMALIZA ';

    OPEN sv_cursor FOR
	SELECT   a.num_siniestro, b.cod_estado, c.des_estado, a.cod_causa,
	         d.des_causa, a.fec_siniestro, a.fec_formaliza, a.fec_anula,
	         a.fec_restituc, a.num_constpol, b.obs_detalle, a.cod_estado,
	         a.num_serie, NVL (e.des_terminal, 'TERMINAL TDMA') des_terminal, a.num_terminal
	    FROM ga_siniestros a,
	         ga_detsinie b,
	         ga_estadosin c,
	         ga_causinie d,
	         al_tipos_terminales e
	   WHERE b.cod_estado = c.cod_estado
	     AND a.num_siniestro = b.num_siniestro
	     AND a.cod_causa = d.cod_causa
	     AND a.cod_producto = d.cod_producto
	     AND a.cod_producto = cv_prod_celular
	     AND a.num_abonado = eo_dat_abo.num_abonado
	     AND a.tip_terminal = e.tip_terminal(+)
	     AND a.cod_producto = e.cod_producto(+)
	ORDER BY a.num_siniestro, b.fec_detalle, a.fec_formaliza;

	RETURN TRUE;

    EXCEPTION
    WHEN OTHERS THEN
          SN_cod_retorno := 999;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PV_ANULA_SINIESTRO_WEB_PG.PV_REC_DATOS_SINIESTROS_FN'||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ANULA_SINIESTRO_WEB_PG.PV_REC_DATOS_SINIESTROS_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
          RETURN FALSE;

END PV_REC_DATOS_SINIESTROS_FN;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
 PROCEDURE pv_graba_anula_siniestro_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql            ge_errores_pg.vQuery;
    SV_NombrePL        VARCHAR2(100) := 'pv_graba_anula_siniestro_pr';
    abonado            PV_DATOS_ABO_QT := NEW PV_DATOS_ABO_QT();
	error_ejecucion    EXCEPTION;
  BEGIN
     abonado.num_abonado := EV_param.num_abonado;
	 EV_param.fec_hora := SYSDATE;
     PV_CAMBIO_SERIE_SB_PG.pv_rec_info_abonado_pr(abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
     IF(SN_cod_retorno = 0) THEN


    	 IF NOT (pv_ins_ci_orserv_fn(ev_param,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
		    RAISE error_ejecucion;
		 END IF;

	     ev_param.cod_cliente := abonado.cod_cliente;
         LV_sSql := 'pv_rec_cargos_basicos_orgi_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
         pv_rec_cargos_basicos_orgi_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

         LV_sSql := 'ge_fn_devvalparam(''GA'',1,''TECNOLOGIA_GSM'');';
         EV_param.par_tecnologia_gsm := ge_fn_devvalparam('GA',1,'TECNOLOGIA_GSM');

         IF(EV_param.cod_cargobasico = 'SIN') THEN
             LV_sSql := 'pv_rec_cargos_basicos_ant_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
             pv_rec_cargos_basicos_ant_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
         END IF;

         LV_sSql := 'pv_Anular_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
         pv_Anular_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

         LV_sSql := 'pv_InsertarDetalle_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
         pv_InsertarDetalle_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

         LV_sSql := 'pv_ChequeaTerminal_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento)';
         IF(pv_ChequeaTerminal_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento) = TRUE) THEN
            LV_sSql := 'pv_rehabilitar_suspension_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
            pv_rehabilitar_suspension_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

			IF abonado.cod_uso <> 3 THEN
	            LV_sSql := 'pv_restituirCargoBasico_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
	            pv_restituirCargoBasico_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
			END IF;
         END IF;

		 IF EV_param.ind_mant_lista_negra = 0 THEN
            LV_sSql := 'pv_BorrarListasNegras_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
            pv_BorrarListasNegras_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
		 END IF;

         LV_sSql := 'pv_PasoHistorico_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
         pv_PasoHistorico_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

     END IF;

 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, EV_param, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento, FALSE);

 END pv_graba_anula_siniestro_pr;



--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
 PROCEDURE pv_rec_cargos_basicos_orgi_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_rec_cargos_basicos_orgi_pr';
  BEGIN

     LV_sSql :=
     'SELECT cod_cargobasico' ||
     ' INTO EV_param.cod_cargobasico' ||
     ' FROM ga_intarcel a' ||
     ' WHERE a.num_abonado = EV_param.num_abonado' ||
     ' and a.cod_cliente = EV_param.cod_cliente' ||
     ' AND a.fec_hasta =' ||
     ' (SELECT MAX(fec_hasta) FROM ga_intarcel b' ||
     ' WHERE a.cod_cliente=b.cod_cliente ' ||
     ' AND a.num_abonado=b.num_abonado);';


     SELECT cod_cargobasico
     INTO EV_param.cod_cargobasico
     FROM ga_intarcel a
     WHERE a.num_abonado = EV_param.num_abonado
     AND a.cod_cliente = EV_param.cod_cliente
     AND a.fec_hasta =
     (SELECT MAX(fec_hasta) FROM ga_intarcel b
     WHERE a.cod_cliente=b.cod_cliente
     AND a.num_abonado=b.num_abonado);

 EXCEPTION
    WHEN NO_DATA_FOUND THEN
       EV_param.cod_cargobasico := NULL;

    WHEN OTHERS THEN
         grabaError(SV_NombrePL, NULL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_rec_cargos_basicos_orgi_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
 PROCEDURE pv_rec_cargos_basicos_ant_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_rec_cargos_basicos_ant_pr';
  BEGIN

    LV_sSql:='SELECT cod_cargobasico FROM ga_intarcel a';
    LV_sSql:=LV_sSql||' WHERE a.num_abonado = '||EV_param.num_abonado;
    LV_sSql:=LV_sSql||' AND a.cod_cliente = '||EV_param.cod_cliente;
    LV_sSql:=LV_sSql||' AND (TRUNC (a.fec_hasta) = (SELECT TRUNC (MAX (b.fec_desde))';
    LV_sSql:=LV_sSql||' FROM ga_intarcel b WHERE a.cod_cliente = b.cod_cliente';
    LV_sSql:=LV_sSql||' AND a.num_abonado = b.num_abonado) OR TRUNC (a.fec_hasta) =';
    LV_sSql:=LV_sSql||' (SELECT TRUNC (MAX (b.fec_desde - 1)) FROM ga_intarcel b';
    LV_sSql:=LV_sSql||' WHERE a.cod_cliente = b.cod_cliente AND a.num_abonado = b.num_abonado))';

    SELECT cod_cargobasico
      INTO EV_param.cod_cargobasico
      FROM ga_intarcel a
     WHERE a.num_abonado = EV_param.num_abonado
       AND a.cod_cliente = EV_param.cod_cliente
       AND (   TRUNC (a.fec_hasta) =
                  (SELECT TRUNC (MAX (b.fec_desde))
                     FROM ga_intarcel b
                    WHERE a.cod_cliente = b.cod_cliente
                      AND a.num_abonado = b.num_abonado)
            OR TRUNC (a.fec_hasta) =
                  (SELECT TRUNC (MAX (b.fec_desde - 1))
                     FROM ga_intarcel b
                    WHERE a.cod_cliente = b.cod_cliente
                      AND a.num_abonado = b.num_abonado)
           );

 EXCEPTION
    WHEN NO_DATA_FOUND THEN
       EV_param.cod_cargobasico := NULL;

    WHEN OTHERS THEN
         grabaError(SV_NombrePL, NULL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_rec_cargos_basicos_ant_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
 PROCEDURE pv_Anular_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_Anular_pr';
  BEGIN


    LV_sSql :=
      'UPDATE GA_SINIESTROS SET' ||
    ' COD_ESTADO = ' || cv_CodActAbo || ', ' ||
    ' FEC_ANULA = EV_param.fec_hora ' ||
    ' WHERE NUM_SINIESTRO = ' || EV_param.num_siniestro;

    UPDATE GA_SINIESTROS SET
    COD_ESTADO =  cv_CodActAbo,
    FEC_ANULA = EV_param.fec_hora
    WHERE NUM_SINIESTRO = EV_param.num_siniestro;


 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, NULL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_Anular_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
 PROCEDURE pv_InsertarDetalle_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_InsertarDetalle_pr';
  BEGIN

    LV_sSql :=
    'INSERT INTO GA_DETSINIE' ||
    '(NUM_SINIESTRO, COD_ESTADO, FEC_DETALLE, NOM_USUARORA, OBS_DETALLE)' ||
    'VALUES(' ||
    'EV_param.num_siniestro, '|| cv_CodActAbo ||', EV_param.fec_hora,' ||
    'EV_param.nom_usuario, EV_param.obs_detalle);';


    INSERT INTO GA_DETSINIE
    (NUM_SINIESTRO, COD_ESTADO, FEC_DETALLE, NOM_USUARORA, OBS_DETALLE)
    VALUES(
    EV_param.num_siniestro, cv_CodActAbo , EV_param.fec_hora,
    EV_param.nom_usuario, EV_param.obs_detalle);

 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, EV_param, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_InsertarDetalle_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
 FUNCTION pv_ChequeaTerminal_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento) RETURN BOOLEAN
 AS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_ChequeaTerminal_pr';
    ret                      BOOLEAN := FALSE;
  BEGIN

    LV_sSql := 'pv_cuenta_siniestro_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
    pv_cuenta_siniestro_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

    LV_sSql := 'pv_datos_siniestros_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
    pv_datos_siniestros_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

    IF(EV_param.cant_siniestros_abo = 2) THEN
       LV_sSql := 'ge_fn_devvalparam(''AL'',1,''COD_SIMCARD_GSM'');';
       EV_param.par_simcard := ge_fn_devvalparam('AL',1,'COD_SIMCARD_GSM');
       IF(EV_param.par_simcard =  EV_param.tip_terminal) THEN
         ret := TRUE;
       ELSE
          IF(EV_param.ind_susp >  0) THEN
             ret := TRUE;
          ELSE
             ret := FALSE;
          END IF;

       END IF;
    ELSE
       IF(EV_param.cant_siniestros_abo = 1 AND
               EV_param.par_tecnologia_gsm = abonado.cod_tecnologia) THEN

          LV_sSql := 'pv_recuperaModuloSuspencion_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
          pv_recuperaModuloSuspencion_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

          IF abonado.cod_situacion = 'SAA' AND EV_param.Cod_Modulo = 'GA' THEN
              IF(EV_param.ind_susp > 0) THEN
                 ret := TRUE;
              ELSE
                 ret := FALSE;
              END IF;
          ELSE
              ret := FALSE;
          END IF;
       ELSIF(EV_param.cant_siniestros_abo = 1) THEN
          ret := TRUE;
       ELSE
           ret := FALSE;
       END IF;
    END IF;

    RETURN ret;

 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, EV_param, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_ChequeaTerminal_pr;



--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
 PROCEDURE pv_cuenta_siniestro_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_cuenta_siniestro_pr';
  BEGIN

    LV_sSql :=
    'SELECT COUNT(1)' ||
    ' FROM ga_siniestros ' ||
    ' WHERE num_abonado = ' || EV_param.num_abonado;


    SELECT COUNT(1) INTO EV_param.cant_siniestros_abo
    FROM ga_siniestros
    WHERE num_abonado = EV_param.num_abonado;

 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, NULL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_cuenta_siniestro_pr;
 --------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
 PROCEDURE pv_cuenta_suspenciones_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_cuenta_suspenciones_pr';
  BEGIN

    LV_sSql :=
    'SELECT COUNT(1)' ||
    'FROM ga_susprehabo ' ||
    'WHERE num_abonado = ' || EV_param.num_abonado;

    SELECT COUNT(1) INTO EV_param.cant_suspenciones
    FROM ga_susprehabo
    WHERE num_abonado = EV_param.num_abonado;

 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, NULL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_cuenta_suspenciones_pr;

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
PROCEDURE pv_datos_siniestros_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_datos_siniestros_pr';
  BEGIN


    LV_sSql :=
    'SELECT tip_terminal, ind_susp ' ||
    'FROM ga_siniestros ' ||
    'WHERE num_siniestro =  '  ||EV_param.num_siniestro;


    SELECT tip_terminal, ind_susp
    INTO EV_param.tip_terminal, EV_param.ind_susp
    FROM ga_siniestros
    WHERE num_siniestro =  EV_param.num_siniestro;


 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, NULL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_datos_siniestros_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
PROCEDURE pv_recuperaModuloSuspencion_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_recuperaModuloSuspencion_pr';
  BEGIN

    LV_sSql := 'pv_cuenta_suspenciones_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
    pv_cuenta_suspenciones_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

    LV_sSql := 'ELECT DISTINCT cod_modulo FROM ga_susprehabo WHERE num_abonado ' || EV_param.num_abonado;
    LV_sSql := LV_sSql || 'AND cod_modulo =''GA''';

    SELECT DISTINCT cod_modulo
	INTO EV_param.cod_modulo
	FROM ga_susprehabo
    WHERE num_abonado =  EV_param.num_abonado
    AND cod_modulo = 'GA';

 EXCEPTION
    WHEN NO_DATA_FOUND THEN
       EV_param.cod_modulo := NULL;
    WHEN OTHERS THEN
       grabaError(SV_NombrePL, EV_param, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_recuperaModuloSuspencion_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
PROCEDURE pv_rehabilitar_suspension_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_rehabilitar_suspension_pr';
	eso_ga_siniestros        ga_siniestros_qt := new ga_siniestros_qt;
	error_ejecucion          EXCEPTION;
  BEGIN


    eso_ga_siniestros.num_siniestro := EV_param.num_siniestro;

    IF NOT (pv_recupera_datos_siniestro_fn (eso_ga_siniestros,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) THEN
	   RAISE error_ejecucion;
	END IF;

	IF (eso_ga_siniestros.ind_susp = 1) THEN


        LV_sSql := 'pv_act_estado_abonado_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
        pv_act_estado_abonado_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

        LV_sSql := 'pv_datos_causa_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
        pv_datos_causa_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

        LV_sSql := 'pv_ga_susprehaboXabonado_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
        pv_ga_susprehaboXabonado_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

        LV_sSql := 'pv_act_ga_susprehabo_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
        pv_act_ga_susprehabo_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

        LV_sSql := 'pv_GeneraMovimientos_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
        pv_GeneraMovimientos_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

	END IF;

 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, EV_param, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_rehabilitar_suspension_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
PROCEDURE pv_act_estado_abonado_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_act_estado_abonado_pr';
  BEGIN


    IF(abonado.des_origen = 'C') THEN

       LV_sSql :=
       'UPDATE ga_abocel SET ' ||
       ' COD_SITUACION = DECODE (COD_SITUACION, ''SAA'',''RTP'',''AOS'',''RAO'',''ATS'',''RAT'',''CVS'',''RCV'',''RDS'',''RRD'',''RTP''), ' ||
       ' FEC_ULTMOD = ' || TO_CHAR(EV_param.fec_hora, 'dd-mm-yyyy hh24-mi-ss') ||
       ' WHERE NUM_ABONADO = ' || EV_param.num_abonado;

       UPDATE GA_ABOCEL SET
       COD_SITUACION = DECODE (COD_SITUACION, 'SAA','RTP','AOS','RAO','ATS','RAT','CVS','RCV','RDS','RRD','RTP'),
       FEC_ULTMOD = EV_param.fec_hora
       WHERE NUM_ABONADO = EV_param.num_abonado;
    ELSE
       LV_sSql :=
       'UPDATE ga_aboamist SET ' ||
       ' COD_SITUACION = DECODE (COD_SITUACION, ''SAA'',''RTP'',''AOS'',''RAO'',''ATS'',''RAT'',''CVS'',''RCV'',''RDS'',''RRD'',''RTP''), ' ||
       ' FEC_ULTMOD = ' || TO_CHAR(EV_param.fec_hora, 'dd-mm-yyyy hh24-mi-ss') ||
       ' WHERE NUM_ABONADO = ' || EV_param.num_abonado;

       UPDATE ga_aboamist SET
       COD_SITUACION = DECODE (COD_SITUACION, 'SAA','RTP','AOS','RAO','ATS','RAT','CVS','RCV','RDS','RRD','RTP'),
       FEC_ULTMOD = EV_param.fec_hora
       WHERE NUM_ABONADO = EV_param.num_abonado;
    END IF;


 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, NULL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_act_estado_abonado_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
PROCEDURE pv_datos_causa_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_datos_causa_pr';
  BEGIN


   LV_sSql :=
   'SELECT cod_cargobasico, cod_servicio' ||
   ' FROM ga_causinie ' ||
   ' WHERE cod_causa = ' || EV_param.cod_causa ||
   ' AND cod_producto = ' || cv_prod_celular;

   SELECT cod_cargobasico, cod_servicio
   INTO EV_param.cod_cargobasico_causa, EV_param.cod_servicio_causa
   FROM ga_causinie
   WHERE cod_causa = EV_param.cod_causa
   AND cod_producto = cv_prod_celular;

 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, NULL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_datos_causa_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
PROCEDURE pv_ga_susprehaboXabonado_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_ga_susprehaboXabonado_pr';
  BEGIN


   LV_sSql :=
   'SELECT cod_servicio'   ||
   ' FROM ga_susprehabo '  ||
   ' WHERE num_abonado = ' || EV_param.num_abonado ||
   ' AND ind_siniestro = 1'||
   ' AND ROWNUM = 1';

   SELECT cod_servicio INTO EV_param.cod_servicioSusp
   FROM ga_susprehabo
   WHERE num_abonado = EV_param.num_abonado
   AND ind_siniestro = 1
   AND ROWNUM = 1;


 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, NULL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_ga_susprehaboXabonado_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
PROCEDURE pv_rec_indSuspencion_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_rec_indSuspencion_pr';
  BEGIN


   LV_sSql :=
   'SELECT COUNT(1) INTO EV_param.ind_suspencion FROM ga_susprehabo'   ||
   ' WHERE num_abonado = ' || EV_param.num_abonado      ||
   ' AND cod_servicio = '  || EV_param.cod_servicioSusp ||
   ' AND fec_suspbd =   '  || EV_param.fec_suspencion   ||
   ' AND ind_siniestro = 1'||
   ' AND ROWNUM = 1';

    --Esta rutina, a pesar que realiza un count, solo varifica si existen registros
    --para la fecha de suspencion, ya que filtra por ROWNUM = 1

    SELECT COUNT(1) INTO EV_param.ind_suspencion FROM ga_susprehabo
    WHERE num_abonado = EV_param.num_abonado
    AND cod_servicio = EV_param.cod_servicioSusp
    AND fec_suspbd = EV_param.fec_suspencion
    AND ind_siniestro = 1
    AND ROWNUM = 1;



 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, NULL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_rec_indSuspencion_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
PROCEDURE pv_act_ga_susprehabo_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_act_ga_susprehabo_pr';
  BEGIN

   pv_rec_indSuspencion_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

   LV_sSql :=
        ' UPDATE GA_SUSPREHABO ' ||
        ' SET FEC_REHABD = EV_param.Fec_Hora ' ||
        ' ,TIP_REGISTRO = 3 ' ||
        ' WHERE NUM_ABONADO = EV_param.num_abonado ' ||
        ' AND IND_SINIESTRO = 1 ' ||
        ' AND COD_SERVICIO = EV_param.cod_servicioSusp ';
        IF (EV_param.ind_suspencion = 1) THEN -- deberia ser 1
            LV_sSql := LV_sSql || ' AND FEC_SUSPBD = EV_param.fec_suspencion ';
        END IF;
        LV_sSql := LV_sSql || ' AND ROWNUM = 1;';


    IF (EV_param.ind_suspencion = 1) THEN -- deberia ser 1
        UPDATE GA_SUSPREHABO
        SET FEC_REHABD = EV_param.Fec_Hora
        ,TIP_REGISTRO = 3
        WHERE NUM_ABONADO = EV_param.num_abonado
        AND IND_SINIESTRO = 1
        AND COD_SERVICIO = EV_param.cod_servicioSusp
         AND FEC_SUSPBD = EV_param.fec_suspencion
        AND ROWNUM = 1;
    ELSE
        UPDATE GA_SUSPREHABO
        SET FEC_REHABD = EV_param.Fec_Hora
        ,TIP_REGISTRO = 3
        WHERE NUM_ABONADO = EV_param.num_abonado
        AND IND_SINIESTRO = 1
        AND COD_SERVICIO = EV_param.cod_servicioSusp
        AND ROWNUM = 1;
    END IF;



 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, EV_param, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_act_ga_susprehabo_pr;

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
PROCEDURE pv_GeneraMovimientos_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_GeneraMovimientos_pr';
  BEGIN

  LV_sSql := 'pv_InsertaMovimiento_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
  pv_InsertaMovimiento_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  LV_sSql := 'pv_IngIntGestor_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
  pv_IngIntGestor_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);


 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, EV_param, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_GeneraMovimientos_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
PROCEDURE pv_InsertaMovimiento_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_InsertaMovimiento_pr';
    EV_cambioserie           PV_CAM_SIMCARD_OT := NEW PV_CAM_SIMCARD_OT();
  BEGIN

    IF(abonado.des_origen = 'C') THEN
        LV_sSql := 'AL_FN_PREFIJO_NUMERO(' || abonado.num_celular ||');';
        EV_param.num_min := AL_FN_PREFIJO_NUMERO(abonado.num_celular);
    END IF;


    LV_sSql := 'SELECT ICC_SEQ_NUMMOV.NEXTVAL into EV_param.mum_mov FROM DUAL;';
    SELECT ICC_SEQ_NUMMOV.NEXTVAL INTO EV_param.mum_mov FROM DUAL;

    LV_sSql :=
    'SELECT COD_ACTABO INTO EV_param.cod_actabo FROM PV_ACTABO_TIPLAN' ||
    'WHERE COD_TIPMODI = ' || cv_CodActAbo ||
    'AND   COD_TIPLAN  = abonado.COD_TIPLAN;';

    SELECT COD_ACTABO INTO EV_param.cod_actabo FROM PV_ACTABO_TIPLAN
    WHERE COD_TIPMODI = cv_CodActAbo
    AND   COD_TIPLAN  = abonado.COD_TIPLAN;

    IF(EV_param.par_tecnologia_gsm = abonado.cod_tecnologia) THEN
       LV_sSql := 'FN_RECUPERA_IMSI(abonado.num_serie);';
       EV_param.IMSI := FN_RECUPERA_IMSI(abonado.num_serie);
    END IF;

    LV_sSql := 'FN_CODACTCEN(cv_prod_celular, EV_param.cod_actabo, ''GA'', abonado.cod_tecnologia);';
    EV_param.cod_act := FN_CODACTCEN(cv_prod_celular, EV_param.cod_actabo, 'GA', abonado.cod_tecnologia);


    LV_sSql :=
    'EV_cambioserie.NumAbonado := EV_param.num_abonado;' ||
    'pv_grabar_simcard_sb_pg.pv_rec_num_servicios_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';

    EV_cambioserie.NumAbonado := EV_param.num_abonado;
    EV_cambioserie.CodServicio := pv_grabar_simcard_sb_pg.pv_rec_num_servicios_pr(EV_cambioserie, SN_cod_retorno, SV_mens_retorno, SN_num_evento);



    LV_sSql :=
    'abonado.cod_central := ' || abonado.cod_central || ';' ||
    'abonado.Num_Celular := ' || abonado.Num_Celular || ';' ||
    'abonado.num_seriehex:= ' || abonado.num_seriehex || ';' ||
    'abonado.Tip_Terminal:= ' || abonado.Tip_Terminal || ';' ||
    'abonado.num_min:= ' || abonado.num_min || ';' ||
    'abonado.cod_tecnologia' || abonado.cod_tecnologia || ';' ||
    'abonado.NUM_IMEI'  || abonado.NUM_IMEI || ';' ||
    'abonado.Num_serie' || abonado.Num_serie || ';' ||
    'INSERT INTO icc_movimiento (' ||
    ' num_movimiento,         num_abonado,' ||
    ' cod_estado,             cod_modulo, ' ||
    ' nom_usuarora,           cod_central,' ||
    ' num_celular,            cod_actuacion,' ||
    ' fec_ingreso,            num_serie,' ||
    ' cod_servicios,          cod_suspreha, ' ||
    ' tip_terminal,           cod_actabo,   ' ||
    ' num_min,                sta, ' ||
    ' tip_tecnologia,         imsi,imei,' ||
    ' icc' ||
    ' ) VALUES (' ||
    ' EV_param.mum_mov,                EV_param.Num_Abonado,' ||
    ' ''1'',                             ''GA'', ' ||
    ' EV_param.nom_usuario,            abonado.cod_central,' ||
    ' abonado.Num_Celular,    EV_param.cod_act,' ||
    ' EV_param.fec_hora,               abonado.num_seriehex, ' ||
    ' EV_cambioserie.CodServicio,      EV_param.cod_servicio_causa,    ' ||
    ' abonado.Tip_Terminal,''RT'', ' ||
    ' abonado.num_min,        DECODE(EV_param.cod_actabo, ''AN'', ''N'', ''S''),' ||
    ' abonado.cod_tecnologia, EV_param.IMSI, ' ||
    ' abonado.NUM_IMEI,       abonado.Num_serie' ||
    ');';


    INSERT INTO icc_movimiento (
    num_movimiento,         num_abonado,
    cod_estado,             cod_modulo,
    nom_usuarora,           cod_central,
    num_celular,            cod_actuacion,
    fec_ingreso,            num_serie,
    cod_servicios,          cod_suspreha,
    tip_terminal,           cod_actabo,
    num_min,                sta,
    tip_tecnologia,         imsi,imei,
    icc
    ) VALUES (
    EV_param.mum_mov,                EV_param.Num_Abonado,
    '1',                             'GA',
    EV_param.nom_usuario,            abonado.cod_central,
    abonado.Num_Celular,    EV_param.cod_act,
    EV_param.fec_hora,               abonado.num_seriehex,
    NULL,      EV_param.cod_servicio_causa,
    abonado.Tip_Terminal,            'RT',
    abonado.num_min,        DECODE(EV_param.cod_actabo, 'AN', 'N', 'S'),
    abonado.cod_tecnologia, EV_param.IMSI,
    abonado.NUM_IMEI,       abonado.Num_serie
    );

 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, EV_param, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_InsertaMovimiento_pr;
 --------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
PROCEDURE pv_IngIntGestor_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_IngIntGestor_pr';
    EV_cambioserie           PV_CAM_SIMCARD_OT := NEW PV_CAM_SIMCARD_OT();
    transacabo               NUMBER(10);
    respuesta                VARCHAR2(10);
    mensaje                  VARCHAR2(4000);
    pvCodValor               VARCHAR2(100);
    pvErrorAplic             VARCHAR2(100);
    pvErrorGlosa             VARCHAR2(100);
    pvErrorOra               VARCHAR2(100);
    pvErrorOraGlosa          VARCHAR2(100);
    pvTrace                  VARCHAR2(100);
  BEGIN

  LV_sSql := 'pv_grabar_simcard_sb_pg.pv_consulta_secuencia_pr(''GA_SEQ_TRANSACABO'', SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
  transacabo := pv_grabar_simcard_sb_pg.pv_consulta_secuencia_pr('GA_SEQ_TRANSACABO', SN_cod_retorno, SV_mens_retorno, SN_num_evento);


  LV_sSql := 'PV_INS_MOV_IDGESTOR_TO_PR('|| transacabo || ',' ||
                                            EV_param.cod_act || ',' ||
                                            EV_param.mum_mov || ',' ||
                                            EV_param.num_abonado || ',' ||
                                            EV_param.cod_modulo || ',' ||
                                            EV_param.tarea || ',' ||
                                            '''1'', ''0'', pvCodValor, pvErrorAplic, pvErrorGlosa, pvErrorOra, pvErrorOraGlosa, pvTrace);';

  PV_INS_MOV_IDGESTOR_TO_PR(transacabo,
                            EV_param.cod_act,
                            EV_param.mum_mov,
                            EV_param.num_abonado,
                            EV_param.cod_modulo,
                            EV_param.tarea,
                            '1', '0', pvCodValor, pvErrorAplic, pvErrorGlosa, pvErrorOra, pvErrorOraGlosa, pvTrace);


  LV_sSql := 'pv_grabar_simcard_sb_pg.pv_recupera_transacabo_pr('|| transacabo ||', mensaje, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
  respuesta := pv_grabar_simcard_sb_pg.pv_recupera_transacabo_pr(transacabo, mensaje, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  IF(respuesta = '4') THEN
     RAISE_APPLICATION_ERROR(raise_err_def, 'No se pudo ejecutar :PV_INS_MOV_IDGESTOR_TO_PR QRY:' || LV_sSql || 'Secuencia : ' || TO_CHAR(transacabo));
  END IF;


 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, NULL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_IngIntGestor_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
PROCEDURE pv_RestituirCargoBasico_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_RestituirCargoBasico_pr';
  BEGIN


    LV_sSql := 'pv_rec_UltPlanTaifFact_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
    pv_rec_UltPlanTaifFact_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
    IF(EV_param.cod_plantarif <> abonado.cod_cargobasico) THEN
       abonado.cod_cargobasico := EV_param.cod_plantarif;
    END IF;

    LV_sSql := 'pv_recCargobasicSiniestro_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
    pv_recCargobasicSiniestro_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
    IF(EV_param.cod_cargobasico_Sinie IS NULL OR EV_param.cod_cargobasico_Sinie = '') THEN
        RAISE_APPLICATION_ERROR(raise_err_def, 'No existe cargo basico (pv_recCargobasicSiniestro_pr) = ' || EV_param.cod_cargobasico_Sinie);
    END IF;

    LV_sSql := 'pv_RecImpCargoBasico_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
    pv_RecImpCargoBasico_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

    LV_sSql := 'pv_RecImpCargoBasicoCausa_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
    pv_RecImpCargoBasicoCausa_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

    LV_sSql := 'pv_EjecutarPLCargoBasico_pr(EV_param, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
    pv_EjecutarPLCargoBasico_pr(EV_param, abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, EV_param, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_RestituirCargoBasico_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
PROCEDURE pv_rec_UltPlanTaifFact_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_rec_UltPlanTaifFact_pr';
  BEGIN

    LV_sSql :=
    'SELECT COD_PLANTARIF into EV_param.COD_PLANTARIF' ||
    ' FROM ga_intarcel a' ||
    ' WHERE a.num_abonado = ' || EV_param.Num_Abonado  ||
    ' AND a.cod_cliente=  ' || EV_param.Cod_Cliente    ||
    ' AND a.fec_hasta = ' ||
    ' (SELECT max(fec_hasta) FROM ga_intarcel b' ||
    ' WHERE a.cod_cliente=b.cod_cliente AND a.num_abonado = b.num_abonado);';


    SELECT COD_PLANTARIF INTO EV_param.COD_PLANTARIF
    FROM ga_intarcel a
    WHERE a.num_abonado = EV_param.Num_Abonado
    AND a.cod_cliente=  EV_param.Cod_Cliente
    AND a.fec_hasta =
    (SELECT MAX(fec_hasta) FROM ga_intarcel b
    WHERE a.cod_cliente=b.cod_cliente AND a.num_abonado = b.num_abonado);

 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, NULL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_rec_UltPlanTaifFact_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
PROCEDURE pv_recCargobasicSiniestro_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_recCargobasicSiniestro_pr';
  BEGIN

    LV_sSql :=
    'SELECT B.COD_CARGOBASICO' ||
    ' INTO EV_param.cod_cargobasico_Sinie' ||
    ' FROM GA_CAUSINIE B ' ||
    ' WHERE  B.COD_PRODUCTO = ' || cv_prod_celular  ||
    ' AND B.COD_CAUSA = ' || EV_param.cod_causa;

    SELECT B.COD_CARGOBASICO
    INTO EV_param.cod_cargobasico_Sinie
    FROM GA_CAUSINIE B
    WHERE  B.COD_PRODUCTO = cv_prod_celular
    AND B.COD_CAUSA = EV_param.cod_causa;

 EXCEPTION
    WHEN NO_DATA_FOUND THEN
         EV_param.cod_cargobasico_Sinie := NULL;
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, NULL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_recCargobasicSiniestro_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
PROCEDURE pv_RecImpCargoBasico_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_RecImpCargoBasico_pr';
  BEGIN

    LV_sSql :=
    'SELECT IMP_CARGOBASICO ' ||
    ' INTO EV_param.imp_cargobasico' ||
    ' FROM TA_CARGOSBASICO  ' ||
    ' WHERE COD_PRODUCTO =  ' || cv_prod_celular  ||
    ' AND COD_CARGOBASICO = ' || abonado.cod_cargobasico;

    SELECT IMP_CARGOBASICO
    INTO EV_param.imp_cargobasico
    FROM TA_CARGOSBASICO
    WHERE COD_PRODUCTO =  cv_prod_celular
    AND COD_CARGOBASICO = abonado.cod_cargobasico
    AND fec_desde <= SYSDATE
    AND fec_hasta >= SYSDATE;

 EXCEPTION
    WHEN NO_DATA_FOUND THEN
        EV_param.imp_cargobasico := NULL;

    WHEN OTHERS THEN
         grabaError(SV_NombrePL, NULL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_RecImpCargoBasico_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
PROCEDURE pv_RecImpCargoBasicoCausa_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_RecImpCargoBasicoCausa_pr';
  BEGIN

    LV_sSql :=
    'SELECT IMP_CARGOBASICO ' ||
    ' INTO EV_param.imp_cargobasico' ||
    ' FROM TA_CARGOSBASICO  ' ||
    ' WHERE COD_PRODUCTO =  ' || cv_prod_celular  ||
    ' AND COD_CARGOBASICO = ' || abonado.cod_cargobasico||
	' AND fec_desde <= '||SYSDATE||
    ' AND fec_hasta >= '||SYSDATE;

    SELECT imp_cargobasico
      INTO ev_param.imp_cargobasico
      FROM ta_cargosbasico
     WHERE cod_producto =  cv_prod_celular
       AND cod_cargobasico = abonado.cod_cargobasico
	   AND fec_desde <= SYSDATE
       AND fec_hasta >= SYSDATE;

 EXCEPTION
    WHEN NO_DATA_FOUND THEN
         EV_param.imp_cargobasico := NULL;
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, NULL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_RecImpCargoBasicoCausa_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
PROCEDURE pv_EjecutarPLCargoBasico_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
	LV_sSqlAnt               ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_EjecutarPLCargoBasico_pr';
    transacabo               NUMBER(10);
    respuesta                VARCHAR2(1);
    mensaje                  VARCHAR2(255);
  BEGIN


  LV_sSql := 'pv_grabar_simcard_sb_pg.pv_consulta_secuencia_pr(''GA_SEQ_TRANSACABO'', SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
  transacabo := pv_grabar_simcard_sb_pg.pv_consulta_secuencia_pr('GA_SEQ_TRANSACABO', SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  LV_sSql := 'p_interfases_abonados('||     TO_CHAR(transacabo) || ',' ||
                                            'CB,' ||
                                            TO_CHAR(cv_prod_celular) || ',' ||
                                            TO_CHAR(EV_param.num_abonado) || ',' ||
                                            'R,' ||
                                            ''''', '''');';
  LV_sSqlAnt := LV_sSql;

  p_interfases_abonados    (TO_CHAR(transacabo),
                            'CB',
                            TO_CHAR(cv_prod_celular),
                            TO_CHAR(EV_param.num_abonado),
                            'R',
                            '', '');

  LV_sSql := 'pv_grabar_simcard_sb_pg.pv_recupera_transacabo_pr(' || TO_CHAR(transacabo) ||', mensaje, SN_cod_retorno, SV_mens_retorno, SN_num_evento);';
  respuesta := pv_grabar_simcard_sb_pg.pv_recupera_transacabo_pr(transacabo, mensaje, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  IF(respuesta = '4') THEN
     RAISE_APPLICATION_ERROR(-20001, 'No se pudo ejecutar :p_interfases_abonados QRY:' || LV_sSqlAnt || 'Secuencia : ' || TO_CHAR(transacabo));
  END IF;


 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, NULL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_EjecutarPLCargoBasico_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
PROCEDURE pv_BorrarListasNegras_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_BorrarListasNegras_pr';
    EV_cambioserie           PV_CAM_SIMCARD_OT := NEW PV_CAM_SIMCARD_OT();
    transacabo               NUMBER(10);
    respuesta                VARCHAR2(10);
    mensaje                  VARCHAR2(4000);
    LV_CAUSA          GA_SUSPREHABO.COD_CAUSUSP%TYPE;
    LV_CAUSA_REV      GA_LISTACAUSAEIR_TD.COD_CAUSA%TYPE;
    LV_NUM_SERIE      GA_LNCELU.NUM_SERIE%TYPE;  

  BEGIN

  transacabo := pv_grabar_simcard_sb_pg.pv_consulta_secuencia_pr('GA_SEQ_TRANSACABO', SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  --INI|COL-70901|24-11-2008|DVG
  Select num_serie,COD_CAUSA
  Into  EV_param.num_serie,LV_CAUSA
  From ga_siniestros
  Where num_siniestro = EV_param.num_siniestro
  Union All
  Select num_serie,COD_CAUSA
  From ga_hsiniestros
  Where num_siniestro=  EV_param.num_siniestro;
  --FIN|COL-70901|24-11-2008|DVG
  
  
  LV_CAUSA_REV:= NULL;    
  BEGIN 
                
    select cod_causa
    INTO LV_CAUSA_REV
    From GA_LISTACAUSAEIR_TD
    where   cod_tipolista ='B'
    and    cod_os =EV_param.COD_OOSS
    and    ind_causa ='2'
    and sysdate between fec_desde and fec_hasta;
            
  EXCEPTION
        WHEN NO_DATA_FOUND THEN
           NULL;
  END;
             
            
  UPDATE  GA_CAUSAEIR_TO
  SET
  COD_estado ='1'
  ,NOM_USUARIO= USER
  ,COD_OS_REV=EV_param.COD_OOSS
  ,COD_CAUSA_OS_REV= LV_CAUSA
  ,COD_CAUSA_REV=  LV_CAUSA_REV
  WHERE NUM_serie = EV_param.num_serie
  and cod_estado = '0';
  
  

  LV_sSql := 'PV_SERIES_NEGATIVAS_PG.PV_SERIES_NEGATIVAS_PR('|| transacabo ||','
                                                             || EV_param.num_serie||','
                                                             || 'D'||','
                                                             || EV_param.num_abonado||','
                                                             || '0'||','
                                                             || 'PC);';

  PV_SERIES_NEGATIVAS_PG.PV_SERIES_NEGATIVAS_PR(
                            transacabo,
                            TO_CHAR(EV_param.num_serie),
                            'D',
                            EV_param.num_abonado,
                            '0',
                            'PC');

  respuesta := pv_grabar_simcard_sb_pg.pv_recupera_transacabo_pr(transacabo, mensaje, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

  IF(respuesta = '4') THEN
     RAISE_APPLICATION_ERROR(raise_err_def, 'No se pudo ejecutar :PV_SERIES_NEGATIVAS_PG:' || LV_sSql || 'Secuencia : ' || TO_CHAR(transacabo));
  END IF;


 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, NULL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_BorrarListasNegras_pr;
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
PROCEDURE pv_PasoHistorico_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error             ge_errores_pg.DesEvent;
    LV_sSql                  ge_errores_pg.vQuery;
    SV_NombrePL              VARCHAR2(100) := 'pv_PasoHistorico_pr';
  BEGIN

    LV_sSql :=
    'INSERT INTO GA_HDETSINIE' ||
    ' (num_siniestro, cod_estado, fec_detalle,' ||
    ' nom_usuarora,    fec_historico, obs_detalle )' ||
    ' (SELECT ' ||
    ' num_siniestro, cod_estado, fec_detalle,' ||
    ' nom_usuarora, ' || TO_CHAR(EV_param.Fec_Hora, 'dd-mm-yyyy hh24-mi-ss') || ', obs_detalle' ||
    ' FROM Ga_detsinie WHERE num_siniestro = ' || EV_param.num_siniestro || ');';

    INSERT INTO GA_HDETSINIE
    (num_siniestro, cod_estado, fec_detalle,
    nom_usuarora,    fec_historico, obs_detalle )
    (SELECT
    num_siniestro, cod_estado, fec_detalle,
    nom_usuarora, EV_param.Fec_Hora, obs_detalle
    FROM Ga_detsinie WHERE num_siniestro = EV_param.num_siniestro);


    LV_sSql := 'DELETE GA_DETSINIE  WHERE NUM_SINIESTRO = ' || EV_param.num_siniestro;
    DELETE GA_DETSINIE
    WHERE NUM_SINIESTRO = EV_param.num_siniestro;


    LV_sSql :=
    'INSERT INTO GA_HSINIESTROS ( ' ||
    ' NUM_SINIESTRO, NUM_ABONADO, COD_PRODUCTO, COD_CAUSA, COD_ESTADO,' ||
    ' NUM_TERMINAL, NUM_SERIE, FEC_SINIESTRO, FEC_HISTORICO, COD_CARGOBASICO, COD_SERVICIO,' ||
    ' FEC_FORMALIZA, FEC_ANULA, FEC_RESTITUC, NUM_CONSTPOL, NUM_SOLLIQ, NUM_SERIEREP, TIP_TERMINAL,NUM_CONSTPOL_ANULA' ||
    ' ) (SELECT' ||
    ' NUM_SINIESTRO, NUM_ABONADO, COD_PRODUCTO, COD_CAUSA, COD_ESTADO,' ||
    ' NUM_TERMINAL, NUM_SERIE, FEC_SINIESTRO, ' || TO_CHAR(EV_param.fec_hora, 'dd-mm-yyyy hh24-mi-ss') ||
    ' , COD_CARGOBASICO, COD_SERVICIO, ' ||
    ' FEC_FORMALIZA, FEC_ANULA, FEC_RESTITUC, NUM_CONSTPOL, NUM_SOLLIQ, NUM_SERIEREP, TIP_TERMINAL,NUM_CONSTPOL_ANULA' ||
    ' FROM GA_SINIESTROS WHERE NUM_SINIESTRO =' ||  EV_param.num_siniestro  ||');';


    INSERT INTO GA_HSINIESTROS (
    NUM_SINIESTRO, NUM_ABONADO, COD_PRODUCTO, COD_CAUSA, COD_ESTADO,
    NUM_TERMINAL, NUM_SERIE, FEC_SINIESTRO, FEC_HISTORICO, COD_CARGOBASICO, COD_SERVICIO,
    FEC_FORMALIZA, FEC_ANULA, FEC_RESTITUC, NUM_CONSTPOL, NUM_SOLLIQ, NUM_SERIEREP, TIP_TERMINAL,NUM_CONSTPOL_ANULA
    ) (SELECT
    NUM_SINIESTRO, NUM_ABONADO, COD_PRODUCTO, COD_CAUSA, COD_ESTADO,
    NUM_TERMINAL, NUM_SERIE, FEC_SINIESTRO, EV_param.fec_hora
    , COD_CARGOBASICO, COD_SERVICIO,
    FEC_FORMALIZA, FEC_ANULA, FEC_RESTITUC, NUM_CONSTPOL, NUM_SOLLIQ, NUM_SERIEREP, TIP_TERMINAL,NUM_CONSTPOL_ANULA
    FROM GA_SINIESTROS WHERE NUM_SINIESTRO =  EV_param.num_siniestro );


    LV_sSql := 'DELETE GA_SINIESTROS WHERE NUM_SINIESTRO = ' || EV_param.num_siniestro;
    DELETE GA_SINIESTROS WHERE NUM_SINIESTRO = EV_param.num_siniestro;


 EXCEPTION
    WHEN OTHERS THEN
         grabaError(SV_NombrePL, NULL, LV_sSql, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

 END pv_PasoHistorico_pr;
--------------------------------------------------------------------------------------


PROCEDURE pv_anulardenuncia_pr
 (
    EV_param           IN PV_ANULA_SINIESTRO_OT, 
    NUM_CONS_POLANUL   IN GA_SINIESTROS. NUM_CONSTPOL_ANULA%TYPE,  
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento)
 IS
    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql            ge_errores_pg.vQuery;
    SV_NombrePL        VARCHAR2(100) := ' pv_anulardenuncia_pr';
  BEGIN


    LV_sSql :=
     'UPDATE GA_HSINIESTROS SET' ||
    ' SET NUM_CONSTPOL_ANULA  = '||NUM_CONS_POLANUL  ||
    ' WHERE NUM_SINIESTRO = ' || EV_param.num_siniestro;

    UPDATE GA_HSINIESTROS SET
    NUM_CONSTPOL_ANULA  = NUM_CONS_POLANUL   
    WHERE NUM_SINIESTRO = EV_param.num_siniestro;


 EXCEPTION
    WHEN OTHERS THEN
            grabaError(SV_NombrePL, NULL, LV_sSql, SN_cod_retorno,SV_mens_retorno, SN_num_evento);

END pv_anulardenuncia_pr;	

--------------------------------------------------------------------------------------

END pv_anula_siniestro_sb_pg;
/
