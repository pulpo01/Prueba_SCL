CREATE OR REPLACE PACKAGE BODY PR_PROCESOS_PROD_TO_PG
AS

PROCEDURE  PR_PROCESOS_PROD_I_PR( EO_PROC_PROD    IN  		 PR_PROCESOS_PROD_TD_QT,
								  EO_DTO		  IN		 BLOB,
								  EO_COD_PROCESO  OUT NOCOPY PR_PROCESOS_PROD_TD.COD_PROCESO%TYPE,
								  SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
								  SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
								  SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentación
  TipoDoc = "Procedure">>
   <Elemento
      Nombre = "PF_PRODUCTO_S_PR"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="ALEJANDRO DÍAZ"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>>
      <Descripción></Descripción>>
      <Parámetros>
         <Entrada>
            <param nom="EO_prod_padre" Tipo="estructura">Código de Producto Padre</param>>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_des_error	   ge_errores_pg.DesEvent;
LV_sSql			   ge_errores_pg.vQuery;
v_contador		   number(9);
ERROR_PARAMETROS EXCEPTION;

BEGIN
	SN_cod_retorno 	:= 0;
	SV_mens_retorno := ' ';
	SN_num_evento 	:= 0;

	IF EO_COD_PROCESO IS NULL THEN
		SELECT PR_PROCESOS_PROD_SQ.NEXTVAL
		INTO   EO_COD_PROCESO
		FROM   DUAL;
	END IF;

	LV_sSql := ' INSERT INTO PR_PROCESOS_PROD_TD ( ';
	LV_sSql := LV_sSql || ' COD_PROCESO, ';
	LV_sSql := LV_sSql || ' NUM_PROCESO, ';
	LV_sSql := LV_sSql || ' ORIGEN_PROCESO, ';
	LV_sSql := LV_sSql || ' FEC_PROCESO, ';
	LV_sSql := LV_sSql || ' ESTADO_PROCESO, ';
	LV_sSql := LV_sSql || ' PARAMETRO_PROCESO) ';
	LV_sSql := LV_sSql || ' VALUES (' ||EO_COD_PROCESO||', ';
	LV_sSql := LV_sSql || EO_PROC_PROD.NUM_PROCESO||', ';
	LV_sSql := LV_sSql || EO_PROC_PROD.ORIGEN_PROCESO||', ';
	LV_sSql := LV_sSql || EO_PROC_PROD.FEC_PROCESO||', ';
	LV_sSql := LV_sSql || EO_PROC_PROD.ESTADO_PROCESO||', ';
	LV_sSql := LV_sSql || '<DTO SERIALIZADO>)';

	INSERT INTO PR_PROCESOS_PROD_TD (
				COD_PROCESO,
				NUM_PROCESO,
				ORIGEN_PROCESO,
				FEC_PROCESO,
				ESTADO_PROCESO,
				PARAMETRO_PROCESO)
	VALUES (EO_COD_PROCESO,
            EO_PROC_PROD.NUM_PROCESO,
            EO_PROC_PROD.ORIGEN_PROCESO,
             to_date(EO_PROC_PROD.FEC_PROCESO, 'DD-MM-YYYY'),
            EO_PROC_PROD.ESTADO_PROCESO,
            EO_DTO);

EXCEPTION
    WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PR_PROCESOS_PROD_I_PR(Lista Procesos; '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PR_PROCESOS_PROD_TO_PG.PR_PROCESOS_PROD_I_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PR_PROCESOS_PROD_I_PR(Lista Procesos); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PR_PROCESOS_PROD_TO_PG.PR_PROCESOS_PROD_I_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PR_PROCESOS_PROD_I_PR;
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE  PR_PROCESOS_PROD_U_PR( EO_PROC_PROD  IN  PR_PROCESOS_PROD_TD_QT,
  			 						EO_DTO 		  IN		BLOB,
  						            SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						            SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						            SN_num_evento       OUT NOCOPY	ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PF_PRODUCTO_S_PR"
	      Lenguaje="PL/SQL"
	      Fecha="20-07-2007"
	      Versión="La del package"
	      Diseñador="Andrés Osorio"
	      Programador="ALEJANDRO DÍAZ"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_prod_padre" Tipo="estructura">Código de Producto Padre</param>>
	         </Entrada>
	         <Salida>
	            <param nom="SO_Lista_Productos" Tipo="Cursor">Lista de Productos</param>>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;
	v_contador		   number(9);
	ERROR_PARAMETROS EXCEPTION;
	LN_COD_PROCESO	 NUMBER;

		BEGIN
	        SN_cod_retorno 	:= 0;
        	SV_mens_retorno := ' ';
        	SN_num_evento 	:= 0;

			IF EO_PROC_PROD IS NULL THEN
			   RAISE ERROR_PARAMETROS;
			ELSE
				IF EO_DTO IS NULL THEN
					LV_sSql := ' UPDATE PR_PROCESOS_PROD_TD ';
					LV_sSql := LV_sSql || ' SET    FEC_PROCESO = ' || SYSDATE ||', ';
					LV_sSql := LV_sSql || ' ESTADO_PROCESO = ' || EO_PROC_PROD.ESTADO_PROCESO ||', ';
					LV_sSql := LV_sSql || ' WHERE  COD_PROCESO = ' || EO_PROC_PROD.COD_PROCESO;

					UPDATE PR_PROCESOS_PROD_TD
					SET    FEC_PROCESO = SYSDATE,
					    ESTADO_PROCESO = EO_PROC_PROD.ESTADO_PROCESO
					WHERE  COD_PROCESO = EO_PROC_PROD.COD_PROCESO;
				ELSE
					LV_sSql := ' UPDATE PR_PROCESOS_PROD_TD ';
					LV_sSql := LV_sSql || ' SET    FEC_PROCESO = ' || SYSDATE ||', ';
					LV_sSql := LV_sSql || ' ESTADO_PROCESO = ' || EO_PROC_PROD.ESTADO_PROCESO ||', ';
					LV_sSql := LV_sSql || ' PARAMETRO_PROCESO = <DTO SERIALIZADO> ';
					LV_sSql := LV_sSql || ' WHERE  COD_PROCESO = ' || EO_PROC_PROD.COD_PROCESO;

					UPDATE PR_PROCESOS_PROD_TD
					SET    FEC_PROCESO = SYSDATE,
						   ESTADO_PROCESO = EO_PROC_PROD.ESTADO_PROCESO,
						   PARAMETRO_PROCESO = EO_DTO
					WHERE  COD_PROCESO = EO_PROC_PROD.COD_PROCESO;
				END IF;
			END IF;

EXCEPTION
    WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PR_PROCESOS_PROD_U_PR(Lista Procesos; '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PR_PROCESOS_PROD_TO_PG.PR_PROCESOS_PROD_U_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PR_PROCESOS_PROD_U_PR(Lista Procesos); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PR_PROCESOS_PROD_TO_PG.PR_PROCESOS_PROD_U_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

	END PR_PROCESOS_PROD_U_PR;
  ---------------------------------------------------------------------------------------------------
    FUNCTION PR_PROCESOS_PROD_S_FN(
			            EO_NUM_PROCESO 	 	IN PR_PROCESOS_PROD_TD.NUM_PROCESO%TYPE,
			            EO_ORIGEN_PROCESO	IN PR_PROCESOS_PROD_TD.ORIGEN_PROCESO%TYPE)
						RETURN VARCHAR2
    IS
	/*
	<Documentación
	  TipoDoc = "Function">>
	   <Elemento
	      Nombre = "PPR_PROCESOS_PROD_S_FN"
	      Lenguaje="PL/SQL"
	      Fecha="27-09-2007"
	      Versión="La del package"
	      Diseñador=""
	      Programador=""
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_prod_padre" Tipo="estructura">Código de Producto Padre</param>>
	         </Entrada>
	         <Salida>
	            <param nom="SO_Lista_Productos" Tipo="Cursor">Lista de Productos</param>>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

	N_ESTADO_PROCESO   PR_PROCESOS_PROD_TD.ESTADO_PROCESO%TYPE;
	V_MAX_COD_PROCESO  PR_PROCESOS_PROD_TD.COD_PROCESO%TYPE;
    BEGIN

		SELECT MAX(COD_PROCESO)
		INTO V_MAX_COD_PROCESO
		FROM PR_PROCESOS_PROD_TD
		WHERE NUM_PROCESO=  EO_NUM_PROCESO
		AND ORIGEN_PROCESO = EO_ORIGEN_PROCESO;



		SELECT ESTADO_PROCESO
		INTO 	N_ESTADO_PROCESO
          FROM PR_PROCESOS_PROD_TD
         WHERE NUM_PROCESO =  EO_NUM_PROCESO
		 AND   ORIGEN_PROCESO = EO_ORIGEN_PROCESO
		 AND COD_PROCESO=V_MAX_COD_PROCESO;
		 RETURN N_ESTADO_PROCESO;

    EXCEPTION

	WHEN NO_DATA_FOUND THEN
		  RETURN '0';

	WHEN OTHERS THEN
		  RETURN '0';

    END PR_PROCESOS_PROD_S_FN;

-------------------------------------------------------------
PROCEDURE  PR_PROCESOS_PROD_SBLOB_PR( EO_PROC_PROD  IN  PR_PROCESOS_PROD_TD_QT,
          EO_DTO       OUT BLOB,
                  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
         SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
         SN_num_evento       OUT NOCOPY ge_errores_pg.evento)
    IS
  /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PR_PROCESOS_PROD_SBLOB_PR"
       Lenguaje="PL/SQL"
       Fecha="18-03-2009"
       Versión="La del package"
       Diseñador="Elizabeth Vera"
       Programador="Elizabeth Vera"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Obtiene DTO con toda la información del proceso</Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_PROC_PROD Tipo="estructura">Estructura de proceso</param>>
          </Entrada>
          <Salida>
             <param nom="EO_DTO" Tipo="BLOB">Objeto con toda la informacion del proceso</param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */
 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql      ge_errores_pg.vQuery;
 Num_proceso     varchar2(20);
    BEGIN
 
 SN_cod_retorno:=0;
        
  SELECT PARAMETRO_PROCESO INTO EO_DTO
  FROM PR_PROCESOS_PROD_TD
  WHERE COD_PROCESO=   EO_PROC_PROD.COD_PROCESO;

    EXCEPTION
  
 WHEN NO_DATA_FOUND THEN
    SN_cod_retorno := '-1';
    SV_mens_retorno := 'No encontro datos del proceso';
 WHEN OTHERS THEN
    SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PR_PROCESOS_PROD_SBLOB_PR; '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PR_PROCESOS_PROD_TO_PG.PR_PROCESOS_PROD_SBLOB_PR', LV_sSQL, SN_cod_retorno, LV_des_error );     

END PR_PROCESOS_PROD_SBLOB_PR;

-------------------------------------------------------------
PROCEDURE  PR_PROCESOS_PROD_ACTUALIZA_PR( EO_PROC_PROD  IN  PR_PROCESO_PRODUCTO_QT,
             EO_DTO    IN BLOB,
                     SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
           SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
          SN_num_evento       OUT NOCOPY ge_errores_pg.evento)
IS

  /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PR_PROCESOS_PROD_ACTUALIZA_PR"
       Lenguaje="PL/SQL"
       Fecha="18-03-2009"
       Versión="La del package"
       Diseñador="Elizabeth Vera"
       Programador="Elizabeth Vera"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Actualiza proceso con error, y graba DTO con informacion del proceso</Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_PROC_PROD Tipo="estructura">Estructura de proceso</param>>
             <param nom="EO_DTO" Tipo="BLOB">Objeto con toda la informacion del proceso</param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */
 
 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql      ge_errores_pg.vQuery;
 ERROR_PARAMETROS EXCEPTION;
 
  BEGIN
         SN_cod_retorno  := 0;
         SV_mens_retorno := ' ';
         SN_num_evento  := 0;  
   
   IF EO_PROC_PROD IS NULL THEN
      RAISE ERROR_PARAMETROS;
   ELSE
    IF EO_DTO IS NULL THEN
     LV_sSql := ' UPDATE PR_PROCESOS_PROD_TD ';
     LV_sSql := LV_sSql || ' SET    FEC_PROCESO = ' || SYSDATE ||', '; 
     LV_sSql := LV_sSql || ' ESTADO_PROCESO = ' || EO_PROC_PROD.ESTADO_PROCESO ||', ';
     LV_sSql := LV_sSql || ' WHERE  COD_PROCESO = ' || EO_PROC_PROD.COD_PROCESO;     
      
     UPDATE PR_PROCESOS_PROD_TD 
     SET    FEC_PROCESO = SYSDATE, 
         ESTADO_PROCESO = EO_PROC_PROD.ESTADO_PROCESO 
     WHERE  COD_PROCESO = EO_PROC_PROD.COD_PROCESO;
    ELSE 
     LV_sSql := ' UPDATE PR_PROCESOS_PROD_TD ';
     LV_sSql := LV_sSql || ' SET    FEC_PROCESO = ' || SYSDATE ||', '; 
     LV_sSql := LV_sSql || ' ESTADO_PROCESO = ' || EO_PROC_PROD.ESTADO_PROCESO ||', ';
     LV_sSql := LV_sSql || ' PARAMETRO_PROCESO = <DTO SERIALIZADO> ';
     LV_sSql := LV_sSql || ' WHERE  COD_PROCESO = ' || EO_PROC_PROD.COD_PROCESO;     
      
     UPDATE PR_PROCESOS_PROD_TD 
     SET    FEC_PROCESO = SYSDATE, 
         ESTADO_PROCESO = EO_PROC_PROD.ESTADO_PROCESO,
         PARAMETRO_PROCESO = EO_DTO,
         NUM_EVENTO = EO_PROC_PROD.NUM_EVENTO,
         COD_OS = EO_PROC_PROD.COD_OS,
         COD_CLIENTE = EO_PROC_PROD.COD_CLIENTE,
         NUM_ABONADO = EO_PROC_PROD.NUM_ABONADO
     WHERE  COD_PROCESO = EO_PROC_PROD.COD_PROCESO;
    END IF;                                
   END IF;

EXCEPTION
    WHEN ERROR_PARAMETROS THEN
       SN_cod_retorno := 98;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PR_PROCESOS_PROD_ACTUALIZA_PR(Proceso; '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PR_PROCESOS_PROD_TO_PG.PR_PROCESOS_PROD_ACTUALIZA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PR_PROCESOS_PROD_ACTUALIZA_PR(Proceso); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PR_PROCESOS_PROD_TO_PG.PR_PROCESOS_PROD_ACTUALIZA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );     
   
END PR_PROCESOS_PROD_ACTUALIZA_PR;
----------------------------
FUNCTION PV_PR_PROCESO_PRODUCTO_QT_FN
        RETURN PR_PROCESO_PRODUCTO_QT
IS

BEGIN
        RETURN PR_PROCESO_PRODUCTO_QT( NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
END PV_PR_PROCESO_PRODUCTO_QT_FN;
-----------------------------
PROCEDURE  PR_LISTA_PROCESOS_PEND_PR(SO_PROCESOS   OUT NOCOPY refCursor,
                    SN_cod_retorno      OUT NOCOPY  ge_errores_pg.coderror,
          SV_mens_retorno     OUT NOCOPY  ge_errores_pg.msgerror,
         SN_num_evento       OUT NOCOPY ge_errores_pg.evento)
IS
  /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PR_LISTA_PROCESOS_PEND_PR"
       Lenguaje="PL/SQL"
       Fecha="18-03-2009"
       Versión="La del package"
       Diseñador="Elizabeth Vera"
       Programador="Elizabeth Vera"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Obtiene una lista de procesos pendientes por error</Descripción>>
       <Parámetros>
          <Salida>
              <param nom="SO_PROCESOS Tipo="cursor">Lista de procesos pendientes por error</param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */
 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql      ge_errores_pg.vQuery;
 ERROR_PARAMETROS EXCEPTION;
 
 BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := ' ';
        SN_num_evento  := 0;  
  
  LV_sSql := 'OPEN SO_PROCESOS FOR ';
  LV_sSql := LV_sSql || 'SELECT COD_PROCESO, NUM_PROCESO, ORIGEN_PROCESO, FEC_PROCESO, ESTADO_PROCESO, ';
  LV_sSql := LV_sSql || 'NUM_EVENTO, COD_OS, COD_CLIENTE, NUM_ABONADO ';
  LV_sSql := LV_sSql || 'FROM PR_PROCESOS_PROD_TD ';
  LV_sSql := LV_sSql || 'WHERE ORIGEN_PROCESO IN (PV, VT) ';
  LV_sSql := LV_sSql || 'AND ESTADO_PROCESO = ERROR ';        
  LV_sSql := LV_sSql || 'ORDER BY COD_PROCESO DESC '; 
  
  OPEN SO_PROCESOS FOR
  SELECT COD_PROCESO, NUM_PROCESO, ORIGEN_PROCESO, FEC_PROCESO, ESTADO_PROCESO, 
      NUM_EVENTO, COD_OS, COD_CLIENTE, NUM_ABONADO
  FROM PR_PROCESOS_PROD_TD
  WHERE ORIGEN_PROCESO IN ('PV', 'VT')
  AND ESTADO_PROCESO = 'ERROR'
  ORDER BY FEC_PROCESO DESC;

            
 EXCEPTION
  WHEN OTHERS THEN
        SN_cod_retorno := 156;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
        END IF;
     LV_des_error   := 'PR_LISTA_PROCESOS_PEND_PR(Proceso); '||SQLERRM;
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PR_PROCESOS_PROD_TO_PG.PR_LISTA_PROCESOS_PEND_PR', LV_sSQL, SN_cod_retorno, LV_des_error );     
    
END PR_LISTA_PROCESOS_PEND_PR;
         
------------------------------------
--consultaProcesoProducto
PROCEDURE PR_CONS_PROCESO_PR( EO_PROC_PROD  IN OUT PR_PROCESO_PRODUCTO_QT,
              SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
          SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
         SN_num_evento       OUT NOCOPY ge_errores_pg.evento)
    IS
  /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PR_CONS_PROCESO_PR"
       Lenguaje="PL/SQL"
       Fecha="07-04-2009"
       Versión="La del package"
       Diseñador="Elizabeth Vera"
       Programador="Elizabeth Vera"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Obtiene información del proceso</Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_PROC_PROD Tipo="estructura">Estructura de proceso</param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */
 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql      ge_errores_pg.vQuery;
 Num_proceso     varchar2(20);
    BEGIN
 
 SN_cod_retorno:=0;
        
  SELECT NUM_PROCESO, 
      ORIGEN_PROCESO, 
      FEC_PROCESO, 
      ESTADO_PROCESO, 
      NUM_EVENTO, 
      COD_OS, 
      COD_CLIENTE, 
      NUM_ABONADO
  INTO EO_PROC_PROD.NUM_PROCESO, 
    EO_PROC_PROD.ORIGEN_PROCESO, 
    EO_PROC_PROD.FEC_PROCESO,
    EO_PROC_PROD.ESTADO_PROCESO,
    EO_PROC_PROD.NUM_EVENTO,
    EO_PROC_PROD.COD_OS, 
    EO_PROC_PROD.COD_CLIENTE,
    EO_PROC_PROD.NUM_ABONADO
  FROM PR_PROCESOS_PROD_TD
  WHERE COD_PROCESO =  EO_PROC_PROD.COD_PROCESO;
  
    EXCEPTION
  
 WHEN NO_DATA_FOUND THEN
    SN_cod_retorno := '1';
    SV_mens_retorno := 'No encontro datos del proceso';
 WHEN OTHERS THEN
    SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PR_CONS_PROCESO_PR; '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PR_PROCESOS_PROD_TO_PG.PR_CONS_PROCESO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );     

END PR_CONS_PROCESO_PR;
                            

--eliminaProcesoProducto
------------------------------------ 
PROCEDURE PR_ELIM_PROCESO_PR( EO_PROC_PROD  IN PR_PROCESO_PRODUCTO_QT,
              SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
          SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
         SN_num_evento       OUT NOCOPY ge_errores_pg.evento)
    IS
  /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PR_ELIM_PROCESO_PR"
       Lenguaje="PL/SQL"
       Fecha="07-04-2009"
       Versión="La del package"
       Diseñador="Elizabeth Vera"
       Programador="Elizabeth Vera"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Obtiene información del proceso</Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_PROC_PROD Tipo="estructura">Estructura de proceso</param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */
 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql      ge_errores_pg.vQuery;
 Num_proceso     varchar2(20);
    BEGIN
 
 SN_cod_retorno:=0;
        
  DELETE FROM PR_PROCESOS_PROD_TD
  WHERE COD_PROCESO =  EO_PROC_PROD.COD_PROCESO;
  
    EXCEPTION
  
 WHEN NO_DATA_FOUND THEN
    SN_cod_retorno := '1';
    SV_mens_retorno := 'No encontro datos del proceso';
 WHEN OTHERS THEN
    SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PR_ELIM_PROCESO_PR; '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PR_PROCESOS_PROD_TO_PG.PR_ELIM_PROCESO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );     

END PR_ELIM_PROCESO_PR;         
------------------------------------                     

END PR_PROCESOS_PROD_TO_PG;
/
SHOW ERRORS
