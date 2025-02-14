CREATE OR REPLACE PROCEDURE CO_P_COMIS_RECUPERO_MPR(
v_Entidada     IN VARCHAR2,
v_FecDesde     IN VARCHAR2,
v_FecHasta     IN VARCHAR2,
v_NumSecuencia IN NUMBER
)IS
v_PorcAplicar  CO_TRASPASO_COMISION_TO.POR_APLICADO%TYPE;
v_cod_error    NUMBER;
v_Des_error    VARCHAR(50);
v_MtoAsignado  CO_TRASPASO_COMISION_TO.MTO_ASIGNADO%TYPE;
v_MtoRecaudado CO_TRASPASO_COMISION_TO.MTO_RECAUDADO%TYPE;
v_PorcRecupero CO_TRASPASO_COMISION_TO.POR_RECUPERADO%TYPE;
v_Comision     CO_TRASPASO_COMISION_TO.MTO_COMISION%TYPE;
V_FORMAT_FECHA  ged_parametros.VAL_PARAMETRO%TYPE;
v_sqlcode        VARCHAR2(10);
v_sqlerrm        VARCHAR2(200);
--ERROR_PROCESO EXCEPTION;
BEGIN
        -- Se obtiene el formato de la fecha segun la operadora de la ged_parametro
        V_FORMAT_FECHA := SP_FN_FORMATOFECHA('FORMATO_SEL2') ;

        v_cod_error := 1;
        v_Des_error := 'ERROR EN SELECT CO_COBEXTERNADOC';
        v_MtoAsignado := 0;

        SELECT nvl(SUM(IMPORTE_DEBE),0)
        INTO v_MtoAsignado
        FROM CO_COBEXTERNADOC
        WHERE IND_INFORMADO = 'S'
        AND COD_ENTIDAD = v_Entidada;

        --   DBMS_OUTPUT.PUT_LINE('v_MtoAsignado   : '||v_MtoAsignado  );

        v_cod_error := 2;
        v_Des_error := 'ERROR EN SELECT CO_HCOBEXTERNADOC';
        v_MtoRecaudado := 0;

        SELECT nvl(SUM(IMPORTE_DEBE),0)
        INTO v_MtoRecaudado
        FROM CO_HCOBEXTERNADOC
        WHERE IND_CANCELADO = 1
        AND COD_ENTIDAD = v_Entidada
        AND FEC_HISTORICO BETWEEN to_date(v_FecDesde,V_FORMAT_FECHA) AND to_date(v_FecHasta,V_FORMAT_FECHA);

        v_MtoAsignado := v_MtoAsignado + v_MtoRecaudado;

        -- DBMS_OUTPUT.PUT_LINE('v_MtoRecaudado  : '||v_MtoRecaudado );
        v_PorcRecupero:= trunc((v_MtoRecaudado * 100) / v_MtoAsignado,4);
        -- DBMS_OUTPUT.PUT_LINE('v_PorcRecupero  : '||v_PorcRecupero );

        v_cod_error := 3;
        v_Des_error := 'ERROR EN SELECT DE PORCENTAJE APLICADO';
        v_PorcAplicar := 0;

        SELECT NVL(PORCENTAJE,0) INTO v_PorcAplicar FROM (
        SELECT P.PL_CALCULO, G.TRAMO_DESDE DESDE, G.TRAMO_HASTA HASTA, G.PORC_APLICADO PORCENTAJE
        FROM CO_PL_COMISION P, CO_GTOS_COBRANZA G
        WHERE G.COD_ENTIDAD = v_Entidada
        AND G.TIP_COMISION = P.TIP_COMISION
        AND P.FORMA_CALCULO = 'M'
        AND SYSDATE BETWEEN G.FEC_VIGENCIA_DD_DH AND G.FEC_VIGENCIA_HH_DH)
        WHERE v_PorcRecupero BETWEEN DESDE AND HASTA;

        v_Comision:= (v_PorcAplicar/100) * v_MtoRecaudado;

        --DBMS_OUTPUT.PUT_LINE('v_Comision : '||v_Comision);

        v_cod_error:=0;
        v_Des_error := 'OK';

        INSERT INTO CO_TRASPASO_COMISION_TO(NUM_TRANSACCION, MTO_ASIGNADO, MTO_RECAUDADO,MTO_COMISION,
        POR_RECUPERADO, POR_APLICADO,FEC_TRANSACCION, USUARIO)
        VALUES(v_NumSecuencia,v_MtoAsignado,v_MtoRecaudado,v_Comision,v_PorcRecupero,v_PorcAplicar,SYSDATE,USER);

        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
        VALUES (v_NumSecuencia,v_cod_error,v_des_error);


        EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN
                        v_sqlcode := sqlcode;
                        v_sqlerrm := sqlerrm;
                        DBMS_OUTPUT.PUT_LINE('Error Oracle ====> '||v_sqlcode||' '||v_sqlerrm);
                        DBMS_OUTPUT.PUT_LINE('Error 2 ');
                        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                        VALUES (           v_NumSecuencia,v_cod_error,v_des_error);
                WHEN NO_DATA_FOUND THEN
                        v_sqlcode := sqlcode;
                        v_sqlerrm := sqlerrm;
                        DBMS_OUTPUT.PUT_LINE('Error Oracle ====> '||v_sqlcode||' '||v_sqlerrm);
                        DBMS_OUTPUT.PUT_LINE('Error 3 ');
                        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                        VALUES (v_NumSecuencia,v_cod_error,v_des_error);
                WHEN OTHERS THEN
                        v_sqlcode := sqlcode;
                        v_sqlerrm := sqlerrm;
                        DBMS_OUTPUT.PUT_LINE('Error Oracle ====> '||v_sqlcode||' '||v_sqlerrm);
                        DBMS_OUTPUT.PUT_LINE('Error 4 ');
                        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                        VALUES (v_NumSecuencia,v_cod_error,v_des_error);
END CO_P_COMIS_RECUPERO_MPR;
/
SHOW ERRORS
