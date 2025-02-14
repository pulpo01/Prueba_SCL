CREATE OR REPLACE PACKAGE BODY AL_INFORMAR_MOVIMIENTOS_EXT_PG
IS

/*
<NOMBRE>       : AL_INFORMAR_MOVIMIENTOS_EXT_PG</NOMBRE>
<FECHACREA>    : <FECHACREA/>
<MODULO >      : Logistica</MODULO >
<AUTOR >       : Luis Munoz</AUTOR >
<VERSION >     : 1.0</VERSION >
<DESCRIPCION>  : PL realiza la extraccion de movientos de Venta y PosVenta sobre la tabla  al_movimientos </DESCRIPCION>
<FECHAMOD >    : </FECHAMOD >
<DESCMOD >     : </DESCMOD >

*/

PROCEDURE  AL_OBTENER_MOVIMIENTOS_PR
 (
  EV_fecha_desde       IN VARCHAR2,
  EV_fecha_hasta       in VARCHAR2,
  sn_cod_retorno       OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
  sv_mens_retorno      OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
  sn_num_evento        OUT NOCOPY  ge_errores_pg.evento)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AL_OBTENER_MOVIMIENTOS_PR"
      Lenguaje="PL/Sql"
      Fecha="20-01-2010"
      Versión="1.0"
      Diseñador="Luis Munoz
      Programador="Luis Munoz
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripción>Utilizado en shell para extrare desde al_movimientos a tabla para informar movimientos de inventario</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_fecha_desde   Tipo="VARCHAR2>Fecha movimiento desde</param>
            <param nom="EV_fecha_hasta  Tipo="VARCHAR2">Fecha movimiento hasta</param>         
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
          </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
 LV_sql                  ge_errores_pg.vQuery;
 LV_des_error            ge_errores_pg.DesEvent;
 LN_registros            NUMBER;
 LN_DIAS                 NUMBER;
 LN_param_dias           ged_parametros.val_parametro%TYPE;
 le_error                exception;
  LE_error_parametros    EXCEPTION;
 PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

     SN_cod_retorno:=0;
     SV_mens_retorno:=NULL;
     SN_num_evento:=0;
      LV_sql := '';
     LN_DIAS :=0;


     LV_sql:='Error en parametros de negocio EV_fecha_desde, EV_fecha_hasta';
     IF EV_fecha_desde IS NULL OR EV_fecha_hasta IS NULL THEN
        DBMS_OUTPUT.PUT_LINE ( 'Error Parámetros de Fecha invalidos  ');
        RAISE LE_error_parametros;
     END IF;
     
     ---El rango de fechas no debe ser superior a los días definidos por parametros
    LN_param_dias := NULL;    
    BEGIN
         SELECT  val_parametro INTO LN_param_dias
         FROM ged_parametros
         WHERE NOM_PARAMETRO ='DIAS_MAXIMO_PROCMOV'
           AND COD_PRODUCTO = 1
           AND COD_MODULO ='AL';
    EXCEPTION
      WHEN others then
           NULL;       
    END;
    
    LV_sql:='Error Parámetro DIAS_MAXIMO_PROCMOV invalido ' ||LN_param_dias;
    IF LN_param_dias IS NULL THEN
       DBMS_OUTPUT.PUT_LINE ( 'Error Parámetro DIAS_MAXIMO_PROCMOV invalido ');
       RAISE LE_error_parametros;
    END IF;
    
     
     LV_sql:='Error Fecha desde y Fecha hasta no debe ser superior a ' ||LN_param_dias ||' dias';
     LN_dias := abs(trunc(TO_DATE(EV_fecha_desde, 'dd-mm-yyyy') - TO_DATE(EV_fecha_hasta, 'dd-mm-yyyy'))); 
     IF LN_DIAS > LN_param_dias then
       DBMS_OUTPUT.PUT_LINE ( 'Error dias entre Fecha desde y Fecha hasta no debe ser superior a ' ||LN_param_dias );
       RAISE le_error;
     END IF;
     
     
     LV_sql:='AL_INFORMAR_MOVIMIENTOS_EXT_PG.AL_INFORMAR_MOV_SCL_PR('||EV_fecha_desde||','||EV_fecha_hasta||',sn_cod_retorno,sv_mens_retorno,sn_num_evento);';
     AL_INFORMAR_MOVIMIENTOS_EXT_PG.AL_INFORMAR_MOV_SCL_PR(EV_fecha_desde,EV_fecha_hasta,sn_cod_retorno,sv_mens_retorno,sn_num_evento);
     IF SN_cod_retorno<>0 THEN
        DBMS_OUTPUT.PUT_LINE ( 'Error al ejecutar proceso AL_INFORMAR_MOVIMIENTOS_EXT_PG.AL_INFORMAR_MOV_SCL_PR ');
        RAISE le_error;
     END IF;
     COMMIT;

EXCEPTION
 WHEN LE_error THEN
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;
     SV_mens_retorno:=SV_mens_retorno||' - '||SUBSTR(SQLERRM,1,120);
     LV_des_error :='LE_error: AL_OBTENER_MOVIMIENTOS_PR- ' || SUBSTR(SQLERRM,1,120);
     SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_OBTENER_MOVIMIENTOS_PR', LV_sql, SQLCODE, LV_des_error );
     ROLLBACK;
WHEN LE_error_parametros THEN
     SN_cod_retorno := 156;
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;
     LV_des_error :='LE_error_parametros: AL_INFORMAR_MOV_SCL_PR - ' || SUBSTR(SQLERRM,1,120);
     SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_INFORMAR_MOV_SCL_PR', LV_sql, SQLCODE, LV_des_error );
     
 WHEN OTHERS THEN
     SN_cod_retorno := 156;
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;
     SV_mens_retorno:=SV_mens_retorno||' - '||SUBSTR(SQLERRM,1,120);
     LV_des_error :='ERROR_CONTROLADO: AL_OBTENER_MOVIMIENTOS_PR- ' || SUBSTR(SQLERRM,1,120);
     SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_OBTENER_MOVIMIENTOS_PR', LV_sql, SQLCODE, LV_des_error );
     ROLLBACK;

END;

PROCEDURE AL_INFORMAR_MOV_SCL_PR
 (
  EV_fecha_desde       IN VARCHAR2,
  EV_fecha_hasta       in VARCHAR2,
  sn_cod_retorno       OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
  sv_mens_retorno      OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
  sn_num_evento        OUT NOCOPY  ge_errores_pg.evento)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "AL_INFORMAR_MOV_SCL_PR"
      Lenguaje="PL/Sql"
      Fecha="20-01-2010"
      Versión="1.0"
      Diseñador="Luis Munoz
      Programador="Luis Munoz"
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripción>Extraer desde SCL salidas definitivas para informar a ente externo</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_fecha_desde   Tipo="VARCHAR2>Fecha movimiento desde</param>
            <param nom="EV_fecha_hasta  Tipo="VARCHAR2">Fecha movimiento hasta</param>
          </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

 LV_sql                  ge_errores_pg.vQuery;
 LV_des_error             ge_errores_pg.DesEvent;
 lv_fechahoy            varchar2(16);
 LV_ind_venta           ga_ventas.ind_venta%TYPE;
 LE_salir               EXCEPTION;
 LE_error_parametros    EXCEPTION;
 LE_siguiente           EXCEPTION;
 LN_precio_pmp          al_pmp_articulo.prec_pmp%TYPE;
 LN_cod_bodega          al_movimientos.cod_bodega_dest%TYPE;
 LN_tipmovinf            number(1);
 LN_existe_ren          number(1);
 LN_existe_ren2          number(1);
 LN_existe_camb         number(1);
 LN_existe_seguro       number(1);
 LN_nummov              al_movimientos.num_movimiento%TYPE;
 LN_count               NUMBER;
 LV_aux                 VARCHAR2(12);
 Ld_fecha_hoy           DATE;
 v_num_movimiento        al_movinf_tt.num_movimiento%TYPE;
 LN_conta_existe_ren     NUMBER;
 LN_conta_existe_camb    NUMBER;
 LN_conta_existe_seguro  NUMBER;
 LN_conta_venta          NUMBER;
 LN_conta_otros          NUMBER;
 LN_lee                  NUMBER;

 CURSOR cur_mov (EV_fecha_desde IN VARCHAR2, EV_fecha_hasta IN VARCHAR2)
 IS
        SELECT a.num_movimiento,a.tip_movimiento,a.cod_articulo,a.fec_movimiento,
               a.num_serie, a.cod_uso,a.tip_stock,
               a.num_transaccion, a.cod_transaccion
         FROM  AL_MOVIMIENTOS a, AL_ARTICULOS c
        WHERE  exists (select 1 from al_config_movinf_td b where a.tip_movimiento = b.tip_movimiento and a.TIP_STOCK = b.TIP_STOCK)
               and a.num_serie   is not null
               and a.cod_articulo = c.cod_articulo
               and c.ind_equiacc = 'E'
               and a.fec_movimiento between to_date(EV_fecha_desde,'dd-mm-yyyy') and to_date(EV_fecha_hasta,'dd-mm-yyyy');

        
 CURSOR c_mov_tt 
 IS
        SELECT a1.num_movimiento
         FROM  al_movinf_tt a1;
         
 CURSOR cur_config (LN_tip_movimiento IN NUMBER, LN_tip_stock IN NUMBER)
 IS
          select a.cod_tipmovinf 
          FROM al_config_movinf_td a,
               al_movinf_td b
          WHERE a.COD_TIPMOVINF = b.COD_TIPMOVINF
           and  a.TIP_MOVIMIENTO = LN_tip_movimiento
           and  a.TIP_STOCK     = LN_tip_stock;

 BEGIN

     SN_cod_retorno:=0;
     SV_mens_retorno:=NULL;
     SN_num_evento:=0;
     
     lv_fechahoy:=to_char(sysdate,'ddmmyyyyhh24miss');


     LV_sql:='Error en parametros de negocio EV_fecha_desde, EV_fecha_hasta';
     IF EV_fecha_desde IS NULL OR EV_fecha_hasta IS NULL THEN
        RAISE LE_error_parametros;
     END IF;


     OPEN c_mov_tt;
     LOOP
        FETCH c_mov_tt INTO v_num_movimiento;
           EXIT WHEN c_mov_tt%NOTFOUND;
           
        Delete from al_movinf_tt
        Where num_movimiento = v_num_movimiento;
           
     END LOOP;
     CLOSE c_mov_tt;
     

     
     LN_conta_existe_ren :=0;
     LN_conta_existe_camb := 0;
     LN_conta_existe_seguro := 0;
     LN_conta_venta := 0;
     LN_conta_otros := 0;
     
     LN_lee := 0;
     
     LV_sql:='FOR cc IN cur_mov(EV_fecha_desde, EV_fecha_hasta) LOOP';     
     FOR cc IN cur_mov(EV_fecha_desde, EV_fecha_hasta) LOOP

          LN_tipmovinf := NULL;
          LN_existe_ren := NULL;
          LN_existe_ren2 := NULL;
          LN_existe_camb := NULL;
          LN_existe_seguro := NULL;
          
          LN_lee := LN_lee + 1;
                    
          
        LV_sql:='FOR c1 IN cur_config (cc.tip_movimiento, cc.tip_stock) LOOP';   
        FOR c1 IN cur_config (cc.tip_movimiento, cc.tip_stock) LOOP
        
        
          Case c1.cod_tipmovinf
          
             WHEN  CN_renovacion THEN                    
             
                   --- Movimientos originados por RENOVACIONES     SCL  (Posventa)           
                    BEGIN        
                            SELECT 1 into LN_existe_ren
                            FROM ga_equipaboser a, 
                                 ga_caucaser d
                            WHERE a.num_serie = cc.num_serie
                              and a.fec_alta = (select max(c.fec_alta) from ga_equipaboser c where c.num_serie = cc.num_serie)
                              and a.COD_CAUSA iN ('RP','RR','RO')            
                              AND a.cod_causa = d.cod_caucaser
                              and d.COD_PRODUCTO = 1;
                    EXCEPTION
                           WHEN OTHERS then
                                NULL;
                    END;
                    
                    IF LN_existe_ren = 1 THEN
                         LN_tipmovinf := CN_renovacion;
                         LN_conta_existe_ren := LN_conta_existe_ren + 1;
                         EXIT;

                    ELSE
                        -- Movimiento originado por RENOVACIONES bajo modelo RENOVACIONES (PosVenta)
                        BEGIN
                            SELECT 1 into LN_existe_ren2
                            FROM ga_equipaboser a, 
                                 PV_REGISTRA_RENOVACION_OS_TO d
                            WHERE  a.num_serie = cc.num_serie
                               and a.fec_alta = (select max(c.fec_alta) from ga_equipaboser c where c.num_serie = cc.num_serie)
                               and a.num_abonado = d.num_abonado;    
                        EXCEPTION
                               WHEN OTHERS THEN
                                    NULL;        
                        END;
                    
                        IF LN_existe_ren2 = 1 THEN
                           LN_tipmovinf := CN_renovacion;
                           LN_conta_existe_ren := LN_conta_existe_ren + 1;
                           EXIT;
                        END IF;                    
                         
                    END IF;
                      
                                                        
             WHEN  CN_cambios THEN  
             
                    ---Movimientos originados por CAMBIOS (Posventa)  
                    BEGIN
                      SELECT 1 into LN_existe_camb
                      FROM ga_equipaboser a, 
                           ga_caucaser d
                      WHERE a.num_serie = cc.num_serie
                        and a.fec_alta = (select max(c.fec_alta) from ga_equipaboser c where c.num_serie = cc.num_serie)
                        and a.COD_CAUSA iN ('PS','CS','CT','CG','SC','12','CC')
                        AND a.cod_causa = d.cod_caucaser
                        and d.COD_PRODUCTO = 1;
                    EXCEPTION
                           WHEN OTHERS THEN
                                NULL;         
                    END;
                    
                    IF LN_existe_camb = 1 THEN
                       LN_tipmovinf := CN_cambios;
                       LN_conta_existe_camb := LN_conta_existe_camb + 1;
                       EXIT;
                    END IF;                      
                
                          
             WHEN  CN_seguro THEN  
             
                  ---Movimientos originados por SEGURO (Posventa)
                  BEGIN
                    SELECT 1 into LN_existe_seguro
                    FROM ga_equipaboser a, 
                         ga_caucaser d
                    WHERE a.num_serie = cc.num_serie
                      and a.fec_alta = (select max(c.fec_alta) from ga_equipaboser c where c.num_serie = cc.num_serie)
                      and a.COD_CAUSA iN ('15')
                      AND a.cod_causa = d.cod_caucaser
                      and d.COD_PRODUCTO = 1
                      AND d.ind_seguro = 1;
                  EXCEPTION
                           WHEN OTHERS THEN
                                NULL;        
                  END;
                  
                  IF LN_existe_seguro = 1 THEN
                     LN_tipmovinf := CN_seguro;
                     LN_conta_existe_seguro := LN_conta_existe_seguro + 1;
                     EXIT;
                  END IF;                         
             
             
             WHEN  CN_venta THEN  
                         
                 IF cc.num_transaccion IS NOT NULL AND cc.num_transaccion <> 0 and
                      ((cc.cod_transaccion = 3) or (cc.cod_transaccion = 4 )) THEN
     
              
                      LV_ind_venta := NULL;
                      
                      BEGIN
                        SELECT A.IND_VENTA into LV_ind_venta
                        FROM ga_ventas a, 
                             ge_clientes b
                        WHERE A.NUM_VENTA = cc.num_transaccion
                          AND A.COD_CLIENTE = B.COD_CLIENTE;
                      EXCEPTION
                               WHEN OTHERS THEN
                                    NULL;        
                      END;
                                  
                      IF LV_ind_venta = 'V' or LV_ind_venta = 'S' or LV_ind_venta = 'v' THEN --VENTA
                         LN_tipmovinf := CN_venta;
                         LN_conta_venta := LN_conta_venta + 1;
                         EXIT;
                      END IF;
                                
                  END IF;
                  
                  
             WHEN  CN_canje THEN 
                    NULL;             
             
             ELSE
                  DBMS_OUTPUT.PUT_LINE ( 'Tipo Moviento no aparece configurado: '||c1.cod_tipmovinf);
                

          End case;
                                                     
        
        END LOOP;
                   

        IF LN_tipmovinf IS NOT NULL THEN
        
           --- Valor PMP para el articulo según Fecha de Movimiento....
           LN_precio_pmp := NULL;
              
           BEGIN

                SELECT PREC_PMP INTO LN_precio_pmp
                FROM   al_pmp_articulo
                WHERE   cod_articulo = cc.cod_articulo 
                   AND to_char(cc.fec_movimiento,'mm-dd-yyyy hh24:mi:ss') between to_char(FEC_ULT_MOD,'mm-dd-yyyy hh24:mi:ss') and to_char(FEC_DIA_PMP,'mm-dd-yyyy hh24:mi:ss') 
                UNION
                SELECT PREC_PMP 
                FROM   al_pmp_articulo_th 
                WHERE cod_articulo=cc.cod_articulo 
                  AND to_char(cc.fec_movimiento,'mm-dd-yyyy hh24:mi:ss') between to_char(FEC_ULT_MOD,'mm-dd-yyyy hh24:mi:ss') and to_char(FEC_DIA_PMP,'mm-dd-yyyy hh24:mi:ss');
            
           EXCEPTION
                WHEN OTHERS THEN
                     NULL;  
           END;
              
           INSERT INTO al_movinf_tt(num_movimiento, tip_movimiento, tip_stock,cod_uso,
                               cod_tipmovinf, cod_articulo,fec_movimiento,
                               pmp_articulo)
           VALUES(cc.num_movimiento, cc.tip_movimiento, cc.tip_stock,cc.cod_uso,
                               LN_tipmovinf, cc.cod_articulo,cc.fec_movimiento,LN_precio_pmp );
        ELSE
           ----  DBMS_OUTPUT.PUT_LINE ( 'Para el moviento no se pudo determinar origen:'||cc.num_movimiento);  
           LN_conta_otros := LN_conta_otros + 1;        
        END IF;
                 

     END LOOP;
     

    dbms_output.put_line('Extraccion de Movimientos desde '|| to_date(EV_fecha_desde,'dd-mm-yyyy') ||' hasta '||to_date(EV_fecha_hasta,'dd-mm-yyyy'));
    dbms_output.put_line(' ');
    dbms_output.put_line('Cantidad Total movimientos leidos       :'|| LN_lee);
    dbms_output.put_line(' ');
    dbms_output.put_line('Cantidad Total acciones de Renovaciones :'|| LN_conta_existe_ren);
    dbms_output.put_line(' ');
    dbms_output.put_line('Cantidad Total acciones de Cambios      :'|| LN_conta_existe_camb);
    dbms_output.put_line(' ');
    dbms_output.put_line('Cantidad Total acciones de Seguros      :'|| LN_conta_existe_seguro);
    dbms_output.put_line(' ');
    dbms_output.put_line('Cantidad Total acciones de Ventas       :'|| LN_conta_venta);
    dbms_output.put_line(' ');
    dbms_output.put_line('Cantidad Total Otros                    :'|| LN_conta_otros);
        
      
     SV_mens_retorno:=NULL;
     
EXCEPTION
 WHEN LE_salir THEN
     SN_cod_retorno := 156;
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;
     LV_des_error :='LE_salir: AL_INFORMAR_MOV_SCL_PR - ' || SUBSTR(SQLERRM,1,120);
     SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_INFORMAR_MOV_SCL_PR', LV_sql, SQLCODE, LV_des_error );
 WHEN LE_error_parametros THEN
     SN_cod_retorno := 156;
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;
     LV_des_error :='LE_error_parametros: AL_INFORMAR_MOV_SCL_PR - ' || SUBSTR(SQLERRM,1,120);
     SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_INFORMAR_MOV_SCL_PR', LV_sql, SQLCODE, LV_des_error );
 WHEN OTHERS THEN
     SN_cod_retorno := 156;
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;
     LV_des_error :='ERROR_CONTROLADO: AL_INFORMAR_MOV_SCL_PR - ' || SUBSTR(SQLERRM,1,120);
     SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_INFORMAR_MOV_SCL_PR', LV_sql, SQLCODE, LV_des_error );
 
 END AL_INFORMAR_MOV_SCL_PR;


END AL_INFORMAR_MOVIMIENTOS_EXT_PG;
/
SHOW ERRORS

