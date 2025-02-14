CREATE OR REPLACE TRIGGER PV_GA_SSABO_DELCARGO911_TG
AFTER UPDATE ON GA_SERVSUPLABO 
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
        LN_pos                                NUMBER(3);
        LN_MAX                                NUMBER(3);
        LN_pos2                               NUMBER(3);
        LN_MAX2                               NUMBER(3);
        LV_CADENA                             VARCHAR2(255);
        LV_CADENA2                            VARCHAR2(5);
        LV_CADENA_FINAL                       VARCHAR2(255);
        LV_SS_ASISTENCIA_911                  ged_parametros.val_parametro%TYPE;
        EO_NUM_ABONADO                        GA_ABOCEL.NUM_ABONADO%TYPE;
        EO_COD_CLIENTE                        GA_ABOCEL.COD_CLIENTE%TYPE;
        EO_COD_PROD_CONTRA                    PR_PRODUCTOS_CONTRATADOS_TO.COD_PROD_CONTRATADO%TYPE;
        EO_COD_CARGO_PROD_CONTRA              GA_SERV911CARGO_TD.COD_CARGO%TYPE;
        EO_NUM_ABONADO_PAGO                   GA_ABOCEL.NUM_ABONADO%TYPE;
        EO_COD_CLIENTE_PAGO                   GA_ABOCEL.COD_CLIENTE%TYPE;
        LV_COD_CLIENTE                        GA_ABOCEL.COD_CLIENTE%TYPE;
        EO_COD_PLANSERV                       GA_ABOCEL.COD_PLANSERV%TYPE;
        LV_COD_PLANSERV                       GA_ABOCEL.COD_PLANSERV%TYPE;
        EO_IND_COBPRORRATEA                   NUMBER;
        EO_COD_CONCEPTO                       GA_SERV911CARGO_TD.COD_CONCEPTO%TYPE;
        EO_FECHA_ALTA                         DATE;
        EO_FECHA_BAJA                         DATE;   
        EO_USUARIO                            GA_ABOCEL.NOM_USUARORA%TYPE;
        sn_cod_retorno                        ge_errores_td.cod_msgerror%TYPE;
        sv_mens_retorno                       ge_errores_td.det_msgerror%TYPE;
        sn_num_evento                         ge_errores_pg.evento;
        CV_error_no_clasif                    CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
        CV_cod_modulo                         CONSTANT VARCHAR2 (2)  := 'GA';
        lv_des_error                          ge_errores_pg.desevent;
        lv_ssql                               ge_errores_pg.vquery;
        LN_CANTIDAD                           NUMBER;
        lo_cargos_rec                         FA_CARGOS_REC_QT;
        
        ERROR_EXCEPTION   EXCEPTION;
        

BEGIN

        SELECT VAL_PARAMETRO 
        INTO LV_SS_ASISTENCIA_911 
        FROM GED_PARAMETROS 
        WHERE NOM_PARAMETRO = 'SS_ASISTENCIA_911';           
        
        
        LN_pos:=0;
        LN_MAX:=LENGTH(LV_SS_ASISTENCIA_911); 
        
        
        WHILE (LN_pos< NVL(LN_MAX,0)) LOOP
                LN_pos2 :=INSTR(LV_SS_ASISTENCIA_911,',');
                IF LN_POS2= 0 THEN 
                
                   LV_CADENA2:= SUBSTR(LV_SS_ASISTENCIA_911,1,LN_MAX -1);
                   LN_pos := lN_MAX+1;
                ELSE
                
                   LV_CADENA2:= SUBSTR(LV_SS_ASISTENCIA_911,1,LN_POS2 - 1);
        
                END IF;
                            
                
                IF (LV_CADENA2 = :OLD.COD_SERVSUPL AND :NEW.FEC_BAJACEN IS NOT NULL) THEN
                        
                        
                        eo_fecha_alta:=:NEW.FEC_BAJACEN;     
                        eo_fecha_baja:=:NEW.FEC_BAJACEN;
                        
                                 
                        
                        SELECT  COD_PLANSERV ,COD_CLIENTE
                        INTO LV_COD_PLANSERV ,LV_COD_CLIENTE
                        FROM GA_aBOCEL
                        WHERE NUM_ABONADO = :OLD.NUM_ABONADO
                        UNION
                        SELECT  COD_PLANSERV ,COD_CLIENTE
                        FROM GA_aBOAMIST
                        WHERE NUM_ABONADO = :OLD.NUM_ABONADO;
                                                            
                        
                        
                        
                        eo_cod_cliente:= LV_COD_CLIENTE;          
                        eo_num_abonado:=:OLD.NUM_ABONADO;          
                        eo_cod_prod_contra:=0;
                                         
                        eo_cod_cliente_pago:=LV_COD_CLIENTE;          
                        eo_num_abonado_pago:=:OLD.NUM_ABONADO;     
                        eo_cod_planserv:=LV_COD_PLANSERV;
                        eo_ind_cobprorratea:=0;     
                        eo_usuario   :=USER;   
                        
                        
                        BEGIN 
                                SELECT B.COD_CONCEPTO,
                                       B.COD_CARGO
                                into   eo_cod_concepto,
                                       eo_cod_cargo_prod_contra
                                FROM GA_SERV911CARGO_TD B
                                WHERE 
                                B.COD_servicio  = :OLD.COD_SERVICIO
                                AND B.COD_servsupl  = :OLD.COD_SERVSUPL;
                             
                        EXCEPTION                                              
                        
                           WHEN NO_DATA_FOUND THEN
                                eo_cod_concepto:=0; 
                        END;
                                   
                                        
                        IF eo_cod_concepto > 0 THEN
                                                  
                                                                        
                                       
                        
                                        BEGIN 
                                        
                                                SELECT COUNT(1) INTO LN_CANTIDAD FROM FA_CARGOS_REC_TO A
                                                WHERE  A.COD_CLIENTESERV     =LV_COD_CLIENTE AND
                                                       A.NUM_ABONADOSERV     =:OLD.NUM_ABONADO AND
                                                       A.COD_CARGO_CONTRATADO=eo_cod_cargo_prod_contra;
                                               
                                         EXCEPTION
                                                   WHEN NO_DATA_FOUND THEN  
                                                        RAISE ERROR_EXCEPTION ;
                                        END;       
                                                                        
                                        lo_cargos_rec := FA_CARGOS_REC_QT('','','','','','','','','','','','','','','','','','','','','','','','');
                                              
                                        lo_cargos_rec.cod_clienteserv      := eo_cod_cliente; 
                                        lo_cargos_rec.num_abonadoserv      := eo_num_abonado;
                                        lo_cargos_rec.cod_prod_contratado  := eo_cod_prod_contra;
                                        lo_cargos_rec.cod_cargo_contratado := eo_cod_cargo_prod_contra;
                                        lo_cargos_rec.cod_clientepago      := eo_cod_cliente_pago;
                                        lo_cargos_rec.num_abonadopago      := eo_num_abonado_pago;
                                        lo_cargos_rec.cod_planserv         := eo_cod_planserv;
                                        lo_cargos_rec.ind_cargopro         := eo_ind_cobprorratea;
                                        lo_cargos_rec.cod_concepto         := eo_cod_concepto;
                                        lo_cargos_rec.fec_alta             := eo_fecha_alta;
                                        lo_cargos_rec.fec_baja             := eo_fecha_baja;
                                        lo_cargos_rec.fec_desdecobr        := eo_fecha_alta;
                                        lo_cargos_rec.fec_hastacobr        := eo_fecha_baja;
                                        lo_cargos_rec.fec_desdebloc        := eo_fecha_alta;
                                        lo_cargos_rec.fec_hastabloc        := eo_fecha_baja;
                                        lo_cargos_rec.nom_usuario          := eo_usuario;

                                         DELETE FROM FA_CARGOS_REC_TO
                                          WHERE COD_CLIENTESERV       = eo_cod_cliente
                                            AND NUM_ABONADOSERV	      = eo_num_abonado
                                            AND COD_PROD_CONTRATADO   = eo_cod_prod_contra
                                            AND COD_CARGO_CONTRATADO  = eo_cod_cargo_prod_contra
                                            AND COD_CONCEPTO          = eo_cod_concepto;
                                        
                                          if (sn_cod_retorno != 0) then    
                                                SN_cod_retorno := -1;
                                                LV_des_error    :=  'PV_GA_SSABO_DELCARGO911_TG('||'); - ' || SQLERRM;
                                                SV_mens_retorno :=  CV_ERROR_NO_CLASIF;
                                                SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                                                    SN_num_evento,
                                                                    CV_COD_MODULO,
                                                                    SV_mens_retorno,
                                                                    '1.0',
                                                                    USER,
                                                                    'PV_GA_SSABO_DELCARGO911_TG',
                                                                    LV_sSql,
                                                                    SN_cod_retorno,
                                                                    LV_des_error); 
                                        end if;
                        ELSE
                                                SN_cod_retorno := -1;
                                                LV_des_error    :=  'PV_GA_SSABO_DELCARGO911_TG('||'); - ' || SQLERRM;
                                                SV_mens_retorno :=  CV_ERROR_NO_CLASIF;
                                                SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                                                    SN_num_evento,
                                                                    CV_COD_MODULO,
                                                                    SV_mens_retorno,
                                                                    '1.0',
                                                                    USER,
                                                                    'PV_GA_SSABO_DELCARGO911_TG',
                                                                    'NO TIENE CONCEPTO CONFIGURADO EL SS911',
                                                                    SN_cod_retorno,
                                                                    'NO TIENE CONCEPTO CONFIGURADO EL SS911');
                        
                        END IF; 
                END IF;
                
               
                if LN_pos < lN_MAX then
                LN_pos:=LN_pos + 1;
                LV_SS_ASISTENCIA_911:=SUBSTR(LV_SS_ASISTENCIA_911,LN_POS2+1,LN_MAX);
                end if;
                
        END LOOP;



    EXCEPTION
    
      WHEN ERROR_EXCEPTION  THEN
      
                LV_des_error    :=  'PV_GA_SSABO_DELCARGO911_TG('||'); - ' || SQLERRM;
                SV_mens_retorno :=  CV_ERROR_NO_CLASIF;
                SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(         SN_num_evento,
                                                                    CV_COD_MODULO,
                                                                    SV_mens_retorno,
                                                                    '1.0',
                                                                    USER,
                                                                    'PV_GA_SSABO_DELCARGO911_TG',
                                                                    'NO TIENE CARGOS RECURRENTES A ELIMINAR',
                                                                    SN_cod_retorno,
                                                                    'NO TIENE CARGOS RECURRENTES A ELIMINAR');
    
      WHEN OTHERS THEN         
             NULL;

END PV_GA_SSABO_DELCARGO911_TG;
/
SHOW ERRORS
