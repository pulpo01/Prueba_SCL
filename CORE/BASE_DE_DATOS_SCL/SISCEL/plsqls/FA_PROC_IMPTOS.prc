CREATE OR REPLACE PROCEDURE Fa_Proc_Imptos (lNumProceso_EXT	 IN NUMBER,
	   	  		  						    iCodCatImpos_EXT IN NUMBER,
											szCodOficina	 IN VARCHAR2,
          		  						    VP_PROC          IN OUT VARCHAR2,    /* En que parte del proceso estoy*/
          		  							VP_TABLA         IN OUT VARCHAR2,    /* En que tabla estoy trabajando*/
          		  							VP_ACT           IN OUT VARCHAR2,    /* Que accion estoy ejecutando*/
          		  							VP_SQLCODE       IN OUT VARCHAR2,    /* sqlcode*/
          		  							VP_SQLERRM       IN OUT VARCHAR2,    /* sqlerrm*/
          		  							VP_ERROR         IN OUT VARCHAR2     /* Error enviando por nosotros u otro.*/
)IS

status 					BOOLEAN;
Tab_FA_PRESUPUESTO 		Fa_Pac_Imptos.TipTab_FA_PRESUPUESTO;
Raya1          			VARCHAR2(50)   := '--------------------------------------------';
Raya2           		VARCHAR2(50)   := '=================================================';
Asteriscos      		VARCHAR2(50)   := '***********************';
i 						PLS_INTEGER;

ERROR_CALL_CARGAIMPTOS  EXCEPTION;
ERROR_CARGADATOS  		EXCEPTION;
ERROR_INSERDATOS  		EXCEPTION;
ERROR_BORRADATOS		EXCEPTION;
ERROR_GETDIRCLIENTE		EXCEPTION;
ERROR_GETZONACLIENTE	EXCEPTION;

VP_DESCERR				VARCHAR2(50);
fallo					BOOLEAN:=FALSE;

glCodCliente			GE_CLIENTES.COD_CLIENTE%TYPE;
giCodZonaImpoCli		GE_ZONACIUDAD.COD_ZONAIMPO%TYPE;
giCodZonaImpoOfi		GE_ZONACIUDAD.COD_ZONAIMPO%TYPE;
giCodZonaImpositiva		GE_ZONACIUDAD.COD_ZONAIMPO%TYPE;

/* ********************************************************************************************* */
/* (-1) * DEBUGGER EN TIEMPO DE EJECUCION DEL PROGRAMA                                           */
/* ********************************************************************************************* */
PROCEDURE SET_ERROR(DESCRIPCION IN VARCHAR2) IS
BEGIN
        IF VP_DESCERR IS NULL THEN
                VP_SQLCODE := TO_CHAR(SQLCODE);
                VP_SQLERRM := SUBSTR(SQLERRM,1,50);
                VP_DESCERR := DESCRIPCION;
                VP_ERROR   := '1';
        END IF;
        fallo := TRUE ;
END SET_ERROR;
/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (-1) * DEBUGGER EN TIEMPO DE EJECUCION DEL PROGRAMA                                           */
/* ********************************************************************************************* */
--PROCEDURE DEBUG IS
--BEGIN
--         --dbms_output.Put_Line(Raya2);
--         --dbms_output.Put_Line(Asteriscos || ' ' || VP_PROC || '*');
--END DEBUG;

/* ********************************************************************************************* */
/* (-1) * INICIALIZADOR DEL PROGRAMA                                           					 */
/* ********************************************************************************************* */
PROCEDURE Inicializa IS
BEGIN
	 VP_PROC  := 'fbInicializa    ';
     VP_TABLA  := '-Ninguna-'           ;
     VP_ACT   := '-'                       ;
     --DEBUG;

	 Tab_FA_PRESUPUESTO.DELETE;

END Inicializa;
/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/

/* ********************************************************************************************* */
/*  OBTIENE LA ZONA IMPOSITIVA DEL CLIENTE 														 */
/* ********************************************************************************************* */
FUNCTION GetZonaImpoCliente RETURN BOOLEAN IS
BEGIN
        VP_PROC         := 'GetZonaCliente'      ;
        VP_TABLA        := 'GA_DIRECCLI-GE_ZONACIUDAD'             ;
        VP_ACT          := 'S'                          ;
        --DEBUG;
        SELECT COD_ZONAIMPO
          INTO giCodZonaImpoCli
          FROM GE_ZONACIUDAD A ,GE_DIRECCIONES B, GA_DIRECCLI C
         WHERE C.COD_TIPDIRECCION = '1'
           AND C.COD_CLIENTE      = glCodCliente
           AND C.COD_DIRECCION    = B.COD_DIRECCION
 		   AND A.COD_REGION		  = B.COD_REGION
		   AND A.COD_PROVINCIA	  = B.COD_PROVINCIA
		   AND A.COD_CIUDAD		  = B.COD_CIUDAD
           AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA;

		RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SET_ERROR('>> NO DATA FOUND ');
				RETURN FALSE;
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO ');
				RETURN FALSE;
END GetZonaImpoCliente;
/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/

/* ********************************************************************************************* */
/*  OBTIENE LA ZONA IMPOSITIVA DEL CLIENTE 														 */
/* ********************************************************************************************* */
FUNCTION GetZonaImpoOficina RETURN BOOLEAN IS
BEGIN
        VP_PROC         := 'GetZonaImpoOficina'      ;
        VP_TABLA        := 'GA_OFICINA-GE_ZONACIUDAD'             ;
        VP_ACT          := 'S'                          ;
        --DEBUG;
        SELECT COD_ZONAIMPO
          INTO giCodZonaImpoOfi
          FROM GE_ZONACIUDAD A ,GE_DIRECCIONES B, GE_OFICINAS C
         WHERE C.COD_OFICINA      = szCodOficina
           AND C.COD_DIRECCION    = B.COD_DIRECCION
 		   AND A.COD_REGION		  = B.COD_REGION
		   AND A.COD_PROVINCIA	  = B.COD_PROVINCIA
		   AND A.COD_CIUDAD		  = B.COD_CIUDAD
           AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA;

        --dbms_output.Put_Line('retorno TRUE'||'giCodZonaImpoOfi('||giCodZonaImpoOfi||')szCodOficina('||szCodOficina||')');

		RETURN TRUE;

EXCEPTION

        WHEN NO_DATA_FOUND THEN
        --dbms_output.Put_Line('retorno TRUE'||'giCodZonaImpoOfi('||giCodZonaImpoOfi||')szCodOficina('||szCodOficina);
        --dbms_output.Put_Line('NO_DATA_FOUND');
                SET_ERROR('>> NO DATA FOUND ');
				RETURN FALSE;
        WHEN OTHERS THEN
        --dbms_output.Put_Line('retorno TRUE'||'giCodZonaImpoOfi('||giCodZonaImpoOfi||')szCodOficina('||szCodOficina);
        --dbms_output.Put_Line('OTHERS');
                SET_ERROR('>> ERROR INESPERADO ');
				RETURN FALSE;
END GetZonaImpoOficina;
/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/


/* ********************************************************************************************* */
/*  OBTIENE LA ZONA IMPOSITIVA DEL CLIENTE 														 */
/* ********************************************************************************************* */
FUNCTION EvaluaZonasImpositivas RETURN BOOLEAN IS
ERROR_ZONA_CLIE EXCEPTION;
ERROR_ZONA_OFIC EXCEPTION;
BEGIN
        VP_PROC         := 'EvaluaZonasImpositivas';
        VP_TABLA        := '-';
        VP_ACT          := '-';
        --DEBUG;

		-- IF GetZonaImpoCliente() THEN Se ELIMINA DE FORMA QUE UTILICE LA ZONA IMPOSITIVA DE LA OFICINA
		    IF GetZonaImpoOficina() THEN

		       --dbms_output.Put_Line('salio ok de GetZonaImpoOficina');

			 /*  IF giCodZonaImpoOfi <> giCodZonaImpoCli THEN --NO COMPARA ZONAS IMPOSITIVAS
			   	--dbms_output.Put_Line('cinco');
			   	  SELECT VAL_PARAMETRO
				    INTO giCodZonaImpositiva
				    FROM GED_PARAMETROS
				   WHERE NOM_PARAMETRO = '5'
				   	 AND COD_MODULO    = 'FA'
					 AND COD_PRODUCTO  = 1;
					 --dbms_output.Put_Line('uno');
			   ELSE
			   	   giCodZonaImpositiva:= giCodZonaImpoCli;
			   	   --dbms_output.Put_Line('dos');
			   END IF; */
			   giCodZonaImpositiva:= giCodZonaImpoOfi;
			ELSE
				--dbms_output.Put_Line('tres');
				RAISE ERROR_ZONA_OFIC;
			END IF;
		/*ELSE
			--dbms_output.Put_Line('cuatro');
			RAISE ERROR_ZONA_CLIE;
		END IF; */
        --dbms_output.Put_Line('seis');
		RETURN TRUE;

EXCEPTION
		WHEN ERROR_ZONA_CLIE THEN
                SET_ERROR('>> ERROR EN ZONA IMPOSITIVA DEL CLIENTE ');
				RETURN FALSE;
		WHEN ERROR_ZONA_OFIC THEN
                SET_ERROR('>> ERROR EN ZONA IMPOSITIVA DE LA OFICINA');
				RETURN FALSE;
        WHEN NO_DATA_FOUND THEN
                SET_ERROR('>> NO EXISTE ZONA IMPOSITIVA POR DEFECTO ');
				RETURN FALSE;
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO ');
				RETURN FALSE;
END EvaluaZonasImpositivas;
/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/

/* ********************************************************************************************* */
/*  CARGA CONCEPTOS YA PROCESADOS                                                                */
/* ********************************************************************************************* */
FUNCTION fbCargaDatos (plNumProceso IN NUMBER ) RETURN BOOLEAN IS

    ERROR_NO_CLIENTE EXCEPTION;
    CURSOR cCarga_Datos IS
        SELECT *
          FROM FAT_PRESUPTEMP
         WHERE NUM_PROCESO = plNumProceso
		 AND COD_TIPCONCE <> 1 ;
	i 		   			   	PLS_INTEGER := 0;

BEGIN
        VP_PROC         := 'fbCargaDatos             ';
        VP_TABLA        := 'FAT_PRESUPTEMP'           ;
        VP_ACT          := 'S'                        ;
        --DEBUG;
		glCodCliente := 0;
        FOR rRegDatos IN cCarga_Datos LOOP
            i := i + 1 ;
			Tab_FA_PRESUPUESTO(i).NUM_PROCESO       := rRegDatos.NUM_PROCESO	;
			Tab_FA_PRESUPUESTO(i).COD_CLIENTE       := rRegDatos.COD_CLIENTE	;
			Tab_FA_PRESUPUESTO(i).COD_CONCEPTO      := rRegDatos.COD_CONCEPTO   ;
			Tab_FA_PRESUPUESTO(i).COLUMNA           := rRegDatos.COLUMNA        ;
			Tab_FA_PRESUPUESTO(i).FEC_EFECTIVIDAD   := rRegDatos.FEC_EFECTIVIDAD;
			Tab_FA_PRESUPUESTO(i).IMP_CONCEPTO      := rRegDatos.IMP_CONCEPTO   ;
			Tab_FA_PRESUPUESTO(i).IMP_FACTURABLE    := rRegDatos.IMP_FACTURABLE ;
			Tab_FA_PRESUPUESTO(i).COD_TIPCONCE      := rRegDatos.COD_TIPCONCE   ;
			Tab_FA_PRESUPUESTO(i).COD_CONCEREL      := rRegDatos.COD_CONCEREL   ;
			Tab_FA_PRESUPUESTO(i).COLUMNA_REL       := rRegDatos.COLUMNA_REL    ;
			Tab_FA_PRESUPUESTO(i).FLAG_IMPUES       := rRegDatos.FLAG_IMPUES    ;
			Tab_FA_PRESUPUESTO(i).PRC_IMPUESTO      := rRegDatos.PRC_IMPUESTO   ;
			IF glCodCliente = 0 AND Tab_FA_PRESUPUESTO(i).COD_CLIENTE <> 0 THEN
			   glCodCliente := Tab_FA_PRESUPUESTO(i).COD_CLIENTE;
			END IF;
		END LOOP;

		IF i = 0 THEN
		   RETURN FALSE;
		END IF;

		IF glCodCliente = 0 THEN
		   RAISE ERROR_NO_CLIENTE;
		END IF;

		RETURN TRUE;

EXCEPTION
        WHEN ERROR_NO_CLIENTE THEN
           	 SET_ERROR('>> NO EXISTE CODIGO DE CLIENTE ');
		   	 RETURN FALSE;
        WHEN NO_DATA_FOUND THEN
           	 SET_ERROR('>> NO DATA FOUND ');
		   	 RETURN FALSE;
        WHEN OTHERS THEN
             SET_ERROR('>> ERROR INESPERADO ');
			 RETURN FALSE;
END fbCargaDatos;
/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* INSERTA DATOS DESDE EL ARREGLO A LA TABLA DE VENTAS DTO                               		 */
/* ********************************************************************************************* */
FUNCTION fbBorraDtos  RETURN BOOLEAN IS
i PLS_INTEGER := 0;
BEGIN
        VP_PROC         := 'fbBorraDtos        ';
        VP_TABLA        := 'FAT_PRESUPTEMP'     ;
        VP_ACT          := 'D'                  ;
        --DEBUG;

		DELETE FROM FAT_PRESUPTEMP WHERE NUM_PROCESO = lNumProceso_EXT;

        --dbms_output.Put_Line('SQLCODE : '||TO_CHAR(SQLCODE));

		RETURN TRUE;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SET_ERROR('>> NO DATA FOUND ??? ');
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO ');
END fbBorraDtos;
/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* INSERTA DATOS DESDE EL ARREGLO A LA TABLA DE VENTAS DTO                               		 */
/* ********************************************************************************************* */
FUNCTION fbInsertaDtos  RETURN BOOLEAN IS
i PLS_INTEGER := 0;
BEGIN
        VP_PROC         := 'fbInsertaDtos        '   ;
        VP_TABLA        := 'FAT_PRESUPTEMP'               ;
        VP_ACT          := 'I'                          ;
        --DEBUG;
        FOR i IN Tab_FA_PRESUPUESTO.FIRST .. Tab_FA_PRESUPUESTO.LAST LOOP
                INSERT INTO FAT_PRESUPTEMP
                       ( NUM_PROCESO	  , COD_CLIENTE
					   , COD_CONCEPTO	  , COLUMNA
					   , FEC_EFECTIVIDAD  , IMP_CONCEPTO
					   , IMP_FACTURABLE   , COD_CONCEREL
					   , COLUMNA_REL	  , FLAG_IMPUES
					   , PRC_IMPUESTO	  , COD_TIPCONCE)
                VALUES
                       (Tab_FA_PRESUPUESTO(i).NUM_PROCESO  	  , Tab_FA_PRESUPUESTO(i).COD_CLIENTE
					   , Tab_FA_PRESUPUESTO(i).COD_CONCEPTO	  , Tab_FA_PRESUPUESTO(i).COLUMNA
					   , Tab_FA_PRESUPUESTO(i).FEC_EFECTIVIDAD, Tab_FA_PRESUPUESTO(i).IMP_CONCEPTO
					   , Tab_FA_PRESUPUESTO(i).IMP_FACTURABLE , Tab_FA_PRESUPUESTO(i).COD_CONCEREL
					   , Tab_FA_PRESUPUESTO(i).COLUMNA_REL	  , Tab_FA_PRESUPUESTO(i).FLAG_IMPUES
					   , Tab_FA_PRESUPUESTO(i).PRC_IMPUESTO	  , Tab_FA_PRESUPUESTO(i).COD_TIPCONCE);
        END LOOP;

		RETURN TRUE;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SET_ERROR('>> NO DATA FOUND ??? ');
        WHEN DUP_VAL_ON_INDEX THEN
                SET_ERROR('>> INDICE DUPLICADO ');
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO ');
END fbInsertaDtos;
/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/


BEGIN
     VP_PROC         := 'FA_PROC_IMPTOS_main ';
     VP_TABLA        := 'FAT_PRESUPTEMP'      ;
     VP_ACT          := 'N'                   ;
	 VP_ERROR 		 := 0;

	 Inicializa();

     ----DEBUG;
     --dbms_output.Put_Line(Raya2);
     --dbms_output.Put_Line('** FECHA DE EJECUCION: ' || TO_CHAR(SYSDATE, '[DD/MON/YYYY][hh24:mi:ss]') || '  *');
     --dbms_output.Put_Line('');

	 IF fbCargaDatos (lNumProceso_EXT) THEN
        --dbms_output.Put_Line('Tab_FA_PRESUPUESTO.LAST : '||Tab_FA_PRESUPUESTO.LAST);
		IF EvaluaZonasImpositivas() THEN
			--dbms_output.Put_Line('EvaluaZonasImpositivas SALIO OK');
			Fa_Pac_Imptos.CARGAIMPTOS(Tab_FA_PRESUPUESTO
									 ,giCodZonaImpositiva
									 ,iCodCatImpos_EXT
									 ,VP_PROC
									 ,VP_TABLA
									 ,VP_ACT
									 ,VP_SQLCODE
									 ,VP_SQLERRM
									 ,VP_ERROR);

	        --dbms_output.Put_Line('Tab_FA_PRESUPUESTO.LAST : '||Tab_FA_PRESUPUESTO.LAST);
	        --dbms_output.Put_Line('VP_ERROR : '||VP_ERROR);
		  	IF VP_ERROR = 0 THEN
			   VP_PROC         := 'FA_PROC_IMPTOS_main ';
			   IF fbBorraDtos () THEN
			   	   IF NOT fbInsertaDtos () THEN
				       --dbms_output.Put_Line('Tab_FA_PRESUPUESTO.LAST'||Tab_FA_PRESUPUESTO.LAST);
					   /* COMMIT; */
				       RAISE ERROR_INSERDATOS;
				   END IF ;
			   ELSE
			   	   RAISE ERROR_BORRADATOS;
			   END IF;
			ELSE
			   RAISE ERROR_CALL_CARGAIMPTOS;
			END IF;
		ELSE
			--dbms_output.Put_Line('EvaluaZonasImpositivas SALIO CON ERROR');
			RAISE ERROR_GETZONACLIENTE;
		END IF;
	  ELSE
	  	  RAISE ERROR_CARGADATOS;
	  END IF;
      --dbms_output.Put_Line('****************************');
   EXCEPTION
		WHEN ERROR_CALL_CARGAIMPTOS THEN
        BEGIN
                VP_SQLERRM := 'Error en la rutina de impuestos';
                VP_SQLCODE :=  TO_CHAR(SQLCODE);
                VP_ERROR   :=  '1' ;
        END;
		WHEN ERROR_CARGADATOS THEN
        BEGIN
                VP_SQLERRM := 'Error en la carga de los conceptos';
                VP_SQLCODE :=  TO_CHAR(SQLCODE);
                VP_ERROR   :=  '1' ;
        END;
		WHEN ERROR_INSERDATOS THEN
        BEGIN
                VP_SQLERRM := 'Error en el insert de los datos';
                VP_SQLCODE :=  TO_CHAR(SQLCODE);
                VP_ERROR   :=  '1' ;
        END;
		WHEN ERROR_GETDIRCLIENTE THEN
        BEGIN
                VP_SQLERRM := 'Error en obtencion direccion cliente';
                VP_SQLCODE :=  TO_CHAR(SQLCODE);
                VP_ERROR   :=  '1' ;
        END;
		WHEN ERROR_GETZONACLIENTE THEN
        BEGIN
                VP_SQLERRM := 'Error en obtencion de zona impositiva';
                VP_SQLCODE :=  TO_CHAR(SQLCODE);
                VP_ERROR   :=  '1' ;
        END;
		WHEN NO_DATA_FOUND THEN
    		 NULL;
        WHEN OTHERS THEN
        	 NULL;
END Fa_Proc_Imptos;
/
SHOW ERRORS
