CREATE OR REPLACE PACKAGE BODY ICC_EVALUA_SERV_PREREQ_PG AS


FUNCTION IC_RETORNA_SERVCOM_FN(EN_SERVICC IN NUMBER,EN_NIVICC IN NUMBER) RETURN VARCHAR2
IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_RETORNA_SERVCOM_FN" Lenguaje="PL/SQL" Fecha="09-03-2007" Versión="1.0.0" Diseñador="José J. Figueroa " Programador="José J. Figueroa" Ambiente="DEIMOS_COL">
<Retorno>VARCHAR2</Retorno>
<Descripción>Retorna los codigos de servicio comercial equicalentes al servicio de ICC</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_SERVICC" Tipo="NUMBER">Servicio de IC</param>
<param nom="EN_NIVICC" Tipo="NUMBER">Nivel de IC</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
LV_servcom GA_SERVSUPL.COD_SERVICIO%TYPE;
LV_salida  VARCHAR2(512);
LN_servicc GA_SERVSUPL.COD_SERVSUPL%TYPE;
LN_nivicc GA_SERVSUPL.COD_NIVEL%TYPE;

CURSOR cServicios (LN_servicc GA_SERVSUPL.COD_SERVSUPL%TYPE,LN_nivicc GA_SERVSUPL.COD_NIVEL%TYPE)IS
SELECT COD_SERVICIO
FROM GA_SERVSUPL
WHERE COD_SERVSUPL=LN_servicc
AND COD_NIVEL =LN_nivicc
GROUP BY COD_SERVICIO;

BEGIN

LN_servicc:=EN_SERVICC;
LN_nivicc:=EN_NIVICC;

	FOR B1 IN cServicios(LN_servicc,LN_nivicc) LOOP
		BEGIN
	 		 IF (LV_salida IS NULL) THEN
			 	    LV_salida:= B1.COD_SERVICIO;
			  ELSE
			 	    LV_salida:=LV_salida || '|' || B1.COD_SERVICIO;
			  END IF;
		END;
	END LOOP;

RETURN LV_salida;

EXCEPTION
     WHEN NO_DATA_FOUND   THEN
          RETURN 'NO_DATA_FOUND';
     WHEN OTHERS THEN
	 	  RETURN 'OTHERS';
END IC_RETORNA_SERVCOM_FN;


FUNCTION IC_RETORNA_BAJAS_COMER_FN(EN_CAD_SERV IN VARCHAR2,EN_NUM_ABO GA_SERVSUPLABO.NUM_ABONADO%TYPE) RETURN VARCHAR2
IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_RETORNA_BAJAS_COMER_FN" Lenguaje="PL/SQL" Fecha="09-03-2007" Versión="1.0.0" Diseñador="José J. Figueroa " Programador="José J. Figueroa" Ambiente="DEIMOS_COL">
<Retorno>VARCHAR2</Retorno>
<Descripción>Busca las bajas y las transforma a servicios comerciales, retorna una cadena de servicios comerciales separados por coma</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_CAD_SERV" Tipo="VARCHAR2">Cadena de servicio de ICC</param>
<param nom="EN_NUM_ABO" Tipo="GA_SERVSUPLABO.NUM_ABONADO%TYPE">Número de abonado</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
LV_cad_servIC VARCHAR2(255);
LV_cad_serv2 VARCHAR2(255);
LV_cad_servCom VARCHAR2(255);
LV_salida VARCHAR2(255);
LN_pos NUMBER;
LN_nivicc GA_SERVSUPLABO.COD_NIVEL%TYPE;
LN_error NUMBER;
BEGIN
	LV_salida :='';
	LN_pos :=1;
	LN_error:=0;
	LV_cad_servIC := EN_CAD_SERV;

    WHILE (LN_pos<=length(LV_cad_servIC)) LOOP

											LV_cad_serv2 :=substr(LV_cad_servIC,LN_pos,6);
											IF (to_number(substr(LV_cad_serv2,3,4))=0) THEN

											   BEGIN

														   SELECT UNIQUE COD_NIVEL
														   INTO LN_nivicc
														   FROM GA_SERVSUPLABO
														   WHERE NUM_ABONADO = EN_NUM_ABO
														   AND COD_SERVSUPL=to_number(substr(LV_cad_serv2,1,2))
														   AND IND_ESTADO=3;

												  EXCEPTION
												     WHEN NO_DATA_FOUND   THEN
												  				 	  LN_error:=1;
														   WHEN OTHERS THEN
														  		 	  LN_error:=1;
									   	 END;

											   IF (LN_error=0)THEN
									  			   LV_cad_servCom := IC_RETORNA_SERVCOM_FN(to_number(substr(LV_cad_serv2,1,2)),LN_nivicc);
									  			   IF (LV_salida IS NULL )THEN
											  	   	  LV_salida := LV_cad_servCom;
												     ELSE
												     	  LV_salida := LV_salida || '|' || LV_cad_servCom;
												     END IF;
											   END IF;

											   LN_pos:=LN_pos+6;

											ELSE
											   LN_pos:=LN_pos+6;
											END IF;

    END LOOP;

RETURN LV_salida;

EXCEPTION
     WHEN NO_DATA_FOUND   THEN
          RETURN sqlerrm;
     WHEN OTHERS THEN
	 	  RETURN sqlerrm;
END IC_RETORNA_BAJAS_COMER_FN;



FUNCTION IC_RETORNA_SERVDEF_FN(EN_NUM_ABO IN ICC_MOVIMIENTO.NUM_ABONADO%TYPE, EN_CAD_SERVCOM IN VARCHAR2) RETURN VARCHAR2
IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_RETORNA_SERVDEF_FN" Lenguaje="PL/SQL" Fecha="09-03-2007" Versión="1.0.0" Diseñador="José J. Figueroa " Programador="José J. Figueroa" Ambiente="DEIMOS_COL">
<Retorno>VARCHAR2</Retorno>
<Descripción></Descripción>
<Parámetros>
<Entrada>
<param nom="EN_NUM_ABO" Tipo="NUMBER(9)">Número de abonado</param>
<param nom="EN_CAD_SERVCOM" Tipo="NUMBER(9)">Cadena de servicios comerciales separada por comas</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
LV_servcom  VARCHAR2(512);
LV_servcom2 VARCHAR2(512);
LV_servcom3 VARCHAR2(512);
LV_salida   VARCHAR2(512);
LN_pos		NUMBER;
LN_pospipe	NUMBER;

LV_SERVDEF 		VARCHAR2(512);
LN_CUENTASERV 	NUMBER;
LV_SERV_BAJAR	VARCHAR2(512);
LV_SERV_NOBAJAR	VARCHAR2(512);
LN_bajas    	NUMBER;
LN_NoBajas    	NUMBER;
LN_flag      	NUMBER;
LV_part1		VARCHAR2(512);
LV_part2		VARCHAR2(512);


CURSOR cServiciosDef(LV_serdef VARCHAR2,LV_abo GA_SERVSUPLABO.NUM_ABONADO%TYPE) IS
SELECT COD_SERVICIO, COD_SERVDEF
FROM GA_SERVSUP_DEF
WHERE COD_SERVDEF=LV_serdef
AND TIP_RELACION=5
AND COD_SERVICIO IN
	(SELECT COD_SERVICIO
	 FROM GA_SERVSUPLABO
	 WHERE NUM_ABONADO =LV_abo
	 AND IND_ESTADO =2);

CURSOR cServiciosReq(LV_ser VARCHAR2,LV_serDefi VARCHAR2) IS
SELECT COD_SERVICIO,COD_SERVDEF
FROM GA_SERVSUP_DEF
WHERE COD_SERVICIO=LV_ser
AND COD_SERVDEF <> LV_serDefi
AND TIP_RELACION=5;

B1 cServiciosReq%ROWTYPE;

BEGIN

LV_servcom:=EN_CAD_SERVCOM;

LN_flag    :=0;
LN_pos	   :=1;
LN_bajas   :=1;
LN_NoBajas :=1;
LV_servcom3:=LV_servcom;
LV_SERV_NOBAJAR :=' ';
LV_part1:='';
LV_part2:='';


   WHILE (LN_pos<=length(LV_servcom)) LOOP

		        LN_pospipe  := INSTR(LV_servcom3,'|',1);
        		IF (LN_pospipe > 1) THEN
        		   LV_servcom2 := substr(LV_servcom3,1,LN_pospipe-1);
        		ELSE
        		   LV_servcom2 := LV_servcom3;
        		END IF;

		FOR C1 IN cServiciosDef(LV_servcom2,EN_NUM_ABO) LOOP
			BEGIN

					OPEN cServiciosReq(C1.COD_SERVICIO, C1.COD_SERVDEF) ;
					LOOP
						FETCH cServiciosReq INTO B1;
						EXIT WHEN cServiciosReq%NOTFOUND;
						BEGIN
								LN_flag:=1;

								SELECT COUNT(COD_SERVICIO)
								INTO LN_CUENTASERV
								FROM GA_SERVSUPLABO
								WHERE NUM_ABONADO = EN_NUM_ABO
								AND COD_SERVICIO = B1.COD_SERVDEF
								AND IND_ESTADO IN (1,2);

								IF (LN_CUENTASERV >=1) THEN

									IF (LN_NoBajas=1) THEN
									   LV_SERV_NOBAJAR := B1.COD_SERVICIO;
									END IF;
									LN_NoBajas := LN_NoBajas + 1;

									IF (instr(LV_SERV_BAJAR,B1.COD_SERVICIO)>0) THEN

									   LV_part1:=substr(LV_SERV_BAJAR,1,instr(LV_SERV_BAJAR,B1.COD_SERVICIO)-2);
									   IF (LV_part1<>'') THEN
									   	  LV_part2:= substr(LV_SERV_BAJAR,instr(LV_SERV_BAJAR,B1.COD_SERVICIO)+length(B1.COD_SERVICIO)+1);
									   ELSE
									   	   LV_part2:= substr(LV_SERV_BAJAR,instr(LV_SERV_BAJAR,B1.COD_SERVICIO)+length(B1.COD_SERVICIO));
									   END IF;

									   LV_SERV_BAJAR:=LV_part1 || LV_part2;

									END IF;

								   EXIT;

								ELSE
								    IF (instr(LV_SERV_NOBAJAR,B1.COD_SERVICIO)=0) THEN
										IF (LN_bajas=1) THEN
										   LV_SERV_BAJAR := B1.COD_SERVICIO;
										END IF;

										IF instr(LV_SERV_BAJAR,B1.COD_SERVICIO) = 0 THEN
										   LV_SERV_BAJAR:= LV_SERV_BAJAR ||'|'|| B1.COD_SERVICIO;
										END IF;
										LN_bajas := LN_bajas + 1;
									END IF;

								END IF;
						END;
					END LOOP;
					CLOSE cServiciosReq;
					IF (LN_flag=0) THEN
					   LV_SERV_BAJAR := C1.COD_SERVICIO;
					   EXIT;
					END IF;
			END;
		END LOOP;

		IF (LN_pospipe > 1) THEN
		   LN_pos := INSTR(LV_servcom3,'|')+1;
		   LV_servcom3:= SUBSTR(LV_servcom3,LN_pos);
		ELSE
			LN_pos:=length(LV_servcom)+1;
		END IF;

   END LOOP;


LV_salida:= LV_SERV_BAJAR;

RETURN LV_salida;

EXCEPTION
     WHEN NO_DATA_FOUND   THEN
          RETURN '';
     WHEN OTHERS THEN
	 	  RETURN '';
END IC_RETORNA_SERVDEF_FN;





FUNCTION IC_RETORNA_SERVICC_FN(EN_CAD_SERVCOM IN VARCHAR2) RETURN VARCHAR2
IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_RETORNA_SERVICC_FN" Lenguaje="PL/SQL" Fecha="09-03-2007" Versión="1.0.0" Diseñador="José J. Figueroa " Programador="José J. Figueroa" Ambiente="DEIMOS_COL">
<Retorno>VARCHAR2</Retorno>
<Descripción>Entra cadena de servicio Comercial y sale cadena de servicio ICC</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_CAD_SERVCOM" Tipo="VARCHAR2">Cadena de servicio comercial</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
LV_servcom  VARCHAR2(512);
LV_servcom2 VARCHAR2(512);
LV_servcom3 VARCHAR2(512);
LV_salida   VARCHAR2(512);
LV_sertmp   VARCHAR2(512);
LN_pos		NUMBER;
LN_largo	NUMBER;
LN_ceros	NUMBER;


CURSOR cServiciosIc(LV_serCom VARCHAR2) IS
SELECT COD_SERVSUPL
FROM GA_SERVSUPL
WHERE COD_SERVICIO=LV_serCom;


BEGIN

		LV_servcom:=EN_CAD_SERVCOM;
		LN_pos :=1;

		LV_servcom3:=LV_servcom;

	    WHILE (LENGTH(LV_servcom3)<>0) LOOP

			IF (INSTR(LV_servcom3,'|')=0) THEN
			    LV_servcom2 :=LV_servcom3;
			ELSE
				LV_servcom2 := SUBSTR(LV_servcom3,LN_pos,INSTR(LV_servcom3,'|')-1);
			END IF;

			FOR C1 IN cServiciosIc(LV_servcom2) LOOP
				BEGIN
					 LV_sertmp:= C1.COD_SERVSUPL;
					 --LV_sertmp:= RPAD(LV_sertmp,6,'0');
					 LV_sertmp:= LPAD(LV_sertmp,2,'0')||'0000';

					 IF LV_salida IS NULL THEN
					 	LV_salida:= LV_salida || LV_sertmp;
					 ELSE
						 IF (INSTR(LV_salida,LV_sertmp)=0) THEN
						   LV_salida:= LV_salida || LV_sertmp;
						 END IF;
					 END IF;

				END;
			END LOOP;

			IF (INSTR(LV_servcom3,'|')=0) THEN
			    LV_servcom3:= '';
			ELSE
				LV_servcom3:= SUBSTR(LV_servcom3,INSTR(LV_servcom3,'|')+1);
			END IF;

	    END LOOP;

RETURN LV_salida;

EXCEPTION
     WHEN NO_DATA_FOUND   THEN
          RETURN 'NO_DATA_FOUND';
     WHEN OTHERS THEN
	 	  RETURN '';
END IC_RETORNA_SERVICC_FN;

FUNCTION IC_PAREASERVICIOS_FN(EN_CAD_SERV IN ICC_MOVIMIENTO.COD_SERVICIOS%TYPE ,EN_CAD_SERV_ICC_BAJA IN VARCHAR2) RETURN BOOLEAN
IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_PAREASERVICIOS_FN" Lenguaje="PL/SQL" Fecha="04-02-2009" Versión="1.0.0" Diseñador="Hector Leiva R " Programador="Hector Leiva R" Ambiente="DEIMOS_COL">
<Retorno>BOOLEAN</Retorno>
<Descripción>Actualiza el campo cod_servicios de la icc_movimiento, para adjuntar los servicios que se deban dar de baja</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_CAD_SERV" Tipo="ICC_MOVIMIENTO.COD_SERVICIOS%TYPE">Número de movimiento</param>
<param nom="EN_CAD_SERV_ICC_BAJA" Tipo="VARCHAR2">servicio(s) de baja que se concatene(n) al final de la cadena de servicios</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LV_serv_a_bajar VARCHAR2(512);
LV_cadenaServ STRING(512);
v_ind NUMBER;
v_len_ser NUMBER;
v_cont NUMBER DEFAULT 1;
v_ser_tmp VARCHAR2(512);


BEGIN
	    v_ind := 0;
		LV_serv_a_bajar := EN_CAD_SERV_ICC_BAJA;
		LV_cadenaServ := EN_CAD_SERV;
        v_len_ser := LENGTH(LV_cadenaServ);

        WHILE v_cont < v_len_ser LOOP
           v_ser_tmp := SUBSTR(LV_cadenaServ,v_cont,6);
           v_cont := v_cont+6;
		   IF (LV_serv_a_bajar = v_ser_tmp) THEN
			  v_ind := 1;
		   END IF;
		END LOOP;

		IF (v_ind = 1) THEN
			RETURN FALSE;
		ELSE
			RETURN TRUE;
		END IF;

END IC_PAREASERVICIOS_FN;

FUNCTION IC_UPDATE_SERV_MOVIMIENTO_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE, EN_CAD_SERV_ICC_BAJA IN VARCHAR2) RETURN BOOLEAN
IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_UPDATE_SERV_MOVIMIENTO_FN" Lenguaje="PL/SQL" Fecha="09-03-2007" Versión="1.0.0" Diseñador="José J. Figueroa " Programador="José J. Figueroa" Ambiente="DEIMOS_COL">
<Retorno>BOOLEAN</Retorno>
<Descripción>Actualiza el campo cod_servicios de la icc_movimiento, para adjuntar los servicios que se deban dar de baja</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_NUM_MOV" Tipo="ICC_MOVIMIENTO.NUM_MOVIMIENTO">Número de movimiento</param>
<param nom="EN_CAD_SERV_ICC_BAJA" Tipo="VARCHAR2">servicio(s) de baja que se concatene(n) al final de la cadena de servicios</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LV_serv_a_bajar VARCHAR2(512);
LV_nummov ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;

BEGIN

	LV_serv_a_bajar := EN_CAD_SERV_ICC_BAJA;
	LV_nummov     := EN_NUM_MOV;

	UPDATE ICC_MOVIMIENTO
	SET COD_SERVICIOS = COD_SERVICIOS || LV_serv_a_bajar
	WHERE NUM_MOVIMIENTO=LV_nummov;

	RETURN TRUE;

EXCEPTION
     WHEN NO_DATA_FOUND   THEN
          RETURN FALSE;
     WHEN OTHERS THEN
	 	  RETURN FALSE;
END IC_UPDATE_SERV_MOVIMIENTO_FN;




FUNCTION IC_EVALUA_CAMBIO_NIVEL_FN(
                                     EN_NUM_ABO IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE,
																																					EV_cadenaServ IN VARCHAR2
																																				) RETURN VARCHAR2
																																				IS

-- TAREAS PENDIENTES AL CODIFICAR
/*
DOCUMENTAR pl
DEFINIR CONT6ROL DE ERROR

*/
  LV_GrupoDato  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
	 LI_Etapa INTEGER;
		LV_Respuesta VARCHAR2(10);
		LV_GrupoCadenaServicio GA_SRVCRM_PG.GrupoSS;
		LV_NivelCadenaServicio GA_SRVCRM_PG.NivelSS;
		LI_Posicion INTEGER;
		LI_LargoCadenaServicio INTEGER;
  LV_CodComerOriginalCambioNivel GA_SRVCRM_PG.CodigoComercialSS;
		LV_NivelOriginalCambioNivel GA_SRVCRM_PG.NivelSS;
  LN_COD_RETORNO ge_errores_pg.coderror;
  LV_MENS_RETORNO ge_errores_pg.msgerror;
  LV_NUM_EVENTO ge_errores_pg.evento;
	 LB_ServicioInformadoDatoCorreo BOOLEAN;
		LB_ServicioOriginalDatoCorreo BOOLEAN;
		LB_ServicioCorreoContratado BOOLEAN;
		LV_GrupoServicioCorreo GA_SRVCRM_PG.GrupoSS;
		LV_NivelServicioCorreo GA_SRVCRM_PG.NivelSS;
		LV_CodComerServicioInformado GA_SRVCRM_PG.CodigoComercialSS;
  LV_CodComerServicioCorreo GA_SRVCRM_PG.CodigoComercialSS;
		LC_refCursor GA_SRVCRM_PG.refcursor;
  LV_PLATAFORMA GED_CODIGOS.DES_VALOR%TYPE;
  Error_GetCorreoContratado EXCEPTION;
  Error_GetCodigoComercial EXCEPTION;

BEGIN

	LI_Etapa:= 0;
	LV_Respuesta := '';
	LB_ServicioInformadoDatoCorreo:= FALSE;
	LB_ServicioOriginalDatoCorreo:= FALSE;
	LB_ServicioCorreoContratado:= FALSE;

	SELECT VAL_PARAMETRO
	INTO LV_GrupoDato
	FROM GED_PARAMETROS
	WHERE NOM_PARAMETRO = 'GRUPO_DATO'
	AND COD_MODULO = 'GE';

	LI_Etapa:= 1;
	LI_Posicion := 0;
	LI_LargoCadenaServicio:= LENGTH(EV_cadenaServ);
	WHILE (LI_Posicion < LI_LargoCadenaServicio) LOOP

	   LV_GrupoCadenaServicio:= TO_NUMBER(SUBSTR(EV_cadenaServ,LI_Posicion+1,2));
				LV_NivelCadenaServicio:= TO_NUMBER(SUBSTR(EV_cadenaServ,LI_Posicion+3,4));
				IF LV_GrupoCadenaServicio = TRIM(LV_GrupoDato) THEN
				   -- El serv informado es de dato

				   GA_SRVCRM_PG.GA_GetServicioCambioNivel_PR(EN_NUM_ABO,LV_GrupoCadenaServicio,LV_NivelOriginalCambioNivel,LV_CodComerOriginalCambioNivel,LN_COD_RETORNO,LV_MENS_RETORNO,LV_NUM_EVENTO);
							IF LN_COD_RETORNO = 0 AND LV_CodComerOriginalCambioNivel IS NOT NULL THEN
							   ---- Existe cambio de nivel ==> servicio informado y original son de datos
   				   IF GA_SRVCRM_PG.GA_IsSrvDatos_FN(LV_GrupoCadenaServicio,LV_NivelCadenaServicio,LN_COD_RETORNO,LV_MENS_RETORNO,LV_NUM_EVENTO) THEN
			   				   -- El servicio informado es  de  datos y esta asociado a correo
	            LB_ServicioInformadoDatoCorreo:= TRUE;
							   END IF;

							   IF GA_SRVCRM_PG.GA_IsSrvDatos_FN(LV_GrupoCadenaServicio,LV_NivelOriginalCambioNivel,LN_COD_RETORNO,LV_MENS_RETORNO,LV_NUM_EVENTO) THEN
										   -- El servicio original es de datos y esta asociado a correo
										   LB_ServicioOriginalDatoCorreo:= TRUE;
										END IF;
										--DEBEMOS EVALUAR 4 SITUACIONES DIEFERENCTES
										--Caso 1 (Serv Original es de dato asociado a correo, Serv Informado es de dato asociado a corre)
										--Caso 2 (Serv Original es de dato asociado a correo, Serv Informado es de dato no asociado a corre)
										--Caso 3 (Serv Original es de dato no asociado a correo, Serv Informado es de dato asociado a corre)
										--Caso 4 (Serv Original es de dato no asociado a correo, Serv Informado es de dato no asociado a corre)

										IF LB_ServicioOriginalDatoCorreo THEN
										   -- Verificar si tiene servicio de correo contratado
													GA_SRVCRM_PG.GA_EstadoSrvCorreoData_PR (EN_NUM_ABO,'C',LV_GrupoServicioCorreo,LV_NivelServicioCorreo,LV_PLATAFORMA, LN_COD_RETORNO,LV_MENS_RETORNO,LV_NUM_EVENTO);
													IF LN_COD_RETORNO > 0 THEN
                RAISE Error_GetCorreoContratado;
													ELSIF LV_GrupoServicioCorreo IS NOT NULL THEN
													  LB_ServicioCorreoContratado	:= TRUE;
													ELSE
															LB_ServicioCorreoContratado	:= FALSE;
													END IF;
										END IF;


										--CASO 1
										IF LB_ServicioOriginalDatoCorreo AND LB_ServicioInformadoDatoCorreo THEN
             IF	LB_ServicioCorreoContratado THEN
													   --Obtengo Código Comercial de Correo
													   GA_SRVCRM_PG.GA_CodigoComercialSS_PR (LV_GrupoServicioCorreo,LV_NivelServicioCorreo,LV_CodComerServicioCorreo,LN_COD_RETORNO,LV_MENS_RETORNO,LV_NUM_EVENTO);
																IF LN_COD_RETORNO > 0 OR LV_CodComerServicioCorreo IS NULL THEN
																   RAISE Error_GetCodigoComercial;
                END IF;
																--Obtengo Código Comercial de Servicio Informado
													   GA_SRVCRM_PG.GA_CodigoComercialSS_PR (LV_GrupoCadenaServicio,LV_NivelCadenaServicio,LV_CodComerServicioInformado,LN_COD_RETORNO,LV_MENS_RETORNO,LV_NUM_EVENTO);
																IF LN_COD_RETORNO > 0 OR LV_CodComerServicioInformado IS NULL THEN
																   RAISE Error_GetCodigoComercial;
																END IF;
																-- Verifico si El servicio Informado No Sirve como Pre-Requisito para el servicio de correo cotratado
													   IF NOT GA_SRVCRM_PG.GA_IsPreRequisito_FN (LV_CodComerServicioCorreo,LV_CodComerServicioInformado,LN_COD_RETORNO,LV_MENS_RETORNO,LV_NUM_EVENTO) THEN
																   LV_Respuesta:= LV_Respuesta || TRIM(TO_CHAR(LV_GrupoServicioCorreo,'09')) || '0000';
																END IF;
													END IF;
										END IF;

										-- Caso 2
										IF LB_ServicioOriginalDatoCorreo AND NOT LB_ServicioInformadoDatoCorreo THEN
										   IF	LB_ServicioCorreoContratado THEN
																   LV_Respuesta:= LV_Respuesta || TRIM(TO_CHAR(LV_GrupoServicioCorreo,'09')) || '0000';
													END IF;
										END IF;

										-- Caso 3, y 4 no interesa, en ambos no puede estar el de correo contratado

				   END IF;
				END IF;
				LI_Posicion := LI_Posicion + 6;

	END LOOP;

	RETURN LV_Respuesta;

EXCEPTION
	   WHEN NO_DATA_FOUND THEN
	        IF LI_Etapa = 0 THEN
									   RETURN 'FALSE';
	        END IF;
    WHEN Error_GetCorreoContratado THEN
				     RETURN 'FALSE';
				WHEN Error_GetCodigoComercial THEN
									RETURN 'FALSE';

END IC_EVALUA_CAMBIO_NIVEL_FN;


FUNCTION ICC_EVALUA_SERV_PREREQ_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE, EN_NUM_ABO IN ICC_MOVIMIENTO.NUM_ABONADO%TYPE, EN_CAD_SERV IN ICC_MOVIMIENTO.COD_SERVICIOS%TYPE) RETURN VARCHAR2
IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "ICC_EVALUA_SERV_PREREQ_FN" Lenguaje="PL/SQL" Fecha="09-03-2007" Versión="1.0.0" Diseñador="José J. Figueroa " Programador="José J. Figueroa" Ambiente="DEIMOS_COL">
<Retorno>VARCHAR2</Retorno>
<Descripción>main del package, Retorna un string con los servicios de ICC que serán dados de baja en caso de que aplique</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_NUM_MOV" Tipo="ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE">Número de movimiento</param>
<param nom="EN_NUM_ABO" Tipo="ICC_MOVIMIENTO.NUM_ABONADO%TYPE">Número de movimiento</param>
<param nom="EN_CAD_SERV" Tipo="ICC_MOVIMIENTO.COD_SERVICIOS%TYPE">Número de movimiento</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LV_cadenaServ STRING(512);
LV_serv_a_bajar VARCHAR2(512);
LV_servicc_a_bajar VARCHAR2(512);
LV_ResultadoCambioNivel VARCHAR2(512);
LV_cadenaServCambioNivel STRING(512);

ERR_UPDATE_MOV EXCEPTION;

BEGIN

 LV_servicc_a_bajar:='';

	LV_cadenaServ := EN_CAD_SERV;

	IF (LV_cadenaServ is NOT NULL) THEN

	   LV_cadenaServ := IC_RETORNA_BAJAS_COMER_FN(LV_cadenaServ,EN_NUM_ABO);

	   IF (LV_cadenaServ is NOT NULL) THEN

  		   LV_serv_a_bajar := IC_RETORNA_SERVDEF_FN(EN_NUM_ABO, LV_cadenaServ);
		     IF (LV_serv_a_bajar is NULL) THEN
   	  		  LV_servicc_a_bajar:='';
  		   ELSE
		     	  LV_servicc_a_bajar := IC_RETORNA_SERVICC_FN(LV_serv_a_bajar);
			       IF IC_PAREASERVICIOS_FN(EN_CAD_SERV, LV_servicc_a_bajar) THEN
   				      IF NOT IC_UPDATE_SERV_MOVIMIENTO_FN(EN_NUM_MOV,LV_servicc_a_bajar) THEN
			   	  	      RAISE ERR_UPDATE_MOV;
				         END IF;
			       ELSE
			          LV_servicc_a_bajar:='';
     			  END IF;
	  	   END IF;
    ELSE
				  --Evaluar caso cambios de nivel
				         LV_cadenaServCambioNivel := EN_CAD_SERV;
						 LV_ResultadoCambioNivel:= IC_EVALUA_CAMBIO_NIVEL_FN(EN_NUM_ABO, LV_cadenaServCambioNivel);
							IF LENGTH (LV_ResultadoCambioNivel) > 0 AND LV_ResultadoCambioNivel != 'FALSE' THEN
							   IF IC_PAREASERVICIOS_FN(EN_CAD_SERV, LV_ResultadoCambioNivel) THEN
             IF NOT IC_UPDATE_SERV_MOVIMIENTO_FN(EN_NUM_MOV,LV_ResultadoCambioNivel) THEN
			      	      RAISE ERR_UPDATE_MOV;
				         END IF;
										END IF;
							ELSE
							   RAISE ERR_UPDATE_MOV;
							END IF;
	   END IF;

	END IF;


    RETURN LV_servicc_a_bajar;

EXCEPTION
     WHEN ERR_UPDATE_MOV   THEN
          RETURN '';
     WHEN NO_DATA_FOUND   THEN
          RETURN '';
     WHEN OTHERS THEN
	 	  RETURN '';
END ICC_EVALUA_SERV_PREREQ_FN;




END ICC_EVALUA_SERV_PREREQ_PG;
/
SHOW ERRORS
