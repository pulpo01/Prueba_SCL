CREATE OR REPLACE PROCEDURE PV_PR_DEVALMACEN(
vNUM_SERIE 		  IN VARCHAR2,	-- Numero de Serie
nNUM_ABONADO 	  IN NUMBER,	-- Numero de Abonado
vDEV_EQUIPO		  IN VARCHAR2,	-- Indicador de la serie
vNOM_USUARORA     IN VARCHAR2,	-- Nombre Usuario
vFEC_SYS		  IN DATE,		-- Fecha Operacion
vCOD_ACTABO	   	  IN VARCHAR2,
vERROR	 		  OUT VARCHAR2,	-- Error
vMEN_ERROR 		  OUT VARCHAR2	-- Mensaje de Error
)
IS

  	nNumError	  NUMBER(2);
	VP_ERROR   	  VARCHAR2(1);
	VP_PROC 	  VARCHAR2(50);
	VP_SQLCODE 	  VARCHAR2(15);
	VP_SQLERRM 	  VARCHAR2(70);
	VP_TABLA   	  VARCHAR2(50);
	VP_ACT 	  	  VARCHAR2(1);


	dfechadev	  date;
	nCodArticulo	AL_SERIES.COD_ARTICULO%TYPE;
	nCodBodega		AL_SERIES.COD_BODEGA%TYPE;
	nTipStock		AL_SERIES.TIP_STOCK%TYPE;
    nCodEstado		AL_SERIES.COD_ESTADO%TYPE;
	nCodUso			AL_SERIES.COD_USO%TYPE;
	sIndEqPrestado	GA_ABOCEL.IND_EQPRESTADO%TYPE;
	nCodProducto    GA_ABOCEL.COD_PRODUCTO%TYPE;
	vModulo			GED_PARAMETROS.COD_MODULO%TYPE;
	vNomParametro	GED_PARAMETROS.NOM_PARAMETRO%TYPE;
	vMovAlmacen		VARCHAR2(2);
	bEjecPInteral	BOOLEAN;
	nNumMeses		GA_PERCONTRATO.NUM_MESES%TYPE;
	sCodRespuesta	GA_TRANSACABO.COD_RETORNO%TYPE;
	nCodTipContra	GA_ABOCEL.COD_TIPCONTRATO%TYPE;
	vCodPlantarif	GA_ABOCEL.COD_PLANTARIF%TYPE;
	vIndProcequi	GA_EQUIPABOSER.IND_PROCEQUI%TYPE;
	sNumTransac		GA_TRANSACABO.NUM_TRANSACCION%TYPE;
	vCodEstadoDev	AL_SERIES.COD_ESTADO%TYPE;
	vCodBodegaDest  AL_SERIES.COD_BODEGA%TYPE;
	nNumMovimiento	AL_MOVIMIENTOS.NUM_MOVIMIENTO%TYPE;
	nIndSerTerl		AL_SERIES.IND_TELEFONO%TYPE;
	nNumVenta		GA_VENTAS.NUM_VENTA%TYPE;
	vCodCausa		GAT_EQUIPOS_DEVDIF.COD_CAUSA%TYPE;
	vCodCategoria	VE_CATPLANTARIF.COD_CATEGORIA%TYPE;
	nCanalVta		VE_TIPCOMIS.IND_VTA_EXTERNA%TYPE;
	nCantDias		GAD_PLAZO_DEVDIF.DIAS_DEVOLUCION%TYPE;
	nCodCliente		GA_ABOCEL.COD_CLIENTE%TYPE;
	vCantDias		VARCHAR2(3);

	ERROR_PROCESO 	EXCEPTION;
BEGIN



    bEjecPInteral:=False;
    VP_PROC:='PV_PR_DEVALMACEN';

	nNumError:=1;
	vMEN_ERROR:='Obtener datos desde ABOCEL';
	VP_TABLA:='GA_ABOCEL';
	VP_ACT:='S';


	SELECT IND_EQPRESTADO,COD_PRODUCTO,COD_TIPCONTRATO, COD_PLANTARIF,COD_CLIENTE
	INTO sIndEqPrestado,nCodProducto,nCodTipContra,vCodPlantarif,nCodCliente
	FROM GA_ABOCEL
  	WHERE NUM_ABONADO=nNUM_ABONADO;

	nNumError:=2;
	vMEN_ERROR:='Obtener datos desde EQUIPABOSER';
	VP_TABLA:='GA_EQUIPABOSER';
	VP_ACT:='S';

	SELECT B.COD_ARTICULO, B.COD_BODEGA,B.TIP_STOCK, B.COD_ESTADO, A.COD_USO, A.IND_PROCEQUI
	INTO nCodArticulo,nCodBodega,nTipStock,nCodEstado,nCodUso,vIndProcequi
	FROM GA_EQUIPABOSER A, AL_SERIES B
	WHERE A.NUM_ABONADO =nNUM_ABONADO
	AND A.NUM_SERIE=vNUM_SERIE
	AND A.NUM_SERIE = B.NUM_SERIE
	AND A.IND_EQUIACC = 'E'
	AND A.FEC_ALTA = (SELECT MAX(FEC_ALTA)
	FROM GA_EQUIPABOSER
	WHERE NUM_ABONADO =nNUM_ABONADO
        AND NUM_SERIE=vNUM_SERIE
	AND IND_EQUIACC = 'E');

	nNumError:=3;
	vMEN_ERROR:='Obtener secuencia TRANSACABO';
	VP_TABLA:='GA_SEQ_TRANSACABO';
	VP_ACT:='S';

	SELECT GA_SEQ_TRANSACABO.NEXTVAL
	INTO sNumTransac
	FROM DUAL;



    IF vDEV_EQUIPO='S' THEN	--Equipo Devuelto

	   nNumError:=4;
	   vMEN_ERROR:='Obtener Parametro Estado Revision';
	   VP_TABLA:='DEVVALPARAM';
	   VP_ACT:='S';

	   PV_PR_DEVVALPARAM('GA',nCodProducto,'COD_ESTREVISION',vCodEstadoDev);
	   nCodEstado:=to_number(vCodEstadoDev);

	   nNumError:=5;
	   vMEN_ERROR:='Obtener Parametro Bodega Destino';
	   VP_TABLA:='DEVVALPARAM';
	   VP_ACT:='S';


	   PV_PR_DEVVALPARAM('AL',nCodProducto,'COD_BODEGA_COMODATO',vCodBodegaDest);
	   nCodBodega:=to_number(vCodBodegaDest);


	   nNumError:=6;
	   vMEN_ERROR:='Obtener Parametro Mov. Retorno Prestamo';
	   VP_TABLA:='DEVVALPARAM';
	   VP_ACT:='S';

	   PV_PR_DEVVALPARAM('GA',nCodProducto,'MOVRETSALTEMARR',vMovAlmacen);

	   nNumError:=7;
	   vMEN_ERROR:='Ejecucion P_INTERAL';

	   VP_TABLA:='P_GA_INTERAL';
	   VP_ACT:='E';


	   P_GA_INTERAL(sNumTransac,vMovAlmacen,nTipStock,nCodBodega,nCodArticulo,nCodUso,nCodEstado,'',1,vNUM_SERIE,0);--Homologacion Patricio Gallegos MA-210820030132 08-09-2003

	   bEjecPInteral:=True;

    ELSIF vDEV_EQUIPO='N' THEN	-- Equipo No Devuelto

		 nNumError:=8;
		 vMEN_ERROR:='Obtener Parametro Mov. Salida Def.';
    	 VP_TABLA:='DEVVALPARAM';
    	 VP_ACT:='S';


    	 PV_PR_DEVVALPARAM('GA',nCodProducto,'MOVSALDEFARRCOM',vMovAlmacen);

		 nNumError:=9;
		 vMEN_ERROR:='Ejecucion P_INTERAL';
    	 VP_TABLA:='P_GA_INTERAL';
    	 VP_ACT:='E';



		 P_GA_INTERAL(sNumTransac,vMovAlmacen,nTipStock,nCodBodega,nCodArticulo,nCodUso,nCodEstado,nNumVenta,1,vNUM_SERIE,0);--Homologacion Patricio Gallegos MA-210820030132 08-09-2003


		 bEjecPInteral:=True;

    ELSIF vDEV_EQUIPO='D' THEN	-- Equipo con Dev. Diferida
	BEGIN

	   	 nNumError:=10;
	   	 vMEN_ERROR:='Obtener Meses GA_PERCONTRATO';
	   	 VP_TABLA:='GA_PERCONTRATO';
    	 VP_ACT:='S';

	  	 SELECT NUM_MESES
		 INTO nNumMeses
		 FROM GA_PERCONTRATO
		 WHERE COD_TIPCONTRATO =nCodTipContra
		 AND COD_PRODUCTO = nCodProducto;

	   	 nNumError:=11;
	   	 vMEN_ERROR:='Obtener Parametro Causa Baja';
		 VP_TABLA:='DEVVALPARAM';
		 VP_ACT:='S';

		 PV_PR_DEVVALPARAM('GA',nCodProducto,'BA',vCodCausa);

		 nNumError:=12;
		 vMEN_ERROR:='Obtener Categoria Plan';
		 VP_TABLA:='VE_CATPLAN';
		 VP_ACT:='S';

	   	 SELECT COD_CATEGORIA
		 INTO vCodCategoria
		 FROM VE_CATPLANTARIF
		 WHERE COD_PLANTARIF=vCodPlanTarif;

	   	 nNumError:=13;
	   	 vMEN_ERROR:='Obtener canal de venta';
		 VP_TABLA:='VE_TIPCOMIS';
		 VP_ACT:='S';

	   	 SELECT IND_VTA_EXTERNA
		 INTO nCanalVta
		 FROM VE_VENDEDORES B, VE_TIPCOMIS A
		 WHERE COD_VENDEDOR=(SELECT COD_VENDEDOR
		 FROM GE_SEG_USUARIO
		 WHERE NOM_USUARIO=vNOM_USUARORA)
		 AND B.COD_TIPCOMIS=A.COD_TIPCOMIS;

	   	 nNumError:=14;
	   	 vMEN_ERROR:='Obtener dias de Dev.';
		 VP_TABLA:='GAD_PLAZO_DEVDIF';
		 VP_ACT:='S';



      	 BEGIN

		 		SELECT DIAS_DEVOLUCION
		 		INTO nCantDias
		 		FROM GAD_PLAZO_DEVDIF
		 		WHERE COD_TIPCONTRATO = nCodTipContra
		 		AND NUM_MESES =nNumMeses
		 		AND COD_OPERACION ='BA'
		 		AND IND_CAUSA =1
		 		AND COD_CAUSA=vCodCausa
		 		AND COD_CATEGORIA=vCodCategoria
		 		AND COD_CANAL_VTA=nCanalVta
		 		AND vFEC_SYS BETWEEN FEC_DESDE AND NVL(FEC_HASTA,vFEC_SYS);
		 EXCEPTION
		 	WHEN NO_DATA_FOUND THEN

    	 		 nNumError:=15;
	   	 		 vMEN_ERROR:='Obtener Parametro Dias Dev Fijo';
		 		 VP_TABLA:='DEVVALPARAM';
		 		 VP_ACT:='S';


		 		 PV_PR_DEVVALPARAM('GA',nCodProducto,'DIASDEVDIF',vCantDias);
				 nCantDias:=to_number(vCantDias);
		 END;

	   	 nNumError:=16;
	   	 vMEN_ERROR:='Ingresar equipos Dev Dif';
		 VP_TABLA:='GAT_-EQUIPOS_DEVDIF';
		 VP_ACT:='I';


		 dfechadev:=vFEC_SYS+nCantDias;


	   	 INSERT INTO GAT_EQUIPOS_DEVDIF
	   	 (COD_CLIENTE, NUM_ABONADO, NUM_SERIE, COD_TIPMOV, COD_OPERACION,
	   	 COD_CAUSA, FEC_INGRESO, NOM_USUARIO, COD_ESTADO_DEV,FEC_MAXIMA_DEV,
		 IND_COBRO, NUM_CARGO)
	   	 VALUES(nCodCliente,nNUM_ABONADO,vNUM_SERIE,'1','BA',vCodCausa,
		 vFEC_SYS,vNOM_USUARORA,'N',dfechadev,NULL,NULL);

    EXCEPTION

           WHEN OTHERS THEN

               RAISE ERROR_PROCESO;
    END;
    END IF;

	IF bEjecPInteral THEN

	   nNumError:=17;
	   vMEN_ERROR:='Respuesta del PL';

	   SELECT COD_RETORNO
	   INTO sCodRespuesta
	   FROM GA_TRANSACABO
	   WHERE NUM_TRANSACCION=sNumTransac;
	   IF sCodRespuesta <> '0'  THEN
		 	RAISE ERROR_PROCESO;

	   END IF;
     END IF;

    vERROR:='0';
    vMEN_ERROR:='Exito';

EXCEPTION

	WHEN ERROR_PROCESO THEN

		  VP_SQLCODE:=SQLCODE;
		  VP_SQLERRM:=SQLERRM;

  	 	  ROLLBACK;

		  vERROR:=to_char(nNumError);

END;
/
SHOW ERRORS
