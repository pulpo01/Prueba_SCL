CREATE OR REPLACE PACKAGE BODY BP_BENEFICIOS_PROMOCIONES_PG AS
/*-------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION  BP_VERSION_FN RETURN VARCHAR2
IS
  lv_Cadena VARCHAR2(200);
BEGIN
	  lv_Cadena:= 'Versión :'|| CV_version ||'.'||CV_subversion||' -- Fecha Modificación :'||CV_Fecha||' -- Modificado por '|| CV_programador;
	  RETURN lv_Cadena;
END;
/*-------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_VALIDA_COLA_CO_PG (EV_NOM_PROCESO IN VARCHAR2,
                               SN_COD_ERROR     OUT NOCOPY NUMBER,
                               SV_MENS_RETORNO  OUT NOCOPY VARCHAR2
) RETURN NUMBER
IS
  LN_Count NUMBER;
BEGIN

	 SELECT COUNT(0)
	 INTO   LN_Count
	 FROM   co_colasproc a
	 WHERE  a.cod_proceso    =  ev_nom_proceso
	 AND    a.cod_activacion =  CV_batch_habilitado
	 AND    a.cod_estado     =  CV_proceso_wait
	 AND    TO_CHAR(SYSDATE,'HH24:MI:SS') BETWEEN IND_HORAINI AND IND_HORAFIN;

	 RETURN LN_Count;

EXCEPTION
	WHEN OTHERS THEN
		 SN_COD_ERROR 	 := -1;
		 SV_MENS_RETORNO := 'BP_VALIDA_COLA_CO_PG' ||' : '||SQLERRM;
		 RETURN 0;
END;
/*-------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_ACTUALIZA_COLA_CO_FN (EV_NOM_PROCESO     IN VARCHAR2,
		 						  EV_COD_ESTADO_INI	 IN VARCHAR2,
								  EV_COD_ESTADO_FIN	 IN VARCHAR2,
	                              SN_COD_ERROR 	     OUT NOCOPY NUMBER,
                               	  SV_MENS_RETORNO    OUT NOCOPY VARCHAR2)

 RETURN BOOLEAN
IS
BEGIN

	 SN_COD_ERROR    := 0;

	 UPDATE co_colasproc
	 SET 	cod_estado   = ev_cod_estado_fin
	 WHERE  cod_proceso  = ev_nom_proceso
	 AND    cod_estado   = ev_cod_estado_ini;

	 RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		 SN_COD_ERROR 	 := -1;
		 SV_MENS_RETORNO := 'BP_ACTUALIZA_COLA_CO_FN' ||' : '||SQLERRM;
		 RETURN FALSE;
END;
/*-------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_REC_SECUENCIA_FN (EV_NOM_SECUENCIA IN     VARCHAR2) RETURN NUMBER
IS
LV_sql	 			VARCHAR2(250);
LN_secuencia		NUMBER;
BEGIN

	LV_sql := 'SELECT '||EV_NOM_SECUENCIA||'.NEXTVAL FROM DUAL';

	EXECUTE IMMEDIATE LV_sql INTO LN_secuencia;
    RETURN LN_secuencia ;

END BP_REC_SECUENCIA_FN;

/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_REC_CICLO_FN    (EN_COD_CICLFACT   IN FA_CICLFACT.COD_CICLFACT%TYPE,
                             SN_COD_ERROR 	  OUT NOCOPY NUMBER,
                             SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
							 SV_SQL		   	  OUT NOCOPY VARCHAR2
) RETURN NUMBER
IS
  LN_cod_ciclo  fa_ciclfact.cod_ciclo%TYPE;
BEGIN

	SV_SQL:='';

	SELECT   ciclo.cod_ciclo
	INTO   LN_cod_ciclo
	FROM   fa_ciclfact ciclo
	WHERE  ciclo.cod_ciclfact  =  en_cod_ciclfact;

	RETURN LN_cod_ciclo;

EXCEPTION
	WHEN OTHERS THEN
		 SN_COD_ERROR 	 := -1;
		 SV_MENS_RETORNO := 'BP_REC_CICLO_FN' ||' : '||SQLERRM;
		 RETURN 0;
END BP_REC_CICLO_FN;

/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_REC_FA_HIST_FN   (EM_TABLA            IN OUT NOCOPY TIP_ENLACE_HIST_LIST,
                             SN_COD_ERROR 	     OUT NOCOPY NUMBER,
                             SV_MENS_RETORNO     OUT NOCOPY VARCHAR2,
							 SV_SQL		   	     OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS


  LN_cod_ciclo  fa_ciclfact.cod_ciclo%TYPE;

BEGIN

	SV_SQL:='';

	SELECT  enl.fa_detcelular
	BULK   COLLECT INTO EM_TABLA
	FROM   fa_ciclfact cicl, fa_enlacehist enl
	WHERE  sysdate - 7 between cicl.fec_desdellam and cicl.fec_hastallam
    AND    cicl.ind_facturacion = 1
    AND    enl.cod_ciclfact = cicl.cod_ciclfact;

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		 SN_COD_ERROR 	 := -1;
		 SV_MENS_RETORNO := 'BP_REC_FA_HIST_FN' ||' : '||SQLERRM;
		 RETURN FALSE;
END BP_REC_FA_HIST_FN ;

/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_ACT_ACUM_FN     (EN_NUM_SECUENCIA     IN NUMBER,
                             EN_DUR_LLAMADA       IN NUMBER) RETURN NUMBER
IS



BEGIN

	    UPDATE tol_detabondcto_td SET
                cnt_valor = cnt_valor  + en_dur_llamada
        WHERE  num_sec = en_num_secuencia;


	RETURN 0;

EXCEPTION
	WHEN OTHERS THEN
		 RETURN -1;
END BP_ACT_ACUM_FN ;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_REC_TOL_DET_FN  (EN_ID_PROCESO       IN  NUMBER,
                             ED_FECHA_ACTUAL     IN  DATE,
                             EN_INDEX            IN  NUMBER,
                             EM_TABLA            OUT TIP_TOL_DETABONDCTO_TD,
                             SN_COD_ERROR 	     OUT NOCOPY NUMBER,
                             SV_MENS_RETORNO     OUT NOCOPY VARCHAR2,
							 SV_SQL		   	     OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS


  LN_cod_ciclo  fa_ciclfact.cod_ciclo%TYPE;

BEGIN


        IF EN_INDEX = 0 THEN
            select bnf.tip_dcto
                  ,bnf.cod_dcto
                  ,bnf.cod_cliente
                  ,bnf.num_abonado
                  ,bnf.num_secuencia
                  ,bnf.cod_ciclo
                  ,ed_fecha_actual
                  ,trunc(sysdate + dsc.dia_vali)- (1/86400)
                  ,user
                  ,sysdate
                  ,dsc.ind_unidad
                  ,CEIL(sum((decode(dsc.ind_unidad,uni.cod_unidad,(det.dur_llamada/uni.fac_cambio),det.dur_llamada)*(dsc.cnt_valor/100)))) VALORES
                  ,null
            BULK   COLLECT INTO EM_TABLA
            from bp_beneficios_aplicar_to bnf , bp_det_factura_vw det , bp_tol_detdescuento_td dsc , tol_unidad_td uni
            where  bnf.cod_cliente          = det.cod_cliente
            and    bnf.num_abonado          = det.num_abonado
            and    bnf.cod_estado           = CV_epr
            and    dsc.tip_dcto             = bnf.tip_dcto
            and    dsc.cod_dcto             = bnf.cod_dcto
            and    det.cod_agrullam         = dsc.cod_agrullam
            and    uni.cod_unidad           = dsc.ind_unidad
            and    uni.tip_unidad           = det.ind_unidad
            and    det.fec_llamada between (trunc(sysdate) - dsc.dia_eval) and (trunc(sysdate) - (1/86400))
            and    bnf.ide_proceso          = en_id_proceso
            and    dsc.ind_unidad       not in ('V','Q')
             group by bnf.tip_dcto,bnf.cod_dcto,bnf.cod_cliente,bnf.num_abonado,bnf.num_secuencia
                    ,bnf.cod_ciclo,sysdate,sysdate + dsc.dia_vali,user,sysdate,dsc.ind_unidad;
        ELSIF EN_INDEX = 1 THEN
            select bnf.tip_dcto
                  ,bnf.cod_dcto
                  ,bnf.cod_cliente
                  ,bnf.num_abonado
                  ,bnf.num_secuencia
                  ,bnf.cod_ciclo
                  ,ed_fecha_actual
                  ,trunc(sysdate + dsc.dia_vali)- (1/86400)
                  ,user
                  ,sysdate
                  ,dsc.ind_unidad
                  ,CEIL(sum((CN_uno*(dsc.cnt_valor/100))))
                  ,null
            BULK   COLLECT INTO EM_TABLA
            from bp_beneficios_aplicar_to bnf , bp_det_factura_vw det , bp_tol_detdescuento_td dsc , tol_unidad_td uni
            where  bnf.cod_cliente          = det.cod_cliente
            and    bnf.num_abonado          = det.num_abonado
            and    bnf.cod_estado           = CV_epr
            and    dsc.tip_dcto             = bnf.tip_dcto
            and    dsc.cod_dcto             = bnf.cod_dcto
            and    det.cod_agrullam         = dsc.cod_agrullam
            and    uni.cod_unidad           = dsc.ind_unidad
            and    uni.tip_unidad           = det.ind_unidad
            and    det.fec_llamada between (trunc(sysdate) - dsc.dia_eval) and (trunc(sysdate) - (1/86400))
            and    bnf.ide_proceso          = en_id_proceso
            and    dsc.ind_unidad        = 'Q'
             group by bnf.tip_dcto,bnf.cod_dcto,bnf.cod_cliente,bnf.num_abonado,bnf.num_secuencia
            ,bnf.cod_ciclo,sysdate,sysdate + dsc.dia_vali,user,sysdate,dsc.ind_unidad;
        ELSIF EN_INDEX = 2 THEN
            select bnf.tip_dcto
                  ,bnf.cod_dcto
                  ,bnf.cod_cliente
                  ,bnf.num_abonado
                  ,bnf.num_secuencia
                  ,bnf.cod_ciclo
                  ,ed_fecha_actual
                  ,trunc(sysdate + dsc.dia_vali)- (1/86400)
                  ,user
                  ,sysdate
                  ,dsc.ind_unidad
                  ,sum((det.mto_real)*(dsc.cnt_valor/100))
                  ,null
            BULK   COLLECT INTO EM_TABLA
            from bp_beneficios_aplicar_to bnf , bp_det_factura_vw det , bp_tol_detdescuento_td dsc 
            where  bnf.cod_cliente          = det.cod_cliente
            and    bnf.num_abonado          = det.num_abonado
            and    bnf.cod_estado           = CV_epr
            and    dsc.tip_dcto             = bnf.tip_dcto
            and    dsc.cod_dcto             = bnf.cod_dcto
            and    det.cod_agrullam         = dsc.cod_agrullam
            and    det.fec_llamada between (trunc(sysdate) - dsc.dia_eval) and (trunc(sysdate) - (1/86400))
            and    bnf.ide_proceso          = en_id_proceso
            and    dsc.ind_unidad           = 'V'
             group by bnf.tip_dcto,bnf.cod_dcto,bnf.cod_cliente,bnf.num_abonado,bnf.num_secuencia
            ,bnf.cod_ciclo,sysdate,sysdate + dsc.dia_vali,user,sysdate,dsc.ind_unidad;
        ELSIF EN_INDEX = 3 THEN
            select distinct
                   bnf.tip_dcto
                  ,bnf.cod_dcto
                  ,bnf.cod_cliente
                  ,bnf.num_abonado
                  ,bnf.num_secuencia
                  ,bnf.cod_ciclo
                  ,ed_fecha_actual
                  ,trunc(sysdate + dsc.dia_vali)- (1/86400)
                  ,user
                  ,sysdate
                  ,dsc.ind_unidad
                  ,dsc.cnt_valor
                  ,NULL
            BULK   COLLECT INTO EM_TABLA
            from bp_beneficios_aplicar_to bnf , tol_detdescuento_td dsc 
            where  bnf.cod_estado           = CV_epr
            and    dsc.tip_dcto             = bnf.tip_dcto
            and    dsc.cod_dcto             = bnf.cod_dcto
            and    bnf.ide_proceso          = en_id_proceso;            
        END IF;

	SV_SQL:='';

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		 SN_COD_ERROR 	 := -1;
		 SV_MENS_RETORNO := 'BP_REC_TOL_DET_FN ' ||' : '||SQLERRM;
		 RETURN FALSE;
END BP_REC_TOL_DET_FN ;


/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_REC_CLIE_DCTO_FN  (EN_ID_PROCESO       IN  NUMBER,
                               EN_INDEX            IN  NUMBER,
                               ED_FECHA_ACTUAL     IN  DATE,
                               EV_FECHA_ACTUAL     IN  VARCHAR2,
                               EV_NOM_TABLA        IN  VARCHAR2,
                               EM_TABLA            OUT TIP_TOL_CLIEDCTO_TO,
                               SN_COD_ERROR 	   OUT NOCOPY NUMBER,
                               SV_MENS_RETORNO     OUT NOCOPY VARCHAR2,
							   SV_SQL		   	   OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS


BEGIN

        IF EN_INDEX  = 0 THEN
            select distinct
                   bnf.tip_dcto
                  ,bnf.cod_dcto
                  ,bnf.cod_cliente
                  ,CN_uno
                  ,ed_fecha_actual
                  ,trunc(sysdate + dsc.dia_vali)- (1/86400)
                  ,pln.ind_aplica
                  ,'C'
                  ,USER
                  ,SYSDATE
                  ,0
                  ,pln.ind_rest_hora
                BULK   COLLECT INTO EM_TABLA
                from bp_beneficios_aplicar_to bnf , bp_det_factura_vw det , bp_tol_detdescuento_td dsc , tol_descuento_td pln
                where  bnf.cod_cliente          = det.cod_cliente
                and    bnf.num_abonado          = det.num_abonado
                and    bnf.cod_estado           = CV_epr
                and    dsc.tip_dcto             = bnf.tip_dcto
                and    dsc.cod_dcto             = bnf.cod_dcto
                and    det.cod_agrullam         = dsc.cod_agrullam
                and    det.fec_llamada between (trunc(sysdate) - dsc.dia_eval) and (trunc(sysdate) - (1/86400))
                and    pln.tip_dcto             = dsc.tip_dcto
                and    pln.cod_dcto             = dsc.cod_dcto
                and    bnf.ide_proceso          = en_id_proceso;
        ELSIF EN_INDEX = 1 THEN
                SV_SQL := ' select distinct bnf.tip_dcto';
                SV_SQL := SV_SQL || ' ,bnf.cod_dcto';
                SV_SQL := SV_SQL || ' ,bnf.cod_cliente';
                SV_SQL := SV_SQL || ' ,' || CN_uno;
                SV_SQL := SV_SQL || ' ,to_date('''|| ev_fecha_actual ||''',''dd-mm-yyyy hh24:mi:ss'')';
                SV_SQL := SV_SQL || ' ,trunc(sysdate + dsc.dia_vali)- (1/86400)';
                SV_SQL := SV_SQL || ' ,pln.ind_aplica ';
                SV_SQL := SV_SQL || ' ,''C''';
                SV_SQL := SV_SQL || ' ,USER';
                SV_SQL := SV_SQL || ' ,SYSDATE';
                SV_SQL := SV_SQL || ' ,''0''';
                SV_SQL := SV_SQL || ' ,pln.ind_rest_hora';
                SV_SQL := SV_SQL || ' from bp_beneficios_aplicar_to bnf ,';
                SV_SQL := SV_SQL ||   ev_nom_tabla || ' det , bp_tol_detdescuento_td dsc, tol_descuento_td pln, tol_tipollam_td b';
                SV_SQL := SV_SQL || ' where  bnf.cod_cliente          = det.num_clie';
                SV_SQL := SV_SQL || ' and    bnf.num_abonado          = det.num_abon';
                SV_SQL := SV_SQL || ' and    bnf.cod_estado           = '''|| CV_epr || '''';
                SV_SQL := SV_SQL || ' and    dsc.tip_dcto             = bnf.tip_dcto';
                SV_SQL := SV_SQL || ' and    dsc.cod_dcto             = bnf.cod_dcto';
                SV_SQL := SV_SQL || ' and    dsc.tip_dcto             = bnf.tip_dcto';
                SV_SQL := SV_SQL || ' and    dsc.cod_dcto             = bnf.cod_dcto';
                SV_SQL := SV_SQL || ' and    det.cod_agrl             = dsc.cod_agrullam';
                SV_SQL := SV_SQL || ' and    to_date(det.date_start_charg,''yyyymmdd'') between (trunc(sysdate) - dsc.dia_eval) and (trunc(sysdate) - (1/86400))';
                SV_SQL := SV_SQL || ' and    pln.tip_dcto             = dsc.tip_dcto';
                SV_SQL := SV_SQL || ' and    pln.cod_dcto             = dsc.cod_dcto';
                SV_SQL := SV_SQL || ' and    det.cod_llam             = b.cod_llam';
                SV_SQL := SV_SQL || ' and    det.cod_sent             = b.cod_sentido';
                SV_SQL := SV_SQL || ' and    bnf.ide_proceso          ='||EN_ID_PROCESO;        
                EXECUTE IMMEDIATE SV_SQL BULK COLLECT INTO EM_TABLA;
        ELSIF EN_INDEX = 2 THEN
            select distinct
                   bnf.tip_dcto
                  ,bnf.cod_dcto
                  ,bnf.cod_cliente
                  ,CN_uno
                  ,ed_fecha_actual
                  ,trunc(sysdate + pln.dia_vali)- (1/86400)
                  ,pln.ind_aplica
                  ,'A'
                  ,USER
                  ,SYSDATE
                  ,0
                  ,pln.ind_rest_hora
                BULK   COLLECT INTO EM_TABLA
                from bp_beneficios_aplicar_to bnf , tol_descuento_td pln
                where  bnf.cod_estado           = CV_epr
                and    pln.tip_dcto             = bnf.tip_dcto
                and    pln.cod_dcto             = bnf.cod_dcto
                and    bnf.ide_proceso          = en_id_proceso;
        END IF;
	SV_SQL:='';

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		 SN_COD_ERROR 	 := -1;
		 SV_MENS_RETORNO := 'BP_REC_CLIE_DCTO_FN ' ||' : '||SQLERRM;
		 RETURN FALSE;
END BP_REC_CLIE_DCTO_FN ;

/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_REC_FA_DET_FN  (EN_ID_PROCESO       IN  NUMBER,
                            EV_NOM_TABLA        IN  VARCHAR2,
                            EV_FECHA_ACTUAL     IN  VARCHAR2,
                            EM_TABLA            OUT TIP_TOL_DETABONDCTO_TD,
                            SN_COD_ERROR 	    OUT NOCOPY NUMBER,
                            SV_MENS_RETORNO     OUT NOCOPY VARCHAR2,
							SV_SQL		   	    OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS
BEGIN

    SV_SQL := ' select bnf.tip_dcto';
    SV_SQL := SV_SQL || ' ,bnf.cod_dcto';
    SV_SQL := SV_SQL || ' ,bnf.cod_cliente';
    SV_SQL := SV_SQL || ' ,bnf.num_abonado';
    SV_SQL := SV_SQL || ' ,bnf.num_secuencia';
    SV_SQL := SV_SQL || ' ,bnf.cod_ciclo';
    SV_SQL := SV_SQL || ' ,to_date('''||ev_fecha_actual||''',''DD-MM-YYYY HH24:MI:SS'')';
    SV_SQL := SV_SQL || ' ,trunc(sysdate + dsc.dia_vali)- (1/86400)';
    SV_SQL := SV_SQL || ' ,user ';
    SV_SQL := SV_SQL || ' ,sysdate';
    SV_SQL := SV_SQL || ' ,dsc.ind_unidad';
    SV_SQL := SV_SQL || ' ,CEIL(sum((decode(dsc.ind_unidad,uni.cod_unidad,(det.dur_real/uni.fac_cambio),det.dur_real)*(dsc.cnt_valor/100))))';
    SV_SQL := SV_SQL || ' from bp_beneficios_aplicar_to bnf ,';
    SV_SQL := SV_SQL ||   ev_nom_tabla || ' det , bp_tol_detdescuento_td dsc,tol_unidad_td uni, tol_tipollam_td b';
    SV_SQL := SV_SQL || ' where  bnf.cod_cliente          = det.num_clie';
    SV_SQL := SV_SQL || ' and    bnf.num_abonado          = det.num_abon';
    SV_SQL := SV_SQL || ' and    bnf.cod_estado           = '''|| CV_epr || '''';
    SV_SQL := SV_SQL || ' and    dsc.tip_dcto             = bnf.tip_dcto';
    SV_SQL := SV_SQL || ' and    dsc.cod_dcto             = bnf.cod_dcto';
    SV_SQL := SV_SQL || ' and    det.cod_agrl             = dsc.cod_agrullam';
    SV_SQL := SV_SQL || ' and    uni.cod_unidad           = dsc.ind_unidad';
    SV_SQL := SV_SQL || ' and    uni.tip_unidad           = b.cod_unidad';
    SV_SQL := SV_SQL || ' and    to_date(det.date_start_charg,''yyyymmdd'') between (trunc(sysdate) - dsc.dia_eval) and (trunc(sysdate) - (1/86400))';
    SV_SQL := SV_SQL || ' and    bnf.ide_proceso          ='||EN_ID_PROCESO;
    SV_SQL := SV_SQL || ' and    dsc.ind_unidad     not in (''V'',''Q'')';
    SV_SQL := SV_SQL || ' and    det.cod_llam            = b.cod_llam';
    SV_SQL := SV_SQL || ' and    det.cod_sent            = b.cod_sentido';
    SV_SQL := SV_SQL || ' group by bnf.tip_dcto,bnf.cod_dcto,bnf.cod_cliente,bnf.num_abonado,bnf.num_secuencia';
    SV_SQL := SV_SQL || ',bnf.cod_ciclo,sysdate,sysdate + dsc.dia_vali,user,sysdate,dsc.ind_unidad';
    SV_SQL := SV_SQL || ' union';
    SV_SQL := SV_SQL || ' select bnf.tip_dcto';
    SV_SQL := SV_SQL || ' ,bnf.cod_dcto';
    SV_SQL := SV_SQL || ' ,bnf.cod_cliente';
    SV_SQL := SV_SQL || ' ,bnf.num_abonado';
    SV_SQL := SV_SQL || ' ,bnf.num_secuencia';
    SV_SQL := SV_SQL || ' ,bnf.cod_ciclo';
    SV_SQL := SV_SQL || ' ,to_date('''||ev_fecha_actual||''',''DD-MM-YYYY HH24:MI:SS'')';
    SV_SQL := SV_SQL || ' ,trunc(sysdate + dsc.dia_vali)- (1/86400)';
    SV_SQL := SV_SQL || ' ,user ';
    SV_SQL := SV_SQL || ' ,sysdate';
    SV_SQL := SV_SQL || ' ,dsc.ind_unidad';
    SV_SQL := SV_SQL || ' ,CEIL(sum(('||CN_uno||'*(dsc.cnt_valor/100))))';
    SV_SQL := SV_SQL || ' from bp_beneficios_aplicar_to bnf ,';
    SV_SQL := SV_SQL ||   ev_nom_tabla || ' det , bp_tol_detdescuento_td dsc,tol_unidad_td uni, tol_tipollam_td b';
    SV_SQL := SV_SQL || ' where  bnf.cod_cliente          = det.num_clie';
    SV_SQL := SV_SQL || ' and    bnf.num_abonado          = det.num_abon';
    SV_SQL := SV_SQL || ' and    bnf.cod_estado           = '''|| CV_epr || '''';
    SV_SQL := SV_SQL || ' and    dsc.tip_dcto             = bnf.tip_dcto';
    SV_SQL := SV_SQL || ' and    dsc.cod_dcto             = bnf.cod_dcto';
    SV_SQL := SV_SQL || ' and    det.cod_agrl             = dsc.cod_agrullam';
    SV_SQL := SV_SQL || ' and    uni.cod_unidad           = dsc.ind_unidad';
    SV_SQL := SV_SQL || ' and    uni.tip_unidad           = b.cod_unidad';
    SV_SQL := SV_SQL || ' and    to_date(det.date_start_charg,''yyyymmdd'') between (trunc(sysdate) - dsc.dia_eval) and (trunc(sysdate) - (1/86400))';
    SV_SQL := SV_SQL || ' and    bnf.ide_proceso          ='||EN_ID_PROCESO;
    SV_SQL := SV_SQL || ' and    dsc.ind_unidad           = ''Q''';
    SV_SQL := SV_SQL || ' and    det.cod_llam            = b.cod_llam';
    SV_SQL := SV_SQL || ' and    det.cod_sent            = b.cod_sentido';
    SV_SQL := SV_SQL || ' group by bnf.tip_dcto,bnf.cod_dcto,bnf.cod_cliente,bnf.num_abonado,bnf.num_secuencia';
    SV_SQL := SV_SQL || ',bnf.cod_ciclo,sysdate,sysdate + dsc.dia_vali,user,sysdate,dsc.ind_unidad';
    SV_SQL := SV_SQL || ' union';
    SV_SQL := SV_SQL || ' select bnf.tip_dcto';
    SV_SQL := SV_SQL || ' ,bnf.cod_dcto';
    SV_SQL := SV_SQL || ' ,bnf.cod_cliente';
    SV_SQL := SV_SQL || ' ,bnf.num_abonado';
    SV_SQL := SV_SQL || ' ,bnf.num_secuencia';
    SV_SQL := SV_SQL || ' ,bnf.cod_ciclo';
    SV_SQL := SV_SQL || ' ,to_date('''||ev_fecha_actual||''',''DD-MM-YYYY HH24:MI:SS'')';
    SV_SQL := SV_SQL || ' ,trunc(sysdate + dsc.dia_vali)- (1/86400)';
    SV_SQL := SV_SQL || ' ,user ';
    SV_SQL := SV_SQL || ' ,sysdate';
    SV_SQL := SV_SQL || ' ,dsc.ind_unidad';
    SV_SQL := SV_SQL || ' ,sum((det.mto_real)*(dsc.cnt_valor/100))';
    SV_SQL := SV_SQL || ' from bp_beneficios_aplicar_to bnf ,';
    SV_SQL := SV_SQL ||   ev_nom_tabla || ' det , bp_tol_detdescuento_td dsc, tol_tipollam_td b';
    SV_SQL := SV_SQL || ' where  bnf.cod_cliente          = det.num_clie';
    SV_SQL := SV_SQL || ' and    bnf.num_abonado          = det.num_abon';
    SV_SQL := SV_SQL || ' and    bnf.cod_estado           = '''|| CV_epr || '''';
    SV_SQL := SV_SQL || ' and    dsc.tip_dcto             = bnf.tip_dcto';
    SV_SQL := SV_SQL || ' and    dsc.cod_dcto             = bnf.cod_dcto';
    SV_SQL := SV_SQL || ' and    det.cod_agrl             = dsc.cod_agrullam';
    SV_SQL := SV_SQL || ' and    to_date(det.date_start_charg,''yyyymmdd'') between (trunc(sysdate) - dsc.dia_eval) and (trunc(sysdate) - (1/86400))';
    SV_SQL := SV_SQL || ' and    bnf.ide_proceso          ='||EN_ID_PROCESO;
    SV_SQL := SV_SQL || ' and    dsc.ind_unidad           = ''V''';
    SV_SQL := SV_SQL || ' and    det.cod_llam            = b.cod_llam';
    SV_SQL := SV_SQL || ' and    det.cod_sent            = b.cod_sentido';
    SV_SQL := SV_SQL || ' group by bnf.tip_dcto,bnf.cod_dcto,bnf.cod_cliente,bnf.num_abonado,bnf.num_secuencia';
    SV_SQL := SV_SQL || ',bnf.cod_ciclo,sysdate,sysdate + dsc.dia_vali,user,sysdate,dsc.ind_unidad';


    EXECUTE IMMEDIATE SV_SQL BULK COLLECT INTO EM_TABLA;
	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		 SN_COD_ERROR 	 := -1;
		 SV_MENS_RETORNO := 'BP_REC_FA_DET_FN ' ||' : '||SQLERRM;
		 RETURN FALSE;
END BP_REC_FA_DET_FN ;



/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_REG_CABECERA_FN (EM_TABLA         IN  TIP_BP_CABECERA_BENEFICIOS_TD,
                             SN_COD_ERROR 	  OUT NOCOPY NUMBER,
                             SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
							 SV_SQL		   	  OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS
BEGIN

	SV_SQL:='';

    FORALL i IN 1..EM_TABLA.COUNT
    INSERT INTO BP_CABECERA_BENEFICIOS_TD VALUES EM_TABLA(i);

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		 SN_COD_ERROR 	 := -1;
		 SV_MENS_RETORNO := 'BP_REG_CABECERA_FN' ||' : '||SQLERRM;
		 RETURN FALSE;
END BP_REG_CABECERA_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_REG_BENEFICIOS_FN (EM_TABLA         IN  TIP_BPT_BENEFICIOS,
                               SN_COD_ERROR 	OUT NOCOPY NUMBER,
                               SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
							   SV_SQL		   	OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS
BEGIN

	SV_SQL:='';
    FORALL i IN 1..EM_TABLA.COUNT
    INSERT INTO BPT_BENEFICIOS VALUES EM_TABLA(i);

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		 SN_COD_ERROR 	 := -1;
		 SV_MENS_RETORNO := 'BP_REG_BENEFICIOS_FN' ||' : '||SQLERRM;
		 RETURN FALSE;
END BP_REG_BENEFICIOS_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_REG_TOL_CLIEDCTO_FN (EM_TABLA        IN  TIP_TOL_CLIEDCTO_TO,
                                 EN_INDICE       IN  NUMBER,
                                 SN_COD_ERROR 	 OUT NOCOPY NUMBER,
                                 SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
							     SV_SQL		   	 OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS
i     NUMBER;
iReg  NUMBER;
BEGIN

	SV_SQL:='';

    FOR i IN EN_INDICE..EM_TABLA.COUNT LOOP
        iReg := i;
        INSERT INTO TOL_CLIEDCTO_TO VALUES EM_TABLA(i);
    END LOOP;
	RETURN TRUE;
EXCEPTION
	WHEN OTHERS THEN
         IF SQLCODE = -1 THEN
            BEGIN
                IF BP_REG_TOL_CLIEDCTO_FN (EM_TABLA,iReg+1,SN_COD_ERROR,SV_MENS_RETORNO,SV_SQL) THEN
                    RETURN TRUE;
                ELSE
                    RETURN FALSE;
                END IF;
            END;
          ELSE
             SN_COD_ERROR 	 := -1;
             SV_MENS_RETORNO := 'BP_REG_TOL_CLIEDCTO_FN' ||' : '||SQLERRM;
             RETURN FALSE;
         END IF;
    
END BP_REG_TOL_CLIEDCTO_FN;

/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_REG_TOL_DETABONDCTO_FN (EM_TABLA         IN  TIP_TOL_DETABONDCTO_TD,
                                    EN_INDICE        IN  NUMBER,
                                    SN_COD_ERROR 	 OUT NOCOPY NUMBER,
                                    SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
							        SV_SQL		   	 OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS
 iRet  NUMBER;
 i     NUMBER;
 iReg  NUMBER;
BEGIN

	SV_SQL:='';
    
    FOR i IN EN_INDICE..EM_TABLA.COUNT LOOP
        iReg := i;
        INSERT INTO TOL_DETABONDCTO_TD VALUES EM_TABLA(i);
    END LOOP;
	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
         IF SQLCODE = -1 THEN
            BEGIN
               
               
                iRet:= BP_ACT_ACUM_FN(EM_TABLA(iReg).NUM_SEC, EM_TABLA(iReg).CNT_VALOR);
                IF BP_REG_TOL_DETABONDCTO_FN (EM_TABLA,iReg+1,SN_COD_ERROR,SV_MENS_RETORNO,SV_SQL) THEN
                    RETURN TRUE;
                ELSE
                    RETURN FALSE;
                END IF;
            END;
          ELSE
             SN_COD_ERROR 	 := -1;
             SV_MENS_RETORNO := 'BP_REG_TOL_DETABONDCTO_FN' ||' : '||SQLERRM;
             RETURN FALSE;
             
         END IF;

END BP_REG_TOL_DETABONDCTO_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_REC_CABECERA_FN (EM_TABLA         IN OUT  TIP_BP_CABECERA_BENEFICIOS_TD,
                             SN_COD_ERROR 	  OUT NOCOPY NUMBER,
                             SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
							 SV_SQL		   	  OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS


  ln_ide_proceso  BP_CABECERA_BENEFICIOS_TD.ide_proceso%TYPE;

BEGIN

	SV_SQL:='';

	ln_ide_proceso := EM_TABLA(1).ide_proceso;

	SV_SQL:='SELECT   cab.ide_proceso';
	SV_SQL:=SV_SQL||' ,cab.cod_proceso ';
	SV_SQL:=SV_SQL||' ,cab.cod_ciclfact ';
	SV_SQL:=SV_SQL||' ,cab.fec_inicio ';
	SV_SQL:=SV_SQL||' ,cab.fec_final ';
	SV_SQL:=SV_SQL||' ,cab.tot_beneficiarios ';
	SV_SQL:=SV_SQL||' ,cab.tot_reevaluados ';
	SV_SQL:=SV_SQL||' ,cab.tot_excluidos ';
	SV_SQL:=SV_SQL||' ,cab.tot_aplicados ';
	SV_SQL:=SV_SQL||' ,cab.tot_error ';
	SV_SQL:=SV_SQL||' ,cab.tip_proceso ';
	SV_SQL:=SV_SQL||' ,cab.cod_estado ';
	SV_SQL:=SV_SQL||' ,cab.tip_beneficio ';
	SV_SQL:=SV_SQL||' ,cab.num_job ';
	SV_SQL:=SV_SQL||' FROM   bp_cabecera_beneficios_td cab ';
	SV_SQL:=SV_SQL||' WHERE  cab.ide_proceso  ='|| ln_ide_proceso;
	SELECT   cab.ide_proceso
			,cab.cod_proceso
			,cab.cod_ciclfact
			,cab.fec_inicio
			,cab.fec_final
			,cab.tot_beneficiarios
			,cab.tot_reevaluados
			,cab.tot_excluidos
			,cab.tot_aplicados
			,cab.tot_error
			,cab.tip_proceso
			,cab.cod_estado
			,cab.tip_beneficio
			,cab.num_job
	BULK   COLLECT INTO EM_TABLA
	FROM   BP_CABECERA_BENEFICIOS_TD cab
	WHERE  cab.ide_proceso  = ln_ide_proceso;

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		 SN_COD_ERROR 	 := -1;
		 SV_MENS_RETORNO := 'BP_REG_CABECERA_FN' ||' : '||SQLERRM;
		 RETURN FALSE;
END BP_REC_CABECERA_FN;
/*--------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_REC_BENEF_APLI_FN (EM_TABLA         IN OUT  TIP_BPT_BENEFICIOS,
                               EN_IDE_PROCESO	IN  NUMBER,
							   SN_COD_ERROR 	OUT NOCOPY NUMBER,
                               SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
							   SV_SQL		   	OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS


  ln_ide_proceso  BP_CABECERA_BENEFICIOS_TD.ide_proceso%TYPE;
  ln_total        NUMBER;
BEGIN

	SV_SQL:='';

	ln_ide_proceso := en_ide_proceso;

	SELECT	  /*+ full */
			  apli.cod_cliente,
			  apli.num_secuencia,
			  apli.num_ident,
			  apli.num_abonado,
			  apli.cod_plan,
			  apli.sec_periodo,
			  apli.cod_estado,
			  apli.fec_estado,
			  apli.cod_ciclfact,
			  apli.fec_ejecprog,
			  apli.fec_desdeapli,
			  apli.fec_ingreso,
			  NULL,
			  NULL
	BULK   COLLECT INTO EM_TABLA
	FROM  BP_BENEFICIOS_APLICAR_TO apli
	WHERE apli.ide_proceso  = ln_ide_proceso;

	ln_total := EM_TABLA.COUNT;

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		 SN_COD_ERROR 	 := -1;
		 SV_MENS_RETORNO := 'BP_REC_BENEF_APLI_FN' ||' : '||SQLERRM;
		 RETURN FALSE;
END BP_REC_BENEF_APLI_FN;


/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_ACT_CABECERA_FN (EM_TABLA         IN OUT  TIP_BP_CABECERA_BENEFICIOS_TD,
                             SN_COD_ERROR 	  OUT NOCOPY NUMBER,
                             SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
							 SV_SQL		   	  OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS

  ln_ide_proceso  BP_CABECERA_BENEFICIOS_TD.ide_proceso%TYPE;

BEGIN

	SV_SQL:='';

	ln_ide_proceso := EM_TABLA(1).ide_proceso;

	UPDATE BP_CABECERA_BENEFICIOS_TD
	SET	 cod_proceso        = EM_TABLA(1).cod_proceso
		,cod_ciclfact       = EM_TABLA(1).cod_ciclfact
		,fec_inicio         = EM_TABLA(1).fec_inicio
		,fec_final          = EM_TABLA(1).fec_final
		,tot_beneficiarios  = EM_TABLA(1).tot_beneficiarios
		,tot_reevaluados    = EM_TABLA(1).tot_reevaluados
		,tot_excluidos      = EM_TABLA(1).tot_excluidos
		,tot_aplicados      = EM_TABLA(1).tot_aplicados
		,tot_error          = EM_TABLA(1).tot_error
		,tip_proceso        = EM_TABLA(1).tip_proceso
		,cod_estado         = EM_TABLA(1).cod_estado
		,tip_beneficio      = EM_TABLA(1).tip_beneficio
	WHERE ide_proceso  		= ln_ide_proceso;


	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		 SN_COD_ERROR 	 := -1;
		 SV_MENS_RETORNO := 'BP_REG_CABECERA_FN' ||' : '||SQLERRM;
		 RETURN FALSE;
END BP_ACT_CABECERA_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_ACT_ESTADO_ASIG_FN (EM_TABLA         IN OUT  TIP_BP_CABECERA_BENEFICIOS_TD,
                                SN_COD_ERROR 	 OUT NOCOPY NUMBER,
                                SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
							 	SV_SQL		   	 OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS
  ln_ide_proceso  BP_CABECERA_BENEFICIOS_TD.ide_proceso%TYPE;

BEGIN

	SV_SQL:='';

	ln_ide_proceso := EM_TABLA(1).ide_proceso;

	UPDATE  bpt_beneficiarios benef SET
		    benef.cod_estado = cv_terminado
		   ,benef.fec_estado = sysdate
	WHERE   benef.ROWID IN (SELECT apli.row_id FROM  BP_BENEFICIOS_APLICAR_TO apli
		   		   		    WHERE apli.ide_proceso   =  ln_ide_proceso
				   		    AND   apli.num_periodos	 =  apli.sec_periodo)
	AND   benef.cod_estado = cv_vigente;



	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		 SN_COD_ERROR 	 := -1;
		 SV_MENS_RETORNO := 'BP_ACT_ESTADO_ASIG_FN' ||' : '||SQLERRM;
		 RETURN FALSE;
END BP_ACT_ESTADO_ASIG_FN;

/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_ACT_ESTADO_EXC_FN (EM_TABLA         IN OUT  TIP_BP_BENEFICIOS_APLICAR_TO,
		 					   SN_TOT_EXC		OUT NUMBER,
                               SN_COD_ERROR 	OUT NOCOPY NUMBER,
                               SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
							   SV_SQL		    OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS

  ln_ide_proceso   BP_BENEFICIOS_APLICAR_TO.ide_proceso%TYPE;
  lv_cod_estado	   BP_BENEFICIOS_APLICAR_TO.cod_estado%TYPE;
  lv_ind_exclusion BP_BENEFICIOS_APLICAR_TO.ind_exclusion%TYPE;
BEGIN

	SV_SQL:='';

	ln_ide_proceso   := EM_TABLA(1).ide_proceso;
	lv_cod_estado    := EM_TABLA(1).cod_estado;
	lv_ind_exclusion := EM_TABLA(1).ind_exclusion;


        UPDATE bp_beneficios_aplicar_to bp
        SET    bp.cod_estado 	= LV_cod_estado
        WHERE  bp.ide_proceso   = LN_ide_proceso
        AND    bp.cod_estado   != LV_cod_estado
        AND    bp.ind_exclusion = LV_ind_exclusion
        AND    EXISTS ( SELECT benef.num_abonado FROM bp_beneficiarios_pospago_ml_vw benef, bp_beneficiarios_pospago_ml_vw benex, bpd_planexclu exclu
                        WHERE  benef.cod_plan      = bp.cod_plan
                        AND    benef.num_abonado   = bp.num_abonado
                        AND    exclu.cod_plana     = benef.cod_plan
                        AND    exclu.fec_desdeapli!= benef.fec_desdeapli
                        AND    exclu.plan_aplicar != benef.cod_plan
                        AND    benex.cod_cliente   = benef.cod_cliente
                        AND    benex.num_abonado   = benef.num_abonado
                        AND    benex.cod_plan      = exclu.plan_aplicar
                        AND    benex.fec_desdeapli = exclu.fec_desdeapli );

	SN_TOT_EXC := SQL%ROWCOUNT;

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		 SN_COD_ERROR 	 := -1;
		 SV_MENS_RETORNO := 'BP_ACT_ESTADO_EXC_FN' ||' : '||SQLERRM;
		 RETURN FALSE;
END BP_ACT_ESTADO_EXC_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_BORRA_TMP_FN (EN_IDE_PROCESO	IN  NUMBER,
                          SN_COD_ERROR 	    OUT NOCOPY NUMBER,
                          SV_MENS_RETORNO   OUT NOCOPY VARCHAR2,
						  SV_SQL		    OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS

  lv_sentencia VARCHAR2(100);

BEGIN

    DELETE FROM BP_BENEFICIOS_APLICAR_TO
    WHERE IDE_PROCESO = EN_IDE_PROCESO;
	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		 SN_COD_ERROR 	 := -1;
		 SV_MENS_RETORNO := 'BP_BORRA_TMP_FN' ||' : '||SQLERRM;
		 RETURN FALSE;
END BP_BORRA_TMP_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_SEGMENTACION_ML_A_FN(EM_TABLA         IN OUT  TIP_BP_CABECERA_BENEFICIOS_TD,
		 					     EM_BENEFICIARIOS IN OUT  TIP_BP_BENEFICIOS_APLICAR_TO,
                                 EN_INDEX         IN NUMBER,
                                 SN_COD_ERROR 	 OUT NOCOPY NUMBER,
                             	 SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
							 	 SV_SQL		   	 OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS
  ln_ide_proceso  BP_CABECERA_BENEFICIOS_TD.ide_proceso%TYPE;

BEGIN

	SV_SQL:='';


	ln_ide_proceso := EM_TABLA(1).ide_proceso;

        IF EN_INDEX = 1 THEN
			SELECT  ln_ide_proceso
			   ,BP_SEC_BENEFICIO.NEXTVAL
			   ,benef.cod_cliente
			   ,benef.num_abonado
			   ,benef.num_ident
			   ,benef.fec_ingreso
			   ,benef.cod_plan
			   ,benef.fec_desdeapli
			   ,NULL
			   ,benef.ind_exclusion
			   ,benef.tip_entidad
			   ,benef.num_periodos
			   ,benefa.sec_periodo + 1
			   ,CV_epr
			   ,SYSDATE
			   ,cicl.cod_ciclfact
			   ,SYSDATE
			   ,benef.row_id
			   ,CN_cero
               ,CN_cero
               ,benef.cod_ciclo
			   ,CN_cero
			   ,benef.tip_beneficio
			   ,benef.cod_dcto
			   ,benef.tip_dcto
			   ,NULL
			   ,NULL
		BULK   COLLECT INTO EM_BENEFICIARIOS
		FROM  bp_beneficiarios_pospago_ml_vw benef,bpt_beneficios benefa ,fa_ciclfact cicl
		WHERE cicl.cod_ciclo     = benef.cod_ciclo
		AND   SYSDATE BETWEEN cicl.fec_desdellam AND  cicl.fec_hastallam
        AND   benefa.num_secuencia =  (select max(apli.num_secuencia) from bpt_beneficios apli
                                       where apli.cod_cliente  =  benef.cod_cliente
                                       and   apli.num_abonado  =  benef.num_abonado
                                       and   apli.cod_plan     =  benef.cod_plan
                                       and   apli.fec_desdeapli=  benef.fec_desdeapli);        

    ELSIF EN_INDEX = 1 THEN
		SELECT  ln_ide_proceso
			   ,BP_SEC_BENEFICIO.NEXTVAL
			   ,benef.cod_cliente
			   ,benef.num_abonado
			   ,benef.num_ident
			   ,benef.fec_ingreso
			   ,benef.cod_plan
			   ,benef.fec_desdeapli
			   ,NULL
			   ,benef.ind_exclusion
			   ,benef.tip_entidad
			   ,benef.num_periodos
			   ,1
			   ,CV_epr
			   ,SYSDATE
			   ,cicl.cod_ciclfact
			   ,SYSDATE
			   ,benef.row_id
			   ,CN_cero
               ,CN_cero
               ,benef.cod_ciclo
			   ,CN_cero
			   ,benef.tip_beneficio
			   ,benef.cod_dcto
			   ,benef.tip_dcto
			   ,NULL
			   ,NULL
		BULK   COLLECT INTO EM_BENEFICIARIOS
		FROM  bp_beneficiarios_pospago_ml_vw benef, fa_ciclfact cicl
		WHERE cicl.cod_ciclo = benef.cod_ciclo
		AND  SYSDATE BETWEEN cicl.fec_desdellam AND  cicl.fec_hastallam
        AND  NOT EXISTS (select 1 from bpt_beneficios apli
                          where apli.cod_cliente  =  benef.cod_cliente
                          and   apli.num_abonado  =  benef.num_abonado
                          and   apli.cod_plan     =  benef.cod_plan
                          and   apli.fec_desdeapli=  benef.fec_desdeapli);
                          
    ELSIF EN_INDEX = 2 THEN
			SELECT  ln_ide_proceso
			   ,BP_SEC_BENEFICIO.NEXTVAL
			   ,benef.cod_cliente
			   ,benef.num_abonado
			   ,benef.num_ident
			   ,benef.fec_ingreso
			   ,benef.cod_plan
			   ,benef.fec_desdeapli
			   ,NULL
			   ,benef.ind_exclusion
			   ,benef.tip_entidad
			   ,benef.num_periodos
			   ,1
			   ,CV_epr
			   ,SYSDATE
			   ,cicl.cod_ciclfact
			   ,SYSDATE
			   ,benef.row_id
			   ,CN_cero
               ,CN_cero
               ,benef.cod_ciclo
			   ,CN_cero
			   ,benef.tip_beneficio
			   ,benef.cod_dcto
			   ,benef.tip_dcto
			   ,NULL
			   ,NULL
		BULK   COLLECT INTO EM_BENEFICIARIOS
		FROM  bp_beneficiarios_pospago_ml_vw benef, fa_ciclfact cicl
		WHERE cicl.cod_ciclo = benef.cod_ciclo
		AND  SYSDATE BETWEEN cicl.fec_desdellam AND  cicl.fec_hastallam
        AND  NOT EXISTS (select 1 from bpt_beneficios apli
                          where apli.cod_cliente  =  benef.cod_cliente
                          and   apli.num_abonado  =  benef.num_abonado
                          and   apli.cod_plan     =  benef.cod_plan
                          and   apli.fec_desdeapli=  benef.fec_desdeapli)
        AND  EXISTS (select 1 from tol_horadcto_td tlp
                     where tlp.cod_dcto = benef.cod_dcto);                                           
	END IF;

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		 SN_COD_ERROR 	 := -1;
		 SV_MENS_RETORNO := 'BP_SEGMENTACION_ML_A_FN' ||' : '||SQLERRM;
		 RETURN FALSE;
END BP_SEGMENTACION_ML_A_FN;

/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION BP_REG_BENEF_APLI_FN (EM_TABLA         IN  TIP_BP_BENEFICIOS_APLICAR_TO,
                               SN_COD_ERROR 	OUT NOCOPY NUMBER,
                               SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
							   SV_SQL		   	OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS

BEGIN

	SV_SQL:='';
    FORALL i IN 1..EM_TABLA.COUNT
    INSERT INTO BP_BENEFICIOS_APLICAR_TO VALUES EM_TABLA(i);

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		 SN_COD_ERROR 	 := -1;
		 SV_MENS_RETORNO := 'BP_REG_BENEF_APLI_FN' ||' : '||SQLERRM;
		 RETURN FALSE;
END BP_REG_BENEF_APLI_FN;

/*---------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE BP_ACT_ESTADO_CABECERA_PR (EM_CABECERA             IN TIP_BP_CABECERA_BENEFICIOS_TD,
                                  	 SV_MENS_RETORNO 		 OUT NOCOPY VARCHAR2,
                                  	 SN_NUM_EVENTO 		 	 OUT NOCOPY NUMBER )
IS
--
  LM_CABECERA           TIP_BP_CABECERA_BENEFICIOS_TD;
  ln_tot_beneficiarios	NUMBER;
  ln_tot_reevaluados	NUMBER;
  ln_tot_excluidos		NUMBER;
  ln_tot_aplicados		NUMBER;
  ln_tot_error			NUMBER;
--
  LV_Sql				VARCHAR2(2000);
  LN_COD_ERROR		    NUMBER;
  ERROR_FUNCION			EXCEPTION;
BEGIN

     LN_COD_ERROR := 0;
     SV_MENS_RETORNO := 'BP_ACT_ESTADO_CABECERA_PR';
     SN_NUM_EVENTO := 0;

	 LM_CABECERA(1).IDE_PROCESO      :=  EM_CABECERA(1).IDE_PROCESO          ;

     IF NOT BP_REC_CABECERA_FN(LM_CABECERA,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
  	    RAISE ERROR_FUNCION;
	 END IF;

	 IF EM_CABECERA(1).TOT_BENEFICIARIOS = -1 THEN
	 	ln_tot_beneficiarios := LM_CABECERA(1).TOT_BENEFICIARIOS;
	 ELSE
	 	ln_tot_beneficiarios := EM_CABECERA(1).TOT_BENEFICIARIOS;
	 END IF;

	 IF EM_CABECERA(1).TOT_REEVALUADOS = -1 THEN
	 	ln_tot_reevaluados := LM_CABECERA(1).TOT_REEVALUADOS;
	 ELSE
	 	ln_tot_reevaluados := EM_CABECERA(1).TOT_REEVALUADOS;
	 END IF;

	 IF EM_CABECERA(1).TOT_EXCLUIDOS = -1 THEN
	 	ln_tot_excluidos := LM_CABECERA(1).TOT_EXCLUIDOS;
	 ELSE
	 	ln_tot_excluidos := EM_CABECERA(1).TOT_EXCLUIDOS;
	 END IF;

	 IF EM_CABECERA(1).TOT_APLICADOS = -1 THEN
	 	ln_tot_aplicados := LM_CABECERA(1).TOT_APLICADOS;
	 ELSE
	 	ln_tot_aplicados := EM_CABECERA(1).TOT_APLICADOS;
	 END IF;

	 IF EM_CABECERA(1).TOT_ERROR = -1 THEN
	 	ln_tot_error := LM_CABECERA(1).TOT_ERROR;
	 ELSE
	 	ln_tot_error := EM_CABECERA(1).TOT_ERROR;
	 END IF;

	 IF EM_CABECERA(1).TOT_APLICADOS > 0 THEN
	 	LM_CABECERA(1).FEC_FINAL        :=  SYSDATE;
	 END IF;

	 LM_CABECERA(1).TOT_BENEFICIARIOS:=  ln_tot_beneficiarios;
	 LM_CABECERA(1).TOT_REEVALUADOS  :=  ln_tot_reevaluados;
	 LM_CABECERA(1).TOT_EXCLUIDOS    :=  ln_tot_excluidos;
	 LM_CABECERA(1).TOT_APLICADOS    :=  ln_tot_aplicados;
	 LM_CABECERA(1).TOT_ERROR        :=  ln_tot_error;
	 LM_CABECERA(1).COD_ESTADO       :=  EM_CABECERA(1).COD_ESTADO;

	 IF NOT BP_ACT_CABECERA_FN(LM_CABECERA,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
  	    RAISE ERROR_FUNCION;
	 END IF;


EXCEPTION
		WHEN ERROR_FUNCION THEN
                SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'BP_BENEFICIOS_PROMOCIONES_PG.BP_ACT_ESTADO_CABECERA_PR', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );
				ROLLBACK;
        WHEN OTHERS THEN
                SV_MENS_RETORNO := SV_MENS_RETORNO;
                SN_NUM_EVENTO 	:= GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'BP_BENEFICIOS_PROMOCIONES_PG.BP_ACT_ESTADO_CABECERA_PR', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );
				ROLLBACK;
END BP_ACT_ESTADO_CABECERA_PR;
/*---------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE BP_GENERAR_CABECERA_PR (EM_CABECERA             IN TIP_BP_CABECERA_BENEFICIOS_TD,
                                  SV_MENS_RETORNO 		 OUT NOCOPY VARCHAR2,
                                  SN_NUM_EVENTO 		 OUT NOCOPY NUMBER )
IS
  LM_CABECERA           TIP_BP_CABECERA_BENEFICIOS_TD;
--
  LV_Sql				VARCHAR2(2000);
  LN_COD_ERROR		    NUMBER;
  ERROR_FUNCION			EXCEPTION;
BEGIN

     LN_COD_ERROR := 0;
     SV_MENS_RETORNO := 'BP_ACT_ESTADO_CABECERA_PR';
     SN_NUM_EVENTO := 0;

	 LM_CABECERA(1).IDE_PROCESO      :=  EM_CABECERA(1).IDE_PROCESO          ;
	 LM_CABECERA(1).COD_PROCESO      :=  EM_CABECERA(1).COD_PROCESO          ;
	 LM_CABECERA(1).COD_CICLFACT     :=  EM_CABECERA(1).COD_CICLFACT         ;
	 LM_CABECERA(1).FEC_INICIO       :=  EM_CABECERA(1).FEC_INICIO           ;
	 LM_CABECERA(1).FEC_FINAL        :=  EM_CABECERA(1).FEC_FINAL            ;
	 LM_CABECERA(1).TOT_BENEFICIARIOS:=  EM_CABECERA(1).TOT_BENEFICIARIOS    ;
	 LM_CABECERA(1).TOT_REEVALUADOS  :=  EM_CABECERA(1).TOT_REEVALUADOS      ;
	 LM_CABECERA(1).TOT_EXCLUIDOS    :=  EM_CABECERA(1).TOT_EXCLUIDOS        ;
	 LM_CABECERA(1).TOT_APLICADOS    :=  EM_CABECERA(1).TOT_APLICADOS        ;
	 LM_CABECERA(1).TOT_ERROR        :=  EM_CABECERA(1).TOT_ERROR            ;
	 LM_CABECERA(1).TIP_PROCESO      :=  EM_CABECERA(1).TIP_PROCESO          ;
	 LM_CABECERA(1).COD_ESTADO       :=  EM_CABECERA(1).COD_ESTADO           ;
	 LM_CABECERA(1).TIP_BENEFICIO	 :=  EM_CABECERA(1).TIP_BENEFICIO		 ;
	 LM_CABECERA(1).NUM_JOB	 		 :=  EM_CABECERA(1).NUM_JOB		 		 ;

	 IF NOT BP_REG_CABECERA_FN(LM_CABECERA,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
  	    RAISE ERROR_FUNCION;
	 END IF;

EXCEPTION
		WHEN ERROR_FUNCION THEN
                SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'BP_BENEFICIOS_PROMOCIONES_PG.BP_GENERAR_CABECERA_PR', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );
				ROLLBACK;
        WHEN OTHERS THEN
                SV_MENS_RETORNO := SV_MENS_RETORNO;
                SN_NUM_EVENTO 	:= GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'BP_BENEFICIOS_PROMOCIONES_PG.BP_GENERAR_CABECERA_PR', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );
				ROLLBACK;
END BP_GENERAR_CABECERA_PR;
/*---------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE BP_SEGMENTACION_ML_PR (EN_IDE_PROCESO	  IN NUMBER,
								 SN_TOTAL_SEG	  OUT NUMBER,
                             	 SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
							 	 SN_NUM_EVENTO 	  OUT NOCOPY NUMBER)
IS

  LV_abo_sexist VARCHAR2(2500);
  LV_abo_nexist VARCHAR2(2500);
  LV_cli_sexist VARCHAR2(2500);
  LV_cli_nexist VARCHAR2(2500);

  LM_TABLA_APLI	  TIP_BP_BENEFICIOS_APLICAR_TO;
  LM_TABLA_CAB    TIP_BP_CABECERA_BENEFICIOS_TD;

  LV_Sql				VARCHAR2(2000);
  LN_COD_ERROR		    NUMBER;
  ERROR_FUNCION			EXCEPTION;
  LN_cod_ciclo			fa_ciclfact.cod_ciclo%TYPE;
BEGIN

    LN_COD_ERROR := 0;
    SV_MENS_RETORNO := 'BP_SEGMENTACION_ML_PR';
    SN_NUM_EVENTO := 0;

	LM_TABLA_CAB(1).IDE_PROCESO := en_ide_proceso;
    IF NOT BP_REC_CABECERA_FN(LM_TABLA_CAB,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
  	    RAISE ERROR_FUNCION;
    END IF;

    SN_TOTAL_SEG :=0;
	IF  BP_SEGMENTACION_ML_A_FN (LM_TABLA_CAB ,LM_TABLA_APLI,0,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN -- Minutos Libres
		IF NOT BP_REG_BENEF_APLI_FN(LM_TABLA_APLI,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
	  	    RAISE ERROR_FUNCION;
		END IF;
	ELSE
  	    RAISE ERROR_FUNCION;
	END IF;

	SN_TOTAL_SEG := SN_TOTAL_SEG + LM_TABLA_APLI.COUNT;

	IF  BP_SEGMENTACION_ML_A_FN (LM_TABLA_CAB ,LM_TABLA_APLI,1,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN -- Minutos Libres
		IF NOT BP_REG_BENEF_APLI_FN(LM_TABLA_APLI,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
	  	    RAISE ERROR_FUNCION;
		END IF;
	ELSE
  	    RAISE ERROR_FUNCION;
	END IF;


	SN_TOTAL_SEG := SN_TOTAL_SEG + LM_TABLA_APLI.COUNT;
EXCEPTION
		WHEN ERROR_FUNCION THEN
                SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'BP_BENEFICIOS_PROMOCIONES_PG.BP_SEGMENTACION_DF_PR', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );
				ROLLBACK;
        WHEN OTHERS THEN
                SV_MENS_RETORNO := SQLERRM;
                SN_NUM_EVENTO 	:= GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'BP_BENEFICIOS_PROMOCIONES_PG.BP_SEGMENTACION_DF_PR', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );
				ROLLBACK;
END BP_SEGMENTACION_ML_PR;

/*---------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE BP_SEGMENTA_FRNHH_ML_PR (EN_IDE_PROCESO	 IN NUMBER,
								   SN_TOTAL_SEG	    OUT NUMBER,
                             	   SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
							 	   SN_NUM_EVENTO    OUT NOCOPY NUMBER)
IS

  LV_abo_sexist VARCHAR2(2500);
  LV_abo_nexist VARCHAR2(2500);
  LV_cli_sexist VARCHAR2(2500);
  LV_cli_nexist VARCHAR2(2500);

  LM_TABLA_APLI	  TIP_BP_BENEFICIOS_APLICAR_TO;
  LM_TABLA_CAB    TIP_BP_CABECERA_BENEFICIOS_TD;

  LV_Sql				VARCHAR2(2000);
  LN_COD_ERROR		    NUMBER;
  ERROR_FUNCION			EXCEPTION;
  LN_cod_ciclo			fa_ciclfact.cod_ciclo%TYPE;
BEGIN

    LN_COD_ERROR := 0;
    SV_MENS_RETORNO := 'BP_SEGMENTACION_ML_PR';
    SN_NUM_EVENTO := 0;

	LM_TABLA_CAB(1).IDE_PROCESO := en_ide_proceso;
    IF NOT BP_REC_CABECERA_FN(LM_TABLA_CAB,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
  	    RAISE ERROR_FUNCION;
    END IF;

    SN_TOTAL_SEG :=0;
	IF  BP_SEGMENTACION_ML_A_FN (LM_TABLA_CAB ,LM_TABLA_APLI,2,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN -- Minutos Libres
		IF NOT BP_REG_BENEF_APLI_FN(LM_TABLA_APLI,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
	  	    RAISE ERROR_FUNCION;
		END IF;
	ELSE
  	    RAISE ERROR_FUNCION;
	END IF;

	SN_TOTAL_SEG := SN_TOTAL_SEG + LM_TABLA_APLI.COUNT;
EXCEPTION
		WHEN ERROR_FUNCION THEN
                SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'BP_BENEFICIOS_PROMOCIONES_PG.BP_SEGMENTA_FRNHH_ML_PR', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );
				ROLLBACK;
        WHEN OTHERS THEN
                SV_MENS_RETORNO := SQLERRM;
                SN_NUM_EVENTO 	:= GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'BP_BENEFICIOS_PROMOCIONES_PG.BP_SEGMENTA_FRNHH_ML_PR', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );
				ROLLBACK;
END BP_SEGMENTA_FRNHH_ML_PR;

/*---------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE BP_REG_BENEFICIOS_PR (EN_IDE_PROCESO	  IN NUMBER,
                                SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
                                SN_NUM_EVENTO 	 OUT NOCOPY NUMBER )
IS
  LM_BPT_BENEFICIOS     TIP_BPT_BENEFICIOS;
  LM_TOL_CLIEDCTO_TO    TIP_TOL_CLIEDCTO_TO;
  LM_TOL_DETABONDCTO_TD TIP_TOL_DETABONDCTO_TD;
  LM_TABLA_CAB          TIP_BP_CABECERA_BENEFICIOS_TD;
  LM_TABLA_HIST         TIP_ENLACE_HIST_LIST;
  LV_Sql				VARCHAR2(5000);
  LN_COD_ERROR		    NUMBER;
  ERROR_FUNCION			EXCEPTION;
  LN_cod_ciclo			fa_ciclfact.cod_ciclo%TYPE;
  LD_FEC_ACTUAL         DATE;
  LV_FEC_ACTUAL         VARCHAR2(25);
BEGIN

    LN_COD_ERROR := 0;
    SV_MENS_RETORNO := 'BP_REG_BENEFICIOS_PR';
    SN_NUM_EVENTO := 0;
    
    
    LD_FEC_ACTUAL:= SYSDATE;
    LV_FEC_ACTUAL:= TO_CHAR(LD_FEC_ACTUAL,'DD-MM-YYYY HH24:MI:SS');

    LM_TABLA_CAB(1).IDE_PROCESO := en_ide_proceso;
    IF NOT BP_REC_CABECERA_FN(LM_TABLA_CAB,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
 	    RAISE ERROR_FUNCION;
    END IF;

    IF NOT BP_REC_BENEF_APLI_FN(LM_BPT_BENEFICIOS,EN_IDE_PROCESO,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;


    IF NOT BP_REC_CLIE_DCTO_FN(EN_IDE_PROCESO,0,LD_FEC_ACTUAL,LV_FEC_ACTUAL,'',LM_TOL_CLIEDCTO_TO,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;
    IF NOT BP_REG_TOL_CLIEDCTO_FN(LM_TOL_CLIEDCTO_TO,1,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;

    IF NOT BP_REC_FA_HIST_FN(LM_TABLA_HIST,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;

    FOR i IN 1..LM_TABLA_HIST.COUNT LOOP
        IF NOT BP_REC_CLIE_DCTO_FN(EN_IDE_PROCESO,1,LD_FEC_ACTUAL,LV_FEC_ACTUAL,LM_TABLA_HIST(i).FA_DETCELULAR,LM_TOL_CLIEDCTO_TO,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
            RAISE ERROR_FUNCION;
        END IF;
        IF NOT BP_REG_TOL_CLIEDCTO_FN(LM_TOL_CLIEDCTO_TO,1,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
            RAISE ERROR_FUNCION;
        END IF;
    END LOOP;
    
    IF NOT BP_REC_TOL_DET_FN(EN_IDE_PROCESO,LD_FEC_ACTUAL,0,LM_TOL_DETABONDCTO_TD,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;

    IF NOT BP_REG_TOL_DETABONDCTO_FN(LM_TOL_DETABONDCTO_TD,1,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;

    IF NOT BP_REC_TOL_DET_FN(EN_IDE_PROCESO,LD_FEC_ACTUAL,1,LM_TOL_DETABONDCTO_TD,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;

    IF NOT BP_REG_TOL_DETABONDCTO_FN(LM_TOL_DETABONDCTO_TD,1,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;

    IF NOT BP_REC_TOL_DET_FN(EN_IDE_PROCESO,LD_FEC_ACTUAL,2,LM_TOL_DETABONDCTO_TD,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;

    IF NOT BP_REG_TOL_DETABONDCTO_FN(LM_TOL_DETABONDCTO_TD,1,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;

    IF NOT BP_REC_FA_HIST_FN(LM_TABLA_HIST,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;

    IF NOT BP_REC_FA_HIST_FN(LM_TABLA_HIST,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;

    FOR i IN 1..LM_TABLA_HIST.COUNT LOOP
       IF NOT BP_REC_FA_DET_FN(EN_IDE_PROCESO,LM_TABLA_HIST(i).FA_DETCELULAR,LV_FEC_ACTUAL,LM_TOL_DETABONDCTO_TD,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
            RAISE ERROR_FUNCION;
        END IF;
        IF NOT BP_REG_TOL_DETABONDCTO_FN(LM_TOL_DETABONDCTO_TD,1,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
            RAISE ERROR_FUNCION;
        END IF;
    END LOOP;

    IF NOT BP_REG_BENEFICIOS_FN(LM_BPT_BENEFICIOS,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;

    IF NOT BP_ACT_ESTADO_ASIG_FN(LM_TABLA_CAB,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;

    IF  NOT BP_BORRA_TMP_FN(EN_IDE_PROCESO,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
	  	    RAISE ERROR_FUNCION;
    END IF;
    
    
    
EXCEPTION
		WHEN ERROR_FUNCION THEN
                SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'BP_BENEFICIOS_PROMOCIONES_PG.BP_REG_BENEFICIOS_PR', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );
				ROLLBACK;
        WHEN OTHERS THEN
                SV_MENS_RETORNO := SV_MENS_RETORNO;
                SN_NUM_EVENTO 	:= GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'BP_BENEFICIOS_PROMOCIONES_PG.BP_REG_BENEFICIOS_PR', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );
				ROLLBACK;
END BP_REG_BENEFICIOS_PR;
/*---------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE BP_REG_BENEFICIOS_FRNHH_PR (EN_IDE_PROCESO	IN NUMBER,
                                      SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
                                      SN_NUM_EVENTO    OUT NOCOPY NUMBER )
IS
  LM_BPT_BENEFICIOS     TIP_BPT_BENEFICIOS;
  LM_TOL_CLIEDCTO_TO    TIP_TOL_CLIEDCTO_TO;
  LM_TOL_DETABONDCTO_TD TIP_TOL_DETABONDCTO_TD;
  LM_TABLA_CAB          TIP_BP_CABECERA_BENEFICIOS_TD;
  LV_Sql				VARCHAR2(5000);
  LN_COD_ERROR		    NUMBER;
  ERROR_FUNCION			EXCEPTION;
  LN_cod_ciclo			fa_ciclfact.cod_ciclo%TYPE;
  LD_FEC_ACTUAL         DATE;
  LV_FEC_ACTUAL         VARCHAR2(25);  
BEGIN

    LN_COD_ERROR := 0;
    SV_MENS_RETORNO := 'BP_REG_BENEFICIOS_FRNHH_PR';
    SN_NUM_EVENTO := 0;
    
    
    LD_FEC_ACTUAL:= SYSDATE;
    LV_FEC_ACTUAL:= TO_CHAR(LD_FEC_ACTUAL,'DD-MM-YYYY HH24:MI:SS');

    LM_TABLA_CAB(1).IDE_PROCESO := en_ide_proceso;
    IF NOT BP_REC_CABECERA_FN(LM_TABLA_CAB,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
 	    RAISE ERROR_FUNCION;
    END IF;

    IF NOT BP_REC_BENEF_APLI_FN(LM_BPT_BENEFICIOS,EN_IDE_PROCESO,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;


    IF NOT BP_REC_CLIE_DCTO_FN(EN_IDE_PROCESO,2,LD_FEC_ACTUAL,LV_FEC_ACTUAL,'',LM_TOL_CLIEDCTO_TO,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;
    
    IF NOT BP_REG_TOL_CLIEDCTO_FN(LM_TOL_CLIEDCTO_TO,1,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;

    IF NOT BP_REC_TOL_DET_FN(EN_IDE_PROCESO,LD_FEC_ACTUAL,3,LM_TOL_DETABONDCTO_TD,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;

    IF NOT BP_REG_TOL_DETABONDCTO_FN(LM_TOL_DETABONDCTO_TD,1,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;

    IF NOT BP_REG_BENEFICIOS_FN(LM_BPT_BENEFICIOS,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;

    IF NOT BP_ACT_ESTADO_ASIG_FN(LM_TABLA_CAB,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
        RAISE ERROR_FUNCION;
    END IF;

    IF  NOT BP_BORRA_TMP_FN(EN_IDE_PROCESO,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
	  	    RAISE ERROR_FUNCION;
    END IF;
    
EXCEPTION
		WHEN ERROR_FUNCION THEN
                SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'BP_BENEFICIOS_PROMOCIONES_PG.BP_REG_BENEFICIOS_FRNHH_PR', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );
				ROLLBACK;
        WHEN OTHERS THEN
                SV_MENS_RETORNO := SV_MENS_RETORNO;
                SN_NUM_EVENTO 	:= GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'BP_BENEFICIOS_PROMOCIONES_PG.BP_REG_BENEFICIOS_FRNHH_PR', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );
				ROLLBACK;
END BP_REG_BENEFICIOS_FRNHH_PR;

/*---------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE BP_VALIDA_EXCLUCION_PR (EN_IDE_PROCESO          IN NUMBER,
		  						  SN_TOT_EXC			 OUT NUMBER,
                                  SV_MENS_RETORNO 		 OUT NOCOPY VARCHAR2,
                                  SN_NUM_EVENTO 		 OUT NOCOPY NUMBER )
IS
--
  LM_TABLA           TIP_BP_BENEFICIOS_APLICAR_TO;
--
  LV_Sql				VARCHAR2(2000);
  LN_COD_ERROR		    NUMBER;
  ERROR_FUNCION			EXCEPTION;
BEGIN

     LN_COD_ERROR := 0;
     SV_MENS_RETORNO := 'BP_VALIDA_EXCLUCION_PR';
     SN_NUM_EVENTO := 0;

	 LM_TABLA(1).IDE_PROCESO      :=  en_ide_proceso;
	 LM_TABLA(1).COD_ESTADO		  :=  CV_exc;
	 LM_TABLA(1).IND_EXCLUSION	  :=  CV_exclu_s;

	 IF NOT BP_ACT_ESTADO_EXC_FN(LM_TABLA,SN_TOT_EXC,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
  	    RAISE ERROR_FUNCION;
	 END IF;

EXCEPTION
		WHEN ERROR_FUNCION THEN
                SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'BP_BENEFICIOS_PROMOCIONES_PG.BP_VALIDA_EXCLUCION_PR', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );
				ROLLBACK;
        WHEN OTHERS THEN
                SV_MENS_RETORNO := SV_MENS_RETORNO;
                SN_NUM_EVENTO 	:= GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'BP_BENEFICIOS_PROMOCIONES_PG.BP_VALIDA_EXCLUCION_PR', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );
				ROLLBACK;
END BP_VALIDA_EXCLUCION_PR;
/*---------------------------------------------------------------------------------------------------------------------------------*/
END Bp_Beneficios_Promociones_Pg;
/
SHOW ERRORS