CREATE OR REPLACE PACKAGE BODY FA_TRAZA_CICLO_PG AS

FUNCTION FA_OBTIENE_TDOCUM_CDESPACHO_FN ( EN_CODCICLO IN NUMBER, EN_CODTIPDOCUM IN NUMBER, EN_CODDESPACHO IN VARCHAR2, EN_HOSTID IN VARCHAR2) RETURN RET_TAB PIPELINED IS

    lv_sql VARCHAR2(1000);

    LN_COD_CLIEINI  NUMBER;
    LN_COD_CLIEFIN  NUMBER;
    LN_COD_TIPDOCUM NUMBER(2);
    LV_COD_DESPACHO VARCHAR2(5);

    TYPE DCTOS_DESPACHO IS REF CURSOR;
    cDCTOS_DESPACHO DCTOS_DESPACHO;

  BEGIN



        IF EN_CODCICLO IS NULL THEN
            return;
        END IF;


        IF EN_HOSTID IS NOT NULL THEN

            BEGIN
                SELECT COD_CLIENTEINI,COD_CLIENTEFIN
                    INTO LN_COD_CLIEINI, LN_COD_CLIEFIN
                FROM FA_RANGOSHOST_TO
                WHERE COD_CICLFACT = EN_CODCICLO
                AND   HOST_ID      = EN_HOSTID;
            EXCEPTION
            WHEN OTHERS THEN
		        RAISE;
		    END;
        END IF;


        lv_sql := 'SELECT distinct A.COD_TIPDOCUM, NVL(A.COD_DESPACHO,''DESNO'') ';
    	lv_sql := lv_sql || ' FROM FA_FACTDOCU_' || EN_CODCICLO || ' A,' || 'FA_TIPDOCUMEN  B ';
    	lv_sql := lv_sql || ' WHERE A.TOT_FACTURA   >= 0 ';
    	lv_sql := lv_sql || '  AND  A.NUM_FOLIO     >= 0 ';
        lv_sql := lv_sql || '  AND  A.IND_SUPERTEL   = 0 ';
        lv_sql := lv_sql || '  AND  A.IND_ANULADA    = 0 ';
        lv_sql := lv_sql || '  AND  A.IND_FACTUR     = 1 ';
        lv_sql := lv_sql || '  AND  A.IND_IMPRESA    = 0 ';

        IF EN_CODTIPDOCUM IS NOT NULL THEN
            lv_sql := lv_sql || '  AND  A.COD_TIPDOCUM   = ' || EN_CODTIPDOCUM;
        END IF;

        IF EN_CODDESPACHO IS NOT NULL THEN
            lv_sql := lv_sql || '  AND  A.COD_DESPACHO   = ''' || EN_CODDESPACHO || '''';
        END IF;

        IF EN_HOSTID IS NOT NULL THEN
            lv_sql := lv_sql || '  AND A.COD_CLIENTE >= ' || LN_COD_CLIEINI;
            lv_sql := lv_sql || '  AND A.COD_CLIENTE <= ' || LN_COD_CLIEFIN;
        END IF;


        lv_sql := lv_sql || '  AND  A.COD_TIPDOCUM   = B.COD_TIPDOCUMMOV ';

        BEGIN
            OPEN cDCTOS_DESPACHO FOR lv_sql;
            LOOP
                FETCH cDCTOS_DESPACHO INTO LN_COD_TIPDOCUM, LV_COD_DESPACHO;

                EXIT WHEN cDCTOS_DESPACHO%NOTFOUND;
                pipe row ( LN_COD_TIPDOCUM ||'|'|| LV_COD_DESPACHO||'|');

            END LOOP;
            CLOSE cDCTOS_DESPACHO;
        EXCEPTION
		WHEN OTHERS THEN
    		RAISE;
		END;

return;
END FA_OBTIENE_TDOCUM_CDESPACHO_FN;





PROCEDURE FA_TRATA_TRAZA_IMPCICLO_FN ( EN_CODCICLO IN NUMBER, EN_CODTIPDOCUM IN NUMBER, EN_CODDESPACHO IN VARCHAR2, EN_HOSTID IN VARCHAR2, EN_COMANDO IN VARCHAR2, SN_COD_ERROR OUT NUMBER)
IS

    lv_sql VARCHAR2(1000);

    LN_COD_CLIEINI  NUMBER;
    LN_COD_CLIEFIN  NUMBER;
    LN_COD_TIPDOCUM NUMBER(2);
    LV_COD_DESPACHO VARCHAR2(5);

    TYPE DCTOS_DESPACHO IS REF CURSOR;
    cDCTOS_DESPACHO DCTOS_DESPACHO;

  BEGIN

        SN_COD_ERROR :=0;


        IF EN_CODCICLO IS NULL THEN
            SN_COD_ERROR :=1;
            return;
        END IF;


        IF EN_HOSTID IS NOT NULL THEN

            BEGIN
                SELECT COD_CLIENTEINI,COD_CLIENTEFIN
                    INTO LN_COD_CLIEINI, LN_COD_CLIEFIN
                FROM FA_RANGOSHOST_TO
                WHERE COD_CICLFACT = EN_CODCICLO
                AND   HOST_ID      = EN_HOSTID;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE;
            WHEN OTHERS THEN
		        SN_COD_ERROR :=1;
                RAISE;
		    END;
        END IF;


        lv_sql := 'SELECT distinct A.COD_TIPDOCUM, NVL(A.COD_DESPACHO,''DESNO'') ';
    	lv_sql := lv_sql || ' FROM FA_FACTDOCU_' || EN_CODCICLO || ' A,' || 'FA_TIPDOCUMEN  B ';
    	lv_sql := lv_sql || ' WHERE A.TOT_FACTURA   >= 0 ';
    	lv_sql := lv_sql || '  AND  A.NUM_FOLIO     >= 0 ';
        lv_sql := lv_sql || '  AND  A.IND_SUPERTEL   = 0 ';
        lv_sql := lv_sql || '  AND  A.IND_ANULADA    = 0 ';
        lv_sql := lv_sql || '  AND  A.IND_FACTUR     = 1 ';
        lv_sql := lv_sql || '  AND  A.IND_IMPRESA    = 0 ';

        IF EN_CODTIPDOCUM IS NOT NULL THEN
            lv_sql := lv_sql || '  AND  A.COD_TIPDOCUM   = ' || EN_CODTIPDOCUM;
        END IF;

        IF EN_CODDESPACHO IS NOT NULL THEN
            lv_sql := lv_sql || '  AND  A.COD_DESPACHO   = ''' || EN_CODDESPACHO || '''';
        END IF;

        IF EN_HOSTID IS NOT NULL THEN
            lv_sql := lv_sql || '  AND A.COD_CLIENTE >= ' || LN_COD_CLIEINI;
            lv_sql := lv_sql || '  AND A.COD_CLIENTE <= ' || LN_COD_CLIEFIN;
        END IF;


        lv_sql := lv_sql || '  AND  A.COD_TIPDOCUM   = B.COD_TIPDOCUMMOV ';

        BEGIN
            OPEN cDCTOS_DESPACHO FOR lv_sql;
            LOOP
                FETCH cDCTOS_DESPACHO INTO LN_COD_TIPDOCUM, LV_COD_DESPACHO;

                EXIT WHEN cDCTOS_DESPACHO%NOTFOUND;

                    BEGIN

                        IF EN_HOSTID IS NOT NULL THEN

                            DELETE FROM FA_PROCIMPRESION_TD
                            WHERE COD_CICLFACT = EN_CODCICLO
                            AND   COD_TIPDOCUM = LN_COD_TIPDOCUM
                            AND   COD_DESPACHO = LV_COD_DESPACHO
                            AND   HOST_ID      = EN_HOSTID;
                        ELSE
                            DELETE FROM FA_PROCIMPRESION_TD
                            WHERE COD_CICLFACT = EN_CODCICLO
                            AND   COD_TIPDOCUM = LN_COD_TIPDOCUM
                            AND   COD_DESPACHO = LV_COD_DESPACHO
                            AND   HOST_ID      IS NULL;
                        END IF;

                        INSERT INTO FA_PROCIMPRESION_TD
                                ( COD_CICLFACT, COD_TIPDOCUM, COD_DESPACHO, COD_ESTAPROC, FEC_INICIO,FEC_TERMINO, CMD_EJECUCION, HOST_ID)
                        VALUES
                                ( EN_CODCICLO, LN_COD_TIPDOCUM, LV_COD_DESPACHO, 4 , SYSDATE, NULL, EN_COMANDO, EN_HOSTID);
                    EXCEPTION
                    WHEN DUP_VAL_ON_INDEX THEN
            		    SN_COD_ERROR :=1;
                        RAISE;
            		WHEN NO_DATA_FOUND THEN
                        RAISE;
                    WHEN OTHERS THEN
              		    SN_COD_ERROR :=1;
                        RAISE;
            		END;



            END LOOP;
            CLOSE cDCTOS_DESPACHO;

        EXCEPTION
		WHEN NO_DATA_FOUND THEN
		    RAISE;
        WHEN OTHERS THEN
    		SN_COD_ERROR :=1;
            RAISE;
		END;

END FA_TRATA_TRAZA_IMPCICLO_FN;



END FA_TRAZA_CICLO_PG;
/
SHOW ERRORS
