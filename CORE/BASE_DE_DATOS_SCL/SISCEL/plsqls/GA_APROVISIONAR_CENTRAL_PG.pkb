CREATE OR REPLACE PACKAGE BODY SISCEL.GA_APROVISIONAR_CENTRAL_PG AS


PROCEDURE GA_APROVISIONAR_PV_PR( VP_NUMSECUENCIA         IN NUMBER,
                                                             VP_NUMABONADO           IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                                      VP_CODESTADO               IN VARCHAR2,
                                                   VP_CODACTABO               IN GA_ACTABO.COD_ACTABO%TYPE,
                                                      VP_CODMODULO               IN VARCHAR2,
                                                      VP_USUARIO                   IN VARCHAR2,
                                                      VP_FECINGRE               IN VARCHAR2,
                                                      VP_TIPTERMINAL          IN VARCHAR2,
                                                      VP_CODCENTRAL           IN GA_ABOCEL.COD_CENTRAL%TYPE,
                                                      VP_INDBLOQUEO           IN NUMBER,
                                                      VP_TIPTERMINAL_NUE     IN VARCHAR2,
                                                      VP_NUMCELULAR            IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                                      VP_NUMSERIE            IN GA_ABOCEL.NUM_SERIE%TYPE,
                                                      VP_NUMCELULAR_NUE        IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                                      VP_NUMSERIE_NUE        IN GA_ABOCEL.NUM_SERIE%TYPE,
                                                      VP_CODSUSPREHA            IN GA_SUSPREHABO.COD_CAUSUSP%TYPE,
                                                      VP_CODSERVICIOS        IN VARCHAR2,
                                                      VP_NUMMIN                IN GA_ABOCEL.NUM_MIN%TYPE,
                                                      VP_NUMMIN_NUE            IN GA_ABOCEL.NUM_MIN%TYPE,
                                                      VP_TIPTECNOLOGIA        IN ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE,
                                                      VP_IMSI_NUE            IN ICC_MOVIMIENTO.IMSI%TYPE,
                                                      VP_IMEI                IN ICC_MOVIMIENTO.IMEI%TYPE,
                                                      VP_IMEI_NUE            IN ICC_MOVIMIENTO.IMEI%TYPE,
                                                   VP_ICC                        IN ICC_MOVIMIENTO.ICC%TYPE,
                                                      VP_ICC_NUE            IN ICC_MOVIMIENTO.ICC%TYPE,
                                                   VP_CARGA                   IN ICC_MOVIMIENTO.CARGA%TYPE,
                                                   VP_CENTRAL_NUE            IN ICC_MOVIMIENTO.COD_CENTRAL_NUE%TYPE,
                                                   VP_PLAN                IN ICC_MOVIMIENTO.PLAN%TYPE,
                                                   VP_VALORPLAN            IN ICC_MOVIMIENTO.VALOR_PLAN%TYPE,
                                                   VP_NUMMSNB            IN ICC_MOVIMIENTO.NUM_MSNB%TYPE,
                                                      VP_NUMERROR            IN PV_ERRORES_OOSS_TO.COD_ERROR%TYPE,
                                                      VP_NUMOOSS                IN PV_ERRORES_OOSS_TO.NUM_OS%TYPE,
                                                      VP_CODOS                IN PV_ERRORES_OOSS_TO.COD_OS%TYPE
                                                      -- Inicio modificacion by SAQL/Soporte 05/12/2005 - RA-200511170141
                                                      ,VP_NUMMOVANT IN ICC_MOVIMIENTO.NUM_MOVANT%TYPE:=NULL
                                                      -- Fin modificacion by SAQL/Soporte 05/12/2005 - RA-200511170141
)IS


   V_GRP_TECNO_GSM   AL_TECNOLOGIA.COD_GRUPO%TYPE;
   V_GRP_TECNO_DMA   AL_TECNOLOGIA.COD_GRUPO%TYPE;

   V_GRP_TECNOLOGICO AL_TECNOLOGIA.COD_GRUPO%TYPE;
   V_CODACTUACION      GA_ACTABO.COD_ACTCEN%TYPE; -- Actuacion de central
   V_IMSI             ICC_MOVIMIENTO.IMSI%TYPE;
   V_ICC             ICC_MOVIMIENTO.ICC%TYPE;

   VP_SQLCODE   NUMBER(9);
   VP_SQLERRM    VARCHAR2(255);

   v_Formato_Sel2   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
   v_Formato_Sel7   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
   v_Formato_Sel19  GED_PARAMETROS.VAL_PARAMETRO%TYPE;


   VP_ERRORSEV  VARCHAR2(255);
   VP_NEVENTO   NUMBER(9);
   VP_ERRORDES  VARCHAR2(255);

   ERROR_PROCESO EXCEPTION;

BEGIN

     V_GRP_TECNO_GSM := GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_GSM');
     V_GRP_TECNO_DMA := GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_DMA');
      v_Formato_Sel2  := GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL2');
     v_Formato_Sel7  := GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL7');
     v_Formato_Sel19 := GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL19');

     GA_APROVISIONAR_CENTRAL_PG.GA_APROVISIONAR_SRV_PR(VP_NUMSECUENCIA,VP_NUMABONADO,VP_CODESTADO,VP_CODACTABO,VP_CODMODULO,VP_USUARIO,
                            VP_FECINGRE,VP_TIPTERMINAL,VP_CODCENTRAL,VP_INDBLOQUEO,VP_TIPTERMINAL_NUE,
                            VP_NUMCELULAR,VP_NUMSERIE,VP_NUMCELULAR_NUE,VP_NUMSERIE_NUE,VP_CODSUSPREHA,
                            VP_CODSERVICIOS,VP_NUMMIN,VP_NUMMIN_NUE,VP_TIPTECNOLOGIA,VP_IMSI_NUE,
                            VP_IMEI,VP_IMEI_NUE,VP_ICC, VP_ICC_NUE,VP_CARGA,VP_CENTRAL_NUE,VP_PLAN,VP_VALORPLAN,
                            VP_NUMMSNB,
                            VP_ERRORSEV,VP_NEVENTO,VP_ERRORDES
                            -- Inicio modificacion by SAQL/Soporte 05/12/2005 - RA-200511170141
                            ,VP_NUMMOVANT
                            -- Fin modificacion by SAQL/Soporte 05/12/2005 - RA-200511170141
                            );


     --IF VP_NEVENTO > 0 THEN XO-200510190912 PBARRIA 25/10/2005
     --  IF VP_NEVENTO <> 0 THEN --XO-200510190912 PBARRIA 25/10/2005
         BEGIN
            
              INSERT INTO PV_ERRORES_OOSS_TO(NUM_ERROR, NUM_OS, COD_OS, COD_ERROR, GLS_ERROR, NOM_PROC,
                                              FEC_ERROR, NOM_USUARIO)
                                     VALUES(VP_NUMERROR,VP_NUMOOSS,VP_CODOS,VP_NEVENTO,VP_ERRORDES,VP_ERRORSEV,
                                             SYSDATE,USER);

         END;
     /* Inicio XO-200510190912 PBARRIA 25/10/2005 ELSE
          BEGIN
              INSERT INTO PV_ERRORES_OOSS_TO(NUM_ERROR, NUM_OS, COD_OS, COD_ERROR, GLS_ERROR, NOM_PROC,
                                              FEC_ERROR, NOM_USUARIO)
                                     VALUES(VP_NUMERROR,VP_NUMOOSS,VP_CODOS,VP_NEVENTO,VP_ERRORDES,VP_ERRORSEV,
                                             SYSDATE,USER);
          END; Fin XO-200510190912 PBARRIA 25/10/2005 */
     --END IF;





EXCEPTION
    /* Inicio XO-200510190912 PBARRIA 25/10/2005
    WHEN ERROR_PROCESO THEN
            VP_SQLCODE  := SQLCODE;
            VP_SQLERRM     := SQLERRM;

           INSERT INTO PV_ERRORES_OOSS_TO(NUM_ERROR, NUM_OS, COD_OS, COD_ERROR, GLS_ERROR, NOM_PROC,
                                  FEC_ERROR, NOM_USUARIO)
                         VALUES(VP_NUMERROR,VP_NUMOOSS,VP_CODOS,VP_SQLCODE,VP_SQLERRM,'PV_APROVISIONAMIENTO_PR',
                                 SYSDATE,USER); Fin XO-200510190912 PBARRIA 25/10/2005*/

    WHEN OTHERS THEN
            VP_SQLCODE  := SQLCODE;
            VP_SQLERRM     := SQLERRM;

           INSERT INTO PV_ERRORES_OOSS_TO(NUM_ERROR, NUM_OS, COD_OS, COD_ERROR, GLS_ERROR, NOM_PROC,
                                  FEC_ERROR, NOM_USUARIO)
                         VALUES(VP_NUMERROR,VP_NUMOOSS,VP_CODOS,VP_SQLCODE,VP_SQLERRM,'evento'||VP_NEVENTO,
                                 SYSDATE,USER);

END GA_APROVISIONAR_PV_PR;


PROCEDURE GA_APROVISIONAR_SRV_PR( VP_NUMSECUENCIA         IN NUMBER,
                                                             VP_NUMABONADO           IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                                      VP_CODESTADO               IN VARCHAR2,
                                                   VP_CODACTABO               IN GA_ACTABO.COD_ACTABO%TYPE,
                                                      VP_CODMODULO               IN VARCHAR2,
                                                      VP_USUARIO                   IN VARCHAR2,
                                                      VP_FECINGRE               IN VARCHAR2,
                                                      VP_TIPTERMINAL          IN VARCHAR2,
                                                      VP_CODCENTRAL           IN GA_ABOCEL.COD_CENTRAL%TYPE,
                                                      VP_INDBLOQUEO           IN NUMBER,
                                                      VP_TIPTERMINAL_NUE     IN VARCHAR2,
                                                      VP_NUMCELULAR            IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                                      VP_NUMSERIE            IN GA_ABOCEL.NUM_SERIE%TYPE,
                                                      VP_NUMCELULAR_NUE        IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                                      VP_NUMSERIE_NUE        IN GA_ABOCEL.NUM_SERIE%TYPE,
                                                      VP_CODSUSPREHA            IN GA_SUSPREHABO.COD_CAUSUSP%TYPE,
                                                      VP_CODSERVICIOS        IN VARCHAR2,
                                                      VP_NUMMIN                IN GA_ABOCEL.NUM_MIN%TYPE,
                                                      VP_NUMMIN_NUE            IN GA_ABOCEL.NUM_MIN%TYPE,
                                                      VP_TIPTECNOLOGIA        IN ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE,
                                                      VP_IMSI_NUE            IN ICC_MOVIMIENTO.IMSI%TYPE,
                                                      VP_IMEI                IN ICC_MOVIMIENTO.IMEI%TYPE,
                                                      VP_IMEI_NUE            IN ICC_MOVIMIENTO.IMEI%TYPE,
                                                   VP_ICC                        IN ICC_MOVIMIENTO.ICC%TYPE,
                                                      VP_ICC_NUE                   IN ICC_MOVIMIENTO.ICC%TYPE,
                                                   VP_CARGA                   IN ICC_MOVIMIENTO.CARGA%TYPE,
                                                   VP_CENTRAL_NUE            IN ICC_MOVIMIENTO.COD_CENTRAL_NUE%TYPE,
                                                   VP_PLAN                IN ICC_MOVIMIENTO.PLAN%TYPE,
                                                   VP_VALORPLAN            IN ICC_MOVIMIENTO.VALOR_PLAN%TYPE,
                                                   VP_NUMMSNB            IN ICC_MOVIMIENTO.NUM_MSNB%TYPE,
                                                   VP_ERRORSEV            OUT VARCHAR2,
                                                      VP_NEVENTO            OUT NUMBER,
                                                      VP_ERRORDES            OUT VARCHAR2
                                                      -- Inicio modificacion by SAQL/Soporte 05/12/2005 - RA-200511170141
                                                   ,VP_NUMMOVANT IN ICC_MOVIMIENTO.NUM_MOVANT%TYPE:=NULL
                                                   -- Fin modificacion by SAQL/Soporte 05/12/2005 - RA-200511170141
                                                      )
IS


   V_GRP_TECNO_GSM   AL_TECNOLOGIA.COD_GRUPO%TYPE;
   V_GRP_TECNO_DMA   AL_TECNOLOGIA.COD_GRUPO%TYPE;

   V_GRP_TECNOLOGICO AL_TECNOLOGIA.COD_GRUPO%TYPE;
   V_CODACTUACION      GA_ACTABO.COD_ACTCEN%TYPE; -- Actuacion de central
   V_IMSI             ICC_MOVIMIENTO.IMSI%TYPE;
   V_ICC             ICC_MOVIMIENTO.ICC%TYPE;
   V_NUMSERIE         ICC_MOVIMIENTO.NUM_SERIE%TYPE;

   VP_SQLCODE   NUMBER(9);
   VP_SQLERRM    VARCHAR2(255);

   v_Formato_Sel2   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
   v_Formato_Sel7   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
   v_Formato_Sel19  GED_PARAMETROS.VAL_PARAMETRO%TYPE;

   VP_NOMTABLA       VARCHAR2(50);
   sMsgError       VARCHAR2(100);
   VP_FECHA_AUX   VARCHAR2(30); --Modificacion RA-2000511160112 - 17/11/205

   ERROR_PROCESO EXCEPTION;

BEGIN

     V_GRP_TECNO_GSM := GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_GSM');
     V_GRP_TECNO_DMA := GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_DMA');
      v_Formato_Sel2  := GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL2');
     v_Formato_Sel7  := GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL7');
     v_Formato_Sel19 := GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL19');

     /* Sacamos la actuacion en central */
     V_CODACTUACION:=null;
     VP_NOMTABLA := 'SELECT FROM GA_ACTABO...';
     sMsgError := 'No se puede obtener el Codigo de Actuacion en Centrales (Package GA_APROVISIONAR_CENTRAL_PG)';
       SELECT FN_CODACTCEN (1,VP_CODACTABO,VP_CODMODULO,VP_TIPTECNOLOGIA)
       INTO V_CODACTUACION
       FROM DUAL;
       
          
     IF LTRIM(RTRIM(V_CODACTUACION)) = '' THEN
        RAISE ERROR_PROCESO;
     END IF;

     V_NUMSERIE    := VP_NUMSERIE;
     --IF V_NUMSERIE = NULL THEN --Modificacion RA-2000511160112 - 17/11/2005
     IF V_NUMSERIE IS NULL OR TRIM(V_NUMSERIE) IS NULL  THEN --Modificacion RA-200511160112 - 17/11/205
         V_NUMSERIE := VP_ICC;
     END IF;

     /* Calculamos el Imsi y seteamos los demas para el Grupo GSM*/
     IF V_GRP_TECNO_GSM = GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(VP_TIPTECNOLOGIA) THEN
        SELECT FN_RECUPERA_IMSI(V_NUMSERIE)
          INTO V_IMSI
          FROM DUAL;

     ELSE
        V_IMSI := 'NO ENTRO';
     END IF;

     BEGIN
            VP_NOMTABLA := 'INSERT INTO ICC_MOVIMIENTO...';
     -- Inicio Modificacion RA-2000511160112 - 17/11/2005
     VP_FECHA_AUX := TRIM(VP_FECINGRE);
      IF LENGTH(VP_FECHA_AUX)  <= 11 THEN
              VP_FECHA_AUX := VP_FECHA_AUX ||' '||TO_CHAR(SYSDATE,'HH24:MI:SS');
       END IF;
       -- Fin Modificacion RA-2000511160112 - 17/11/2005

            sMsgError := 'No se puedo insertar el movimiento en centrales (Package GA_APROVISIONAR_CENTRAL_PG)';
            
            /*VP_ERRORDES:=VP_NUMSECUENCIA||','||VP_NUMABONADO||','||VP_CODESTADO||','||VP_CODACTABO||','||VP_CODMODULO||','||
                                     V_CODACTUACION||','||VP_CARGA||','||VP_CENTRAL_NUE||','||
                                      VP_USUARIO||','||'fecha'||','||VP_TIPTERMINAL||','||VP_CODCENTRAL||','|| 
                                     VP_INDBLOQUEO||','||VP_TIPTERMINAL_NUE||','||VP_NUMCELULAR||','||
                                     VP_NUMSERIE||','||VP_NUMCELULAR_NUE||','||VP_NUMSERIE_NUE||','||
                                     VP_CODSUSPREHA||','||VP_CODSERVICIOS||','||VP_PLAN||','||VP_VALORPLAN||','||
                                     VP_NUMMIN||','||VP_NUMMIN_NUE||','||VP_NUMMSNB||','||
                                     VP_TIPTECNOLOGIA||','||V_IMSI||','||VP_IMSI_NUE||','||VP_IMEI||','||
                                     VP_IMEI_NUE||','||VP_ICC||','||VP_ICC_NUE
                                     ||','||VP_NUMMOVANT||')';*/--INC 185221 BMR 19-07-2012

         VP_NEVENTO := GE_ERRORES_PG.GRABAR(0, 'GA', null, '1', USER, '', '', 'GA_APROVISIONAR_SRV_PR', 'PV_ERRORES_OOSS_TO', SQLCODE, VP_ERRORDES);

           INSERT INTO ICC_MOVIMIENTO(NUM_MOVIMIENTO, NUM_ABONADO, COD_ESTADO, COD_ACTABO, COD_MODULO,
                                          COD_ACTUACION,CARGA,COD_CENTRAL_NUE,
                                     NOM_USUARORA, FEC_INGRESO, TIP_TERMINAL, COD_CENTRAL,
                                     IND_BLOQUEO, TIP_TERMINAL_NUE, NUM_CELULAR,
                                     NUM_SERIE, NUM_CELULAR_NUE, NUM_SERIE_NUE,
                                     COD_SUSPREHA, COD_SERVICIOS,PLAN,VALOR_PLAN,
                                     NUM_MIN, NUM_MIN_NUE,NUM_MSNB,
                                     TIP_TECNOLOGIA, IMSI, IMSI_NUE, IMEI,
                                     IMEI_NUE, ICC, ICC_NUE
                                     -- Inicio modificacion by SAQL/Soporte 05/12/2005 - RA-200511170141
                                     ,NUM_MOVANT
                                     -- Fin modificacion by SAQL/Soporte 05/12/2005 - RA-200511170141
                                     )
                                 VALUES(VP_NUMSECUENCIA,VP_NUMABONADO,VP_CODESTADO,VP_CODACTABO,VP_CODMODULO,
                                     V_CODACTUACION,VP_CARGA,VP_CENTRAL_NUE,
                                     --VP_USUARIO,to_date(VP_FECINGRE,v_Formato_Sel2 || ' ' || v_Formato_Sel7),VP_TIPTERMINAL,VP_CODCENTRAL, --Modificacion RA-2000511160112 - 17/11/2005
                                     VP_USUARIO,to_date(VP_FECHA_AUX,v_Formato_Sel2 || ' ' || v_Formato_Sel7),VP_TIPTERMINAL,VP_CODCENTRAL, --Modificacion RA-2000511160112 - 17/11/2005
                                     VP_INDBLOQUEO,VP_TIPTERMINAL_NUE,VP_NUMCELULAR,
                                     VP_NUMSERIE,VP_NUMCELULAR_NUE,VP_NUMSERIE_NUE,
                                     VP_CODSUSPREHA,VP_CODSERVICIOS,VP_PLAN,VP_VALORPLAN,
                                     VP_NUMMIN,VP_NUMMIN_NUE,VP_NUMMSNB,
                                     VP_TIPTECNOLOGIA,V_IMSI,VP_IMSI_NUE,VP_IMEI,
                                     VP_IMEI_NUE,VP_ICC,VP_ICC_NUE
                                     -- Inicio modificacion by SAQL/Soporte 05/12/2005 - RA-200511170141
                                     ,VP_NUMMOVANT
                                     -- Fin modificacion by SAQL/Soporte 05/12/2005 - RA-200511170141
                                     );

     END;

     VP_ERRORSEV := 'Verdadero';
     VP_ERRORDES := 'Operacion Exitosa';
     VP_NEVENTO := 0;


EXCEPTION

    WHEN ERROR_PROCESO THEN

         VP_ERRORSEV := 'Falso';
         VP_ERRORDES := 'FN_CODACTCEN ( 1, ' || VP_CODACTABO || ', ' || VP_CODMODULO || ', ' || VP_TIPTECNOLOGIA || ' )' || ' - ' || SQLERRM;
         VP_NEVENTO := GE_ERRORES_PG.GRABAR(0, 'GA', sMsgError, '1', USER, '', '', 'GA_APROVISIONAR_SRV_PR', VP_NOMTABLA, SQLCODE, VP_ERRORDES);

      WHEN OTHERS THEN

         VP_ERRORSEV := 'Falso';
         /*VP_ERRORDES := 'GA_APROVISIONAR_CENTRAL_PG( ' || VP_NUMSECUENCIA || ', ' || VP_NUMABONADO || ', ' || VP_CODESTADO || ', ' || VP_CODACTABO;
         VP_ERRORDES := VP_ERRORDES || ', ' || VP_CODMODULO    || ', ' || VP_USUARIO || ', ' || VP_FECINGRE || ', ' || VP_TIPTERMINAL || ', ' || VP_CODCENTRAL;
         VP_ERRORDES := VP_ERRORDES || ', ' || VP_INDBLOQUEO || ', ' || VP_TIPTERMINAL_NUE || ', ' || VP_NUMCELULAR || ', ' || VP_NUMSERIE || ', ' || VP_NUMCELULAR_NUE;
         VP_ERRORDES := VP_ERRORDES || ', ' || VP_NUMSERIE_NUE || ', ' || VP_CODSUSPREHA || ', ' || VP_CODSERVICIOS || ', ' || VP_NUMMIN || ', ' || VP_NUMMIN_NUE;
         VP_ERRORDES := VP_ERRORDES || ', ' || VP_TIPTECNOLOGIA || ', ' || VP_IMSI_NUE || ', ' || VP_IMEI || ', ' || VP_IMEI_NUE || ', ' || VP_ICC_NUE || ', ' || VP_CARGA;
         VP_ERRORDES := VP_ERRORDES || ', ' || VP_CENTRAL_NUE || ', ' || VP_PLAN || ', ' || VP_VALORPLAN || ', ' || VP_ERRORSEV || ', ' || VP_NEVENTO || ', ' || VP_ERRORDES || ' )' || ' - ' || SQLERRM;
         */
         VP_NEVENTO := GE_ERRORES_PG.GRABAR(0, 'GA', sMsgError, '1', USER, '', '', 'GA_APROVISIONAR_SRV_PR', VP_NOMTABLA, SQLCODE, VP_ERRORDES);


END GA_APROVISIONAR_SRV_PR;


FUNCTION PV_GRUPO_TECNOLOGICO_FN(
vCOD_TECNOLOGIA IN VARCHAR2) RETURN VARCHAR2

IS
-- Funcion que recibe la tecnologia y devuelve el grupo al que pertenece.
-- Fecha : 13-08-2004
-- CEM

   vCOD_GRUPO AL_TECNOLOGIA.COD_GRUPO%type;

BEGIN
   SELECT COD_GRUPO
     INTO vCOD_GRUPO
     FROM AL_TECNOLOGIA
    WHERE COD_TECNOLOGIA=vCOD_TECNOLOGIA;

   RETURN vCOD_GRUPO;

EXCEPTION
WHEN OTHERS THEN
   RETURN 'ERROR';
END PV_GRUPO_TECNOLOGICO_FN;



END GA_APROVISIONAR_CENTRAL_PG;
/
