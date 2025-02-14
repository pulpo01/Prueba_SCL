CREATE OR REPLACE PROCEDURE        VE_P_CAMBPLANCOM(
  vp_transac IN VARCHAR2 ,
  vp_calcli IN VARCHAR2 ,
  vp_plan_old IN VARCHAR2 ,
  vp_plan_new IN VARCHAR2 )
IS
v_producto ge_productos.cod_producto%TYPE;
v_cliente ge_clientes.cod_cliente%TYPE;
v_abonado ga_abocel.num_abonado%TYPE;
v_ciclo fa_ciclos.cod_ciclo%TYPE;
v_proc ga_errores.nom_proc%TYPE;
v_tabla ga_errores.nom_tabla%TYPE;
v_action ga_errores.cod_act%TYPE;
v_sqlcode ga_errores.cod_sqlcode%TYPE;
v_sqlerrm ga_errores.cod_sqlerrm%TYPE;
v_error VARCHAR2(1);
CURSOR c_abocel IS
       SELECT  a.COD_CLIENTE, b.NUM_ABONADO, b.COD_CICLO
         FROM  GA_CLIENTE_PCOM a, GA_INTARCEL b, GE_CLIENTES c
        WHERE  c.COD_CALCLIEN = vp_calcli
          AND  a.COD_PLANCOM = vp_plan_old
          AND  a.COD_CLIENTE = b.COD_CLIENTE
          AND  a.COD_CLIENTE = c.COD_CLIENTE
          AND  b.COD_CLIENTE = c.COD_CLIENTE
          AND  SYSDATE BETWEEN b.FEC_DESDE AND b.FEC_HASTA
          AND  SYSDATE BETWEEN a.FEC_DESDE AND NVL(a.FEC_HASTA, SYSDATE);
CURSOR c_abobeep IS
       SELECT  a.COD_CLIENTE, b.NUM_ABONADO, b.COD_CICLO
         FROM  GA_CLIENTE_PCOM a, GA_INTARBEEP b, GE_CLIENTES c
        WHERE  c.COD_CALCLIEN = vp_calcli
          AND  a.COD_PLANCOM = vp_plan_old
          AND  a.COD_CLIENTE = b.COD_CLIENTE
          AND  a.COD_CLIENTE = c.COD_CLIENTE
          AND  b.COD_CLIENTE = c.COD_CLIENTE
          AND  SYSDATE BETWEEN b.FEC_DESDE AND b.FEC_HASTA
          AND  SYSDATE BETWEEN a.FEC_DESDE AND NVL(a.FEC_HASTA, SYSDATE);
CURSOR c_abotrek IS
       SELECT  a.COD_CLIENTE, b.NUM_ABONADO, b.COD_CICLO
         FROM  GA_CLIENTE_PCOM a, GA_INTARTREK b, GE_CLIENTES c
        WHERE  c.COD_CALCLIEN = vp_calcli
          AND  a.COD_PLANCOM = vp_plan_old
          AND  a.COD_CLIENTE = b.COD_CLIENTE
          AND  a.COD_CLIENTE = c.COD_CLIENTE
          AND  b.COD_CLIENTE = c.COD_CLIENTE
          AND  SYSDATE BETWEEN b.FEC_DESDE AND b.FEC_HASTA
          AND  SYSDATE BETWEEN a.FEC_DESDE AND NVL(a.FEC_HASTA, SYSDATE);
CURSOR c_abotrunk IS
       SELECT  a.COD_CLIENTE, b.NUM_ABONADO, b.COD_CICLO
         FROM  GA_CLIENTE_PCOM a, GA_INTARTRUNK b, GE_CLIENTES c
        WHERE  c.COD_CALCLIEN = vp_calcli
          AND  a.COD_PLANCOM = vp_plan_old
          AND  a.COD_CLIENTE = b.COD_CLIENTE
          AND  a.COD_CLIENTE = c.COD_CLIENTE
          AND  b.COD_CLIENTE = c.COD_CLIENTE
          AND  SYSDATE BETWEEN b.FEC_DESDE AND b.FEC_HASTA
          AND  SYSDATE BETWEEN a.FEC_DESDE AND NVL(a.FEC_HASTA, SYSDATE);
BEGIN
   v_error := '0';
   /* Cambio de Plan Comercial para abonados de CELULAR */
   IF v_error <> '4' THEN
      OPEN c_abocel;
      v_producto := 1;
      LOOP
         FETCH  c_abocel
          INTO  v_cliente, v_abonado, v_ciclo;
         EXIT WHEN c_abocel%NOTFOUND;
         P_CAMBIO_PLANCOM (v_producto,
                           v_cliente,
                           v_abonado,
                           vp_plan_new,
                           v_ciclo,
                           SYSDATE,
      v_proc,
      v_tabla,
      v_action,
      v_sqlcode,
      v_sqlerrm,
                           v_error);
         IF v_error = '4' THEN
            EXIT;
         END IF;
      END LOOP;
      CLOSE c_abocel;
   END IF;
   /* Cambio de Plan Comercial para abonados de BEEPER */
   IF v_error <> '4' THEN
      OPEN c_abobeep;
      v_producto := 2;
      LOOP
         FETCH  c_abobeep
          INTO  v_cliente, v_abonado, v_ciclo;
         EXIT WHEN c_abobeep%NOTFOUND;
         P_CAMBIO_PLANCOM (v_producto,
                           v_cliente,
                           v_abonado,
                           vp_plan_new,
                           v_ciclo,
                           SYSDATE,
      v_proc,
      v_tabla,
      v_action,
      v_sqlcode,
      v_sqlerrm,
                           v_error);
         IF v_error = '4' THEN
            EXIT;
         END IF;
      END LOOP;
      CLOSE c_abobeep;
   END IF;
   /* Cambio de Plan Comercial para abonados de TREK */
   IF v_error <> '4' THEN
      OPEN c_abotrek;
      v_producto := 4;
      LOOP
         FETCH  c_abotrek
          INTO  v_cliente, v_abonado, v_ciclo;
         EXIT WHEN c_abotrek%NOTFOUND;
         P_CAMBIO_PLANCOM (v_producto,
                           v_cliente,
                           v_abonado,
                           vp_plan_new,
                           v_ciclo,
                           SYSDATE,
      v_proc,
      v_tabla,
      v_action,
      v_sqlcode,
      v_sqlerrm,
                           v_error);
         IF v_error = '4'THEN
            EXIT;
         END IF;
      END LOOP;
      CLOSE c_abotrek;
   END IF;
   /* Cambio de Plan Comercial para abonados de TRUNKING */
   IF v_error <> '4' THEN
      OPEN c_abotrunk;
      v_producto := 3;
      LOOP
         FETCH  c_abotrunk
          INTO  v_cliente, v_abonado, v_ciclo;
         EXIT WHEN c_abotrunk%NOTFOUND;
         P_CAMBIO_PLANCOM (v_producto,
                           v_cliente,
                           v_abonado,
                           vp_plan_new,
                           v_ciclo,
                           SYSDATE,
      v_proc,
      v_tabla,
      v_action,
      v_sqlcode,
      v_sqlerrm,
                           v_error);
         IF v_error = '4' THEN
            EXIT;
         END IF;
      END LOOP;
      CLOSE c_abotrunk;
   END IF;
   INSERT INTO
   GA_TRANSACABO  (NUM_TRANSACCION,
                  COD_RETORNO,
                  DES_CADENA)
          VALUES  (vp_transac,
                  v_error,
                  v_producto || '@' || v_cliente || '@' || v_abonado || '@');
END;
/
SHOW ERRORS
