CREATE OR REPLACE PROCEDURE Al_Actualiza_Stock_Control_PR IS
/*
<NOMBRE>        : Al_Actualiza_Stock_Control_PR</NOMBRE>
<FECHACREA>     : 20/02/2007<FECHACREA/>
<MODULO >       : Logistica </MODULO >
<AUTOR >           : Carlos Contreras A. </AUTOR >
<VERSION >      : 1.0</VERSION >
<DESCRIPCION> : Actualiza al_stock, con datos no procesados por bloqueo </DESCRIPCION>
*/

  CURSOR C_Stock_Control IS
        SELECT  COD_BODEGA, TIP_STOCK, COD_ARTICULO, COD_USO, COD_ESTADO, NUM_DESDE, COD_PLAZA, SUM(Cnt_E) CANTIDAD
        FROM ( SELECT  COD_BODEGA, TIP_STOCK, COD_ARTICULO, COD_USO, COD_ESTADO, NUM_DESDE, COD_PLAZA, SUM(CAN_STOCK) Cnt_E
                                FROM AL_STOCK_CONTROL_TO
                           WHERE IND_ENTSAL = 'E'
                             AND COD_PROCESO = 'P'
                           GROUP BY COD_BODEGA, TIP_STOCK, COD_ARTICULO, COD_USO, COD_ESTADO, NUM_DESDE, COD_PLAZA
               UNION ALL
                   SELECT  COD_BODEGA, TIP_STOCK, COD_ARTICULO, COD_USO, COD_ESTADO, NUM_DESDE, COD_PLAZA, SUM(CAN_STOCK)*-1 Cnt_E
                                FROM AL_STOCK_CONTROL_TO
                           WHERE IND_ENTSAL = 'S'
                             AND COD_PROCESO = 'P'
                           GROUP BY COD_BODEGA, TIP_STOCK, COD_ARTICULO, COD_USO, COD_ESTADO, NUM_DESDE, COD_PLAZA)
        GROUP BY COD_BODEGA, TIP_STOCK, COD_ARTICULO, COD_USO, COD_ESTADO, NUM_DESDE, COD_PLAZA
        HAVING  SUM(Cnt_E) <> 0;

          LN_bodega    AL_STOCK_CONTROL_TO.cod_bodega%type;
          LN_stock     AL_STOCK_CONTROL_TO.tip_stock%type;
          LN_articulo  AL_STOCK_CONTROL_TO.cod_articulo%type;
          LN_uso           AL_STOCK_CONTROL_TO.cod_uso%type;
          LN_estado    AL_STOCK_CONTROL_TO.cod_estado%type;
          LN_desde     AL_STOCK_CONTROL_TO.num_desde%type;
          LV_plaza     AL_STOCK_CONTROL_TO.cod_plaza%type;
          LN_cantidad  NUMBER(9) ;

          LN_cant  al_stock.can_stock%TYPE;
      LN_rowid ROWID;

          No_Actualizado        EXCEPTION;

BEGIN
    --- Marco los registros a procecesar
    UPDATE AL_STOCK_CONTROL_TO
    SET COD_PROCESO = 'P'
        WHERE COD_PROCESO = 'N';

    OPEN C_Stock_Control;
    LOOP
            FETCH C_Stock_Control INTO LN_bodega, LN_stock, LN_articulo, LN_uso, LN_estado, LN_desde, LV_plaza, LN_cantidad ;
        EXIT WHEN C_Stock_Control%NOTFOUND;
        BEGIN
                        SELECT ROWID, can_stock INTO LN_rowid, LN_cant
                FROM al_stock
                WHERE cod_bodega  = LN_bodega
                AND tip_stock     = LN_stock
                AND cod_articulo  = LN_articulo
                AND cod_uso       = LN_uso
                AND cod_estado    = LN_estado
                AND num_desde     = LN_desde
                AND cod_plaza     = LV_plaza
                        FOR UPDATE NOWAIT;

                IF LN_cant < ABS(LN_cantidad) THEN
                                RAISE No_Actualizado;

                ELSIF (LN_cant + LN_cantidad) = 0 THEN
                                BEGIN

                      DELETE al_stock
                      WHERE ROWID = LN_rowid;
                    EXCEPTION
                          WHEN OTHERS THEN
                                        RAISE No_Actualizado;
                                END;

                        ELSE
                                BEGIN
                                        UPDATE al_stock SET can_stock = can_stock + LN_cantidad
                                        WHERE ROWID = LN_rowid;
                                EXCEPTION
                                    WHEN OTHERS THEN
                                    RAISE No_Actualizado;
                                END;

                        END IF;

        EXCEPTION
                    WHEN No_Actualizado THEN
                             UPDATE AL_STOCK_CONTROL_TO SET cod_proceso = 'N'
                              WHERE cod_bodega    = LN_bodega
                                AND tip_stock     = LN_stock
                                AND cod_articulo  = LN_articulo
                                AND cod_uso       = LN_uso
                                AND cod_estado    = LN_estado
                                AND num_desde     = LN_desde
                                AND cod_plaza     = LV_plaza;

            WHEN NO_DATA_FOUND THEN
                INSERT INTO al_stock (cod_bodega, tip_stock, cod_articulo, cod_uso, cod_estado,
                                                                          can_stock, fec_creacion, num_desde, num_hasta, cod_plaza )
                VALUES (LN_bodega,LN_stock,LN_articulo,LN_uso,LN_estado,
                                        LN_cantidad,sysdate,NVL(LN_desde,0),null,LV_plaza  );

            WHEN OTHERS THEN
                             UPDATE AL_STOCK_CONTROL_TO SET cod_proceso = 'N'
                                      WHERE cod_bodega    = LN_bodega
                                        AND tip_stock     = LN_stock
                                        AND cod_articulo  = LN_articulo
                                        AND cod_uso       = LN_uso
                                        AND cod_estado    = LN_estado
                                        AND num_desde     = LN_desde
                                        AND cod_plaza     = LV_plaza;
        END;
        END LOOP;

        CLOSE C_Stock_Control;

        --- Elimino los registros a procesados
    DELETE AL_STOCK_CONTROL_TO  WHERE COD_PROCESO = 'P';

    COMMIT ;
EXCEPTION
     WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20100, 'ERROR EN EJECUCION DE PROCEDIMIENTO' || TO_CHAR(SQLCODE) || ': ' || SQLERRM);
              ROLLBACK ;
END Al_Actualiza_Stock_Control_PR;
/
SHOW ERRORS
