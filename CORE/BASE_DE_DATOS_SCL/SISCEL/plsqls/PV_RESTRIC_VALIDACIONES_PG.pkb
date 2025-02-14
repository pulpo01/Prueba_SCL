CREATE OR REPLACE PACKAGE BODY PV_RESTRIC_VALIDACIONES_PG IS
---------------------------------------------------------------------------------------------------------
	PROCEDURE PV_VALIDA_SERV_ACTDEC_PR (EO_VALIDA_SERV_ACTDEC   IN				PV_VALIDA_SERV_ACTDEC_QT,
									    SV_record               OUT NOCOPY				refcursor,
									    SN_cod_retorno          OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
									    SV_mens_retorno         OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
									    SN_num_evento           OUT NOCOPY		ge_errores_pg.evento)
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_VALIDA_SER_ACTDEC_PR"
	      Lenguaje="PL/SQL"
	      Fecha="11-07-2007"
	      Versión="La del package"
	      Diseñador=""
	      Programador="Carlos Elizondo"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_VALIDA_SERV_ACTDEC" Tipo="estructura">estructura de los datos de servicos a activar y desactivar</param>>
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
	IS
		LV_des_error	   			ge_errores_pg.DesEvent;
		LV_sSql			   			ge_errores_pg.vQuery;
		--SV_record                  refcursor;-- TC_cursordatos;

		ERROR_EJECUCION       		EXCEPTION;
		EN_NUM_MOVIMIENTO     		NUMBER  (9);
		EN_NUM_MOVIMIENTO_AUX_INI	NUMBER  (9);
		EN_NUM_MOVIMIENTO_AUX_FIN	NUMBER  (9);
		EV_FLAG						NUMBER  (1);
		EV_COD_ACTABO         		VARCHAR2(2);
		EN_COD_PRODUCTO       		NUMBER  (1);
		EV_COD_TECNOLOGIA     		VARCHAR2(7);
		EN_TIP_PANTALLA       		NUMBER  (2);
		EN_COD_CONCEPTO       		NUMBER  (4);
		EV_COD_MODULO         		VARCHAR2(2);
		EV_COD_PLANTARIF_NUE  		VARCHAR2(3);
		EV_COD_PLANTARIF_ANT  		VARCHAR2(3);
		EN_TIP_ABONADO        		NUMBER  (1);
		EV_COD_OS             		VARCHAR2(5);
		EN_COD_CLIENTE        		NUMBER  (8);
		EN_NUM_ABONADO        		NUMBER  (8);
		EN_IND_FACTUR         		NUMBER  (1);
		EV_COD_PLANSERV       		VARCHAR2(3);
		EV_COD_OPERACION      		VARCHAR2(2);
		EV_COD_TIPCONTRATO    		VARCHAR2(3);
		EN_TIP_CELULAR        		VARCHAR2(1);
		EN_NUM_MESES          		NUMBER  (2);
		EV_COD_ANTIGUEDAD     		VARCHAR2(3);
		EN_COD_CICLO          		NUMBER  (2);
		EN_NUM_CELULAR        		NUMBER  (15);
		EN_TIP_SERVICIO       		NUMBER  (1);
		EN_COD_PLANCOM        		NUMBER  (6);
		EV_PARAM1_MENS        		VARCHAR2(255);
		EV_PARAM2_MENS        		VARCHAR2(255);
		EV_PARAM3_MENS        		VARCHAR2(255);
		EN_COD_ARTI       	  		NUMBER  (6);
		EV_COD_CAUSA          		VARCHAR2(5);
		EV_COD_CAUSA_NUE      		VARCHAR2(5);
		EN_COD_VENDE          		NUMBER  (6);
		EV_COD_CATEG      	  		VARCHAR2(3);
		EN_COD_MODVTA         		NUMBER  (2);
		EV_COD_CAUSINIE       		VARCHAR2(2);
		LN_INDICE			BINARY_INTEGER := 0;
	    LN_INDICE2			BINARY_INTEGER := 0;
	    LV_QUERY            VARCHAR2(500);
		LN_CantRegistros    NUMBER(6);
	    LN_SECUENCIA        PV_TMPPARAMETROS_SALIDA_TT.NUM_MOVIMIENTO%TYPE;



		EV_DES_SERV            VARCHAR2(255);
        EN_NUM_UNIDADES        NUMBER(6);
        EN_IMP_CARGO           NUMBER(14,4);
        EV_COD_ARTICULO        NUMBER(6);
        EV_NUM_SERIE           VARCHAR2(25);
        EN_IND_EQUIPO          VARCHAR2(1);
        EV_TIP_DTO             VARCHAR2(1);
        EN_VAL_DTO             NUMBER(14,4);
        EV_COD_PLANCOM         NUMBER(6);
        EV_CLASE_SERVICIO_ACT  VARCHAR2(255);
        EV_CLASE_SERVICIO_DES  VARCHAR2(255);
        EV_CLASE_SERVICIO      VARCHAR2(255);
        EV_DES_MONEDA          VARCHAR2(255);
        EV_COD_MONEDA          VARCHAR2(3);
        EN_FACT_CONT           NUMBER(1);
        EN_P_DESC              NUMBER(1);
        EN_COD_ERROR           NUMBER(1);
        EV_DES_ERROR           VARCHAR2(255);
		EV_COD_BODEGA	       NUMBER(6);
		EN_COD_CONCEPTO_DTO	   NUMBER(4);
		EV_P_DESC              NUMBER(1);
		EN_VAL_MIN             NUMBER(14,4);
		EN_VAL_MAX             NUMBER(14,4);

	BEGIN
		sn_cod_retorno 	:= 0;
	    sv_mens_retorno := '';
	    sn_num_evento 	:= 0;

		EN_NUM_MOVIMIENTO:=EO_VALIDA_SERV_ACTDEC.NUM_MOVIMIENTO;
		EV_COD_ACTABO			:=EO_VALIDA_SERV_ACTDEC.COD_ACTABO;
		EN_COD_PRODUCTO			:=EO_VALIDA_SERV_ACTDEC.COD_PRODUCTO;
		EV_COD_TECNOLOGIA		:=EO_VALIDA_SERV_ACTDEC.COD_TECNOLOGIA;
		EN_TIP_PANTALLA			:=EO_VALIDA_SERV_ACTDEC.TIP_PANTALLA;
		EN_COD_CONCEPTO			:=EO_VALIDA_SERV_ACTDEC.COD_CONCEPTO;
		EV_COD_MODULO			:=EO_VALIDA_SERV_ACTDEC.COD_MODULO;
		EV_COD_PLANTARIF_NUE	:=EO_VALIDA_SERV_ACTDEC.COD_PLANTARIF_NUE;
		EV_COD_PLANTARIF_ANT	:=EO_VALIDA_SERV_ACTDEC.COD_PLANTARIF_ANT;
		EN_TIP_ABONADO			:=EO_VALIDA_SERV_ACTDEC.TIP_ABONADO;
		EV_COD_OS				:=EO_VALIDA_SERV_ACTDEC.COD_OS;
		EN_COD_CLIENTE			:=EO_VALIDA_SERV_ACTDEC.COD_CLIENTE;
		EN_NUM_ABONADO			:=EO_VALIDA_SERV_ACTDEC.NUM_ABONADO;
		EN_IND_FACTUR			:=EO_VALIDA_SERV_ACTDEC.IND_FACTUR;
		EV_COD_PLANSERV			:=EO_VALIDA_SERV_ACTDEC.COD_PLANSERV;
		EV_COD_OPERACION		:=EO_VALIDA_SERV_ACTDEC.COD_OPERACION;
		EV_COD_TIPCONTRATO		:=EO_VALIDA_SERV_ACTDEC.COD_TIPCONTRATO;
		EN_TIP_CELULAR			:=EO_VALIDA_SERV_ACTDEC.TIP_CELULAR;
		EN_NUM_MESES			:=EO_VALIDA_SERV_ACTDEC.NUM_MESES;
		EV_COD_ANTIGUEDAD		:=EO_VALIDA_SERV_ACTDEC.COD_ANTIGUEDAD;
		EN_COD_CICLO			:=EO_VALIDA_SERV_ACTDEC.COD_CICLO;
		EN_NUM_CELULAR			:=EO_VALIDA_SERV_ACTDEC.NUM_CELULAR;
		EN_TIP_SERVICIO			:=EO_VALIDA_SERV_ACTDEC.TIP_SERVICIO;
		EN_COD_PLANCOM			:=EO_VALIDA_SERV_ACTDEC.COD_PLANCOM;
		EV_PARAM1_MENS			:=EO_VALIDA_SERV_ACTDEC.PARAM1_MENS;
		EV_PARAM2_MENS			:=EO_VALIDA_SERV_ACTDEC.PARAM2_MENS;
		EV_PARAM3_MENS			:=EO_VALIDA_SERV_ACTDEC.PARAM3_MENS;
		EN_COD_ARTI				:=EO_VALIDA_SERV_ACTDEC.COD_ARTICULO;
		EV_COD_CAUSA			:=EO_VALIDA_SERV_ACTDEC.COD_CAUSA;
		EV_COD_CAUSA_NUE		:=EO_VALIDA_SERV_ACTDEC.COD_CAUSA_NUE;
		EN_COD_VENDE			:=EO_VALIDA_SERV_ACTDEC.COD_VEND;
		EV_COD_CATEG			:=EO_VALIDA_SERV_ACTDEC.COD_CATEGORIA;
		EN_COD_MODVTA			:=EO_VALIDA_SERV_ACTDEC.COD_MODVENTA;
		EV_COD_CAUSINIE			:=EO_VALIDA_SERV_ACTDEC.COD_CAUSINIE;

		LV_sSql:='';
		LV_sSql:=LV_sSql||'PV_EJECUTA_TRANS_OS_PG.PV_FACHADA_PARAMETRO ('||EN_NUM_MOVIMIENTO||','||EV_COD_ACTABO||','||EN_COD_PRODUCTO||',';
		LV_sSql:=LV_sSql||''||EV_COD_TECNOLOGIA||','||EN_TIP_PANTALLA||','||EN_COD_CONCEPTO||','||EV_COD_MODULO||','||EV_COD_PLANTARIF_NUE||',';
		LV_sSql:=LV_sSql||''||EV_COD_PLANTARIF_ANT||','||EN_TIP_ABONADO||','||EV_COD_OS||','||EN_COD_CLIENTE||','||EN_NUM_ABONADO||','||EN_IND_FACTUR||',';
		LV_sSql:=LV_sSql||''||EV_COD_PLANSERV||','||EV_COD_OPERACION||','||EV_COD_TIPCONTRATO||','||EN_TIP_CELULAR||','||EN_NUM_MESES||','||EV_COD_ANTIGUEDAD||',';
		LV_sSql:=LV_sSql||''||EN_COD_CICLO||','||EN_NUM_CELULAR||','||EN_TIP_SERVICIO||','||EN_COD_PLANCOM||','||EV_PARAM1_MENS||','||EV_PARAM2_MENS||',';
		LV_sSql:=LV_sSql||''||EV_PARAM3_MENS||','||EN_COD_ARTI||','||EV_COD_CAUSA||','||EV_COD_CAUSA_NUE||','||EN_COD_VENDE||','||EV_COD_CATEG||',';
		LV_sSql:=LV_sSql||''||EN_COD_MODVTA||','||EV_COD_CAUSINIE||',SV_record)';

dbms_output.put_line('ENTRADA PV_FACHADA_PARAMETRO');
		PV_EJECUTA_TRANS_OS_PG.PV_FACHADA_PARAMETRO (EN_NUM_MOVIMIENTO,
													EV_COD_ACTABO,
													EN_COD_PRODUCTO,
													EV_COD_TECNOLOGIA,
													EN_TIP_PANTALLA,
													EN_COD_CONCEPTO,
													EV_COD_MODULO,
													EV_COD_PLANTARIF_NUE,
													EV_COD_PLANTARIF_ANT,
												    EN_TIP_ABONADO,
												   EV_COD_OS,
												   EN_COD_CLIENTE,
												   EN_NUM_ABONADO,
												   EN_IND_FACTUR,
												   EV_COD_PLANSERV,
												   EV_COD_OPERACION,
												   EV_COD_TIPCONTRATO,
												   EN_TIP_CELULAR,
												   EN_NUM_MESES,
												   EV_COD_ANTIGUEDAD,
												   EN_COD_CICLO,
												   EN_NUM_CELULAR,
												   EN_TIP_SERVICIO,
												   EN_COD_PLANCOM,
												   EV_PARAM1_MENS,
												   EV_PARAM2_MENS,
												   EV_PARAM3_MENS,
												   EN_COD_ARTI,
												   EV_COD_CAUSA,
												   EV_COD_CAUSA_NUE,
												   EN_COD_VENDE,
												   EV_COD_CATEG,
												   EN_COD_MODVTA,
												   EV_COD_CAUSINIE,
						                           SV_record);


		LN_INDICE:=0;
		LN_CantRegistros:=0;
		EV_FLAG:= 0;
		LN_INDICE2:=0;

		dbms_output.put_line('salida PV_FACHADA_PARAMETRO');

		LOOP    FETCH  SV_record INTO EN_NUM_MOVIMIENTO
				,EV_COD_ACTABO
				,EN_IND_FACTUR
				,EV_DES_SERV
				,EN_NUM_UNIDADES
				,EN_COD_CONCEPTO
				,EN_IMP_CARGO
				,EV_COD_ARTICULO
				,EV_COD_BODEGA
				,EV_NUM_SERIE
				,EN_IND_EQUIPO
				,EN_COD_CLIENTE
				,EN_NUM_ABONADO
				,EV_TIP_DTO
				,EN_VAL_DTO
				,EN_COD_CONCEPTO_DTO
				,EN_NUM_CELULAR
				,EV_COD_PLANCOM
				,EV_CLASE_SERVICIO_ACT
				,EV_CLASE_SERVICIO_DES
				,EV_PARAM1_MENS
				,EV_PARAM2_MENS
				,EV_PARAM3_MENS
				,EV_CLASE_SERVICIO
				,EV_DES_MONEDA
				,EV_COD_MONEDA
				,EN_COD_CICLO
				,EN_FACT_CONT
				,EV_P_DESC
				,EN_VAL_MIN
				,EN_VAL_MAX
				,EN_COD_ERROR
				,EV_DES_ERROR;

				LN_INDICE:= LN_INDICE+ 1;

		EXIT WHEN  SV_record%NOTFOUND;

		END LOOP;

		LN_INDICE2:=0;
		LOOP    FETCH  SV_record INTO EN_NUM_MOVIMIENTO
				,EV_COD_ACTABO
				,EN_IND_FACTUR
				,EV_DES_SERV
				,EN_NUM_UNIDADES
				,EN_COD_CONCEPTO
				,EN_IMP_CARGO
				,EV_COD_ARTICULO
				,EV_COD_BODEGA
				,EV_NUM_SERIE
				,EN_IND_EQUIPO
				,EN_COD_CLIENTE
				,EN_NUM_ABONADO
				,EV_TIP_DTO
				,EN_VAL_DTO
				,EN_COD_CONCEPTO_DTO
				,EN_NUM_CELULAR
				,EV_COD_PLANCOM
				,EV_CLASE_SERVICIO_ACT
				,EV_CLASE_SERVICIO_DES
				,EV_PARAM1_MENS
				,EV_PARAM2_MENS
				,EV_PARAM3_MENS
				,EV_CLASE_SERVICIO
				,EV_DES_MONEDA
				,EV_COD_MONEDA
				,EN_COD_CICLO
				,EN_FACT_CONT
				,EV_P_DESC
				,EN_VAL_MIN
				,EN_VAL_MAX
				,EN_COD_ERROR
				,EV_DES_ERROR;
				 dbms_output.put_line(' cursor2  EN_NUM_MOVIMIENTO:'|| EN_NUM_MOVIMIENTO);

				WHILE 	(LN_INDICE2 <= LN_INDICE -1 ) LOOP

					SELECT PV_SEQ_NUMOS.NEXTVAL INTO LN_SECUENCIA FROM DUAL ;

					INSERT INTO PV_TMPPARAM_SALIDA_TT
							(NUM_MOVIMIENTO
							,COD_ACTABO
							,IND_FACTUR
							,DES_SERV
							,NUM_UNIDADES
							,COD_CONCEPTO
							,IMP_CARGO
							,COD_ARTICULO
							,COD_BODEGA
							,NUM_SERIE
							,IND_EQUIPO
							,COD_CLIENTE
							,NUM_ABONADO
							,TIP_DTO
							,VAL_DTO
							,COD_CONCEPTO_DTO
							,NUM_CELULAR
							,COD_PLANCOM
							,CLASE_SERVICIO_ACT
							,CLASE_SERVICIO_DES
							,PARAM1_MENS
							,PARAM2_MENS
							,PARMA3_MENS
							,CLASE_SERVICIO
							,DES_MONEDA
							,COD_MONEDA
							,COD_CICLO
							,FACT_CONT
							,P_DESC
							,VAL_MIN
							,VAL_MAX
							,COD_ERROR
							,DES_ERROR)
					VALUES
							(
							 LN_SECUENCIA
							,EV_COD_ACTABO
							,EN_IND_FACTUR
							,EV_DES_SERV
							,EN_NUM_UNIDADES
							,EN_COD_CONCEPTO
							,EN_IMP_CARGO
							,EV_COD_ARTICULO
							,EV_COD_BODEGA
							,EV_NUM_SERIE
							,EN_IND_EQUIPO
							,EN_COD_CLIENTE
							,EN_NUM_ABONADO
							,EV_TIP_DTO
							,EN_VAL_DTO
							,EN_COD_CONCEPTO_DTO
							,EN_NUM_CELULAR
							,EV_COD_PLANCOM
							,EV_CLASE_SERVICIO_ACT
							,EV_CLASE_SERVICIO_DES
							,EV_PARAM1_MENS
							,EV_PARAM2_MENS
							,EV_PARAM3_MENS
							,EV_CLASE_SERVICIO
							,EV_DES_MONEDA
							,EV_COD_MONEDA
							,EN_COD_CICLO
							,EN_FACT_CONT
							,EV_P_DESC
							,EN_VAL_MIN
							,EN_VAL_MAX
							,EN_COD_ERROR
							,EV_DES_ERROR );

					LN_INDICE2:= LN_INDICE2 +1;

					IF (EV_FLAG= 0) THEN
							EN_NUM_MOVIMIENTO_AUX_INI:= LN_SECUENCIA;
							EV_FLAG:= 1;
					ELSE
							EN_NUM_MOVIMIENTO_AUX_FIN:= LN_SECUENCIA;
					END IF;

				END LOOP;

				EXIT WHEN  SV_record%NOTFOUND;

		END LOOP;
   		EN_NUM_MOVIMIENTO_AUX_FIN:= EN_NUM_MOVIMIENTO_AUX_FIN - 1;
		OPEN  SV_record  FOR
			SELECT   NUM_MOVIMIENTO,COD_ACTABO,IND_FACTUR,DES_SERV,NVL(NUM_UNIDADES,0),COD_CONCEPTO  ,nvl(IMP_CARGO,0)
					 ,NVL(COD_ARTICULO,0),NVL(COD_BODEGA,0),NUM_SERIE,IND_EQUIPO,NVL(COD_CLIENTE,0),NVL(NUM_ABONADO,0)
					 ,TIP_DTO,nvl(VAL_DTO,0),NVL(COD_CONCEPTO_DTO,0),NVL(NUM_CELULAR,0),NVL(COD_PLANCOM,0),CLASE_SERVICIO_ACT
					 ,CLASE_SERVICIO_DES,PARAM1_MENS,PARAM2_MENS,PARMA3_MENS,CLASE_SERVICIO,DES_MONEDA,NVL(COD_MONEDA,0)
					 ,NVL(COD_CICLO,0),NVL(FACT_CONT,1),NVL(P_DESC,0),NVL(VAL_MIN,0),NVL(VAL_MAX,0),COD_ERROR,DES_ERROR
					 FROM PV_TMPPARAM_SALIDA_TT WHERE (NUM_MOVIMIENTO >= EN_NUM_MOVIMIENTO_AUX_INI AND
			 	     NUM_MOVIMIENTO <= EN_NUM_MOVIMIENTO_AUX_FIN)
					 order by num_abonado ,cod_concepto;



             DELETE FROM PV_TMPPARAM_SALIDA_TT
			 WHERE (NUM_MOVIMIENTO >= EN_NUM_MOVIMIENTO_AUX_INI AND
			 	     NUM_MOVIMIENTO <= EN_NUM_MOVIMIENTO_AUX_FIN)	;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 149;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_VALIDA_SERV_ACTDEC_PR ('||EN_NUM_MOVIMIENTO||') '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_RESTRIC_VALIDACIONES_PG.PV_VALIDA_SERV_ACTDEC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PV_VALIDA_SERV_ACTDEC_PR('||EN_NUM_MOVIMIENTO||') '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_RESTRIC_VALIDACIONES_PG.PV_VALIDA_SERV_ACTDEC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	END PV_VALIDA_SERV_ACTDEC_PR;


---------------------------------------------------------------------------------------------------------
END PV_RESTRIC_VALIDACIONES_PG;
/
SHOW ERRORS
