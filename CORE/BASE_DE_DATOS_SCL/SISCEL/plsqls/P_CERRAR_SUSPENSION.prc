CREATE OR REPLACE PROCEDURE        P_CERRAR_SUSPENSION(
  VP_PRODUCTO IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_SERVSUPL IN VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de actualizacion de tabla de abonados a facturar en ciclo
-- a un nuevo ciclo
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; El cambio se ha realizado correctamente
--         - "4" ; Error en el proceso
--
   CURSOR CSUSP IS
   SELECT ROWID
     FROM GA_SUSPREHABO
    WHERE NUM_ABONADO = VP_ABONADO
      AND COD_SERVSUPL = VP_SERVSUPL
      AND COD_PRODUCTO = VP_PRODUCTO
      AND TIP_REGISTRO < 3;
   V_ROWID ROWID;
BEGIN
    OPEN CSUSP;
    LOOP
       FETCH CSUSP INTO V_ROWID;
       EXIT WHEN CSUSP%NOTFOUND;
       UPDATE GA_SUSPREHABO
          SET TIP_REGISTRO = 4,
       FEC_REHABD = SYSDATE,
       FEC_REHACEN = SYSDATE
        WHERE ROWID = V_ROWID;
       P_HISTORICO_SUSPENSIONES(V_ROWID,SYSDATE);
    END LOOP;
    CLOSE CSUSP;
EXCEPTION
   WHEN OTHERS THEN
        VP_ERROR := '4';
END;
/
SHOW ERRORS
