CREATE OR REPLACE FUNCTION AL_TECNOLOGIA_FN (IN_Cod_Articulo al_articulos.cod_articulo%type) return varchar is
 OV_tecnologia   al_tecnologia.cod_tecnologia%type;
 BEGIN
   EXECUTE IMMEDIATE 'SELECT cod_tecnologia FROM al_tecnoarticulo_td WHERE cod_articulo = :tip_terminal and ind_defecto = 1'
   INTO OV_tecnologia
   USING IN_Cod_Articulo;

   RETURN OV_tecnologia;

 EXCEPTION
        WHEN NO_DATA_FOUND THEN
       RETURN ('No hay Informacion');
    WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20100, 'Error ' || to_char(SQLCODE) || ': ' || SQLERRM);
 end;
/
SHOW ERRORS
