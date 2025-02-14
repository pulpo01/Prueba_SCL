CREATE OR REPLACE PROCEDURE        P_MODIFICA_ESTADOABOROAVIS
(
  VP_PRODUCTO IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_INDSUSP IN NUMBER ,
  VP_FECSYS IN DATE )
IS
--
-- Procedimiento de actualizacion del estado o situacion en las tablas
-- de abonados/producto en funcion de la actuacion realizada
--
   V_PROCED VARCHAR2(25) := NULL;
BEGIN
   IF VP_PRODUCTO = 1 THEN
         UPDATE GA_ABOROAVIS
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
          WHERE NUM_ABONADO    = VP_ABONADO;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20214,V_PROCED||' '||SQLERRM);
END;
/
SHOW ERRORS
