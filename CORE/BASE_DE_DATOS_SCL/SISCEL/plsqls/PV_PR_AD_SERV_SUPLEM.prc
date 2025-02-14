CREATE OR REPLACE PROCEDURE Pv_Pr_Ad_Serv_Suplem
(
  s_num_os    IN                        VARCHAR2,
  --INI COL-40406|11-05-2007|PCR
  --s_cs_act  in  varchar2,
  --s_cs_des  in  varchar2,
  s_cs_act    IN OUT       VARCHAR2,
  s_cs_des    IN OUT       VARCHAR2,
  --FIN COL-40406|11-05-2007|PCR
  s_abonado   IN                   VARCHAR2,
  s_error        OUT       VARCHAR2
)
 IS

--PV_PR_AD_SERV_SUPLEM v1.0 //COL INI COL-40406|11-05-2007|PCR
--PV_PR_AD_SERV_SUPLEM v1.1 //40406-COL|22-06-2007|EFR
--PV_PR_AD_SERV_SUPLEM v1.2 //74072 col/07-12-2008/EFR
--PV_PR_AD_SERV_SUPLEM v1.3 //INI COL-74205|09-12-2008|RRG
--PV_PR_AD_SERV_SUPLEM v1.4 //INI COL 74211|10-12-2008|SAQL
--PV_PR_AD_SERV_SUPLEM v1.5 //COL-74450|13-12-2008|GEZ
--PV_PR_AD_SERV_SUPLEM v1.6 //COL 74755|18-12-2008|SAQL
--PV_PR_AD_SERV_SUPLEM v1.7 //COL 76303|19-01-2009|SAQL
--PV_PR_AD_SERV_SUPLEM v1.8 //COL 77523/02-02-2009/RRG


/******************************************************************************
   NAME          :     p_ad_serv_suplem
   AREA          :     POSTVENTA
   EMPRESA       :     TELEFONICA MOVIL SOLUTION S.A.
   Actualizado   :     20-11-2002
        Por      :     Area Desarrollo Post-Venta
******************************************************************************/

        error_parametros        EXCEPTION;
        error_consulta          EXCEPTION;

        cod_1                   VARCHAR2(3);--1 = Dias Especiales
        cod_2                   VARCHAR2(3);--2 = C+digo FriendFamily
        cod_3                   NUMBER(2);--3 = N·mero mîximo de d?as especiales por abonado
        cod_4                   NUMBER(2);--4 = N·mero mîximo de n·meros especiles por abonado
        cod_5                   VARCHAR2(2);--5=  C+digo de tipo de d?a para d?as especiales celular
        cod_6                   VARCHAR2(3);--6=  C+digo de servicio de cargo de conexi+n celular
        cod_7                   VARCHAR2(3);--7=  C+digo de servicio detalle llamadas celular

    /********************* variables para manejar servicios a activar y desactivar*********************/

        i_a                     INTEGER; --indice para servicios a activar
        i_d                     INTEGER; --indice para servicios a desactivar
        i_p                     INTEGER; --indice para servicios procesados

        l_a                     INTEGER; --largo servicios a activar
        l_d                     INTEGER; --largo servicios a desactivar
        l_p                     INTEGER; --largo servicios procesardos

        s_cod_servicio_a        VARCHAR2(2); -- servicio en activar
        s_cod_nivel_a           VARCHAR2(4); -- nivel del servicio a activar
        s_cod_servicio_d        VARCHAR2(2); -- servicio a desactivar
        s_cod_nivel_d           VARCHAR2(4); -- nivel del servicio a desactivar
        s_cs_act_procesados     VARCHAR2(255); -- Servicios a activar ya procesados
        s_cs_act_pservicio      VARCHAR2(2); -- servicio ya procesado
        s_cs_act_pnivel         VARCHAR2(4); -- nivel del servicio ya procesado
        n_find                  INTEGER; -- servicio encontrado 1 = true 0 = false
        s_servicios_a           VARCHAR2(255); --  servicios que activo  en enroque
        s_servicios_d           VARCHAR2(255); --  servicios que desactivo
        s_servicios_sa          VARCHAR2(255); -- servicios que solo activo

        /********************* variables para desarrollar consultas dinîmicas *****************************/

        ssql                    VARCHAR2(1400); -- contiene consulta dinîmica
        cur_din                 INTEGER; -- Var asociada a un cursor dinîmico
        rows_return             INTEGER; -- filas retornadas por ejecutar consulta en cursor dinîmico

    /******************** variables para contener datos anexos a un codigo de servicio ****************/

        concepto_fa             NUMBER(4); -- si es distinta de null el servicio a activar tiene asociado un concepto de facturaci+n
        cod_servicio_siscel     ga_servsuplabo.COD_SERVSUPL%TYPE; -- valor del servicio visto por SISCEL varchar2(4)
        celular                 ga_abocel.NUM_CELULAR%TYPE; -- celular de un abonado} number(8)
        cod_central1            ga_abocel.COD_CENTRAL%TYPE;
        NumSerieHex1            ga_abocel.NUM_SERIEHEX%TYPE;
        TipTerminal1            ga_abocel.TIP_TERMINAL%TYPE;
        nummin1                 ga_abocel.NUM_MIN%TYPE;
        CodCliente1             ga_abocel.COD_CLIENTE%TYPE;
        v_numdiasnum            ga_servsuplabo.NUM_DIASNUM%TYPE;
        CodPlanCom1             ga_cliente_pcom.COD_PLANCOM%TYPE;
        Cadena_actual           ga_abocel.clase_servicio%TYPE;
        scod_servicio           ga_servsupl.COD_SERVICIO%TYPE;
        s_usuario               pv_iorserv.USUARIO%TYPE;
        n_ciclo                 ga_abocel.cod_ciclo%TYPE;
        s_cod_ciclo             fa_ciclfact.COD_CICLFACT%TYPE;
        Cadena_resp             ga_abocel.clase_servicio%TYPE;

   /******************** variables 35941*/
       LV_OOSSCambPlan                  VARCHAR2(50); -- Valores del Val parametro
       LV_CodOS                         pv_iorserv.cod_os%TYPE; --codigo de la ooss
       LV_fECHA                         VARCHAR2(25); --fecha de Baja

   /******************** variables de apoyo *********************************************************/
       c                        VARCHAR2(1);
       ncod_sistema                     icg_serviciotercen.COD_SISTEMA%TYPE;
       isoportable                      INTEGER;
       scode_error                      ga_errores.COD_SQLCODE%TYPE;
       sdes_error                       VARCHAR2(255);
       TABLA                            VARCHAR2(100);
       n_es_detalle             GA_SERVSUPL.COD_SERVICIO%TYPE;
       n_es_fyf                 GA_SERVSUPL.COD_SERVICIO%TYPE;
       fyf_param                GED_PARAMETROS.VAL_PARAMETRO%TYPE;

-- PGG Nueva Variable para obtener el codigo de Tecnologia
       V_TECNOLOGIA                     GA_ABOCEL.COD_TECNOLOGIA%TYPE;

       V_FECSYS                                 DATE; --MODIFICACION - GBM/SOPORTE - 10-11-2005 - XO-200510250955
       NROMODABO                                NUMBER; --MODIFICACION - GBM/SOPORTE - 10-11-2005 - XO-200510250955
       LV_IND_IP           GA_SERVSUPL.IND_IP%TYPE;
       SN_cod_retorno      ge_errores_pg.CodError;
       SV_mens_retorno     ge_errores_pg.MsgError;
       SN_num_evento       ge_errores_pg.Evento;
       LV_COD_SERVICIO_D   GA_SERVSUPL.COD_SERVICIO%TYPE;

        /******************** Variables para actualizar PV_MOVMIENTOS ************************************/
       cant_mov                INTEGER;

        /******************** CURSORES *******************************************************************/

       CURSOR DIAS_ESPECIALES IS
       SELECT GA_SEQ_NUMDIASNUM .NEXTVAL FROM DUAL;

       CURSOR DAT_DIAS_ESPECIALES IS
       SELECT *
       FROM GA_DIASABO
       WHERE NUM_ABONADO = TO_NUMBER(s_abonado);

       --INI COL-40406|11-05-2007|PCR
       LVCadenaSSAct           pv_camcom.clase_servicio_act%TYPE;
       LVCadenaSSActAtras          pv_camcom.clase_servicio_act%TYPE;

       LVCadenaSSDes           pv_camcom.clase_servicio_des%TYPE;
       LVCadenaSSDesAtras      pv_camcom.clase_servicio_des%TYPE;

       LVCadenaSSSer           VARCHAR2(6);
       --FIN COL-40406|11-05-2007|PCR

       V_COUNT                     NUMBER; --MOD 40406-COL|15-06-2007|EFR (PCR)

        --INI 40406-COL|22-06-2007|EFR
        LNExiSS                NUMBER;
        LVSSOtroGrup           VARCHAR2(6);
        LV_Tabla               ga_errores.nom_tabla%TYPE;
        LV_Accion              ga_errores.cod_act%TYPE;
        --FIN 40406-COL|22-06-2007|EFR
        LV_COUNT_AUX           NUMBER;

        LN_Pos         NUMBER;  --COL-74450|13-12-2008|-gez
        vFormatoSel2          GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        vFormatoSel7          GED_PARAMETROS.VAL_PARAMETRO%TYPE;

BEGIN
   -- Inicializar variables
   c  := CHR(39);
   i_a:= 0;
   i_d:= 0;
   s_servicios_a:= '';
   s_servicios_d:= '';
   s_servicios_sa:= '';
   
   
    vFormatoSel2            := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL2');
    vFormatoSel7            := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL7');
 

   IF (s_cs_act = NULL OR s_cs_des = NULL OR s_abonado = NULL)  THEN
      RAISE error_parametros;
   END IF;

   IF (s_cs_act = '*' AND s_cs_des = '*') THEN
      RAISE error_consulta;
   END IF;

   --INI COL-40406|11-05-2007|PCR   Validacion de Servicios repetidos en la cadena

   --1) validar la cadena de SS a activar
   LVCadenaSSAct:=s_cs_act;

   IF LVCadenaSSAct <> '*' THEN
       LOOP

                  IF LVCadenaSSAct IS NULL THEN
                          EXIT;
                  END IF;

                  LVCadenaSSSer:=SUBSTR(LVCadenaSSAct,1,6);

                  LVCadenaSSAct:=SUBSTR(LVCadenaSSAct,7);

                  --INI 40406-COL|22-06-2007|EFR
                  LV_Tabla      :='GA_SERSUPLABO-A1('||LVCadenaSSSer||')';
                  LV_Accion:='S';

                  SELECT COUNT(1)
                  INTO   LNExiSS
                  FROM   ga_servsuplabo
                  WHERE  num_abonado=s_abonado
                  AND    LPAD(cod_servsupl,2,'0')||LPAD(cod_nivel,4,'0')=LVCadenaSSSer
                  AND    ind_estado <3;

                  IF LNExiSS>0 THEN

                         --INI COL-74450|13-12-2008|GEZ
                          --s_cs_act:=REPLACE(s_cs_act,LVCadenaSSSer,NULL);
                          LN_Pos:=1;

                          LOOP
                                      IF LVCadenaSSSer IS NULL OR s_cs_act IS NULL THEN
                                                   EXIT;
                                      END IF;

                                      LN_Pos:=InStr(s_cs_act,LVCadenaSSSer,LN_Pos);

                                      IF LN_Pos=0 THEN
                                                    EXIT;
                                      END IF;

                                      IF MOD(LN_Pos,6)=1 THEN
                                                   s_cs_act:=SUBSTR(s_cs_act,1,LN_Pos-1)|| SUBSTR(s_cs_act,LN_Pos+6);
                                                LN_Pos:=1;
                                      ELSE
                                                  LN_Pos:=LN_Pos+1;
                                      END IF;

                            END LOOP;
                          --FIN COL-74450|13-12-2008|GEZ

                         -- INICIO 65278 07-05-2008 COL RRG
                         IF s_cs_act IS NULL OR s_cs_act = '' THEN
                                s_cs_act := '*';
                         END IF;
                         -- FIN 65278 07-05-2008 COL RRG

                  ELSE
                          BEGIN
                                  LV_Tabla      :='GA_SERSUPLABO-A2('||LVCadenaSSSer||')';
                                  LV_Accion:='S';

                                  SELECT LPAD(cod_servsupl,2,'0')||LPAD(cod_nivel,4,'0')
                                  INTO   LVSSOtroGrup
                                  FROM   ga_servsuplabo
                                  WHERE  num_abonado=s_abonado
                                  AND    LPAD(cod_servsupl,2,'0')||LPAD(cod_nivel,4,'0')<>LVCadenaSSSer
                                  AND    cod_servsupl=TO_NUMBER(SUBSTR(LVCadenaSSSer,1,2))
                                  AND    ind_estado <3;

                                  IF INSTR(s_cs_des,LVSSOtroGrup)=0 THEN
                                                                                 --Inicio INC|40406|COL|27-03-2008|MMC
--                                       s_cs_des:=s_cs_des||LVSSOtroGrup;
                                                                                 --Fin INC|40406|COL|27-03-2008|MMC
                                         s_cs_des:= REPLACE(s_cs_des,'*','') || LVSSOtroGrup;
                                  END IF;
                          EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                         NULL;
                          END;
                  --FIN 40406-COL|22-06-2007|EFR

                          --INI COL-74450|13-12-2008|GEZ
                          --LVCadenaSSAct:=REPLACE(LVCadenaSSAct,LVCadenaSSSer,NULL);
                          LN_Pos:=1;

                          LOOP
                                      IF LVCadenaSSSer IS NULL OR LVCadenaSSAct IS NULL THEN
                                                   EXIT;
                                      END IF;

                                      LN_Pos:=InStr(LVCadenaSSAct,LVCadenaSSSer,LN_Pos);

                                      IF LN_Pos=0 THEN
                                                    EXIT;
                                      END IF;

                                      IF MOD(LN_Pos,6)=1 THEN
                                                   LVCadenaSSAct:=SUBSTR(LVCadenaSSAct,1,LN_Pos-1)|| SUBSTR(LVCadenaSSAct,LN_Pos+6);
                                                LN_Pos:=1;
                                      ELSE
                                                  LN_Pos:=LN_Pos+1;
                                      END IF;

                            END LOOP;
                          --FIN COL-74450|13-12-2008|GEZ

                          LVCadenaSSActAtras:=SUBSTR(s_cs_act,1,INSTR(s_cs_act,LVCadenaSSSer)-1);

                          s_cs_act:=LVCadenaSSActAtras||LVCadenaSSSer||LVCadenaSSAct;

                  END IF; --ECU 40406-COL|22-06-2007|EFR

          END LOOP;
   END IF;

   --2) validar la cadena de SS a desactivar
   LVCadenaSSDes:=s_cs_des;

   IF LVCadenaSSDes <> '*' THEN
       LOOP

                  IF LVCadenaSSDes IS NULL THEN
                          EXIT;
                  END IF;

                  LVCadenaSSSer:=SUBSTR(LVCadenaSSDes,1,6);

                  LVCadenaSSDes:=SUBSTR(LVCadenaSSDes,7);

                  --INI 40406-COL|22-06-2007|EFR

                  LV_Tabla      :='GA_SERSUPLABO-D('||LVCadenaSSSer||')';
                  LV_Accion:='S';

                  SELECT COUNT(1)
                  INTO   LNExiSS
                  FROM   ga_servsuplabo a
                  WHERE  num_abonado=s_abonado
                  AND    LPAD(cod_servsupl,2,'0')||LPAD(cod_nivel,4,'0')=LVCadenaSSSer
                  -- AND    ind_estado IN (3,4) -- COL 76303|19-01-2008|SAQL
                  AND    ind_estado > 2         -- COL 76303|19-01-2008|SAQL
                  AND    NOT EXISTS (SELECT 9 FROM ga_servsuplabo
                                     WHERE num_abonado=a.num_abonado
                                     AND cod_servicio=a.cod_servicio
                                     AND ind_estado<3);

                  IF LNExiSS=0 THEN
                  --FIN 40406-COL|22-06-2007|EFR

                     --INI COL-74450|13-12-2008|GEZ
                     --LVCadenaSSDes:=REPLACE(LVCadenaSSDes,LVCadenaSSSer,NULL);
                     LN_Pos:=1;
                     LOOP
                        IF LVCadenaSSSer IS NULL OR LVCadenaSSDes IS NULL THEN
                           EXIT;
                        END IF;

                        LN_Pos:=InStr(LVCadenaSSDes,LVCadenaSSSer,LN_Pos);

                        IF LN_Pos=0 THEN
                           EXIT;
                        END IF;

                        IF MOD(LN_Pos,6)=1 THEN
                           LVCadenaSSDes:=SUBSTR(LVCadenaSSDes,1,LN_Pos-1)|| SUBSTR(LVCadenaSSDes,LN_Pos+6);
                           LN_Pos:=1;
                        ELSE
                           LN_Pos:=LN_Pos+1;
                        END IF;
                     END LOOP;
                     --FIN COL-74450|13-12-2008|GEZ

                     LVCadenaSSDesAtras:=SUBSTR(s_cs_des,1,INSTR(s_cs_des,LVCadenaSSSer)-1);
                     s_cs_des:=LVCadenaSSDesAtras||LVCadenaSSSer||LVCadenaSSDes;
                  --INI 40406-COL|22-06-2007|EFR
                  ELSE
                     s_cs_des:=REPLACE(s_cs_des,LVCadenaSSSer,NULL);
                  END IF;
                  --FIN 40406-COL|22-06-2007|EFR

          END LOOP;
   END IF;

   --FIN COL-40406|11-05-2007|PCR

   -- INI COL|76303|19-01-2009|SAQL
-- IF LENGTH(s_cs_act) = 0   THEN                          COL 77523/02-02-2009/RRG
   IF LENGTH(s_cs_act) = 0 or s_cs_act is null  THEN --    COL 77523/02-02-2009/RRG
      s_cs_act := '*';
   END IF;
--   IF LENGTH(s_cs_des) = 0 THEN                               COL 77523/02-02-2009/RRG
   IF LENGTH(s_cs_des) = 0 or s_cs_des is null  THEN --    COL 77523/02-02-2009/RRG
      s_cs_des := '*';
   END IF;
   -- FIN COL|76303|19-01-2009|SAQL

   -- Rescatar c+digos para servicios especiales
   LV_Tabla   :='GA_DATOSGENER'; --COL-71988|18-10-2008|GEZ
   LV_Accion  :='S';                     --COL-71988|18-10-2008|GEZ

   SELECT COD_DIASESPCEL, COD_FYFCEL, NUM_DIASESP, NUM_TELESP, COD_TIPDIACEL, COD_SERCONEXCEL, COD_DETCEL
   INTO   cod_1,          cod_2,      cod_3,       cod_4,      cod_5,         cod_6,           cod_7
   FROM   GA_DATOSGENER;

  -------------------------
  -- Rescata codigos de la ooss con num_os 06/11/2006 W.A 35941

   LV_Tabla   :='PV_IORSERV'; --COL-71988|18-10-2008|GEZ
   LV_Accion  :='S';              --COL-71988|18-10-2008|GEZ

   --SELECT a.cod_os                      --COL-71988|18-10-2008|GEZ
   --INTO   LV_CodOS                      --COL-71988|18-10-2008|GEZ
   SELECT a.cod_os,usuario                        --COL-71988|18-10-2008|GEZ
   INTO   LV_CodOS,s_usuario                      --COL-71988|18-10-2008|GEZ
   FROM   pv_iorserv a
   WHERE  a.num_os = TO_NUMBER(s_num_os);

   LV_Tabla   :='PV_IORSERV'; --COL-71988|18-10-2008|GEZ
   LV_Accion  :='S';              --COL-71988|18-10-2008|GEZ

   -- Rescata codigos val parametro OOSS 06/11/2006 W.A 35941
   SELECT a.val_parametro
   INTO   LV_OOSSCambPlan
   FROM   GED_PARAMETROS a
   WHERE  a.nom_parametro  IN('OOSS_CAMB_PLAN_BATCH')
   AND    a.COD_PRODUCTO = 1
   AND    a.COD_MODULO   = 'GA';

   --Obtener datos del abonado
   TABLA := 'GA_ABOCEL';
   BEGIN

                   LV_Tabla   :='GA_ABOCEL';  --COL-71988|18-10-2008|GEZ
                   LV_Accion  :='S';              --COL-71988|18-10-2008|GEZ

                   --SELECT a.NUM_CELULAR, a.COD_CENTRAL, a.NUM_SERIEHEX, a.TIP_TERMINAL,a.NUM_MIN,a.COD_CLIENTE, a.CLASE_SERVICIO, a.cod_ciclo   --COL-71988|18-10-2008|GEZ
           --INTO celular, cod_central1, NumSerieHex1, TipTerminal1, nummin1,CodCliente1, cadena_actual, n_ciclo                                                        --COL-71988|18-10-2008|GEZ
           SELECT a.NUM_CELULAR, a.COD_CENTRAL, a.NUM_SERIEHEX, a.TIP_TERMINAL,a.NUM_MIN,a.COD_CLIENTE, a.CLASE_SERVICIO, a.cod_ciclo,cod_tecnologia   --COL-71988|18-10-2008|GEZ
           INTO celular, cod_central1, NumSerieHex1, TipTerminal1, nummin1,CodCliente1, cadena_actual, n_ciclo,V_TECNOLOGIA                                                     --COL-71988|18-10-2008|GEZ
                   FROM GA_ABOCEL a
           WHERE a.NUM_ABONADO = TO_NUMBER(s_abonado);
   EXCEPTION
       WHEN NO_DATA_FOUND THEN
           TABLA:= 'GA_ABOAMIST';
   END;

   IF TABLA = 'GA_ABOAMIST' THEN

                   LV_Tabla   :='GA_ABOAMIST';  --COL-71988|18-10-2008|GEZ
                   LV_Accion  :='S';                --COL-71988|18-10-2008|GEZ

                   --SELECT a.NUM_CELULAR, a.COD_CENTRAL, a.NUM_SERIEHEX, a.TIP_TERMINAL,a.NUM_MIN,a.COD_CLIENTE, a.CLASE_SERVICIO, a.cod_ciclo --COL-71988|18-10-2008|GEZ
           --INTO celular, cod_central1, NumSerieHex1, TipTerminal1, nummin1,CodCliente1, cadena_actual, n_ciclo                                                  --COL-71988|18-10-2008|GEZ
                   SELECT a.NUM_CELULAR, a.COD_CENTRAL, a.NUM_SERIEHEX, a.TIP_TERMINAL,a.NUM_MIN,a.COD_CLIENTE, a.CLASE_SERVICIO, a.cod_ciclo,cod_tecnologia --COL-71988|18-10-2008|GEZ
           INTO celular, cod_central1, NumSerieHex1, TipTerminal1, nummin1,CodCliente1, cadena_actual, n_ciclo,V_TECNOLOGIA                                               --COL-71988|18-10-2008|GEZ
           FROM GA_ABOAMIST a
           WHERE a.NUM_ABONADO = TO_NUMBER(s_abonado);
   END IF;

   -- Rescata fecha a Grabar FA_CICLFACT  06/11/2006 W.A 35941
       -- SELECT TO_CHAR(FEC_DESDELLAM-1/86000,'DD-MM-YYYY HH24:MI:SS')  -- COL|35941|SAQL|02-01-2007

   LV_Tabla   :='FA_CICLFACT';  --COL-71988|18-10-2008|GEZ
   LV_Accion  :='S';              --COL-71988|18-10-2008|GEZ

   --SELECT TO_CHAR(FEC_DESDELLAM-1/86400,'DD-MM-YYYY HH24:MI:SS')  -- COL|35941|SAQL|02-01-2007 --COL-71988|18-10-2008|GEZ
   --INTO   LV_fECHA                                                                                            --COL-71988|18-10-2008|GEZ
   SELECT TO_CHAR(FEC_DESDELLAM-1/86400,'DD-MM-YYYY HH24:MI:SS'),COD_CICLFACT    --COL-71988|18-10-2008|GEZ
   INTO   LV_fECHA,s_cod_ciclo                                                                                                  --COL-71988|18-10-2008|GEZ
   FROM   FA_CICLFACT
   WHERE  COD_CICLO = n_ciclo
   AND    SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;

   --INI COL-71988|18-10-2008|GEZ
   LV_Tabla   :='GED_PARAMETROS';
   LV_Accion  :='S';

   SELECT val_parametro
   INTO   fyf_param
   FROM   ged_parametros
   WHERE  nom_parametro = 'FRIEND_FAM';
   --FIN COL-71988|18-10-2008|GEZ

   LV_COUNT_AUX := 0;

   LV_Tabla   :='GED_CODIGOS';  --COL-71988|18-10-2008|GEZ
   LV_Accion  :='S';              --COL-71988|18-10-2008|GEZ

   SELECT  COUNT(1) INTO LV_COUNT_AUX
   FROM GED_CODIGOS
   WHERE
   COD_MODULO  ='GA' AND
   NOM_TABLA   ='PV_CONVERSION_SERVSUP_TD' AND
   NOM_COLUMNA ='NOM_USUARIO'              AND
   COD_VALOR IN (LV_CodOS);

   --COMPARO si la ooss corresponde a lo definido en el Parametro.06/11/2006 W.A 35941
   IF ((INSTR(LV_OOSSCambPlan,LV_CodOS)>0) OR (LV_COUNT_AUX= 1))THEN
        LV_fECHA := LV_fECHA;
   ELSE
        -- LV_fECHA := 'SYSDATE'; COL|35941|SAQL|03-01-2007
        LV_FECHA := TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS');
   END IF;
    -------------------------Fin a la Modificación.
   --Obtener c+digo de sistema

   LV_Tabla   :='ICG_CENTRAL';  --COL-71988|18-10-2008|GEZ
   LV_Accion  :='S';              --COL-71988|18-10-2008|GEZ

   SELECT cod_sistema
   INTO   ncod_sistema
   FROM   ICG_CENTRAL
   WHERE  cod_producto = 1
   AND    cod_central = cod_central1;

-- PGG Nuevas query para la obtencion del codigo de Tecnologia

   /*--INI COL-71988|18-10-2008|GEZ

        IF TABLA = 'GA_ABOCEL' THEN
                        SELECT COD_TECNOLOGIA
                        INTO V_TECNOLOGIA
                        FROM GA_ABOCEL
                        WHERE NUM_ABONADO = TO_NUMBER(s_abonado);
        ELSIF TABLA = 'GA_ABOAMIST' THEN
                        SELECT COD_TECNOLOGIA
                        INTO V_TECNOLOGIA
                        FROM GA_ABOAMIST
                        WHERE NUM_ABONADO = TO_NUMBER(s_abonado);
        END IF;

   --Obtener usuario de la OOSS
   SELECT usuario
   INTO s_usuario
   FROM PV_IORSERV
   WHERE NUM_OS = s_num_os;
   */
    --FIN COL-71988|18-10-2008|GEZ

   IF s_cs_act <> '*' THEN
      l_a := LENGTH(s_cs_act)/6;
   ELSIF s_cs_act = '*' THEN --significa que no se solicita activar un servicio
      l_a:= 0;
   END IF;
   IF s_cs_des <> '*' THEN --significa que no se solicita DESACTIVAR un servicio
      l_d := LENGTH(s_cs_des)/6;
   ELSIF s_cs_des = '*' THEN
      l_d := 0;
   END IF;

   IF l_d > 0 THEN
           LOOP -- ciclo para recorrer servicios a desactivar
              n_find := 0;

                          IF i_d >= l_d THEN
                     EXIT;
              END IF;

                          s_cod_servicio_d := SUBSTR(s_cs_des,6*i_d+1,2);
              s_cod_nivel_d := SUBSTR(s_cs_des,6*i_d+1+2,4);
              i_a:= 0;

                          IF l_a > 0 THEN
                 LOOP --ciclo para recorrer servicios a activar
                        IF i_a >= l_a THEN
                               EXIT;
                        END IF;

                                                s_cod_servicio_a := SUBSTR(s_cs_act,6*i_a+1,2);
                        s_cod_nivel_a := SUBSTR(s_cs_act,6*i_a+1+2,4);

                                                IF s_cod_servicio_d = s_cod_servicio_a THEN
                           n_find := 1;
                           EXIT;
                        END IF;

                        i_a:= i_a +1;

                 END LOOP;--ciclo para recorrer servicios a activar
              END IF;

              --if LTRIM(RTRIM(s_cod_servicio_d)) <> '' then --74072 col/07-12-2008/EFR -- COL 74755|18-12-2008|SAQL
              if LENGTH(s_cod_servicio_d) > 0 then -- COL 74755|18-12-2008|SAQL

                          IF n_find = 1 THEN --Caso en que desactivo un servicio y activo otro del mismo grupo

                         s_servicios_a := s_servicios_a || s_cod_servicio_a || s_cod_nivel_a;
                     /********* Obtengo los datos complemnatrios del servicio a Activar **************************/

                                         LV_Tabla   :='GA_SERVSUPL';  --COL-71988|18-10-2008|GEZ
                                         LV_Accion  :='S';                --COL-71988|18-10-2008|GEZ

                                         SELECT cod_servicio
                     INTO   scod_servicio
                     FROM       GA_SERVSUPL
                     WHERE  cod_producto = 1
                     AND        cod_nivel = TO_NUMBER(s_cod_nivel_a)
                     AND        cod_servsupl = TO_NUMBER(s_cod_servicio_a);
                     /********* Fin datos complemnatrios del servicio a Activar **********************************/

                         /*Verificar si el servicio es soportado por el terminal*/
                         /* PGG se incorpora el codigo de Tecnologia en la condicion */

                                         LV_Tabla   :='ICG_SERVICIOTERCEN';  --COL-71988|18-10-2008|GEZ
                                         LV_Accion  :='S';                --COL-71988|18-10-2008|GEZ

                                         SELECT COUNT(*)
                     INTO isoportable
                     FROM ICG_SERVICIOTERCEN
                     WHERE cod_servicio = TO_NUMBER(s_cod_servicio_a)
                     AND cod_producto = 1
                     AND tip_terminal = TipTerminal1
                     AND cod_sistema = ncod_sistema
                     AND TIP_TECNOLOGIA = V_TECNOLOGIA;

                     IF isoportable > 0 THEN
                     
                     
                     
                     
                              -- ocb-ini ip_fija  BAJA
                             
                              SELECT IND_IP 
                              INTO LV_IND_IP
                              FROM GA_SERVSUPL 
                              WHERE 
                              cod_producto =1 and 
                              COD_SERVICIO =scod_servicio;
                                
                                
                              IF LV_IND_IP <> 0 THEN                               
                                   PV_IPFIJA_PG.pv_generar_datos_ip_pr(s_abonado,celular,1,scod_servicio,TO_DATE(LV_FECHA, vFormatoSel2||' '|| vFormatoSel7)+1/86400 ,
                                   TO_CHAR(TO_NUMBER(s_cod_servicio_a)),TO_CHAR(TO_NUMBER(s_cod_nivel_a)),'DEL',0,1,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                              END IF; 
                             
                             -- ocb-ini ip_fija BAJA
                     
                      
                     
                     
                                     /* 1 Dar de baja servicio a desactivar*/
                             ssql := 'UPDATE GA_SERVSUPLABO SET '||
                             --'FEC_BAJABD = SYSDATE, IND_ESTADO = 3 ' ||--W.A 35941
                             -- 'FEC_BAJABD =' ||LV_fECHA||', IND_ESTADO = 3 ' || -- COL|35941|SAQL|02-01-2007
                             'FEC_BAJABD = TO_DATE('|| c ||LV_FECHA|| c ||','|| c ||'DD-MM-YYYY HH24:MI:SS'|| c ||'), IND_ESTADO = 3 '||
                             'WHERE COD_PRODUCTO = 1 ' ||
                             'AND NUM_ABONADO = ' || s_abonado || ' ' ||
                             'AND COD_SERVSUPL = ' || s_cod_servicio_d || ' ' ||
                             'AND FEC_BAJABD IS NULL ';

                                                         LV_Tabla   :='GA_SERVSUPLABO';  --COL-71988|18-10-2008|GEZ
                                                         LV_Accion  :='U';                --COL-71988|18-10-2008|GEZ

                             cur_din:= DBMS_SQL.OPEN_CURSOR;
                             DBMS_SQL.PARSE(cur_din,ssql,dbms_sql.v7);
                             rows_return:= DBMS_SQL.EXECUTE(cur_din);
                             DBMS_SQL.CLOSE_CURSOR(cur_din);

                                 /****** si es detalle de llamadas entonces actualiz+ en alta ga_infaccel *******/
                             /* Buscamos si el codigo de servicio es detalle*/
                             BEGIN

                                  LV_Tabla   :='GA_GRUPOS_SERVSUP_A';  --COL-71988|18-10-2008|GEZ
                                                                  LV_Accion  :='U';               --COL-71988|18-10-2008|GEZ

                                                                  SELECT COD_SERVICIO
                                  INTO   n_es_detalle
                                  FROM   GA_GRUPOS_SERVSUP
                                  WHERE COD_GRUPO = 'DETLLAM'
                                                                  /* Soporte 15-11-2002   se modifica, ya que debe acceder por servicio comercial para baja
                                  AND  COD_SERVICIO = s_cod_servicio_d */
                                  AND  COD_SERVICIO = scod_servicio
                                  AND  COD_PRODUCTO = 1;
                             EXCEPTION
                                          WHEN OTHERS THEN
                                           n_es_detalle := NULL;
                             END;

                             /*IF TABLA = 'GA_ABOCEL' AND s_cod_servicio_a = cod_7 THEN*/
                             IF TABLA = 'GA_ABOCEL' AND n_es_detalle IS NOT NULL THEN

                                                                --INI COL-71988|18-10-2008|GEZ
                                                                SELECT COD_CICLFACT
                                INTO s_cod_ciclo
                                FROM FA_CICLFACT
                                WHERE COD_CICLO = n_ciclo
                                AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;

                                                                --FIN COL-71988|18-10-2008|GEZ

                                IF  s_cod_nivel_d = '0000' THEN
                                        LV_Tabla   :='GA_INFACCEL';  --COL-71988|18-10-2008|GEZ
                                                                                LV_Accion  :='U';                 --COL-71988|18-10-2008|GEZ

                                                                                UPDATE GA_INFACCEL
                                        SET IND_DETALLE = 0
                                        WHERE COD_CLIENTE = CodCliente1
                                        AND NUM_ABONADO = s_abonado
                                        AND COD_CICLFACT = s_cod_ciclo;
                                END IF;
                             END IF;

                             /* FRIEND AND FAMILY */
                             BEGIN

                                                           --INI COL-71988|18-10-2008|GEZ
                                                           /*SELECT val_parametro
                               INTO fyf_param
                               FROM ged_parametros
                               WHERE nom_parametro = 'FRIEND_FAM';      */
                                                           --FIN COL-71988|18-10-2008|GEZ

                                                           LV_Tabla   :='GA_GRUPOS_SERVSUP FF';  --COL-71988|18-10-2008|GEZ
                                                           LV_Accion  :='S';              --COL-71988|18-10-2008|GEZ

                               SELECT COD_SERVICIO
                               INTO n_es_fyf
                               FROM GA_GRUPOS_SERVSUP
                               WHERE COD_GRUPO = fyf_param
                               AND COD_SERVICIO = scod_servicio
                               AND COD_PRODUCTO = 1;

                             EXCEPTION
                                WHEN OTHERS THEN
                                         n_es_fyf := NULL;
                             END;

                             IF n_es_fyf IS NOT NULL THEN

                                                                  LV_Tabla   :='GA_INTARCEL';  --COL-71988|18-10-2008|GEZ
                                                                  LV_Accion  :='S';               --COL-71988|18-10-2008|GEZ

                                                                  UPDATE ga_intarcel SET
                                  ind_friends = 1
                                  WHERE cod_cliente = CodCliente1
                                  AND num_abonado = s_abonado
                                  AND SYSDATE BETWEEN fec_desde AND NVL(fec_hasta, SYSDATE);
                             END IF;
                             
                             
                             
                             -- ocb-ini ip_fija  ALTA
                             
                              SELECT IND_IP 
                              INTO LV_IND_IP
                              FROM GA_SERVSUPL 
                              WHERE 
                              cod_producto =1 and 
                              COD_SERVICIO =scod_servicio;
                              
                             -- ocb-ini ip_fija ALTA
                             
                                                         /**********************************/

                             /* ********** 2  Dar de Alta el Servicio por enroque *********** */
                             /*                                        1              2           3            4            5           6              7           8            9       */
                             ssql := 'INSERT INTO GA_SERVSUPLABO (NUM_ABONADO, COD_SERVICIO, FEC_ALTABD, COD_SERVSUPL, COD_NIVEL, NUM_TERMINAL, COD_PRODUCTO,  IND_ESTADO , NOM_USUARORA';
                             IF  s_cod_servicio_a IN (cod_1,  cod_2) THEN
                                                         /*    10   */
                                    ssql := ssql || ', NUM_DIASNUM ';
                             END IF;

                             /********* Rescatar si existe concepto de facturaci+n asociado al servicio ******************/
                             BEGIN
                                                                  LV_Tabla   :='GA_ACTUASERV';  --COL-71988|18-10-2008|GEZ
                                                                  LV_Accion  :='S';               --COL-71988|18-10-2008|GEZ

                                          SELECT COD_CONCEPTO
                                          INTO   concepto_fa
                                          FROM   GA_ACTUASERV
                                          WHERE  COD_SERVICIO = scod_servicio
                                          AND    COD_PRODUCTO = 1
                                          AND    COD_ACTABO = 'FA'
                                          AND    COD_TIPSERV = '2';
                             EXCEPTION
                                WHEN OTHERS THEN
                                concepto_fa:= NULL;
                             END;
                                  /********* FIN Rescatar si existe concepto de facturaci+n asociado al servicio ******************/

                             IF NOT concepto_fa IS NULL THEN
                                                         /*    11     */
                               ssql := ssql || ', COD_CONCEPTO';
                             END IF;

                                                         ssql := ssql || ')  VALUES (' ||
                                   /*             1                     2                       3              4                           5                    6           7       8                9         */
                             -- W.A 35941 s_abonado || ',' || c || scod_servicio || c || ', sysdate, ' || to_char(to_number(s_cod_servicio_a)) || ', ' || to_char(to_number(s_cod_nivel_a)) || ', ' || celular || ',  1,       1,' || c || LTRIM(RTRIM(s_usuario)) || c;
                             s_abonado || ',' || c || scod_servicio || c ||','|| 'to_date(' || c || LV_fECHA || c ||','|| c || 'DD-MM-YYYY HH24:MI:SS'|| c || ')+1/86400,'||  TO_CHAR(TO_NUMBER(s_cod_servicio_a)) || ', ' || TO_CHAR(TO_NUMBER(s_cod_nivel_a)) || ', ' || celular || ',  1,       1,' || c || LTRIM(RTRIM(s_usuario)) || c;

                                                         IF s_cod_servicio_a IN (cod_1, cod_2) THEN

                                 /**********capturo el correlativo numdiasnum (para D?as Especiales o FriendFamily*******/
                                  IF NOT DIAS_ESPECIALES%ISOPEN THEN
                                     OPEN DIAS_ESPECIALES;
                                  END IF;

                                  FETCH DIAS_ESPECIALES INTO v_numdiasnum;
                                  IF DIAS_ESPECIALES%FOUND THEN
                                     ssql:= ssql || ', ' || v_numdiasnum;
                                  END IF;
                                  /********* Fin capturo el correlativo numdiasnum (para D?as Especiales o FriendFamily*******/

                             END IF;

                             IF NOT concepto_fa IS NULL THEN
                                sSql:= sSql || ',' || concepto_fa;
                             END IF;

                                                         sSql := sSql || ')';

                             /******************* Ejecuto consulta para dar de alta el servicio ****************************/
                             --INI 40406-COL|15-06-2007|EFR (PCR)
                             LV_Tabla   :='GA_SERVSUPLABO_C';  --COL-71988|18-10-2008|GEZ
                                                         LV_Accion  :='S';                --COL-71988|18-10-2008|GEZ

                                                         SELECT COUNT(1)
                             INTO V_COUNT
                             FROM ga_Servsuplabo
                             WHERE num_Abonado=s_abonado
                             AND cod_Servicio=scod_servicio
                             AND fec_altabd=TO_DATE(LV_fECHA,'DD-MM-YYYY HH24:MI:SS')+1/86400
                             AND ind_estado<3;

                             IF V_COUNT = 0 THEN
                             
                              -- ocb-ini ip_fija  ALTA
                             
                               IF LV_IND_IP <> 0 THEN                               
                                   PV_IPFIJA_PG.pv_generar_datos_ip_pr(s_abonado,celular,1,scod_servicio,TO_DATE(LV_fECHA,vFormatoSel2||' '|| vFormatoSel7)+1/86400,
                                   TO_CHAR(TO_NUMBER(s_cod_servicio_a)),TO_CHAR(TO_NUMBER(s_cod_nivel_a)),'INS',1,0,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                               END IF; 
                              
                              -- ocb-ini ip_fija  ALTA 
                             
                             
                             
                                --FIN 40406-COL|15-06-2007|EFR (PCR)

                                                                        LV_Tabla   :='GA_SERVSUPLABO_A';  --COL-71988|18-10-2008|GEZ
                                                                        LV_Accion  :='I';                 --COL-71988|18-10-2008|GEZ

                                    cur_din:= DBMS_SQL.OPEN_CURSOR;
                                    DBMS_SQL.PARSE(cur_din,sSql,dbms_sql.v7);
                                    rows_return:= DBMS_SQL.EXECUTE(cur_din);
                                    DBMS_SQL.CLOSE_CURSOR(cur_din);
                                    s_cs_act_procesados := s_cs_act_procesados || s_cod_servicio_a || s_cod_nivel_a;
                             END IF; --MOD 40406-COL|15-06-2007|EFR (PCR)

                             /*********************************** servicio en alta   ***************************************/

                             /***************** si es detalle de llamadas entonces actualiz+ en alta ga_infaccel *******************/

                             /* Buscamos si el codigo de servicio es detalle*/
                             BEGIN
                                                              LV_Tabla   :='GA_GRUPOS_SERVSUP-GA_SERVSUPL';  --COL-71988|18-10-2008|GEZ
                                                                  LV_Accion  :='S';                                                              --COL-71988|18-10-2008|GEZ

                                  SELECT a.COD_SERVICIO
                                  INTO   n_es_detalle
                                  FROM   GA_GRUPOS_SERVSUP A, GA_SERVSUPL B
                                  WHERE  a.COD_GRUPO = 'DETLLAM'
                                  AND  a.COD_PRODUCTO = 1
                                  AND  a.cod_producto = b.cod_producto
                                  AND  a.cod_servicio = b.cod_servicio
                                  AND  b.cod_nivel    = TO_NUMBER(s_cod_nivel_a)
                                  AND  b.cod_servsupl = TO_NUMBER(s_cod_servicio_a);

                                                                  /*Soporte (Comentario) 15-11-2002 Sereemplaza script, ya que debe dar de baja el detalle de llamada respecto a los servicios a desactivar
                                                                  El script de arriba reemplaza este
                                                 SELECT COD_SERVICIO
                                                   INTO n_es_detalle
                                                   FROM GA_GRUPOS_SERVSUP
                                              WHERE COD_GRUPO = 'DETLLAM'
                                                    AND COD_SERVICIO = s_cod_servicio_d
                                                        AND COD_PRODUCTO = 1;
Fin Soporte*/
                             EXCEPTION
                                WHEN OTHERS THEN
                                         n_es_detalle := NULL;
                             END;

                             /*IF TABLA = 'GA_ABOCEL' AND s_cod_servicio_a = cod_7 THEN*/
                             IF TABLA = 'GA_ABOCEL' AND n_es_detalle IS NOT NULL THEN

                                                                --INI COL-71988|18-10-2008|GEZ
                                                                /*SELECT COD_CICLFACT
                                INTO s_cod_ciclo
                                FROM FA_CICLFACT
                                WHERE COD_CICLO = n_ciclo
                                AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;*/

                                                                --FIN COL-71988|18-10-2008|GEZ

                                                                IF  s_cod_nivel_a <> '0000' THEN

                                                                        LV_Tabla   :='GA_INFACCEL';  --COL-71988|18-10-2008|GEZ
                                                                        LV_Accion  :='U';                        --COL-71988|18-10-2008|GEZ

                                                                        UPDATE GA_INFACCEL
                                    SET    IND_DETALLE = 1
                                    WHERE  COD_CLIENTE = CodCliente1
                                    AND    NUM_ABONADO = s_abonado
                                    AND    COD_CICLFACT = s_cod_ciclo;
                                END IF;
                             END IF;

                             /* FRIEND AND FAMILY */
                             BEGIN

                                                                  --INI COL-71988|18-10-2008|GEZ
                                                                  /*
                                                                  SELECT val_parametro
                                  INTO fyf_param
                                  FROM ged_parametros
                                  WHERE nom_parametro = 'FRIEND_FAM';
                                                                  */

                                                                  LV_Tabla   :='GA_GRUPOS_SERVSUP';
                                                                  LV_Accion  :='S';
                                                                  --FIN COL-71988|18-10-2008|GEZ

                                  SELECT COD_SERVICIO
                                  INTO   n_es_fyf
                                  FROM   GA_GRUPOS_SERVSUP
                                  WHERE  COD_GRUPO = fyf_param
                                  AND    COD_SERVICIO = scod_servicio
                                  AND    COD_PRODUCTO = 1;
                             EXCEPTION
                                WHEN OTHERS THEN
                                         n_es_fyf := NULL;
                             END;

                             IF n_es_fyf IS NOT NULL THEN
                                LV_Tabla   :='GA_INTARCELD';  --COL-71988|18-10-2008|GEZ
                                                                LV_Accion  :='U';                        --COL-71988|18-10-2008|GEZ

                                                                UPDATE ga_intarcel SET
                                ind_friends = 1
                                WHERE cod_cliente = CodCliente1
                                AND num_abonado = s_abonado
                                AND SYSDATE BETWEEN fec_desde AND NVL(fec_hasta, SYSDATE);
                             END IF;
                             /**********************************/

                                     ELSE
                             s_error:= s_error || scod_servicio || 'NS';
                         END IF; --fin if que valida que el servicio es soportable por el terminal

              ELSIF n_find = 0 THEN -- Caso en que solo desactivo un servicio es decir paso el servicio a nivel 0
              
              
                     -- ocb-ini ip_fija  BAJA
                             
                              SELECT IND_IP ,COD_SERVICIO
                              INTO LV_IND_IP ,LV_COD_SERVICIO_D
                              FROM GA_SERVSUPL 
                              WHERE 
                              cod_producto =1 and 
                              COD_SERVSUPL =s_cod_servicio_d AND 
                              COD_NIVEL    =s_cod_nivel_d;
                                
                                
                              IF LV_IND_IP <> 0 THEN                               
                                   PV_IPFIJA_PG.pv_generar_datos_ip_pr(s_abonado,celular,1,LV_COD_SERVICIO_D,TO_DATE(LV_FECHA,vFormatoSel2||' '|| vFormatoSel7)+1/86400,
                                   TO_CHAR(TO_NUMBER(s_cod_servicio_d)),TO_CHAR(TO_NUMBER(s_cod_nivel_d)),'DEL',0,1,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                              END IF; 
                             
                    -- ocb-ini ip_fija BAJA
                    
                    
              
                     -- s_servicios_d := s_servicios_d || s_cod_servicio_d || s_cod_nivel_d;
                     s_servicios_d := s_servicios_d || s_cod_servicio_d ||'0000';

                      /* 3 Dar de baja servicio a desactivar*/
                         ssql := 'UPDATE GA_SERVSUPLABO SET ' ||
                     -- 'FEC_BAJABD = SYSDATE, IND_ESTADO = 3 ' || --W.A 35941
                     -- 'FEC_BAJABD = ' ||LV_fECHA||', IND_ESTADO = 3 ' || -- COL|35941|SAQL|02-01-2007
                     'FEC_BAJABD = TO_DATE('|| c || LV_FECHA || c ||','|| c ||'DD-MM-YYYY HH24:MI:SS'|| c ||'), IND_ESTADO = 3 '||
                     'WHERE NUM_ABONADO = ' || s_abonado || ' ' ||
                     'AND COD_SERVSUPL = ' || s_cod_servicio_d || ' ' ||
                     'AND FEC_BAJABD IS NULL ';

                                         LV_Tabla   :='GA_SERVSUPLABOD';  --COL-71988|18-10-2008|GEZ
                                         LV_Accion  :='U';                       --COL-71988|18-10-2008|GEZ

                                         cur_din:= DBMS_SQL.OPEN_CURSOR;
                     DBMS_SQL.PARSE(cur_din,ssql,dbms_sql.v7);
                     rows_return:= DBMS_SQL.EXECUTE(cur_din);
                     DBMS_SQL.CLOSE_CURSOR(cur_din);

                                         /* Soporte 15-11-2002, agrega desactivación de servicio de detalle de llamadas, el cual no se habia incorporado  */
                     /***************** si es detalle de llamadas entonces actualiz+ en alta ga_infaccel *******************/
                     /* Buscamos si el codigo de servicio es detalle*/
                     BEGIN

                                                                LV_Tabla   :='GA_GRUPOS_SERVSUP-GA_SERVSUPL';  --COL-71988|18-10-2008|GEZ
                                                                LV_Accion  :='S';                        --COL-71988|18-10-2008|GEZ

                                                                SELECT a.COD_SERVICIO
                                INTO   n_es_detalle
                                FROM   GA_GRUPOS_SERVSUP A, GA_SERVSUPL B
                                WHERE  a.COD_GRUPO = 'DETLLAM'
                                AND  a.COD_PRODUCTO = 1
                                AND  a.cod_producto = b.cod_producto
                                AND  a.cod_servicio = b.cod_servicio
                                AND  b.cod_nivel    = TO_NUMBER(s_cod_nivel_d)
                                AND  b.cod_servsupl = TO_NUMBER(s_cod_servicio_d);

                     EXCEPTION
                        WHEN OTHERS THEN
                                 n_es_detalle := NULL;
                     END;

                     IF TABLA = 'GA_ABOCEL' AND n_es_detalle IS NOT NULL THEN

                                                --INI COL-71988|18-10-2008|GEZ
                                                /*SELECT COD_CICLFACT
                        INTO s_cod_ciclo
                        FROM FA_CICLFACT
                        WHERE COD_CICLO = n_ciclo
                        AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;*/
                        --FIN COL-71988|18-10-2008|GEZ

                                                IF  s_cod_nivel_a <> '0000' THEN

                                                          LV_Tabla   :='GA_INFACCELE';  --COL-71988|18-10-2008|GEZ
                                                          LV_Accion  :='U';                      --COL-71988|18-10-2008|GEZ

                                                          UPDATE GA_INFACCEL
                              SET IND_DETALLE = 1
                              WHERE COD_CLIENTE = CodCliente1
                              AND NUM_ABONADO = s_abonado
                              AND COD_CICLFACT = s_cod_ciclo;
                        END IF;
                     END IF;
                          /* Fin soporte 15-11-2002 */

              END IF;

                          -- rrg END IF; --74072 col/07-12-2008/EFR

                  -- INICIO RRG 10-12-2008 74205 COL
                  -- SE CLONA LA FUNCIONALIDAD PARA NO HECHAR A PEDER ALGO QUE ESTUVIERA OK
                  ELSIF n_find = 0 THEN -- Caso en que solo desactivo un servicio es decir paso el servicio a nivel 0


                      -- ocb-ini ip_fija  BAJA
                             
                              SELECT IND_IP ,COD_SERVICIO
                              INTO LV_IND_IP ,LV_COD_SERVICIO_D
                              FROM GA_SERVSUPL 
                              WHERE 
                              cod_producto =1 and 
                              COD_SERVSUPL =s_cod_servicio_d AND 
                              COD_NIVEL    =s_cod_nivel_d;
                                
                                
                              IF LV_IND_IP <> 0 THEN                               
                                   PV_IPFIJA_PG.pv_generar_datos_ip_pr(s_abonado,celular,1,LV_COD_SERVICIO_D,TO_DATE(LV_FECHA,vFormatoSel2||' '|| vFormatoSel7)+1/86400,
                                   TO_CHAR(TO_NUMBER(s_cod_servicio_d)),TO_CHAR(TO_NUMBER(s_cod_nivel_d)),'DEL',0,1,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                              END IF; 
                             
                    -- ocb-ini ip_fija BAJA                       






                     s_servicios_d := s_servicios_d || s_cod_servicio_d ||'0000';


                         ssql := 'UPDATE GA_SERVSUPLABO SET ' ||

                     'FEC_BAJABD = TO_DATE('|| c || LV_FECHA || c ||','|| c ||'DD-MM-YYYY HH24:MI:SS'|| c ||'), IND_ESTADO = 3 '||
                     'WHERE NUM_ABONADO = ' || s_abonado || ' ' ||
                     'AND COD_SERVSUPL = ' || s_cod_servicio_d || ' ' ||
                     'AND FEC_BAJABD IS NULL ';

                                         LV_Tabla   :='GA_SERVSUPLABOD';
                                         LV_Accion  :='U';

                                         cur_din:= DBMS_SQL.OPEN_CURSOR;
                     DBMS_SQL.PARSE(cur_din,ssql,dbms_sql.v7);
                     rows_return:= DBMS_SQL.EXECUTE(cur_din);
                     DBMS_SQL.CLOSE_CURSOR(cur_din);


                     BEGIN

                                                                LV_Tabla   :='GA_GRUPOS_SERVSUP-GA_SERVSUPL';
                                                                LV_Accion  :='S';

                                                                SELECT a.COD_SERVICIO
                                INTO   n_es_detalle
                                FROM   GA_GRUPOS_SERVSUP A, GA_SERVSUPL B
                                WHERE  a.COD_GRUPO = 'DETLLAM'
                                AND  a.COD_PRODUCTO = 1
                                AND  a.cod_producto = b.cod_producto
                                AND  a.cod_servicio = b.cod_servicio
                                AND  b.cod_nivel    = TO_NUMBER(s_cod_nivel_d)
                                AND  b.cod_servsupl = TO_NUMBER(s_cod_servicio_d);

                     EXCEPTION
                        WHEN OTHERS THEN
                                 n_es_detalle := NULL;
                     END;

                     IF TABLA = 'GA_ABOCEL' AND n_es_detalle IS NOT NULL THEN

                                                IF  s_cod_nivel_a <> '0000' THEN

                                                          LV_Tabla   :='GA_INFACCELE';
                                                          LV_Accion  :='U';

                                                          UPDATE GA_INFACCEL
                              SET IND_DETALLE = 1
                              WHERE COD_CLIENTE = CodCliente1
                              AND NUM_ABONADO = s_abonado
                              AND COD_CICLFACT = s_cod_ciclo;
                        END IF;
                     END IF;


              END IF;

                  --- FIN       RRG 10-12-2008 74205 COL

                          i_d:= i_d +1;

           END LOOP;-- ciclo para recorrer servicios a desactivar

                   /*  se deben procesar aquellos servicios que estan para activar pero no se encuentran en desactivar*/
           /*  en la viariable s_cs_act_procesados estan aquellos servicios no procesados por no tener relaci+n con los*/
           /*  que se desactivan                                                                                       */

          -- Ver si hay servicios pendientes de ser procesados
          IF LENGTH(s_cs_act_procesados) > 0 THEN
                 l_p := LENGTH(s_cs_act_procesados)/6;
          ELSE
             l_p:= 0;
          END IF;
                  --------------------

                  i_a:=0;

                  IF l_a > 0 THEN --if que contiene al loop valida que la cacdena de activar es largo 0
                 LOOP --ciclo para recorrer servicios a activar
                  n_find := 0;

                                  IF i_a >= l_a THEN
                         EXIT;
                  END IF;

                                  s_cod_servicio_a := SUBSTR(s_cs_act,6*i_a+1,2);
                  s_cod_nivel_a := SUBSTR(s_cs_act,6*i_a+1+2,4);
                  i_p := 0;

                                  IF l_p > 0 THEN
                         LOOP  --ciclo para verificar que el servicio no este activado por enroque
                           IF i_p >= l_p THEN
                                  EXIT;
                           END IF;

                                                   s_cs_act_pservicio := SUBSTR(s_cs_act_procesados,6*i_p+1,2);
                           s_cs_act_pnivel := SUBSTR(s_cs_act_procesados,6*i_p+1+2,4);

                                                   IF s_cod_servicio_a = s_cs_act_pservicio THEN
                                  n_find := 1;
                              EXIT;
                           END IF;

                                                   i_p := i_p +1;

                     END LOOP;
                  END IF;

                                  -- if LTRIM(RTRIM(s_cod_servicio_a)) <> '' then --74072 col/07-12-2008/EFR -- COL 74211|10-12-2008|SAQL
              if LENGTH(LTRIM(RTRIM(s_cod_servicio_a))) > 0 then --74072 col/07-12-2008/EFR -- COL 74211|10-12-2008|SAQL

                                  IF n_find <> 1 THEN
                         --Hemos encontrado un servicio sin procesar que debe ser activado
                     s_servicios_sa := s_servicios_sa || s_cod_servicio_a || s_cod_nivel_a;

                                         ssql := '';

                     /********* Obtengo los datos complemnatrios del servicio a Activar **************************/
                     LV_Tabla   :='GA_SERVSUPL';  --COL-71988|18-10-2008|GEZ
                                         LV_Accion  :='S';                       --COL-71988|18-10-2008|GEZ

                                         SELECT cod_servicio
                     INTO scod_servicio
                     FROM GA_SERVSUPL
                     WHERE cod_servsupl = TO_NUMBER(s_cod_servicio_a)
                     AND cod_nivel = TO_NUMBER(s_cod_nivel_a)
                     AND COD_PRODUCTO = 1;

                     /********* Fin datos complemnatrios del servicio a Activar **********************************/

                     /*Verificar si el servicio es soportado por el terminal*/
                     /* PGG se incorpora el codigo de Tecnologia en la condicion */

                                         LV_Tabla   :='ICG_SERVICIOTERCEN';  --COL-71988|18-10-2008|GEZ
                                         LV_Accion  :='S';                       --COL-71988|18-10-2008|GEZ

                     SELECT COUNT(*)
                     INTO isoportable
                     FROM ICG_SERVICIOTERCEN
                     WHERE cod_servicio = TO_NUMBER(s_cod_servicio_a)
                     AND cod_producto = 1
                     AND tip_terminal = TipTerminal1
                     AND cod_sistema = ncod_sistema
                     AND TIP_TECNOLOGIA = V_TECNOLOGIA;

                     IF isoportable > 0 THEN
                     
                     -- ocb-ini ip_fija  ALTA
                             
                              SELECT IND_IP 
                              INTO LV_IND_IP
                              FROM GA_SERVSUPL 
                              WHERE 
                              cod_producto =1 and 
                              COD_SERVICIO =scod_servicio; 
                             
                             
                    -- ocb-ini ip_fija ALTA
                     
                     
                     
                     
                     

                           /* **********4 Dar de Alta el Servicio sin  procesar *********** */
                                           /*                                        1              2           3            4            5           6              7           8            9       */
                           ssql := 'INSERT INTO GA_SERVSUPLABO (NUM_ABONADO, COD_SERVICIO, FEC_ALTABD, COD_SERVSUPL, COD_NIVEL, NUM_TERMINAL, COD_PRODUCTO,  IND_ESTADO , NOM_USUARORA';

                                                   IF  s_cod_servicio_a IN (cod_1,  cod_2) THEN
                                                                /*    10   */
                                        ssql := ssql || ', NUM_DIASNUM ';
                           END IF;

                           /********* Rescatar si existe concepto de facturaci+n asociado al servicio ******************/
                           BEGIN

                                                                LV_Tabla   :='GA_ACTUASERVF';  --COL-71988|18-10-2008|GEZ
                                                                LV_Accion  :='S';                        --COL-71988|18-10-2008|GEZ

                                                                SELECT COD_CONCEPTO
                                INTO concepto_fa
                                FROM GA_ACTUASERV
                                WHERE COD_SERVICIO = scod_servicio
                                AND COD_PRODUCTO = 1
                                AND COD_ACTABO = 'FA'
                                AND COD_TIPSERV = '2';
                           EXCEPTION
                                        WHEN OTHERS THEN
                                         concepto_fa:= NULL;
                           END;
                                          /********* FIN Rescatar si existe concepto de facturaci+n asociado al servicio ******************/

                           IF NOT concepto_fa IS NULL THEN
                                                                 /*    11     */
                                        ssql := ssql || ', COD_CONCEPTO';
                           END IF;

                                                   ssql := ssql || ')  VALUES (' ||
                           /*             1                          2                       3              4                           5                    6                                    7           8         9         */
                           -- W.A 35941  s_abonado || ',' || c || scod_servicio || c || ', sysdate, ' || to_char(to_number(s_cod_servicio_a)) || ', ' || to_char(to_number(s_cod_nivel_a)) || ', ' || celular || ',  1,       1,' || c || LTRIM(RTRIM(s_usuario)) || c;

                                                   s_abonado || ',' || c || scod_servicio || c ||','|| 'to_date(' || c || LV_fECHA || c ||','|| c || 'DD-MM-YYYY HH24:MI:SS'|| c || ')+1/86400,'||  TO_CHAR(TO_NUMBER(s_cod_servicio_a)) || ', ' || TO_CHAR(TO_NUMBER(s_cod_nivel_a)) || ', ' || celular || ',  1,       1,' || c || LTRIM(RTRIM(s_usuario)) || c;

                                                   IF s_cod_servicio_a IN (cod_1, cod_2) THEN

                                  /**********capturo el correlativo numdiasnum (para D?as Especiales o FriendFamily*******/
                              IF NOT DIAS_ESPECIALES%ISOPEN THEN
                                 OPEN DIAS_ESPECIALES;
                              END IF;

                                                          FETCH DIAS_ESPECIALES INTO v_numdiasnum;

                                                          IF DIAS_ESPECIALES%FOUND THEN
                                 ssql:= ssql || ', ' || v_numdiasnum;
                              END IF;
                              /********* Fin capturo el correlativo numdiasnum (para D?as Especiales o FriendFamily*******/

                           END IF;

                           IF NOT concepto_fa IS NULL THEN
                               sSql:= sSql || ',' || concepto_fa;
                           END IF;

                                                   sSql := sSql || ')';

                           /******************* Ejecuto consulta para dar de alta el servicio ****************************/

                                                   LV_Tabla   :='GA_SERVSUPLABOG';  --COL-71988|18-10-2008|GEZ
                                                   LV_Accion  :='S';                     --COL-71988|18-10-2008|GEZ

                                                   --INI 40406-COL|15-06-2007|EFR (PCR)
                           SELECT COUNT(1)
                           INTO V_COUNT
                           FROM ga_Servsuplabo
                           WHERE num_Abonado=s_abonado
                           AND cod_Servicio=scod_servicio
                           AND fec_altabd=TO_DATE(LV_fECHA,'DD-MM-YYYY HH24:MI:SS')+1/86400
                           AND ind_estado<3;

                           IF V_COUNT = 0 THEN
                           
                           
                              -- ocb-ini ip_fija  ALTA    
                                
                              IF LV_IND_IP <> 0 THEN                               
                                   PV_IPFIJA_PG.pv_generar_datos_ip_pr(s_abonado,celular,1,scod_servicio ,TO_DATE(LV_fECHA,vFormatoSel2||' '|| vFormatoSel7)+1/86400,
                                   TO_CHAR(TO_NUMBER(s_cod_servicio_a)),TO_CHAR(TO_NUMBER(s_cod_nivel_a)),'INS',1,0,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                              END IF; 
                           
                             -- ocb-ini ip_fija  ALTA
                           
                           --FIN 40406-COL|15-06-2007|EFR (PCR)

                                                                 LV_Tabla   :='GA_SERVSUPLABOG';  --COL-71988|18-10-2008|GEZ
                                                                 LV_Accion  :='I';                       --COL-71988|18-10-2008|GEZ

                                                                 cur_din:= DBMS_SQL.OPEN_CURSOR;
                                 DBMS_SQL.PARSE(cur_din,sSql,dbms_sql.v7);
                                 rows_return:= DBMS_SQL.EXECUTE(cur_din);
                                 DBMS_SQL.CLOSE_CURSOR(cur_din);
                                 s_cs_act_procesados := s_cs_act_procesados || s_cod_servicio_a || s_cod_nivel_a;
                           END IF; -- MOD 40406-COL|15-06-2007|EFR (PCR)

                           /*********************************** servicio en alta   ***************************************/

                           /***************** si es detalle de llamadas entonces actualiz+ en alta ga_infaccel *******************/

                           /* Buscamos si el codigo de servicio es detalle*/
                           BEGIN

                                                                LV_Tabla   :='GA_GRUPOS_SERVSUPG';  --COL-71988|18-10-2008|GEZ
                                                                LV_Accion  :='S';                        --COL-71988|18-10-2008|GEZ

                                                                SELECT COD_SERVICIO
                                INTO   n_es_detalle
                                FROM   GA_GRUPOS_SERVSUP
                                WHERE  COD_GRUPO = 'DETLLAM'
                                AND  COD_SERVICIO = scod_servicio
                                                /* Soporte 15-11-2002   se modifica, ya que debe acceder por servicio comercial para baja
                                AND  COD_SERVICIO = s_cod_servicio_d */
                                AND  COD_PRODUCTO = 1;
                           EXCEPTION
                                        WHEN OTHERS THEN
                                         n_es_detalle := NULL;
                           END;

                           /*IF TABLA = 'GA_ABOCEL' AND s_cod_servicio_a = cod_7 THEN*/
                           IF TABLA = 'GA_ABOCEL' AND n_es_detalle IS NOT NULL THEN

                                                          --INI COL-71988|18-10-2008|GEZ
                                                          /*
                                                          SELECT COD_CICLFACT
                              INTO s_cod_ciclo
                              FROM FA_CICLFACT
                              WHERE COD_CICLO = n_ciclo
                              AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;
                                                          */
                              --FIN COL-71988|18-10-2008|GEZ

                                                          IF  s_cod_nivel_a <> '0000' THEN

                                                                  LV_Tabla   :='GA_INFACCELG';  --COL-71988|18-10-2008|GEZ
                                                                  LV_Accion  :='S';                      --COL-71988|18-10-2008|GEZ

                                                                  UPDATE GA_INFACCEL
                                  SET IND_DETALLE = 1
                                  WHERE COD_CLIENTE = CodCliente1
                                  AND NUM_ABONADO = s_abonado
                                  AND COD_CICLFACT = s_cod_ciclo;
                              END IF;
                           END IF;

                           /* FRIEND AND FAMILY */
                           BEGIN

                                                                --INI COL-71988|18-10-2008|GEZ
                                                                /*SELECT val_parametro
                                INTO fyf_param
                                FROM ged_parametros
                                WHERE nom_parametro = 'FRIEND_FAM';
                                                                */
                                                                LV_Tabla   :='GA_GRUPOS_SERVSUPH';  --COL-71988|18-10-2008|GEZ
                                                                LV_Accion  :='S';                                       --COL-71988|18-10-2008|GEZ

                                                                --FIN COL-71988|18-10-2008|GEZ

                                SELECT COD_SERVICIO
                                INTO n_es_fyf
                                FROM GA_GRUPOS_SERVSUP
                                WHERE COD_GRUPO = fyf_param
                                AND COD_SERVICIO = scod_servicio
                                AND COD_PRODUCTO = 1;

                           EXCEPTION
                                        WHEN OTHERS THEN
                                         n_es_fyf := NULL;
                           END;

                           IF n_es_fyf IS NOT NULL THEN

                                                          LV_Tabla   :='GA_INTARCELH';  --COL-71988|18-10-2008|GEZ
                                                          LV_Accion  :='S';                                     --COL-71988|18-10-2008|GEZ

                                                          UPDATE ga_intarcel SET
                              ind_friends = 1
                              WHERE cod_cliente = CodCliente1
                              AND num_abonado = s_abonado
                              AND SYSDATE BETWEEN fec_desde AND NVL(fec_hasta, SYSDATE);
                           END IF;
                           /**********************************/

                     ELSE
                                 s_error:= s_error || scod_servicio || 'NS';
                     END IF; -- servicio dado de alta si es soportado por el terminal

                  -- Dado de alta servicio no procesado

                  END IF;

                                  END IF;--74072 col/07-12-2008/EFR

                      i_a:= i_a +1;
             END LOOP;--ciclo para recorrer servicios a activar
          END IF; -- if que contien a este loop

                  -------------------
          /*  FIN: se deben procesar aquellos servicios que estan para activar pero no se encuentran en desactivar*/

   ELSIF l_d = 0 THEN
         /*if length(s_cs_act_procesados) > 0 then
         l_p := length(s_cs_act_procesados)/6;
         else
             l_p:= 0;
         end if;*/

                 LOOP --ciclo para recorrer servicios a activar
              n_find := 0;

                          IF i_a >= l_a THEN
                 EXIT;
              END IF;

                          s_cod_servicio_a := SUBSTR(s_cs_act,6*i_a+1,2);
              s_cod_nivel_a := SUBSTR(s_cs_act,6*i_a+1+2,4);

                          -- if LTRIM(RTRIM(s_cod_servicio_a)) <> '' then --74072 col/06-12-2008/EFR -- COL 74211|10-12-2008|SAQL
            IF LENGTH(LTRIM(RTRIM(s_cod_servicio_a))) > 0 THEN -- COL 74211|10-12-2008|SAQL

                          /*                i_p := 0;
                  if l_p > 0 then
                     loop  --ciclo para verificar que el servicio no este activado por enroque
                        if i_p >= l_p then
                               exit;
                            end if;
                            s_cs_act_pservicio := substr(s_cs_act_procesados,6*i_p+1,6*(i_p+1));
                            s_cs_act_pnivel := substr(s_cs_act_procesados,6*i_p+1,6*(i_p+1));
                            if s_cod_servicio_a = s_cs_act_pservicio then
                               n_find := 1;
                                   exit;
                            end if;
                            i_p := i_p +1;
                     end loop;
                  end if;*/
                  --if n_find <> 1 then
                     --Hemos encontrado un servicio sin procesar que debe ser activado

                          s_servicios_sa := s_servicios_sa || s_cod_servicio_a || s_cod_nivel_a;
              ssql := '';

              /********* Obtengo los datos complemnatrios del servicio a Activar **************************/

                          LV_Tabla   :='GA_SERVSUPLI';  --COL-71988|18-10-2008|GEZ
                          LV_Accion  :='S';                                     --COL-71988|18-10-2008|GEZ

                          SELECT cod_servicio
              INTO scod_servicio
              FROM GA_SERVSUPL
              WHERE cod_servsupl = TO_NUMBER(s_cod_servicio_a)
              AND cod_nivel = TO_NUMBER(s_cod_nivel_a)
              AND COD_PRODUCTO = 1;

              /********* Fin datos complemnatrios del servicio a Activar **********************************/

              /*Verificar si el servicio es soportado por el terminal*/
              /* PGG se incorpora el codigo de Tecnologia en la condicion */

                          LV_Tabla   :='GA_SERVSUPLI';  --COL-71988|18-10-2008|GEZ
                          LV_Accion  :='S';                                     --COL-71988|18-10-2008|GEZ

                          SELECT COUNT(*)
              INTO isoportable
              FROM ICG_SERVICIOTERCEN
              WHERE cod_servicio = TO_NUMBER(s_cod_servicio_a)
              AND cod_producto = 1
              AND tip_terminal = TipTerminal1
              AND cod_sistema = ncod_sistema
              AND TIP_TECNOLOGIA = V_TECNOLOGIA;

              IF isoportable > 0 THEN
              
              
              
              
                    -- ocb-ini ip_fija  ALTA
                             
                              SELECT IND_IP 
                              INTO LV_IND_IP
                              FROM GA_SERVSUPL 
                              WHERE 
                              cod_producto =1 and 
                              COD_SERVICIO =scod_servicio; 
                           
                             
                    -- ocb-ini ip_fija ALTA
              
              
              
              
              
              

                 /* **********5 Dar de Alta el Servicio sin  procesar *********** */
                 /*                                        1              2           3            4            5           6              7           8            9       */
                 ssql := 'INSERT INTO GA_SERVSUPLABO (NUM_ABONADO, COD_SERVICIO, FEC_ALTABD, COD_SERVSUPL, COD_NIVEL, NUM_TERMINAL, COD_PRODUCTO,  IND_ESTADO , NOM_USUARORA';

                                 IF  s_cod_servicio_a IN (cod_1,  cod_2) THEN
                          /*    10   */
                          ssql := ssql || ', NUM_DIASNUM ';
                 END IF;

                 /********* Rescatar si existe concepto de facturaci+n asociado al servicio ******************/
                 BEGIN

                                          LV_Tabla   :='GA_ACTUASERVI';  --COL-71988|18-10-2008|GEZ
                                          LV_Accion  :='S';                                     --COL-71988|18-10-2008|GEZ

                                          SELECT COD_CONCEPTO
                      INTO concepto_fa
                      FROM GA_ACTUASERV
                      WHERE COD_SERVICIO = scod_servicio
                      AND COD_PRODUCTO = 1
                      AND COD_ACTABO = 'FA'
                      AND COD_TIPSERV = '2';
                 EXCEPTION
                                WHEN OTHERS THEN
                                 concepto_fa:= NULL;
                 END;
                  /*********3 FIN Rescatar si existe concepto de facturaci+n asociado al servicio ******************/

                 IF NOT concepto_fa IS NULL THEN
                                                         /*    11     */
                                ssql := ssql || ', COD_CONCEPTO';
                 END IF;

                                  ssql := ssql || ')  VALUES (' ||
                                   /*             1                          2                       3              4                           5                    6           7       8                9         */
                                   -- W.A 35941 s_abonado || ',' || c || scod_servicio || c || ', sysdate, ' || to_char(to_number(s_cod_servicio_a)) || ', ' || to_char(to_number(s_cod_nivel_a)) || ', ' || celular || ',  1,       1,' || c || LTRIM(RTRIM(s_usuario)) || c;
                  s_abonado || ',' || c || scod_servicio || c ||','|| 'to_date(' || c || LV_fECHA || c ||','|| c || 'DD-MM-YYYY HH24:MI:SS'|| c || ')+1/86400,'||  TO_CHAR(TO_NUMBER(s_cod_servicio_a)) || ', ' || TO_CHAR(TO_NUMBER(s_cod_nivel_a)) || ', ' || celular || ',  1,       1,' || c || LTRIM(RTRIM(s_usuario)) || c;

                  IF s_cod_servicio_a IN (cod_1, cod_2) THEN

                         /**********capturo el correlativo numdiasnum (para D?as Especiales o FriendFamily*******/
                     IF NOT DIAS_ESPECIALES%ISOPEN THEN
                        OPEN DIAS_ESPECIALES;
                     END IF;

                                         FETCH DIAS_ESPECIALES INTO v_numdiasnum;

                                         IF DIAS_ESPECIALES%FOUND THEN
                        ssql:= ssql || ', ' || v_numdiasnum;
                     END IF;

                                         /********* Fin capturo el correlativo numdiasnum (para D?as Especiales o FriendFamily*******/

                  END IF;

                  IF NOT concepto_fa IS NULL THEN
                         sSql:= sSql || ',' || concepto_fa;
                  END IF;

                                  sSql := sSql || ')';

                  /******************* Ejecuto consulta para dar de alta el servicio ****************************/

                                  LV_Tabla   :='GA_SERVSUPLABOI';  --COL-71988|18-10-2008|GEZ
                                  LV_Accion  :='S';                                     --COL-71988|18-10-2008|GEZ

                                  --INI 40406-COL|15-06-2007|EFR (PCR)
                  SELECT COUNT(1)
                  INTO V_COUNT
                  FROM ga_Servsuplabo
                  WHERE num_Abonado=s_abonado
                  AND cod_Servicio=scod_servicio
                  AND fec_altabd=TO_DATE(LV_fECHA,'DD-MM-YYYY HH24:MI:SS')+1/86400
                  AND ind_estado<3;

                  IF V_COUNT = 0 THEN
                  
                           -- ocb-ini ip_fija  ALTA  
                                
                              IF LV_IND_IP <> 0 THEN                               
                                   PV_IPFIJA_PG.pv_generar_datos_ip_pr(s_abonado,celular,1,scod_servicio ,TO_DATE(LV_fECHA,vFormatoSel2||' '|| vFormatoSel7)+1/86400,
                                   TO_CHAR(TO_NUMBER(s_cod_servicio_a)),TO_CHAR(TO_NUMBER(s_cod_nivel_a)),'INS',1,0,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                              END IF;
                                
                           -- ocb-ini ip_fija  ALTA
                  
                  --FIN 40406-COL|15-06-2007|EFR (PCR)

                                                LV_Tabla   :='GA_SERVSUPLABOI';  --COL-71988|18-10-2008|GEZ
                                                LV_Accion  :='I';                                       --COL-71988|18-10-2008|GEZ

                                cur_din:= DBMS_SQL.OPEN_CURSOR;
                        DBMS_SQL.PARSE(cur_din,sSql,dbms_sql.v7);
                        rows_return:= DBMS_SQL.EXECUTE(cur_din);
                        DBMS_SQL.CLOSE_CURSOR(cur_din);

                                                s_cs_act_procesados := s_cs_act_procesados || s_cod_servicio_a || s_cod_nivel_a;
                   END IF; --MOD 40406-COL|15-06-2007|EFR (PCR)

                                   /*********************************** servicio en alta   ***************************************/

                   /***************** si es detalle de llamadas entonces actualiz+ en alta ga_infaccel *******************/

                   /* Buscamos si el codigo de servicio es detalle*/
                   BEGIN

                                                LV_Tabla   :='GA_GRUPOS_SERVSUPI';  --COL-71988|18-10-2008|GEZ
                                                LV_Accion  :='S';                                       --COL-71988|18-10-2008|GEZ

                                                SELECT  COD_SERVICIO
                        INTO    n_es_detalle
                        FROM    GA_GRUPOS_SERVSUP
                        WHERE   COD_GRUPO       = 'DETLLAM'
                        AND   COD_SERVICIO    = scod_servicio
                                                /* Soporte 15-11-2002   se modifica, ya que debe acceder por servicio comercial para baja
                        AND  COD_SERVICIO = s_cod_servicio_d */
                        AND COD_PRODUCTO = 1;
                   EXCEPTION
                                WHEN OTHERS THEN
                                 n_es_detalle := NULL;
                   END;

                   /*IF TABLA = 'GA_ABOCEL' AND s_cod_servicio_a = cod_7 THEN*/
                   IF TABLA = 'GA_ABOCEL' AND n_es_detalle IS NOT NULL THEN

                                          --INI COL-71988|18-10-2008|GEZ
                          /*SELECT COD_CICLFACT
                      INTO s_cod_ciclo
                      FROM FA_CICLFACT
                      WHERE COD_CICLO = n_ciclo
                      AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;*/
                      --FIN COL-71988|18-10-2008|GEZ

                                          IF  s_cod_nivel_a <> '0000' THEN

                                                  LV_Tabla   :='GA_INFACCELI';  --COL-71988|18-10-2008|GEZ
                                                  LV_Accion  :='S';                                     --COL-71988|18-10-2008|GEZ

                                                  UPDATE GA_INFACCEL
                          SET IND_DETALLE = 1
                          WHERE COD_CLIENTE = CodCliente1
                          AND NUM_ABONADO = s_abonado
                          AND COD_CICLFACT = s_cod_ciclo;
                      END IF;
                   END IF;

                   /* FRIEND AND FAMILY */
                   BEGIN

                                                --INI COL-71988|18-10-2008|GEZ
                                /*SELECT val_parametro
                        INTO fyf_param
                        FROM ged_parametros
                        WHERE nom_parametro = 'FRIEND_FAM';*/

                                                LV_Tabla   :='GA_GRUPOS_SERVSUPI';
                                                LV_Accion  :='S';

                                                --FIN COL-71988|18-10-2008|GEZ

                        SELECT COD_SERVICIO
                        INTO n_es_fyf
                        FROM GA_GRUPOS_SERVSUP
                        WHERE COD_GRUPO = fyf_param
                        AND COD_SERVICIO = scod_servicio
                        AND COD_PRODUCTO = 1;
                   EXCEPTION
                                WHEN OTHERS THEN
                                 n_es_fyf := NULL;
                   END;

                           IF n_es_fyf IS NOT NULL THEN

                                          LV_Tabla   :='GA_INTARCELI';  --COL-71988|18-10-2008|GEZ
                                          LV_Accion  :='U';                                     --COL-71988|18-10-2008|GEZ

                                          UPDATE ga_intarcel SET
                      ind_friends = 1
                      WHERE cod_cliente = CodCliente1
                      AND num_abonado = s_abonado
                      AND SYSDATE BETWEEN fec_desde AND NVL(fec_hasta, SYSDATE);
                   END IF;

                                   /**********************************/

              ELSE
                  s_error:= s_error || scod_servicio || 'NS';
              END IF; -- servicio dado de alta si es soportado por el terminal

              -- Dado de alta servicio no procesado

                          end if; --74072 col/06-12-2008/EFR

              --end if;
              i_a:= i_a +1;

         END LOOP;--ciclo para recorrer servicios a activar

   END IF;
   /************* Actualizar clase de servicio ************************/
   --  s_servicios_a    --  servicios que activo  en enroque
   --   s_servicios_d    --  servicios que desactivo
   --   s_servicios_sa   -- servicios que solo activo

   s_cod_servicio_a:= '';
   s_cod_nivel_a:= '';
   cadena_resp:= '';
   n_find:= 0;
   i_a:= 0;

   IF LENGTH(cadena_actual) > 0 THEN
      l_a := LENGTH(cadena_actual)/6;
   ELSE
      l_a:= 0;
   END IF;

   LOOP -- recorro cadena actual
          IF i_a >= l_a THEN
             EXIT;
          END IF;

                  s_cod_servicio_a := SUBSTR(cadena_actual,6*i_a+1,2);
          s_cod_nivel_a := SUBSTR(cadena_actual,6*i_a+1+2,4);
          i_d:= 0;

                  IF LENGTH(s_servicios_a) > 0 THEN
             l_d:= LENGTH(s_servicios_a)/6;
          ELSE
             l_d:= 0;
          END IF;

          LOOP --verifico si tomo en cadena_resp servicio que cambian de nivel
                 n_find:=0;

                                 IF i_d >= l_d THEN
                    EXIT;
                 END IF;

                                 s_cod_servicio_d := SUBSTR(s_servicios_a,6*i_d+1,2);
                 s_cod_nivel_d := SUBSTR(s_servicios_a,6*i_d+1+2,4);

                                 IF s_cod_servicio_a = s_cod_servicio_d THEN
                        n_find:=1;
                        EXIT;
                 END IF;

                                 i_d:= i_d +1;

          END LOOP;

                  IF n_find = 1 THEN
             cadena_resp:= cadena_resp || s_cod_servicio_d || s_cod_nivel_d;
          END IF;

                  i_d:= 0;

                  IF LENGTH(s_servicios_d) > 0 THEN
             l_d:= LENGTH(s_servicios_d)/6;
          ELSE
             l_d:=0;
          END IF;

                  LOOP --verifico si el servicio en cadena_resp no debe ir
             IF i_d >= l_d THEN
                EXIT;
             END IF;

                         s_cod_servicio_d := SUBSTR(s_servicios_d,6*i_d+1,2);
             s_cod_nivel_d := SUBSTR(s_servicios_d,6*i_d+1+2,4);

                         IF s_cod_servicio_a = s_cod_servicio_d THEN
                n_find:=2;
                EXIT;
             END IF;
             i_d:= i_d +1;
          END LOOP;

          IF n_find = 2 THEN
             cadena_resp:= cadena_resp; --ignoro este servicio
          ELSIF n_find = 0 THEN -- el servicio se concerva sin cambios
             cadena_resp:= cadena_resp || s_cod_servicio_a || s_cod_nivel_a;
          END IF;

          i_a:= i_a+1;

   END LOOP;

   cadena_resp:= cadena_resp || s_servicios_sa; --agrego a los nuevos

   IF TABLA = 'GA_ABOCEL' THEN

      LV_Tabla   :='GA_ABOCELI';  --COL-71988|18-10-2008|GEZ
          LV_Accion  :='S';                                     --COL-71988|18-10-2008|GEZ

      UPDATE GA_ABOCEL
      SET clase_servicio = cadena_resp
      WHERE NUM_ABONADO = s_abonado;
   ELSIF TABLA = 'GA_ABOAMIST' THEN

          LV_Tabla   :='GA_ABOAMISTI';  --COL-71988|18-10-2008|GEZ
          LV_Accion  :='S';                                     --COL-71988|18-10-2008|GEZ

      UPDATE GA_ABOAMIST
      SET clase_servicio = cadena_resp
      WHERE NUM_ABONADO = s_abonado;
   END IF;

   --INICIO MODIFICACION - GBM/SOPORTE - 10-11-2005 - XO-200510250955
   V_FECSYS := TO_DATE(TO_CHAR(SYSDATE,'YYYY-DD-MM HH24:MI:SS') , 'YYYY-DD-MM HH24:MI:SS');

   LV_Tabla   :='GA_MODABOCEL';  --COL-71988|18-10-2008|GEZ
   LV_Accion  :='S';                                    --COL-71988|18-10-2008|GEZ

   SELECT COUNT(1)
   INTO NROMODABO
   FROM GA_MODABOCEL
   WHERE NUM_ABONADO = TO_NUMBER(s_abonado)
   AND FEC_MODIFICA=V_FECSYS;

   /************* Actualizar GA_MODABOCEL *************************/
   IF NROMODABO>0 THEN

                   LV_Tabla   :='GA_MODABOCELA';  --COL-71988|18-10-2008|GEZ
                   LV_Accion  :='I';                                    --COL-71988|18-10-2008|GEZ

                   INSERT INTO GA_MODABOCEL
           (NUM_ABONADO, NUM_OS, COD_TIPMODI, FEC_MODIFICA,NOM_USUARORA)
           VALUES
           --(to_number(s_abonado), to_number(s_num_os), 'SS',  sysdate + 1/24/60/60 , LTRIM(RTRIM(s_usuario)));--COL-41023|05-06-2007|PBR
           (TO_NUMBER(s_abonado), TO_NUMBER(s_num_os), 'SS',  V_FECSYS + 1/24/60/60 , LTRIM(RTRIM(s_usuario)));
   ELSE

                   LV_Tabla   :='GA_MODABOCELB';  --COL-71988|18-10-2008|GEZ
                   LV_Accion  :='I';                                    --COL-71988|18-10-2008|GEZ

                   INSERT INTO GA_MODABOCEL
           (NUM_ABONADO, NUM_OS, COD_TIPMODI, FEC_MODIFICA,NOM_USUARORA)
           VALUES
           --(to_number(s_abonado), to_number(s_num_os), 'SS', sysdate, LTRIM(RTRIM(s_usuario)));--COL-41023|05-06-2007|PBR
           (TO_NUMBER(s_abonado), TO_NUMBER(s_num_os), 'SS', V_FECSYS, LTRIM(RTRIM(s_usuario)));
   END IF;

   --INSERT INTO GA_MODABOCEL
   --(NUM_ABONADO, NUM_OS, COD_TIPMODI, FEC_MODIFICA,NOM_USUARORA)
   --VALUES
   --(to_number(s_abonado), to_number(s_num_os), 'SS', sysdate, LTRIM(RTRIM(s_usuario)));
   --FIN MODIFICACION - GBM/SOPORTE - 10-11-2005 - XO-200510250955

   /************* Actualizar PV_MOVMIENTOS ******************/
   --  s_servicios_a    --  servicios que activo  en enroque
   --  s_servicios_d    --  servicios que desactivo
   --  s_servicios_sa   -- servicios que solo activo
   BEGIN

           LV_Tabla   :='PV_MOVIMIENTOS';  --COL-71988|18-10-2008|GEZ
           LV_Accion  :='S';                                    --COL-71988|18-10-2008|GEZ

           SELECT COUNT(*)
       INTO cant_mov
       FROM PV_MOVIMIENTOS
       WHERE NUM_OS = TO_NUMBER(s_num_os);
   EXCEPTION
       WHEN OTHERS THEN
              cant_mov:=0;
   END;

   IF cant_mov > 0 THEN

          LV_Tabla   :='PV_MOVIMIENTOS';  --COL-71988|18-10-2008|GEZ
          LV_Accion  :='U';                                     --COL-71988|18-10-2008|GEZ

          UPDATE PV_MOVIMIENTOS
      SET COD_SERVICIO = s_servicios_a || s_servicios_d ||  s_servicios_sa
      WHERE num_os = TO_NUMBER(s_num_os);

   ELSIF cant_mov = 0 THEN

          LV_Tabla   :='PV_MOVIMIENTOS';  --COL-71988|18-10-2008|GEZ
          LV_Accion  :='I';                                     --COL-71988|18-10-2008|GEZ

          INSERT INTO PV_MOVIMIENTOS (NUM_OS, F_EJECUCION, ORD_COMANDO, COD_ACTABO, COD_SERVICIO, IND_ESTADO, FEC_EXPIRA, RESP_CENTRAL, NUM_MOVIMIENTO)
      VALUES (TO_NUMBER(s_num_os), NULL, 1, 'SS', s_servicios_a || s_servicios_d ||  s_servicios_sa, 1, NULL, NULL, NULL);

   END IF;

   s_error:= 'OK';

EXCEPTION
     WHEN error_parametros THEN
           s_error:= s_error || 'Parametros mal Ingresados';

                   scode_error:= TO_CHAR(SQLCODE);
           sdes_error:= SUBSTR(SQLERRM,1,60);--HD-200312160035-->(CH-261120031531) 30-01-2004,PAGC

                   IF s_abonado IS NOT NULL THEN

                                   --INI COL-71988|18-10-2008|GEZ
                                   /*
                                   INSERT INTO GA_ERRORES
                   (COD_ACTABO,CODIGO              ,FEC_ERROR,COD_PRODUCTO,NOM_PROC          ,NOM_TABLA,COD_ACT,COD_SQLCODE,COD_SQLERRM)
                   VALUES
                   ('SS'      ,TO_NUMBER(s_abonado),SYSDATE  ,1           ,'PV_AD_SERV_SUPLEM',NULL     ,'P'    ,scode_error   ,sdes_error     );
                                   */
                                   P_INSERTA_ERRORES(1,'SS',TO_NUMBER(s_abonado),SYSDATE,'PV_AD_SERV_SUPLEM',LV_Tabla,LV_Accion,scode_error,sdes_error);
                                   --FIN COL-71988|18-10-2008|GEZ

           ELSE
                   s_error:= s_error || ':' || scode_error || ':' || sdes_error;
           END IF;

     WHEN error_consulta THEN
           /*Caso en que el error se debe a que no existen servicios a activar ni a desactivar*/
           s_error:= s_error || 'NO HAY SERVICIOS PARA A/D';

     WHEN NO_DATA_FOUND THEN
           scode_error:= TO_CHAR(SQLCODE);
           sdes_error:= SUBSTR(SQLERRM,1,60);--HD-200312160035-->(CH-261120031531) 30-01-2004,PAGC

                   IF s_abonado IS NOT NULL THEN

                           --INI COL-71988|18-10-2008|GEZ
                           /*INSERT INTO GA_ERRORES
               (COD_ACTABO,CODIGO              ,FEC_ERROR,COD_PRODUCTO,NOM_PROC          ,NOM_TABLA,COD_ACT,COD_SQLCODE,COD_SQLERRM)
               VALUES
               ('SS'      ,TO_NUMBER(s_abonado),SYSDATE  ,1           ,'PV_AD_SERV_SUPLEM',NULL     ,'F'    ,scode_error   ,sdes_error     );
                           */

                           P_INSERTA_ERRORES(1,'SS',TO_NUMBER(s_abonado),SYSDATE,'PV_AD_SERV_SUPLEM',LV_Tabla,LV_Accion,scode_error,sdes_error);

                           --FIN COL-71988|18-10-2008|GEZ

                           s_error:= s_error || ':' || scode_error || ':' || sdes_error;

           ELSE
               s_error:= s_error || ':' || scode_error || ':' || sdes_error;
           END IF;

                   ROLLBACK; --COL-71988|18-10-2008|GEZ

         WHEN OTHERS THEN
           scode_error:= TO_CHAR(SQLCODE);
           sdes_error:= SUBSTR(SQLERRM,1,60);--HD-200312160035-->(CH-261120031531) 30-01-2004,PAGC

                   IF s_abonado IS NOT NULL THEN

                           --FIN COL-71988|18-10-2008|GEZ
                           /*INSERT INTO GA_ERRORES
               (COD_ACTABO,CODIGO              ,FEC_ERROR,COD_PRODUCTO,NOM_PROC          ,NOM_TABLA,COD_ACT,COD_SQLCODE,COD_SQLERRM)
               VALUES
               ('SS'      ,TO_NUMBER(s_abonado),SYSDATE  ,1           ,'PV_AD_SERV_SUPLEM',NULL     ,'F'    ,scode_error   ,sdes_error     );
               */
                           P_INSERTA_ERRORES(1,'SS',TO_NUMBER(s_abonado),SYSDATE,'PV_AD_SERV_SUPLEM',LV_Tabla,LV_Accion,scode_error,sdes_error);

                           --FIN COL-71988|18-10-2008|GEZ

                           s_error:= s_error || ':' || scode_error || ':' || sdes_error;

           ELSE
                s_error:= s_error || ':' || scode_error || ':' || sdes_error;
           END IF;

           ROLLBACK;

END Pv_Pr_Ad_Serv_Suplem;
/
