CREATE OR REPLACE PROCEDURE          "CO_P_RECARGA" (	vNumAbonado IN GA_ABOCEL.NUM_ABONADO%TYPE,
	   	  		  							vNomUsuario IN VARCHAR2,
											vResultado OUT NUMBER
)
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : CO_P_RECARGA
-- * Descripcion        : Entrega recarga para planes hibridos al
-- *					 momento de desbloquearlos de facturacion.
-- * Fecha de creacion  : 02-2003
-- * Responsable        : Manuel Garcia
-- *************************************************************
vCodPlanTarif	GA_ABOCEL.COD_PLANTARIF%TYPE;
vCodCentral		GA_ABOCEL.COD_CENTRAL%TYPE;
vNumCelular		GA_ABOCEL.NUM_CELULAR%TYPE;
vNumSerieHex	GA_ABOCEL.NUM_SERIEHEX%TYPE;
vTipTerminal	GA_ABOCEL.TIP_TERMINAL%TYPE;
vNumMin			GA_ABOCEL.NUM_MIN%TYPE;
vCodTecnologia	GA_ABOCEL.COD_TECNOLOGIA%TYPE;
vNumSerie		GA_ABOCEL.NUM_SERIE%TYPE;
vNumImei		GA_ABOCEL.NUM_IMEI%TYPE;
vCodCiclo		GA_ABOCEL.COD_CICLO%TYPE;
vCodCliente		GA_ABOCEL.COD_CLIENTE%TYPE;

vNumImsi		ICC_MOVIMIENTO.IMSI%TYPE;

vCodPromocion   GA_ABOAMI_PROM.COD_PROMOCION%TYPE;
vCodCategoria	VE_CATPLANTARIF.COD_CATEGORIA%TYPE;
vIva			FA_DATOSGENER.PCT_IVA%TYPE;
vCargaPromoc	GA_ABOAMI_PROM.CARGA_PERIODO%TYPE;
vCargoBasico	TA_PLANTARIF.COD_CARGOBASICO%TYPE;
vNumDiasExp		TA_PLANTARIF.NUM_DIAS_EXPIRA%TYPE;
vCodTiPlan		TA_PLANTARIF.COD_TIPLAN%TYPE;
vCodCiclFact	FA_CICLFACT.COD_CICLFACT%TYPE;
vFecRecarga		VARCHAR2(8);
vCodActCen		GA_ACTABO.COD_ACTCEN%TYPE;

vAbonadoActivo	NUMBER (1);
vOK				NUMBER (1) := 1;
vValParametro	VARCHAR2(10);
vNumMov			NUMBER;
vImpCargoBasico	NUMBER (16);
vFechaExpira	DATE;
vRespuesta		VARCHAR2 (1);
vExisteCarga    NUMBER (1);  /*TM-200411091079 17-11-2004 Soporte RyC PRM*/

BEGIN
	SELECT COD_CLIENTE,
		   COD_CICLO,
		   COD_PLANTARIF,
		   COD_CENTRAL,
		   NUM_CELULAR,
		   NUM_SERIEHEX,
		   TIP_TERMINAL,
		   NUM_MIN,
		   DECODE( COD_SITUACION, 'BAA', 0, 'BAP', 0, 'REA', 0, 'REP', 0, 1 ),
		   COD_TECNOLOGIA,
		   NUM_SERIE,
		   NUM_IMEI,
   		   DECODE( COD_TECNOLOGIA, 'GSM', fRecuperSIMCARD_FN( NUM_SERIE, 'IMSI'), NULL ) IMSI
	  INTO vCodCliente,
	  	   vCodCiclo,
	  	   vCodPlanTarif,
		   vCodCentral,
		   vNumCelular,
		   vNumSerieHex,
		   vTipTerminal,
		   vNumMin,
		   vAbonadoActivo,
		   vCodTecnologia,
		   vNumSerie,
		   vNumImei,
		   vNumImsi
	  FROM GA_ABOCEL
	 WHERE NUM_ABONADO = vNumAbonado;

    -- < Se comenta sentencia de Calculo / MA-200409300514 / RVelizR - SOP RyC >
	-- SELECT( PCT_IVA / 100 ) + 1
	-- INTO vIva
	-- FROM FA_DATOSGENER;

	IF vAbonadoActivo = 0
	THEN
		vOK := 0;
	ELSE
		SELECT COD_CARGOBASICO,
			   DECODE( NUM_DIAS_EXPIRA, NULL, 0, NUM_DIAS_EXPIRA ),
			   COD_TIPLAN
		  INTO vCargoBasico,
			   vNumDiasExp,
			   vCodTiPlan
		  FROM TA_PLANTARIF
		 WHERE COD_PLANTARIF = vCodPlanTarif
		   AND COD_PRODUCTO = 1;

		IF vCodTiPlan != 3	-- Si no es un Hibrido
		THEN
			vOK := 0;
		ELSE
			-- recuperamos el ciclo de facturacion vigente
			SELECT COD_CICLFACT
			  INTO vCodCiclFact
			  FROM FA_CICLFACT
			 WHERE COD_CICLO = vCodCiclo
			   AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;

			BEGIN
				-- comprobamos si existe para el cliente/abonado
				SELECT NVL( TO_CHAR( FEC_RECARGA, 'DDMMYYYY' ), 'SF' )
				  INTO vFecRecarga
				  FROM GA_INFACCEL
				 WHERE COD_CLIENTE = vCodCliente
				   AND NUM_ABONADO = vNumAbonado
				   AND COD_CICLFACT = vCodCiclFact
				   AND SYSDATE BETWEEN FEC_ALTA AND FEC_BAJA;  /* TM-200503291318 30-03-2005 Soporte RyC PRM. Se Agrega condicion de fecha  Homologacion de XC-200411020347*/

				EXCEPTION
					WHEN NO_DATA_FOUND THEN
						vFecRecarga := 'SF';
			END;

			IF vFecRecarga = 'SF'
			THEN
				-- < Se comenta calculo que incluye Iva / MA-200409300514 / RVelizR - SOP RyC >
				--SELECT ROUND( IMP_CARGOBASICO * vIva )
				  SELECT ROUND( IMP_CARGOBASICO)
				  INTO vImpCargoBasico
				  FROM TA_CARGOSBASICO
				  WHERE COD_CARGOBASICO = vCargoBasico;

				-- < Se calcula Iva segun abonado / MA-200409300514 / RVelizR - SOP RyC >
				  SELECT  PV_MTONBPORC_FN( null, null, vImpCargoBasico, 0,vNumAbonado)
			      INTO vImpCargoBasico
				  FROM DUAL;

				--   Ajusta las cargas segun la promocion
				vCargaPromoc := 0;

				-- Rescata el monto de promocion del abonado si el mismo esta sujeto a promocion
				SELECT NVL( SUM( A.CARGA_PERIODO ), 0), NVL( MAX( A.COD_PROMOCION ), -1 )
				INTO vCargaPromoc, vCodPromocion
				FROM GA_ABOAMI_PROM A, GA_PROMOC_AMISTAR B
				WHERE A.NUM_ABONADO = vNumAbonado
				AND A.COD_PROMOCION = B.COD_PROMOCION
				AND A.NUM_PERIODOS <= B.NUM_PERIODOS
				AND B.IND_NEGOCIO = 'C';

				vImpCargoBasico := vImpCargoBasico + vCargaPromoc;

				IF vCargaPromoc > 0
				THEN
					UPDATE GA_ABOAMI_PROM A
					   SET A.NUM_PERIODOS = A.NUM_PERIODOS + 1,
						   A.FEC_ULTMOD = SYSDATE,
						   CARGA_TOTAL =   CARGA_TOTAL + vCargaPromoc
					 WHERE A.NUM_ABONADO = vNumAbonado
					   AND A.NUM_PERIODOS <= (	SELECT B.NUM_PERIODOS
												  FROM GA_PROMOC_AMISTAR B
												 WHERE A.COD_PROMOCION = B.COD_PROMOCION
												   AND B.IND_NEGOCIO = 'C' );
				END IF;

				vFechaExpira := SYSDATE + vNumDiasExp;

				-- recuperamos la categoria
				SELECT COD_CATEGORIA
				  INTO vCodCategoria
				  FROM VE_CATPLANTARIF
				 WHERE COD_PLANTARIF = vCodPlanTarif
				   AND COD_PRODUCTO = 1
				   AND SYSDATE BETWEEN FEC_EFECTIVIDAD AND NVL( FEC_FINEFECTIVIDAD, SYSDATE );

                -- Se controla existencia de datos recargas /*TM-200411091079 17-11-2004 Soporte RyC PRM*/
                SELECT COUNT(1)
                INTO vExisteCarga
                FROM GAT_CARGA_CTASEG
                WHERE NUM_CELULAR = vNumCelular
                AND COD_CICLFACT = vCodCiclFact;

                IF vExisteCarga = 0   -- No existe carga, se inserta en la tabla de recargas  /*TM-200411091079 17-11-2004 Soporte RyC PRM*/
                THEN
					-- se inserta en la tabla de recargas
					INSERT INTO GAT_CARGA_CTASEG (
					NUM_CELULAR,
					COD_CICLFACT,
					NUM_ABONADO,
					COD_CICLO,
					COD_PLANTARIF,
					COD_CARGOBASICO,
					COD_CATEGORIA,
					COD_CICLO_ANT,
					COD_PLANTARIF_ANT,
					FEC_CARGA_TARJETA,
					COD_PROMOCION,
					IMP_CARGA,
					COD_OPERACION,
					FEC_PROCESO_CARGA,
					FEC_PROCESO_COMV,
					IMP_CARGA_PROM,
					FCT_PROPORCION )
					VALUES (
					vNumCelular,
					vCodCiclFact,
					vNumAbonado,
					vCodCiclo,
					vCodPlanTarif,
					vCargoBasico,
					vCodCategoria,
					vCodCiclo,
					vCodPlantarif,
					NULL,
					vCodPromocion,
					vImpCargoBasico,
					'BALANCE',
					SYSDATE,
					NULL,
					vCargaPromoc,
					1 );

					-- Recuperamos el codigo de actuacion en central.
					SELECT COD_ACTCEN
				  	INTO vCodActCen
				  	FROM GA_ACTABO
				 	WHERE COD_ACTABO = 'P1'
				   	AND COD_TECNOLOGIA = vCodTecnologia
				   	AND COD_MODULO = 'GA';

					-- recuperamos el numero de secuencia para la central
					SELECT ICC_SEQ_NUMMOV.NEXTVAL
				  	INTO vNumMov
				  	FROM DUAL;

					-- insertamos el movimiento en la central
					INSERT INTO ICC_MOVIMIENTO(
					NUM_MOVIMIENTO,
					NUM_ABONADO,
					COD_ESTADO,
					COD_ACTABO,
					COD_MODULO,
					NUM_INTENTOS,
					DES_RESPUESTA,
					COD_ACTUACION,
					NOM_USUARORA,
					FEC_INGRESO,
					COD_CENTRAL,
					NUM_CELULAR,
					NUM_SERIE,
					TIP_TERMINAL,
					IND_BLOQUEO,
					NUM_MIN,
					CARGA,
					FEC_EXPIRA,
					TIP_TECNOLOGIA,
					ICC,
					IMEI,
					IMSI )
					VALUES(
					vNumMov,
					vNumAbonado,
					1,
					'P1',
					'CO',
					0,
					'PENDIENTE',
					vCodActCen,
					vNomUsuario,
					SYSDATE,
					vCodCentral,
					vNumCelular,
					vNumSerieHex,
					vTipTerminal,
					0,
					vNumMin,
					vImpCargoBasico,
					vFechaExpira,
					vCodTecnologia,
					DECODE( vCodTecnologia, 'GSM', vNumSerie, NULL ),
					vNumImei,
					vNumImsi );

					-- actualizamos
					UPDATE GA_INFACCEL
				   	SET FEC_RECARGA = SYSDATE
				 	WHERE COD_CLIENTE = vCodCliente
				   	AND NUM_ABONADO = vNumAbonado
				   	AND COD_CICLFACT = vCodCiclFact;

               	END IF; -- if vExisteCarga > 0
			END IF; -- IF vFecRecarga = 'SF'

			vOK := 0;
		END IF; -- IF vCodTiPlan != 3
	END IF; -- IF vAbonadoActivo = 0

	IF vOK = 0
	THEN
	-- el proceso se realizo correctamente
		vResultado := 0;
	ELSE
	-- el proceso no se realizo correctamente
		vResultado := 1;
	END IF;
EXCEPTION
	WHEN OTHERS
	THEN
		-- se produjo un error en el proceso
		vResultado := 2;
END;
/
SHOW ERRORS
