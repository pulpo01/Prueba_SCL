CREATE OR REPLACE PACKAGE BODY FA_SERVICIOS_PG AS

 GV_ERROR_NO_CLASIF 	  VARCHAR2(100) := 'Error no clasificado';
 GV_SQL             	  VARCHAR2(1000);
 GV_FORMATO_FECHAS 		  VARCHAR2(30) := 'DDMMYYYYHH24MISS'; 

 FUNCTION FA_OBTENER_SECUENCIA_FN (EV_ID_SECUENCIA IN  VARCHAR2,
 			                       SN_COD_RETORNO  OUT NOCOPY NUMBER, 
			                       SV_MENS_RETORNO OUT NOCOPY VARCHAR2, 
			                       SN_NUM_EVENTO   OUT NOCOPY NUMBER) 
 RETURN VARCHAR2
/*  
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "FA_OBTENER_SECUENCIA_FN"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>Número de Secuencia</Retorno>
      <Descripcion>Recupera parametricamente la secuencia desde tabla Dual</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="EV_ID_SECUENCIA" Tipo="VARCHAR2">Nombre de la secuencia</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 AS
   Lv_Secuencia  	VARCHAR2(20);
   Lv_Nom_Secuencia VARCHAR2(100);
   ERROR_PROCEDURE  EXCEPTION;
 
 BEGIN
 	SN_cod_retorno   := 0;
	SV_mens_retorno  := NULL;
 	SN_num_evento    := 0;
	
 	Lv_Secuencia     := NULL;
	
 	Lv_Nom_Secuencia := ev_id_secuencia||'.NEXTVAL';	
	
	GV_SQL := 'SELECT ' ||  Lv_Nom_Secuencia || ' FROM DUAL ';
	 
    EXECUTE IMMEDIATE GV_SQL INTO LV_SECUENCIA; 

    RETURN LV_SECUENCIA;

 EXCEPTION	   
   WHEN OTHERS THEN
         SN_COD_RETORNO := 1268; -- 'Error en recuperar secuencia'

 	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'FA_SERVICIOS_PG.FA_OBTENER_SECUENCIA_FN', 
											       GV_SQL, SQLCODE, SQLERRM );
   	     RETURN NULL;
 END;

			   
 FUNCTION FA_OBTENERCANTIDADCUOTAS_FN (EN_NUMCUOTAS    IN  NUMBER,
                                       SN_COD_RETORNO  OUT NOCOPY NUMBER, 
                                       SV_MENS_RETORNO OUT NOCOPY VARCHAR2, 
                                       SN_NUM_EVENTO   OUT NOCOPY NUMBER)
 RETURN NUMBER
/*  
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "FA_OBTENERCANTIDADCUOTAS_FN"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Jorge Toro"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>Verifica si el número de cuotas es valido (1:true, 0:false)</Retorno>
      <Descripcion>Verifica si el número de cuotas es valido</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="EN_NUMCUOTAS" Tipo="NUMBER">Número de cuotas propuesto</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/ 
 AS
 
  LN_NUMCUOTAS NUMBER;  
   
 BEGIN
 
    SN_COD_RETORNO  := 0; 
    SV_MENS_RETORNO := NULL; 
    SN_NUM_EVENTO   := 0;  
 
    LN_NUMCUOTAS := 0;
  
    GV_SQL:='SELECT COUNT(1) ';
	GV_SQL:= GV_SQL || 'FROM   GE_TIPCUOTAS A ';
	GV_SQL:= GV_SQL || 'WHERE  A.NUM_CUOTAS    = ' || EN_NUMCUOTAS;  
  
    SELECT COUNT(1)
    INTO   LN_NUMCUOTAS
    FROM   GE_TIPCUOTAS A
    WHERE  A.NUM_CUOTAS = EN_NUMCUOTAS;
  
    IF LN_NUMCUOTAS > 0
    THEN
       RETURN 1; -- TRUE 
    ELSE
       RETURN 0; -- FALSE 
    END IF;
	
 EXCEPTION
    WHEN OTHERS THEN
         SN_COD_RETORNO := 2164; -- Error en Recuperar Número Cuotas.
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'FA_SERVICIOS_PG.FA_OBTENERCANTIDADCUOTAS_FN', 
												   GV_SQL, SQLCODE, SQLERRM );	
         RETURN 0; -- FALSE 

 END;		

 PROCEDURE FA_REGISTRAR_PROCESO_PR (EN_NUM_PROCESO 		      IN  FA_PROCESOS.NUM_PROCESO%type,
  								    EN_COD_TIPDOCUM 		  IN  FA_PROCESOS.COD_TIPDOCUM%type,
  								    EN_COD_VENDEDOR_AGENTE    IN  FA_PROCESOS.COD_VENDEDOR_AGENTE%type,
  								    EN_COD_CENTREMI 		  IN  FA_PROCESOS.COD_CENTREMI%type,
  								    ED_FEC_EFECTIVIDAD 	   	  IN  VARCHAR2,
  								    EV_NOM_USUARORA 		  IN  FA_PROCESOS.NOM_USUARORA%type,
  								    EV_LETRAAG  			  IN  FA_PROCESOS.LETRAAG%type,  
  								    EN_NUM_SECUAG 		   	  IN  FA_PROCESOS.NUM_SECUAG%type,
  								    EN_COD_TIPDOCNOT 	   	  IN  FA_PROCESOS.COD_TIPDOCNOT%type,
  								    EN_COD_VENDEDOR_AGENTENOT IN  FA_PROCESOS.COD_VENDEDOR_AGENTENOT%type,
  								    EV_LETRANOT  			  IN  FA_PROCESOS.LETRANOT%type,
								    EV_COD_CENTRNOT 		  IN  FA_PROCESOS.COD_CENTRNOT%type,
  								    EN_NUM_SECUNOT  		  IN  FA_PROCESOS.NUM_SECUNOT%type,
  								    EN_IND_ESTADO 			  IN  FA_PROCESOS.IND_ESTADO%type,
  								    EN_COD_CICLFACT 		  IN  FA_PROCESOS.COD_CICLFACT%type,
  								    EN_IND_NOTACREDC 		  IN  FA_PROCESOS.IND_NOTACREDC%type,
                                    SN_COD_RETORNO  		  OUT NOCOPY NUMBER, 
                                    SV_MENS_RETORNO 		  OUT NOCOPY VARCHAR2, 
                                    SN_NUM_EVENTO   		  OUT NOCOPY NUMBER)
/*  
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "FA_REGISTRAR_PROCESO_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripcion>Inserta un registro en tabla FA_PROCESOS</Descripcion>
      <Parámetros>
          <Entrada>
            <param >Todos los campos de tabla FA_PROCESOS</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 AS


 BEGIN
    SN_COD_RETORNO  := 0; 
    SV_MENS_RETORNO := NULL; 
    SN_NUM_EVENTO   := 0;
	
	GV_SQL :='INSERT INTO FA_PROCESOS';
	
	INSERT INTO FA_PROCESOS (NUM_PROCESO, 
  							 COD_TIPDOCUM,
  							 COD_VENDEDOR_AGENTE,
  							 COD_CENTREMI,
  							 FEC_EFECTIVIDAD,
  							 NOM_USUARORA,
  							 LETRAAG,
  							 NUM_SECUAG,
  							 COD_TIPDOCNOT ,
  							 COD_VENDEDOR_AGENTENOT ,
  							 LETRANOT,
							 COD_CENTRNOT,
  							 NUM_SECUNOT ,
  							 IND_ESTADO ,
  							 COD_CICLFACT ,
  							 IND_NOTACREDC)

	VALUES 					(EN_NUM_PROCESO,	 
							 EN_COD_TIPDOCUM, 
							 EN_COD_VENDEDOR_AGENTE,
		    				 EN_COD_CENTREMI, 
							 TO_DATE(ED_FEC_EFECTIVIDAD, GV_FORMATO_FECHAS),		
  							 EV_NOM_USUARORA,
  							 EV_LETRAAG,
  							 EN_NUM_SECUAG,
  							 EN_COD_TIPDOCNOT ,
  							 EN_COD_VENDEDOR_AGENTENOT ,
  							 EV_LETRANOT,
							 EV_COD_CENTRNOT,
  							 EN_NUM_SECUNOT ,
  							 EN_IND_ESTADO ,
  							 EN_COD_CICLFACT ,
  							 EN_IND_NOTACREDC);
							 
 EXCEPTION
    WHEN OTHERS THEN
         SN_COD_RETORNO := 1373; -- 'Error en Registrar Proceso'
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'FA_SERVICIOS_PG.FA_REGISTRAR_PROCESO_PR', 
												   GV_SQL, SQLCODE, SQLERRM );	
 END;									   									


 FUNCTION FA_VALIDA_CONCEPTO_AFECTO_FN (EN_CODCONCEPTO  IN  NUMBER,
                                        EN_CODCATIMPOS  IN  GE_IMPUESTOS.COD_CATIMPOS%type,
			                            EN_CODZONAIMPO  IN  GE_IMPUESTOS.COD_ZONAIMPO%type,
									    EV_FECHASISTEMA IN  VARCHAR2,
                                        SN_COD_RETORNO  OUT NOCOPY NUMBER, 
                                        SV_MENS_RETORNO OUT NOCOPY VARCHAR2, 
                                        SN_NUM_EVENTO   OUT NOCOPY NUMBER) 
 RETURN NUMBER
/*  
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "FA_VALIDA_CONCEPTO_AFECTO_FN"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripcion>Determina si el concepto es afecto (1:afecto, 0:Exento) </Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="EN_CODCONCEPTO" Tipo="NUMBER">Codigo Concepto</param>		  
            <param nom="EN_CODCATIMPOS" Tipo="VARCHAR2">Codigo de la cateria impositiva</param>
            <param nom="EN_CODZONAIMPO" Tipo="VARCHAR2">Codigo de la zona impositiva</param>
            <param nom="EV_FECHASISTEMA" Tipo="VARCHAR2">Fecha Sistema</param>												
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 AS
    LN_EXENTOAFECTO NUMBER:=0;
	LD_FECHASISTEMA DATE;
	LN_CODGRPSERVI  NUMBER;
 BEGIN

    SN_COD_RETORNO  := 0;
    SV_MENS_RETORNO := NULL;
    SN_NUM_EVENTO   := 0;	

    BEGIN
	
	   GV_SQL :='';
	   GV_SQL := 'SELECT A.COD_GRPSERVI ';
	   GV_SQL := GV_SQL || 'FROM   FA_GRPSERCONC A ';
	   GV_SQL := GV_SQL || 'WHERE A.COD_CONCEPTO = ' || TO_CHAR(EN_CODCONCEPTO);	    
	   GV_SQL := GV_SQL || ' AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA '; -- INC 212304 - PGG - 10-SEPT-2018
	   
     SELECT A.COD_GRPSERVI
	   INTO   LN_CODGRPSERVI
	   FROM   FA_GRPSERCONC A
	   WHERE  A.COD_CONCEPTO = EN_CODCONCEPTO
	   AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA; -- INC 212304 - PGG - 10-SEPT-2018
	   
	EXCEPTION
	   WHEN NO_DATA_FOUND THEN
	        SN_COD_RETORNO := 1449; -- Grupo Servicio no existe.

  	        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	           SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	        END IF;
  	        SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 
	                                                  1.0, USER, 'FA_SERVICIOS_PG.FA_VALIDA_CONCEPTO_AFECTO_FN', 
					   							      GV_SQL, SQLCODE, SQLERRM );	   
	        RETURN 0; -- FALSE 
	   WHEN OTHERS THEN
            SN_COD_RETORNO := 1459; -- Error en Recupera Grupo Servicio.

  	        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	           SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	        END IF;
  	        SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 
	                                                  1.0, USER, 'FA_SERVICIOS_PG.FA_VALIDA_CONCEPTO_AFECTO_FN', 
												      GV_SQL, SQLCODE, SQLERRM );
	        RETURN 0; -- FALSE 
	END;
	
	LD_FECHASISTEMA := TO_DATE(EV_FECHASISTEMA, GV_FORMATO_FECHAS);
 
    GV_SQL := '';
    GV_SQL :='SELECT DECODE(PRC_IMPUESTO, 0, 0, 1) ';
    GV_SQL := GV_SQL || 'FROM GE_IMPUESTOS g, FA_DATOSGENER a ';
    GV_SQL := GV_SQL || 'WHERE G.COD_CATIMPOS  = ' || EN_CODCATIMPOS;
    GV_SQL := GV_SQL || ' AND g.COD_ZONAIMPO  = ' || EN_CODZONAIMPO;
    GV_SQL := GV_SQL || ' AND g.COD_TIPIMPUES = a.COD_IVA ';
    GV_SQL := GV_SQL || ' AND g.COD_GRPSERVI  = ' || LN_CODGRPSERVI;
    GV_SQL := GV_SQL || ' AND g.COD_CONCGENE  = a.COD_CONCIVA ';
    GV_SQL := GV_SQL || ' AND ' || LD_FECHASISTEMA || ' BETWEEN FEC_DESDE AND FEC_HASTA';
    
	SELECT DECODE(G.PRC_IMPUESTO, 0, 0, 1)
	INTO   LN_EXENTOAFECTO
	FROM   GE_IMPUESTOS G, FA_DATOSGENER A
	WHERE  G.COD_CATIMPOS  = EN_CODCATIMPOS
	AND    G.COD_ZONAIMPO  = EN_CODZONAIMPO
	AND    G.COD_TIPIMPUES = A.COD_IVA
	AND    G.COD_GRPSERVI  = LN_CODGRPSERVI
	AND    G.COD_CONCGENE  = A.COD_CONCIVA 
	AND    LD_FECHASISTEMA BETWEEN G.FEC_DESDE AND G.FEC_HASTA;
	
	RETURN LN_EXENTOAFECTO;
	
 EXCEPTION
   WHEN NO_DATA_FOUND THEN
	   SN_COD_RETORNO := 2165; -- Impuesto Afecto no existe.

  	   IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	      SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	   END IF;
  	   SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 
	                                             1.0, USER, 'FA_SERVICIOS_PG.FA_VALIDA_CONCEPTO_AFECTO_FN', 
												 GV_SQL, SQLCODE, SQLERRM );	   
	   RETURN 0; -- FALSE 
	   
   WHEN OTHERS THEN
       SN_COD_RETORNO := 2166; -- Error en Recupera Concepto Afecto.

  	   IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	      SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	   END IF;
  	   SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 
	                                             1.0, USER, 'FA_SERVICIOS_PG.FA_VALIDA_CONCEPTO_AFECTO_FN', 
												 GV_SQL, SQLCODE, SQLERRM );
	   RETURN 0; -- FALSE 
 END;
  

 FUNCTION FA_VALIDAR_MENSAJE_FN (EN_CORRMENSAJE  IN  NUMBER,
                                 SN_COD_RETORNO  OUT NOCOPY NUMBER, 
                                 SV_MENS_RETORNO OUT NOCOPY VARCHAR2, 
			                     SN_NUM_EVENTO   OUT NOCOPY NUMBER)
 RETURN NUMBER
/*  
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "FA_VALIDAR_MENSAJE_FN"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Jorge Toro"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripcion>Verifica si el correlativo del mensaje existe (1:True, 0:False) </Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="EN_CORRMENSAJE" Tipo="NUMBER">Correlativo del mensaje</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 AS
    LN_EXISTE NUMBER:=0;
 BEGIN
 
    SN_COD_RETORNO  := 0; 
    SV_MENS_RETORNO := NULL; 
    SN_NUM_EVENTO   := 0;
	
	GV_SQL:='';
    GV_SQL:='SELECT COUNT(1) ';
	GV_SQL:= GV_SQL || 'FROM   FA_MENSAJES A ';
	GV_SQL:= GV_SQL || 'WHERE  A.CORR_MENSAJE    = ' || EN_CORRMENSAJE;	 
 
    SELECT COUNT(1)
	INTO   LN_EXISTE
	FROM   FA_MENSAJES A
	WHERE  A.CORR_MENSAJE = EN_CORRMENSAJE;
	
	IF LN_EXISTE > 0
	THEN
	    RETURN 1; -- TRUE 
	ELSE
	    RETURN 0; -- FALSE 
	END IF;

 EXCEPTION
	WHEN OTHERS THEN
         SN_COD_RETORNO := 2167; -- Error en Recupera Mensaje.
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'FA_SERVICIOS_PG.FA_VALIDAR_MENSAJE_FN', 
												   GV_SQL, SQLCODE, SQLERRM );
		 RETURN 0; -- FALSE 	
 END; 


PROCEDURE   FA_OBTPARMENSAJE_PR (EN_COD_FORMULARIO  IN  NUMBER,
 								 EN_COD_BLOQUE      IN  NUMBER,
								 SN_CANT_LINEASMEN  OUT NUMBER,
 								 SN_CANT_CARACTLIN  OUT NUMBER, 								 
                                 SN_COD_RETORNO     OUT NOCOPY NUMBER, 
                                 SV_MENS_RETORNO    OUT NOCOPY VARCHAR2, 
			                     SN_NUM_EVENTO      OUT NOCOPY NUMBER)
/*  
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "FA_OBTPARMENSAJE_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripcion>Obtiene los parametros del mensaje Cantidad de lineas y N° de caracteres</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="EN_COD_FORMULARIO" Tipo="NUMBER">Cod. formulario</param>
            <param nom="EN_COD_BLOQUE" Tipo="NUMBER">Cod. Bloque</param>
         </Entrada>
         <Salida>
            <param nom="SN_CANT_LINEASMEN" Tipo="NUMBER">Cantidad Lineas Mensaje</param>
            <param nom="SN_CANT_CARACTLIN" Tipo="NUMBER">Cantidad Caracteres Linea</param>					 
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 AS

 BEGIN
 
    SN_COD_RETORNO  := 0; 
    SV_MENS_RETORNO := NULL; 
    SN_NUM_EVENTO   := 0;
	
	GV_SQL:= 'SELECT CANT_LINEASMEN, CANT_CARACTLIN ';
	GV_SQL:= GV_SQL || 'FROM FA_PARMENSAJE ';
	GV_SQL:= GV_SQL || 'WHERE COD_FORMULARIO = ' || EN_COD_FORMULARIO;
	GV_SQL:= GV_SQL || ' AND COD_BLOQUE = ' || EN_COD_BLOQUE;	 
 
 	SELECT CANT_LINEASMEN, CANT_CARACTLIN
	INTO   SN_CANT_LINEASMEN, SN_CANT_CARACTLIN
	FROM   FA_PARMENSAJE
	WHERE  COD_FORMULARIO = EN_COD_FORMULARIO
	AND    COD_BLOQUE     = EN_COD_BLOQUE;
	

 EXCEPTION
	WHEN OTHERS THEN
         SN_COD_RETORNO := 2167; -- Error en Obtener Parámetros de Mensaje.
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'FA_SERVICIOS_PG.FA_OBTPARMENSAJE_PR', 
												   GV_SQL, SQLCODE, SQLERRM );
 END; 


 FUNCTION FA_VERIFCARGOS_DESCUENTOS_FN (EN_CODCONCEPTOCARGO     IN  NUMBER,
                                        EN_CODCONCEPTODESCUENTO IN  NUMBER,
                                        SN_COD_RETORNO          OUT NOCOPY NUMBER, 
			                            SV_MENS_RETORNO         OUT NOCOPY VARCHAR2, 
			                            SN_NUM_EVENTO           OUT NOCOPY NUMBER)
 RETURN NUMBER
/*  
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "FA_VERIFCARGOS_DESCUENTOS_FN"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Jorge Toro"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripcion>Valida si el codigo concepto descuento tenga un concepto cargo asociado</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="EN_CODCONCEPTOCARGO" Tipo="NUMBER">Concepto cargo</param>
            <param nom="EN_CODCONCEPTODESCUENTO" Tipo="NUMBER">Concepto descuento</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/ 
 AS
    LN_CODCONCEPTOCARGO NUMBER;
 BEGIN

    SN_COD_RETORNO  := 0; 
    SV_MENS_RETORNO := NULL; 
    SN_NUM_EVENTO   := 0; 
 
    SELECT A.COD_CONCORIG
	INTO   LN_CODCONCEPTOCARGO
    FROM   FA_CONCEPTOS A
    WHERE  A.COD_CONCEPTO = EN_CODCONCEPTODESCUENTO
	AND    A.COD_TIPCONCE = 2;
	
	IF (LN_CODCONCEPTOCARGO = EN_CODCONCEPTOCARGO)
	THEN
	    RETURN 1; --TRUE 
	ELSE
	    RETURN 0; --FALSE 
	END IF;	
   
 EXCEPTION
    WHEN NO_DATA_FOUND THEN
         SN_COD_RETORNO := 888; -- Cod. Concepto Cargo No Encontrado .	
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'FA_SERVICIOS_PG.FA_VERIFCARGOS_DESCUENTOS_PR', 
												   GV_SQL, SQLCODE, SQLERRM );
		 RETURN 0; -- FALSE		 
	WHEN OTHERS THEN
         SN_COD_RETORNO := 2306; -- Error en Validar Concepto Cargo.
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'FA_SERVICIOS_PG.FA_VERIFCARGOS_DESCUENTOS_PR', 
												   GV_SQL, SQLCODE, SQLERRM );
		 RETURN 0; --FALSE    
   
 END; 


 PROCEDURE FA_REGISTRAR_MENSAJE_PR (EN_CORRMENSAJE  IN  NUMBER,
                                    EV_DESCMENSAJE  IN  VARCHAR2,
									EN_NUMLINEA     IN  NUMBER,
									EV_CODIDIOMA    IN  VARCHAR2,
									EV_DESCMENSLIN  IN  VARCHAR2,
                                    SN_COD_RETORNO  OUT NOCOPY NUMBER, 
			                        SV_MENS_RETORNO OUT NOCOPY VARCHAR2, 
			                        SN_NUM_EVENTO   OUT NOCOPY NUMBER)
/*  
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "FA_REGISTRAR_MENSAJE_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Jorge Toro"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripcion>Valida si el codigo concepto descuento tenga un concepto cargo asociado</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="EN_CORRMENSAJE" Tipo="NUMBER">Correlativo mensaje</param>
            <param nom="EV_DESCMENSAJE" Tipo="VARCHAR2">Descripción del mensaje</param>
            <param nom="EN_NUMLINEA" Tipo="NUMBER">Numero de linea</param>
            <param nom="EV_CODIDIOMA" Tipo="VARCHAR2">Cod. idioma</param>
            <param nom="EV_DESCMENSLIN" Tipo="VARCHAR2">Descripción del mensaje por linea</param>			
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/ 
 AS
 BEGIN

    SN_COD_RETORNO  := 0; 
    SV_MENS_RETORNO := NULL; 
    SN_NUM_EVENTO   := 0;
	
	GV_SQL := '';
	GV_SQL := 'INSERT INTO FA_MENSAJES (CORR_MENSAJE, DESC_MENSAJE, ';
	GV_SQL := GV_SQL || 'NUM_LINEA ,     COD_IDIOMA,   DESC_MENSLIN, ';
	GV_SQL := GV_SQL || 'CANT_LINEASMEN, CANT_CARACTLIN) ';
	GV_SQL := GV_SQL || 'SELECT ' || TO_CHAR(EN_CORRMENSAJE) || ', ' || EV_DESCMENSAJE || ', ';
	GV_SQL := GV_SQL || TO_CHAR(EN_NUMLINEA) || ', ' || EV_CODIDIOMA || ', ' || EV_DESCMENSLIN || ', ';
	GV_SQL := GV_SQL || 'A.CANT_LINEASMEN, A.CANT_CARACTLIN ';
	GV_SQL := GV_SQL || 'FROM FA_PARMENSAJE A ';
	GV_SQL := GV_SQL || 'WHERE A.COD_FORMULARIO = ' || TO_CHAR(1);
	GV_SQL := GV_SQL || ' AND  A.COD_BLOQUE = ' || TO_CHAR(3);
	
	INSERT INTO FA_MENSAJES (CORR_MENSAJE,   DESC_MENSAJE, 
                             NUM_LINEA ,     COD_IDIOMA,   DESC_MENSLIN,
							 CANT_LINEASMEN, CANT_CARACTLIN) 
    SELECT EN_CORRMENSAJE,   EV_DESCMENSAJE, 
           EN_NUMLINEA,      EV_CODIDIOMA, EV_DESCMENSLIN, 
           A.CANT_LINEASMEN, A.CANT_CARACTLIN 
    FROM   FA_PARMENSAJE A 
    WHERE  A.COD_FORMULARIO = 1 
	AND    A.COD_BLOQUE     = 3;

	
 EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
         SN_COD_RETORNO := 2168; -- Cod. Concepto Cargo No Encontrado .	
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'FA_SERVICIOS_PG.FA_REGISTRAR_MENSAJE_PR', 
												   GV_SQL, SQLCODE, SQLERRM );
	WHEN OTHERS THEN
         SN_COD_RETORNO := 1371; -- Error en Validar Concepto Cargo.
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'FA_SERVICIOS_PG.FA_REGISTRAR_MENSAJE_PR', 
												   GV_SQL, SQLCODE, SQLERRM );			
 END;
 

 PROCEDURE FA_REGISTRAR_MENSPROCESO_PR (EN_NUMPROCESO    IN  NUMBER,  
                                        EN_CODFORMULARIO IN  NUMBER,
                                        EN_CODBLOQUE     IN  NUMBER,   
										EN_CORRMENSAJE   IN  NUMBER,
                                        EN_NUMLINEAS     IN  NUMBER,   
										EV_CODORIGEN     IN  VARCHAR2,
                                        EV_DESCMENSAJE   IN  VARCHAR2, 
										EV_INDFACTURADO  IN  VARCHAR2,
                                        EV_NOMUSUARIO    IN  VARCHAR2,  
										EV_FECHASISTEMA  IN  VARCHAR2,
                                        SN_COD_RETORNO   OUT NOCOPY NUMBER, 
			                            SV_MENS_RETORNO  OUT NOCOPY VARCHAR2, 
			                            SN_NUM_EVENTO    OUT NOCOPY NUMBER)
/* 
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "FA_REGISTRAR_MENSPROCESO_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Jorge Toro"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripcion>Inserta en la tabla  FA_MENSPROCESO</Descripcion>
      <Parámetros>
          <Entrada>
            <param</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/ 
 AS
    LV_FECHASISTEMA VARCHAR2(21);
    LD_FECHASISTEMA DATE;	
 BEGIN
 
    SN_COD_RETORNO  := 0; 
    SV_MENS_RETORNO := NULL; 
    SN_NUM_EVENTO   := 0;
	
	LV_FECHASISTEMA := EV_FECHASISTEMA;
	LD_FECHASISTEMA := TO_DATE(EV_FECHASISTEMA, GV_FORMATO_FECHAS);		

    GV_SQL := '';
	GV_SQL := 'INSERT INTO FA_MENSPROCESO (NUM_PROCESO, COD_FORMULARIO, ';
	GV_SQL := GV_SQL || 'COD_BLOQUE,CORR_MENSAJE, NUM_LINEAS, COD_ORIGEN, ';
	GV_SQL := GV_SQL || 'DESC_MENSAJE, IND_FACTURADO, NOM_USUARIO, FEC_INGRESO) ';
	GV_SQL := GV_SQL || 'VALUES (' || TO_CHAR(EN_NUMPROCESO) || ',' || TO_CHAR(EN_CODFORMULARIO) || ', ';
    GV_SQL := GV_SQL || TO_CHAR(EN_CODBLOQUE) || ', ' || TO_CHAR(EN_CORRMENSAJE) || ', ' || TO_CHAR(EN_NUMLINEAS) || ', ';
	GV_SQL := GV_SQL || EV_CODORIGEN || ', ' || EV_DESCMENSAJE || ', ' || EV_INDFACTURADO || ', ';
	GV_SQL := GV_SQL || EV_NOMUSUARIO || ', ' || LV_FECHASISTEMA;
	
	INSERT INTO FA_MENSPROCESO (NUM_PROCESO,  COD_FORMULARIO,
                                COD_BLOQUE,   CORR_MENSAJE,
                                NUM_LINEAS,   COD_ORIGEN,
                                DESC_MENSAJE, IND_FACTURADO,
                                NOM_USUARIO,  FEC_INGRESO)
    VALUES (EN_NUMPROCESO, EN_CODFORMULARIO,
            EN_CODBLOQUE,  EN_CORRMENSAJE,
            EN_NUMLINEAS,  EV_CODORIGEN,
            EV_DESCMENSAJE,EV_INDFACTURADO,
            EV_NOMUSUARIO, LD_FECHASISTEMA);								
	

 EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
         SN_COD_RETORNO := 2169; -- Llave Duplicada en Insert FA_MENSPROCESO.	
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'FA_SERVICIOS_PG.FA_REGISTRAR_MENSPROCESO_PR', 
												   GV_SQL, SQLCODE, SQLERRM );
	WHEN OTHERS THEN
         SN_COD_RETORNO := 670; -- Error en Insert FA_MENSPROCESO.
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'FA_SERVICIOS_PG.FA_REGISTRAR_MENSPROCESO_PR', 
												   GV_SQL, SQLCODE, SQLERRM );	
		
 END;  




PROCEDURE FA_EJECUTAR_FACTURA_PR (EV_num_proceso     IN  VARCHAR2,
 								  EV_num_venta       IN  VARCHAR2,
 								  EV_cod_modgener    IN  VARCHAR2,
 								  EV_cod_tipmovimien IN  VARCHAR2,
 								  EV_cod_catribut    IN  VARCHAR2,
 								  EV_num_folio       IN  VARCHAR2,
 								  EV_cod_estadoc     IN  VARCHAR2,
 								  EV_cod_estproc     IN  VARCHAR2,
 								  EV_fec_vencimiento IN  VARCHAR2,
								  EV_fec_ingreso     IN  VARCHAR2,
 								  EV_cod_modventa    IN  VARCHAR2,
 								  EV_num_cuotas      IN  VARCHAR2,
 								  EV_pref_plaza      IN  VARCHAR2,
 								  EV_tip_foliacion   IN  VARCHAR2,
 								  EV_cod_tipdocum	 IN  VARCHAR2,
								  SN_COD_RETORNO     OUT NOCOPY NUMBER, 
			                      SV_MENS_RETORNO    OUT NOCOPY VARCHAR2, 
			                      SN_NUM_EVENTO      OUT NOCOPY NUMBER) 
/*
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "FA_EJECUTAR_FACTURA_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripcion>Inserta en la tabla  FA_INTERFACT</Descripcion>
      <Parámetros>
          <Entrada>
            <param</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/ 
IS

BEGIN
 	  SN_cod_retorno := 0;
	  SV_mens_retorno := NULL;
 	  SN_num_evento := 0;

      INSERT INTO FA_INTERFACT
       		   					(NUM_PROCESO    ,
								 NUM_VENTA      ,
								 COD_MODGENER   ,
								 COD_ESTADOC    ,
								 COD_ESTPROC    ,
								 COD_TIPMOVIMIEN,
								 COD_CATRIBUT   ,
								 COD_TIPDOCUM   ,
								 NUM_FOLIO      ,
								 NUM_FOLIOREL   ,
								 FEC_INGRESO    ,
								 FEC_FACTURACION,
								 FEC_IMPRESION  ,
								 FEC_FOLIACION  ,
								 FEC_VISACION   ,
								 FEC_PASOCOBRO  ,
								 FEC_CIERRE 	   ,
								 FEC_VENCIMIENTO,
 					             COD_MODVENTA   ,
								 NUM_CUOTAS     ,	
								 PREF_PLAZAREL  ,
 								 TIP_FOLIACION)
      VALUES                    (to_number(EV_num_proceso),
        						 to_number(EV_num_venta),
        						 EV_cod_modgener,
        						 to_number(EV_cod_estadoc),
        						 to_number(EV_cod_estproc),
        						 to_number(EV_cod_tipmovimien),
        						 EV_cod_catribut,
        						 to_number(nvl(EV_cod_tipdocum,0)),
        						 to_number(EV_num_folio),
        						 null,
        						 to_date(EV_fec_ingreso, GV_FORMATO_FECHAS),
        						 null,
        						 null,
        						 null,
        						 null,
        						 null,
								 null,
        						 TRUNC(to_date(EV_fec_vencimiento,GV_FORMATO_FECHAS)),
        						 to_number(EV_cod_modventa),
        						 to_number(EV_num_cuotas),
								 EV_pref_plaza,
        						 NVL(EV_tip_foliacion,'P') );

 EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
         SN_COD_RETORNO := 2230; --Error en Insert a Fa_Interfact, Registro Duplicado

 	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'FA_SERVICIOS_PG.FA_EJECUTAR_FACTURA_PR', 
											       GV_SQL, SQLCODE, SQLERRM );	   	   
    
   WHEN OTHERS THEN
         SN_COD_RETORNO := 2231; -- 'Otros Errores No Esperados. Error en Insert a Fa_Interfact

 	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'FA_SERVICIOS_PG.FA_EJECUTAR_FACTURA_PR', 
											       GV_SQL, SQLCODE, SQLERRM );		   
END;


 FUNCTION FA_VALIDA_CONCEPTO_FN (EN_CODCONCEPTO  IN  NUMBER,
			                     EV_CODTIPCONCE  IN  VARCHAR2,
                                 SN_COD_RETORNO  OUT NOCOPY NUMBER, 
                                 SV_MENS_RETORNO OUT NOCOPY VARCHAR2, 
                                 SN_NUM_EVENTO   OUT NOCOPY NUMBER) 
 RETURN NUMBER
/*
<Documentacion
  TipoDoc = Función">
   <Elemento 
      Nombre = "FA_VALIDA_CONCEPTO_FN"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Jorge Toro"
      Fecha modificacion="" 
      Modificado por="" 
      Ambiente Desarrollo="BD"> 
      <Retorno></Retorno>
      <Descripcion>Valida si existe en Concepto en la tabla FA_CONCEPTOS</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="EN_CODCONCEPTO Tipo="NUMBER">Codigo Concepto</param>
            <param nom="EV_CODTIPCONCE Tipo="VARCHAR2">Codigo Tipo Concepto</param>			
         </Entrada> 
         <Salida> 
		 </Salida> 
      </Parametros> 
   </Elemento> 
</Documentacion> 
*/ 
 AS
	LN_CODTIPOCONCEPTO NUMBER := 0;
	LN_CONCEPTO NUMBER := 0;
 BEGIN

    SN_COD_RETORNO  := 0;
    SV_MENS_RETORNO := NULL;
    SN_NUM_EVENTO   := 0;
	
	IF (TRIM(EV_CODTIPCONCE) = 'C')
	THEN
	    LN_CODTIPOCONCEPTO := 3;
	ELSIF (TRIM(EV_CODTIPCONCE) = 'D')
	     THEN
	         LN_CODTIPOCONCEPTO := 2;	
	END IF;
 
    GV_SQL := '';
    GV_SQL :='SELECT COUNT(1) ';
    GV_SQL := GV_SQL || 'FROM FA_CONCEPTOS A ';
    GV_SQL := GV_SQL || 'WHERE A.COD_CONCEPTO  = ' || TO_CHAR(EN_CODCONCEPTO);
    GV_SQL := GV_SQL || ' AND  A.COD_TIPCONCE  = ' || TO_CHAR(LN_CODTIPOCONCEPTO);

    
	SELECT COUNT(1)
	INTO   LN_CONCEPTO
	FROM   FA_CONCEPTOS A
	WHERE  A.COD_CONCEPTO  = EN_CODCONCEPTO
	AND    A.COD_TIPCONCE  = LN_CODTIPOCONCEPTO;
	
	IF (LN_CONCEPTO > 0)
	THEN	
	    RETURN 1; -- TRUE 
	ELSE
	    RETURN 0; -- FALSE 
	END IF;
	
 EXCEPTION
   WHEN NO_DATA_FOUND THEN
	   SN_COD_RETORNO := 888; -- Cód. Concepto no existe 

  	   IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	      SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	   END IF;
  	   SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 
	                                             1.0, USER, 'FA_SERVICIOS_PG.FA_VALIDA_CONCEPTO_FN', 
												 GV_SQL, SQLCODE, SQLERRM );	   
	   RETURN 0; -- FALSE 
	   
   WHEN OTHERS THEN
       SN_COD_RETORNO := 2306; -- Error en validar Cód. Concepto 

  	   IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	      SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	   END IF;
  	   SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 
	                                             1.0, USER, 'FA_SERVICIOS_PG.FA_VALIDA_CONCEPTO_FN', 
												 GV_SQL, SQLCODE, SQLERRM );
	   RETURN 0; -- FALSE 
 END;

 PROCEDURE FA_REGISTRAR_CARGOS_PR (EN_NUM_PROCESO      IN  NUMBER,
 		   						   EN_COD_CLIENTE      IN  NUMBER,
  								   EN_COD_CONCEPTO     IN  NUMBER,
  								   EN_COLUMNA          IN  NUMBER,
  								   EN_COD_PRODUCTO     IN  NUMBER,
  								   EV_COD_MONEDA       IN  VARCHAR2,
  								   EV_FEC_VALOR        IN  VARCHAR2,
  								   EV_FEC_EFECTIVIDAD  IN  VARCHAR2,
  								   EN_IMP_CONCEPTO     IN  NUMBER,
  								   EN_IMP_FACTURABLE   IN  NUMBER,
  								   EN_IMP_MONTOBASE    IN  NUMBER,
  								   EV_COD_REGION       IN  VARCHAR2,
  								   EV_COD_PROVINCIA    IN  VARCHAR2,
  								   EV_COD_CIUDAD       IN  VARCHAR2,
  								   EV_COD_MODULO       IN  VARCHAR2,
  								   EN_COD_PLANCOM      IN  NUMBER,
  								   EN_IND_FACTUR       IN  NUMBER,
  								   EN_NUM_UNIDADES     IN  NUMBER,
  								   EN_COD_CATIMPOS     IN  NUMBER,
  								   EN_IND_ESTADO       IN  NUMBER,
  								   EN_COD_PORTADOR     IN  NUMBER,
  								   EN_COD_TIPCONCE     IN  NUMBER,
  								   EN_COD_CICLFACT     IN  NUMBER,
  								   EN_COD_CONCEREL     IN  NUMBER,
  								   EN_COLUMNA_REL      IN  NUMBER,
  								   EN_NUM_ABONADO      IN  NUMBER,
  								   EV_NUM_TERMINAL     IN  VARCHAR2,
  								   EN_CAP_CODE         IN  NUMBER,
  								   EV_NUM_SERIEMEC     IN  VARCHAR2,
  								   EV_NUM_SERIELE      IN  VARCHAR2,
  								   EN_FLAG_IMPUES      IN  NUMBER,
  								   EN_FLAG_DTO         IN  NUMBER,
  								   EN_PRC_IMPUESTO     IN  NUMBER,
  								   EN_VAL_DTO          IN  NUMBER,
  								   EN_TIP_DTO          IN  NUMBER,
  								   EN_NUM_VENTA        IN  NUMBER,
  								   EN_MES_GARANTIA     IN  NUMBER,
  								   EN_IND_ALTA         IN  NUMBER,
  								   EN_IND_SUPERTEL     IN  NUMBER,
  								   EN_NUM_PAQUETE      IN  NUMBER,
  								   EN_NUM_TRANSACCION  IN  NUMBER,
  								   EN_IND_CUOTA        IN  NUMBER,
  								   EN_NUM_GUIA         IN  NUMBER,
  								   EN_NUM_CUOTAS       IN  NUMBER,
  								   EN_ORD_CUOTA        IN  NUMBER,
  								   EV_DES_NOTACREDC    IN  VARCHAR2,
  								   EN_IND_MODVENTA     IN  NUMBER,
  								   EV_IND_RECUPIVA     IN  CHAR,
  								   EN_COD_TIPDOCUM     IN  NUMBER,
  								   EV_COD_TECNOLOGIA   IN  VARCHAR2,
  								   EV_COD_MONEDAIMP    IN  VARCHAR2,
  								   EN_IMP_CONVERSION   IN  NUMBER,
  								   EN_IMP_VALUNITARIO  IN  NUMBER,
  								   EV_GLS_DESCRIP      IN  VARCHAR2,							
								   SN_COD_RETORNO      OUT NOCOPY NUMBER, 
			                       SV_MENS_RETORNO     OUT NOCOPY VARCHAR2, 
			                       SN_NUM_EVENTO       OUT NOCOPY NUMBER)
/*
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "FA_REGISTRAR_CARGOS_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripcion>Inserta en la tabla  FA_PREFACTURA</Descripcion>
      <Parámetros>
          <Entrada>
            <param</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/ 
 AS
    LV_FECHASISTEMA VARCHAR2(21);
	LN_TIP_DTO      NUMBER;
 BEGIN
 
    SN_COD_RETORNO  := 0; 
    SV_MENS_RETORNO := NULL; 
    SN_NUM_EVENTO   := 0;
	
	IF (EN_TIP_DTO = -1)
	THEN
	     LN_TIP_DTO := NULL;
	ELSE
	     LN_TIP_DTO := EN_TIP_DTO; 
	END IF;
	
					INSERT INTO FA_PREFACTURA (
					  	 	 	   NUM_PROCESO,
 		   						   COD_CLIENTE,
  								   COD_CONCEPTO,
  								   COLUMNA,
  								   COD_PRODUCTO,
  								   COD_MONEDA,
  								   FEC_VALOR, 
  								   FEC_EFECTIVIDAD, 
  								   IMP_CONCEPTO,
  								   IMP_FACTURABLE,
  								   IMP_MONTOBASE,
  								   COD_REGION,
  								   COD_PROVINCIA,
  								   COD_CIUDAD,
  								   COD_MODULO,
  								   COD_PLANCOM,
  								   IND_FACTUR,
  								   NUM_UNIDADES,
  								   COD_CATIMPOS,
  								   IND_ESTADO,
  								   COD_PORTADOR,
  								   COD_TIPCONCE,
  								   COD_CICLFACT,
  								   COD_CONCEREL,
  								   COLUMNA_REL,
  								   NUM_ABONADO,
  								   NUM_TERMINAL,
  								   CAP_CODE ,
  								   NUM_SERIEMEC,
  								   NUM_SERIELE,
  								   FLAG_IMPUES,
  								   FLAG_DTO,
  								   PRC_IMPUESTO,
  								   VAL_DTO,
  								   TIP_DTO,
  								   NUM_VENTA,
  								   MES_GARANTIA,
  								   IND_ALTA,
  								   IND_SUPERTEL,
  								   NUM_PAQUETE,
  								   NUM_TRANSACCION,
  								   IND_CUOTA,
  								   NUM_GUIA,
  								   NUM_CUOTAS,
  								   ORD_CUOTA,
  								   DES_NOTACREDC,
  								   IND_MODVENTA,
  								   IND_RECUPIVA,
  								   COD_TIPDOCUM,
  								   COD_TECNOLOGIA,
  								   COD_MONEDAIMP,
  								   IMP_CONVERSION,
  								   IMP_VALUNITARIO,
  								   GLS_DESCRIP)	
				SELECT 
					  			   EN_NUM_PROCESO,
 		   						   EN_COD_CLIENTE,
  								   EN_COD_CONCEPTO,
  								   EN_COLUMNA,
  								   EN_COD_PRODUCTO,
  								   EV_COD_MONEDA,
  								   TO_DATE(EV_FEC_VALOR, GV_FORMATO_FECHAS),
  								   TO_DATE(EV_FEC_EFECTIVIDAD, GV_FORMATO_FECHAS),								   
  								   EN_IMP_CONCEPTO,
  								   EN_IMP_FACTURABLE,
  								   EN_IMP_MONTOBASE,
  								   EV_COD_REGION,
  								   EV_COD_PROVINCIA,
  								   EV_COD_CIUDAD,
  								   A.COD_MODULO,
  								   EN_COD_PLANCOM,
  								   EN_IND_FACTUR,
  								   EN_NUM_UNIDADES,
  								   EN_COD_CATIMPOS,
  								   EN_IND_ESTADO,
  								   EN_COD_PORTADOR,
  								   EN_COD_TIPCONCE,
  								   EN_COD_CICLFACT,
  								   EN_COD_CONCEREL,
  								   EN_COLUMNA_REL,
  								   EN_NUM_ABONADO,
  								   EV_NUM_TERMINAL,
  								   EN_CAP_CODE ,
  								   EV_NUM_SERIEMEC,
  								   EV_NUM_SERIELE,
  								   EN_FLAG_IMPUES,
  								   EN_FLAG_DTO,
  								   EN_PRC_IMPUESTO,
  								   EN_VAL_DTO,
  								   LN_TIP_DTO,
  								   EN_NUM_VENTA,
  								   EN_MES_GARANTIA,
  								   EN_IND_ALTA,
  								   EN_IND_SUPERTEL,
  								   EN_NUM_PAQUETE,
  								   EN_NUM_TRANSACCION,
  								   EN_IND_CUOTA,
  								   EN_NUM_GUIA,
  								   EN_NUM_CUOTAS,
  								   EN_ORD_CUOTA,
  								   EV_DES_NOTACREDC,
  								   EN_IND_MODVENTA,
  								   EV_IND_RECUPIVA,
  								   EN_COD_TIPDOCUM,
  								   EV_COD_TECNOLOGIA,
  								   EV_COD_MONEDAIMP,
  								   EN_IMP_CONVERSION,
  								   EN_IMP_VALUNITARIO,
  								   EV_GLS_DESCRIP
					FROM 		   FA_CONCEPTOS A
					WHERE
						 		   COD_CONCEPTO = EN_COD_CONCEPTO;

								   
 EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
         SN_COD_RETORNO := 2232; -- Llave Duplicada en Insert FA_prefactura.	
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'FA_SERVICIOS_PG.FA_REGISTRAR_CARGOS_PR', 
												   GV_SQL, SQLCODE, SQLERRM );
	WHEN OTHERS THEN
         SN_COD_RETORNO := 2233; -- Error en Insert FA_MENSPROCESO.
		 
  	     IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
  	        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
 	     END IF;
		 
  	     SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, 'FA', SV_MENS_RETORNO, 1.0, 
		                                           USER, 'FA_SERVICIOS_PG.FA_REGISTRAR_CARGOS_PR', 
												   GV_SQL, SQLCODE, SQLERRM );	
 END;  
        
END;
/
SHOW ERRORS