CREATE OR REPLACE PROCEDURE VT_VALIDA_AUTENTICACION_PR
(
pTRANSACCION IN ga_transacabo.NUM_TRANSACCION%type,
pNUM_SERIE   IN VARCHAR2,
pPROCEDENCIA IN VARCHAR2,
pCODUSO      IN ga_abocel.COD_USO%type
)
/**********************************************************************************************************************
   NAME:       VT_VALIDA_AUTENTICACION_PR
   PURPOSE:    Procedimiento que ...

   REVISIONS:
   Ver        Date        Author
   ---------  ----------  ---------------
   1.0        09-09-2002   wjrc/ITS
   1.1        25-11-2002   wjrc/ITS
   1.2            29-04-2003   PGonzalez
   PARAMETERS:
   INPUT:
                          pTRANSACCION : numero de transaccion
                          pNUM_SERIE   : numero serie
                          pPROCEDENCIA : procedencia (interna/externa)
                          pCODUSO          : codigo de uso (prepago/postpago)
   OUTPUT:
          sINDAKEYS     : indice AKEYS (0/1)
          iSQLCODE      : codigo de error (0/4)
          sSQLERRM      : mensaje de error, donde :

          sSQLERRM : sINDAKEYS + sACCION + sOperadora + pNUM_SERIE + mensaje

          sINDAKEYS  :indice AKEYS
                      sACCION    : accion a seguir
                      sOperadora : operadora
                      pNUM_SERIE : numero de serie
                      mensaje    : mensaje anexo

   NOTES:
**********************************************************************************************************************/
IS

sSQLERRM       VARCHAR2(1024);
sERROR         VARCHAR2(5);
sOPERADORA     VARCHAR2(3);
sINDAKEYS      VARCHAR2(1);
sNUMSECSERVESP VARCHAR2(99);
sACCION        VARCHAR2(2);
sVALAUTENTIF   VARCHAR2(20);
sVALOR         VARCHAR2(6);

iSQLCODE          INTEGER;
iEXISTE           INTEGER;
iINDAUTENTICACION INTEGER;
iCODUSOAMI                INTEGER;

v_INDUSOVENTA  AL_USOS.IND_USOVENTA%TYPE;
v_CODESTADO    ICT_AKEYS.COD_ESTADO%TYPE;
v_CODDIAESPE   GA_DATOSGENER.COD_DIASESPCEL%TYPE;
v_CODFRIEND    GA_DATOSGENER.COD_FYFCEL%TYPE;

cSERV_SUPLEMENTARIOS CONSTANT VARCHAR2(1) := '2';
cFACTURACION         CONSTANT VARCHAR2(2) := 'FA';
cACCION00            CONSTANT VARCHAR2(2) := '00'; /*  ERROR al grabar en GA_TRANSACABO */
cACCION20            CONSTANT VARCHAR2(2) := '20'; /*  Puerto Rico, HABILITAR */
cACCION21            CONSTANT VARCHAR2(2) := '21'; /*  Puerto Rico, PARAR */
cACCION23            CONSTANT VARCHAR2(2) := '23'; /*  Chile, HABILITAR */
cACCION24            CONSTANT VARCHAR2(2) := '24'; /*  Chile, NADA */

ERROR_PROCESO EXCEPTION;

BEGIN
  sVALOR := '000000';
  sINDAKEYS := '0';
  sSQLERRM := '';
  iSQLCODE := 0;
  iEXISTE := 1;

  /*--- obtenemos operadora ---*/
  iSQLCODE := 4;
  sACCION := cACCION24;
  sSQLERRM := 'Error, al obtener operadora';
  SELECT GE_FN_OPERADORA_SCL
  INTO sOPERADORA
  FROM DUAL;

  /*--- operadora posee autenticacion ---*/
  -- INDICADOR AUTENTIFICACION: 0 : no hay autenticacion
  --                            1 : autentica celular
  --                            2 : autentica amistar
  --                            3 : autentica ambos
  sACCION := cACCION24;
  sSQLERRM := 'Error, indicador de autenticacion';
  SELECT VAL_PARAMETRO
  INTO iINDAUTENTICACION
  FROM GED_PARAMETROS
  WHERE NOM_PARAMETRO = 'OPER_AUTENTICACION';

  sSQLERRM := 'Error, Obtencion Uso Amistar';
  SELECT VAL_PARAMETRO
  INTO iCODUSOAMI
  FROM  GED_PARAMETROS
  WHERE NOM_PARAMETRO = 'USO_PREPAGO'
  AND   COD_MODULO = 'GA'
  AND   COD_PRODUCTO = 1;

  IF (iINDAUTENTICACION = 0) THEN -- No autentica
         iSQLCODE := 0;
         sSQLERRM := 'Operadora no autentica';
  ELSE -- debe autenticar la operadora
     /*-----------------------------------------------------------------------------------------------------------*/
     /* OPERADORA: CHILE */
     /*-----------------------------------------------------------------------------------------------------------*/
     IF (sOPERADORA = 'TMC') THEN

         IF (pPROCEDENCIA = 'E') THEN -- procedencia externa
                        iSQLCODE := 0;
                        sSQLERRM := 'procedencia no corresponde para TMC';
         ELSE -- procedendcia no debe ser externa

                         IF (pCODUSO = iCODUSOAMI) THEN -- codigo de uso amistar
                iSQLCODE := 0;
                                sSQLERRM := 'codigo de uso es amistar para TMC';
             ELSE -- codigo de uso debe no ser amistar

                 /*--- verificamos indice uso asociado al equipo ---*/
                 sSQLERRM := 'Error, al obtener indice asociado al equipo';

                 SELECT B.IND_USOVENTA
                 INTO v_INDUSOVENTA
                 FROM AL_SERIES A, AL_USOS B
                 WHERE A.NUM_SERIE = pNUM_SERIE
                 AND A.COD_USO = B.COD_USO;

                 IF (v_INDUSOVENTA <> 1) THEN
                     iSQLCODE := 0;
                     sSQLERRM := 'Indice uso venta <> 1';
                 ELSE
                 BEGIN /*--- comprobamos en la tabla ICT_AKEYS ---*/
                     SELECT COD_ESTADO
                     INTO v_CODESTADO
                     FROM ICT_AKEYS
                     WHERE NUM_ESN = pNUM_SERIE;

                     EXCEPTION
                     WHEN NO_DATA_FOUND THEN /*--- No existe registro en tabla ICT_AKEYS insertar segun documento para informar a Fraude ---*/
                          iEXISTE := 0;
                          sSQLERRM := 'Error, al insertar en ICT_AKEYS';
                          INSERT INTO ICT_AKEYS
                          (NUM_ESN, ID_CARGA, FEC_ACTUALIZACION, COD_ESTADO)
                          VALUES (pNUM_SERIE,-1, SYSDATE,-1);
                     WHEN OTHERS THEN
                          sSQLERRM := 'Error, al obtener estado en ICT_AKEYS';
                          RAISE ERROR_PROCESO;
                     END;

                     IF (iEXISTE = 1) THEN /*--- registro existe en ICT_AKEYS ---*/
                         IF (v_CODESTADO = -1) THEN /*--- actualizamos fecha de registro ---*/
                                 sSQLERRM := 'Error, al actualizar ICT_AKEYS (estado = -1)';
                                 UPDATE ICT_AKEYS
                                 SET FEC_ACTUALIZACION = SYSDATE
                                 WHERE NUM_ESN = pNUM_SERIE;
                         ELSE /*--- actualizamos fecha de registro y estado ---*/
                             sINDAKEYS := '1';
                                 sSQLERRM := 'Error, al actualizar ICT_AKEYS (estado <> -1)';
                                 UPDATE ICT_AKEYS
                                 SET COD_ESTADO = 1, FEC_ACTUALIZACION = SYSDATE
                                 WHERE NUM_ESN = pNUM_SERIE;
                         END IF;
                     END IF;

                     IF (sINDAKEYS <> '1') THEN
                         iSQLCODE := 0;
                         sSQLERRM := 'Indice AKEYS <> 1';
                     ElSE
                         /*--- obtenemos valor del servicio ---*/
                         sSQLERRM := 'Error, al obtener valor del servicio';

                         SELECT trim(s.cod_servsupl || decode(length(s.cod_nivel),1,'000' || s.cod_nivel,2,'00' || s.cod_nivel))
                         INTO sVALOR
                         FROM ga_servsupl s, ged_parametros p
                         WHERE s.cod_servicio = p.val_parametro
                         AND s.cod_producto = 1
                         AND p.nom_parametro = 'IND_AUTENTICACION';

                         /*--- concadenamos clase de servico con valor servicio ---*/
                         sSQLERRM := 'Error, al actualizar GA_ABOCEL (concadenar clase con valor del servicio)';

                         UPDATE GA_ABOCEL
                         SET CLASE_SERVICIO = nvl(CLASE_SERVICIO,'') || sVALOR
                         WHERE NUM_SERIE = pNUM_SERIE;

                         /*--- valor del parametro para IND_AUTENTICACION ---*/
                         sSQLERRM := 'Error, al obtener valor del parametro para IND_AUTENTICACION';

                         SELECT VAL_PARAMETRO
                         INTO sVALAUTENTIF
                         FROM GED_PARAMETROS
                         WHERE NOM_PARAMETRO = 'IND_AUTENTICACION';

                         /*--- obtenemos ...---*/
                         sSQLERRM := 'Error, al obtener ...';
                         v_CODDIAESPE := '';
                         v_CODFRIEND := '';
                         SELECT COD_DIASESPCEL, COD_FYFCEL
                         INTO v_CODDIAESPE, v_CODFRIEND
                         FROM GA_DATOSGENER;

                         sNUMSECSERVESP := NULL;

                         IF (sVALAUTENTIF = TRIM(v_CODDIAESPE)) OR (sVALAUTENTIF = TRIM(v_CODFRIEND)) THEN
                                 /*--- obtenemos siguiente secuencia...---*/
                                 sSQLERRM := 'Error, al obtener siguiente secuencia...';
                                 SELECT GA_SEQ_NUMDIASNUM.NEXTVAL
                             INTO sNUMSECSERVESP
                             FROM DUAL;
                         END IF;

                         /*--- insertamos el servicio en GA_SERVSUPLABO ---*/
                         sSQLERRM := 'Error, al insertar servicio en GA_SERVSUPLABO';
                         INSERT INTO GA_SERVSUPLABO
                         (NUM_ABONADO,COD_SERVICIO, FEC_ALTABD, COD_SERVSUPL, COD_NIVEL,
                                                  COD_PRODUCTO, NUM_TERMINAL, NOM_USUARORA, COD_CONCEPTO, NUM_DIASNUM)
                         SELECT
                          C.NUM_ABONADO, A.COD_SERVICIO, SYSDATE, A.COD_SERVSUPL, A.COD_NIVEL,
                          A.COD_PRODUCTO, C.NUM_CELULAR, USER, B.COD_CONCEPTO, TRIM(sNUMSECSERVESP)
                         FROM GA_SERVSUPL A, GA_ACTUASERV B, GA_ABOCEL C
                         WHERE C.NUM_SERIE = pNUM_SERIE
                         AND A.COD_PRODUCTO = C.COD_PRODUCTO
                         AND A.COD_SERVICIO = TRIM(sVALAUTENTIF)
                         AND A.COD_PRODUCTO = B.COD_PRODUCTO(+)
                         AND A.COD_SERVICIO = B.COD_SERVICIO(+)
                         AND B.COD_ACTABO(+) = cFACTURACION
                         AND B.COD_TIPSERV(+) = cSERV_SUPLEMENTARIOS;

                         /*--- termino OK ---*/
                         iSQLCODE := 0;
                         sACCION := cACCION23;
                         sSQLERRM := 'Termino OK';
                     END IF;
                 END IF;
             END IF;
         END IF;
     /*-----------------------------------------------------------------------------------------------------------*/
     /* OPERADORA: PUERTO RICO */
     /*-----------------------------------------------------------------------------------------------------------*/
     ELSE
         /*--- comprobamos en la tabla ICT_AKEYS ---*/
         iSQLCODE := 4;
         sACCION := cACCION21;
                 sSQLERRM := 'Error, al obtener estado en ICT_AKEYS';
         BEGIN
                 SELECT COD_ESTADO
         INTO v_CODESTADO
         FROM ICT_AKEYS
         WHERE NUM_ESN = pNUM_SERIE;

             EXCEPTION
         WHEN NO_DATA_FOUND THEN /*--- No existe registro en tabla ICT_AKEYS no realiza la venta ---*/
              iEXISTE := 0;
              sSQLERRM := 'Error, no existe estado en ICT_AKEYS, no puede continuar la venta';
                          RAISE ERROR_PROCESO;
         WHEN OTHERS THEN
              sSQLERRM := 'Error, al obtener estado en ICT_AKEYS';
              RAISE ERROR_PROCESO;
         END;

         sINDAKEYS := '1';

         /*--- obtenemos valor del servicio ---*/
         sSQLERRM := 'Error, al obtener valor del servicio';
         SELECT trim(s.cod_servsupl || decode(length(s.cod_nivel),1,'000' || s.cod_nivel,2,'00' || s.cod_nivel))
         INTO sVALOR
         FROM ga_servsupl s, ged_parametros p
         WHERE s.cod_servicio = p.val_parametro
         AND s.cod_producto = 1
         AND p.nom_parametro = 'IND_AUTENTICACION';

         /*--- concadenamos clase de servico con valor servicio ---*/
         sSQLERRM := 'Error, al actualizar GA_ABOCEL (concadenar clase con valor del servicio)';
         UPDATE GA_ABOCEL
         SET CLASE_SERVICIO = nvl(CLASE_SERVICIO,'') || sVALOR
         WHERE NUM_SERIE = pNUM_SERIE;

         /*--- valor del parametro para IND_AUTENTICACION ---*/
         sSQLERRM := 'Error, al obtener valor del parametro para IND_AUTENTICACION';
         SELECT VAL_PARAMETRO
         INTO sVALAUTENTIF
         FROM GED_PARAMETROS
         WHERE NOM_PARAMETRO = 'IND_AUTENTICACION';

         /*--- obtenemos ...---*/
         sSQLERRM := 'Error, al obtener ...';
         v_CODDIAESPE := '';
         v_CODFRIEND := '';
         SELECT COD_DIASESPCEL, COD_FYFCEL
         INTO v_CODDIAESPE, v_CODFRIEND
         FROM GA_DATOSGENER;

         sNUMSECSERVESP := NULL;

         IF (sVALAUTENTIF = TRIM(v_CODDIAESPE)) OR (sVALAUTENTIF = TRIM(v_CODFRIEND)) THEN
             /*--- obtenemos siguiente secuencia...---*/
             sSQLERRM := 'Error, al obtener siguiente secuencia...';
             SELECT GA_SEQ_NUMDIASNUM.NEXTVAL
             INTO sNUMSECSERVESP
             FROM DUAL;
         END IF;

         /*--- insertamos el servicio en GA_SERVSUPLABO ---*/
         iSQLCODE := 4;
         sACCION := cACCION21;
         sSQLERRM := 'Error, al insertar servicio en GA_SERVSUPLABO';

         INSERT INTO GA_SERVSUPLABO
         (NUM_ABONADO, COD_SERVICIO, FEC_ALTABD, COD_SERVSUPL, COD_NIVEL, COD_PRODUCTO,
          NUM_TERMINAL, NOM_USUARORA, COD_CONCEPTO, NUM_DIASNUM)
         SELECT
          C.NUM_ABONADO, A.COD_SERVICIO, SYSDATE, A.COD_SERVSUPL, A.COD_NIVEL, A.COD_PRODUCTO,
          C.NUM_CELULAR, USER, B.COD_CONCEPTO, TRIM(sNUMSECSERVESP)
         FROM GA_SERVSUPL A, GA_ACTUASERV B, GA_ABOCEL C
         WHERE C.NUM_SERIE = pNUM_SERIE
         AND A.COD_PRODUCTO = C.COD_PRODUCTO
         AND A.COD_SERVICIO = TRIM(sVALAUTENTIF)
         AND A.COD_PRODUCTO = B.COD_PRODUCTO(+)
         AND A.COD_SERVICIO = B.COD_SERVICIO(+)
         AND B.COD_ACTABO(+) = cFACTURACION
         AND B.COD_TIPSERV(+) = cSERV_SUPLEMENTARIOS;

         /*--- termino OK ---*/
         iSQLCODE := 0;
         sACCION := cACCION20;
         sSQLERRM := 'Termino OK';
     END IF;
  END IF;

  /*--- OK: termino normal del procedimiento ---*/
  sSQLERRM := sINDAKEYS || sACCION || sVALOR || sOperadora || '-(SERIE: ' || pNUM_SERIE  || ') '  || sSQLERRM;
  INSERT INTO GA_TRANSACABO
  (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
  VALUES
  (to_number(pTRANSACCION), iSQLCODE, sSQLERRM);



EXCEPTION
  WHEN ERROR_PROCESO THEN /*--- NOK: termino anormal del procedimiento ---*/
     sSQLERRM := sINDAKEYS || sACCION || sVALOR || sOperadora ||'-(SERIE: ' || pNUM_SERIE  || ') ' || sSQLERRM || '(Error: ' || SQLCODE || ' ' || SQLERRM || ')';
     BEGIN
          INSERT INTO GA_TRANSACABO
          (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
          VALUES
          (to_number(pTRANSACCION), iSQLCODE, sSQLERRM);
     END;
  WHEN OTHERS THEN /*--- NOK: termino anormal del procedimiento ---*/
     sSQLERRM := sINDAKEYS || sACCION || sVALOR || sOperadora ||'-(SERIE: ' || pNUM_SERIE  || ') ' || sSQLERRM || '(Error: ' || SQLCODE || ' ' || SQLERRM || ')';
     BEGIN
          INSERT INTO GA_TRANSACABO
          (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
          VALUES
          (to_number(pTRANSACCION), iSQLCODE, sSQLERRM);
     END;
END VT_VALIDA_AUTENTICACION_PR;
/
SHOW ERRORS
