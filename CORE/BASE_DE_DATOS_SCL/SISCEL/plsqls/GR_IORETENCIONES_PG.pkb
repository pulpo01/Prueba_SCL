CREATE OR REPLACE PACKAGE BODY GR_IORETENCIONES_PG
AS

FUNCTION GR_GRABAERROR_FN (NOM_PL       IN  VARCHAR2,
                            NOM_TABLA    IN  VARCHAR2,
                            NumError     IN  NUMBER,
					        Descripcion  IN  VARCHAR2,
					        EVENTO       OUT NUMBER )  RETURN BOOLEAN IS

 sNumProceso   VARCHAR2(25);
 sTerminal     VARCHAR2(25);

 BEGIN

    SELECT NVL(process,'NO PROCESS'), NVL(terminal,'NO TERMINAL')
    INTO   sNumProceso, sTerminal
    FROM   V$SESSION
    WHERE  username = user AND status = 'ACTIVE';

	EVENTO := GE_ERRORES_PG.GRABAR(0, 'RET', 'Ejecucion de Package ret_retenciones_pg', '1',
	          user, sNumProceso, sTerminal, NOM_PL, NOM_TABLA, NumError, Descripcion);
    RETURN TRUE;

 EXCEPTION

    WHEN NO_DATA_FOUND THEN
 	   RETURN FALSE;
 	WHEN OTHERS THEN
 	   RETURN FALSE;

 END GR_GRABAERROR_FN;

 PROCEDURE GR_DETOFERTAFICHA_PR(p_nnum_ficha  IN  RET_FICHAS_TH.NUM_FICHA%TYPE)
IS
-- Procedimiento que es llamado desde el Trigger GR_FICH_AFUP_TG
-- y que ingresa los registros de los Detalle de Oferta de la Ficha
v_nnum_ficha            RET_FICHAS_TH.NUM_FICHA%TYPE;
v_nnum_abonado          RET_FICHAS_TH.NUM_ABONADO%TYPE;
v_ncod_cliente          RET_FICHAS_TH.COD_CLIENTE%TYPE;
v_dfec_ultimo_contacto  RET_FICHAS_TH.FEC_ULTIMO_CONTACTO%TYPE;
v_ncod_tipo_oferta      RET_CONTACTOS_TH.COD_TIPO_OFERTA%TYPE;
---
v_ncod_valor            GED_CODIGOS.COD_VALOR%TYPE;
v_vdes_valor            GED_CODIGOS.DES_VALOR%TYPE;
---
p_ncod_valor            GED_CODIGOS.COD_VALOR%TYPE;
p_vdes_valor            GED_CODIGOS.DES_VALOR%TYPE;
---
v_vcod_plantarif        GA_FINCICLO.COD_PLANTARIF%TYPE;
v_dfec_desdellam        GA_FINCICLO.FEC_DESDELLAM%TYPE;
v_dfec_cumplan          GA_ABOAMIST.FEC_CUMPLAN%TYPE;
--
v_vcod_moneda           TA_CARGOSBASICO.COD_MONEDA%TYPE;
v_nimp_cargobasico      TA_CARGOSBASICO.IMP_CARGOBASICO%TYPE;
--
v_vdes_articulo         AL_ARTICULOS.DES_ARTICULO%TYPE;
v_vcod_tecnologia       GA_ABOCEL.COD_TECNOLOGIA%TYPE;
--
v_vcod_moneda_s         GE_CARGOS.COD_MONEDA%TYPE;
v_nimp_cargo_s          GE_CARGOS.IMP_CARGO%TYPE;
--
v_nnum_abonado_c        GA_ABOCEL.NUM_ABONADO%TYPE;
v_dfec_bajacen_c        GA_ABOCEL.FEC_BAJACEN%TYPE;
v_dfec_alta_c           GE_CARGOS.FEC_ALTA%TYPE;
v_vcod_moneda_c         GE_CARGOS.COD_MONEDA%TYPE;
v_nimp_cargo_c          GE_CARGOS.IMP_CARGO%TYPE;
--
v_dfec_baja             GA_ABOCEL.fec_baja%TYPE;
v_vfrm_fecha            VARCHAR2(40);
v_nerror                NUMBER;
v_verror                VARCHAR2(255);

CURSOR Cur_CompOferta
    IS
    SELECT
          cod_valor,
          des_valor
    FROM  ged_codigos
    WHERE cod_modulo  ='GR'
      AND nom_tabla   ='RET_FICHAS_OFERTA_TH'
      AND nom_columna ='COD_COMP_OFERTA'
      ORDER BY cod_valor;
BEGIN
    v_vfrm_fecha := TRIM(ge_fn_devvalparam('GE',1,'FORMATO_SEL2'));
    v_vfrm_fecha := TRIM(v_vfrm_fecha) || ' ' || TRIM(ge_fn_devvalparam('GE',1,'FORMATO_SEL7'));

    -----------------
	 v_nnum_ficha := p_nnum_ficha;
	-- RECUPERA DATOS DE LA FICHA
	 GR_DATOSFICHA_PR(p_nnum_ficha,v_nnum_abonado,v_ncod_cliente,v_dfec_ultimo_contacto,v_ncod_tipo_oferta);
	 --dbms_output.put_line('DATOS FICHA :'|| v_nnum_abonado||','||v_ncod_cliente||','||v_dfec_ultimo_contacto||','||v_ncod_tipo_oferta);

	-- RECUPERA DATOS DE LA GED_CODIGO
	 GR_RECUPERAGEDCODIGO_PR(v_ncod_tipo_oferta,v_ncod_valor,v_vdes_valor);
	 --dbms_output.put_line('GED CODIGO :'|| v_ncod_valor||','||v_vdes_valor);
     ----------------------

     IF v_ncod_valor =1 THEN -- 1. ACEPTA OFERTA - CAMBIO DE PLAN
          PV_CONSULTAPOSVENTA_PG.PV_AFCAMBIOPLAN_PR(v_nnum_abonado,v_dfec_desdellam,v_vcod_plantarif,v_dfec_cumplan,v_nimp_cargobasico,v_ncod_cliente);
--     	  dbms_output.put_line('PV_AFCAMBIOPLAN_PR :'|| v_dfec_desdellam||','||v_vcod_plantarif||','||v_dfec_cumplan||','||v_nimp_cargobasico);
     ELSIF v_ncod_valor =2 THEN -- 2. ACEPTA OFERTA - CAMBIO DE SERIE
    	  PV_CONSULTAPOSVENTA_PG.PV_AFCAMBIOSERIE_PR(v_nnum_abonado,v_vdes_articulo,v_vcod_tecnologia,v_nimp_cargo_s);

     ELSIF v_ncod_valor =6 OR v_ncod_valor = 8 THEN -- 6. NO ACEPTA - BAJA O 8. MIGRACION PREPAGO
	 	  PV_CONSULTAPOSVENTA_PG.PV_NAMIGARCIONPREPAGO_PR(v_nnum_abonado,v_dfec_baja,v_nnum_abonado_c,v_dfec_bajacen_c,v_dfec_alta_c,v_nimp_cargo_c);

     END IF;

     OPEN Cur_CompOferta;
     LOOP
     FETCH Cur_CompOferta INTO
           p_ncod_valor,
           p_vdes_valor;
     EXIT WHEN Cur_CompOferta%NOTFOUND;
     BEGIN
         IF v_ncod_valor =1 THEN -- 1. ACEPTA OFERTA - CAMBIO DE PLAN
             IF p_ncod_valor =4 THEN --NUEVO PLAN (C PLAN)
                IF LTRIM(RTRIM(v_vcod_plantarif)) IS NOT NULL THEN
                    --INSERT INTO RET_FICHAS_OFERTA_TH (NUM_FICHA,COD_COMP_OFERTA, DET_COMP_OFERTA)
                    GR_GRABAFICHA_PR(v_nnum_ficha,p_ncod_valor,v_vcod_plantarif);
                END IF;
             ELSIF p_ncod_valor =5 THEN --FECHA INICIO (C PLAN)
                IF v_dfec_desdellam IS NOT NULL THEN
                   GR_GRABAFICHA_PR(v_nnum_ficha,p_ncod_valor,TO_CHAR(v_dfec_desdellam,v_vfrm_fecha));
                END IF;
             ELSIF p_ncod_valor =6 THEN --FECHA TERMINO(C PLAN)
                IF v_dfec_cumplan IS NOT NULL THEN
                    GR_GRABAFICHA_PR(v_nnum_ficha,p_ncod_valor,TO_CHAR(v_dfec_cumplan,v_vfrm_fecha));
                END IF;
             ELSIF p_ncod_valor =7 THEN --CARGO FIJO(C PLAN)
                IF v_nimp_cargobasico IS NOT NULL THEN
                    GR_GRABAFICHA_PR(v_nnum_ficha,p_ncod_valor,v_nimp_cargobasico);
                END IF;
             END IF;
         ELSIF v_ncod_valor =2 THEN -- 2. ACEPTA OFERTA - CAMBIO DE SERIE
             IF p_ncod_valor =1 THEN --TECNOLOGIA (C SERIE)
                IF LTRIM(RTRIM(v_vcod_tecnologia)) IS NOT NULL THEN
                   GR_GRABAFICHA_PR(v_nnum_ficha,p_ncod_valor,v_vcod_tecnologia);
                END IF;
             ELSIF p_ncod_valor =2 THEN --MODELO (C SERIE)
                IF LTRIM(RTRIM(v_vdes_articulo)) IS NOT NULL THEN
                    GR_GRABAFICHA_PR(v_nnum_ficha,p_ncod_valor,v_vdes_articulo);
                END IF;
             ELSIF p_ncod_valor =3 THEN --CARGO NUEVO EQUIPO(C SERIE)
                IF v_nimp_cargo_s IS NOT NULL THEN
                    GR_GRABAFICHA_PR(v_nnum_ficha,p_ncod_valor,v_nimp_cargo_s);
                END IF;
             END IF;
         ELSIF v_ncod_valor =6 THEN -- 6. NO ACEPTA - BAJA
             IF p_ncod_valor =9 THEN --FECHA BAJA (BAJA)
                IF v_dfec_baja IS NOT NULL THEN
                    GR_GRABAFICHA_PR(v_nnum_ficha,p_ncod_valor,TO_CHAR(v_dfec_baja,v_vfrm_fecha));
                END IF;
             ELSIF p_ncod_valor =10 THEN --INDEMNIZACION (BAJA)
                IF v_nimp_cargo_c IS NOT NULL THEN
                    GR_GRABAFICHA_PR(v_nnum_ficha,p_ncod_valor,v_nimp_cargo_c);
                END IF;
             END IF;
         ELSIF v_ncod_valor =8 THEN -- 8. MIGRACION PREPAGO
             IF p_ncod_valor =8 THEN --INDEMNIZACION (MIGRACION)
                IF v_nimp_cargo_c IS NOT NULL THEN
                    GR_GRABAFICHA_PR(v_nnum_ficha,p_ncod_valor,v_nimp_cargo_c);
                END IF;
             END IF;
         END IF;
     END;
     END LOOP;
     CLOSE Cur_CompOferta;
EXCEPTION
           	WHEN OTHERS THEN
			BEGIN
           		 RAISE_APPLICATION_ERROR(-30500,'GR_DETOFERTAFICHA_PR('||TO_CHAR(p_nnum_ficha)||') - '||SQLERRM);
			END;
END GR_DETOFERTAFICHA_PR;


PROCEDURE GR_DATOSFICHA_PR(p_nnum_ficha IN RET_FICHAS_TH.NUM_FICHA%TYPE,
				          v_nnum_abonado OUT RET_FICHAS_TH.NUM_ABONADO%TYPE,
				          v_ncod_cliente OUT RET_FICHAS_TH.COD_CLIENTE%TYPE,
				          v_dfec_ultimo_contacto OUT RET_FICHAS_TH.FEC_ULTIMO_CONTACTO%TYPE,
				          v_ncod_tipo_oferta OUT RET_CONTACTOS_TH.COD_TIPO_OFERTA%TYPE)
IS
BEGIN
    SELECT
          f.num_abonado,
          f.cod_cliente,
          f.fec_ultimo_contacto,
          c.cod_tipo_oferta
    INTO
          v_nnum_abonado,
          v_ncod_cliente,
          v_dfec_ultimo_contacto,
          v_ncod_tipo_oferta
    FROM  ret_fichas_th f, ret_contactos_th c
    WHERE f.num_ficha    = p_nnum_ficha
      AND c.num_ficha    = f.num_ficha
      AND c.fec_contacto = f.fec_ultimo_contacto
	  AND ROWNUM=1;

EXCEPTION
           	WHEN OTHERS THEN
           		 RAISE_APPLICATION_ERROR(-30200,'GR_DETOFERTAFICHA_PR4('||TO_CHAR(p_nnum_ficha)||', '||v_nnum_abonado||', '||v_ncod_cliente||', '||v_dfec_ultimo_contacto||', '||v_ncod_tipo_oferta||') - '||SQLERRM);
END GR_DATOSFICHA_PR;

PROCEDURE GR_RECUPERAGEDCODIGO_PR(v_ncod_tipo_oferta IN RET_CONTACTOS_TH.COD_TIPO_OFERTA%TYPE,
		  						  v_ncod_valor OUT GED_CODIGOS.COD_VALOR%TYPE,
								  v_vdes_valor OUT GED_CODIGOS.DES_VALOR%TYPE)
IS
BEGIN
    SELECT
          cod_valor,
          des_valor
    INTO
          v_ncod_valor,
          v_vdes_valor
    FROM  ged_codigos
    WHERE cod_modulo ='GR'
     AND  nom_tabla  ='RET_TIPOFERTAS_ABON_TO'
     AND  nom_columna='COD_TIPO_OFERTA'
     AND  cod_valor  = v_ncod_tipo_oferta;

EXCEPTION
           	WHEN OTHERS THEN
           		 RAISE_APPLICATION_ERROR(-30201,'GR_DETOFERTAFICHA_PR5('||v_ncod_tipo_oferta||', '||v_ncod_valor||', '||v_vdes_valor||') - '||SQLERRM);
END GR_RECUPERAGEDCODIGO_PR;

PROCEDURE GR_GRABAFICHA_PR(v_num_ficha IN RET_FICHAS_OFERTA_TH.NUM_FICHA%TYPE,
		  				   v_cod_comp_oferta IN RET_FICHAS_OFERTA_TH.COD_COMP_OFERTA%TYPE,
						   v_det_comp_oferta IN RET_FICHAS_OFERTA_TH.DET_COMP_OFERTA%TYPE)IS
BEGIN
     INSERT INTO RET_FICHAS_OFERTA_TH (NUM_FICHA,COD_COMP_OFERTA, DET_COMP_OFERTA)
           VALUES(v_num_ficha,v_cod_comp_oferta, v_det_comp_oferta);
EXCEPTION
     WHEN OTHERS THEN
       		 RAISE_APPLICATION_ERROR(-30202,'GR_DETOFERTAFICHA_PR6('||v_num_ficha||', '||v_cod_comp_oferta||', '||v_det_comp_oferta||') - '||SQLERRM);

END GR_GRABAFICHA_PR;
PROCEDURE GR_OSSRET_PR(p_num_ficha   IN  RET_FICHAS_TH.NUM_FICHA%TYPE,
                       p_cod_estado_ooss IN  RET_FICHAS_TH.COD_ESTADO_OOSS%TYPE,
						nCod_Error 		   OUT NUMBER,	 --Codigo de error
						sMen_Error 		   OUT VARCHAR2, --Descripcion del Error
						nEvento 		   OUT NUMBER)	 --Numero de Evento del Error

    IS
    ----------------------------
    v_ncount_upd  NUMBER(2);
	nNumError 	  NUMBER(2);
	sMsgError 	  VARCHAR2(300);
	sNumProceso   VARCHAR(20);
	sTerminal 	  VARCHAR(50);
	sNOM_TABLA 	  VARCHAR2(100);
	IDTAREA       RET_FICHAS_TH.ID_TAREA%TYPE;
	NomEstadoContacto RET_RESULTADOS_FASES_TO.NOM_ESTADO_CONTACTO%TYPE;
    MSG_ERROR     VARCHAR2(100);
    ERROR_PROCESO     EXCEPTION;
	ERROR_PROCESO2    EXCEPTION;
    ----------------------------

    BEGIN
	    MSG_ERROR := '';
        sNOM_TABLA := 'RET_FICHAS_TH';
		nEvento:=0;
        ---------------------
        IF p_cod_estado_ooss != 3 THEN
           UPDATE RET_FICHAS_TH
           SET    COD_ESTADO_OOSS = p_cod_estado_ooss
           WHERE  NUM_FICHA       = p_num_ficha;
        ELSE
           UPDATE RET_FICHAS_TH
           SET    COD_ESTADO_OOSS = p_cod_estado_ooss,
                  COD_ESTADO_FICHA = 2 -- ESTE VALOR ES PARA INDICAR QUE LA FICHA ESTA CERRADA, A La FECHA DE CREACION DEL SERVICIO
	       WHERE  NUM_FICHA       = p_num_ficha;  -- ESTE VALOR SE ENCUENTRA EN LA TABLA GED_CODIGOS
		   BEGIN
              SELECT id_tarea
		      INTO IDTAREA
              FROM ret_fichas_th
              WHERE num_ficha = p_num_ficha;
		   EXCEPTION
		      WHEN NO_DATA_FOUND THEN
			     IDTAREA:=NULL;
			  WHEN OTHERS THEN
			  	 MSG_ERROR:= 'Problemas el recuperar Id_tarea en tabla ret_fichas_th';
		   END;
		   IF MSG_ERROR != '' THEN
		      RAISE ERROR_PROCESO2;
		   END IF;
           IF IDTAREA IS NOT NULL THEN
				SELECT C.NOM_ESTADO_CONTACTO
				INTO NomEstadoContacto
				FROM RET_RESULTADOS_FASES_TO C,RET_CONTACTOS_TH B
				WHERE B.NUM_FICHA =  p_num_ficha
				AND B.NUM_CONTACTO = (
									SELECT MAX(A.NUM_CONTACTO)
									FROM RET_CONTACTOS_TH A
									WHERE A.NUM_FICHA = p_num_ficha
				                   )
				AND C.COD_FASE = B.COD_FASE
				AND C.COD_RESULTADO = B.COD_RESULTADO;
                GC_CONTACTOS_PG.GC_ModificacionTareas_PR(5,'C','',1, IDTAREA,'',NomEstadoContacto,user);
           END IF;
        END IF;
        v_ncount_upd := SQL%ROWCOUNT;
		DBMS_OUTPUT.PUT_LINE('v_ncount_upd :'||v_ncount_upd);
        IF v_ncount_upd = 0 THEN
            RAISE ERROR_PROCESO;
        END IF;
        IF p_cod_estado_ooss = 3 THEN
            BEGIN
              GR_DETOFERTAFICHA_PR(p_num_ficha);
            END;
        END IF;
    EXCEPTION
	    WHEN ERROR_PROCESO2 THEN
			sMen_Error := 'GR_OSSRET_PR('||p_num_ficha||', '||p_cod_estado_ooss||') - '||SQLERRM;

			IF NOT GR_GRABAERROR_FN('PL: GR_OSSRET_PR','GR_OSSRET_PR', 3, sMen_Error, nEvento) THEN
		          RAISE_APPLICATION_ERROR(-30900,MSG_ERROR);
		    END IF;
			nCOD_ERROR:=nNumError;
			sMEN_ERROR:=sMsgError;

		WHEN ERROR_PROCESO THEN
			sMen_Error := 'GR_OSSRET_PR('||p_num_ficha||', '||p_cod_estado_ooss||') - '||SQLERRM;

			IF NOT GR_GRABAERROR_FN('PL: GR_OSSRET_PR','GR_OSSRET_PR', 3, sMen_Error, nEvento) THEN
		          RAISE_APPLICATION_ERROR(-30901,'No se actualizo ningun registro en ret_fichas_th');
		    END IF;
			nCOD_ERROR:=nNumError;
			sMEN_ERROR:=sMsgError;
        WHEN OTHERS THEN
	        BEGIN
			sMen_Error := 'GR_OSSRET_PR('||p_num_ficha||', '||p_cod_estado_ooss||') - '||SQLERRM;

			IF NOT GR_GRABAERROR_FN('PL: GR_OSSRET_PR','GR_OSSRET_PR', 3, sMen_Error, nEvento) THEN
		          RAISE_APPLICATION_ERROR(-30902,'No es Posible realizar la operacion Update a la tabla RET_FICHAS_TH');
		    END IF;
			nCOD_ERROR:=nNumError;
			sMEN_ERROR:=sMsgError;
	        END;

END GR_OSSRET_PR;
END GR_IORETENCIONES_PG;
/
SHOW ERRORS
