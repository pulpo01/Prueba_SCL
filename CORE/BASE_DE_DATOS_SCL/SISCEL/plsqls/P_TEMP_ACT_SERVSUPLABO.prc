CREATE OR REPLACE PROCEDURE        P_TEMP_ACT_SERVSUPLABO
 IS  CURSOR cCursorGA_SERVSUPLABO is
        SELECT MAX(B.FEC_ALTABD), b.num_abonado, b.cod_servicio
    FROM GA_SERVSUPLABO B where ind_estado = 5
        group by b.num_abonado, b.cod_servicio
        having count(*) > 1;

        v_num_abonado     GA_SERVSUPLABO.NUM_ABONADO%TYPE;
    v_cod_servicio    GA_SERVSUPLABO.COD_SERVICIO%TYPE;
    v_fec_altabd      GA_SERVSUPLABO.FEC_ALTABD%TYPE;

    iSQLCODE     INTEGER;
    sSQLERRM     VARCHAR2(1024);
    sConteo       VARCHAR2(20);
    nNUMABONADO  NUMBER(8);

ERROR_PROCESO EXCEPTION;

BEGIN

     sconteo:=0;
         OPEN cCursorGA_SERVSUPLABO;
         LOOP
                 iSQLCODE :=  0;
             sSQLERRM := 'INICIANDO PROCESO...';

             FETCH cCursorGA_SERVSUPLABO
                 INTO v_fec_altabd, v_num_abonado, v_cod_servicio;

             EXIT WHEN cCursorGA_SERVSUPLABO%NOTFOUND;

         UPDATE GA_SERVSUPLABO A SET A.IND_ESTADO = 4
                 where fec_altabd <> v_fec_altabd
                 and cod_servicio = v_cod_servicio
                 and num_abonado = v_num_abonado
                 and ind_estado = 5;

                 IF (sconteo < 1000 ) THEN
                         sconteo := sconteo + 1;
                         commit;
                 else
                     sconteo:=0;
                 END IF;

         -- SI FALLA AUNQUE SOLO SEA EN UNO NOS SALIMOS

         IF iSQLCODE > 0 THEN
            RAISE ERROR_PROCESO;
         END IF;

         END LOOP;
     CLOSE cCursorGA_SERVSUPLABO;

     /*--- OK: termino normal del procedimiento ---*/
     iSQLCODE :=  0;
         sSQLERRM:= 'PROCESO FINALIZADO OK....';

EXCEPTION
   WHEN ERROR_PROCESO THEN
        sSQLERRM := 'PROCESO FINALIZADO CON ERROR...' || sSQLERRM || ' ' || iSQLCODE;
        iSQLCODE := 4;

END P_TEMP_ACT_SERVSUPLABO;
/
SHOW ERRORS
