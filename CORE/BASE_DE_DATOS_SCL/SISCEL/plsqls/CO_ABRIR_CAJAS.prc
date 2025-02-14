CREATE OR REPLACE PROCEDURE CO_ABRIR_CAJAS( vp_num_ejerc     IN VARCHAR2   , vp_cod_periodo   IN VARCHAR2  ,
                                           vp_cod_servicio  IN VARCHAR2  , vp_cod_empresa   IN VARCHAR2  ,
                                           vp_outGlosa      OUT NOCOPY VARCHAR2 , vp_outRetorno    OUT NOCOPY NUMBER) IS
/*
<NOMBRE>      : CO_ABRIR_CAJAS/NOMBRE>
<FECHACREA>   : 09-07-2000<FECHACREA/>
<MODULO >     : Cobranza </MODULO >
<AUTOR >      : GAC</AUTOR >
<VERSION >    : </VERSION >
<DESCRIPCION> : Efectua la apertura de caja virtual para pagos NT</DESCRIPCION>
<FECHAMOD >   : 14-09-2005</FECHAMOD >
<DESCMOD >    : Se eliminan valores en duro en query a la tabla co_cajeros</DESCMOD >
<ParamEntr>   : vp_num_ejerc   : Numero de ejercicio </ParamEntr>
<ParamEntr>   : vp_cod_periodo : Codigo de periodo </ParamEntr>
<ParamEntr>   : vp_cod_servicio: Codigo de servicio </ParamEntr>
<ParamEntr>   : vp_cod_empresa : Codigo de empresa </ParamEntr>
<ParamSal >   : vp_outGlosa    : Glosa de retorno </ParamSal >
<ParamSal >   : vp_outRetorno  : Valor de retorno. </ParamSal >
*/

sUsuario        VARCHAR2(30);
iFechayyyymmdd  NUMBER(8);
iInd_dias       NUMBER(3);
iVp_error       NUMBER(5);
sVp_gls_error   VARCHAR2(255);
iTip_movcaja    NUMBER(1);
sNom_proceso    VARCHAR2(50);
sDesc_Sql       VARCHAR2(150);
sEmp_Recauda    CO_EMPRESAS_REX.EMP_RECAUDADORA%TYPE;
sCod_oficina    CO_EMPRESAS_REX.COD_OFICINA%TYPE;
iCod_caja       CO_EMPRESAS_REX.COD_CAJA%TYPE;
iTip_valor      CO_TIPVALOR.TIP_VALOR%TYPE;
sCod_Moneda		CO_TIPVALOR.COD_MONEDA%TYPE;
sFec_Desde      VARCHAR2(25);
sFec_Hasta_N    VARCHAR2(25);
sFec_Hasta_F    VARCHAR2(25);
sFec_Cierre     VARCHAR2(25);
sPeriodo        VARCHAR2(6);
sCod_TipPer     CED_SERVEMPRE.COD_TIPPERCONC%TYPE;

sDia_Actual     VARCHAR2(11);
iDia_Festivo    NUMBER := 1;
iNum_Dias       NUMBER := 1;

sCod_Operadora  CO_EMPRESAS_REX.COD_OPERADORA_SCL%TYPE;
sCod_Plaza		CO_EMPRESAS_REX.COD_PLAZA%TYPE;


/********/
CURSOR c1 IS
SELECT TIP_VALOR, COD_MONEDA
FROM CO_TIPVALOR
WHERE IND_EFECTIVO=1;
/*******/

ERROR_PROCESO EXCEPTION;
BEGIN
   sNom_proceso := 'CO_ABRIR_CAJAS';
   sPeriodo := vp_cod_periodo;

   sDesc_Sql := 'SELECT FROM CO_EMPRESAS_REX';
   SELECT EMP_RECAUDADORA, COD_OFICINA , COD_CAJA, COD_OPERADORA_SCL, COD_PLAZA
   INTO   sEmp_Recauda, sCod_oficina , iCod_caja, sCod_Operadora, sCod_Plaza
   FROM   CO_EMPRESAS_REX
   WHERE  EMP_RECAUDADORA = vp_cod_empresa;

   sDesc_Sql := 'SELECT FROM CO_CAJEROS';
   SELECT UNIQUE NOM_USUARORA, TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMMDD'))
   INTO   sUsuario, iFechayyyymmdd
   FROM   CO_CAJEROS
   WHERE  COD_OFICINA = sCod_oficina --'NT'
   AND    COD_CAJA    = iCod_caja;

   sDesc_Sql := 'INSERT INTO COT_CAJAS_NT' ;
   INSERT INTO COT_CAJAS_NT
           (COD_OFICINA, COD_CAJA, NUM_EJERCICIO, DES_CAJA, FEC_ALTA, NOM_USUALTA,
            IND_ABIERTA, FEC_EFECTIVIDAD, NOM_USUARORA, MAX_REINTEGRO, DIR_IP, NUM_SECUMOV)
   VALUES  (sCod_oficina, iCod_caja, vp_num_ejerc, sEmp_Recauda, SYSDATE, USER,
            1, SYSDATE, sUsuario, 10000 , '172.20.77.90', 1);


   IF  sCod_oficina = 'NT' THEN
        sDesc_Sql := 'SELECT FROM CED_SERVEMPRE';
        SELECT COD_TIPPERCONC
        INTO   sCod_TipPer
        FROM   CED_SERVEMPRE
        WHERE  SUBSTR(COD_SERVICIO,1,3) = vp_cod_servicio
        AND    COD_EMPRESA  = vp_cod_empresa;
   ELSE
        sCod_TipPer := 'DIA_N';
   END IF;

   IF sCod_TipPer = 'DIA_N' THEN
       BEGIN
            sDesc_Sql := 'SELECT FEC DESDE Y HASTA (Dia_N)';
            sFec_Desde  := TO_CHAR(TO_DATE(sPeriodo,'DDMMRR'),'DD-MM-YYYY')||' 00:00:01';
            sFec_Hasta_N:= TO_CHAR(TO_DATE(sPeriodo,'DDMMRR'),'DD-MM-YYYY')||' 23:59:59';

            sDesc_Sql := 'INSERT INTO CET_PERIODOSERV (Dia Normal 00:00-23:59)';
            INSERT INTO CET_PERIODOSERV
                   (COD_SERVICIO , COD_PERIODO , COD_EMPRESA , COD_TIPPERIODO , COD_TIPUSO ,
                            FEC_DESDE    , FEC_HASTA   , COD_ESTADO  , FEC_ULTMOD     , NOM_USUARIO, IND_GRUPOSERV)
            VALUES ('REX02', sPeriodo , vp_cod_empresa , sCod_TipPer, 'PA',
                            TO_DATE(sFec_Desde,'DD-MM-YYYY HH24:MI:SS') , TO_DATE(sFec_Hasta_N,'DD-MM-YYYY HH24:MI:SS'),
                           'AB' , SYSDATE , sUsuario , 0 );
        END;
   ELSE
        BEGIN
            sDesc_Sql :='SELECT TO_CHAR(sPeriodo,DAY)';
            sDia_Actual:= TO_CHAR(TO_DATE(sPeriodo,'DDMMYY'),'DAY');

            IF LTRIM(RTRIM(sDia_Actual)) = 'MONDAY' THEN
               BEGIN
               iNum_Dias := iNum_Dias + 2;
               END;
            END IF;

            LOOP

                EXIT WHEN iDia_Festivo = 0;
                sDesc_Sql :='SELECT TO_CHAR(Dia_F)';
                sFec_Desde  := TO_CHAR(TO_DATE(sPeriodo,'DDMMRR')-iNum_Dias,'DD-MM-YYYY')||' 14:00:00';
                sFec_Hasta_F:= TO_CHAR(TO_DATE(sPeriodo,'DDMMRR'),'DD-MM-YYYY')||' 13:59:59';
                sFec_Cierre := TO_CHAR(TO_DATE(sPeriodo,'DDMMRR')-iNum_Dias,'DD-MM-YYYY');

                sDesc_Sql :='SELECT COUNT(*) FROM TA_DIASFEST';
                SELECT COUNT(1)
                INTO   iDia_Festivo
                FROM   TA_DIASFEST
                WHERE  FEC_DIAFEST = TO_DATE(sFec_Cierre,'DD-MM-YYYY');

				iNum_Dias := iNum_Dias + 1;
                IF iDia_Festivo > 0 THEN

				   sDia_Actual:= TO_CHAR(TO_DATE(sFec_Cierre,'DD-MM-YY'),'DAY');
				   IF LTRIM(RTRIM(sDia_Actual)) = 'MONDAY' THEN
                      BEGIN
                         iNum_Dias := iNum_Dias + 2;
                         iDia_Festivo := 1;
                      END;
	               END IF;
                END IF;

            END LOOP;

            sDesc_Sql := 'INSERT INTO CET_PERIODOSERV (Dia Financiero 14:00-13:59)';
            INSERT INTO CET_PERIODOSERV
                   (COD_SERVICIO , COD_PERIODO , COD_EMPRESA , COD_TIPPERIODO , COD_TIPUSO ,
                    FEC_DESDE    , FEC_HASTA   , COD_ESTADO  , FEC_ULTMOD     , NOM_USUARIO, IND_GRUPOSERV)
            VALUES ('REX02' , sPeriodo, vp_cod_empresa , sCod_TipPer , 'PA',
                    TO_DATE(sFec_Desde,'DD-MM-YYYY HH24:MI:SS') , TO_DATE(sFec_Hasta_F,'DD-MM-YYYY HH24:MI:SS'),
                   'AB', SYSDATE , sUsuario , 0);
        END;
   END IF;


   FOR rREG IN c1 LOOP
     iTip_movcaja := 1;
     LOOP
       EXIT WHEN iTip_movcaja > 2;

       sDesc_Sql := 'INSERT INTO CO_MOVIMIENTOSCAJA';
       INSERT INTO CO_MOVIMIENTOSCAJA
                (COD_OFICINA, COD_CAJA, NUM_SECUMOV, NUM_EJERCICIO,
				FEC_EFECTIVIDAD, NOM_USUARORA, TIP_MOVCAJA, IND_DEPOSITO,
				IMPORTE, IND_ERRONEO, TIP_VALOR, IND_CIERRE,
                COD_CLIENTE, NUM_ABONADO,COD_PRODUCTO, TIP_DOCUMENT,
				COD_VENDEDOR_AGENTE, LETRA, COD_CENTREMI, NUM_SECUENCI,
				LETRAC,COD_CENTRC, NUM_SECUC, COD_BANCO,
				COD_SUCURSAL, CTA_CORRIENTE, NUM_CHEQUE, TIP_CLEARING,
				FEC_CHEQUE, COD_TIPTARJETA, NUM_TARJETA, COD_AUTORIZA,
				NUM_CUPON, NUM_CUOTAS, FEC_CUPON, COD_MOVILI,
				DES_MOVILI, COD_RECOMPE, NOM_CUSTODIA, NUM_IDENT,
				NUM_ORDEN, FEC_EMISION, FEC_VENCIMIENTO, COD_COBRADOR,
				NUM_INGMANUAL, NUM_RESPINGR, NUM_COMPAGO, PREF_PLAZA,
				COD_MONEDA, COD_OPERADORA_SCL, COD_PLAZA)
	   VALUES (
              sCod_oficina, iCod_caja, COS_SEQ_MOVCAJA.NEXTVAL , vp_num_ejerc ,
              SYSDATE , sUsuario , iTip_movcaja , 0 ,
              0 , 0 , rREG.TIP_VALOR ,0 ,
              NULL , NULL , NULL , NULL ,
              NULL , NULL , NULL , NULL ,
              NULL , NULL , NULL , NULL ,
              NULL , NULL , NULL , NULL ,
              NULL , NULL , NULL , NULL ,
              NULL , NULL , NULL , NULL ,
              NULL , NULL , NULL , NULL ,
              NULL , NULL , NULL , NULL ,
			  NULL , NULL , NULL , NULL ,
              rREG.COD_MONEDA , sCod_Operadora , sCod_Plaza );

        	  iTip_movcaja := iTip_movcaja + 1;
     END LOOP;

     INSERT INTO CO_EFECTIVO_CAJAS
           (COD_OFICINA, COD_CAJA , NUM_EJERCICIO,COD_MONEDA,EFEC_EGRESO,EFEC_CAMBIO,COD_OPERADORA_SCL,COD_PLAZA)
     VALUES (sCod_oficina, iCod_caja,vp_num_ejerc,rREG.COD_MONEDA,0,0, sCod_Operadora , sCod_Plaza );
   END LOOP;

    vp_outGlosa   := 'OK';
    vp_outRetorno := 0;
    COMMIT;

    EXCEPTION
      WHEN ERROR_PROCESO THEN
           ROLLBACK;
           vp_outGlosa   := 'Error : '||sVp_gls_error;
           vp_outRetorno := 1;
           INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO , DESC_SQL , DESC_CADENA)
           VALUES (sNom_proceso, iVp_error, SYSDATE, sDesc_Sql, sVp_gls_error);
           COMMIT;
      WHEN NO_DATA_FOUND THEN
           ROLLBACK;
           sVp_gls_error := 'No Hay Datos - ' || SQLERRM;
           iVp_error := SQLCODE;
           vp_outGlosa   := 'Error : '|| SQLERRM;
           vp_outRetorno := 100;
           INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO , DESC_SQL , DESC_CADENA)
           VALUES (sNom_proceso, iVp_error, SYSDATE, sDesc_Sql , sVp_gls_error);
           COMMIT;
      WHEN OTHERS THEN
           ROLLBACK;
           sVp_gls_error := 'Otros Errores - ' || SQLERRM;
           iVp_error := SQLCODE;
           vp_outGlosa   := 'Error : '|| SQLERRM;
           vp_outRetorno := 1;
           INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO , DESC_SQL , DESC_CADENA)
           VALUES (sNom_proceso, iVp_error, SYSDATE, sDesc_Sql, sVp_gls_error);
           COMMIT;
END CO_ABRIR_CAJAS;
/
SHOW ERRORS
