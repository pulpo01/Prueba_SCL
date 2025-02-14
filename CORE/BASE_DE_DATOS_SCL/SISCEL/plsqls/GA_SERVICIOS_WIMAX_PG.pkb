CREATE OR REPLACE PACKAGE BODY GA_SERVICIOS_WIMAX_PG IS
FUNCTION getNombreCliente_FN 
                            (EN_numMovimiento IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
                            RETURN VARCHAR2 IS

LV_CodCliente GE_CLIENTES.COD_CLIENTE%TYPE;
LV_NomCliente VARCHAR2(100);
LN_NUM_ABONADO GA_ABOCEL.NUM_ABONADO%TYPE;

BEGIN
     
     SELECT NUM_ABONADO 
     INTO LN_NUM_ABONADO
     FROM ICC_MOVIMIENTO
     WHERE NUM_MOVIMIENTO=EN_numMovimiento;



     SELECT COD_CLIENTE 
     INTO LV_CodCliente       
     FROM GA_ABOCEL 
     WHERE NUM_ABONADO=LN_NUM_ABONADO;
     
     SELECT NOM_CLIENTE || ' ' || NOM_APECLIEN1 || ' ' || NOM_APECLIEN2
     INTO LV_NomCliente
     FROM GE_CLIENTES 
     WHERE COD_CLIENTE=LV_CodCliente;
     
     
     
--|  (pipe) se cambia por  <$>
--,  (coma) se cambia por  <#>
--;  (punto y coma) se cambia por  <@>

LV_nomCliente:=REPLACE(LV_NomCliente,'|','<$>' );
LV_nomCliente:=REPLACE(LV_NomCliente,',','<#>' );
LV_nomCliente:=REPLACE(LV_NomCliente,';','<@>' );

RETURN LV_NomCliente;
 
EXCEPTION 
      WHEN OTHERS THEN 
       RETURN 'ERROR AL OBTENER NOMBRE DEL CLIENTE ' || SQLERRM; 
                  
END getNombreCliente_FN; 

FUNCTION getMacAddress_FN
                            (EN_numMovimiento IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
                            RETURN VARCHAR2 IS

LV_MAC_ADDRESS GA_DATABONADO_TO.MAC_ADDRESS%TYPE;
LN_NUM_ABONADO GA_ABOCEL.NUM_ABONADO%TYPE;
BEGIN
     
     SELECT NUM_ABONADO 
     INTO LN_NUM_ABONADO
     FROM ICC_MOVIMIENTO
     WHERE NUM_MOVIMIENTO=EN_numMovimiento;
     
     
     
     SELECT MAC_ADDRESS
     INTO LV_MAC_ADDRESS
     FROM GA_DATABONADO_TO
     WHERE NUM_ABONADO= LN_NUM_ABONADO; 
 
     RETURN LV_MAC_ADDRESS;

EXCEPTION     
      WHEN OTHERS THEN 
           RETURN 'ERROR AL OBTENER MAC ADDRESS ASOCIADO AL ABONADO ' || SQLERRM; 
                  
END getMacAddress_FN;

FUNCTION getDireccionUsuario_fn
                            (EN_numMovimiento IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
                            RETURN VARCHAR2 IS

LN_codUsuario GA_USUARIOS.COD_USUARIO%TYPE;
LV_GLOSA_DIR VARCHAR2(500); 
LV_DIRECCION GE_DIRECCIONES.COD_DIRECCION%TYPE;
LN_NUM_ABONADO GA_ABOCEL.NUM_ABONADO%TYPE;
BEGIN
        

        SELECT NUM_ABONADO 
        INTO LN_NUM_ABONADO
        FROM ICC_MOVIMIENTO
        WHERE NUM_MOVIMIENTO=EN_numMovimiento;

  
        SELECT COD_USUARIO 
        INTO LN_codUsuario
        FROM GA_ABOCEL 
        WHERE NUM_ABONADO=LN_NUM_ABONADO;
        
        SELECT COD_DIRECCION 
        INTO LV_DIRECCION
        FROM GA_DIRECUSUAR
        WHERE COD_USUARIO=LN_codUsuario
        AND COD_TIPDIRECCION=3;
        

        select  c.DES_DIREC1 || ' ' || c.NOM_CALLE || ' ' || c.NUM_CALLE ||  ' ' ||  e.des_ciudad || ' ' ||  d.DES_PROVINCIA || ' ' || a.DES_REGION   
                INTO LV_GLOSA_DIR
                from ge_regiones a,ge_direcciones c,ge_provincias d , ge_ciudades e 
                where a.COD_REGION=c.COD_REGION
                and c.COD_REGION=d.COD_REGION
                and c.COD_PROVINCIA=d.COD_PROVINCIA
                and e.COD_ciudad=c.COD_CIUDAD
                and c.cod_region=e.cod_region
                and cod_direccion=LV_DIRECCION;

     LV_GLOSA_DIR:=REPLACE(LV_GLOSA_DIR,'|','<$>' );
     LV_GLOSA_DIR:=REPLACE(LV_GLOSA_DIR,',','<#>' );
     LV_GLOSA_DIR:=REPLACE(LV_GLOSA_DIR,';','<@>' );
              
RETURN LV_GLOSA_DIR;
EXCEPTION     
      WHEN OTHERS THEN 
           RETURN 'ERROR AL OBTENER DIRECCION DE USUARIO ' || SQLERRM; 
END getDireccionUsuario_fn;

FUNCTION getTipoZona_fn
                            (EN_numMovimiento IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
                            RETURN VARCHAR2 IS

LV_TipZona GE_PROVINCIAS.TIP_ZONA%TYPE;
LN_codUsuario GA_USUARIOS.COD_USUARIO%TYPE;
LV_DIRECCION GE_DIRECCIONES.COD_DIRECCION%TYPE;
LN_NUM_ABONADO GA_ABOCEL.NUM_ABONADO%TYPE;
BEGIN
        
        SELECT NUM_ABONADO 
        INTO LN_NUM_ABONADO
        FROM ICC_MOVIMIENTO
        WHERE NUM_MOVIMIENTO=EN_numMovimiento;
        
        SELECT COD_USUARIO 
        INTO LN_codUsuario
        FROM GA_ABOCEL 
        WHERE NUM_ABONADO=LN_NUM_ABONADO;
        
        SELECT COD_DIRECCION 
        INTO LV_DIRECCION
        FROM GA_DIRECUSUAR
        WHERE COD_USUARIO=LN_codUsuario
        AND COD_TIPDIRECCION=3;
        

        select  D.TIP_ZONA   
        INTO LV_TipZona
        from ge_regiones a,ge_direcciones c,ge_provincias d , ge_ciudades e 
        where a.COD_REGION=c.COD_REGION
        and c.COD_REGION=d.COD_REGION
        and c.COD_PROVINCIA=d.COD_PROVINCIA
        and e.COD_ciudad=c.COD_CIUDAD
        and c.cod_region=e.cod_region
        and cod_direccion=LV_DIRECCION;

 RETURN  LV_TipZona;   
                  
END getTipoZona_fn;                             
END GA_SERVICIOS_WIMAX_PG; 
/
SHOW ERRORS