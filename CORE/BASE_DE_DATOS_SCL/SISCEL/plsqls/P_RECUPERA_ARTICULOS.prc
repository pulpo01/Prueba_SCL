CREATE OR REPLACE procedure P_RECUPERA_ARTICULOS
(
  VP_PRODUCTO IN NUMBER ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento de recuperacion de articulos reservados en ventas incompletas
--
   V_ESTORIG AL_MOVIMIENTOS.COD_ESTADO%TYPE;
   V_TIPMOVRES AL_MOVIMIENTOS.TIP_MOVIMIENTO%TYPE;
   V_ROWID ROWID;
   V_ARTICULO GA_RESERVART.COD_ARTICULO%TYPE;
   V_UNIDADES GA_RESERVART.NUM_UNIDADES%TYPE;
   V_PRODUCTO GA_RESERVART.COD_PRODUCTO%TYPE;
   V_BODEGA   GA_RESERVART.COD_BODEGA%TYPE;
   V_STOCK    GA_RESERVART.TIP_STOCK%TYPE;
   V_SERIE    GA_RESERVART.NUM_SERIE%TYPE;
   V_CELULAR  GA_ABOCEL.NUM_CELULAR%TYPE;
   V_ABONADO  GA_ABOCEL.NUM_ABONADO%TYPE;
   V_USO      GA_RESERVART.COD_USO%TYPE;
   V_ESTADO   GA_RESERVART.COD_ESTADO%TYPE;
   V_ESTADO_SERIE  GA_RESERVART.COD_ESTADO%TYPE;
   V_MOVIMIENTO AL_MOVIMIENTOS.NUM_MOVIMIENTO%TYPE;
   V_CAPCODE  GA_RESERVART.CAP_CODE%TYPE;
   V_TRANSAC GA_TRANSACABO.NUM_TRANSACCION%TYPE;
   V_RETORNO GA_TRANSACABO.COD_RETORNO%TYPE;
   V_CADENA GA_TRANSACABO.DES_CADENA%TYPE;
   V_OPERACION_ALMACEN NUMBER(1);
   V_SITUACION GA_ABOCEL.COD_SITUACION%TYPE;
   VP_ESTADO ICC_MOVIMIENTO.COD_ESTADO%TYPE;
   V_VENTA GA_ABOCEL.NUM_VENTA%TYPE;
--Inicio Tratamiento Homologacion HB-200312030237 Benjamin Franulic 16/11/2003
   V_EXISTE_SERIE NUMBER(2);
--Fin Tratamiento Homologacion HB-200312030237 Benjamin Franulic 16/11/2003

   CURSOR C1 IS
   SELECT ROWID,COD_ARTICULO,COD_PRODUCTO,
          COD_BODEGA,TIP_STOCK,COD_USO,
          COD_ESTADO,NUM_UNIDADES,NUM_SERIE,
          CAP_CODE
     FROM GA_RESERVART
    WHERE COD_PRODUCTO = VP_PRODUCTO
    AND TRUNC(FEC_RESERVA)<= SYSDATE -1;
BEGIN
    OPEN C1;
    LOOP
      BEGIN
         V_SITUACION:=' ';
         FETCH C1 INTO V_ROWID,V_ARTICULO,V_PRODUCTO,
                       V_BODEGA,V_STOCK,V_USO,
                       V_ESTADO,V_UNIDADES,V_SERIE,
                       V_CAPCODE;
         EXIT WHEN C1%NOTFOUND;
         -- Consultando Estado de ABOCEL , si este es <> 'TVP',
         -- se debe efectuar una salida definitiva.
         V_OPERACION_ALMACEN:=5;  -- anula reserva venta
         IF V_PRODUCTO='1' THEN
         BEGIN
           SELECT COD_SITUACION,NUM_CELULAR,NUM_ABONADO,NUM_VENTA
           INTO V_SITUACION,V_CELULAR,V_ABONADO,V_VENTA
           FROM GA_ABOCEL
           WHERE NUM_SERIE=V_SERIE
           AND COD_SITUACION NOT IN ('BAA','BAP');
           IF V_SITUACION = 'AOP' OR V_SITUACION='ATP' THEN
             P_CONSULTA_MOVIMIENTO_AL(V_CELULAR,VP_ESTADO,V_MOVIMIENTO,VP_ERROR);
             IF VP_ERROR ='0' THEN
               -- encontro movimiento
               IF VP_ESTADO=9 THEN
                 P_DES_VENTA(V_VENTA,VP_ERROR);                          -- anula venta
               ELSIF VP_ESTADO=1 THEN
                 P_DES_VENTA(V_VENTA,VP_ERROR);
                 P_DES_MOVIMIENTO(V_ABONADO,V_MOVIMIENTO,VP_ERROR);          -- cancela mov
               END IF;
               V_OPERACION_ALMACEN:=5;                                  -- elimina reserva serie
             ELSIF VP_ERROR='1' THEN
                -- no encontro movimiento
                P_DEL_RESERVANUMERO(V_ABONADO,VP_ERROR);                  -- elimina reserva numero
                V_OPERACION_ALMACEN:=1;                                   -- salida definitiva
             END IF;
           ELSIF V_SITUACION='AOA' OR V_SITUACION='AAA' OR V_SITUACION='ATA' THEN
               V_OPERACION_ALMACEN:=1;
           END IF;
         EXCEPTION
           WHEN NO_DATA_FOUND THEN
             V_OPERACION_ALMACEN:=5;
         END;
         END IF;
         SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO V_TRANSAC FROM DUAL;
         -- recuperando uso desde almacen para reponerla, si no
         -- existe implica que salio mediante salida definitiva
         -- por ello se elimina, si estado != 7 entonces, ya se
         -- recuperado.
         BEGIN
           SELECT COD_USO,COD_ESTADO
           INTO V_USO,V_ESTADO_SERIE
           FROM AL_SERIES
           WHERE NUM_SERIE=V_SERIE;
         EXCEPTION
           When no_data_found Then
             DELETE GA_RESERVART WHERE ROWID = V_ROWID;
         END;
         IF V_ESTADO_SERIE=7 THEN
           IF V_OPERACION_ALMACEN=5 THEN
              P_GA_INTERAL (V_TRANSAC,V_OPERACION_ALMACEN,V_STOCK,V_BODEGA,V_ARTICULO,
              V_USO,V_ESTADO,NULL,V_UNIDADES,V_SERIE,1);
           ELSIF V_OPERACION_ALMACEN=1 THEN
              P_GA_INTERAL (V_TRANSAC,V_OPERACION_ALMACEN,V_STOCK,V_BODEGA,V_ARTICULO,
              V_USO,V_ESTADO,V_VENTA,V_UNIDADES,V_SERIE,1);
            END IF;
           SELECT COD_RETORNO,DES_CADENA
           INTO V_RETORNO,V_CADENA
           FROM GA_TRANSACABO
           WHERE NUM_TRANSACCION = V_TRANSAC;
           IF V_RETORNO = 0 THEN
              DELETE GA_RESERVART WHERE ROWID = V_ROWID;
-- Inicio Tratamiento Homologacion HB-200312030237 Benjamin Franulic 16/11/2003
           ELSE
		  -- SE COMPRUEBA QUE NO EXISTA EN AL_SERIES PARA BORRAR
		  SELECT COUNT(NUM_SERIE)
		  INTO V_EXISTE_SERIE
		  FROM AL_SERIES WHERE NUM_SERIE = V_SERIE;
		  IF V_EXISTE_SERIE = 0 THEN
		     DELETE GA_RESERVART WHERE ROWID = V_ROWID;
		  END IF;
-- Fin Tratamiento Homologacion HB-200312030237 Benjamin Franulic 16/11/2003
           END IF;
           DELETE GA_TRANSACABO WHERE NUM_TRANSACCION = V_TRANSAC;
         ELSE
             DELETE GA_RESERVART WHERE ROWID = V_ROWID;
         END IF;
         COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
           ROLLBACK;
        END;
      END LOOP;
    CLOSE C1;
EXCEPTION
   WHEN OTHERS THEN
        NULL;
END;
/
SHOW ERRORS
