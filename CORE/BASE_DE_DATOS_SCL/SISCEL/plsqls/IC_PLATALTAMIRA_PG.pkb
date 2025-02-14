CREATE OR REPLACE PACKAGE BODY IC_PLATALTAMIRA_PG AS

/*
<Documentacion TipoDoc = "CUERPO">
  <Elemento Nombre = "IC_PLATALTAMIRA_PG" Lenguaje = "PL/SQL" Fecha = "07-03-2005"
    Version = "1.0.0" Dise?ador = "Carlos Sellao" Programador = "Stuver Ca?ete" Ambiente = "Oracle 8i">
    <Descripcion> Funciones parametricas orientadas a la plataforma de prepago AltamirA </Descripcion>
    <Propietarios>
      <Prop>Interfaz con Centrales</Prop>
    </Propietarios>
  </Elemento>
</Documentacion>
*/

----------------------------------------------------------------------------
-- IC_UMBRALCADUC_FN--
----------------------------------------------------------------------------
FUNCTION IC_UMBRALCADUC_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
RETURN STRING IS
--
    LV_out        STRING(512);
    LN_umbral     pv_umbral_to.umbral%TYPE;
	LN_celular    icc_movimiento.num_celular%TYPE;
	LN_abonado    icc_movimiento.num_abonado%TYPE;
    error_proceso EXCEPTION;
	error_umbral EXCEPTION;
--
BEGIN

	   SELECT NVL(icc.num_celular,0), NVL(icc.num_abonado, 0)
	   INTO LN_celular, LN_abonado
       FROM icc_movimiento icc
	   WHERE icc.num_movimiento = EN_NUM_MOV;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

		IF (LN_celular = 0) OR (LN_abonado = 0) THEN
           RAISE error_umbral;
		END IF;


       SELECT pvu.num_dias
	   INTO LN_umbral
       FROM pv_umbral_to pvu
	   WHERE pvu.num_celular = LN_celular
	     AND pvu.num_abonado = LN_abonado;

       IF SQLCODE <> 0 THEN
         RAISE error_proceso;
       END IF;

	   LV_out := TO_CHAR(LN_umbral);
       RETURN LV_out;

EXCEPTION
    WHEN error_proceso THEN
	  RETURN 'ERROR IC_UMBRALCADUC_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN error_umbral THEN
	  LV_out := 'Valores  en Cero';
      RETURN 'ERROR IC_UMBRALCADUC_FN, SLQERRM:' || LV_out;
    WHEN OTHERS THEN
      RETURN 'ERROR IC_UMBRALCADUC_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;

----------------------------------------------------------------------------
-- IC_MECCONSULTA_FN--
----------------------------------------------------------------------------
FUNCTION IC_MECCONSULTA_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
RETURN STRING IS
--
    LV_out        STRING(512);
    LN_saldo      pv_umbral_to.cod_notificacion%TYPE;
	LN_celular    icc_movimiento.num_celular%TYPE;
	LN_abonado    icc_movimiento.num_abonado%TYPE;
    error_proceso EXCEPTION;
	error_saldo EXCEPTION;
--
BEGIN

	   SELECT NVL(icc.num_celular,0), NVL(icc.num_abonado, 0)
	   INTO LN_celular, LN_abonado
       FROM icc_movimiento icc
	   WHERE icc.num_movimiento = EN_NUM_MOV;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

		IF (LN_celular = 0) OR (LN_abonado = 0) THEN
           RAISE error_saldo;
		END IF;

 	   SELECT pvu.cod_notificacion
       INTO LN_saldo
       FROM pv_umbral_to pvu
	   WHERE pvu.num_celular = LN_celular
	     AND pvu.num_abonado = LN_abonado;

       IF SQLCODE <> 0 THEN
         RAISE error_proceso;
       END IF;

	   LV_out := TO_CHAR(LN_saldo);
       RETURN LV_out;

EXCEPTION
    WHEN error_proceso THEN
	  RETURN 'ERROR IC_MECCONSULTA_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN error_saldo THEN
	  LV_out := 'Valores  en Cero';
      RETURN 'ERROR IC_MECCONSULTA_FN, SLQERRM:' || LV_out;
    WHEN OTHERS THEN
      RETURN 'ERROR IC_MECCONSULTA_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;

----------------------------------------------------------------------------
-- IC_CAUSANOTIF_FN --
----------------------------------------------------------------------------
FUNCTION IC_CAUSANOTIF_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
RETURN STRING IS
--
    LV_out        STRING(512);
    LV_causa      pv_umbral_to.cod_causa_not%TYPE;
	LN_celular    icc_movimiento.num_celular%TYPE;
	LN_abonado    icc_movimiento.num_abonado%TYPE;
    error_proceso EXCEPTION;
	error_causa EXCEPTION;
--
BEGIN

	   SELECT NVL(icc.num_celular,0), NVL(icc.num_abonado, 0)
	   INTO LN_celular, LN_abonado
       FROM icc_movimiento icc
	   WHERE icc.num_movimiento = EN_NUM_MOV;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

		IF (LN_celular = 0) OR (LN_abonado = 0) THEN
           RAISE error_causa;
		END IF;


       SELECT pvu.cod_causa_not
   	   INTO LV_causa
       FROM pv_umbral_to pvu
	   WHERE pvu.num_celular = LN_celular
	     AND pvu.num_abonado = LN_abonado;

       IF SQLCODE <> 0 THEN
         RAISE error_proceso;
       END IF;

	   LV_out := LV_causa;
       RETURN LV_out;

EXCEPTION
    WHEN error_proceso THEN
	  RETURN 'ERROR IC_CAUSANOTIF_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN error_causa THEN
	  LV_out := 'Valores  en Cero';
      RETURN 'ERROR IC_CAUSANOTIF_FN, SLQERRM:' || LV_out;
    WHEN OTHERS THEN
      RETURN 'ERROR IC_CAUSANOTIF_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;

----------------------------------------------------------------------------
-- IC_PERVALIDEZ_FN --
----------------------------------------------------------------------------
FUNCTION IC_PERVALIDEZ_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
RETURN STRING IS
--
    LV_out         STRING(512);
    LN_valor      pv_icgenerica_to.valor1%TYPE;
    error_proceso EXCEPTION;
--
BEGIN

	   SELECT  pvi.valor1
	   INTO LN_valor
       FROM pv_icgenerica_to pvi
	   WHERE pvi.num_movimiento = EN_NUM_MOV;

       IF SQLCODE <> 0 THEN
        RAISE error_proceso;
       END IF;

       LV_out := to_char(trunc(LN_valor,0));

       RETURN LV_out;

EXCEPTION
    WHEN error_proceso THEN
	  RETURN 'ERROR IC_CLAVEALF_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR IC_CLAVEALF_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;

----------------------------------------------------------------------------
-- IC_ORIGENREC_FN--
----------------------------------------------------------------------------
FUNCTION IC_ORIGENREC_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
RETURN STRING IS
--
    LV_out        STRING(512);
    LV_valor      pv_icgenerica_to.valor2%TYPE;
    error_proceso EXCEPTION;
--
BEGIN

	   SELECT  pvi.valor2
	   INTO LV_valor
       FROM pv_icgenerica_to pvi
	   WHERE pvi.num_movimiento = EN_NUM_MOV;

       IF SQLCODE <> 0 THEN
        RAISE error_proceso;
       END IF;

       LV_out := LV_valor;

       RETURN LV_out;

EXCEPTION
    WHEN error_proceso THEN
	  RETURN 'ERROR IC_ORIGENREC_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR IC_ORIGENREC_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;

----------------------------------------------------------------------------
-- IC_PROMOREC_FN --
----------------------------------------------------------------------------
FUNCTION IC_PROMOREC_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
RETURN STRING IS
--
    LV_out        STRING(512);
    LV_valor      pv_icgenerica_to.valor3%TYPE;
    error_proceso EXCEPTION;
--
BEGIN

	   SELECT  pvi.valor3
	   INTO LV_valor
       FROM pv_icgenerica_to pvi
	   WHERE pvi.num_movimiento = EN_NUM_MOV;

       IF SQLCODE <> 0 THEN
        RAISE error_proceso;
       END IF;

       LV_out := LV_valor;

       RETURN LV_out;

EXCEPTION
    WHEN error_proceso THEN
	  RETURN 'ERROR IC_PROMOREC_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR IC_PROMOREC_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;

----------------------------------------------------------------------------
-- IC_IDIOMA_FN --
----------------------------------------------------------------------------
FUNCTION IC_IDIOMA_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
RETURN STRING IS
--
    LV_out        STRING(512);
    LV_valor      pv_icgenerica_to.valor2%TYPE;
    error_proceso EXCEPTION;
--
BEGIN

	   SELECT  pvi.valor2
	   INTO LV_valor
       FROM pv_icgenerica_to pvi
	   WHERE pvi.num_movimiento = EN_NUM_MOV;

       IF SQLCODE <> 0 THEN
        RAISE error_proceso;
       END IF;

       LV_out := LV_valor;

       RETURN LV_out;

EXCEPTION
    WHEN error_proceso THEN
	  RETURN 'ERROR IC_IDIOMA_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR IC_IDIOMA_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;


----------------------------------------------------------------------------
-- IC_CAUSAIDIOMA_FN --
----------------------------------------------------------------------------
FUNCTION IC_CAUSAIDIOMA_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
RETURN STRING IS
--
    LV_out        STRING(512);
    LV_valor      pv_icgenerica_to.valor3%TYPE;
    error_proceso EXCEPTION;
--
BEGIN

	   SELECT  pvi.valor3
	   INTO LV_valor
       FROM pv_icgenerica_to pvi
	   WHERE pvi.num_movimiento = EN_NUM_MOV;

       IF SQLCODE <> 0 THEN
        RAISE error_proceso;
       END IF;

       LV_out := LV_valor;

       RETURN LV_out;

EXCEPTION
    WHEN error_proceso THEN
	  RETURN 'ERROR IC_CAUSAIDIOMA_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR IC_CAUSAIDIOMA_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;


----------------------------------------------------------------------------                                                 
-- IC_CBPLAN_FN --                                                                                                           
----------------------------------------------------------------------------                                                 
FUNCTION IC_CBPLAN_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)                                                      
RETURN STRING IS                                                                                                             
    LV_out        STRING(512);                                                                                               
    LV_valor      TA_PLANTARIF.cod_plan_comverse%TYPE;                                                                       
	v_cod_uso ga_abocel.cod_uso%TYPE;                                                                                    
BEGIN                                                                                                                        
                                                                                                                             
-- Inicio inc_45617                                                                                                          
                                                                                                                             
SELECT COD_USO INTO  V_COD_USO                                                                                               
FROM GA_ABOCEL                                                                                                               
WHERE COD_SITUACION <> 'AAA'                                                                                                 
AND NUM_ABONADO = (SELECT NUM_ABONADO FROM ICC_MOVIMIENTO WHERE NUM_MOVIMIENTO = EN_NUM_MOV)                                 
UNION                                                                                                                        
SELECT COD_USO                                                                                                               
FROM GA_ABOAMIST                                                                                                             
WHERE COD_SITUACION <> 'AAA'                                                                                                 
AND NUM_ABONADO = (SELECT NUM_ABONADO FROM ICC_MOVIMIENTO WHERE NUM_MOVIMIENTO = EN_NUM_MOV);                                
-- Fin inc_45617                                                                                                             
                                                                                                                             
                                                                                                                             
-- Inicio 34734                                                                                                              
                                                                                                                             
if v_cod_uso = 2 then                                                                                                        
                                                                                                                             
	SELECT ta.cod_plan_comverse                                                                                          
	INTO  LV_valor                                                                                                       
	FROM  ta_plantarif ta, icc_movimiento ic                                                                             
	WHERE  ic.num_movimiento=EN_NUM_MOV                                                                                  
	AND   ic.plan=ta.cod_plantarif;                                                                                      
else                                                                                                                         
	SELECT ic.plan	-- Inicio inc_45617                                                                                  
	INTO  LV_valor                                                                                                       
	FROM  icc_movimiento ic                                                                                              
	WHERE  ic.num_movimiento=EN_NUM_MOV                                                                                  
	;               -- Fin inc_45617                                                                                     
end if;                                                                                                                      
                                                                                                                             
                                                                                                                             
	LV_out := LV_valor;                                                                                                  
                                                                                                                             
    RETURN LV_out;                                                                                                           
-- Fin 34734                                                                                                                 
EXCEPTION                                                                                                                    
    WHEN OTHERS THEN                                                                                                         
      RETURN 'ERROR IC_CBPLAN_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;                                   
END;                                                                                                                         


FUNCTION IC_MercadoContable_FN(
        EN_Num_Mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING IS
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_MercadoContable_FN"
                Lenguaje="PL/SQL"
                Fecha creación="01-03-2006"
                Creado por="Carlos Sellao H.."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>STRING</Retorno>
                <Descripción>Funcion para obtener el mercado contable</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_Num_Mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>
                                <param nom="LV_salida"       Tipo="CARACTER">Valor a retornar</param>
                                <param nom="LN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>
                                <param nom="LV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                                <param nom="LN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/

        LN_num_abonado    ga_abocel.num_abonado%TYPE;
        LN_cod_cliente    ga_abocel.cod_cliente%TYPE;
        LN_cod_direccion  ga_direccli.cod_direccion%TYPE;
        LV_cod_region     ge_direcciones.cod_region%TYPE;
        LV_cod_provincia  ge_direcciones.cod_provincia%TYPE;
        LV_cod_ciudad     ge_direcciones.cod_ciudad%TYPE;
        LN_mdo_contable   ge_ciudades.mdo_contable%TYPE;
	
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

        LV_salida VARCHAR2(512);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;

BEGIN

       sSql := 'SELECT icc.num_abonado';
       sSql := sSql||' INTO LN_num_abonado';
       sSql := sSql||' FROM icc_movimiento icc';
       sSql := sSql||' WHERE icc.num_movimiento = '||EN_NUM_MOV;

       SELECT 
	           icc.num_abonado 
	   INTO 
	           LN_num_abonado
       FROM 
	           icc_movimiento icc
       WHERE 
	           icc.num_movimiento = EN_NUM_MOV;

       BEGIN

          sSql := 'SELECT abo.cod_cliente';
          sSql := sSql||' INTO LN_cod_cliente';
          sSql := sSql||' FROM ga_abocel abo';
          sSql := sSql||' WHERE abo.num_abonado = '||TO_CHAR(LN_num_abonado);

          SELECT 
		        abo.cod_cliente
          INTO 
		        LN_cod_cliente
          FROM 
		        ga_abocel abo
          WHERE 
		        abo.num_abonado = LN_num_abonado;
       EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        BEGIN
                                sSql := 'SELECT abo.cod_cliente';
                                sSql := sSql||' INTO LN_cod_cliente';
                                sSql := sSql||' FROM ga_aboamist abo';
                                sSql := sSql||' WHERE abo.num_abonado = '||TO_CHAR(LN_num_abonado);

                                SELECT 
                	                  abo.cod_cliente
                                INTO 
              	                      LN_cod_cliente
                                FROM 
                                      ga_aboamist abo
                                WHERE 
                                      abo.num_abonado = LN_num_abonado;
                        EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                        LV_salida := 'FALSE';
                                        RETURN LV_salida;
                                WHEN OTHERS THEN
                                        LN_cod_retorno := CN_Err_Cliente;
                                        IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                                LV_mens_retorno := CV_Err_NoClasif;
                                        END IF;
                                        LV_des_error := 'IC_PLATALTAMIRA_PG.IC_MercadoContable_FN('||EN_num_mov||'); - ' || SQLERRM;
                                        LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PLATALTAMIRA_PG.IC_MercadoContable_FN',sSql,SQLCODE,LV_des_error);
                                        LV_salida := 'FALSE';
                                        RETURN LV_salida;
                        END;

                WHEN OTHERS THEN
                        LN_cod_retorno := CN_Err_Cliente;
                        IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                LV_mens_retorno := CV_Err_NoClasif;
                        END IF;
                        LV_des_error := 'IC_PLATALTAMIRA_PG.IC_MercadoContable_FN('||EN_num_mov||'); - ' || SQLERRM;
                        LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PLATALTAMIRA_PG.IC_MercadoContable_FN',sSql,SQLCODE,LV_des_error);
                        LV_salida := 'FALSE';
                        RETURN LV_salida;
        END;

        sSql := 'SELECT dir.cod_direccion';
        sSql := sSql||' INTO LN_cod_direccion';
        sSql := sSql||' FROM ga_direccli dir';
        sSql := sSql||' WHERE dir.cod_cliente = '||TO_CHAR(LN_cod_cliente);
        sSql := sSql||'   AND dir.cod_tipdireccion = 1';

        SELECT 
		      dir.cod_direccion
        INTO 
		      LN_cod_direccion
        FROM 
		      ga_direccli dir
        WHERE 
		      dir.cod_cliente=LN_cod_cliente
          AND dir.cod_tipdireccion = 1;

        sSql := 'SELECT NVL(dir.cod_provincia,CHR(0)), NVL(dir.cod_region,CHR(0)), NVL(dir.cod_ciudad,CHR(0))';
        sSql := sSql||' INTO LN_cod_provincia, LN_cod_region, LN_cod_ciudad';
        sSql := sSql||' FROM ge_direcciones dir';
        sSql := sSql||' WHERE dir.cod_direccion = '||TO_CHAR(LN_cod_direccion);

        SELECT 
		       NVL(dir.cod_provincia,CHR(0)), NVL(dir.cod_region,CHR(0)), NVL(dir.cod_ciudad,CHR(0))
        INTO 
		       LV_cod_provincia, LV_cod_region, LV_cod_ciudad
        FROM 
		       ge_direcciones dir
        WHERE 
               dir.cod_direccion = LN_cod_direccion;

        sSql := 'SELECT ciu.mdo_contable';
        sSql := sSql||' INTO LN_mdo_contable';
        sSql := sSql||' FROM ge_ciudades ciu';
        sSql := sSql||' WHERE ciu.cod_provincia = '||LV_cod_provincia;
        sSql := sSql||'   AND ciu.cod_region = '||LV_cod_region;
        sSql := sSql||'   AND ciu.cod_ciudad = '||LV_cod_ciudad;

        SELECT 
		       ciu.mdo_contable
        INTO 
               LN_mdo_contable
        FROM 
		       ge_ciudades ciu
        WHERE 
		      ciu.cod_provincia = LV_cod_provincia
          AND ciu.cod_region = LV_cod_region
		  AND ciu.cod_ciudad = LV_cod_ciudad;

        IF LN_mdo_contable IS NULL THEN
                LV_salida := 'FALSE';
                RETURN LV_salida;
        END IF;
		  
        RETURN TO_CHAR(LN_mdo_contable);			

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                LV_salida := 'FALSE';
                RETURN LV_salida;
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Ciudad;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PLATALTAMIRA_PG.IC_MercadoContable_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PLATALTAMIRA_PG.IC_MercadoContable_FN',sSql,SQLCODE,LV_des_error);
                LV_salida := 'FALSE';
                RETURN LV_salida;
END;


END IC_PLATALTAMIRA_PG;
/
SHOW ERRORS
