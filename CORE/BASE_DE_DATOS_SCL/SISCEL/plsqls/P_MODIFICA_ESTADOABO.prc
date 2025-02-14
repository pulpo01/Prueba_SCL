CREATE OR REPLACE PROCEDURE P_MODIFICA_ESTADOABO(
  VP_PRODUCTO IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_INDSUSP IN NUMBER ,
  VP_RENT IN NUMBER ,
  VP_FECSYS IN DATE ,
  VP_ORIGEN IN NUMBER  DEFAULT 1, -- Parámetro indica desde donde es ejecutado este PL 0:Trigger - 1: P_GA_RESPUESTA
  VP_MODULO IN VARCHAR DEFAULT 'GA') -- Parametor que indica el modulo de origen del mov CO=Cobranza - GA=General
IS
--
-- Procedimiento de actualizacion del estado o situacion en las tablas
-- de abonados/producto en funcion de la actuacion realizada
--
   V_IND_TELE GED_PARAMETROS.VAL_PARAMETRO%TYPE;
   V_PROCED VARCHAR2(25) := NULL;
   V_TIPLAN     TA_PLANTARIF.cod_tiplan%TYPE;
   V_PLANTARIF TA_PLANTARIF.cod_plantarif%TYPE;
   V_bUPTABO   Integer:=1; --1: Actualiza Ga_aboamist - 0: No realiza Actualización de Ga_aboamist
BEGIN
   IF VP_PRODUCTO = 1 THEN

          IF VP_ORIGEN=1 THEN--si viene desde el P_GA_RESPUESTA

                  SELECT COD_PLANTARIF INTO V_PLANTARIF
                  FROM GA_ABOAMIST WHERE NUM_ABONADO = VP_ABONADO
                  UNION
                  SELECT COD_PLANTARIF
                  FROM GA_ABOCEL WHERE NUM_ABONADO = VP_ABONADO;

                  SELECT COD_TIPLAN INTO V_TIPLAN
                  FROM TA_PLANTARIF
                  WHERE COD_PLANTARIF = V_PLANTARIF;

                  IF ( V_TIPLAN = GE_FN_DEVVALPARAM('GA', 1, 'TIP_PLAN_PREPAGO') --Si es prepago
                                OR V_TIPLAN = GE_FN_DEVVALPARAM('GA', 1, 'TIP_PLAN_HIBRIDO')) --Si es hibrido
                                                AND PV_SEQTRXPLATAF_FN(NULL,VP_ABONADO) THEN  -- y plantaforma entrega secuencia
                         V_bUPTABO:=0; --No realizar modificación de situación del abonado --
                  END IF;
          END IF;

          IF VP_MODULO = 'CO' THEN -- SI EL MODULO ES COBRANZA
                 V_bUPTABO:=1; --Realizamos modificación de situación del abonado --
          END IF;

          SELECT VAL_PARAMETRO
          INTO V_IND_TELE
          FROM GED_PARAMETROS
          WHERE NOM_PARAMETRO = 'IND_TELEF_PREPA';

          IF VP_RENT = 0 THEN
         UPDATE GA_ABOCEL
            SET COD_SITUACION  = DECODE(COD_SITUACION,
            -- Inicio modificacion by SAQL/Soporte 28/08/2006 - CO-200608160326
            'CPP','AAA',
            -- Fin modificacion by SAQL/Soporte 28/08/2006 - CO-200608160326
            'CNP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
            'ABP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
            --'RTP',DECODE(VP_INDSUSP,0,'AAA','SAA'),                                                --OCB-INI-TMM_04008
                        'RTP',DECODE(VP_INDSUSP,0,DECODE(V_bUPTABO,1,'AAA',COD_SITUACION)
                                                                   ,NULL,DECODE(V_bUPTABO,1,'AAA',COD_SITUACION) --OCB-INI-TMM_04008
                                                                   ,'SAA'),
            'DEP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
                'RAO','AOA',
                'RAT','ATA',
            'RCV','CVA',
            'RRD','RDA',
            --'STP','SAA',                                                         --OCB-INI-TMM_04008
            'STP',DECODE(V_bUPTABO,1,'SAA',COD_SITUACION), --OCB-INI-TMM_04008  Proy. Fase III Int. SCL - Altamira Dic_2004 HPG (DECODE V_bUPTABO)--
            'ERP','ERA',
            'SAO','AOS',
            'SAT','ATS',
            'SCV','CVS',
            'SRD','RDS',
            'ACP','AAA',
            --'BAP','BAA',                                                                 --OCB-INI-TMM_04008
                        'BAP',DECODE(V_bUPTABO,1,'BAA',COD_SITUACION), --OCB-INI-TMM_04008 Proy. Fase III Int. SCL - Altamira Dic_2004 HPG (DECODE V_bUPTABO)--

            'CSP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
            'REP','REA',
            'TAP','AAA',
            COD_SITUACION)
         WHERE NUM_ABONADO    = VP_ABONADO
                 AND FEC_ACEPVENTA IS NULL;

                  -- PARA CUANDO LA VENTA SE ENCUENTRA ACEPTADA.
         UPDATE GA_ABOCEL
            SET COD_SITUACION  = DECODE(COD_SITUACION,
            -- Inicio modificacion by SAQL/Soporte 28/08/2006 - CO-200608160326
            'CPP','AAA',
            -- Fin modificacion by SAQL/Soporte 28/08/2006 - CO-200608160326
            'CNP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
            'ABP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
            --'RTP',DECODE(VP_INDSUSP,0,'AAA','SAA'),                                                --OCB-INI-TMM_04008
                        'RTP',DECODE(VP_INDSUSP,0,DECODE(V_bUPTABO,1,'AAA',COD_SITUACION)
                                                                   ,NULL,DECODE(V_bUPTABO,1,'AAA',COD_SITUACION) --OCB-INI-TMM_04008
                                                                   ,'SAA'),                                                                      --Proy. Fase III Int. SCL - Altamira Dic_2004 HPG (DECODE V_bUPTABO)--
                        'DEP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
                'RAO','AAA',--'RAO','AOA',
                'RAT','AAA',--'RAT','ATA',
            'RCV','AAA',--'RCV','CVA',
            'RRD','AAA',--'RRD','RDA',
            --'STP','SAA',                                                         --OCB-INI-TMM_04008
            'STP',DECODE(V_bUPTABO,1,'SAA',COD_SITUACION), --OCB-INI-TMM_04008  Proy. Fase III Int. SCL - Altamira Dic_2004 HPG (DECODE V_bUPTABO)--

                        'ERP','ERA',
            'SAO','SAA',--'SAO','AOS',
            'SAT','SAA',--'SAT','ATS',
            'SCV','SAA',--'SCV','CVS',
            'SRD','SAA',--'SRD','RDS',
            'ACP','AAA',
            --'BAP','BAA',                                                                 --OCB-INI-TMM_04008
                        'BAP',DECODE(V_bUPTABO,1,'BAA',COD_SITUACION), --OCB-INI-TMM_04008 Proy. Fase III Int. SCL - Altamira Dic_2004 HPG (DECODE V_bUPTABO)--

            'TAP','AAA', --Homologación HB-071020030056 PAGC. 18-03-2004
            'CSP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
            'REP','REA',
            COD_SITUACION)
         WHERE NUM_ABONADO    = VP_ABONADO
             AND FEC_ACEPVENTA IS NOT NULL;

                 UPDATE GA_ABOAMIST
            SET IND_TELEFONO = V_IND_TELE
            WHERE NUM_ABONADO    = VP_ABONADO
                AND COD_SITUACION    = 'DQP';

                 UPDATE GA_ABOAMIST
            SET COD_SITUACION  = DECODE(COD_SITUACION,
                        'RTP',DECODE(VP_INDSUSP,0,DECODE(V_bUPTABO,1,'AAA',COD_SITUACION)
                                                                   ,NULL,DECODE(V_bUPTABO,1,'AAA',COD_SITUACION) --OCB-INI-TMM_04008
                                                                   ,'SAA'), --Proy. Fase III Int. SCL - Altamira Dic_2004 HPG (DECODE V_bUPTABO)--
                        'CNP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
            'STP',DECODE(V_bUPTABO,1,'SAA',COD_SITUACION), --Proy. Fase III Int. SCL - Altamira Dic_2004 HPG (DECODE V_bUPTABO)--
            'AOP','AAA',
            'BAP',DECODE(V_bUPTABO,1,'BAA',COD_SITUACION), --Proy. Fase III Int. SCL - Altamira Dic_2004 HPG (DECODE V_bUPTABO)--
            --Inicio Modificación: PAGC Inc. MO-091020030146
            'TAP','AAA',
            --Fin modificación: MO-091020030146
            'CSP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
                'BQP',DECODE(V_bUPTABO,1,'BPA',COD_SITUACION), --Proy. Fase III Int. SCL - Altamira Dic_2004 HPG (DECODE V_bUPTABO)--
                'DQP',DECODE(V_bUPTABO,1,'AAA',COD_SITUACION), --Proy. Fase III Int. SCL - Altamira Dic_2004 HPG (DECODE V_bUPTABO)--
                'CPP',DECODE(V_bUPTABO,1,'AAA',COD_SITUACION),
            COD_SITUACION)
         WHERE NUM_ABONADO    = VP_ABONADO;
      ELSE
                 UPDATE GA_ABORENT
            SET COD_SITUACION = DECODE (COD_SITUACION,
                'STP','SAA',
                'RTP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
                'CSP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
                        'CNP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
                COD_SITUACION)
         WHERE NUM_ABONADO = VP_ABONADO
         AND VP_FECSYS BETWEEN FEC_ALTA
         AND FEC_BAJA;
      END IF;
   ELSIF VP_PRODUCTO = 2 THEN
      UPDATE GA_ABOBEEP
         SET COD_SITUACION  = DECODE(COD_SITUACION,
         'CNP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
         'ABP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
         'RTP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
         'RAO','AOA',
         'RAT','ATA',
         'RCV','CVA',
         'RRD','RDA',
         'STP','SAA',
         'SAO','AOS',
         'SAT','ATS',
         'SCV','CVS',
         'SRD','RDS',
         'ACP','AAA',
         'BAP','BAA',
         'CSP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
         'REP','REA',
         COD_SITUACION)
       WHERE NUM_ABONADO = VP_ABONADO;
   ELSIF VP_PRODUCTO = 3 THEN
      UPDATE GA_ABOTRUNK
         SET COD_SITUACION  = DECODE(COD_SITUACION,
         'CNP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
         'ABP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
         'RTP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
         'RAO','AOA',
         'RAT','ATA',
         'RCV','CVA',
         'RRD','RDA',
         'STP','SAA',
         'SAO','AOS',
         'SAT','ATS',
         'SCV','CVS',
         'SRD','RDS',
         'ACP','AAA',
         'BAP','BAA',
         'CSP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
         'REP','REA',
         COD_SITUACION)
       WHERE NUM_ABONADO = VP_ABONADO;
   ELSIF VP_PRODUCTO = 4 THEN
      UPDATE GA_ABOTREK
         SET COD_SITUACION  = DECODE(COD_SITUACION,
         'CNP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
         'ABP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
         'RTP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
         'RAO','AOA',
         'RAT','ATA',
         'RCV','CVA',
         'RRD','RDA',
         'STP','SAA',
         'SAO','AOS',
         'SAT','ATS',
         'SCV','CVS',
         'SRD','RDS',
         'ACP','AAA',
         'BAP','BAA',
         'CSP',DECODE(VP_INDSUSP,0,'AAA','SAA'),
         'REP','REA',
         COD_SITUACION)
       WHERE NUM_ABONADO = VP_ABONADO;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20214,V_PROCED||' '||SQLERRM);
END;
/
SHOW ERRORS
