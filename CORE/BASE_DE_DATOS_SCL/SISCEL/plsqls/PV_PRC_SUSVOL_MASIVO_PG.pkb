CREATE OR REPLACE PACKAGE BODY PV_PRC_SUSVOL_MASIVO_PG
AS
---------------------------------------------------------------------------------------------------------
PROCEDURE PV_PRC_SUSVOL_MASIVO_PR(VP_COD_OS        IN VARCHAR2,
                                 VP_RESULTADO     IN OUT NOCOPY INTEGER,
                                 VP_SQLCODE       IN OUT NOCOPY VARCHAR2,
                                 VP_SQLERRM       IN OUT NOCOPY VARCHAR2  )
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_PRC_SUSVOL_MASIVO_PR"
       Lenguaje="PL/SQL"
       Fecha="25-08-2009"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="VP_COD_OS" Tipo="codigo orden servicio"><param>>
          </Entrada>
          <Salida>
             <param nom="VP_RESULTADO" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="VP_SQLCODE" Tipo="CARACTER">codigo error oracle</param>>
             <param nom="VP_SQLERRM " Tipo="caracter">glosa</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

  V_NUM_ABONADO           ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
  V_COD_ACTABO            ICC_MOVIMIENTO.COD_ACTABO%TYPE;
  V_NOM_USUARIO           ICC_MOVIMIENTO.NOM_USUARORA%TYPE;
  V_CAUSA                 ICC_MOVIMIENTO.COD_SUSPREHA%TYPE;
  V_NUM_OS                CI_ORSERV.NUM_OS%TYPE;
  V_FEC_EJECUCION         PV_INTERFAZ_SUSVOL_TO.FEC_EJECUCION%TYPE;  
  V_COD_ESTADO            PV_INTERFAZ_SUSVOL_TO.COD_ESTADO%TYPE;
  V_FEC_PROCESO           PV_INTERFAZ_SUSVOL_TO.FEC_PROCESO%TYPE;
  V_COD_CAUSA             PV_INTERFAZ_SUSVOL_TO.COD_CAUSA%TYPE;  
  V_COD_FRAUDE            PV_INTERFAZ_SUSVOL_TO.COD_FRAUDE%TYPE;
  V_COD_SERVICIOS         PV_INTERFAZ_SUSVOL_TO.COD_SERVICIOS%TYPE;  
  V_IND_CENTRAL           PV_INTERFAZ_SUSVOL_TO.IND_CENTRAL%TYPE;  
  V_COMENTARIO            PV_INTERFAZ_SUSVOL_TO.COMENTARIO%TYPE;
  V_BDATOS                PV_INTERFAZ_SUSVOL_TO.BDATOS%TYPE;
  V_FEC_REHABILITA        PV_INTERFAZ_SUSVOL_TO.FEC_REHABILITA%TYPE;
  V_TIP_SUSP              PV_INTERFAZ_SUSVOL_TO.TIP_SUSP%TYPE;
  V_COD_OS                PV_INTERFAZ_SUSVOL_TO.COD_OS%TYPE;
  
  V_NUMTRANSACABO         GA_TRANSACABO.NUM_TRANSACCION%TYPE:=NULL;
  ERROR_PROCESO           EXCEPTION;

  VP_COD_OS_AUX           CI_TIPORSERV.COD_OS%TYPE; 

  g_sNumMov               ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;
  sEstado                 GED_PARAMETROS.VAL_PARAMETRO%TYPE;

  CURSOR C1 IS
  SELECT 
    NUM_ABONADO   ,  FEC_EJECUCION ,  COD_ESTADO    ,
    COD_ACTABO    ,  FEC_PROCESO   ,  NOM_USUARIO   ,
    NUM_OS        ,  COD_CAUSA     ,  COD_FRAUDE    ,
    COD_SERVICIOS ,  IND_CENTRAL   ,  COMENTARIO    ,
    BDATOS        ,  FEC_REHABILITA,  TIP_SUSP      ,
    COD_OS
  FROM   PV_INTERFAZ_SUSVOL_TO
  WHERE  COD_ESTADO = 0 and cod_actabo IN ('ST','S7','R7','RT')
  AND COD_OS   IN ('50016','50018','50019','50020')
  AND    FEC_EJECUCION <= SYSDATE;


BEGIN
  
    BEGIN
        VP_RESULTADO := 0;

                OPEN C1;
                LOOP
                        FETCH C1 INTO   V_NUM_ABONADO   ,  V_FEC_EJECUCION ,  V_COD_ESTADO    ,
                                        V_COD_ACTABO    ,  V_FEC_PROCESO   ,  V_NOM_USUARIO   ,
                                        V_NUM_OS        ,  V_COD_CAUSA     ,  V_COD_FRAUDE    ,
                                        V_COD_SERVICIOS ,  V_IND_CENTRAL   ,  V_COMENTARIO    ,
                                        V_BDATOS        ,  V_FEC_REHABILITA,  V_TIP_SUSP      ,
                                        V_COD_OS;
                        EXIT WHEN C1%NOTFOUND;
                                dbms_output.put_line('itera 1');
                                PV_PRC_SUSVOL_MASIVO_PG.PV_PRC_PROCSUSVOL_PR(
                                                     V_NUM_ABONADO   ,  V_FEC_EJECUCION ,  V_COD_ESTADO    ,
                                                     V_COD_ACTABO    ,  V_FEC_PROCESO   ,  V_NOM_USUARIO   ,
                                                     V_NUM_OS        ,  V_COD_CAUSA     ,  V_COD_FRAUDE    ,
                                                     V_COD_SERVICIOS ,  V_IND_CENTRAL   ,  V_COMENTARIO    ,
                                                     V_BDATOS        ,  V_FEC_REHABILITA,  V_TIP_SUSP      ,
                                                     V_COD_OS        ,  VP_RESULTADO    ,  VP_SQLCODE      ,  
                                                     VP_SQLERRM    );
                                                                              
                     
                                
                                IF VP_RESULTADO = 1 THEN
                                        
                                        UPDATE PV_INTERFAZ_SUSVOL_TO
                                        SET    COD_ESTADO  = 1,  
                                               FEC_PROCESO = SYSDATE,
                                               NOM_USUARIO = V_NOM_USUARIO,
                                               NUM_OS      = V_NUM_OS --Codigo 1 = procesada
                                        WHERE  NUM_ABONADO = V_NUM_ABONADO
                                        AND    COD_ACTABO  = V_COD_ACTABO;

                                ELSE

                                        ROLLBACK;
                                        UPDATE PV_INTERFAZ_SUSVOL_TO
                                        SET    COD_ESTADO  = 2,
                                               FEC_PROCESO = SYSDATE, --Codigo 2= error
                                               NOM_USUARIO = V_NOM_USUARIO,
                                               NUM_OS      = V_NUM_OS
                                        WHERE  NUM_ABONADO = V_NUM_ABONADO
                                        AND    COD_ACTABO  = V_COD_ACTABO;

                                END IF;
                                
                                
                                
                                delete from  PV_TMPPARAMETROS_SALIDA_TT
                                where
                                NUM_ABONADO=V_NUM_ABONADO;
        

                                COMMIT;
                END LOOP;
                CLOSE C1;


            VP_RESULTADO := 1;
            COMMIT;

        EXCEPTION
            WHEN ERROR_PROCESO THEN
                 VP_SQLCODE      := SQLCODE;
                 VP_SQLERRM      := SQLERRM;
                 VP_RESULTADO    := 0;
            WHEN OTHERS THEN
                 VP_RESULTADO := 0;
                 VP_SQLCODE      := SQLCODE;
                 VP_SQLERRM      := SQLERRM;
    END;
END PV_PRC_SUSVOL_MASIVO_PR;


PROCEDURE PV_PRC_PROCSUSVOL_PR( VP_NUM_ABONADO     IN    ICC_MOVIMIENTO.NUM_ABONADO%TYPE,
                              VP_FEC_EJECUCION     IN    PV_INTERFAZ_SUSVOL_TO.FEC_EJECUCION%TYPE,  
                              VP_COD_ESTADO        IN    PV_INTERFAZ_SUSVOL_TO.COD_ESTADO%TYPE,
                              VP_COD_ACTABO        IN    ICC_MOVIMIENTO.COD_ACTABO%TYPE,
                              VP_FEC_PROCESO       IN    PV_INTERFAZ_SUSVOL_TO.FEC_PROCESO%TYPE,
                              VP_NOM_USUARIO       IN    ICC_MOVIMIENTO.NOM_USUARORA%TYPE,
                              VP_NUM_OS            IN    CI_ORSERV.NUM_OS%TYPE,
                              VP_COD_CAUSA         IN    PV_INTERFAZ_SUSVOL_TO.COD_CAUSA%TYPE,  
                              VP_COD_FRAUDE        IN    PV_INTERFAZ_SUSVOL_TO.COD_FRAUDE%TYPE,
                              VP_COD_SERVICIOS     IN    PV_INTERFAZ_SUSVOL_TO.COD_SERVICIOS%TYPE,  
                              VP_IND_CENTRAL       IN    PV_INTERFAZ_SUSVOL_TO.IND_CENTRAL%TYPE,  
                              VP_COMENTARIO        IN    PV_INTERFAZ_SUSVOL_TO.COMENTARIO%TYPE, 
                              VP_BDATOS            IN    PV_INTERFAZ_SUSVOL_TO.BDATOS%TYPE,
                              VP_FEC_REHABILITA    IN    PV_INTERFAZ_SUSVOL_TO.FEC_REHABILITA%TYPE,
                              VP_TIP_SUSP          IN    PV_INTERFAZ_SUSVOL_TO.TIP_SUSP%TYPE,
                              VP_COD_OS            IN    PV_INTERFAZ_SUSVOL_TO.COD_OS%TYPE,
                              VP_RESULTADO         IN OUT NOCOPY INTEGER, 
                              VP_SQLCODE           IN OUT NOCOPY VARCHAR2,   
                              VP_SQLERRM           IN OUT NOCOPY VARCHAR2
                              )
IS

 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_PRC_PROCSUSVOL_PR
       Lenguaje="PL/SQL"
       Fecha="25-08-2009"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="VP_COD_OS" Tipo="codigo orden servicio"><param>>
          </Entrada>
          <Salida>
             <param nom="VP_RESULTADO" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="VP_SQLCODE" Tipo="CARACTER">codigo error oracle</param>>
             <param nom="VP_SQLERRM " Tipo="caracter">glosa</param>>
             <param nom="VP_NUMTRANSACABO " Tipo="NUMERICO">NUMERO TRANSACCION</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

        so_ooss_batch           pv_orden_servicio_qt;
        reg_pv_traspaso_cargos  pv_trasp_cargos;
        
        sn_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
        sv_mens_retorno     ge_errores_td.det_msgerror%TYPE;
        sn_num_evento       ge_errores_pg.evento;
        SV_record			refCursor;
   
   
        V_CODACT_AL         VARCHAR2(255);
        V_CODACT_BA         VARCHAR2(255);
        V_TIP_ESTADO        NUMBER(1);
        V_IDSECUENCIA       NUMBER(10);
        V_USUARIO           VARCHAR2(30);
        V_COD_OS            VARCHAR2(5);
        V_NUM_ABONADO       NUMBER(8);
        V_PERIODOFACT       NUMBER(7);
        V_COD_PLANTARIF     VARCHAR2(3);  																	
        V_FEC_VENCIMIENTO   DATE;         																	
        V_COD_ACTABO        VARCHAR2(2);  																	
        V_NUM_OSF           NUMBER(10);   																	
        V_DESCRIPCION       VARCHAR2(50); 																	
        V_TIP_PROCESA       NUMBER(2);    																	
        V_COD_MODGENER      VARCHAR2(3);  																	
        V_DES_ESTADOC       VARCHAR2(30); 																	
        V_NUM_CELULAR       NUMBER(15);   																	
        V_COD_CLIENTE       NUMBER(8);    																	
        V_COD_CUENTA        NUMBER(8);    																	
        V_COD_PRODUCTO      NUMBER(1);    																	
        V_TIP_TERMINAL      VARCHAR2(1);  																	
        V_TIP_PLANTARIF     VARCHAR2(1);  																	
        V_COD_SERVICIO      VARCHAR2(255);																	
        V_COD_ESTADO        NUMBER(3);    																	
        V_COD_OSANT	        VARCHAR2(5);  																	
        V_COMBINATORIA      VARCHAR2(20); 																	
        V_EVENTO            VARCHAR2(10);
        V_COD_PLANTARIF_NUE VARCHAR2(3);
        V_TIP_PLANTARIF_NUE VARCHAR2(1);
        V_COD_CLIENTE_NUE   NUMBER(8);                
        V_COD_CUENTA_NUE    NUMBER(8);                        
        V_NUM_MOVIMIENTO    NUMBER(9);	
        V_COD_CAUSA_EXC	    NUMBER(3);
        V_ABONADO_NUEVO     NUMBER(8);
        V_TIP_SUJETO        VARCHAR2(2);
        V_COD_CAUSA	        VARCHAR2(2);
        V_IND_PORTABLE      NUMBER(1);
        V_NUM_DIA           NUMBER(3);
        V_COD_VENDEDOR      NUMBER(6);
        V_PARAM1_MENS       VARCHAR2(255);
        V_NUM_CELU_PERS     VARCHAR2(15);
        V_COD_GRPSERV  	    VARCHAR2(2);
        V_COMENTARIO	    VARCHAR2(500);
        LV_COD_TIPLAN       VARCHAR2(1);
        V_COD_TECNOLOGIA    VARCHAR2(7);
        V_COD_PLANSERV      VARCHAR2(3); 
        V_COD_CICLO         NUMBER(2);
        V_COD_PLANCOM       NUMBER(6);
        V_NUM_MESES         NUMBER(2);
        V_COD_TIPOCONTRA    VARCHAR2(3);
        V_COD_CATEGORIA     VARCHAR2(3);
        V_COD_ANTIGUEDAD    NUMBER(3);
        V_NUM_MOVIMIENTOS   NUMBER(9);
        V_COD_PRESTACION    VARCHAR2(5);
        V_GRP_PRESTACION    VARCHAR2(5);  
        
     
        
        cursor_NumMovimiento        NUMBER(9)     ;        
        cursor_CodActAbo            VARCHAR2(2)   ;                  
        cursor_IndFactur            VARCHAR2(1)   ;
        cursor_DesServ              VARCHAR2(255) ;                  
        cursor_NumUnidades          NUMBER(6)     ;                       
        cursor_CodConcepto          NUMBER(4)     ;                       
        cursor_ImpCargo             NUMBER(14,4)  ;                       
        cursor_CodArticulo          NUMBER(6)     ;                       
        cursor_CodBodega            NUMBER(6)     ;                       
        cursor_NumSerie             VARCHAR2(25)  ;                  
        cursor_IndEquipo            VARCHAR2(1)   ;                  
        cursor_CodCliente           NUMBER(8)     ;        
        cursor_NumAbonado           NUMBER(8)     ;                       
        cursor_TipDto               VARCHAR2(1)   ;                  
        cursor_ValDto               NUMBER(14,4)  ;                       
        cursor_CodConceptoDTO       NUMBER(4)     ;                       
        cursor_NumCelular           NUMBER(15)    ;                       
        cursor_CodPlanCom           NUMBER(6)     ;                       
        cursor_ClaseServiciosAct    VARCHAR2(255) ;                  
        cursor_ClaseServiciosDes    VARCHAR2(255) ;                  
        cursor_Param1_mens          VARCHAR2(255) ;                  
        cursor_Param2_mens          VARCHAR2(255) ;                  
        cursor_Param3_mens          VARCHAR2(255) ;                  
        cursor_ClaseServicios       VARCHAR2(255) ;                  
        cursor_DesMoneda            VARCHAR2(255) ;                  
        cursor_CodMoneda            VARCHAR2(3)   ;                  
        cursor_CodCiclo             NUMBER(2)     ;                       
        cursor_FacCont              NUMBER(1)     ;                       
        cursor_PDesc                NUMBER(14,4)  ;                       
        cursor_ValMin               NUMBER(14,4)  ;                       
        cursor_ValMax               NUMBER(1)     ;                       
        cursor_CodError             NUMBER(1)     ;        
        cursor_DES_ERROR            VARCHAR2(255) ;
        
        LV_CANTIDAD                 NUMBER(2);
        FLG_ESTADO                  BOOLEAN;
        
        
         
        LD_SUSPE_AUX               PV_INTERFAZ_SUSVOL_TO.FEC_EJECUCION%TYPE;
        LN_NUM_AUX                 PV_INTERFAZ_SUSVOL_TO.NUM_OS%TYPE;
        LN_num_periodosusp         pv_det_suspvolprog_to.NUM_DET_SUS_VOL_PRG%TYPE;
        LD_FEC_FIN                 pv_suspvolprog_to.FEC_FIN%TYPE; 
        
        
        
        ERROR_EJEC        EXCEPTION;
        lv_des_error           ge_errores_pg.desevent;
        lv_ssql                ge_errores_pg.vquery;
      

BEGIN
 
        VP_RESULTADO    :=1; 
        VP_SQLCODE      :=0;   
        VP_SQLERRM      :=0;   
        LV_CANTIDAD     :=0;
        
        --*****valida si se puede realizar suspensiones**********
        
        lv_ssql:='PV_PRC_SUSVOL_MASIVO_PG.PV_PRC_VALIDADATOS_PR('||VP_NUM_ABONADO ||','|| VP_FEC_EJECUCION ||','||VP_COD_CAUSA  ||',';  
        lv_ssql:=lv_ssql || VP_COD_FRAUDE || ','|| VP_COD_SERVICIOS  || ','|| VP_FEC_REHABILITA ||' ,'|| VP_TIP_SUSP ||',';
        lv_ssql:=lv_ssql || VP_RESULTADO  || ','|| VP_SQLCODE        || ','|| VP_SQLERRM || ');';
        PV_PRC_SUSVOL_MASIVO_PG.PV_PRC_VALIDADATOS_PR(VP_NUM_ABONADO     ,
                                                      VP_FEC_EJECUCION   ,  
                                                      VP_COD_CAUSA       ,  
                                                      VP_COD_FRAUDE      ,
                                                      VP_COD_SERVICIOS   ,  
                                                      VP_FEC_REHABILITA  ,
                                                      VP_TIP_SUSP        ,
                                                      VP_RESULTADO       , 
                                                      VP_SQLCODE         ,   
                                                      VP_SQLERRM         );
                              

        IF VP_RESULTADO > 0 THEN
            RAISE ERROR_EJEC;
        END IF;
        --*****ontención data y generacion registros batch**********
        
        lv_ssql:='SELECT COD_CLIENTE,TIP_PLANTARIF,COD_PLANTARIF,NUM_CELULAR,COD_VENDEDOR,TIP_TERMINAL,';
        lv_ssql:=lv_ssql || ' COD_CUENTA,COD_TECNOLOGIA,COD_PLANSERV, COD_CICLO,COD_TIPCONTRATO';
        lv_ssql:=lv_ssql || ' FROM GA_ABOCEL WHERE NUM_ABONADO = ' ||VP_NUM_ABONADO;
        
        
        SELECT COD_CLIENTE   , TIP_PLANTARIF     , COD_PLANTARIF  ,
              NUM_CELULAR   , COD_VENDEDOR      , TIP_TERMINAL   ,
              COD_CUENTA    , COD_TECNOLOGIA    , COD_PLANSERV   ,
              COD_CICLO     , COD_TIPCONTRATO   , COD_PRESTACION 
        INTO  V_COD_CLIENTE , V_TIP_PLANTARIF   , V_COD_PLANTARIF, 
              V_NUM_CELULAR , V_COD_VENDEDOR    , V_TIP_TERMINAL ,
              V_COD_CUENTA  , V_COD_TECNOLOGIA  , V_COD_PLANSERV ,
              V_COD_CICLO   , V_COD_TIPOCONTRA  , V_COD_PRESTACION
        FROM GA_ABOCEL       
        WHERE NUM_ABONADO = VP_NUM_ABONADO;
        
        
        lv_ssql:='SELECT COD_PLANCOM FROM GA_CLIENTE_PCOM'; 
        lv_ssql:=lv_ssql || ' WHERE COD_CLIENTE = ' || V_COD_CLIENTE; 
        lv_ssql:=lv_ssql || ' AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE)';
        
        
        SELECT COD_PLANCOM 
        INTO   V_COD_PLANCOM
        FROM GA_CLIENTE_PCOM 
        WHERE COD_CLIENTE =  V_COD_CLIENTE 
        AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE);
        
        
        lv_ssql:=' SELECT NUM_MESES  FROM GA_PERCONTRATO  WHERE COD_PRODUCTO=1 AND ';
        lv_ssql:=lv_ssql || ' COD_TIPCONTRATO='||V_COD_TIPOCONTRA;
      
        SELECT NUM_MESES 
        INTO V_NUM_MESES
        FROM GA_PERCONTRATO 
        WHERE COD_PRODUCTO=1 AND
        COD_TIPCONTRATO=V_COD_TIPOCONTRA;
        lv_ssql:=' SELECT cod_categoria FROM ve_catplantarif Where Cod_producto = 1';
        lv_ssql:=lv_ssql || ' AND cod_plantarif = '||V_COD_PLANTARIF;
        lv_ssql:=lv_ssql || ' AND SYSDATE BETWEEN fec_efectividad AND NVL(fec_finefectividad,SYSDATE)';
        
        SELECT cod_categoria 
        INTO V_COD_CATEGORIA
        FROM ve_catplantarif
        Where Cod_producto = 1
        AND cod_plantarif = V_COD_PLANTARIF
        AND SYSDATE BETWEEN fec_efectividad AND NVL(fec_finefectividad,SYSDATE);
                        
        V_COD_ANTIGUEDAD:=0; -- PARA EL CASO DE LA SUSPENSION NO LO NECESITA                 
        
        lv_ssql:='SELECT COD_TIPLAN FROM TA_PLANTARIF'; 
        lv_ssql:=lv_ssql || ' WHERE COD_PLANTARIF = '||V_COD_PLANTARIF;
        
        SELECT COD_TIPLAN ,GRP_PRESTACION
        INTO LV_COD_TIPLAN,V_GRP_PRESTACION
        FROM TA_PLANTARIF 
        WHERE COD_PLANTARIF = V_COD_PLANTARIF;
        lv_ssql:=' SELECT COD_ACTABO  FROM PV_ACTABO_TIPLAN';
        lv_ssql:=lv_ssql || ' WHERE COD_TIPMODI = '||VP_COD_ACTABO;
        lv_ssql:=lv_ssql || ' AND   COD_TIPLAN  = '||LV_COD_TIPLAN;
        
        
                 
        SELECT COD_ACTABO
        INTO  V_COD_ACTABO 
        FROM PV_ACTABO_TIPLAN
        WHERE COD_TIPMODI = VP_COD_ACTABO
        AND   COD_TIPLAN  = LV_COD_TIPLAN; 
        
        v_codact_al 	    :=null; 
        v_codact_ba	        :=null; 
        v_tip_estado	    :=null; 
        v_idsecuencia	    :=vp_num_os  ; 
        v_usuario 	        :=vp_nom_usuario ; 
        v_cod_os 	        :=vp_cod_os; 
        v_num_abonado       :=VP_NUM_ABONADO ; 
        v_periodofact       :=null; 
        v_fec_vencimiento   :=vp_fec_ejecucion;	
        v_num_osf 	        :=null; 
        v_descripcion	    :=null; 
        v_tip_procesa	    :=null; 
        v_cod_modgener      :=null;	
        v_des_estadoc       :=null; 
        v_cod_producto      :=1; 
        v_cod_servicio      :=null; 
        v_cod_estado 	    :=null; 
        v_cod_osant	        :=null; 
        v_combinatoria      :=null;	
        v_evento	        :=null; 
        v_cod_plantarif_nue :=V_COD_PLANTARIF; 
        v_tip_plantarif_nue :=V_TIP_PLANTARIF; 
        v_cod_cliente_nue   :=V_COD_CLIENTE; 
        v_cod_cuenta_nue    :=V_COD_CUENTA; 
        v_num_movimiento    :=null; 
        v_cod_causa_exc     :=null; 
        v_abonado_nuevo     :=null; 
        v_tip_sujeto        :='A'; 
        v_cod_causa         :=vp_cod_causa; 
        v_ind_portable      :=1; 
        v_num_dia           :=null; 
        v_param1_mens       :=null; 
        v_num_celu_pers     :=null; 
        v_cod_grpserv	    :=null; 
        v_comentario        :=vp_comentario; 

        so_ooss_batch                  := pv_inicia_estructuras_pg.pv_orden_servicio_qt_fn;
        so_ooss_batch.codact_al 	   := v_codact_al 	         ;
        so_ooss_batch.codact_ba	       := v_codact_ba	         ;
        so_ooss_batch.tip_estado	   := v_tip_estado	         ;
        so_ooss_batch.idsecuencia	   := v_idsecuencia	         ;
        so_ooss_batch.usuario 	       := v_usuario 	         ;
        so_ooss_batch.cod_os 	       := v_cod_os 	             ;
        so_ooss_batch.num_abonado 	   := v_num_abonado 	     ;
        so_ooss_batch.periodofact 	   := v_periodofact 	     ;
        so_ooss_batch.cod_plantarif    := v_cod_plantarif        ;
        so_ooss_batch.fec_vencimiento  := v_fec_vencimiento	     ;
        so_ooss_batch.cod_actabo 	   := v_cod_actabo 		     ;
        so_ooss_batch.num_osf 	       := v_num_osf 	         ;
        so_ooss_batch.descripcion	   := v_descripcion	         ;
        so_ooss_batch.tip_procesa	   := v_tip_procesa	         ;
        so_ooss_batch.cod_modgener	   := v_cod_modgener	     ;
        so_ooss_batch.des_estadoc 	   := v_des_estadoc 	     ;
        so_ooss_batch.num_celular 	   := v_num_celular 	     ;
        so_ooss_batch.cod_cliente 	   := v_cod_cliente 	     ;
        so_ooss_batch.cod_cuenta 	   := v_cod_cuenta 	         ;
        so_ooss_batch.cod_producto 	   := v_cod_producto 	     ;
        so_ooss_batch.tip_terminal 	   := v_tip_terminal 	     ;
        so_ooss_batch.tip_plantarif	   := v_tip_plantarif	     ;
        so_ooss_batch.cod_servicio 	   := v_cod_servicio 	     ;
        so_ooss_batch.cod_estado 	   := v_cod_estado 	         ;
        so_ooss_batch.cod_osant	       := v_cod_osant	         ;
        so_ooss_batch.combinatoria	   := v_combinatoria	     ;
        so_ooss_batch.evento		   := v_evento		         ;
        so_ooss_batch.cod_plantarif_nue:= v_cod_plantarif_nue	 ;
        so_ooss_batch.tip_plantarif_nue:= v_tip_plantarif_nue	 ;
        so_ooss_batch.cod_cliente_nue  := v_cod_cliente_nue	     ;
        so_ooss_batch.cod_cuenta_nue   := v_cod_cuenta_nue	     ;
        so_ooss_batch.num_movimiento   := v_num_movimiento       ;
        so_ooss_batch.cod_causa_exc	   := v_cod_causa_exc    	 ;
        so_ooss_batch.abonado_nuevo    := v_abonado_nuevo        ;
        so_ooss_batch.tip_sujeto       := v_tip_sujeto           ;
        so_ooss_batch.cod_causa        := v_cod_causa            ;
        so_ooss_batch.ind_portable     := v_ind_portable         ;
        so_ooss_batch.num_dia          := v_num_dia              ;
        so_ooss_batch.cod_vendedor     := v_cod_vendedor         ;
        so_ooss_batch.param1_mens      := v_param1_mens          ;
        so_ooss_batch.num_celu_pers    := v_num_celu_pers        ;
        so_ooss_batch.cod_grpserv	   := v_cod_grpserv	         ;
        so_ooss_batch.comentario	   := v_comentario           ;
        
        
        
        
       lv_ssql:='PV_ORDEN_SERVICIO_PG.PV_REGISTR_CAMB_PLAN_BATCH_PR(so_ooss_batch,sn_cod_retorno ,sv_mens_retorno, sn_num_evento)';
                       
       PV_ORDEN_SERVICIO_PG.PV_REGISTR_CAMB_PLAN_BATCH_PR(so_ooss_batch,
                                                          sn_cod_retorno,
                                                          sv_mens_retorno,
                                                          sn_num_evento);
                                                                          
                                                                          
                        IF sn_num_evento > 0 THEN
                            RAISE ERROR_EJEC;
                        END IF;      
                        
                        IF (V_GRP_PRESTACION = 'TM' OR V_GRP_PRESTACION = 'TF' OR V_GRP_PRESTACION = 'IE') THEN
                                    
                                    --*****obtención y registro de cargos en la tabla pv_traspaso_cargos**********
                                    
                                    lv_ssql:='SELECT PV_SEQ_NUMOS.NEXTVAL  FROM DUAL';
                                    
                                    SELECT PV_SEQ_NUMOS.NEXTVAL INTO V_NUM_MOVIMIENTOS FROM DUAL;
                                    
                                    lv_ssql:='PV_EJECUTA_TRANS_OS_PG.PV_FACHADA_PARAMETRO ('||V_NUM_MOVIMIENTOS||','||VP_COD_ACTABO||',1,'||V_COD_TECNOLOGIA||',2,0,'||'YX'||','||v_cod_plantarif||','||v_cod_plantarif||',';
                                    lv_ssql:= lv_ssql || LV_COD_TIPLAN||','|| v_cod_os||','|| v_cod_cliente|| ','|| v_num_abonado|| ','||' 0,'||V_COD_PLANSERV||','|| VP_COD_ACTABO||',';
                                    lv_ssql:= lv_ssql || V_COD_TIPOCONTRA||',0,'||V_NUM_MESES||','|| V_COD_ANTIGUEDAD||','||V_COD_CICLO||','|| v_num_celular||' ,1,'||V_COD_PLANCOM||',';
                                    lv_ssql:= lv_ssql ||'N'||','|| V_COD_TIPOCONTRA||','||V_NUM_MESES||','||'0,'||v_cod_causa||','|| v_cod_causa||','||V_COD_VENDEDOR||','||V_COD_ANTIGUEDAD||',0,';
                                    lv_ssql:= lv_ssql || v_cod_causa ||')';
                                    
                                    
                                    
                                    
                                    
                                    PV_EJECUTA_TRANS_OS_PG.PV_FACHADA_PARAMETRO (V_NUM_MOVIMIENTOS,VP_COD_ACTABO,1,V_COD_TECNOLOGIA,2,	0,'YX',v_cod_plantarif,v_cod_plantarif ,
                                                                                 LV_COD_TIPLAN, v_cod_os, v_cod_cliente , v_num_abonado , 0,V_COD_PLANSERV, VP_COD_ACTABO,
                                                                                 V_COD_TIPOCONTRA,0,V_NUM_MESES, V_COD_ANTIGUEDAD,V_COD_CICLO, v_num_celular ,1,V_COD_PLANCOM,
                                                                                 'N', V_COD_TIPOCONTRA,V_NUM_MESES,0,v_cod_causa, v_cod_causa,V_COD_VENDEDOR,V_COD_ANTIGUEDAD,0,
                                                                                 v_cod_causa,SV_record);
                                    
                                                 
                                     
                                     
                                     
                                     SELECT  COUNT(1) INTO LV_CANTIDAD FROM PV_TMPPARAMETROS_SALIDA_TT;
                                    
                                     dbms_output.put_line('CANTIDAD PV_TMPPARAMETROS_SALIDA_TT:'||LV_CANTIDAD);
                                     
                                                                            
                                     loop
                                     fetch SV_record into     cursor_NumMovimiento      ,  cursor_CodActAbo          ,  cursor_IndFactur          ,  cursor_DesServ            ,                  
                                                              cursor_NumUnidades        ,  cursor_CodConcepto        ,  cursor_ImpCargo           ,  cursor_CodArticulo        ,                       
                                                              cursor_CodBodega          ,  cursor_NumSerie           ,  cursor_IndEquipo          ,  cursor_CodCliente         ,        
                                                              cursor_NumAbonado         ,  cursor_TipDto             ,  cursor_ValDto             ,  cursor_CodConceptoDTO     ,                       
                                                              cursor_NumCelular         ,  cursor_CodPlanCom         ,  cursor_ClaseServiciosAct  ,  cursor_ClaseServiciosDes  ,                  
                                                              cursor_Param1_mens        ,  cursor_Param2_mens        ,  cursor_Param3_mens        ,  cursor_ClaseServicios     ,                  
                                                              cursor_DesMoneda          ,  cursor_CodMoneda          ,  cursor_CodCiclo           ,  cursor_FacCont            ,                       
                                                              cursor_PDesc              ,  cursor_ValMin             ,  cursor_ValMax             ,  cursor_CodError           ,        
                                                              cursor_DES_ERROR;
                                                              
                                     exit when SV_record%notfound;
                                     
                                          reg_pv_traspaso_cargos                   := pv_inicia_estructuras_pg.PV_INICIA_PV_TRASP_CARGOS_FN;
                                    
                                          dbms_output.put_line('Secuencial enviado :'||V_NUM_MOVIMIENTOS);
                                          dbms_output.put_line('Secuencial Recibido:'||cursor_NumMovimiento);
                                    
                                          IF TO_NUMBER(V_NUM_MOVIMIENTOS)< TO_NUMBER(cursor_NumMovimiento)  THEN
                                          
                                                  SELECT GE_SEQ_CARGOS.NEXTVAL INTO reg_pv_traspaso_cargos.num_cargo FROM DUAL;
                                          
                                                  dbms_output.put_line('itera 4');
                                          
                                                  cursor_IndFactur:=1;  
                                                  reg_pv_traspaso_cargos.cod_concepto       :=TO_NUMBER(cursor_CodConcepto);
                                                  reg_pv_traspaso_cargos.fec_alta           :=sysdate;
                                                  reg_pv_traspaso_cargos.imp_cargo          :=cursor_ImpCargo;
                                                  reg_pv_traspaso_cargos.cod_moneda         :=cursor_CodMoneda;
                                                  reg_pv_traspaso_cargos.cod_plancom        :=cursor_CodPlanCom;
                                                  reg_pv_traspaso_cargos.num_unidades       :=cursor_NumUnidades;
                                                  reg_pv_traspaso_cargos.ind_factur         :=cursor_IndFactur ;
                                                  reg_pv_traspaso_cargos.num_paquete        :=null;
                                                  reg_pv_traspaso_cargos.num_abonado        :=cursor_NumAbonado;
                                                  reg_pv_traspaso_cargos.cod_ciclfact       :=null;
                                                  reg_pv_traspaso_cargos.mes_garantia       :=null;
                                                  reg_pv_traspaso_cargos.num_preguia        :=null;
                                                  reg_pv_traspaso_cargos.num_guia           :=null;
                                                  reg_pv_traspaso_cargos.num_factura        :=0;
                                                  reg_pv_traspaso_cargos.cod_concepto_dto   :=cursor_CodConceptoDTO;
                                                  reg_pv_traspaso_cargos.val_dto            :=cursor_ValDto;
                                                  reg_pv_traspaso_cargos.tip_dto            :=cursor_TipDto;
                                                  reg_pv_traspaso_cargos.ind_cuota          :=null;                     
                                                  reg_pv_traspaso_cargos.ind_supertel       :=null;                     
                                                  reg_pv_traspaso_cargos.ind_manual         :=null;                     
                                                  reg_pv_traspaso_cargos.nom_usuarora       :=null;   
                                                  reg_pv_traspaso_cargos.cod_cliente        :=cursor_CodCliente;    
                                                  reg_pv_traspaso_cargos.cod_producto       :=1;                    
                                                  reg_pv_traspaso_cargos.num_transaccion    :=0;                    
                                                  reg_pv_traspaso_cargos.num_venta          :=0;                    
                                                  reg_pv_traspaso_cargos.num_terminal       :=cursor_NumCelular;                     
                                                  reg_pv_traspaso_cargos.num_serie          :=cursor_NumSerie;      
                                                  reg_pv_traspaso_cargos.cap_code           :=null;                     
                                                  reg_pv_traspaso_cargos.num_seriemec       :=null;  
                                                  reg_pv_traspaso_cargos.NUM_OS             :=v_idsecuencia;
                                        
                                                  lv_ssql:='PV_ORDEN_SERVICIO_PG.PV_INSERT_TRASPASO_CARGO_PR(reg_pv_traspaso_cargos,sn_cod_retorno,sv_mens_retorno,sn_num_evento)';
                                                  PV_ORDEN_SERVICIO_PG.PV_INSERT_TRASPASO_CARGO_PR(reg_pv_traspaso_cargos,
                                                                                                   sn_cod_retorno ,
                                                                                                   sv_mens_retorno,
                                                                                                   sn_num_evento);
                                                                                                   
                                                  dbms_output.put_line('Retorno de la inserción a la tabla PV_TRASPASO_CARGOS:'||sn_num_evento||'-'||sv_mens_retorno||'-'||sn_cod_retorno);                                                                       
                                                   IF sn_num_evento > 0 THEN
                                                      RAISE ERROR_EJEC;
                                                      
                                                   END IF; 
                                                   
                                                   
                                           END IF ;
                                           
                                           
                                     end loop;
                                     
                                     CLOSE SV_record;
                         END IF;
       
            IF  (v_cod_os 	='50019' OR v_cod_os 	='50020') THEN
            
            
                      SELECT  TO_DATE(FEC_EJECUCION,'DD-MM-YYYY'),NUM_OS 
                      INTO LD_SUSPE_AUX,LN_NUM_AUX
                      FROM  PV_INTERFAZ_SUSVOL_TO
                      WHERE
                      COD_ACTABO IN ('ST','S7')   AND
                      NUM_ABONADO = v_num_abonado AND
                      FEC_EJECUCION = (SELECT  MAX(FEC_EJECUCION)
                                       From PV_INTERFAZ_SUSVOL_TO
                                       Where  
                                       COD_ACTABO IN ('ST','S7') AND
                                       num_abonado = v_num_abonado);
                                       
                                       
                       update  pv_det_suspvolprog_to
                       set fec_rehabilitacion= v_fec_vencimiento,
                       num_os_reh=LN_NUM_AUX
                       where num_det_sus_vol_prg   in (select MAX(num_det_sus_vol_prg) from
                                                       pv_det_suspvolprog_to
                                                       where num_abonado =v_num_abonado
                                                       )
                       AND num_abonado =v_num_abonado;                    
            END IF;
            
            IF(v_cod_os ='50016' OR v_cod_os ='50018') THEN
            
                       SELECT  ga_seq_num_sus_vol_prg.NEXTVAL INTO LN_num_periodosusp FROM DUAL;
                       
                       SELECT  ADD_MONTHS (TRUNC (SYSDATE), 12)-1  INTO LD_FEC_FIN FROM DUAL;
            
                       INSERT INTO pv_suspvolprog_to
                       (num_periodosusp, num_abonado, cod_cliente, FEC_INICIO, fec_fin, dias_acum)
                       VALUES (1, v_num_abonado,  v_cod_cliente,   v_fec_vencimiento, LD_FEC_FIN,0);
            
            
                     INSERT INTO pv_det_suspvolprog_to 
                          (num_det_sus_vol_prg, num_abonado       , num_periodosusp_1 , 
                           num_periodosusp_2  , fec_solicitud     , fec_suspension    , 
                           fec_rehabilitacion , fec_actualizacion , dias_periodosusp_1,
                           dias_periodosusp_2 , estado            , cod_causal        , 
                           usuario            , num_os_sus        , num_os_reh
                          )
                   VALUES (LN_num_periodosusp,  v_num_abonado, 1, 
                           1, SYSDATE, v_fec_vencimiento, 
                           v_fec_vencimiento , SYSDATE, 0,
                           0, 'SUS',  v_cod_causa, 
                           v_usuario 	, v_idsecuencia,0
                          );   
            END IF;
       
        
                                          
         DBMS_OUTPUT.PUT_LINE('PASO OK ');
         VP_RESULTADO    :=1;     
EXCEPTION
        WHEN ERROR_EJEC THEN
             VP_RESULTADO     := 4;
             SN_cod_retorno   := 156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'PV_PRC_SUSVOL_MASIVO_PG.PV_PRC_PROCSUSVOL_PR';
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRC_SUSVOL_MASIVO_PG.PV_PRC_PROCSUSVOL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

             
             
             
        WHEN otherS THEN
             DBMS_OUTPUT.PUT_LINE('ERROR EN EL PROCESO:'||sqlerrm||'-'||sqlcode  );
             VP_RESULTADO     := 4;
             SN_cod_retorno   := 156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'PV_PRC_SUSVOL_MASIVO_PG.PV_PRC_PROCSUSVOL_PR'||SQLERRM;
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PRC_SUSVOL_MASIVO_PG.PV_PRC_PROCSUSVOL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

                  
                                                                         
                                                          
END PV_PRC_PROCSUSVOL_PR;  
  
PROCEDURE PV_VALIDA_SUSPENSIONES_PARCIAL(
                              VP_NUM_ABONADO       IN    ICC_MOVIMIENTO.NUM_ABONADO%TYPE,
                              VP_RESULTADO         IN OUT NOCOPY INTEGER, 
                              VP_SQLCODE           IN OUT NOCOPY VARCHAR2,   
                              VP_SQLERRM           IN OUT NOCOPY VARCHAR2)
IS

 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_VALIDA_SUSPENSIONES_PARCIAL
       Lenguaje="PL/SQL"
       Fecha="25-08-2009"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
            <param nom="VP_NUM_ABONADO" Tipo="NUMERO ABONADO"><param>>
          
          </Entrada>
          <Salida>
             <param nom="VP_RESULTADO" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="VP_SQLCODE" Tipo="CARACTER">codigo error oracle</param>>
             <param nom="VP_SQLERRM " Tipo="caracter">glosa</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */
 
 LV_TIP_SUSP     CONSTANT CHAR(1)  := 'P';
 LV_TIP_REGISTRO CONSTANT NUMBER(1):= 3;

 LV_VAR1         GA_ABOCEL.NUM_ABONADO%TYPE;

 
BEGIN

   VP_RESULTADO         :=0; 
   VP_SQLCODE           :=0;   
   VP_SQLERRM           :=0;   
   
		   SELECT NUM_ABONADO
  	       INTO LV_VAR1
		   FROM GA_SUSPREHABO
		   WHERE NUM_ABONADO = VP_NUM_ABONADO  
		   AND TIP_SUSP      = LV_TIP_SUSP
		   AND TIP_REGISTRO  < LV_TIP_REGISTRO;
		   VP_RESULTADO := 1;
       
EXCEPTION
		   WHEN NO_DATA_FOUND THEN
		         VP_RESULTADO := 0;
		   WHEN TOO_MANY_ROWS THEN
		         VP_RESULTADO:= 1;
		   WHEN OTHERS THEN
   		         VP_RESULTADO := 0;
                 VP_SQLCODE      := SQLCODE;
                 VP_SQLERRM      := SQLERRM;
                 
END PV_VALIDA_SUSPENSIONES_PARCIAL;      

PROCEDURE PV_PRC_VALIDADATOS_PR(
                              VP_NUM_ABONADO     IN    ICC_MOVIMIENTO.NUM_ABONADO%TYPE,
                              VP_FEC_EJECUCION     IN    PV_INTERFAZ_SUSVOL_TO.FEC_EJECUCION%TYPE,  
                              VP_COD_CAUSA         IN    PV_INTERFAZ_SUSVOL_TO.COD_CAUSA%TYPE,  
                              VP_COD_FRAUDE        IN    PV_INTERFAZ_SUSVOL_TO.COD_FRAUDE%TYPE,
                              VP_COD_SERVICIOS     IN    PV_INTERFAZ_SUSVOL_TO.COD_SERVICIOS%TYPE,  
                              VP_FEC_REHABILITA    IN    PV_INTERFAZ_SUSVOL_TO.FEC_REHABILITA%TYPE,
                              VP_TIP_SUSP          IN    PV_INTERFAZ_SUSVOL_TO.TIP_SUSP%TYPE,
                              VP_RESULTADO         IN OUT NOCOPY INTEGER, 
                              VP_SQLCODE           IN OUT NOCOPY VARCHAR2,   
                              VP_SQLERRM           IN OUT NOCOPY VARCHAR2)
                              
IS

 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_PRC_VALIDADATOS_PR
       Lenguaje="PL/SQL"
       Fecha="25-08-2009"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
            <param nom="VP_NUM_ABONADO" Tipo="NUMERO ABONADO"><param>>
            <param nom="VP_FEC_EJECUCION" Tipo="FECHA EJECUCIÓN"><param>>
            <param nom="VP_COD_CAUSA"  Tipo="CODIDO CAUSA SUSPENSIÓN"><param>>
            <param nom="VP_COD_FRAUDE" Tipo="CODIGO FRAUDE"><param>>
            <param nom="VP_COD_SERVICIOS" Tipo="codigo servicio"><param>>
            <param nom="VP_FEC_REHABILITA" Tipo="FECHA REHABILITACION><param>>
            <param nom="VP_TIP_SUSP " Tipo="TIPO SUSPENSIÓN"><param>>
          </Entrada>
          <Salida>
             <param nom="VP_RESULTADO" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="VP_SQLCODE" Tipo="CARACTER">codigo error oracle</param>>
             <param nom="VP_SQLERRM " Tipo="caracter">glosa</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */
 
 sFECR          DATE;
 LV_CANTIDAD    INTEGER(2);
 
BEGIN

   VP_RESULTADO         :=0; 
   VP_SQLCODE           :=0;   
   VP_SQLERRM           :=0;   
       


   If Trim(VP_FEC_REHABILITA) = '' Then
      sFECR := TO_DATE ('01-01-3000  01:01:00','DD-MM-YYYY HH24:MI:SS');
   Else
      sFECR := VP_FEC_REHABILITA;
   End If;
   
   If VP_TIP_SUSP  = 'P' Then --UNI-DIRECCIONAL
         -- EN DEFINICION
         NULL;
         
   ELSE                       --BI-DIRECCIONAL
            SELECT COUNT(1)
            INTO LV_CANTIDAD
            FROM GA_PETSR 
            WHERE 
            NUM_ABONADO = VP_NUM_ABONADO AND 
            TIP_SUSP = 'T'               AND 
            VP_FEC_EJECUCION   BETWEEN FEC_SUSPENSION AND NVL(FEC_REHABILITA, SYSDATE)   OR 
            TO_DATE(sFECR, 'DD-MM-YYYY HH24:MI:SS')  BETWEEN FEC_SUSPENSION AND NVL(FEC_REHABILITA, SYSDATE) OR 
            (VP_FEC_EJECUCION <= FEC_SUSPENSION AND   TO_DATE(sFECR, 'DD-MM-YYYY HH24:MI:SS') >= FEC_REHABILITA); 
            
            IF LV_CANTIDAD >0 THEN
              VP_RESULTADO         :=4; 
              VP_SQLCODE           :=4;   
              VP_SQLERRM           :=' El Abonado ya Tiene Asignada una Suspensión TOTAL Entre Fechas Coincidentes ';
            END IF;  
   END IF;


EXCEPTION
             WHEN OTHERS THEN
                 VP_RESULTADO     := 4;
                 VP_SQLCODE      := SQLCODE;
                 VP_SQLERRM      := SQLERRM;
                 
END PV_PRC_VALIDADATOS_PR;      
END;
/
SHOW ERRORS