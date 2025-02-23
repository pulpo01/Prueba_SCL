CREATE OR REPLACE procedure P_CLOSERV_TERMINAL
(
  VP_TRANSACCION IN VARCHAR2 ,
  VP_PRODUCTO IN VARCHAR2 ,
  VP_ABONADO IN VARCHAR2 ,
  VP_TERMINAL IN VARCHAR2 ,
  VP_CENTRAL IN VARCHAR2 ,
  VP_RENT IN VARCHAR2 )
IS
--
-- Procedimiento que realiza el cierre de los servicios marcando
-- fechas de cierre al producirse un cambio de tipo de terminal
-- cuando el servicio no es soportado por el cambio
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
   V_ABONADO GA_ABOCEL.NUM_ABONADO%TYPE;
   V_PRODUCTO ICG_SERVICIOTERCEN.COD_PRODUCTO%TYPE;
   V_PRODUCTO_AUX ICG_SERVICIOTERCEN.COD_PRODUCTO%TYPE;
   V_ESTADO GA_SERVSUPLABO.IND_ESTADO%TYPE;
   CURSOR C1 is
   SELECT ROWID,COD_SERVSUPL,COD_PRODUCTO,IND_ESTADO
     FROM GA_SERVSUPLABO
    WHERE NUM_ABONADO = V_ABONADO;
-- Mejora de performance
--      AND IND_ESTADO = 2
--      AND COD_PRODUCTO = V_PRODUCTO;
   V_ROWID ROWID;
   V_SERVSUPL GA_SERVSUPLABO.COD_SERVSUPL%TYPE;
   VAR1 ICG_SERVICIOTERCEN.COD_SERVICIO%TYPE;
   V_ERROR CHAR(1) := '0';
   V_TRANSAC GA_TRANSACABO.NUM_TRANSACCION%TYPE;
   V_CADENA GA_TRANSACABO.DES_CADENA%TYPE;
   V_CENTRAL GA_ABOCEL.COD_CENTRAL%TYPE;
   V_SISTEMA ICG_SERVICIOTERCEN.COD_SISTEMA%TYPE;
   V_CLASEABO GA_ABOCEL.CLASE_SERVICIO%TYPE;
   V_FECSYS DATE;
   V_RENT NUMBER(1);
   V_CLASE GA_ABOCEL.CLASE_SERVICIO%TYPE;
   V_PERFIL GA_ABOCEL.PERFIL_ABONADO%TYPE;
   V_TECNOLOGIA GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   ERROR_PROCESO EXCEPTION;
BEGIN
   V_PRODUCTO := TO_NUMBER(VP_PRODUCTO);
   V_TRANSAC := TO_NUMBER(VP_TRANSACCION);
   V_CENTRAL := TO_NUMBER(VP_CENTRAL);
   V_ABONADO := TO_NUMBER(VP_ABONADO);
   V_RENT := TO_NUMBER(VP_RENT);
   SELECT COD_SISTEMA,SYSDATE
     INTO V_SISTEMA, V_FECSYS
     FROM ICG_CENTRAL
    WHERE COD_PRODUCTO = V_PRODUCTO
      AND COD_CENTRAL = V_CENTRAL;

    -- RECUPERO TECNOLOGIA
    -- INI TMM_04026
         SELECT COD_TECNOLOGIA
           INTO V_TECNOLOGIA
           FROM AL_ARTICULOS A, AL_TECNOARTICULO_TD B
          WHERE TIP_TERMINAL = VP_TERMINAL
            AND COD_PRODUCTO = V_PRODUCTO
			AND ROWNUM = 1;

        IF V_TECNOLOGIA = '' THEN
           V_ERROR := '4';
           RAISE ERROR_PROCESO;
        END IF;

    -- FIN TMM_04026

-- SELECT SYSDATE INTO V_FECSYS FROM DUAL;
   OPEN C1;
   LOOP
      FETCH C1 INTO V_ROWID,V_SERVSUPL,V_PRODUCTO_AUX,V_ESTADO;
      EXIT WHEN C1%NOTFOUND;
      IF V_PRODUCTO_AUX= V_PRODUCTO AND V_ESTADO=2 THEN
      BEGIN
          -- INI TMM_04026
          SELECT COD_SERVICIO
          INTO VAR1
          FROM ICG_SERVICIOTERCEN
          WHERE COD_PRODUCTO = V_PRODUCTO
          AND COD_SERVICIO = V_SERVSUPL
          AND TIP_TERMINAL = VP_TERMINAL
          AND TIP_TECNOLOGIA = V_TECNOLOGIA
          AND COD_SISTEMA  = V_SISTEMA;
          -- FIN TMM_04026
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
           UPDATE GA_SERVSUPLABO
             SET FEC_BAJABD = SYSDATE,
             IND_ESTADO = 3
           WHERE ROWID = V_ROWID;
           V_CLASEABO := V_CLASEABO||LPAD(V_SERVSUPL,2,0)||'0000';
--           P_CERRAR_SUSPENSION (V_PRODUCTO,V_ABONADO,V_SERVSUPL,V_ERROR);
--           IF V_ERROR <> '0' THEN
--             V_ERROR := '4';
--             RAISE ERROR_PROCESO;
--           END IF;
--           P_BORRA_LOSAS(V_PRODUCTO,V_ABONADO,V_SERVSUPL,V_ERROR);
--           IF V_ERROR <> '0' THEN
--             V_ERROR := '4';
--             RAISE ERROR_PROCESO;
--           END IF;
       WHEN OTHERS THEN
            V_ERROR := '4';
            RAISE ERROR_PROCESO;
       END;
       END IF;
   END LOOP;
   CLOSE C1;
   IF V_CLASEABO IS NOT NULL THEN
      P_RECUPERA_PERFILABO(V_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,
      V_RENT,V_FECSYS);
      P_ACTUALIZA_CLASERV(V_PRODUCTO,V_ABONADO,V_CLASEABO,V_CLASE,
      V_RENT,V_FECSYS,V_ERROR);
      IF V_ERROR <> '0' THEN
         V_ERROR := '4';
         RAISE ERROR_PROCESO;
      END IF;
      V_CADENA := '/'||V_CLASEABO;
   END IF;
   RAISE ERROR_PROCESO;
EXCEPTION
   WHEN ERROR_PROCESO THEN
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,
                                   COD_RETORNO,
                                   DES_CADENA)
                           VALUES (V_TRANSAC,
                                   V_ERROR,
                                   V_CADENA);
   WHEN OTHERS THEN
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,
                                   COD_RETORNO,
                                   DES_CADENA)
                           VALUES (V_TRANSAC,
                                   '4',
                                   V_CADENA);
END;
/
SHOW ERRORS
