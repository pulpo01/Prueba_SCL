CREATE OR REPLACE PROCEDURE        PP_RESRECVTA_HABSUS_ABO
(
pTRANSACCION IN ga_transacabo.NUM_TRANSACCION%type,
pNumVenta    IN VARCHAR2,
pCodCliente  IN VARCHAR2,
pAccion      IN VARCHAR2)
/**********************************************************************************************************************
   NAME:       PP_RESRECVTA_HABSUS_ABO
   PURPOSE:    Procedimiento que ...

   REVISIONS:
   Ver        Date        Author
   ---------  ----------  ---------------
   1.0        25-09-2002   ITS - wjrc
   1.1        05-11-2002   ITS - wjrc
   1.2        08-11-2002   ITS - wjrc

   PARAMETERS:
   INPUT:
                          pCodCliente  : codigo del cliente al que se habilitaran/suspenderan los abonados
                          pAccion          : accion a relizar (0: Habilitar/ 1:Suspender)
   OUTPUT:
                  iSQLCODE      : codigo de error (0/4)
          sSQLERRM      : mensaje que describe ejecucion del procedre


   NOTES:
**********************************************************************************************************************/
IS
   CURSOR cCursorAbonados is
                        select num_abonado
                        from ga_abocel
                        where num_venta = pNumVenta
                        and cod_cliente = pCodCliente
						union
						select num_abonado
                        from ga_aboamist
                        where num_venta = pNumVenta
                        and cod_cliente = pCodCliente;

iSQLCODE     INTEGER;
sSQLERRM     VARCHAR2(1024);
nNUMABONADO  NUMBER(8);
sVALOR       VARCHAR2(20);

ERROR_PROCESO EXCEPTION;

BEGIN

     /*
     SELECT trim(val_parametro)
     INTO sVALOR
     FROM ged_parametros
     WHERE nom_parametro = 'USUARIO_PL_RECHAZO';
     */

         OPEN cCursorAbonados;
         LOOP
                 iSQLCODE :=  0;
             sSQLERRM := 'INICIANDO PROCESO...';

             FETCH cCursorAbonados
                 INTO nNUMABONADO;

             EXIT WHEN cCursorAbonados%NOTFOUND;

                 IF (pAccion = '0') THEN
                         PV_PR_REHASUSPENSION(nNUMABONADO,USER,iSQLCODE,sSQLERRM);
                 ELSE
                         PV_PR_SUSPENSION(nNUMABONADO,USER,iSQLCODE,sSQLERRM);
                 END IF;

         -- SI FALLA AUNQUE SOLO SEA EN UNO NOS SALIMOS
         IF iSQLCODE > 0 THEN
            RAISE ERROR_PROCESO;
         END IF;

         END LOOP;
     CLOSE cCursorAbonados;

     /*--- OK: termino normal del procedimiento ---*/
     iSQLCODE :=  0;
         sSQLERRM:= 'PROCESO FINALIZADO OK....';

     INSERT INTO GA_TRANSACABO
     (NUM_TRANSACCION,
      COD_RETORNO,
      DES_CADENA)
     VALUES
     (to_number(pTRANSACCION),
      iSQLCODE,
      sSQLERRM);

EXCEPTION
   WHEN ERROR_PROCESO THEN
        sSQLERRM := 'PROCESO FINALIZADO CON ERROR...' || sSQLERRM || ' ' || iSQLCODE;
        iSQLCODE := 4;

        BEGIN
            INSERT INTO GA_TRANSACABO
            (NUM_TRANSACCION,
             COD_RETORNO,
             DES_CADENA)
            VALUES
            (to_number(pTRANSACCION),
             iSQLCODE,
             sSQLERRM);
       END;

   WHEN OTHERS THEN
        sSQLERRM := 'PROCESO FINALIZADO CON ERROR...' || sSQLERRM || ' ' || iSQLCODE;
        iSQLCODE := 4;

        BEGIN
            INSERT INTO GA_TRANSACABO
            (NUM_TRANSACCION,
             COD_RETORNO,
             DES_CADENA)
            VALUES
            (to_number(pTRANSACCION),
             iSQLCODE,
             sSQLERRM);
       END;

END PP_RESRECVTA_HABSUS_ABO;
/
SHOW ERRORS
