CREATE OR REPLACE PROCEDURE        P_RESTAURAR_VENTAS(
  VP_PRODUCTO IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de depuracion de tablas en ventas incompletas de los
-- diferentes productos
--
   V_ROWID ROWID;
   V_ABONADO GA_ABOCEL.NUM_ABONADO%TYPE;
   V_ERROR VARCHAR2(1) := '0';
   V_HOLDING GA_ABOCEL.COD_HOLDING%TYPE;
   V_EMPRESA GA_ABOCEL.COD_EMPRESA%TYPE;
   V_USUARIO GA_ABOCEL.COD_USUARIO%TYPE;
   V_SUBCUENTA GA_ABOCEL.COD_SUBCUENTA%TYPE;
   V_CUENTA GA_ABOCEL.COD_CUENTA%TYPE;
   V_CLIENTE GA_ABOCEL.COD_CLIENTE%TYPE;
   V_VENTA GA_ABOCEL.NUM_VENTA%TYPE;
   CURSOR C1 IS
   SELECT ROWID,
          NUM_ABONADO
     FROM GA_TRANSACVENTA
    WHERE NUM_ABONADO = VP_ABONADO;
   ERROR_PROCESO EXCEPTION;
BEGIN
 OPEN C1;
 LOOP
    BEGIN
       VP_ERROR := '0';
       FETCH C1 INTO V_ROWID,V_ABONADO;
       dbms_output.put_line ('abonado='||to_char(v_abonado));
       dbms_output.put_line ('producto='||to_char(vp_producto));
       EXIT WHEN C1%NOTFOUND;
       P_RECINF_ABONADO (VP_PRODUCTO,V_ABONADO,V_HOLDING,V_EMPRESA,
                         V_VENTA,VP_ERROR);
       IF VP_ERROR <> '0' THEN
   dbms_output.put_line('recinf abonado');
   VP_ERROR := '0';
          RAISE ERROR_PROCESO;
       END IF;
       P_DEL_EQUIPABONOSER (VP_PRODUCTO,V_ABONADO,VP_ERROR);
       IF VP_ERROR <> '0' THEN
   dbms_output.put_line('delete equipabonoser');
   VP_ERROR := '0';
   RAISE ERROR_PROCESO;
       END IF;
       P_DEL_EQUIPABOSER (VP_PRODUCTO,V_ABONADO,VP_ERROR);
       IF VP_ERROR <> '0' THEN
   dbms_output.put_line('delete equipaboser');
   VP_ERROR := '0';
   RAISE ERROR_PROCESO;
       END IF;
       P_DEL_DIASABO (V_ABONADO,VP_ERROR);
       IF V_ERROR <> '0' THEN
   dbms_output.put_line('delete diasabo');
   VP_ERROR := '0';
   RAISE ERROR_PROCESO;
       END IF;
       P_DEL_NUMESPABO (V_ABONADO,VP_ERROR);
       IF V_ERROR <> '0' THEN
   dbms_output.put_line('delete numespabo');
   VP_ERROR := '0';
   RAISE ERROR_PROCESO;
       END IF;
       P_DEL_SERVSUPLABO (V_ABONADO,VP_ERROR);
       IF V_ERROR <> '0' THEN
   dbms_output.put_line('delete servsuplabo');
   VP_ERROR := '0';
   RAISE ERROR_PROCESO;
       END IF;
       P_DEL_SEGURABO (V_ABONADO,VP_ERROR);
       IF V_ERROR <> '0' THEN
   dbms_output.put_line('delete segurabo');
   VP_ERROR := '0';
   RAISE ERROR_PROCESO;
       END IF;
       IF V_HOLDING IS NOT NULL THEN
          P_UPDTE_HOLDING (VP_PRODUCTO,V_HOLDING,VP_ERROR);
       END IF;
       IF V_ERROR <> '0' THEN
   dbms_output.put_line('update holding');
   VP_ERROR := '0';
   RAISE ERROR_PROCESO;
       END IF;
       IF V_EMPRESA IS NOT NULL THEN
          P_UPDTE_EMPRESA (VP_PRODUCTO,V_EMPRESA,VP_ERROR);
       END IF;
       IF V_ERROR <> '0' THEN
   dbms_output.put_line('update empresa');
   VP_ERROR := '0';
   RAISE ERROR_PROCESO;
       END IF;
       P_UPDTE_MOVIMIENTO (VP_PRODUCTO,V_ABONADO,VP_ERROR);
       IF V_ERROR <> '0' THEN
   dbms_output.put_line('update movimiento');
   VP_ERROR := '0';
   RAISE ERROR_PROCESO;
       END IF;
       P_DEL_CARGOS (V_ABONADO,VP_ERROR);
       IF V_ERROR <> '0' THEN
   dbms_output.put_line('delete cargos');
   VP_ERROR := '0';
   RAISE ERROR_PROCESO;
       END IF;
       P_DEL_ABONADOS (VP_PRODUCTO,V_ABONADO,VP_ERROR);
       IF V_ERROR <> '0' THEN
   dbms_output.put_line('delete abonados');
   VP_ERROR := '0';
   RAISE ERROR_PROCESO;
       END IF;
       P_DEL_PETIGUIAS (V_ABONADO,VP_ERROR);
       IF V_ERROR <> '0' THEN
   dbms_output.put_line('delete petiguias');
   VP_ERROR := '0';
   RAISE ERROR_PROCESO;
       END IF;
       P_DEL_VENTAS (V_VENTA,VP_ERROR);
       IF V_ERROR <> '0' THEN
   dbms_output.put_line('delete ventas');
   VP_ERROR := '0';
   RAISE ERROR_PROCESO;
       END IF;
       DELETE GA_TRANSACVENTA WHERE ROWID = V_ROWID;
       COMMIT;
    EXCEPTION
 WHEN ERROR_PROCESO THEN
      ROLLBACK;
        WHEN OTHERS THEN
      ROLLBACK;
    END;
 END LOOP;
 CLOSE C1;
 P_RECUPERA_ARTICULOS(VP_PRODUCTO,VP_ERROR);
       IF V_ERROR <> '0' THEN
   dbms_output.put_line('recupera articulos');
   VP_ERROR := '0';
       END IF;
 COMMIT;
 P_RECUPERA_NUMERACION(VP_PRODUCTO,VP_ERROR);
       IF V_ERROR <> '0' THEN
   dbms_output.put_line('recupera numeracion');
   VP_ERROR := '0';
       END IF;
 COMMIT;
EXCEPTION
   WHEN OTHERS THEN
        NULL;
END;
/
SHOW ERRORS
