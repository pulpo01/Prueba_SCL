CREATE OR REPLACE PACKAGE BODY SISCEL.PV_EXCLUSION_PLANES_SS_PG AS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE  PV_VAL_PAD_EXCLUYENTES_PR(   EN_COD_PROD_OFERTADO IN pf_productos_ofertados_td.COD_PROD_OFERTADO%TYPE,
                                        EN_NIVEL_APLIC       IN pf_productos_ofertados_td.IND_NIVEL_APLICA%TYPE,
										EV_PLAN_DESTINO      IN ta_plantarif.cod_plantarif%TYPE,
										EN_CLIENTE_DESTINO   IN ge_clientes.cod_cliente%TYPE,
										SV_ID_ESPEC_PROD     OUT NOCOPY VARCHAR2,
										SV_TIPO_EXCLUYE      OUT NOCOPY VARCHAR2,
										SV_ID_PROD_OFERTA    OUT NOCOPY VARCHAR2,
										SN_COD_RETORNO       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
										SV_MENS_RETORNO      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
										SN_NUM_EVENTO        OUT NOCOPY ge_errores_pg.evento) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_VAL_PAD_EXCLUYENTES_PR"
           Lenguaje="PL/SQL"
       Fecha="25-03-2009"
       Versión="La del package"
       Diseñador="ORLANDO CABEZAS"
       Programador="ORLANDO CABEZAS"
       Ambiente Desarrollo="BD">
       <Retorno></Retorno>>
       <Descripción>Realiza la validacion de planes excluyentes</Descripción>>
       <Parámetros>
          <Entrada>
		  	    <param nom ="EN_COD_PROD_OFERTADO " tipo="NUMERICO">CODIGO PRODUCTO OFERTADO</param>
				<param nom ="EN_NIVEL_APLIC" tipo="caracter">nivel de la aplicacion</param>
				<param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
				<param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
				<param nom ="EV_ID_ESPEC_PROD" tipo="caracter">ID ESPECIFICACION PRODUCTO</param>
				<param nom ="EV_TIPO_EXCLUYE" tipo="CARACTER">TIPO EXCLUYENCIA</param>
				<param nom ="EV_ID_PROD_OFERTA" tipo="CARACTER">ID PRODUCTO OFERTADO</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
LN_COUNT		 NUMBER;

SO_LISTA_EXCLUYE_DEV refcursor;
SO_LISTA_SS_PLAN_DEV refcursor;
SO_LISTA_VALIDA      refcursor;
EN_ID_ESPEC_PROD     ps_especificaciones_prod_td.ID_ESPEC_PROD%TYPE;
lv_tipo_exclu        VARCHAR2(4) ; --('PLAN' o 'SS')
lv_codigo_exclu      VARCHAR2(10); --(cod_espec_prod o cod_servicio)
lv_id_exclu   		 VARCHAR2(10); --(id_prod_ofertado o cod_servsupl)	
LN_CANT              NUMBER;

flag_evalua_exclu        BOOLEAN;
lv_id_prod_ofertado      VARCHAR2(10);
LV_ID_PROD_OFERTADO_AUX  VARCHAR2(10);
LV_ID_PROD_OFERTADO_ENT  VARCHAR2(10);
lv_id_espec_prod         VARCHAR2(10);
lv_cod_espec_prod        pf_productos_ofertados_td.COD_ESPEC_PROD%type; 



lv_cod_prod_padre    ta_plantarif.COD_PROD_PADRE%type; 	
lv_cod_prod_hijo     pf_paquete_ofertado_to.COD_PROD_HIJO%type;

CURSOR C1 IS
SELECT COD_PROD_HIJO
FROM   PF_PAQUETE_OFERTADO_TO 
WHERE  COD_PROD_PADRE = LV_COD_PROD_PADRE; 


CURSOR C2 IS
SELECT C.ID_ESPEC_PROD
FROM   PR_PRODUCTOS_CONTRATADOS_TO A, PF_PRODUCTOS_OFERTADOS_TD B, PS_ESPECIFICACIONES_PROD_TD C  
WHERE  A.COD_CLIENTE_CONTRATANTE  = EN_CLIENTE_DESTINO
AND    A.NUM_ABONADO_CONTRATANTE  = 0
AND    A.COD_CLIENTE_BENEFICIARIO = A.COD_CLIENTE_CONTRATANTE
AND    A.NUM_ABONADO_BENEFICIARIO = A.NUM_ABONADO_CONTRATANTE
AND    B.COD_PROD_OFERTADO        = A.COD_PROD_OFERTADO
AND    C.COD_ESPEC_PROD           = B.COD_ESPEC_PROD; 


ERROR_PLAN_EXCLUYE EXCEPTION;

BEGIN
   SN_Cod_retorno 	 := 0;
   SV_Mens_retorno   := NULL;
   SN_Num_evento     := 0;
   FLAG_EVALUA_EXCLU := FALSE;
   LN_CANT           := 0;
	
	
   LV_sSql:=' SELECT COD_ESPEC_PROD, ID_PROD_OFERTADO';
   LV_sSql:=LV_sSql ||' FROM   PF_PRODUCTOS_OFERTADOS_TD'; 
   LV_sSql:=LV_sSql ||' WHERE  COD_PROD_OFERTADO = '||EN_COD_PROD_OFERTADO;
   LV_sSql:=LV_sSql ||' AND    IND_NIVEL_APLICA  = '||EN_NIVEL_APLIC;
			
   SELECT COD_ESPEC_PROD, ID_PROD_OFERTADO
   INTO   LV_COD_ESPEC_PROD, LV_ID_PROD_OFERTADO_ENT
   FROM   PF_PRODUCTOS_OFERTADOS_TD 
   WHERE  COD_PROD_OFERTADO = EN_COD_PROD_OFERTADO 
   AND    IND_NIVEL_APLICA  = EN_NIVEL_APLIC;
	
   LV_sSql:=LV_sSql ||' SELECT ID_ESPEC_PROD';
   LV_sSql:=LV_sSql ||' FROM   PS_ESPECIFICACIONES_PROD_TD'; 
   LV_sSql:=LV_sSql ||' WHERE  COD_ESPEC_PROD = '||LV_COD_ESPEC_PROD;
			
   SELECT ID_ESPEC_PROD
   INTO   EN_ID_ESPEC_PROD
   FROM   PS_ESPECIFICACIONES_PROD_TD 
   WHERE  COD_ESPEC_PROD = LV_COD_ESPEC_PROD;
	
	
   LV_sSql:='PV_EXCLUSION_PLANES_SS_PG.PV_LISTA_EXCLUYENTES_PLAN_PR('||EN_ID_ESPEC_PROD||','||EN_NIVEL_APLIC||')';
   PV_EXCLUSION_PLANES_SS_PG.PV_LISTA_EXCLUYENTES_PLAN_PR(EN_ID_ESPEC_PROD,EN_NIVEL_APLIC,SO_LISTA_EXCLUYE_DEV,
      SN_Cod_retorno,SV_Mens_retorno,SN_Num_evento);
		 
   IF SN_Cod_retorno = 0 THEN
      flag_evalua_exclu := TRUE;
   END IF; 

   IF FLAG_EVALUA_EXCLU THEN
      -- VALIDA  SI EL PLAN ADICIONAL ES EXCLUYENTE CON ALGUN SS POR DEFECTO AL PLAN TARIFARIO DESTINO  
      -- LISTA EXCLUYENTES 
      LOOP
         FETCH SO_LISTA_EXCLUYE_DEV INTO lv_tipo_exclu,lv_codigo_exclu,lv_id_exclu; 
         EXIT WHEN SO_LISTA_EXCLUYE_DEV%NOTFOUND;
		 
         IF trim(lv_tipo_exclu) = to_char(CV_2) THEN
			   
            LN_CANT := 0;
				  
            LV_sSql:=' SELECT  COUNT(1)'; 
            LV_sSql:=LV_sSql ||' FROM GAD_SERVSUP_PLAN WHERE';
            LV_sSql:=LV_sSql ||' COD_PLANTARIF = '|| EV_PLAN_DESTINO       ||'AND';
            LV_sSql:=LV_sSql ||' COD_SERVICIO  = TRIM('||lv_codigo_exclu||')  AND';
            LV_sSql:=LV_sSql ||' TIP_RELACION  = 3                            AND';
            LV_sSql:=LV_sSql ||' SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA';
				  
            BEGIN
				  
               SELECT  COUNT(1) 
               INTO LN_CANT 
               FROM GAD_SERVSUP_PLAN
               WHERE
               COD_PLANTARIF = EV_PLAN_DESTINO       AND
               COD_SERVICIO  = trim(lv_codigo_exclu) AND
               TIP_RELACION  = 3                     AND
               SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
               EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                      NULL;
            END;
			
            IF LN_CANT > 0 THEN
               SV_Mens_retorno   := 'Existe exclusión';
               SV_ID_ESPEC_PROD  := lv_codigo_exclu;
               SV_TIPO_EXCLUYE   := CV_2;
               SV_ID_PROD_OFERTA := LV_ID_PROD_OFERTADO_ENT;
					 
               RAISE ERROR_PLAN_EXCLUYE;
            END IF;
         END IF;
		       
      END LOOP;
	  close SO_LISTA_EXCLUYE_DEV;
	      
   END IF;	
	
 
  
   FLAG_EVALUA_EXCLU := FALSE;


   LV_sSql:='PV_EXCLUSION_PLANES_SS_PG.PV_LISTA_EXCLUYENTES_PLAN_PR('||EN_ID_ESPEC_PROD||','||EN_NIVEL_APLIC||')';
   PV_EXCLUSION_PLANES_SS_PG.PV_LISTA_EXCLUYENTES_PLAN_PR(EN_ID_ESPEC_PROD,EN_NIVEL_APLIC,SO_LISTA_EXCLUYE_DEV,
      SN_Cod_retorno,SV_Mens_retorno,SN_Num_evento);

   IF SN_Cod_retorno = 0 THEN
      FLAG_EVALUA_EXCLU := TRUE;
   END IF; 

   IF FLAG_EVALUA_EXCLU THEN
   	 
      OPEN C2;
      LOOP
         FETCH C2 INTO lv_id_espec_prod;
         EXIT WHEN C2%NOTFOUND;
							       
         -- VALIDA  SI EL PLAN ADICIONAL  ES EXCLUYENTE CON ALGUN PLAN ADICIONAL DEL CLIENTE DESTINO (ABONADO 0).   	
         -- LISTA EXCLUYENTES 
         LOOP
            FETCH SO_LISTA_EXCLUYE_DEV INTO lv_tipo_exclu,lv_codigo_exclu,lv_id_exclu; 
            EXIT WHEN SO_LISTA_EXCLUYE_DEV%NOTFOUND;
			
            IF trim(lv_tipo_exclu) = to_char(CV_1) AND trim(lv_id_exclu) = trim(lv_id_espec_prod) THEN
               SV_Mens_retorno   := 'Existe exclusión';
               SV_ID_ESPEC_PROD  := lv_codigo_exclu;
               SV_TIPO_EXCLUYE   := CV_1;
               SV_ID_PROD_OFERTA := LV_ID_PROD_OFERTADO_ENT;

               RAISE ERROR_PLAN_EXCLUYE;
			  
            END IF;
			      
         END LOOP;
		  
         PV_EXCLUSION_PLANES_SS_PG.PV_LISTA_EXCLUYENTES_PLAN_PR(EN_ID_ESPEC_PROD,EN_NIVEL_APLIC,SO_LISTA_EXCLUYE_DEV,SN_Cod_retorno,SV_Mens_retorno,SN_Num_evento); 
		 close  SO_LISTA_EXCLUYE_DEV;
		
      END LOOP;	
		
      CLOSE C2;
	
   END IF;
   
  
   -- VALIDA SI EL PLAN ADICIONAL ES EXCLUYENTE CON ALGUN PLAN ADICIONAL POR DEFECTO AL PLAN TARIFARIO DESTINO 

   FLAG_EVALUA_EXCLU := FALSE;


   LV_sSql:='PV_EXCLUSION_PLANES_SS_PG.PV_LISTA_EXCLUYENTES_PLAN_PR('||EN_ID_ESPEC_PROD||','||EN_NIVEL_APLIC||')';
   PV_EXCLUSION_PLANES_SS_PG.PV_LISTA_EXCLUYENTES_PLAN_PR(EN_ID_ESPEC_PROD,EN_NIVEL_APLIC,SO_LISTA_EXCLUYE_DEV,
      SN_Cod_retorno,SV_Mens_retorno,SN_Num_evento);

   IF SN_Cod_retorno = 0 THEN
      FLAG_EVALUA_EXCLU := TRUE;
   END IF; 

   IF FLAG_EVALUA_EXCLU THEN
   	 
	  LV_sSql:=' SELECT COD_PROD_PADRE';
	  LV_sSql:=LV_sSql ||'FROM   TA_PLANTARIF'; 
	  LV_sSql:=LV_sSql ||'WHERE  COD_PLANTARIF = ' ||EV_PLAN_DESTINO;
	 	
      SELECT COD_PROD_PADRE 
	  INTO   LV_COD_PROD_PADRE 
	  FROM   TA_PLANTARIF 
	  WHERE  COD_PLANTARIF = EV_PLAN_DESTINO;
	
      OPEN C1;
      LOOP
         FETCH C1 INTO LV_COD_PROD_HIJO;
         EXIT WHEN C1%NOTFOUND;
							       
         SV_Mens_retorno  := 'No existe configuración de producto ofertado';			
         LV_sSql:=' select cod_espec_prod,to_char(ID_PROD_OFERTADO)';
         LV_sSql:=LV_sSql ||' from   pf_productos_ofertados_td'; 
         LV_sSql:=LV_sSql ||' where  cod_prod_ofertado  = '||lv_cod_prod_hijo ||'and';
         LV_sSql:=LV_sSql ||' ind_nivel_aplica   = '||EN_NIVEL_APLIC;
    					
         SELECT COD_ESPEC_PROD, ID_PROD_OFERTADO
         INTO   LV_COD_ESPEC_PROD, LV_ID_PROD_OFERTADO_AUX
         FROM   PF_PRODUCTOS_OFERTADOS_TD 
         WHERE  COD_PROD_OFERTADO = LV_COD_PROD_HIJO 
         AND    IND_NIVEL_APLICA  = EN_NIVEL_APLIC;
								
         SV_Mens_retorno  := 'No existe configuración de especificación de producto';
         LV_sSql:=LV_sSql ||' select to_char(id_espec_prod)';
         LV_sSql:=LV_sSql ||' from   ps_especificaciones_prod_td'; 
         LV_sSql:=LV_sSql ||' where  cod_espec_prod  = '||lv_cod_espec_prod;
					
         SELECT ID_ESPEC_PROD
         INTO   LV_ID_ESPEC_PROD
         FROM   PS_ESPECIFICACIONES_PROD_TD 
         WHERE  COD_ESPEC_PROD = LV_COD_ESPEC_PROD;	 
	 
         -- VALIDA  SI EL PLAN ADICIONAL  ES EXCLUYENTE CON ALGUN PLAN ADICIONAL POR DEFECTO AL PLAN TARIFARIO DESTINO 	
         -- LISTA EXCLUYENTES 
         LOOP
            FETCH SO_LISTA_EXCLUYE_DEV INTO lv_tipo_exclu,lv_codigo_exclu,lv_id_exclu; 
            EXIT WHEN SO_LISTA_EXCLUYE_DEV%NOTFOUND;
			
            IF trim(lv_tipo_exclu) = to_char(CV_1) AND trim(lv_id_exclu) = trim(lv_id_espec_prod) THEN
               SV_Mens_retorno   := 'Existe exclusión';
               SV_ID_ESPEC_PROD  := lv_codigo_exclu;
               SV_TIPO_EXCLUYE   := CV_1;
               SV_ID_PROD_OFERTA := LV_ID_PROD_OFERTADO_ENT;

               RAISE ERROR_PLAN_EXCLUYE;
			  
            END IF;
			      
         END LOOP;
		  
         PV_EXCLUSION_PLANES_SS_PG.PV_LISTA_EXCLUYENTES_PLAN_PR(EN_ID_ESPEC_PROD,EN_NIVEL_APLIC,SO_LISTA_EXCLUYE_DEV,SN_Cod_retorno,SV_Mens_retorno,SN_Num_evento); 
		 close SO_LISTA_EXCLUYE_DEV; 
		
      END LOOP;	
		
      CLOSE C1;
	
   END IF;
   
   SV_Mens_retorno :='No existe exclusión';		

EXCEPTION
   WHEN NO_DATA_FOUND THEN
	  SN_Cod_retorno 	:= 0;
	  
   WHEN ERROR_PLAN_EXCLUYE THEN
	  SN_Cod_retorno 	:= 1;
	  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'PV_VAL_PAD_EXCLUYENTES_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'PV_EXCLUSION_PLANES_SS_PG.PV_VAL_PAD_EXCLUYENTES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	 

   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'PV_VAL_PAD_EXCLUYENTES_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'PV_EXCLUSION_PLANES_SS_PG.PV_VAL_PAD_EXCLUYENTES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	 
END PV_VAL_PAD_EXCLUYENTES_PR;


PROCEDURE PV_LISTA_PLANES_SS_CLIABO_PR (EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
										EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
										SO_LISTA_PLAN_SS   OUT NOCOPY refCursor,
										SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
										SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
										SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
							) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_LISTA_PLANES_SS_CLIABO_PR"
           Lenguaje="PL/SQL"
       Fecha="25-03-2009"
       Versión="La del package"
       Diseñador="ORLANDO CABEZAS"
       Programador="ORLANDO CABEZAS"
       Ambiente Desarrollo="BD">
       <Retorno></Retorno>>
       <Descripción>lista planes adicionales y servicios previamente contratados por el cliente - abonado</Descripción>>
       <Parámetros>
          <Entrada>
		  	   <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente ORIGEN</param>
  		  	   <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado ORIGEN</param>
          </Entrada>
          <Salida>
 	         <param Cursor="SO_LISTA_PLAN_SS"   Tipo="Cursor refCursor">        </param>> 
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;

LN_COUNT		 NUMBER;
LN_NUM_ABONADO   GA_ABOCEL.NUM_ABONADO%TYPE;


BEGIN
	SN_Cod_retorno 	:= 0;
	SV_Mens_retorno := NULL;
	SN_Num_evento 	:= 0;
	
	--ESTA LISTA DEVUELVE EL TIPO(1:PLAN, 2:SERVICIO) ,ID_PROD_OFERTADO Y ID_ESPEC_PROD  CONTRATADOS POS CLIENTE/ABONADO
		
	IF EN_ABONADO_ORIGEN >0 THEN
	
				LV_sSql:='OPEN SO_LISTA_PLAN_SS FOR';
                LV_sSql:=LV_sSql ||' SELECT '||'2'||',COD_SERVICIO , COD_SERVICIO';
                LV_sSql:=LV_sSql ||' FROM   GA_SERVSUPLABO ';
                LV_sSql:=LV_sSql ||' WHERE  NUM_ABONADO = '||EN_ABONADO_ORIGEN;
                LV_sSql:=LV_sSql ||' AND    IND_ESTADO  < 3';
                LV_sSql:=LV_sSql ||' UNION ';
                LV_sSql:=LV_sSql ||' SELECT '||'1'||', OFERTADO.ID_PROD_OFERTADO, ESPEC.ID_ESPEC_PROD'; 
                LV_sSql:=LV_sSql ||' FROM   PF_PRODUCTOS_OFERTADOS_TD OFERTADO, PS_ESPECIFICACIONES_PROD_TD ESPEC';
                LV_sSql:=LV_sSql ||' WHERE  ESPEC.COD_ESPEC_PROD        = OFERTADO.COD_ESPEC_PROD ';
                LV_sSql:=LV_sSql ||' AND    OFERTADO.COD_PROD_OFERTADO IN (SELECT COD_PROD_OFERTADO ';
                LV_sSql:=LV_sSql ||'                                       FROM   PR_PRODUCTOS_CONTRATADOS_TO '; 
                LV_sSql:=LV_sSql ||'                                       WHERE  COD_CLIENTE_BENEFICIARIO = '||EN_CLIENTE_ORIGEN;       
                LV_sSql:=LV_sSql ||'                                       AND    NUM_ABONADO_BENEFICIARIO = '||EN_ABONADO_ORIGEN;
                LV_sSql:=LV_sSql ||'                                       AND    COD_CLIENTE_CONTRATANTE  = COD_CLIENTE_BENEFICIARIO';
                LV_sSql:=LV_sSql ||'                                       AND    NUM_ABONADO_CONTRATANTE  = NUM_ABONADO_BENEFICIARIO  )';
                LV_sSql:=LV_sSql ||' UNION ';
                LV_sSql:=LV_sSql ||' SELECT '||'1'||', OFERTADO.ID_PROD_OFERTADO, ESPEC.ID_ESPEC_PROD';
                LV_sSql:=LV_sSql ||' FROM   PF_PRODUCTOS_OFERTADOS_TD OFERTADO, PS_ESPECIFICACIONES_PROD_TD ESPEC';
                LV_sSql:=LV_sSql ||' WHERE  ESPEC.COD_ESPEC_PROD        = OFERTADO.COD_ESPEC_PROD ';
                LV_sSql:=LV_sSql ||' AND    OFERTADO.COD_PROD_OFERTADO IN (SELECT  COD_PROD_OFERTADO '; 
                LV_sSql:=LV_sSql ||'                                       FROM   PR_PRODUCTOS_CONTRATADOS_TO ';
                LV_sSql:=LV_sSql ||'                                       WHERE  COD_CLIENTE_BENEFICIARIO = '||EN_CLIENTE_ORIGEN;       
                LV_sSql:=LV_sSql ||'                                       AND    NUM_ABONADO_BENEFICIARIO = 0 ';
                LV_sSql:=LV_sSql ||'                                       AND    COD_CLIENTE_CONTRATANTE  = COD_CLIENTE_BENEFICIARIO';
                LV_sSql:=LV_sSql ||'                                       AND    NUM_ABONADO_CONTRATANTE  = NUM_ABONADO_BENEFICIARIO  )';				
				
			    OPEN SO_LISTA_PLAN_SS FOR
                SELECT '2',COD_SERVICIO, COD_SERVICIO
                FROM   GA_SERVSUPLABO
                WHERE  NUM_ABONADO = EN_ABONADO_ORIGEN
                AND    IND_ESTADO  < 3
                UNION
                SELECT '1', OFERTADO.ID_PROD_OFERTADO, ESPEC.ID_ESPEC_PROD 
                FROM   PF_PRODUCTOS_OFERTADOS_TD OFERTADO, PS_ESPECIFICACIONES_PROD_TD ESPEC
                WHERE  ESPEC.COD_ESPEC_PROD        = OFERTADO.COD_ESPEC_PROD 
                AND	   OFERTADO.COD_PROD_OFERTADO IN (SELECT COD_PROD_OFERTADO 
                                                      FROM   PR_PRODUCTOS_CONTRATADOS_TO 
                                                      WHERE  COD_CLIENTE_BENEFICIARIO = EN_CLIENTE_ORIGEN       
                                                      AND    NUM_ABONADO_BENEFICIARIO = EN_ABONADO_ORIGEN
                                                      AND    COD_CLIENTE_CONTRATANTE  = COD_CLIENTE_BENEFICIARIO
                                                      AND    NUM_ABONADO_CONTRATANTE  = NUM_ABONADO_BENEFICIARIO  )
                UNION
                SELECT '1', OFERTADO.ID_PROD_OFERTADO, ESPEC.ID_ESPEC_PROD
                FROM   PF_PRODUCTOS_OFERTADOS_TD OFERTADO, PS_ESPECIFICACIONES_PROD_TD ESPEC
                WHERE  ESPEC.COD_ESPEC_PROD        = OFERTADO.COD_ESPEC_PROD 
                AND	   OFERTADO.COD_PROD_OFERTADO IN (SELECT  COD_PROD_OFERTADO 
                                                      FROM   PR_PRODUCTOS_CONTRATADOS_TO
                                                      WHERE  COD_CLIENTE_BENEFICIARIO = EN_CLIENTE_ORIGEN       
                                                      AND    NUM_ABONADO_BENEFICIARIO = 0
                                                      AND    COD_CLIENTE_CONTRATANTE  = COD_CLIENTE_BENEFICIARIO
                                                      AND    NUM_ABONADO_CONTRATANTE  = NUM_ABONADO_BENEFICIARIO  );				
				
    ELSE
	
	
				LV_sSql:='OPEN SO_LISTA_PLAN_SS FOR';
                LV_sSql:=LV_sSql ||' SELECT '||'2'||', COD_SERVICIO, ss';
                LV_sSql:=LV_sSql ||' FROM   GA_SERVSUPLABO ';
                LV_sSql:=LV_sSql ||' WHERE  NUM_ABONADO IN ( SELECT NUM_ABONADO FROM GA_ABOCEL WHERE COD_CLIENTE = '||EN_CLIENTE_ORIGEN||' AND COD_SITUACION = '||'AAA'||' )'; 
                LV_sSql:=LV_sSql ||' AND    IND_ESTADO   < 3 '; 
                LV_sSql:=LV_sSql ||' UNION  ';
                LV_sSql:=LV_sSql ||' SELECT '||'1'||', OFERTADO.ID_PROD_OFERTADO, ESPEC.ID_ESPEC_PROD '; 
                LV_sSql:=LV_sSql ||' FROM   PF_PRODUCTOS_OFERTADOS_TD OFERTADO, PS_ESPECIFICACIONES_PROD_TD ESPEC '; 
                LV_sSql:=LV_sSql ||' WHERE  ESPEC.COD_ESPEC_PROD        = OFERTADO.COD_ESPEC_PROD   ';
                LV_sSql:=LV_sSql ||' AND    OFERTADO.COD_PROD_OFERTADO IN (SELECT COD_PROD_OFERTADO '; 
                LV_sSql:=LV_sSql ||'                                       FROM   PR_PRODUCTOS_CONTRATADOS_TO ';  
                LV_sSql:=LV_sSql ||'                                       WHERE  COD_CLIENTE_BENEFICIARIO  = '||EN_CLIENTE_ORIGEN;
                LV_sSql:=LV_sSql ||'                                       AND    NUM_ABONADO_BENEFICIARIO IN ( SELECT NUM_ABONADO '; 
                LV_sSql:=LV_sSql ||'                                                                            FROM   GA_ABOCEL  ';
                LV_sSql:=LV_sSql ||'                                                                            WHERE  COD_CLIENTE   = '||EN_CLIENTE_ORIGEN;
                LV_sSql:=LV_sSql ||'                                                                            AND    COD_SITUACION = '||'AAA'||' )'; 
                LV_sSql:=LV_sSql ||'                                       AND    COD_CLIENTE_CONTRATANTE   = COD_CLIENTE_BENEFICIARIO';
                LV_sSql:=LV_sSql ||'                                       AND    NUM_ABONADO_CONTRATANTE   = NUM_ABONADO_BENEFICIARIO ) ';
				LV_sSql:=LV_sSql ||' UNION ';
                LV_sSql:=LV_sSql ||' SELECT '||'1'||', OFERTADO.ID_PROD_OFERTADO, ESPEC.ID_ESPEC_PROD ';
                LV_sSql:=LV_sSql ||' FROM   PF_PRODUCTOS_OFERTADOS_TD OFERTADO, PS_ESPECIFICACIONES_PROD_TD ESPEC';
                LV_sSql:=LV_sSql ||' WHERE  ESPEC.COD_ESPEC_PROD        = OFERTADO.COD_ESPEC_PROD ';
                LV_sSql:=LV_sSql ||' AND    OFERTADO.COD_PROD_OFERTADO IN (SELECT  COD_PROD_OFERTADO '; 
                LV_sSql:=LV_sSql ||'                                       FROM   PR_PRODUCTOS_CONTRATADOS_TO ';
                LV_sSql:=LV_sSql ||'                                       WHERE  COD_CLIENTE_BENEFICIARIO = '||EN_CLIENTE_ORIGEN;       
                LV_sSql:=LV_sSql ||'                                       AND    NUM_ABONADO_BENEFICIARIO = 0 ';
                LV_sSql:=LV_sSql ||'                                       AND    COD_CLIENTE_CONTRATANTE  = COD_CLIENTE_BENEFICIARIO ';
                LV_sSql:=LV_sSql ||'                                       AND    NUM_ABONADO_CONTRATANTE  = NUM_ABONADO_BENEFICIARIO  ) ';
				
			    OPEN SO_LISTA_PLAN_SS FOR
                SELECT '2', COD_SERVICIO, 'ss'
                FROM   GA_SERVSUPLABO
                WHERE  NUM_ABONADO IN ( SELECT NUM_ABONADO FROM GA_ABOCEL WHERE COD_CLIENTE = EN_CLIENTE_ORIGEN AND COD_SITUACION = 'AAA' ) 
                AND    IND_ESTADO   < 3 
                UNION 
                SELECT '1', OFERTADO.ID_PROD_OFERTADO, ESPEC.ID_ESPEC_PROD 
                FROM   PF_PRODUCTOS_OFERTADOS_TD OFERTADO, PS_ESPECIFICACIONES_PROD_TD ESPEC 
                WHERE  ESPEC.COD_ESPEC_PROD        = OFERTADO.COD_ESPEC_PROD  
                AND	   OFERTADO.COD_PROD_OFERTADO IN (SELECT COD_PROD_OFERTADO 
                                                      FROM   PR_PRODUCTOS_CONTRATADOS_TO  
                                                      WHERE  COD_CLIENTE_BENEFICIARIO  = EN_CLIENTE_ORIGEN
                                                      AND    NUM_ABONADO_BENEFICIARIO IN ( SELECT NUM_ABONADO 
                                                                                           FROM   GA_ABOCEL 
                                                                                           WHERE  COD_CLIENTE   = EN_CLIENTE_ORIGEN
                                                                                           AND    COD_SITUACION = 'AAA' ) 
                                                      AND    COD_CLIENTE_CONTRATANTE   = COD_CLIENTE_BENEFICIARIO
                                                      AND    NUM_ABONADO_CONTRATANTE   = NUM_ABONADO_BENEFICIARIO )
				UNION
                SELECT '1', OFERTADO.ID_PROD_OFERTADO, ESPEC.ID_ESPEC_PROD
                FROM   PF_PRODUCTOS_OFERTADOS_TD OFERTADO, PS_ESPECIFICACIONES_PROD_TD ESPEC
                WHERE  ESPEC.COD_ESPEC_PROD        = OFERTADO.COD_ESPEC_PROD 
                AND	   OFERTADO.COD_PROD_OFERTADO IN (SELECT  COD_PROD_OFERTADO 
                                                      FROM   PR_PRODUCTOS_CONTRATADOS_TO
                                                      WHERE  COD_CLIENTE_BENEFICIARIO = EN_CLIENTE_ORIGEN       
                                                      AND    NUM_ABONADO_BENEFICIARIO = 0
                                                      AND    COD_CLIENTE_CONTRATANTE  = COD_CLIENTE_BENEFICIARIO
                                                      AND    NUM_ABONADO_CONTRATANTE  = NUM_ABONADO_BENEFICIARIO  );
	END IF;														   											   

    SN_Cod_retorno 	:= 0;
	SV_Mens_retorno := 'TIENE LISTA PLANES ADICIONALES CONTRATADOS ó SERVICIOS SUPLEMENTARIOS'; 

EXCEPTION
   WHEN NO_DATA_FOUND THEN
	  SN_Cod_retorno 	:= 1;
	  SV_Mens_retorno   := 'NO TIENE LISTA PLANES ADICIONALES CONTRATADOS NI SERVICIOS SUPLEMENTARIOS'; 
   
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'PV_LISTA_PLANES_SS_CLIABO_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'PV_EXCLUSION_PLANES_SS_PG.PV_LISTA_PLANES_SS_CLIABO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	 
END PV_LISTA_PLANES_SS_CLIABO_PR;


PROCEDURE PV_LISTA_EXCLUYENTES_PLAN_PR (EN_ID_ESPEC_PROD   IN ps_especificaciones_prod_td.ID_ESPEC_PROD%TYPE,
										EN_NIVEL_APLIC     IN pf_productos_ofertados_td.IND_NIVEL_APLICA%TYPE,
                                     	SO_LISTA_EXCLUYE   OUT NOCOPY refCursor,
										SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	  								    SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
										SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
							) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_LISTA_EXCLUYENTES_PLAN_PR"
           Lenguaje="PL/SQL"
       Fecha="25-03-2009"
       Versión="La del package"
       Diseñador="ORLANDO CABEZAS"
       Programador="ORLANDO CABEZAS"
       Ambiente Desarrollo="BD">
       <Retorno></Retorno>>
       <Descripción>lista planes adicionales y servicios excluyentes para un plan adicional a contratar</Descripción>>
       <Parámetros>
          <Entrada>
		     <param nom ="EN_ID_ESPEC_PROD " tipo="NUMERICO">ID ESPEFICICACION PRODUCTO</param>
			 <param nom ="EN_NIVEL_APLIC   " tipo="CARACTER">NIVEL APLICACION PRODUCTO</param>
          </Entrada>
          <Salida>
 	         <param Cursor="SO_LISTA_EXCLUYE"   Tipo="Cursor refCursor">        </param>> 
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
LN_COUNT		 NUMBER;

BEGIN
	SN_Cod_retorno 	:= 0; -- encuentra registros
	SV_Mens_retorno := NULL;
	SN_Num_evento 	:= 0;
	
    LV_sSql:=LV_sSql ||'	OPEN SO_LISTA_EXCLUYE FOR';
	LV_sSql:=LV_sSql ||'	SELECT TO_CHAR(A.TIPO_COD_EXCLUYENTE_DESTINO), C.ID_PROD_OFERTADO, B.ID_ESPEC_PROD';
	LV_sSql:=LV_sSql ||'	FROM   PR_PROD_SS_EXCLUYENTES_TD   A ,';
	LV_sSql:=LV_sSql ||'	       PS_ESPECIFICACIONES_PROD_TD B ,';
	LV_sSql:=LV_sSql ||'	       PF_PRODUCTOS_OFERTADOS_TD   C';
	LV_sSql:=LV_sSql ||'	WHERE  A.TIPO_COD_EXCLUYENTE_ORIGEN  = '||CV_1;
	LV_sSql:=LV_sSql ||'	AND    A.COD_EXCLUYENTE_ORIGEN       = '||EN_ID_ESPEC_PROD;
	LV_sSql:=LV_sSql ||'	AND    A.TIPO_COD_EXCLUYENTE_DESTINO = '||CV_1;
	LV_sSql:=LV_sSql ||'	AND    SYSDATE                 BETWEEN A.FEC_INICIO_VIGENCIA AND A.FEC_TERMINO_VIGENCIA';	
	LV_sSql:=LV_sSql ||'	AND    B.ID_ESPEC_PROD               = A.COD_EXCLUYENTE_DESTINO';
	LV_sSql:=LV_sSql ||'	AND    SYSDATE                 BETWEEN B.FEC_INICIO_VIGENCIA AND B.FEC_TERMINO_VIGENCIA';	 
	LV_sSql:=LV_sSql ||'	AND    C.COD_ESPEC_PROD              = B.COD_ESPEC_PROD';          
	LV_sSql:=LV_sSql ||'	AND    C.IND_NIVEL_APLICA            = '||EN_NIVEL_APLIC; 
	LV_sSql:=LV_sSql ||'	AND    SYSDATE                 BETWEEN C.FEC_INICIO_VIGENCIA AND C.FEC_TERMINO_VIGENCIA';
	LV_sSql:=LV_sSql ||'	UNION ';
	LV_sSql:=LV_sSql ||'	SELECT TO_CHAR(A.TIPO_COD_EXCLUYENTE_ORIGEN), C.ID_PROD_OFERTADO, B.ID_ESPEC_PROD';
	LV_sSql:=LV_sSql ||'	FROM   PR_PROD_SS_EXCLUYENTES_TD   A ,';
	LV_sSql:=LV_sSql ||'	       PS_ESPECIFICACIONES_PROD_TD B ,';
	LV_sSql:=LV_sSql ||'	       PF_PRODUCTOS_OFERTADOS_TD   C';
	LV_sSql:=LV_sSql ||'	WHERE  A.TIPO_COD_EXCLUYENTE_DESTINO = '||CV_1;
	LV_sSql:=LV_sSql ||'	AND    A.COD_EXCLUYENTE_DESTINO      = '||EN_ID_ESPEC_PROD;
	LV_sSql:=LV_sSql ||'	AND    A.TIPO_COD_EXCLUYENTE_ORIGEN  = '||CV_1;
	LV_sSql:=LV_sSql ||'	AND    SYSDATE                 BETWEEN A.FEC_INICIO_VIGENCIA AND A.FEC_TERMINO_VIGENCIA';	
	LV_sSql:=LV_sSql ||'	AND    B.ID_ESPEC_PROD               = A.COD_EXCLUYENTE_ORIGEN';
	LV_sSql:=LV_sSql ||'	AND    SYSDATE                 BETWEEN B.FEC_INICIO_VIGENCIA AND B.FEC_TERMINO_VIGENCIA';	
	LV_sSql:=LV_sSql ||'	AND    C.COD_ESPEC_PROD              = B.COD_ESPEC_PROD';
	LV_sSql:=LV_sSql ||'	AND    C.IND_NIVEL_APLICA            = EN_NIVEL_APLIC'; 
	LV_sSql:=LV_sSql ||'	AND    SYSDATE                 BETWEEN C.FEC_INICIO_VIGENCIA AND C.FEC_TERMINO_VIGENCIA';
	LV_sSql:=LV_sSql ||'	UNION  ';
	LV_sSql:=LV_sSql ||'	SELECT TO_CHAR(A.TIPO_COD_EXCLUYENTE_DESTINO), A.COD_EXCLUYENTE_DESTINO, A.COD_EXCLUYENTE_DESTINO';
	LV_sSql:=LV_sSql ||'	FROM   PR_PROD_SS_EXCLUYENTES_TD   A ';
	LV_sSql:=LV_sSql ||'	WHERE  A.TIPO_COD_EXCLUYENTE_ORIGEN  = '||CV_1;
	LV_sSql:=LV_sSql ||'	AND    A.COD_EXCLUYENTE_ORIGEN       = '||EN_ID_ESPEC_PROD;
	LV_sSql:=LV_sSql ||'	AND    A.TIPO_COD_EXCLUYENTE_DESTINO = '||CV_2;
	LV_sSql:=LV_sSql ||'	AND SYSDATE BETWEEN A.FEC_INICIO_VIGENCIA AND A.FEC_TERMINO_VIGENCIA';

    	

	--ESTA LISTA DEVUELVE EL TIPO(1:PLAN, 2:SERVICIO) ,ID_PROD_OFERTADO Y ID_ESPEC_PRROD 
	
	OPEN SO_LISTA_EXCLUYE FOR
	SELECT TO_CHAR(A.TIPO_COD_EXCLUYENTE_DESTINO), C.ID_PROD_OFERTADO, B.ID_ESPEC_PROD
	FROM   PR_PROD_SS_EXCLUYENTES_TD   A ,
	       PS_ESPECIFICACIONES_PROD_TD B ,
	       PF_PRODUCTOS_OFERTADOS_TD   C
	WHERE  A.TIPO_COD_EXCLUYENTE_ORIGEN  = CV_1
	AND    A.COD_EXCLUYENTE_ORIGEN       = EN_ID_ESPEC_PROD
	AND    A.TIPO_COD_EXCLUYENTE_DESTINO = CV_1
	AND    SYSDATE                 BETWEEN A.FEC_INICIO_VIGENCIA AND A.FEC_TERMINO_VIGENCIA	
	AND    B.ID_ESPEC_PROD               = A.COD_EXCLUYENTE_DESTINO
	AND    SYSDATE                 BETWEEN B.FEC_INICIO_VIGENCIA AND B.FEC_TERMINO_VIGENCIA	 
	AND    C.COD_ESPEC_PROD              = B.COD_ESPEC_PROD          
	AND    C.IND_NIVEL_APLICA            = EN_NIVEL_APLIC 
	AND    SYSDATE                 BETWEEN C.FEC_INICIO_VIGENCIA AND C.FEC_TERMINO_VIGENCIA
	UNION
	SELECT TO_CHAR(A.TIPO_COD_EXCLUYENTE_ORIGEN), C.ID_PROD_OFERTADO, B.ID_ESPEC_PROD
	FROM   PR_PROD_SS_EXCLUYENTES_TD   A ,
	       PS_ESPECIFICACIONES_PROD_TD B ,
	       PF_PRODUCTOS_OFERTADOS_TD   C
	WHERE  A.TIPO_COD_EXCLUYENTE_DESTINO = CV_1
	AND    A.COD_EXCLUYENTE_DESTINO      = EN_ID_ESPEC_PROD
	AND    A.TIPO_COD_EXCLUYENTE_ORIGEN  = CV_1	
	AND    SYSDATE                 BETWEEN A.FEC_INICIO_VIGENCIA AND A.FEC_TERMINO_VIGENCIA	
	AND    B.ID_ESPEC_PROD               = A.COD_EXCLUYENTE_ORIGEN  
	AND    SYSDATE                 BETWEEN B.FEC_INICIO_VIGENCIA AND B.FEC_TERMINO_VIGENCIA	
	AND    C.COD_ESPEC_PROD              = B.COD_ESPEC_PROD              
	AND    C.IND_NIVEL_APLICA            = EN_NIVEL_APLIC 
	AND    SYSDATE                 BETWEEN C.FEC_INICIO_VIGENCIA AND C.FEC_TERMINO_VIGENCIA
	UNION
	SELECT TO_CHAR(A.TIPO_COD_EXCLUYENTE_DESTINO), A.COD_EXCLUYENTE_DESTINO, A.COD_EXCLUYENTE_DESTINO
	FROM   PR_PROD_SS_EXCLUYENTES_TD   A 
	WHERE  A.TIPO_COD_EXCLUYENTE_ORIGEN  = CV_1
	AND    A.COD_EXCLUYENTE_ORIGEN       = EN_ID_ESPEC_PROD
	AND    A.TIPO_COD_EXCLUYENTE_DESTINO = CV_2
	AND SYSDATE BETWEEN A.FEC_INICIO_VIGENCIA AND A.FEC_TERMINO_VIGENCIA;
	
EXCEPTION
   WHEN NO_DATA_FOUND THEN
	  SN_Cod_retorno 	:= 1; -- no hay registros
	  SV_Mens_retorno := 'NO EXISTE LISTA DE EXCLUYENTES'; 
   
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'PV_LISTA_EXCLUYENTES_PLAN_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'PV_EXCLUSION_PLANES_SS_PG.PV_LISTA_EXCLUYENTES_PLAN_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_LISTA_EXCLUYENTES_PLAN_PR;





PROCEDURE  PV_VALIDACION_EXCLUYENTES_PR (EN_CLIENTE_ORIGEN IN ge_clientes.cod_cliente%TYPE,
										EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
										EN_ID_ESPEC_PROD   IN ps_especificaciones_prod_td.ID_ESPEC_PROD%TYPE,
										EN_NIVEL_APLIC     IN pf_productos_ofertados_td.IND_NIVEL_APLICA%TYPE,
                                     	SO_LISTA_VALIDA    OUT NOCOPY refCursor,
										SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	  								    SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
										SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
							) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = " PV_VALIDACION_EXCLUYENTES_PR"
           Lenguaje="PL/SQL"
       Fecha="25-03-2009"
       Versión="La del package"
       Diseñador="ORLANDO CABEZAS"
       Programador="ORLANDO CABEZAS"
       Ambiente Desarrollo="BD">
       <Retorno></Retorno>>
       <Descripción>valida que el plan seleccionado cumple con la condicion de no ser excluyente con algun plan previamente contratado</Descripción>>
       <Parámetros>
          <Entrada>
  		    <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente ORIGEN</param>
  		  	<param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado ORIGEN</param>
		    <param nom ="EN_ID_ESPEC_PRODD" tipo="NUMERICO">id ESPEC producto</param>
			 <param nom ="EN_NIVEL_APLIC " tipo="NUMERICO">NIVEL APLICACION</param>
          </Entrada>
          <Salida>
 	         <param Cursor="SO_LISTA_VALIDA "   Tipo="Cursor refCursor">        </param>> 
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LN_COUNT		 NUMBER;

SO_LISTA_EXCLUYE_DEV refcursor;
SO_LISTA_SS_PLAN_DEV refcursor;

lv_tipo_exclu        VARCHAR2(4) ; --('PLAN' o 'SS')
lv_codigo_exclu      VARCHAR2(10); --(cod_espec_prod o cod_servicio)
lv_id_exclu   		 VARCHAR2(10); --(id_prod_ofertado o cod_servsupl)	

lv_tipo_contra       VARCHAR2(4) ; --('PLAN' o 'SS')
lv_codigo_contra     VARCHAR2(10); --(cod_espec_prod o cod_servicio)
lv_id_aux_contra     VARCHAR2(10); --(id_prod_ofertado o cod_servsupl)
lv_id_prod_ofertado  VARCHAR2(10); 	
flag_evalua_exclu    BOOLEAN;
flag_evalua_contra   BOOLEAN;
flag_encontro        BOOLEAN; 
LN_fila1             NUMBER;


BEGIN
   SN_Cod_retorno 	  := 0;
   SV_Mens_retorno    := NULL;
   SN_Num_evento 	  := 0;
   flag_evalua_exclu  := FALSE;
   flag_evalua_contra := FALSE;
   LN_fila1           := 0;
   flag_encontro      := FALSE;
   
   LV_sSql:='PV_EXCLUSION_PLANES_SS_PG.PV_LISTA_EXCLUYENTES_PLAN_PR( EN_ID_ESPEC_PROD , SO_LISTA_EXCLUYE_DEV ,SV_Mens_retorno,SN_Num_evento)';
   
   PV_EXCLUSION_PLANES_SS_PG.PV_LISTA_EXCLUYENTES_PLAN_PR(EN_ID_ESPEC_PROD,EN_NIVEL_APLIC,SO_LISTA_EXCLUYE_DEV,SN_Cod_retorno,SV_Mens_retorno,SN_Num_evento);
   
   if SN_Cod_retorno = 0 then
      flag_evalua_exclu :=true;
   end if; 
   
   LV_sSql:='PV_EXCLUSION_PLANES_SS_PG.PV_LISTA_PLANES_SS_CLIABO_PR(EN_CLIENTE_ORIGEN,EN_ABONADO_ORIGEN,SO_LISTA_SS_PLAN_DEV,';
   LV_sSql:= LV_sSql || 'SV_Mens_retorno,SN_Num_evento)';
   
   PV_EXCLUSION_PLANES_SS_PG.PV_LISTA_PLANES_SS_CLIABO_PR(EN_CLIENTE_ORIGEN,EN_ABONADO_ORIGEN,SO_LISTA_SS_PLAN_DEV,SN_Cod_retorno,SV_Mens_retorno,SN_Num_evento);
  
   if SN_Cod_retorno = 0 then
      flag_evalua_contra :=true;
   end if;
   
   ind_excluyente := 0;
  -- SI EXISTE LISTA DE EXCLUYENTES Y DE CONTRATADOS SE EVALUA   
   IF flag_evalua_exclu AND flag_evalua_contra THEN
      -- LISTA EXCLUYENTES  
      LOOP
         lv_id_exclu := '';
         FETCH SO_LISTA_EXCLUYE_DEV INTO lv_tipo_exclu,lv_codigo_exclu,lv_id_exclu; 
         EXIT WHEN SO_LISTA_EXCLUYE_DEV%NOTFOUND;
         -- LISTA PLANES ADICIONALES Y SERVICIOS CONTRATADOS 
         LOOP
            FETCH SO_LISTA_SS_PLAN_DEV INTO lv_tipo_contra,lv_codigo_contra,lv_id_aux_contra;  
            EXIT WHEN SO_LISTA_SS_PLAN_DEV%NOTFOUND;

               IF trim(lv_tipo_exclu) = trim(lv_tipo_contra) THEN
                  IF trim(lv_id_exclu) = trim(lv_id_aux_contra) THEN
                     -- LISTA DE PLANES Y SERVICIOS EN QUE SE ENCONTRO RELACION DE EXCLUYENTES 
                     FLAG_ENCONTRO := TRUE;  
                     tab_excluyente(ind_excluyente).t_v_tipo   :=lv_tipo_contra;
                     tab_excluyente(ind_excluyente).t_v_codigo :=lv_codigo_contra;
                     tab_excluyente(ind_excluyente).t_v_id     :=lv_id_aux_contra;
							
                     IF trim(lv_tipo_exclu)= to_char(CV_1) THEN
                        tab_excluyente(ind_excluyente).t_v_glosa :='La especificación:'|| EN_ID_ESPEC_PROD || ' es excluyente con el plan adicional:'||lv_codigo_contra ;
                     ELSE
                        tab_excluyente(ind_excluyente).t_v_glosa :='La especificación:'|| EN_ID_ESPEC_PROD || ' es excluyente con el servicio suplementario:'||lv_codigo_contra ;
                     END IF;
                                
                     ind_excluyente := ind_excluyente + 1;
						    
                  END IF;
               END IF;						   
         END LOOP;
					  
         
         LV_sSql:='PV_EXCLUSION_PLANES_SS_PG.PV_LISTA_PLANES_SS_CLIABO_PR';
         PV_EXCLUSION_PLANES_SS_PG.PV_LISTA_PLANES_SS_CLIABO_PR(EN_CLIENTE_ORIGEN,EN_ABONADO_ORIGEN,SO_LISTA_SS_PLAN_DEV,SN_Cod_retorno,SV_Mens_retorno,SN_Num_evento);
					   
      END LOOP;
      
      -- LLENADO Y SALIDA CURSOR FINAL   
			  
      IF ind_excluyente > 0 AND FLAG_ENCONTRO THEN
					
         LN_fila1:=0;
					
         FOR LN_fila1 IN 0..ind_excluyente -1 LOOP
             INSERT INTO 
             PV_TMPEXCLUYENTE_SALIDA_TT(TIPO_EXCLUYE,ID_PROD_OFERTADO_EXCL,ID_ESPEC_PROD_EXCL,DES_EXCLUYE )
             VALUES (
                     tab_excluyente(LN_fila1).t_v_tipo,
                     tab_excluyente(LN_fila1).t_v_codigo,
                     tab_excluyente(LN_fila1).t_v_id,
                     tab_excluyente(LN_fila1).t_v_glosa
                    );
         END LOOP;
					  
         LV_sSql:='OPEN SO_LISTA_VALIDA';
         OPEN SO_LISTA_VALIDA FOR
         SELECT TIPO_EXCLUYE, ID_PROD_OFERTADO_EXCL,ID_ESPEC_PROD_EXCL,DES_EXCLUYE
         FROM   PV_TMPEXCLUYENTE_SALIDA_TT;
					  
         DELETE PV_TMPEXCLUYENTE_SALIDA_TT ;
		 
      END IF;
      
  END IF;

  IF FLAG_ENCONTRO = FALSE THEN
     SN_Cod_retorno     := 1;
  END IF;
  
  
--  LV_SSQL:='CLOSE SO_LISTA_SS_PLAN_DEV';
  IF SO_LISTA_SS_PLAN_DEV%ISOPEN THEN
            CLOSE SO_LISTA_SS_PLAN_DEV;
  END IF;
-- LV_sSql:='close SO_LISTA_EXCLUYE_DEV';
     
    IF SO_LISTA_EXCLUYE_DEV%ISOPEN THEN
             CLOSE SO_LISTA_EXCLUYE_DEV;
    END IF;
   
EXCEPTION
   WHEN INVALID_CURSOR THEN 

            SN_Cod_retorno         := 0;
            SV_Mens_retorno    := ind_excluyente || '-' || LV_sSql  ;
            SN_Num_evento          := -1;
   --WHEN NO_DATA_FOUND THEN
   --   SN_Cod_retorno     := 1;
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := ' PV_VALIDACION_EXCLUYENTES_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'PV_EXCLUSION_PLANES_SS_PG. PV_VALIDACION_EXCLUYENTES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END  PV_VALIDACION_EXCLUYENTES_PR;
/********************************************************************************************************************************************/
PROCEDURE PV_LOG_EXCLUSION_PR(  EN_NUM_OS             IN pr_log_excluyentes_to.num_os%TYPE,
                                EN_COD_CLIENTE        IN pr_log_excluyentes_to.cod_cliente%TYPE,
                                EN_NUM_ABONADO        IN pr_log_excluyentes_to.num_abonado%TYPE,
                                EV_COD_EXCLUYENTE     IN pr_log_excluyentes_to.cod_excluyente%TYPE,
                                EN_TIPO_EXCLUYENTE    IN pr_log_excluyentes_to.tipo_cod_excluyente%TYPE,
                                EV_ID_PROD_OFERTADO   IN pr_log_excluyentes_to.id_prod_ofertado%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_PLANES_ADICIONALES_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Reliza la mantencion de productos para integrar con los cambios de plan</Descripción>>
       <Parámetros>
          <Entrada>
            <param nom ="EV_COD_OS           tipo="CARACTER">Código de OS</param>
            <param nom ="EN_NUM_OS           tipo="NUMERICO">Número de OS</param>
            <param nom ="EN_COD_CLIENTE      tipo="NUMERICO">Cliente de la OS</param>
            <param nom ="EN_NUM_ABONADO      tipo="NUMERICO">Abonado de la OS</param>
            <param nom ="EV_USUARIO_OS       tipo="CARACTER">Usuario Oracle</param>
            <param nom ="ED_FECHA_OS         tipo="FECHA">Fecha de OS</param>
            <param nom ="EV_ID_PROD_OFERTADO tipo="CARACTER">Plan Adicional Excluido</param>
            <param nom ="EN_TIPO_EXCLUYENTE  tipo="NUMERICO">Tipo de Plan Excluyente</param>
            <param nom ="EV_COD_EXCLUYENTE   tipo="CARACTER">Codigo Plan Excluyente</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;

LV_USUARIO_OS ci_orserv.usuario%TYPE;

BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    LV_sSql := 'SELECT cod_os, usuario';  
    LV_sSql := LV_sSql || ' FROM   pv_iorserv';
    LV_sSql := LV_sSql || ' WHERE  num_os = '||EN_NUM_OS;
    LV_sSql := LV_sSql || ' UNION';
    LV_sSql := LV_sSql || ' SELECT cod_os, usuario';
    LV_sSql := LV_sSql || ' FROM   ci_orserv';
    LV_sSql := LV_sSql || ' WHERE  num_os = '||EN_NUM_OS;    

    BEGIN
        SELECT usuario  
        INTO   LV_USUARIO_OS
        FROM   pv_iorserv
        WHERE  num_os = EN_NUM_OS
        UNION
        SELECT usuario
        FROM   ci_orserv
        WHERE  num_os = EN_NUM_OS;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            LV_USUARIO_OS := USER;
    END;
        

    LV_sSql := 'INSERT INTO PR_LOG_EXCLUYENTES_TO';
    LV_sSql := LV_sSql || ' ( NUM_OS, COD_CLIENTE, NUM_ABONADO, USUARIO_OS,';
    LV_sSql := LV_sSql || ' FECHA, ID_PROD_OFERTADO, TIPO_COD_EXCLUYENTE, COD_EXCLUYENTE)';
    LV_sSql := LV_sSql || ' VALUES';
    LV_sSql := LV_sSql || ' ( '||EN_NUM_OS||', ';
    LV_sSql := LV_sSql || ' '||EN_COD_CLIENTE||', ';
    LV_sSql := LV_sSql || ' '||EN_NUM_ABONADO||', ';
    LV_sSql := LV_sSql || ' '||LV_USUARIO_OS||', ';
    LV_sSql := LV_sSql || ' '||SYSDATE||', ';
    LV_sSql := LV_sSql || ' '||EV_ID_PROD_OFERTADO||', ';
    LV_sSql := LV_sSql || ' '||EN_TIPO_EXCLUYENTE||', ';
    LV_sSql := LV_sSql || ' '||EV_COD_EXCLUYENTE;
    LV_sSql := LV_sSql || ' )';

    INSERT INTO PR_LOG_EXCLUYENTES_TO
    ( NUM_OS,
      COD_CLIENTE,
      NUM_ABONADO,
      USUARIO_OS,
      FECHA,
      ID_PROD_OFERTADO,
      TIPO_COD_EXCLUYENTE,
      COD_EXCLUYENTE
    )
    VALUES
    ( EN_NUM_OS,
      EN_COD_CLIENTE,
      EN_NUM_ABONADO,
      LV_USUARIO_OS,
      SYSDATE,
      EV_ID_PROD_OFERTADO,
      EN_TIPO_EXCLUYENTE,
      EV_COD_EXCLUYENTE
    );

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=255;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_EXCLUSION_PLANES_SS_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'PV_EXCLUSION_PLANES_SS_PG.PV_LOG_EXCLUSION_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_EXCLUSION_PLANES_SS_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'PV_EXCLUSION_PLANES_SS_PG.PV_LOG_EXCLUSION_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_LOG_EXCLUSION_PR;

END PV_EXCLUSION_PLANES_SS_PG;
/
