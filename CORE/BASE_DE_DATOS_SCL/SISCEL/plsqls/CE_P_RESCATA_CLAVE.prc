CREATE OR REPLACE PROCEDURE        CE_P_RESCATA_CLAVE(
  num_atm IN VARCHAR2 ,
  num_oper IN VARCHAR2 ,
  monto IN VARCHAR2 ,
  cod_estado IN VARCHAR2,
  num_clave IN OUT VARCHAR2,
  serie IN OUT VARCHAR2,
  expi IN OUT VARCHAR2)
IS
     p_num_clave    cet_clavedisp.num_clave%TYPE;
     p_serie        cet_clavedisp.num_serie%TYPE;
     p_expi         VARCHAR2(9);
         marca          NUMBER(2);
        CURSOR clave IS
    SELECT NUM_CLAVE , NUM_SERIE,
    TO_CHAR(FEC_EXPIRACION,'YYYYMMDD')
    FROM CET_CLAVEDISP
    WHERE NUM_OPERACION =num_oper
        AND NUM_ATMOPER         =num_atm
        AND COD_ESTADO      ='VP'
        AND MTO_CLAVE       =monto;
ERROR_PROCESO EXCEPTION;
  BEGIN
  marca :=1;
  num_clave := '0001'; -- Codigo para cuando no existen claves disponibles
  UPDATE CET_CLAVEDISP A SET
   A.COD_ESTADO = 'VP',
   A.NUM_ATMOPER=num_atm,
   A.NUM_OPERACION=num_oper,
   A.FEC_TRANSACCION=sysdate
   WHERE
   A.MTO_CLAVE =monto
   AND A.COD_ESTADO='A'
   AND A.NUM_SERIE IN (SELECT MIN(B.NUM_SERIE)
   FROM CET_CLAVEDISP B
   WHERE B.COD_ESTADO='A'
   AND B.MTO_CLAVE=monto);
--BEGIN
        OPEN clave;
        marca :=2;
        LOOP
        FETCH clave INTO num_clave, serie, expi;
        IF clave%NOTFOUND THEN
           IF num_clave IS NULL THEN
                  num_clave := '0001'; -- Codigo para cuando no existen claves disponibles
           END IF;
        END IF;
        EXIT WHEN clave%NOTFOUND;
        END LOOP;
        CLOSE clave;
        marca :=0;
        COMMIT;
    EXCEPTION
              WHEN ERROR_PROCESO THEN
           if marca != 0 then
                num_clave:='0003';
                ROLLBACK;
           end if;
              WHEN OTHERS THEN
                num_clave:='0003';
                ROLLBACK;
 END CE_P_RESCATA_CLAVE;
/
SHOW ERRORS
