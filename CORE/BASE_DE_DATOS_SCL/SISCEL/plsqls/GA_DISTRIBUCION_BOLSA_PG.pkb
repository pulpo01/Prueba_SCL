CREATE OR REPLACE PACKAGE BODY                  GA_Distribucion_Bolsa_Pg IS
PROCEDURE VE_obtiene_datos_Bolsa_PR       (EV_codPlantarif    IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                           SV_DES_PLANTARIF   OUT NOCOPY TA_PLANTARIF.DES_PLANTARIF%TYPE,
                                           SV_COD_BOLSA       OUT NOCOPY TOL_BOLSA_PLAN.COD_BOLSA%TYPE,
                                           SV_GLSPARAM        OUT NOCOPY SCH_CODIGOS.GLS_PARAM%TYPE,
                                           SV_CANTIDAD_BOLSA  OUT NOCOPY TOL_BOLSA_TD.CNT_BOLSA%TYPE,
                                           SN_TIPO_UNIDAD     OUT NOCOPY TOL_BOLSA_TD.IND_UNIDAD%TYPE,
                                           SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
  
  

       no_data_found_cursor      EXCEPTION;
       LV_des_error ge_errores_pg.DesEvent;
       LV_sSql      ge_errores_pg.vQuery;
       LN_contador      NUMBER;
    BEGIN

        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';
        
        
        SELECT C.DES_PLANTARIF, D.COD_BOLSA, F.GLS_PARAM ,E.CNT_BOLSA, E.IND_UNIDAD 
        INTO SV_DES_PLANTARIF,SV_COD_BOLSA,SV_GLSPARAM,SV_CANTIDAD_BOLSA,SN_TIPO_UNIDAD
        FROM TA_PLANTARIF C, TOL_BOLSA_PLAN D, TOL_BOLSA_TD E, SCH_CODIGOS F
        WHERE 
            C.COD_PLANTARIF = D.COD_PLAN
           AND D.COD_BOLSA = E.COD_BOLSA
           AND E.IND_UNIDAD = F.COD_PARAM
           AND F.COD_TIPO = 'INDUNIDAD'
           AND C.CLA_PLANTARIF='DIS'
           AND C.COD_PLANTARIF=EV_codPlantarif;
   

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             SV_mens_retorno := 'Error al recuperar datos del plan tarifario distribuible';
             LV_des_error := SUBSTR('OTHERS:GA_Distribucion_Bolsa_Pg.VE_obtiene_datos_Bolsa_PR('|| EV_CODPLANTARIF ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'GA_Distribucion_Bolsa_Pg.VE_obtiene_datos_Bolsa_PR', LV_sSql, SN_cod_retorno, LV_des_error );
END VE_obtiene_datos_Bolsa_PR;
PROCEDURE VE_obtiene_ventas_ant_PR        (EN_numVenta        IN  GA_VENTAS.NUM_VENTA%TYPE,
                                           EN_COD_CLIENTE     IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                                           SN_COUNT_VENTAS    OUT NOCOPY NUMBER,
                                           SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
  
  

       no_data_found_cursor      EXCEPTION;
       LV_des_error ge_errores_pg.DesEvent;
       LV_sSql      ge_errores_pg.vQuery;
       LN_contador      NUMBER;
    BEGIN

        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';
        
         SELECT  COUNT(1) 
         INTO SN_COUNT_VENTAS
         FROM GA_VENTAS A
         WHERE A.COD_CLIENTE =   EN_COD_CLIENTE  
         AND A.NUM_VENTA <> EN_NUMVENTA;
 

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             SV_mens_retorno := 'Error al recuperar datos ventas antiguas';
             LV_des_error := SUBSTR('OTHERS:GA_Distribucion_Bolsa_Pg.VE_obtiene_ventas_ant_PR('|| EN_numVenta ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'GA_Distribucion_Bolsa_Pg.VE_obtiene_ventas_ant_PR', LV_sSql, SN_cod_retorno, LV_des_error );
END VE_obtiene_ventas_ant_PR;

PROCEDURE VE_obtiene_vtas_ant_X_plan_PR   (EN_numVenta        IN  GA_VENTAS.NUM_VENTA%TYPE,
                                           EN_COD_CLIENTE     IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                                           EN_COD_PLANTARIF   IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                           SN_COUNT_VENTAS    OUT NOCOPY NUMBER,
                                           SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
 
       LV_des_error ge_errores_pg.DesEvent;
       LV_sSql      ge_errores_pg.vQuery;
    BEGIN

        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';
        
        LV_sSql := 'SELECT  COUNT(1) INTO SN_COUNT_VENTAS FROM GA_ABOCEL A';
        LV_sSql := LV_sSql || ' WHERE A.COD_SITUACION NOT IN (AAA,BAP,BAA,AOP,ATP,APF,TVP,REA,API)';
        LV_sSql := LV_sSql || ' AND A.COD_CLIENTE = '|| EN_COD_CLIENTE;
        LV_sSql := LV_sSql || ' AND NUM_VENTA IN (SELECT NUM_VENTA FROM GA_VENTAS WHERE COD_CLIENTE = '|| EN_COD_CLIENTE ||' AND NUM_VENTA <>'|| EN_NUMVENTA||')';
        LV_sSql := LV_sSql || ' AND COD_PLANTARIF = '|| EN_COD_PLANTARIF;	 


        SELECT  COUNT(1) INTO SN_COUNT_VENTAS FROM GA_ABOCEL A 
        WHERE A.COD_SITUACION NOT IN ('AAA','BAP','BAA','AOP','ATP','APF','TVP','REA','API')
        AND A.COD_CLIENTE = EN_COD_CLIENTE
        AND A.NUM_VENTA IN (SELECT NUM_VENTA FROM GA_VENTAS WHERE COD_CLIENTE = EN_COD_CLIENTE AND NUM_VENTA <> EN_NUMVENTA)
        AND A.COD_PLANTARIF =  EN_COD_PLANTARIF;

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             SV_mens_retorno := 'Error al recuperar datos ventas antiguas X plan';
             LV_des_error := SUBSTR('OTHERS:GA_Distribucion_Bolsa_Pg.VE_obtiene_vtas_ant_X_plan_PR('|| EN_numVenta ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'GA_Distribucion_Bolsa_Pg.VE_obtiene_vtas_ant_X_plan_PR', LV_sSql, SN_cod_retorno, LV_des_error );
END VE_obtiene_vtas_ant_X_plan_PR;

PROCEDURE VE_validaPlan_Dist_PR        (   EN_COD_CLIENTE     IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                                           SV_codPlantarif    OUT NOCOPY TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                           SV_codPrestacion   OUT NOCOPY GA_ABOCEL.COD_PRESTACION%TYPE,
                                           SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
  
  

       no_data_found_cursor      EXCEPTION;
       LV_des_error ge_errores_pg.DesEvent;
       LV_sSql      ge_errores_pg.vQuery;
       LN_contador      NUMBER;
    BEGIN

        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';
        
        
        SELECT DISTINCT(COD_PLANTARIF),COD_PRESTACION
        INTO SV_codPlantarif,SV_codPrestacion
        FROM GA_ABOCEL
        WHERE COD_CLIENTE = EN_COD_CLIENTE AND COD_PLANTARIF IN (SELECT COD_PLANTARIF
                                                    FROM TA_PLANTARIF
                                                    WHERE CLA_PLANTARIF = 'DIS');
   
    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
             NULL;
        WHEN TOO_MANY_ROWS THEN 
             SN_cod_retorno:=4;
             SV_mens_retorno := 'Cliente Posee mas de un Plan Distribuido';
             LV_des_error := SUBSTR('OTHERS:GA_Distribucion_Bolsa_Pg.VE_validaPlan_Dist_PR('|| EN_COD_CLIENTE ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'GA_Distribucion_Bolsa_Pg.VE_validaPlan_Dist_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             SV_mens_retorno := 'Error al recuperar Plan Tarifario Distribuido';
             LV_des_error := SUBSTR('OTHERS:GA_Distribucion_Bolsa_Pg.VE_validaPlan_Dist_PR('|| EN_COD_CLIENTE ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'GA_Distribucion_Bolsa_Pg.VE_validaPlan_Dist_PR', LV_sSql, SN_cod_retorno, LV_des_error );
END VE_validaPlan_Dist_PR;

PROCEDURE VE_obtienePlan_Dist_PR        (  EN_num_Venta     IN  GA_VENTAS.NUM_VENTA%TYPE,
                                           SC_CURSORDATOS   OUT NOCOPY REFCURSOR,
                                           SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
  
  

       no_data_found_cursor      EXCEPTION;
       LV_des_error ge_errores_pg.DesEvent;
       LV_sSql      ge_errores_pg.vQuery;
       LN_contador      NUMBER;
       LN_CodCliente GE_CLIENTES.COD_CLIENTE%TYPE;
    BEGIN

        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';
        
        SELECT COD_CLIENTE 
        INTO LN_CodCliente
        FROM GA_VENTAS
        WHERE NUM_VENTA=EN_num_Venta;
        
        
        OPEN SC_CURSORDATOS FOR
        SELECT DISTINCT(A.COD_PLANTARIF), B.DES_PLANTARIF
        FROM GA_ABOCEL A,TA_PLANTARIF B
        WHERE A. NUM_VENTA= EN_num_Venta
        AND A.COD_PLANTARIF IN (SELECT COD_PLANTARIF
                              FROM TA_PLANTARIF
                              WHERE CLA_PLANTARIF = 'DIS')
        AND A.COD_PLANTARIF NOT IN (SELECT COD_PLANTARIF FROM GA_ABOCEL WHERE COD_CLIENTE=LN_CodCliente AND NUM_VENTA<>EN_num_Venta)
        
        AND A.COD_PLANTARIF=B.COD_PLANTARIF;            

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             SV_mens_retorno := 'Error al recuperar Plan Tarifario Distribuido';
             LV_des_error := SUBSTR('OTHERS:GA_Distribucion_Bolsa_Pg.VE_obtienePlan_Dist_PR('|| EN_num_Venta ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'GA_Distribucion_Bolsa_Pg.VE_obtienePlan_Dist_PR', LV_sSql, SN_cod_retorno, LV_des_error );
END VE_obtienePlan_Dist_PR;
PROCEDURE VE_obtienePlan_Dist_Auto_PR   (  EN_num_Venta     IN  GA_VENTAS.NUM_VENTA%TYPE,
                                           SC_CURSORDATOS   OUT NOCOPY REFCURSOR,
                                           SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
  
  

       no_data_found_cursor      EXCEPTION;
       LV_des_error ge_errores_pg.DesEvent;
       LV_sSql      ge_errores_pg.vQuery;
       LN_contador      NUMBER;
       LN_CodCliente GE_CLIENTES.COD_CLIENTE%TYPE;
    BEGIN

        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';
        
        SELECT COD_CLIENTE 
        INTO LN_CodCliente
        FROM GA_VENTAS
        WHERE NUM_VENTA=EN_num_Venta;
        
        
        OPEN SC_CURSORDATOS FOR
        SELECT DISTINCT(A.COD_PLANTARIF), B.DES_PLANTARIF
        FROM GA_ABOCEL A,TA_PLANTARIF B
        WHERE A. NUM_VENTA= EN_num_Venta
        AND A.COD_PLANTARIF IN (SELECT COD_PLANTARIF
                              FROM TA_PLANTARIF
                              WHERE CLA_PLANTARIF = 'DIS')
        AND A.COD_PLANTARIF IN (SELECT COD_PLANTARIF FROM GA_ABOCEL WHERE COD_CLIENTE=LN_CodCliente AND NUM_VENTA<>EN_num_Venta)
        
        AND A.COD_PLANTARIF=B.COD_PLANTARIF;            

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             SV_mens_retorno := 'Error al recuperar Plan Tarifario Distribuido Automatico';
             LV_des_error := SUBSTR('OTHERS:GA_Distribucion_Bolsa_Pg.VE_obtienePlan_Dist_Auto_PR('|| EN_num_Venta ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'GA_Distribucion_Bolsa_Pg.VE_obtienePlan_Dist_Auto_PR', LV_sSql, SN_cod_retorno, LV_des_error );
END VE_obtienePlan_Dist_Auto_PR;
PROCEDURE VE_obtieneAbonados_Dist_PR        (  EN_num_Venta     IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                                           EV_CodPlantarif  IN  TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                           SC_CURSORDATOS   OUT NOCOPY REFCURSOR,
                                           SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
  
  

       no_data_found_cursor      EXCEPTION;
       LV_des_error ge_errores_pg.DesEvent;
       LV_sSql      ge_errores_pg.vQuery;
       LN_contador      NUMBER;
    BEGIN

        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';
        
        
        OPEN SC_CURSORDATOS FOR
        SELECT NUM_ABONADO,NUM_CELULAR 
        FROM GA_ABOCEL 
        WHERE NUM_VENTA=EN_num_Venta
        AND COD_PLANTARIF =  EV_CodPlantarif;             


    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             SV_mens_retorno := 'Error al recuperar abonados con plan distribuido';
             LV_des_error := SUBSTR('OTHERS:GA_Distribucion_Bolsa_Pg.VE_obtienePlan_Dist_PR('|| EN_num_Venta ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'GA_Distribucion_Bolsa_Pg.VE_obtienePlan_Dist_PR', LV_sSql, SN_cod_retorno, LV_des_error );
END VE_obtieneAbonados_Dist_PR;
PROCEDURE PV_obtienePlan_Dist_PR        (  EN_cod_Cliente   IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                                           SC_CURSORDATOS   OUT NOCOPY REFCURSOR,
                                           SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
  
  

       no_data_found_cursor      EXCEPTION;
       LV_des_error ge_errores_pg.DesEvent;
       LV_sSql      ge_errores_pg.vQuery;
       LN_contador      NUMBER;
       LN_CodCliente GE_CLIENTES.COD_CLIENTE%TYPE;
    BEGIN

        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';
        
        OPEN SC_CURSORDATOS FOR
        SELECT DISTINCT(A.COD_PLANTARIF), B.DES_PLANTARIF
        FROM GA_ABOCEL A,TA_PLANTARIF B
        WHERE A. COD_CLIENTE= EN_cod_Cliente
        AND A.COD_PLANTARIF IN (SELECT COD_PLANTARIF
                              FROM TA_PLANTARIF
                              WHERE CLA_PLANTARIF = 'DIS')
        AND A.COD_PLANTARIF=B.COD_PLANTARIF;            

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             SV_mens_retorno := 'Error al recuperar Plan Tarifario Distribuido';
             LV_des_error := SUBSTR('OTHERS:GA_Distribucion_Bolsa_Pg.PV_obtienePlan_Dist_PR('|| EN_cod_Cliente ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'GA_Distribucion_Bolsa_Pg.PV_obtienePlan_Dist_PR', LV_sSql, SN_cod_retorno, LV_des_error );
END PV_obtienePlan_Dist_PR;



END GA_Distribucion_Bolsa_Pg; 
/

SHOW ERROR
