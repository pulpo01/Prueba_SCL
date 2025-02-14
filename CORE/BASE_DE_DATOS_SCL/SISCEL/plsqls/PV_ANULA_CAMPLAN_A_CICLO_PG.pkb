CREATE OR REPLACE PACKAGE BODY PV_ANULA_CAMPLAN_A_CICLO_PG AS


PROCEDURE PV_ANULA_CAMPLAN_A_CICLO_PR(
          EV_cod_cliente           IN               ge_clientes.cod_cliente%TYPE,
      EV_num_abonado           IN               ga_abocel.num_abonado%TYPE,
          EV_cod_plantarif         IN               ta_plantarif.cod_plantarif%TYPE,
          SV_cod_retorno           OUT              VARCHAR2,--1 tiene 0 no tiene 4 error
      SV_glosa_retorno         OUT              VARCHAR2,
          SV_plan_NUEVO            OUT              ta_plantarif.cod_plantarif%TYPE,
          SV_NUM_OOSS              OUT              pv_camcom.num_os%TYPE,
          SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento
          )
        IS

--Declaracion de Variables
--version 2.0 --****--COL - 71894|25-11-2008|EFR.
--version 3.0 --****--COL - 71894|15-12-2008|EFR.
--***********************************************
        LV_des_error        ge_errores_pg.DesEvent;
        LV_sSql                     ge_errores_pg.vQuery;
        V_ESTADO            PV_IORSERV.cod_estado%TYPE;
        ERROR_INTARCEL EXCEPTION;
        TODO_OK             EXCEPTION;
        V_PLANTARIF         ta_plantarif.cod_plantarif%TYPE;
        V_COUNT             number(2);
        V_FEC_DESDE_ANT     DATE;
        V_INTENTO_MAX       VARCHAR2(3);
        V_NUM_OOSS          PV_IORSERV.NUM_OS%TYPE;
        V_COD_PLANTARIF_NUE PV_PARAM_ABOCEL.COD_PLANTARIF_NUE%TYPE;
        V_FEC_DESDE2        VARCHAR2(30);
        V_FEC_DESDE         DATE;
        V_NUM_ABONADO       GA_ABOCEL.NUM_ABONADO%TYPE;
        V_COD_LIMCOSUMO     GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
        V_CODPLANTARIF_NUE  GA_INTARCEL.COD_PLANTARIF%TYPE;
        V_CODPLAN_DES           TA_PLANTARIF.COD_TIPLAN%TYPE;
        ln_count_pend           PV_IORSERV.NUM_OS%TYPE;
        LN_COUNT_INTARCEL       NUMBER(5);
        LV_FEC_MAX                      DATE;
        LV_FEC_MIN                      DATE;
		LD_FecDesde						DATE;

--Declaracion de Cursores
CURSOR OOSS_BATCH IS
      SELECT A.NUM_OS
      FROM PV_IORSERV A,PV_PARAM_ABOCEL B
      WHERE A.COD_OS IN (10022,10029,10020,10233,10530,10539)
      AND TRUNC(A.FH_EJECUCION) >= TRUNC(SYSDATE)
      AND A.NUM_OS =B.NUM_OS
      AND A.NUM_OS IN (SELECT  C.NUM_OS FROM PV_CAMCOM C
                       WHERE   C.COD_CLIENTE = EV_COD_CLIENTE
                                           AND C.NUM_ABONADO=V_NUM_ABONADO
                               AND TRUNC(C.FEC_VENCIMIENTO) >= TRUNC(SYSDATE)
                              )
          AND COD_ESTADO <210;


CURSOR INTARCEL IS
       SELECT FEC_DESDE,NUM_ABONADO
       FROM GA_INTARCEL
       WHERE  COD_CLIENTE = EV_COD_CLIENTE
           AND NUM_ABONADO=V_NUM_ABONADO
       AND    FEC_HASTA  IN (SELECT  MAX(FEC_HASTA) FROM GA_INTARCEL
                            WHERE
                                        COD_CLIENTE = EV_COD_CLIENTE
                                                        AND NUM_ABONADO=V_NUM_ABONADO
                                        AND TRUNC(FEC_HASTA) <= TO_DATE(V_FEC_DESDE2,'DD-MM-YYYY')
                            AND COD_PLANTARIF= EV_COD_PLANTARIF
                                                AND ROWNUM=1)
      AND ROWNUM=1;

-- INICIO RRG COL 02-12-2008
-- ESTA CUSTION TAMBIEN TA MALA
-- YA QUE NO TOMA EL ABONADO CERO (0)
/*CURSOR ABOCEL IS
       SELECT NUM_ABONADO
       FROM GA_ABOCEL
       WHERE  COD_CLIENTE = EV_COD_CLIENTE
           AND COD_SITUACION NOT IN ('BAA','BAP');-*/


CURSOR ABOCEL IS
 /* INI COL 71894|15-12-2008|SAQL
	   select NUM_ABONADO from
	   ga_intarcel where cod_cliente = EV_COD_CLIENTE
	   and  fec_desde > sysdate;
*/
	SELECT A.NUM_ABONADO
	FROM PV_CAMCOM A, PV_IORSERV B
	where A.COD_CLIENTE = EV_cod_cliente
	AND B.COD_OS IN ('10022','10029','10020','10233','10530','10539')
	AND B.COD_ESTADO < 210
	AND A.NUM_OS = B.NUM_OS;
-- FIN COL 71894|15-12-2008|SAQL

-- FIN	RRG COL 02-12-2008


        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_ANULA_CAMPLAN_A_CICLO_PR"
              Lenguaje="PL/SQL"
              Fecha="14-06-2007"
              Versión="La del package"
              Diseñador= " Orlando Cabezas"
              Programador="Nicolás Contreras"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Anula la solicitud de cambio de plan realizando la eliminacion o termino de vigencia en tablas GA_INTARCEL y GA_FINCICLO </Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EV_cod_cliente" Tipo="STRING"></param>>
                                <param nom="EV_num_abonado" Tipo="STRING"></param>>
                                <param nom="EV_cod_plantarif" Tipo="STRING"></param>>
                     </Entrada>
                 <Salida>
                                <param nom="SV_cod_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                                <param nom="SV_glosa_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                                <param nom="SV_plan_NUEVO" Tipo="CARACTER">Mensaje de Retorno</param>>
                                <param nom="SV_NUM_OOSS" Tipo="CARACTER">Mensaje de Retorno</param>>
                                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
BEGIN
        SV_glosa_retorno:='OK';
        SV_cod_retorno:='0';
        SV_plan_NUEVO:='-';
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;
        SN_cod_retorno:='0';
        SV_mens_retorno:='0';
        SN_num_evento:='0';
        SV_NUM_OOSS:=0;


        V_num_abonado:=EV_num_abonado;

    LV_sSQL := 'SELECT VAL_PARAMETRO FROM GED_PARAMETROS WHERE NOM_PARAMETRO = ''MAX_INTENTOS'' AND COD_MODULO = ''GA'' AND COD_PRODUCTO = 1';

        SELECT VAL_PARAMETRO
         INTO V_INTENTO_MAX
          FROM GED_PARAMETROS
           WHERE NOM_PARAMETRO = 'MAX_INTENTOS'
                         AND COD_MODULO      = 'GA'
                         AND COD_PRODUCTO    = 1;


   --Eliminar Tabla GA_FREC_CICLO esta se debe eliminar si existe cambio de plan a ciclo pendiente,
   --esto aplica para cualquier cliente



--Validar si cliente es empresa

     LV_sSQL := ' SELECT COUNT(1) FROM GA_EMPRESA WHERE COD_CLIENTE='||EV_cod_cliente;
     SELECT COUNT(1)
     INTO V_COUNT
     FROM GA_EMPRESA
     WHERE COD_CLIENTE=EV_cod_cliente;

IF V_COUNT=0 THEN
      ln_count_pend:=0;

          SELECT count(1)
          Into ln_count_pend
      FROM PV_IORSERV A,PV_PARAM_ABOCEL B
      WHERE A.COD_OS IN (10022,10029,10020,10233,10530,10539)
      AND TRUNC(A.FH_EJECUCION) >= TRUNC(SYSDATE)
      AND A.NUM_OS =B.NUM_OS
      AND A.NUM_OS IN (SELECT  C.NUM_OS FROM PV_CAMCOM C
                       WHERE   C.COD_CLIENTE = EV_COD_CLIENTE
                                           AND C.NUM_ABONADO= EV_num_abonado
                               AND TRUNC(C.FEC_VENCIMIENTO) >= TRUNC(SYSDATE)
                              )
          AND COD_ESTADO <210;

      If ln_count_pend >0 then

           LV_sSQL := ' DELETE GA_FREC_CICLO WHERE NUM_ABONADO='||EV_num_abonado;
       DELETE GA_FREC_CICLO
       WHERE NUM_ABONADO=EV_num_abonado;


      --Eliminacion de Tablas GA_FINCICLO y GA_INTARCEL
           LV_sSQL := ' DELETE FROM GA_FINCICLO WHERE COD_CLIENTE='||EV_cod_cliente||' AND NUM_ABONADO='||EV_num_abonado||' AND COD_PLANTARIF <> '||EV_cod_plantarif;
           DELETE FROM GA_FINCICLO
           WHERE COD_CLIENTE=EV_cod_cliente
           AND NUM_ABONADO=EV_num_abonado
           AND COD_PLANTARIF <> EV_cod_plantarif;

                BEGIN

                   LV_sSQL := ' SELECT COUNT(1) FROM GA_INTARCEL WHERE COD_CLIENTE='||EV_cod_cliente||' AND NUM_ABONADO='||EV_num_abonado;
                   LV_sSql:=LV_sSql||' AND TRUNC(FEC_DESDE) >= TRUNC(SYSDATE) AND COD_PLANTARIF <> '||EV_cod_plantarif;
                   SELECT  COUNT(1)
                   INTO    V_COUNT
                   FROM    GA_INTARCEL
                   WHERE   COD_CLIENTE = EV_cod_cliente
                   AND     NUM_ABONADO = EV_num_abonado
                   AND     TRUNC(FEC_DESDE) >= TRUNC(SYSDATE)
                   AND     COD_PLANTARIF <> EV_cod_plantarif;


                   IF V_COUNT<> 0 THEN

                   LV_sSQL := ' SELECT  FEC_DESDE, COD_PLANTARIF';
                   LV_sSql:=LV_sSql||' FROM GA_INTARCEL  WHERE   COD_CLIENTE = '||EV_cod_cliente||'';
                   LV_sSql:=LV_sSql||' AND NUM_ABONADO = '||EV_num_abonado||' AND TRUNC(FEC_DESDE) >= TRUNC(SYSDATE)';
                   LV_sSql:=LV_sSql||' AND COD_PLANTARIF <> '||EV_cod_plantarif;

                      SELECT  FEC_DESDE, COD_PLANTARIF
                      INTO    V_FEC_DESDE, V_CODPLANTARIF_NUE
                      FROM    GA_INTARCEL
                      WHERE   COD_CLIENTE = EV_cod_cliente
                      AND     NUM_ABONADO = EV_num_abonado
                      AND     TRUNC(FEC_DESDE) >= TRUNC(SYSDATE)
                      AND     COD_PLANTARIF <> EV_cod_plantarif
                          AND ROWNUM=1;

                      LV_sSQL := 'DELETE GA_INTARCEL WHERE COD_CLIENTE='||EV_cod_cliente||' AND NUM_ABONADO='||EV_num_abonado;
                      LV_sSql:=LV_sSql||' AND TRUNC(FEC_DESDE) >= TRUNC(SYSDATE) AND COD_PLANTARIF <> '||EV_cod_plantarif;

                      DELETE GA_INTARCEL
                      WHERE  COD_CLIENTE = EV_cod_cliente
                      AND     NUM_ABONADO = EV_num_abonado
                      AND    TRUNC(FEC_DESDE) >= TRUNC(SYSDATE)
                      AND    COD_PLANTARIF <> EV_cod_plantarif;


                      BEGIN

                              DELETE GA_INTARCEL
                              WHERE  COD_CLIENTE = EV_cod_cliente
                              AND    NUM_ABONADO = EV_num_abonado
                              AND    TRUNC(FEC_HASTA) = TO_DATE('31-12-3000','DD-MM-YYYY')
                              AND    COD_PLANTARIF = EV_cod_plantarif;

                     EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                                NULL;
                     END;

                          LV_sSQL := ' SELECT COD_TIPLAN';
                          LV_sSql:=LV_sSql||' FROM TA_PLANTARIF WHERE COD_PLANTARIF = '||V_CODPLANTARIF_NUE;

                          SELECT COD_TIPLAN
                          INTO V_CODPLAN_DES
                           FROM TA_PLANTARIF
                            WHERE COD_PLANTARIF = V_CODPLANTARIF_NUE;

                          BEGIN
                            IF  ((V_CODPLAN_DES = CN_POSPAGO) OR (V_CODPLAN_DES = CN_HIBRIDO)) THEN

                                     LV_sSQL := 'DELETE FROM GA_INTARCEL_ACCIONES_TO WHERE COD_CLIENTE='||EV_cod_cliente||' AND NUM_ABONADO='||EV_num_abonado||'AND FEC_DESDE= '||V_FEC_DESDE;
                                     DELETE FROM GA_INTARCEL_ACCIONES_TO
                                     WHERE COD_CLIENTE = EV_cod_cliente
                                     AND NUM_ABONADO   = EV_num_abonado
                                     AND FEC_DESDE= V_FEC_DESDE;

                                         LV_sSQL := ' DELETE GA_LIMITE_CLIABO_TO WHERE COD_CLIENTE = '||EV_cod_cliente;
										 LV_sSQL := LV_sSQL || ' AND NUM_ABONADO = '||EV_num_abonado;
										 LV_sSQL := LV_sSQL || ' AND to_date(FEC_DESDE) = to_date('''||V_FEC_DESDE||''')';

                                     DELETE GA_LIMITE_CLIABO_TO
                                     WHERE COD_CLIENTE= EV_cod_cliente
                                     AND NUM_ABONADO  = EV_num_abonado
                                     AND to_date(FEC_DESDE) = to_date(V_FEC_DESDE);

                                         V_COD_LIMCOSUMO:=0;

									LV_sSQL := 'SELECT MAX(FEC_DESDE) ';
									LV_sSQL := LV_sSQL || ' FROM GA_LIMITE_CLIABO_TO ';
									LV_sSQL := LV_sSQL || ' WHERE COD_CLIENTE = ' || EV_cod_cliente;
									LV_sSQL := LV_sSQL || ' AND NUM_ABONADO  = '|| EV_num_abonado;
									LV_sSQL := LV_sSQL || ' AND COD_PLANTARIF = '|| EV_cod_plantarif;

									SELECT MAX(FEC_DESDE)
									INTO LD_FecDesde
									FROM GA_LIMITE_CLIABO_TO
									WHERE COD_CLIENTE = EV_cod_cliente
									AND NUM_ABONADO  = EV_num_abonado
									AND COD_PLANTARIF = EV_cod_plantarif;


                                         LV_sSQL := 'SELECT COD_LIMCONS FROM GA_LIMITE_CLIABO_TO';
                                         LV_sSql:=LV_sSql||' WHERE COD_CLIENTE= '||EV_cod_cliente||' AND NUM_ABONADO = '||EV_num_abonado;
                                         LV_sSql:=LV_sSql||' AND FEC_HASTA    = (to_date(V_FEC_DESDE, ''DD-MM-YYYY HH24:MI:SS'') - (1/(24*60*60)))';


                                     SELECT COD_LIMCONS
                                     INTO V_COD_LIMCOSUMO
                                     FROM GA_LIMITE_CLIABO_TO
                                     WHERE
                                     COD_CLIENTE      = EV_cod_cliente
                                     AND NUM_ABONADO  = EV_num_abonado
                                     AND COD_PLANTARIF = EV_cod_plantarif
									 AND FEC_DESDE = LD_FecDesde;


                                     UPDATE GA_LIMITE_CLIABO_TO SET
                                     FEC_HASTA = NULL
                                     WHERE
                                     COD_CLIENTE      = EV_cod_cliente
                                     AND NUM_ABONADO  = EV_num_abonado
                                     AND COD_PLANTARIF = EV_cod_plantarif
									 AND FEC_DESDE = LD_FecDesde;

                                     UPDATE GA_ABOCEL
                                     SET COD_LIMCONSUMO = V_COD_LIMCOSUMO
                                     WHERE COD_CLIENTE  = EV_cod_cliente
                                     AND NUM_ABONADO    = EV_num_abonado;
                                END IF;

                          EXCEPTION
                           WHEN NO_DATA_FOUND THEN
                                        NULL;
                          END;

                   --Procedemos a crear una nuevo Registro en GA_INTARCEL Para ello obtenemos
                   --datos del anterior registro de acuerdo a la fecha desde obtenida anteriormente


                      SELECT  count(1)
		              INTO    LN_COUNT_INTARCEL
		              FROM    GA_INTARCEL
		              WHERE   COD_CLIENTE = EV_cod_cliente
		              AND     NUM_ABONADO = EV_num_abonado
		              AND     TRUNC(FEC_HASTA) >= TRUNC(SYSDATE)
		              AND     COD_PLANTARIF = EV_cod_plantarif;


                      LV_sSQL := 'SELECT FEC_DESDE FROM GA_INTARCEL WHERE  COD_CLIENTE = '||EV_cod_cliente;
                          LV_sSql:=LV_sSql||' AND NUM_ABONADO = '||EV_num_abonado||' AND FEC_HASTA  IN (SELECT  MAX(fec_hasta) from GA_INTARCEL';
                          LV_sSql:=LV_sSql||'  where COD_CLIENTE = '||EV_cod_cliente||'  AND NUM_ABONADO = '||EV_num_abonado;
                          LV_sSql:=LV_sSql||' and TRUNC(FEC_HASTA) < TRUNC('||V_FEC_DESDE||')  and COD_PLANTARIF= '||EV_cod_plantarif||')';

             IF LN_COUNT_INTARCEL >=1 THEN
                                 LV_FEC_MAX:=NULL;

                 SELECT  MAX(FEC_HASTA)
                 INTO LV_FEC_MAX
                 FROM GA_INTARCEL
                 WHERE COD_CLIENTE = EV_COD_CLIENTE
                 AND NUM_ABONADO = EV_NUM_ABONADO
                 AND TRUNC(FEC_HASTA) > TRUNC(V_FEC_DESDE)
                 AND COD_PLANTARIF= EV_COD_PLANTARIF;

                                 LV_FEC_MIN:=NULL;

                 SELECT  MIN(FEC_DESDE)
                 INTO LV_FEC_MIN
                 FROM GA_INTARCEL
                 WHERE COD_CLIENTE = EV_COD_CLIENTE
                 AND NUM_ABONADO = EV_NUM_ABONADO
                 AND COD_PLANTARIF= EV_COD_PLANTARIF;

                 IF LV_FEC_MIN <> null and LV_FEC_MAX<> NULL THEN

                    DELETE GA_INTARCEL
                    WHERE  COD_CLIENTE = EV_cod_cliente
                    AND    NUM_ABONADO = EV_num_abonado
                    AND    TRUNC(FEC_HASTA) = TRUNC(lv_fec_max)
                    AND    TRUNC(FEC_HASTA) > TRUNC(lv_fec_min)
                    AND    COD_PLANTARIF = EV_cod_plantarif;

                 END IF;


                 UPDATE GA_INTARCEL
                 SET FEC_HASTA= TO_DATE('31-12-3000','DD-MM-YYYY')
                 WHERE NUM_ABONADO=EV_num_abonado
                 AND COD_CLIENTE=EV_COD_CLIENTE
				 --INI 71894|25-11-2008|EFR.
                 --AND TRUNC(FEC_DESDE)=TRUNC(LV_FEC_MIN);
				 and COD_PLANTARIF = EV_cod_plantarif
				 AND FEC_HASTA = (select MAX(FEC_HASTA)
									from ga_intarcel
									where num_abonado = EV_num_abonado
									and cod_cliente = EV_COD_CLIENTE
									and COD_PLANTARIF = EV_cod_plantarif);
				 --FIN 71894|25-11-2008|EFR.

              ELSE
                                 LV_FEC_MIN:=NULL;

                 SELECT  MIN(FEC_DESDE)
                 INTO LV_FEC_MIN
                 FROM GA_INTARCEL
                 WHERE COD_CLIENTE = EV_COD_CLIENTE
                 AND NUM_ABONADO = EV_NUM_ABONADO
                 AND COD_PLANTARIF= EV_COD_PLANTARIF;


                 UPDATE GA_INTARCEL
                 SET FEC_HASTA = TO_DATE('31-12-3000','DD-MM-YYYY')
                 WHERE NUM_ABONADO=EV_num_abonado
                 AND COD_CLIENTE=EV_COD_CLIENTE
				 --INI 71894|25-11-2008|EFR.
                 --AND TRUNC(FEC_DESDE)=TRUNC(LV_FEC_MIN);
				 and COD_PLANTARIF = EV_cod_plantarif
				 AND FEC_HASTA = (select MAX(FEC_HASTA)
									from ga_intarcel
									where num_abonado = EV_num_abonado
									and cod_cliente = EV_COD_CLIENTE
									and COD_PLANTARIF = EV_cod_plantarif);
				 --FIN 71894|25-11-2008|EFR.

              END IF;



                   END IF;

                  EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                                 RAISE TODO_OK ;

                 END;

                  BEGIN
                          LV_sSQL := 'SELECT  A.NUM_OS,B.COD_PLANTARIF_NUE  FROM PV_IORSERV A,PV_PARAM_ABOCEL B';
                          LV_sSql:=LV_sSql||' WHERE A.COD_OS IN (10020,10022,10029,10233,10530,10539)';
                          LV_sSql:=LV_sSql||' AND TRUNC(A.FH_EJECUCION) >= TRUNC(SYSDATE) AND A.NUM_OS =B.NUM_OS';
                          LV_sSql:=LV_sSql||'  AND A.NUM_OS IN (SELECT  C.NUM_OS FROM PV_CAMCOM C';
                          LV_sSql:=LV_sSql||'  WHERE   C.COD_CLIENTE = '||EV_COD_CLIENTE||' AND';
                          LV_sSql:=LV_sSql||'  C.NUM_ABONADO = '||EV_NUM_ABONADO||' AND';
                          LV_sSql:=LV_sSql||' TRUNC(C.FEC_VENCIMIENTO) >= TRUNC(SYSDATE))';
                          LV_sSql:=LV_sSql||' AND COD_ESTADO <=210';

                          SELECT  A.NUM_OS,B.COD_PLANTARIF_NUE
                      INTO V_NUM_OOSS,V_COD_PLANTARIF_NUE
                      FROM PV_IORSERV A,PV_PARAM_ABOCEL B, PV_ERECORRIDO D
                      WHERE A.COD_OS IN (10020,10022,10029,10233,10530,10539)
                      AND TRUNC(A.FH_EJECUCION) >= TRUNC(SYSDATE)
                      AND A.NUM_OS =B.NUM_OS
                      AND A.NUM_OS IN (SELECT  C.NUM_OS FROM PV_CAMCOM C
                                       WHERE   C.COD_CLIENTE = EV_COD_CLIENTE AND
                                                           C.NUM_ABONADO = EV_NUM_ABONADO AND
                                                                   TRUNC(C.FEC_VENCIMIENTO) >= TRUNC(SYSDATE)
                                                  )
                      AND A.COD_ESTADO <=210
                          AND D.TIP_ESTADO != 4
                          AND A.NUM_OS = D.NUM_OS;

                      UPDATE PV_IORSERV
                      SET NUM_OSF_ERR=1,
                          NUM_OSPADRE=V_NUM_OOSS,
                      NUM_INTENTOS= V_INTENTO_MAX
                      ,STATUS = 'CANCELADA' --COL|71894|17-10-2008|EFR
                      WHERE NUM_OS=V_NUM_OOSS;


                      UPDATE PV_ERECORRIDO
			-- INI COL|71894|17-10-2008|EFR
			-- SET TIP_ESTADO=4
			SET TIP_ESTADO = 5,
			MSG_ERROR = 'CANCELADA'
			-- FIN COL|71894|17-10-2008|EFR
                      WHERE NUM_OS=V_NUM_OOSS;

                  EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                                 RAISE TODO_OK ;
                  END;
        end if;

ELSE --EMPRESA


  OPEN  ABOCEL;
  LOOP
    FETCH ABOCEL INTO V_NUM_ABONADO;
        EXIT WHEN ABOCEL%NOTFOUND;


          ln_count_pend:=0;

          SELECT count(1)
          Into ln_count_pend
      FROM PV_IORSERV A,PV_PARAM_ABOCEL B
      WHERE A.COD_OS IN (10022,10029,10020,10233,10530,10539)
      AND TRUNC(A.FH_EJECUCION) >= TRUNC(SYSDATE)
      AND A.NUM_OS =B.NUM_OS
      AND A.NUM_OS IN (SELECT  C.NUM_OS FROM PV_CAMCOM C
                       WHERE   C.COD_CLIENTE = EV_COD_CLIENTE
                                           AND C.NUM_ABONADO= V_NUM_ABONADO
                               AND TRUNC(C.FEC_VENCIMIENTO) >= TRUNC(SYSDATE)
                              )
          AND COD_ESTADO <210;

      If ln_count_pend >0  or V_NUM_ABONADO =0 then --- RRG  V_NUM_ABONADO = 0

              LV_sSQL := ' DELETE GA_FREC_CICLO WHERE NUM_ABONADO='||V_NUM_ABONADO;
          DELETE GA_FREC_CICLO
          WHERE NUM_ABONADO=V_NUM_ABONADO;

                  DELETE FROM GA_FINCICLO
                  WHERE COD_CLIENTE=EV_COD_CLIENTE
                  AND NUM_ABONADO in (V_NUM_ABONADO,0)
                  AND COD_PLANTARIF<> EV_cod_plantarif;

                  LV_sSql := '-- (Empresa)';
                  LV_sSql:=LV_sSql||' SELECT COUNT(1) FROM GA_INTARCEL WHERE COD_CLIENTE='||EV_cod_cliente||' AND NUM_ABONADO='||V_num_abonado;
                  LV_sSql:=LV_sSql||' AND TRUNC(FEC_DESDE) >= TRUNC(SYSDATE) AND COD_PLANTARIF <> '||EV_cod_plantarif;

                  SELECT  COUNT(1)
                  INTO    V_COUNT
                  FROM    GA_INTARCEL
                  WHERE   COD_CLIENTE = EV_cod_cliente
                  AND     NUM_ABONADO = V_num_abonado
                  AND     TRUNC(FEC_DESDE) >= TRUNC(SYSDATE)
                  AND     COD_PLANTARIF <> EV_cod_plantarif;

                  IF V_COUNT<>0 THEN

              LV_sSql := '-- (Empresa)';
              LV_sSql := LV_sSql||' SELECT FEC_DESDE, COD_PLANTARIF';
                  LV_sSql := LV_sSql||' FROM GA_INTARCEL WHERE COD_CLIENTE = '||EV_cod_cliente;
                  LV_sSql := LV_sSql||' AND NUM_ABONADO='||V_NUM_ABONADO;
                  LV_sSql := LV_sSql||' AND TRUNC(FEC_DESDE) >= TRUNC(SYSDATE) AND COD_PLANTARIF <> '||EV_cod_plantarif||'  AND ROWNUM=1';

			-- INICIO RRG 02-12-2008 COL

              /*SELECT  FEC_DESDE, COD_PLANTARIF
              INTO    V_FEC_DESDE, V_CODPLANTARIF_NUE
              FROM    GA_INTARCEL
              WHERE   COD_CLIENTE = EV_cod_cliente
                  AND     NUM_ABONADO=V_NUM_ABONADO
              AND     TRUNC(FEC_DESDE) >= TRUNC(SYSDATE)
              AND     COD_PLANTARIF <> EV_cod_plantarif
              AND ROWNUM=1;*/

			  -- ESTA CUSTION TA MALA, NO SE USA NUNCA ROWNUM, APRENDAN!!!!

			  SELECT  FEC_DESDE, COD_PLANTARIF
              INTO    V_FEC_DESDE, V_CODPLANTARIF_NUE
			  FROM (
				  SELECT  FEC_DESDE, COD_PLANTARIF
	              FROM    GA_INTARCEL
	              WHERE   COD_CLIENTE = EV_cod_cliente
	                  AND     NUM_ABONADO=V_NUM_ABONADO
	              AND     TRUNC(FEC_DESDE) >= TRUNC(SYSDATE)
	              AND     COD_PLANTARIF <> EV_cod_plantarif
				  ORDER BY FEC_DESDE asc
			  ) WHERE ROWNUM=1;


			  -- FIN RRG 02-12-2008 COL



              DELETE GA_INTARCEL
              WHERE  COD_CLIENTE = EV_cod_cliente
              --AND    NUM_ABONADO in (V_NUM_ABONADO,0)   RRG
			  AND    NUM_ABONADO in (V_NUM_ABONADO)
              AND    TRUNC(FEC_DESDE) >= TRUNC(SYSDATE)
              AND    COD_PLANTARIF <> EV_cod_plantarif;

             BEGIN

			  	   	 dbms_output.put_line('Borra Intarcel registro a futuro 31-12-3000');

                      DELETE GA_INTARCEL
                      WHERE  COD_CLIENTE = EV_cod_cliente
                      ---AND    NUM_ABONADO IN (V_num_abonado,0)  // RRG
					  AND    NUM_ABONADO IN (V_num_abonado)
                      AND    TRUNC(FEC_HASTA) = TO_DATE('31-12-3000','DD-MM-YYYY')
                      AND    COD_PLANTARIF = EV_cod_plantarif;
             EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                                NULL;
             END;


                  LV_sSql := '-- (Empresa)';
              LV_sSql := LV_sSql||' SELECT COD_TIPLAN FROM TA_PLANTARIF WHERE COD_PLANTARIF = '||V_CODPLANTARIF_NUE;

                  SELECT COD_TIPLAN
                  INTO V_CODPLAN_DES
                  FROM TA_PLANTARIF
                  WHERE COD_PLANTARIF = V_CODPLANTARIF_NUE;

                  BEGIN
                           IF  ((V_CODPLAN_DES = CN_POSPAGO) OR (V_CODPLAN_DES = CN_HIBRIDO)) THEN

                                                DELETE FROM GA_INTARCEL_ACCIONES_TO
                                                WHERE COD_CLIENTE = EV_cod_cliente
                                                AND NUM_ABONADO   in (0,V_NUM_ABONADO)
                                                AND FEC_DESDE= V_FEC_DESDE;

												 LV_sSQL := ' DELETE GA_LIMITE_CLIABO_TO WHERE COD_CLIENTE = '||EV_cod_cliente;
										 		 LV_sSQL := LV_sSQL || ' AND NUM_ABONADO = 0';
										 		 LV_sSQL := LV_sSQL || ' AND to_date(FEC_DESDE) = to_date('''||V_FEC_DESDE||''')';

                                                DELETE GA_LIMITE_CLIABO_TO
                                                WHERE COD_CLIENTE= EV_cod_cliente
                                                AND NUM_ABONADO  =0
                                                AND to_date(FEC_DESDE)    =to_date(V_FEC_DESDE);

                                                LV_sSql := '-- (Empresa)';
                                        LV_sSql := LV_sSql||' SELECT COD_LIMCONS FROM GA_LIMITE_CLIABO_TO';
                                                LV_sSql := LV_sSql||' WHERE COD_CLIENTE= '||EV_cod_cliente||' AND NUM_ABONADO = 0';
                                                LV_sSql := LV_sSql||' AND FEC_HASTA = (to_date('||V_FEC_DESDE||', ''DD-MM-YYYY HH24:MI:SS'') - (1/(24*60*60)))';

												LV_sSQL := 'SELECT MAX(FEC_DESDE) ';
												LV_sSQL := LV_sSQL || ' FROM GA_LIMITE_CLIABO_TO ';
												LV_sSQL := LV_sSQL || ' WHERE COD_CLIENTE = ' || EV_cod_cliente;
												LV_sSQL := LV_sSQL || ' AND NUM_ABONADO  = '|| 0;
												LV_sSQL := LV_sSQL || ' AND COD_PLANTARIF = '|| EV_cod_plantarif;

												SELECT MAX(FEC_DESDE)
												INTO LD_FecDesde
												FROM GA_LIMITE_CLIABO_TO
												WHERE COD_CLIENTE = EV_cod_cliente
												AND NUM_ABONADO  = 0
												AND COD_PLANTARIF = EV_cod_plantarif;


                                                SELECT COD_LIMCONS
                                                INTO V_COD_LIMCOSUMO
                                                FROM GA_LIMITE_CLIABO_TO
                                                WHERE
                                                COD_CLIENTE      = EV_cod_cliente
                                                AND NUM_ABONADO  = 0
                                                AND COD_PLANTARIF = EV_cod_plantarif
												AND FEC_DESDE = LD_FecDesde;

                                                UPDATE GA_LIMITE_CLIABO_TO SET
                                                FEC_HASTA = NULL
                                                WHERE
                                                COD_CLIENTE      = EV_cod_cliente
                                                AND NUM_ABONADO  = 0
                                                AND COD_PLANTARIF = EV_cod_plantarif
												AND FEC_DESDE = LD_FecDesde;

                                                UPDATE GA_ABOCEL
                                                SET     COD_LIMCONSUMO = V_COD_LIMCOSUMO
                                                WHERE COD_CLIENTE  = EV_cod_cliente
                                                AND NUM_ABONADO    in (0,V_NUM_ABONADO);

                          END IF;

                 EXCEPTION
           WHEN NO_DATA_FOUND THEN
                    NULL;
             END;

                 V_FEC_DESDE2:=TO_CHAR(V_FEC_DESDE,'DD-MM-YYYY');

             OPEN  INTARCEL;
             LOOP
                        FETCH INTARCEL INTO V_FEC_DESDE,V_NUM_ABONADO;
                        EXIT WHEN INTARCEL%NOTFOUND;

                UPDATE GA_INTARCEL
                SET FEC_HASTA = TO_DATE('31-12-3000','DD-MM-YYYY')
                WHERE COD_CLIENTE=EV_cod_cliente
                        --AND NUM_ABONADO IN(V_NUM_ABONADO,0) // RRG
						AND NUM_ABONADO IN(V_NUM_ABONADO)
                        AND FEC_DESDE=V_FEC_DESDE;
             END LOOP;
             CLOSE INTARCEL;
      END IF;



           /*UPDATE GA_INTARCEL
           SET FEC_HASTA = TO_DATE('31-12-3000','DD-MM-YYYY')
           WHERE COD_CLIENTE=EV_cod_cliente
           AND NUM_ABONADO =0;*/

      --Se realiza regularizacion de tablas PV_CAMCOM y PV_ERECORRIDO

          OPEN  OOSS_BATCH;
                 LOOP
                    FETCH OOSS_BATCH INTO V_NUM_OOSS;
                    EXIT WHEN OOSS_BATCH%NOTFOUND;

                    UPDATE PV_IORSERV
            SET NUM_OSF_ERR=1,
                        NUM_OSPADRE=V_NUM_OOSS,
                    NUM_INTENTOS= V_INTENTO_MAX
                    ,STATUS = 'CANCELADA' --COL|71894|17-10-2008|EFR
            WHERE NUM_OS=V_NUM_OOSS;

            UPDATE PV_ERECORRIDO
		-- INI COL|71894|17-10-2008|EFR
		-- SET TIP_ESTADO=4
		SET TIP_ESTADO = 5,
		MSG_ERROR = 'CANCELADA'
		-- FIN COL|71894|17-10-2008|EFR
            WHERE NUM_OS=V_NUM_OOSS;

      END LOOP;
      CLOSE OOSS_BATCH;
                        end if;
          END LOOP;
          CLOSE ABOCEL;
   -- INI COL|71894|15-12-2008|SAQL
   delete ga_intarcel
   where cod_cliente = EV_cod_cliente
   and num_abonado = 0
   and fec_desde >= sysdate;

   update ga_intarcel set
   fec_hasta = to_date('31-12-3000','dd-mm-yyyy')
   where cod_cliente = EV_cod_cliente
   and num_abonado = 0
   and sysdate between fec_desde and fec_hasta;
   -- FIN COL|71894|15-12-2008|SAQL
END IF;

RAISE TODO_OK ;

EXCEPTION
          WHEN TODO_OK THEN
               NULL;
          WHEN ERROR_INTARCEL THEN
              SN_cod_retorno := 1;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' NO EXISTEN DATOS GA_INTARCEL (''); '||SQLERRM;
              SV_glosa_retorno:=' NO EXISTEN DATOS GA_INTARCEL (''); '||SQLERRM;
                  SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ANULA_CAMPLAN_A_CICLO_PG', LV_sSQL, SN_cod_retorno, LV_des_error );
                  SV_cod_retorno:=4;
          WHEN OTHERS THEN -- RRG COL 77303 05-02-2009 SE DESCOMENTA POR QUE SE NECESITA
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_ANULA_CAMPLAN_A_CICLO_PG (''); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_ANULA_CAMPLAN_A_CICLO_PG', LV_sSQL, SN_cod_retorno, LV_des_error );
          SV_cod_retorno :=4;
END PV_ANULA_CAMPLAN_A_CICLO_PR;




END PV_ANULA_CAMPLAN_A_CICLO_PG;
/
SHOW ERRORS
