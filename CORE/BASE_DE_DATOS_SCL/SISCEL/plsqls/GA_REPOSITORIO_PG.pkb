CREATE OR REPLACE PACKAGE BODY GA_REPOSITORIO_PG IS

    PROCEDURE VE_getList_TiposDocumentos_PR (
                                            SC_cursordatos      OUT NOCOPY REFCURSOR,
                                            SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS

       no_data_found_cursor      EXCEPTION;
       LV_des_error ge_errores_pg.DesEvent;
       LV_sSql      ge_errores_pg.vQuery;
       LN_contador      NUMBER;
    BEGIN

        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';


        OPEN SC_cursordatos FOR
        SELECT COD_TIPO_DOC,DES_TIPO_DOC
        FROM GA_TIPDOC_DIGITALIZADOS_TD
        WHERE IND_VIGENCIA=1;


    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:GA_REPOSITORIO_PG.VE_getList_TiposDocumentos_PR(); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'GA_REPOSITORIO_PG.VE_getList_TiposDocumentos_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_getList_TiposDocumentos_PR;


	PROCEDURE VE_getList_DocDigitalizados_PR (
    	EN_numventa				IN 			GA_VENTAS.NUM_VENTA%TYPE,
        EN_NUM_CORRELATIVO   	IN 			GA_DOC_DIGITALIZADOS_TO.NUM_CORRELATIVO%TYPE,
        EN_codTipdocumento   	IN 			GA_TIPDOC_DIGITALIZADOS_TD.COD_TIPO_DOC%TYPE,
        SC_cursordatos       	OUT NOCOPY 	REFCURSOR,
        SN_cod_retorno       	OUT NOCOPY 	ge_errores_pg.CodError,
        SV_mens_retorno      	OUT NOCOPY 	ge_errores_pg.MsgError,
        SN_num_evento        	OUT NOCOPY 	ge_errores_pg.Evento)
    IS
    	no_data_found_cursor    EXCEPTION;
     	LV_des_error 			ge_errores_pg.DesEvent;
    	LV_sSql      			ge_errores_pg.vQuery;
    	LN_contador      		NUMBER;

    BEGIN

        LV_sSql := 'SELECT a.num_correlativo, a.observacion, a.valor_content_type, '
        || 'a.nombre_archivo, a.fec_creacion, a.cod_tipo_doc, '
        || 'b.des_tipo_doc, a.num_venta, a.bin_archivo '
        || 'FROM ga_doc_digitalizados_to a, ga_tipdoc_digitalizados_td b '
        || 'WHERE a.cod_tipo_doc = b.cod_tipo_doc ' ;

        IF  EN_numventa IS NOT NULL THEN
           LV_sSql:= LV_sSql || ' AND a.NUM_VENTA='|| EN_numventa;
        END IF;

        IF  EN_codTipdocumento IS NOT NULL THEN
           LV_sSql:= LV_sSql || ' AND a.COD_TIPO_DOC='|| EN_codTipdocumento;
        END IF;

        IF EN_NUM_CORRELATIVO IS NOT NULL THEN
           LV_sSql:= LV_sSql || ' AND a.NUM_CORRELATIVO='|| EN_NUM_CORRELATIVO;
        END IF;

        OPEN SC_cursordatos FOR LV_sSql;

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:GA_REPOSITORIO_PG.VE_getList_DocDigitalizados_PR(); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'GA_REPOSITORIO_PG.VE_getList_DocDigitalizados_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_getList_DocDigitalizados_PR;
    
	PROCEDURE VE_Ins_DocDigitalizados_PR (
        EN_numventa             IN 			GA_VENTAS.NUM_VENTA%TYPE,
        EN_codTipdocumento      IN 			GA_TIPDOC_DIGITALIZADOS_TD.COD_TIPO_DOC%TYPE,
        EV_OBSERVACION          IN 			GA_DOC_DIGITALIZADOS_TO.OBSERVACION%TYPE,
        EV_NOM_USUARORA         IN 			GA_DOC_DIGITALIZADOS_TO.NOM_USUARORA%TYPE,
        EV_VALOR_CONTENT_TYPE   IN 			GA_DOC_DIGITALIZADOS_TO.VALOR_CONTENT_TYPE%TYPE,
        EV_NOMBRE_ARCHIVO       IN          GA_DOC_DIGITALIZADOS_TO.NOMBRE_ARCHIVO%TYPE,
        EV_BIN_ARCHIVO          IN          GA_DOC_DIGITALIZADOS_TO.BIN_ARCHIVO%TYPE,
        SN_Secuencia            OUT NOCOPY  GA_DOC_DIGITALIZADOS_TO.NUM_CORRELATIVO%TYPE,
        SN_cod_retorno          OUT NOCOPY  ge_errores_pg.CodError,
        SV_mens_retorno         OUT NOCOPY  ge_errores_pg.MsgError,
        SN_num_evento           OUT NOCOPY  ge_errores_pg.Evento) IS
       	no_data_found_cursor    EXCEPTION;
       	LV_des_error 			ge_errores_pg.DesEvent;
       	LV_sSql      			ge_errores_pg.vQuery;
       	LN_contador    			NUMBER;
       	LN_CORRELATIVO 			NUMBER(9);
    
    BEGIN

       	SELECT GA_REPOSITORIO_SQ.nextval INTO LN_CORRELATIVO FROM DUAL;
		
        LV_sSql := 
        'INSERT INTO GA_DOC_DIGITALIZADOS_TO a (
        	a.NUM_CORRELATIVO,
           	a.NUM_VENTA,
            a.COD_TIPO_DOC,
            a.OBSERVACION,
            a.NOM_USUARORA,
       		a.VALOR_CONTENT_TYPE,
            a.NOMBRE_ARCHIVO,
            a.BIN_ARCHIVO,
            a.FEC_CREACION)
       	VALUES ('
            || LN_CORRELATIVO 			|| ', ' 
            || EN_numventa 				|| ', ' 
            || EN_codTipdocumento 		|| ', ' 
            || EV_OBSERVACION 			|| ', ' 
            || EV_NOM_USUARORA 			|| ', '
            || EV_VALOR_CONTENT_TYPE 	|| ', ' 
       		|| EV_NOMBRE_ARCHIVO 		|| ', '
            || 'EV_BIN_ARCHIVO' 		|| ', ' 
            || SYSDATE 					||
        ')';

       	SN_Secuencia := LN_CORRELATIVO;
       
       	INSERT INTO GA_DOC_DIGITALIZADOS_TO a (
        	a.NUM_CORRELATIVO,
            a.NUM_VENTA,
            a.COD_TIPO_DOC,
            a.OBSERVACION,
            a.NOM_USUARORA,
       		a.VALOR_CONTENT_TYPE,
            a.NOMBRE_ARCHIVO,
            a.BIN_ARCHIVO,
            a.FEC_CREACION
    	)
       	VALUES (
        	LN_CORRELATIVO,
            EN_numventa,
            EN_codTipdocumento,
            EV_OBSERVACION,
            EV_NOM_USUARORA,
            EV_VALOR_CONTENT_TYPE,
       		EV_NOMBRE_ARCHIVO,
            EV_BIN_ARCHIVO,
            SYSDATE
        );

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:GA_REPOSITORIO_PG.VE_Ins_DocDigitalizados_PR(); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'GA_REPOSITORIO_PG.VE_Ins_DocDigitalizados_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_Ins_DocDigitalizados_PR;
    
    
       PROCEDURE VE_Del_DocDigitalizados_PR  (EN_CORRELATIVO       IN GA_DOC_DIGITALIZADOS_TO.NUM_CORRELATIVO%TYPE,
                                              SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS

       no_data_found_cursor      EXCEPTION;
       LV_des_error ge_errores_pg.DesEvent;
       LV_sSql      ge_errores_pg.vQuery;
       LN_contador    NUMBER;
       LN_CORRELATIVO NUMBER(9);
    BEGIN

        DELETE FROM GA_DOC_DIGITALIZADOS_TO
        WHERE NUM_CORRELATIVO=EN_CORRELATIVO;



    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:GA_REPOSITORIO_PG.VE_Del_DocDigitalizados_PR(); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'GA_REPOSITORIO_PG.VE_Del_DocDigitalizados_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_Del_DocDigitalizados_PR;



    PROCEDURE VE_INSERTA_DOCDIG_SCORING_PR (
           EV_NUM_SOLSCORING       IN              GA_DOC_DIGITALIZADOS_TO.NUM_SOLSCORING%TYPE,
           EV_OBSERVACION          IN              GA_DOC_DIGITALIZADOS_TO.OBSERVACION%TYPE,
           EV_NOM_USUARORA         IN              GA_DOC_DIGITALIZADOS_TO.NOM_USUARORA%TYPE,
           EV_VALOR_CONTENT_TYPE   IN              GA_DOC_DIGITALIZADOS_TO.VALOR_CONTENT_TYPE%TYPE,
           EV_COD_DOCSCORING       IN              GA_DOC_DIGITALIZADOS_TO.COD_DOCSCORING%TYPE,
           EV_DES_DOCSCORING       IN              GA_DOC_DIGITALIZADOS_TO.DES_DOCSCORING%TYPE,
           EV_REQUERIDO_SCORING    IN              GA_DOC_DIGITALIZADOS_TO.REQUERIDO_SCORING%TYPE,
           EV_NOMBRE_ARCHIVO       IN              GA_DOC_DIGITALIZADOS_TO.NOMBRE_ARCHIVO%TYPE,
           SN_NUM_CORRELATIVO      OUT NOCOPY      GA_DOC_DIGITALIZADOS_TO.NUM_CORRELATIVO%TYPE,
           SN_cod_retorno          OUT NOCOPY      ge_errores_pg.coderror,
           SV_mens_retorno         OUT NOCOPY      ge_errores_pg.msgerror,
           SN_num_evento           OUT NOCOPY      ge_errores_pg.evento )
           IS

           no_data_found_cursor   EXCEPTION;
           lv_des_error           ge_errores_pg.desevent;
           lv_ssql                ge_errores_pg.vquery;
           ln_contador            NUMBER;
           ln_correlativo         NUMBER (9);


            BEGIN
               SELECT ga_repositorio_sq.NEXTVAL INTO SN_NUM_CORRELATIVO FROM DUAL;


               INSERT INTO ga_doc_digitalizados_to a (
                           a.num_correlativo,
                           a.NUM_SOLSCORING,
                           a.OBSERVACION,
                           a.NOM_USUARORA,
                           a.VALOR_CONTENT_TYPE,
                           a.COD_DOCSCORING,
                           a.DES_DOCSCORING,
                           a.REQUERIDO_SCORING,
                           a.NOMBRE_ARCHIVO,
                           a.FEC_CREACION)
               VALUES (
                           SN_NUM_CORRELATIVO,
                           EV_NUM_SOLSCORING,
                           EV_OBSERVACION ,
                           EV_NOM_USUARORA,
                           EV_VALOR_CONTENT_TYPE,
                           EV_COD_DOCSCORING,
                           EV_DES_DOCSCORING,
                           EV_REQUERIDO_SCORING,
                           EV_NOMBRE_ARCHIVO, SYSDATE
                );
            EXCEPTION
               WHEN OTHERS
               THEN
                  sn_cod_retorno := 4;

                  IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
                  THEN
                     sv_mens_retorno := cv_error_no_clasif;
                  END IF;

                  lv_des_error := SUBSTR ('OTHERS:GA_REPOSITORIO_PG.VE_INSERTA_DOCDIG_SCORING_PR(); - '
                           || SQLERRM,                       1,
                           cn_largoerrtec
                          );
                  sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
                  sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,       cv_cod_modulo,
                                           sv_mens_retorno, '1.0',
                                           USER, 'GA_REPOSITORIO_PG.VE_INSERTA_DOCDIG_SCORING_PR',
                                           lv_ssql, sn_cod_retorno, lv_des_error
                                          );
            END VE_INSERTA_DOCDIG_SCORING_PR;


      PROCEDURE VE_INSERTA_DOCDIG_SCORING_PR (
           EV_NUM_SOLSCORING       IN              GA_DOC_DIGITALIZADOS_TO.NUM_SOLSCORING%TYPE,
           EV_COD_DOCSCORING       IN              GA_DOC_DIGITALIZADOS_TO.COD_DOCSCORING%TYPE,
           EV_DES_DOCSCORING       IN              GA_DOC_DIGITALIZADOS_TO.DES_DOCSCORING%TYPE,
           EV_REQUERIDO_SCORING    IN              GA_DOC_DIGITALIZADOS_TO.REQUERIDO_SCORING%TYPE,
           SN_NUM_CORRELATIVO      OUT NOCOPY      GA_DOC_DIGITALIZADOS_TO.NUM_CORRELATIVO%TYPE,
           SN_cod_retorno          OUT NOCOPY      ge_errores_pg.coderror,
           SV_mens_retorno         OUT NOCOPY      ge_errores_pg.msgerror,
           SN_num_evento           OUT NOCOPY      ge_errores_pg.evento )
           IS

           no_data_found_cursor   EXCEPTION;
           lv_des_error           ge_errores_pg.desevent;
           lv_sql                ge_errores_pg.vquery;
           ln_contador            NUMBER;
           ln_correlativo         NUMBER (9);

            BEGIN
               SELECT ga_repositorio_sq.NEXTVAL INTO SN_NUM_CORRELATIVO FROM DUAL;

               INSERT INTO ga_doc_digitalizados_to a (
                           a.num_correlativo,
                           a.NUM_SOLSCORING,
                           a.COD_DOCSCORING,
                           a.DES_DOCSCORING,
                           a.REQUERIDO_SCORING)
               VALUES (
                           SN_NUM_CORRELATIVO,
                           EV_NUM_SOLSCORING,
                           EV_COD_DOCSCORING,
                           EV_DES_DOCSCORING,
                           EV_REQUERIDO_SCORING
                );
            EXCEPTION
                WHEN OTHERS THEN
             SN_cod_retorno := 4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno, SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
             END IF;
             lv_des_error := 'GA_REPOSITORIO_PG.VE_INSERTA_DOCDIG_SCORING_PR;- ' || SQLERRM;
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, cv_cod_modulo, SV_mens_retorno, '1.0', USER,
             'GA_REPOSITORIO_PG.VE_INSERTA_DOCDIG_SCORING_PR',  LV_sql, SQLCODE, lv_des_error);
            END VE_INSERTA_DOCDIG_SCORING_PR;


    PROCEDURE VE_listar_DocDigScoring_PR (
        EV_NUM_CORRELATIVO      IN          GA_DOC_DIGITALIZADOS_TO.NUM_CORRELATIVO%TYPE,
        EN_NUM_SOLSCORING       IN          GA_DOC_DIGITALIZADOS_TO.NUM_SOLSCORING%TYPE,
        SC_cursordatos      OUT NOCOPY REFCURSOR,
        SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY ge_errores_pg.Evento
    ) IS

        LV_des_error ge_errores_pg.DesEvent;
        LV_sSql      ge_errores_pg.vQuery;

        BEGIN

        SN_num_evento   := 0;
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';

        LV_sSql :=
            'SELECT
                a.COD_DOCSCORING, a.DES_DOCSCORING, a.FEC_CREACION,
                a.NOM_USUARORA, a.NOMBRE_ARCHIVO, a.NUM_CORRELATIVO,
                a.NUM_SOLSCORING, a.OBSERVACION, a.REQUERIDO_SCORING,
                a.VALOR_CONTENT_TYPE, a.BIN_ARCHIVO
            FROM
                ga_doc_digitalizados_to a
            WHERE
                a.NUM_SOLSCORING = ' || EN_NUM_SOLSCORING;

            IF EV_NUM_CORRELATIVO IS NOT NULL THEN
                LV_sSql := LV_sSql || ' AND a.NUM_CORRELATIVO = ' || EV_NUM_CORRELATIVO;
            END IF;


        OPEN SC_cursordatos FOR LV_sSql;

        EXCEPTION
            WHEN OTHERS THEN
                SN_cod_retorno:=4;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                LV_des_error := SUBSTR('OTHERS:GA_REPOSITORIO_PG.VE_listar_DocDigScoring_PR; - '|| SQLERRM,1,CN_largoerrtec);
                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                'GA_REPOSITORIO_PG.VE_listar_DocDigScoring_PR', LV_sSql, SN_cod_retorno, LV_des_error );


         END VE_listar_DocDigScoring_PR;


    PROCEDURE VE_UPDATE_DOCDIGITALIZADO_PR (
        EV_NUM_CORRELATIVO      IN          GA_DOC_DIGITALIZADOS_TO.NUM_CORRELATIVO%TYPE,
        EV_NOM_USUARORA         IN          GA_DOC_DIGITALIZADOS_TO.NOM_USUARORA%TYPE,
        EV_NOMBRE_ARCHIVO       IN          GA_DOC_DIGITALIZADOS_TO.NOMBRE_ARCHIVO%TYPE,
        EV_OBSERVACION          IN          GA_DOC_DIGITALIZADOS_TO.OBSERVACION%TYPE,
        EV_VALOR_CONTENT_TYPE   IN          GA_DOC_DIGITALIZADOS_TO.VALOR_CONTENT_TYPE%TYPE,
        EV_BIN_ARCHIVO          IN          GA_DOC_DIGITALIZADOS_TO.BIN_ARCHIVO%TYPE,
        SN_cod_retorno          OUT NOCOPY  ge_errores_pg.coderror,
        SV_mens_retorno         OUT NOCOPY  ge_errores_pg.msgerror,
        SN_num_evento           OUT NOCOPY  ge_errores_pg.evento) IS

        lv_des_error            ge_errores_pg.desevent;
        LV_sSql      			ge_errores_pg.vQuery;
        v_fecha_creacion        DATE;

        BEGIN

            IF EV_NOMBRE_ARCHIVO  IS NULL THEN
                v_fecha_creacion := NULL;
            ELSE
                v_fecha_creacion := SYSDATE;
            END IF;
            
            LV_sSql   := 'UPDATE ga_doc_digitalizados_to a SET' || '
                a.NOM_USUARORA = '|| EV_NOM_USUARORA || ',
                a.NOMBRE_ARCHIVO = ' || EV_NOMBRE_ARCHIVO ||',
                a.OBSERVACION = '||EV_OBSERVACION ||',
                a.VALOR_CONTENT_TYPE = '|| EV_VALOR_CONTENT_TYPE ||',
                a.BIN_ARCHIVO = EV_BIN_ARCHIVO,
                a.FEC_CREACION = ' || v_fecha_creacion ||'
            WHERE
                a.NUM_CORRELATIVO = ' || EV_NUM_CORRELATIVO ;

            UPDATE ga_doc_digitalizados_to a SET
                a.NOM_USUARORA = EV_NOM_USUARORA,
                a.NOMBRE_ARCHIVO = EV_NOMBRE_ARCHIVO,
                a.OBSERVACION = EV_OBSERVACION,
                a.VALOR_CONTENT_TYPE = EV_VALOR_CONTENT_TYPE,
                a.BIN_ARCHIVO = EV_BIN_ARCHIVO,
                a.FEC_CREACION = v_fecha_creacion
            WHERE
                a.NUM_CORRELATIVO = EV_NUM_CORRELATIVO;

        EXCEPTION
            WHEN OTHERS THEN
                SN_cod_retorno := 4;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno, SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                    END IF;
                lv_des_error := 'GA_REPOSITORIO_PG.VE_UPDATE_DOCDIGITALIZADO_PR;- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, cv_cod_modulo, SV_mens_retorno, '1.0', USER,
                'GA_REPOSITORIO_PG.VE_UPDATE_DOCDIGITALIZADO_PR', LV_sSql   , SQLCODE, lv_des_error);
        END VE_UPDATE_DOCDIGITALIZADO_PR;

END GA_REPOSITORIO_PG; 
/

SHOW ERRORS
