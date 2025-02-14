CREATE OR REPLACE PROCEDURE        P_AL_CONS_STOCK (VP_COD_BODEGA IN AL_STOCK.COD_BODEGA%TYPE,
                                                   VP_TIP_STOCK IN AL_STOCK.TIP_STOCK%TYPE,
                                                   VP_COD_ARTICULO IN AL_STOCK.COD_ARTICULO%TYPE,
                                                   VP_COD_USO IN AL_STOCK.COD_USO%TYPE,
                                                   VP_COD_ESTADO IN AL_STOCK.COD_ESTADO%TYPE,
                                                   V_TOTAL_STOCK IN OUT AL_STOCK.CAN_STOCK%TYPE,
                                                   V_ERR IN OUT NUMBER ) is
 V_TOTAL_BODEGA       NUMBER;
 V_TOTAL_TIPO_STOCK   NUMBER;
 V_TOTAL_ARTICULO     NUMBER;
 V_TOTAL_USO          NUMBER;
 V_TOTAL_ESTADO       NUMBER;
 EXCEPTION_BODEGA exception;
 EXCEPTION_TIPOSTOCK exception;
 EXCEPTION_ARTICULO exception;
 EXCEPTION_USO exception;
 EXCEPTION_ESTADO exception;
BEGIN
-- inicializa variables
 V_TOTAL_BODEGA := 0;
 V_TOTAL_TIPO_STOCK := 0;
 V_TOTAL_ARTICULO := 0;
 V_TOTAL_USO := 0;
 V_TOTAL_ESTADO := 0;
 V_TOTAL_STOCK := 0;
   -- Verifica la existencia de la bodega
        SELECT COUNT(COD_BODEGA) INTO V_TOTAL_BODEGA FROM AL_BODEGAS WHERE
        COD_BODEGA = VP_COD_BODEGA;
        IF V_TOTAL_BODEGA = 0 THEN
           raise EXCEPTION_BODEGA;
        END IF;
   -- Verifica la existencia de tipo de stock
        SELECT COUNT(TIP_STOCK) INTO V_TOTAL_TIPO_STOCK FROM AL_TIPOS_STOCK WHERE
        TIP_STOCK = VP_TIP_STOCK;
        IF V_TOTAL_TIPO_STOCK = 0 THEN
           raise EXCEPTION_TIPOSTOCK;
        END IF;
   -- Verifica la existencia de articulo
        SELECT COUNT(COD_ARTICULO) INTO V_TOTAL_ARTICULO FROM AL_ARTICULOS WHERE
        COD_ARTICULO = VP_COD_ARTICULO;
        IF V_TOTAL_ARTICULO = 0 THEN
           raise EXCEPTION_ARTICULO;
        END IF;
   -- Verifica la existencia de uso
        SELECT COUNT(COD_USO) INTO V_TOTAL_USO FROM AL_USOS WHERE
        COD_USO = VP_COD_USO;
        IF V_TOTAL_USO = 0 THEN
           raise EXCEPTION_USO;
        END IF;
   -- Verifica la existencia de estado
        SELECT COUNT(COD_ESTADO) INTO V_TOTAL_ESTADO FROM AL_ESTADOS WHERE
        COD_ESTADO = VP_COD_ESTADO;
        IF V_TOTAL_ESTADO = 0 THEN
           raise EXCEPTION_ESTADO;
        END IF;
   -- Busco el total de stock existente en almacen al_stock
        SELECT CAN_STOCK INTO V_TOTAL_STOCK FROM AL_STOCK WHERE
        COD_BODEGA=VP_COD_BODEGA AND
        TIP_STOCK = VP_TIP_STOCK AND
        COD_ARTICULO = VP_COD_ARTICULO AND
        COD_USO = VP_COD_USO AND
        COD_ESTADO = VP_COD_ESTADO;
EXCEPTION
                when EXCEPTION_BODEGA then
                     V_ERR:= 1;
                when EXCEPTION_TIPOSTOCK then
                     V_ERR:= 2;
                when EXCEPTION_ARTICULO then
                     V_ERR:= 3;
                when EXCEPTION_USO then
                     V_ERR:= 4;
                when EXCEPTION_ESTADO then
                     V_ERR:= 5;
                when NO_DATA_FOUND THEN
                     NULL;
                when OTHERS then
                     V_ERR:= SQLCODE;
                     raise;
END;
/
SHOW ERRORS
