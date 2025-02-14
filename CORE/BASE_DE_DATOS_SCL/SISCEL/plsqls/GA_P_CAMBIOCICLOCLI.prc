CREATE OR REPLACE procedure GA_P_CAMBIOCICLOCLI
(VP_CLIENTE IN NUMBER,
                              VP_CICLONUE IN NUMBER,
                              VP_CICLOANT IN NUMBER,
                              VP_FECSYS IN DATE,
                              VP_PROC IN OUT VARCHAR2,
                              VP_TABLA IN OUT VARCHAR2,
                              VP_ACT IN OUT VARCHAR2,
                              VP_SQLCODE IN OUT VARCHAR2,
                              VP_SQLERRM IN OUT VARCHAR2,
                              VP_ERROR IN OUT VARCHAR2)
IS
 V_ABONADO GA_ABOCEL.NUM_ABONADO%TYPE;
 V_PRODUCTO GE_PRODUCTOS.COD_PRODUCTO%TYPE;
 V_CICLFACT FA_CICLFACT.COD_CICLFACT%TYPE;
 V_FECHADLL GA_INTARCEL.FEC_DESDE%TYPE;
 V_ROWID ROWID;
 V_INDFACT GA_ABOCEL.IND_FACTUR%TYPE;
 V_CICLONUE GA_ABOCEL.COD_CICLO%TYPE;
 V_CICLOANT        GA_ABOCEL.COD_CICLO%TYPE;
 V_NUM_MOVIMIENTO  ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;

 V_plantarif    ga_abocel.COD_PLANTARIF%type;
 V_cod_servicio gad_servsup_plan.COD_SERVICIO%type;
 V_cod_serv     ga_servsupl.COD_SERVICIO%type;
 V_cod_ser      ga_servsuplabo.COD_SERVICIO%type;
 V_USUARIO      ICC_MOVIMIENTO.NOM_USUARORA%TYPE;

 LV_actabonado ICC_MOVIMIENTO.COD_ACTABO%TYPE;

 VP_ROWNUM NUMBER;
 IND_VALOR NUMBER := 0;
 IND_GESTOR NUMBER := 0;

 CV_MODULO   CONSTANT ged_parametros.COD_MODULO%TYPE := 'GA';
 CV_NOMPARAM CONSTANT ged_parametros.NOM_PARAMETRO%TYPE := 'INSMOVIMCC';
 LV_VALPARAM ged_parametros.VAL_PARAMETRO%TYPE;


 CURSOR ABOCEL IS
        SELECT NUM_ABONADO, COD_CICLO
        FROM GA_INTARCEL
        WHERE COD_CLIENTE = VP_CLIENTE
              AND IND_NUMERO = IND_VALOR
              AND VP_FECSYS BETWEEN FEC_DESDE AND FEC_HASTA
        AND NUM_ABONADO IN (SELECT NUM_ABONADO FROM GA_ABOCEL);
 CURSOR ABOBEEP IS
        SELECT NUM_ABONADO, COD_CICLO
        FROM GA_INTARBEEP
        WHERE COD_CLIENTE = VP_CLIENTE
              AND VP_FECSYS BETWEEN FEC_DESDE AND FEC_HASTA;
 ERROR_PROCESO EXCEPTION;
BEGIN
 VP_PROC := 'GA_P_CAMBIOCICLOCLI';
 V_CICLONUE := VP_CICLONUE;
 V_CICLOANT := VP_CICLOANT;

 UPDATE GE_CLIENTES
 SET COD_CICLONUE = V_CICLONUE
 WHERE COD_CLIENTE = VP_CLIENTE;

 VP_TABLA := 'GA_ABOCEL';
 V_PRODUCTO := 1;

 PV_PR_DEVVALPARAM (CV_MODULO,V_PRODUCTO,CV_NOMPARAM,LV_VALPARAM);

 OPEN ABOCEL;
 LOOP
     FETCH ABOCEL INTO V_ABONADO, V_CICLOANT;
     EXIT WHEN ABOCEL%NOTFOUND;
     P_CAMBIO_CICLO(V_PRODUCTO, VP_CLIENTE, V_ABONADO, V_CICLONUE,
                    V_CICLOANT, VP_FECSYS, VP_PROC, VP_TABLA, VP_ACT,
                    VP_SQLCODE,VP_SQLERRM, VP_ERROR);
     IF VP_ERROR = '4' THEN
        RAISE ERROR_PROCESO;
     END IF;

     IF IND_GESTOR =0   then

                         BEGIN
                                 V_cod_ser := '';
                                 select a.cod_servicio into V_cod_ser from ga_servsuplabo a
                                 Where  num_abonado   = V_ABONADO and
                                        ind_estado < 3 and
                                                cod_servicio in (select cod_servicio
                                                                                 from ga_servsupl
                                                                                 where cod_producto = 1 and
                                                                                 ind_gestor         = 1 and
                                                                             cod_servicio      =a.cod_servicio)
                                                and rownum=1;
                      EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                     VP_ERROR := '0';
                                 WHEN OTHERS THEN
                                     VP_ERROR := '4';
                                     RAISE ERROR_PROCESO;
                         END;

                         SELECT USER INTO V_USUARIO  FROM DUAL;

                         IF RTRIM(LTRIM(V_cod_ser)) IS NOT NULL  then

                                        V_NUM_MOVIMIENTO:=0;
                                                 PV_PRC_INS_MOVIMIENTO_PR(0,V_ABONADO,'GC',V_USUARIO,0,'',NULL,V_NUM_MOVIMIENTO,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
                                         IF VP_ERROR = '4' THEN
                                                RAISE ERROR_PROCESO;
                                         END IF;

                                         IND_GESTOR:=1;
                         END IF;
     END IF;

	 IF  LV_VALPARAM = 'TRUE' THEN	 --Valida si Flag esta en Verdadero.

		 LV_actabonado :='HC';

	     PV_PRC_INS_ICCMOVIMIENTO_PR(V_ABONADO,LV_actabonado,V_USUARIO,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
	     IF VP_ERROR = '4' THEN
	            RAISE ERROR_PROCESO;
	     END IF;

	 END IF;

 END LOOP;
 CLOSE ABOCEL;

 VP_TABLA := 'GE_CLIENTES';
 VP_PROC := 'GA_PCAMBIOCICLOCLI';
 VP_ACT := 'S';
 BEGIN
    SELECT IND_FACTUR INTO V_INDFACT FROM GE_CLIENTES
    WHERE COD_CLIENTE = VP_CLIENTE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
             VP_ERROR := '4';
             RAISE ERROR_PROCESO;
        WHEN OTHERS THEN
             VP_ERROR := '4';
             RAISE ERROR_PROCESO;
 END;
 IF V_INDFACT = 1 THEN
    P_ACTUALIZA_CAM_CICLOCLI (VP_CLIENTE,V_CICLONUE,VP_PROC,VP_TABLA,
                              VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
    IF VP_ERROR <> '0' THEN
       VP_ERROR := '4';
       RAISE ERROR_PROCESO;
    END IF;
    VP_PROC := 'GA_P_CAMBIOCICLOCLI';
 ELSE
     P_ACTUALIZA_CAM_CICLOCLI (VP_CLIENTE,V_CICLONUE,VP_PROC,VP_TABLA,
                               VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
     IF VP_ERROR <> '0' THEN
        VP_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     P_ACTUALIZA_CAM_NOCICLOCLI (VP_CLIENTE,V_CICLONUE,VP_PROC,VP_TABLA,
                                 VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
     IF VP_ERROR <> '0' THEN
        VP_ERROR := '4';
        RAISE ERROR_PROCESO;
     END IF;
     VP_PROC := 'GA_P_CAMBIOCICLOCLI';
 END IF;
  VP_TABLA := 'GA_ABOBEEP';
 V_PRODUCTO := 2;
 OPEN ABOBEEP;
 LOOP
     FETCH ABOBEEP INTO V_ABONADO, V_CICLOANT;
     EXIT WHEN ABOBEEP%NOTFOUND;
     P_CAMBIO_CICLO(V_PRODUCTO, VP_CLIENTE, V_ABONADO, V_CICLONUE,
                    V_CICLOANT, VP_FECSYS, VP_PROC, VP_TABLA, VP_ACT,
                    VP_SQLCODE,VP_SQLERRM, VP_ERROR);
     IF VP_ERROR = '4' THEN
        RAISE ERROR_PROCESO;
     END IF;
 END LOOP;
 CLOSE ABOBEEP;
 VP_TABLA := 'GE_CLIENTES';
 VP_PROC := 'GA_P_CAMBIOCICLOCLI';
 VP_ACT := 'S';
 BEGIN
    SELECT IND_FACTUR INTO V_INDFACT FROM GE_CLIENTES
    WHERE COD_CLIENTE = VP_CLIENTE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
             VP_ERROR := '4';
             RAISE ERROR_PROCESO;
        WHEN OTHERS THEN
             VP_ERROR := '4';
             RAISE ERROR_PROCESO;
 END;
 IF V_INDFACT = 1 THEN
    P_ACTUALIZA_CAM_CICLOCLI (VP_CLIENTE,V_CICLONUE,VP_PROC,VP_TABLA,
                              VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
    IF VP_ERROR <> '0' THEN
       VP_ERROR := '4';
       RAISE ERROR_PROCESO;
    END IF;
    VP_PROC := 'GA_P_CAMBIOCICLOCLI';
 ELSE
    P_ACTUALIZA_CAM_CICLOCLI (VP_CLIENTE,V_CICLONUE,VP_PROC,VP_TABLA,
                              VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
    IF VP_ERROR <> '0' THEN
       VP_ERROR := '4';
       RAISE ERROR_PROCESO;
    END IF;
    P_ACTUALIZA_CAM_NOCICLOCLI (VP_CLIENTE,V_CICLONUE,VP_PROC,VP_TABLA,
                            VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
    IF VP_ERROR <> '0' THEN
       VP_ERROR := '4';
       RAISE ERROR_PROCESO;
    END IF;
    VP_PROC := 'GA_P_CAMBIOCICLOCLI';
 END IF;
EXCEPTION
    WHEN ERROR_PROCESO THEN
         VP_SQLCODE := SQLCODE;
         VP_SQLERRM := SQLERRM;
         VP_ERROR := '4';
    WHEN OTHERS THEN
         VP_SQLCODE := SQLCODE;
         VP_SQLERRM := SQLERRM;
         VP_ERROR := '4';
END;
/
SHOW ERRORS
