CREATE OR REPLACE PROCEDURE CO_P_COB_EXT_TMC (	vp_NumProceso	IN NUMBER,
												vp_CodProceso 	IN VARCHAR2,
												vp_NumIdent 	IN VARCHAR2,
												vp_CodTipIdent 	IN VARCHAR2,
												vp_CodCliente	IN NUMBER,
												vp_CodEntidad 	IN VARCHAR2,
												vp_CodEnvio  	IN VARCHAR2,
												vp_NomUsuario 	IN VARCHAR2,
												vp_MtoEnvioAnt	IN NUMBER
) IS

/*    Funcion        :Genera Registros en Formato COBEXTERNA TMC						   */
/*    Autor          :Ricardo Salazar  	  		  			 							   	 				*/
/*    Fecha          :30/05/2002																			*/
/*    Modificaciones :																						*/
/*                   :11/06/2002 (Modesto Aranda)															*/
/*                        se agrego caracter '#', el cual permite distinguir el fin de la  	 				*/
/*                        cadena en  el  programa cobexterna.pc			   	  	  	   	   	 				*/
/*                   :26/06/2002 (Modesto Aranda)										   	 				*/
/*                        Se elimina COMMIT y se mueve UPDATE que cambia estado de EP a SM 	 				*/
/*                   :08/07/2002 (Modesto Aranda)	   		  	  		 		   	  	   	 				*/
/*                        Inicializacion variable  v_deuda_total						   	 				*/
/*					 :12/07/2002 (Modesto Aranda)  										   	 				*/
/*					    - Control de numero de decimales (segun operadora)				   	 				*/
/*					    - Se utilizaran numeros en vez de letras para identificar el	   	 				*/
/*						  tipo de registro	(encabezado, detalle y pie)			  		   	 				*/
/*					 :30/10/2002 (Modesto Aranda)	   									   	 				*/
/*					    - Se cambia de lugar trozo de codigo que permite actualizar las    	 				*/
/*						  tablas de estadisticas CO_COBEXENV y CO_ARCHIVOS. Debido a que   	 				*/
/*						  no se estaban actualizando en el caso de las bajas.			   	 				*/
/*					 :16/12/2002 (Rodrigo Maturana)	  	 	  	 	 					   	 			 	*/
/*					 	- Se Marcan todos los Documentos de cada cliente con			   	 				*/
/*						  IND_INFORMADO = 'S' antes de pasarlos a CO_DET_ARCHIVOS		   	 				*/
/*     				 :30/04/2003 (Modesto Aranda)                                                           */
/*                      		 Se agrega obtencion del parametro "TIP_DOCTOS_INFORMAR"  de Ged_aparmetros */
/*                      		 y  el campo COD_ENTIDAD al accesar tablas CO_COBEXTERNA y CO_COBEXTERNADOC */
/*    Ult.Paso Pruduc:04/07/2002 (TMC --> BREGO) 										   					*/
/*                    16/12/2002 (TMC -->Produccion)														*/
/*                    16/12/2002 (DEIMOS) 		 															*/
/*                    15/07/2002 (HELENA --> Puerto Rico)													*/

v_reg_buenos       CO_ARCHIVOS.REG_BUENOS%TYPE;
v_mto_envio        CO_COBEXENV.MTO_ENVIO%TYPE;
vCntNumIdent       CO_COBEXENV.CNT_NUM_IDENT%TYPE;
v_deuda_total      CO_CARTERA.IMPORTE_DEBE%TYPE;
v_nom_archivo	   CO_ARCHIVOS.NOM_ARCHIVO%TYPE;
v_total_reg        CO_ARCHIVOS.TOT_REGISTROS%TYPE;
v_exis_mto_buenos  CO_ARCHIVOS.MTO_BUENOS%TYPE;
v_exis_reg_buenos  CO_ARCHIVOS.REG_BUENOS%TYPE;
v_exis_total_reg   CO_ARCHIVOS.TOT_REGISTROS%TYPE;
szhNomCliente      VARCHAR2(90);
szhNomCalle        GE_DIRECCIONES.NOM_CALLE%TYPE;
szhNumCalle        GE_DIRECCIONES.NUM_CALLE%TYPE;
szhNroPiso         GE_DIRECCIONES.NUM_PISO%TYPE;
szhDesComuna       GE_COMUNAS.DES_COMUNA%TYPE;
szhDesCiudad       GE_CIUDADES.DES_CIUDAD%TYPE;
lhDirPostal        NUMBER;
szhTelContacto     GA_CUENTAS.TEL_CONTACTO%TYPE;
szhNumFolio        CO_DICOMDOC.NUM_FOLIO%TYPE;
v_stg_general      VARCHAR2(1024);
szhFecVencimie     VARCHAR2(8);
szhFecEfectividad  VARCHAR2(8);
szhCodComuna       GE_COMUNAS.COD_COMUNA%TYPE;
szhCodCiudad       GE_CIUDADES.COD_CIUDAD%TYPE;
szhDesProvincia    GE_PROVINCIAS.DES_PROVINCIA%TYPE;
szhCodOficina      GE_OFICINAS.COD_OFICINA%TYPE;
szhDesOficina      GE_OFICINAS.DES_OFICINA%TYPE;
lhNumAbonado       CO_COBEXTERNADOC.NUM_ABONADO%TYPE;
ihSecCuota         CO_COBEXTERNADOC.SEC_CUOTA%TYPE;
dhImpDeuda         CO_COBEXTERNADOC.IMPORTE_DEBE%TYPE;
ihNumCuota         CO_COBEXTERNADOC.NUM_CUOTAS%TYPE;
szhTipDocum        CO_COBEXTERNADOC.COD_TIPDOCUM%TYPE;
szhCodRegion       GE_DIRECCIONES.COD_REGION%TYPE;
szhCodCategoria    GE_CLIENTES.COD_CATEGORIA%TYPE;
szhCodCatCuenta    CO_CATCUENTAS.COD_CATCUENTA%TYPE;
lhNumCelular       GA_ABOCEL.NUM_CELULAR%TYPE;
szhRutSantiago     CO_COBEXTERNA.NUM_IDENT_SANTIAGO%TYPE;
v_fin              CHAR(1) := '#';
iDecimal           NUMBER(2) := 0;--Decimales por Operadora.
v_Tip_Doctos_Infor	VARCHAR2(2) := ' '; -- Parametro que indica el tipo de documentos a considerar  (T = todos)

CURSOR C1( p1 VARCHAR2, p2 VARCHAR2 ) IS
SELECT COD_CLIENTE
  FROM GE_CLIENTES
 WHERE COD_TIPIDENT = p1
   AND NUM_IDENT = ltrim(rtrim( p2 ) );

C1_CLIENTE	C1%ROWTYPE;

CURSOR C2( p3 NUMBER , p4 VARCHAR2 , p5 VARCHAR2) IS
SELECT NUM_ABONADO
	  ,COD_TIPDOCUM
	  ,NUM_FOLIO
	  ,NVL( SEC_CUOTA, 0 ) SEC_CUOTA
	  ,NVL( ( IMPORTE_DEBE - IMPORTE_HABER ), 0 ) IMPORTE
	  ,TO_CHAR( FEC_EFECTIVIDAD, 'DDMMYYYY' ) FEC_EFECTIVIDAD
	  ,TO_CHAR( FEC_VENCIMIE   , 'DDMMYYYY' ) FEC_VENCIMIE
	  ,NVL( NUM_CUOTAS, 0 ) NUM_CUOTA
  FROM CO_COBEXTERNADOC
 WHERE COD_CLIENTE = p3
   AND COD_ENTIDAD = p5
   AND IND_INFORMADO in ('N',decode(ltrim(rtrim(p4)),'T','S','N'));

C2_DOCUM	C2%ROWTYPE;

BEGIN
    v_deuda_total := 0;
    v_total_reg := 0;
    v_reg_buenos := 0;
    v_nom_archivo := vp_CodProceso || '_' || vp_CodEntidad || '_' || vp_NumProceso || '.' || 'txt';

	/* Obtiene la cantidad de decimales a utilizar */
	SELECT GE_PAC_GENERAL.PARAM_GENERAL('num_decimal')
	  INTO iDecimal
	  FROM DUAL;

    /* Parametro que indica el tipo de documentos a considerar (Este se valida en el programa que invoca a este Procedimiento)*/
	SELECT VAL_PARAMETRO
	  INTO v_Tip_Doctos_Infor
	  FROM GED_PARAMETROS
	 WHERE NOM_PARAMETRO = 'TIP_DOCTOS_INFORMAR'
	   AND COD_MODULO = 'CO'
	   AND COD_PRODUCTO = 1;


	IF vp_CodEnvio <> 'B' AND vp_CodEnvio <> 'R'THEN
		FOR C1_CLIENTE IN C1( vp_CodTipIdent, vp_NumIdent ) LOOP
			FOR C2_DOCUM IN C2( C1_CLIENTE.COD_CLIENTE , v_Tip_Doctos_Infor , vp_CodEntidad ) LOOP
				szhCodCategoria := NULL;
				v_total_reg := v_total_reg + 1;

				szhTipDocum       := C2_DOCUM.COD_TIPDOCUM;
				szhNumFolio       := C2_DOCUM.NUM_FOLIO;
				dhImpDeuda        := C2_DOCUM.IMPORTE;
				szhFecVencimie    := C2_DOCUM.FEC_VENCIMIE;
				szhFecEfectividad := C2_DOCUM.FEC_EFECTIVIDAD;
				ihNumCuota        := C2_DOCUM.NUM_CUOTA;
				ihSecCuota        := C2_DOCUM.SEC_CUOTA;
				lhNumAbonado      := C2_DOCUM.NUM_ABONADO;

				BEGIN
					SELECT TO_CHAR(COD_CATEGORIA)
					  INTO szhCodCategoria
					  FROM GE_CLIENTES
					 WHERE COD_CLIENTE = C1_CLIENTE.COD_CLIENTE
					   AND COD_CATEGORIA IS NOT NULL;

					EXCEPTION
					WHEN NO_DATA_FOUND THEN
					BEGIN
						SELECT COD_CATCUENTA
						  INTO szhCodCatCuenta
						  FROM CO_CATCUENTAS
						 WHERE COD_CLIENTE = C1_CLIENTE.COD_CLIENTE
						   AND ( FEC_HASTA IS NULL OR ( TRUNC( FEC_HASTA ) = TO_DATE('31123000','DDMMYYYY') ) )
						   AND COD_CATCUENTA NOT IN ( 'PYMES', 'GRCLI' );
						EXCEPTION
							WHEN NO_DATA_FOUND THEN
								szhCodCatCuenta:='ENA';
					END;
				END;

				IF szhCodCategoria IS NOT NULL THEN
					SELECT NVL(SUBSTR( DES_VALOR, 1, 5 ), ' ' )
					  INTO szhCodCatCuenta
					  FROM CO_CODIGOS
					 WHERE NOM_TABLA	= 'GE_CLIENTES'
					   AND NOM_COLUMNA = 'COD_CATEGORIA'
					   AND TO_NUMBER( COD_VALOR ) = TO_NUMBER( szhCodCategoria );
				END IF;

				BEGIN
					SELECT NUM_CELULAR
					  INTO lhNumCelular
					  FROM GA_ABOCEL
					 WHERE NUM_ABONADO = C2_DOCUM.NUM_ABONADO
					   AND COD_SITUACION <>'BAA';
					EXCEPTION
						WHEN NO_DATA_FOUND THEN
							lhNumCelular := 00000000;
				END;

				BEGIN
					SELECT NUM_IDENT_SANTIAGO
					  INTO szhRutSantiago
					  FROM CO_COBEXTERNA
					 WHERE NUM_IDENT =vp_NumIdent
					   AND COD_TIPIDENT = vp_CodTipIdent
					   AND COD_ENTIDAD = vp_CodEntidad;
					EXCEPTION
						WHEN NO_DATA_FOUND THEN
							szhRutSantiago:=null;
				END;

				IF szhRutSantiago ='S' THEN
					szhCodRegion := 1;
				ELSE
					szhCodRegion := 2;
				END IF;

				--Marcar Documentos como Informados en tabla contingente.
				UPDATE CO_COBEXTERNADOC
				   SET IND_INFORMADO = 'S'
				 WHERE NUM_IDENT    = vp_NumIdent
				   AND COD_TIPIDENT = vp_CodTipIdent
				   AND COD_CLIENTE  = C1_CLIENTE.COD_CLIENTE
				   AND COD_ENTIDAD  = vp_CodEntidad;

				--Marcar Documentos como Informados en historia.
				UPDATE CO_HCOBEXTERNADOC
				   SET IND_INFORMADO = 'S'
				 WHERE NUM_IDENT    = vp_NumIdent
				   AND COD_TIPIDENT = vp_CodTipIdent
				   AND COD_CLIENTE  = C1_CLIENTE.COD_CLIENTE
				   AND COD_ENTIDAD  = vp_CodEntidad;

   				--***********************
				BEGIN
					SELECT NVL( RTRIM( GC.NOM_CLIENTE ), ' ' ) || ' ' || NVL( RTRIM( GC.NOM_APECLIEN1 ), ' ' ) || ' ' || NVL( RTRIM( GC.NOM_APECLIEN2 ), ' ' ),
						   NVL( RTRIM( G1.NOM_CALLE ), ' ' ),
						   NVL( RTRIM( G1.NUM_PISO ), ' ' ),
						   NVL( RTRIM( G1.NUM_CALLE ), ' ' ),
						   NVL( G1.COD_COMUNA, ' ' ),
						   NVL( RTRIM( G5.DES_COMUNA ), ' ' ),
						   NVL( G1.COD_CIUDAD, ' ' ),
						   NVL( RTRIM( G4.DES_CIUDAD ), ' ' ),
						   NVL( RTRIM( G3.DES_PROVINCIA ), ' ' ),
						   NVL( G6.COD_OFICINA, ' ' ),
						   NVL( RTRIM( G6.DES_OFICINA ), ' ' ),
						   NVL( GC.TEF_CLIENTE1, '00000000' )
					 INTO  szhNomCliente,
						   szhNomCalle,
						   szhNroPiso,
						   szhNumCalle,
						   szhCodComuna,
						   szhDesComuna,
						   szhCodCiudad,
						   szhDesCiudad,
						   szhDesProvincia,
						   szhCodOficina,
						   szhDesOficina,
						   szhTelContacto
					  FROM GE_OFICINAS    G6
						  ,GE_COMUNAS     G5
						  ,GE_CIUDADES    G4
						  ,GE_PROVINCIAS  G3
						  ,GE_REGIONES    G2
						  ,GE_DIRECCIONES G1
						  ,GA_DIRECCLI    G0
						  ,GE_CLIENTES    GC
					 WHERE GC.COD_CLIENTE = C1_CLIENTE.COD_CLIENTE
					   AND G0.COD_CLIENTE =  GC.COD_CLIENTE
					   AND G0.COD_TIPDIRECCION = 3
					   AND G1.COD_DIRECCION = G0.COD_DIRECCION
					   AND G2.COD_REGION    = G1.COD_REGION
					   AND G3.COD_REGION    = G1.COD_REGION
					   AND G3.COD_PROVINCIA = G1.COD_PROVINCIA
					   AND G4.COD_REGION    = G1.COD_REGION
					   AND G4.COD_PROVINCIA = G1.COD_PROVINCIA
					   AND G4.COD_CIUDAD    = G1.COD_CIUDAD
					   AND G5.COD_REGION    = G1.COD_REGION
					   AND G5.COD_PROVINCIA = G1.COD_PROVINCIA
					   AND G5.COD_COMUNA    = G1.COD_COMUNA
					   AND G6.COD_OFICINA   = NVL( GC.COD_OFICINA, '20' );

					EXCEPTION
						WHEN NO_DATA_FOUND THEN
							szhNomCliente:= null;
				END;

				v_stg_general := lpad(vp_NumProceso,8,'0')||rpad(vp_CodEntidad,5,' ')||rpad(vp_CodEnvio,1,' ')||rpad(vp_NumIdent,11,' ');
				v_stg_general := v_stg_general||rpad(vp_CodTipIdent,2,' ')||lpad(C1_CLIENTE.COD_CLIENTE,8,'0')||lpad(lhNumAbonado,8,'0');
				v_stg_general := v_stg_general||lpad(lhNumCelular,8,'0')||lpad(szhTipDocum,2,'0')||lpad(szhNumFolio,8,'0');
				v_stg_general := v_stg_general||lpad(ihNumCuota,2,'0')||lpad(ihSecCuota,2,'0')||lpad(GE_PAC_GENERAL.REDONDEA(dhImpDeuda, iDecimal, 0),14,'0');
				v_stg_general := v_stg_general||rpad(szhFecEfectividad,8,' ')||rpad(szhFecVencimie,8,' ')||rpad(szhNomCliente,50,' ');
				v_stg_general := v_stg_general||rpad(szhNomCalle,50,' ')||rpad(szhNroPiso,10,' ')||rpad(szhNumCalle,10,' ');
				v_stg_general := v_stg_general||rpad(szhCodComuna,5,' ')||rpad(szhDesComuna,30,' ')||rpad(szhCodCiudad,5,' ');
				v_stg_general := v_stg_general||rpad(szhDesCiudad,30,' ')||rpad(szhDesProvincia,30,' ')||rpad(szhCodOficina,2,' ');
				v_stg_general := v_stg_general||rpad(szhDesOficina,40,' ')||rpad(szhTelContacto,12,' ')||rpad(szhCodCatCuenta,5,' ');
				v_stg_general := v_stg_general||lpad(szhCodRegion,1,'0')||v_fin;

				INSERT INTO CO_DET_ARCHIVOS( NUM_PROCESO, COD_PROCESO, COD_ENTIDAD, TIP_REGITRO, TXT_REGISTRO )
				VALUES( vp_NumProceso, vp_CodProceso, vp_CodEntidad, '2', v_stg_general );

				v_deuda_total := v_deuda_total + dhImpDeuda;
				v_reg_buenos := v_reg_buenos + 1;
			END LOOP;
		END LOOP;

		--DBMS_OUTPUT.PUT_LINE('TERMINE OK');
    ELSE
	   --Marcar Documentos como Informados.
	   UPDATE CO_HCOBEXTERNADOC
		  SET IND_INFORMADO = 'S'
		WHERE NUM_IDENT    = vp_NumIdent
		  AND COD_TIPIDENT = vp_CodTipIdent
		  AND COD_ENTIDAD = vp_CodEntidad;

	   v_total_reg := v_total_reg + 1;
	   v_reg_buenos := v_reg_buenos + 1;
       v_stg_general := lpad(vp_NumProceso,8,'0')||rpad(vp_CodEntidad,5,' ')||'B'||rpad(vp_NumIdent,11,' ')||rpad(vp_CodTipIdent,350,' ')||v_fin;
       INSERT INTO CO_DET_ARCHIVOS( NUM_PROCESO, COD_PROCESO, COD_ENTIDAD, TIP_REGITRO, TXT_REGISTRO )
       VALUES( vp_NumProceso, vp_CodProceso, vp_CodEntidad, '2', v_stg_general );
    END IF; /* IF vp_CodEnvio <> B AND vp_CodEnvio <> R THEN */

    /*  actualizacion de las tablas de estadisticas */
	BEGIN
	    SELECT NVL( MTO_BUENOS, 0 ), REG_BUENOS, TOT_REGISTROS
		  INTO v_exis_mto_buenos, v_exis_reg_buenos, v_exis_total_reg
		  FROM CO_ARCHIVOS
		 WHERE NUM_PROCESO = vp_NumProceso
		   AND COD_PROCESO = vp_CodProceso
		   AND NOM_ARCHIVO = v_nom_archivo;

		EXCEPTION
	   	    WHEN NO_DATA_FOUND THEN
    	        v_exis_reg_buenos := NULL;
	END;

	IF v_exis_mto_buenos IS NULL THEN
	   --insert co_archivos
	   INSERT INTO CO_ARCHIVOS( NUM_PROCESO, COD_PROCESO, FEC_PROCESO, COD_ENTIDAD, NOM_ARCHIVO,
	   							TOT_REGISTROS, REG_BUENOS, MTO_BUENOS, NOM_USUARIO)
	   VALUES( vp_NumProceso, vp_CodProceso, SYSDATE, vp_CodEntidad, v_nom_archivo,
	   		   v_total_reg, v_reg_buenos, v_deuda_total, vp_NomUsuario );
	ELSE
	   v_exis_mto_buenos := NVL( v_deuda_total, 0 ) + NVL( v_exis_mto_buenos, 0 );
	   v_exis_reg_buenos := v_exis_reg_buenos + v_reg_buenos;
       v_exis_total_reg  := v_exis_total_reg + v_total_reg;

       --update a la tabla co_archivos
		UPDATE CO_ARCHIVOS
		   SET MTO_BUENOS = v_exis_mto_buenos,
		       REG_BUENOS = v_exis_reg_buenos,
		       TOT_REGISTROS = v_exis_total_reg
		 WHERE NUM_PROCESO = vp_NumProceso
		   AND COD_PROCESO = vp_CodProceso
		   AND NOM_ARCHIVO = v_nom_archivo;
	END IF;

	BEGIN
		SELECT CNT_NUM_IDENT + 1, NVL( MTO_ENVIO, 0 )
		  INTO vCntNumIdent,v_mto_envio
		  FROM CO_COBEXENV
		 WHERE NUM_PROCESO = vp_NumProceso
		   AND COD_ENTIDAD = vp_CodEntidad
		   AND COD_ENVIO = vp_CodEnvio;

		EXCEPTION
	   	    WHEN NO_DATA_FOUND THEN
    	        v_mto_envio :=  NULL;
				vCntNumIdent := 1;
	END;

	IF v_mto_envio IS NULL THEN
	   v_mto_envio := NVL( v_deuda_total, 0 ) - NVL( vp_MtoEnvioAnt, 0 );
	   INSERT INTO CO_COBEXENV( NUM_PROCESO, COD_ENTIDAD, COD_ENVIO, CNT_NUM_IDENT, MTO_ENVIO )
	   VALUES( vp_NumProceso, vp_CodEntidad, vp_CodEnvio, vCntNumIdent, v_mto_envio );
	ELSE
	   v_mto_envio := v_mto_envio + ( v_deuda_total - vp_MtoEnvioAnt );
		UPDATE CO_COBEXENV
		   SET CNT_NUM_IDENT = vCntNumIdent,
			   MTO_ENVIO = v_mto_envio
		 WHERE NUM_PROCESO = vp_NumProceso
		   AND COD_ENTIDAD = vp_CodEntidad
		   AND COD_ENVIO = vp_CodEnvio;
	END IF;

	UPDATE CO_COBEXTERNA
	   SET FEC_MOVIMIENTO = SYSDATE,
		   NUM_PROCESO = vp_NumProceso,
		   MTO_ENVIOANT = v_deuda_total
	 WHERE NUM_IDENT = vp_NumIdent
	   AND COD_TIPIDENT = vp_CodTipIdent
	   AND COD_ENTIDAD = vp_CodEntidad;

EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE(SQLERRM);
END CO_P_COB_EXT_TMC;
/
SHOW ERRORS
