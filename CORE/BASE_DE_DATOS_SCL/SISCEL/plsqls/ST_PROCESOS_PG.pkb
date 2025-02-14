CREATE OR REPLACE PACKAGE BODY ST_PROCESOS_PG AS
/******************************************************************************
   NAME:       ST_PROCESOS_PG
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2-6-2009             1. Created this package body.
******************************************************************************/

FUNCTION ST_OPERADORA_LOCAL_FN 
RETURN VARCHAR
IS
LV_Operadora     VARCHAR2(10);
SN_cod_retorno   ge_errores_pg.CodError;
SV_mens_retorno  ge_errores_pg.MsgError;
SN_num_evento    ge_errores_pg.Evento;
BEGIN
   SN_cod_retorno:=0;
   SV_mens_retorno:=' ';
   SN_num_evento:=0;
   LV_Operadora:=GE_OBTIENE_OPERADORA_LOCAL_FN(SN_cod_retorno,SV_mens_retorno,SN_num_evento);
   IF SN_cod_retorno > 0 THEN
      LV_Operadora:='Err';
   END IF;
     RETURN LV_Operadora;
END ST_OPERADORA_LOCAL_FN;


FUNCTION  ST_CHEQUEOS_ORDEN_FN (EN_Orden IN sp_ordenes_reparacion.num_orden%type)
RETURN VARCHAR
IS
LV_Chequeos     VARCHAR2(1500):=null;
CURSOR C_Chequeos (EN_Orden IN sp_ordenes_reparacion.num_orden%type)
IS
    SELECT b.des_elemento||' '||c.des_estado des_chequeo
    FROM sp_chequeos_orden a, sp_chequeos b, sp_estados_chequeos_td c
    WHERE a.num_orden=EN_Orden
    AND a.cod_estado=c.cod_estado  
    AND  a.cod_elemento=b.cod_elemento
    UNION
    SELECT b.des_elemento||' '||c.des_estado   des_chequeo
    FROM sp_hchequeos_orden a, sp_chequeos b, sp_estados_chequeos_td c
    WHERE a.num_orden=EN_Orden
    AND a.cod_estado=c.cod_estado  
    AND  a.cod_elemento=b.cod_elemento;
BEGIN
    FOR V_Chequeos  IN C_Chequeos(EN_Orden) LOOP
           LV_Chequeos:=LV_Chequeos ||V_Chequeos.des_chequeo|| ', ';
    END LOOP;
    LV_Chequeos:=initcap(substr(LV_Chequeos,1,(length(LV_Chequeos)-2)));
    RETURN LV_Chequeos;
   EXCEPTION
     WHEN OTHERS THEN
            RETURN NULL;
END ST_CHEQUEOS_ORDEN_FN;

FUNCTION  ST_NOMBRE_REPORTE_FN (EN_CodReporte IN sp_qry_reportes.nom_reporte%type)
RETURN VARCHAR
IS
LV_NombreRep  sp_qry_reportes.nom_reporte%type;
SN_cod_retorno   ge_errores_pg.CodError;
SV_mens_retorno  ge_errores_pg.MsgError;
SN_num_evento    ge_errores_pg.Evento;
BEGIN
   SN_cod_retorno:=0;
   SV_mens_retorno:=' ';
   SN_num_evento:=0;
   BEGIN
    SELECT nom_reporte
	INTO LV_NombreRep
	FROM sp_qry_reportes
	WHERE cod_reporte=EN_CodReporte AND
	      cod_operadora=ST_OPERADORA_LOCAL_FN;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
          LV_NombreRep:=null;   
   END ;
   
   RETURN LV_NombreRep;
END ST_NOMBRE_REPORTE_FN;

FUNCTION  ST_DIR_CLIENTE_FN (EV_CodSujeto IN VARCHAR2, 
                              EN_TipSujeto IN NUMBER, 
                              EN_CodTipdireccion IN NUMBER, 
                              EN_CodDisplay IN NUMBER, 
                              EV_ValFac IN VARCHAR2 := '1' )
RETURN VARCHAR
IS
LV_Direccion    VARCHAR2(800);
LN_retorno      NUMBER;
BEGIN
    BEGIN
        LV_Direccion :=ge_fn_obtiene_dirclie(EV_CodSujeto,EN_TipSujeto,EN_CodTipdireccion,EN_CodDisplay,EV_ValFac);
        LN_retorno:=INSTR(LV_Direccion,'ERROR');
        IF LN_retorno > 0 THEN
           LV_Direccion:=null;
        END IF; 
    EXCEPTION
       WHEN OTHERS THEN
          LV_Direccion:=null;
    END;
    DBMS_OUTPUT.PUT_LINE ( 'LV_Direccion = ' || LV_Direccion );
    RETURN LV_Direccion;
END ST_DIR_CLIENTE_FN;

FUNCTION  ST_AVERIAS_ORDEN_FN (EN_Orden IN sp_ordenes_reparacion.num_orden%type)
RETURN VARCHAR
IS
LV_Averias     VARCHAR2(1500):=null;
CURSOR C_Averias (EN_Orden IN sp_ordenes_reparacion.num_orden%type)
IS
    SELECT b.des_averia
    FROM sp_averias_orden a, sp_averias b
    WHERE a.num_orden=EN_Orden
    AND a.cod_averia=b.cod_averia  
    UNION
    SELECT b.des_averia
    FROM sp_haverias_orden a, sp_averias b
    WHERE a.num_orden=EN_Orden
    AND a.cod_averia=b.cod_averia;  
BEGIN
    FOR V_Averias  IN C_Averias(EN_Orden) LOOP
           LV_Averias:=LV_Averias ||V_averias.des_averia|| ', ';
    END LOOP;
    LV_Averias:=initcap(substr(LV_Averias,1,(length(LV_Averias)-2)));
    RETURN LV_Averias;
   EXCEPTION
     WHEN OTHERS THEN
            RETURN NULL;
END ST_AVERIAS_ORDEN_FN;

PROCEDURE  ST_HISTORICO_OBSERVACIONES_PR (EN_Orden IN sp_observaciones_orden_to.num_orden%type,
                                         EN_EstadoOrden IN sp_ordenes_reparacion.cod_estado_orden%type)
IS
CURSOR c_obs (EN_Orden IN sp_observaciones_orden_to.num_orden%type)
IS
SELECT num_observacion, num_orden, des_observacion, nom_usuario, fecha_obs
FROM sp_observaciones_orden_to
WHERE num_orden=EN_Orden;
LV_EstadoFinal varchar2 (5);
CV_ORDENFIN VARCHAR2(20):='ORDEN_FINALIZADA';
CV_MODULO VARCHAR2(3):='ST';
RG_Obs  RT_Obs;
BEGIN
    RG_Obs:= RT_Obs(null);
    SELECT val_parametro
    INTO LV_EstadoFinal
    FROM ged_parametros
    WHERE nom_parametro=CV_ORDENFIN
    AND cod_modulo=CV_MODULO;
    IF  LV_EstadoFinal= EN_EstadoOrden THEN
        OPEN c_obs(EN_Orden);
	    LOOP
	 	    FETCH c_obs BULK COLLECT INTO RG_obs LIMIT 1000;
            EXIT WHEN RG_obs.COUNT = 0;
		    --------------------------------------------------
		    IF RG_obs.FIRST is not null THEN
                FOR i IN RG_obs.FIRST .. RG_obs.LAST LOOP
                       INSERT INTO SP_OBSERVACIONES_ORDEN_TH (NUM_OBSERVACION,NUM_ORDEN,FEC_HISTORICO,DES_OBSERVACION,NOM_USUARIO,FECHA_OBS)
                       VALUES (RG_obs(i).num_observacion,RG_obs(i).num_orden,sysdate,RG_obs(i).des_observacion,RG_obs(i).nom_usuario,RG_obs(i).fecha_obs);
                END LOOP;
            END IF;
         RG_obs.delete;
	 END LOOP;
	 CLOSE c_obs;  
    END IF;    
END  ST_HISTORICO_OBSERVACIONES_PR;                              



END ST_PROCESOS_PG;
/
SHOW ERRORS