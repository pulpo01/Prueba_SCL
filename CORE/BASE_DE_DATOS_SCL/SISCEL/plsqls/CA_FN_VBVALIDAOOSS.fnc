CREATE OR REPLACE FUNCTION          "CA_FN_VBVALIDAOOSS" --Versión 1.1 RA-200511290218, PBARRIA 01/12/2005

  (VP_NUM_ABONADO IN VARCHAR2,
   VP_SCODACTABO IN VARCHAR2,
   VP_INTERLOCUTOR IN NUMBER, -- 1 Producto Celular
   VP_SCODSITUACION IN VARCHAR2,
   VP_FECHA_CUMPLAN IN VARCHAR2,
   VP_COD_CAUBAJA IN VARCHAR2,
   VP_SINDSUSPEN IN VARCHAR2 )
   RETURN NUMBER IS
-- --------------------------------------------------------------------------------
-- Funcion que valida estado de abonado antes de solicitar cualquier OOSS desde SAC
-- --------------------------------------------------------------------------------
   VI_BRES NUMBER;
   VI_CodCauTras VARCHAR2(5);
   VI_DES_SITUACION  VARCHAR2(30);
   VI_LDIAS NUMBER;
   VI_FECHA_AUX DATE;
   VI_CONTADOR NUMBER;
   VI_FMT_FECHA VARCHAR2(20);
   VI_FMT_FECHA_HORA VARCHAR2(30);
   VI_nNumError NUMBER (5);   -- numero de error
   VI_sMsgError varchar(500); -- mensaje de error
   ERROR_PROCESO EXCEPTION;
BEGIN
   VI_BRES:= 0;  -- Se inicializa en Falso
-- --------- Obtiene datos generales ----------------------------------------------
   VI_FMT_FECHA := GE_FN_DEVVALPARAM('GE',1,'FORMATO_SEL2');
   VI_FMT_FECHA_HORA := GE_FN_DEVVALPARAM('GE',1,'FORMATO_SEL7');
   VI_FMT_FECHA_HORA := VI_FMT_FECHA || ' ' || VI_FMT_FECHA_HORA;
   SELECT cod_cautras INTO VI_CodCauTras
   FROM ga_datosgener;
   SELECT des_situacion INTO VI_DES_SITUACION
   FROM ga_situabo
   WHERE cod_situacion = VP_SCODSITUACION;
-- -----------Validacion 1---------------------------------------------------------
-- DT, ABONO DE MINUTOS
IF VP_SCODACTABO = 'DT' THEN
   IF VP_SCODSITUACION <> 'AAA' THEN
      VI_nNumError := -20010;
      RAISE ERROR_PROCESO;
   ELSE
      VI_BRES := 1; --Verdadero
   END IF;
-- -----------Validacion 2---------------------------------------------------------
-- CB,CAMBIO DE CARGO BASICO
-- CC,CAMBIO DE CICLO DE FACTURACION
-- CG,CAMBIO GRUPO COBRO SERVICIOS
-- CL,CAMBIO DE LIMITE DE CONSUMO
-- CM,CAMBIO CREDITO MOROSIDAD
-- CN,CAMBIO DE NUMERO DE CELULAR
-- CS,CAMBIO DE PLAN DE SERVICIOS
-- DE,CAMBIO DIAS ESPECIALES
-- FF,CAMBIO FRIENDS AND FAMILY
-- MC,MODIFICAR CAMPOS DE CATEGORIA
-- MG,MODIFICACION GENERALES ABONADO
-- RA,ALTA ROAMING STARTEL
-- SS,SERVICIOS SUPLEMENTARIOS
-- TA,TRASPASO DE ABONADOS
ELSIF VP_SCODACTABO IN ('CB','CC','CG','CL','CM','CN','CS','DE','FF','MC','MG','RA','SS','TA') THEN
   IF VP_SCODSITUACION = 'SAA' THEN
      VI_nNumError := -20022;
      SELECT COUNT(*) INTO VI_CONTADOR
          FROM GA_SUSPREHABO
      WHERE COD_MODULO = 'CO'
        AND COD_CAUSUSP = '1'
        AND FEC_REHABD IS NULL
        AND NUM_ABONADO = VP_NUM_ABONADO;
          IF VI_CONTADOR > 0 THEN
         VI_BRES := 1; --Verdadero
          ELSE
         VI_nNumError := -20022;
         RAISE ERROR_PROCESO;
          END IF;
   ELSIF VP_SCODSITUACION  = 'AAA' THEN
      VI_BRES := 1; --Verdadero
   ELSE
      VI_nNumError := -20010;
      RAISE ERROR_PROCESO;
   END IF;
-- -----------Validacion 3---------------------------------------------------------
-- SP,SUSPENSION PARCIAL
-- ST,SUSPENSION TOTAL
ELSIF VP_SCODACTABO IN ('SP','ST') THEN
   IF VP_SCODSITUACION IN ('AAA','SAA') THEN
      IF VP_SINDSUSPEN = 1 THEN
          VI_BRES := 1; --Verdadero
      ELSE
          IF VP_SINDSUSPEN = 0 THEN
              VI_nNumError := -20011;
              RAISE ERROR_PROCESO;
          ELSE
              VI_nNumError := -20012;
              RAISE ERROR_PROCESO;
          END IF;
      END IF;
   ELSE
      VI_nNumError := -20013;
      RAISE ERROR_PROCESO;
   END IF;
-- -----------Validacion 4---------------------------------------------------------
-- FS,FORMALIZACION SINIESTRO
-- RE,RESTITUCION DE EQUIPO
-- S2,ANULA.AV.SINIESTRO RENT PHONE
-- S3,FORMALIZACION RENT A PHONE
-- S4,RESTITUCION SINIESTROS RENT
ELSIF VP_SCODACTABO IN ('FS','RE','S2','S3','S4') THEN
   IF VP_SCODSITUACION IN ('AOS','ATS','CVS','RDS','SAA','AAA','RTP') THEN
      SELECT COUNT(*) INTO VI_CONTADOR
      FROM GA_SINIESTROS
      WHERE NUM_ABONADO = VP_NUM_ABONADO;
      IF VI_CONTADOR <> 0 THEN
         VI_BRES := 1;--Verdadero
      ELSE
         VI_nNumError := -20014;
         RAISE ERROR_PROCESO;
      END IF;
   ELSE
      VI_nNumError := -20015;
      RAISE ERROR_PROCESO;
   END IF;
-- -----------Validacion 5---------------------------------------------------------
-- AC,CAMBIO DE ARRIENDO A COMPRA
ELSIF VP_SCODACTABO = 'AC' THEN
   VI_nNumError := -20016;
   RAISE ERROR_PROCESO;
-- -----------Validacion 6---------------------------------------------------------
-- AB,ANULACION DE BAJA DE ABONADOS
ELSIF VP_SCODACTABO = 'AB'  THEN
   IF VP_SCODSITUACION = 'BAA' THEN
      IF VP_COD_CAUBAJA <> VI_CodCauTras THEN
         VI_BRES := 1;--Verdadero
      ELSE
         VI_nNumError := -20017;
         RAISE ERROR_PROCESO;
      END IF;
   ELSE
      IF VP_SCODSITUACION = 'BAP' THEN
          VI_BRES := 1;--Verdadero
          IF VP_INTERLOCUTOR <> 1 THEN
             VI_nNumError := -20018;
             RAISE ERROR_PROCESO;
          END IF;
      ELSE
          VI_nNumError := -20018;
          RAISE ERROR_PROCESO;
      END IF;
   END IF;
-- -----------Validacion 7---------------------------------------------------------

ELSIF VP_SCODACTABO = 'CT' THEN
--Inicio RA-200511290218, PBARRIA 02-12-2005
   VI_BRES := 1;  --Verdadero

/* Se comenta la siguiente condición debido a que estará incluída en el modelo de restricciones
-- CT,CAMBIO DE PLAN TARIFARIO
   IF VP_SCODSITUACION ='AAA' THEN
          VI_FECHA_AUX := TO_DATE(VP_FECHA_CUMPLAN,VI_FMT_FECHA_HORA);
          VI_FECHA_AUX := TO_DATE(TO_CHAR(VI_FECHA_AUX,VI_FMT_FECHA),VI_FMT_FECHA);
      VI_LDIAS := TO_DATE(TO_CHAR(SYSDATE,VI_FMT_FECHA),VI_FMT_FECHA) - VI_FECHA_AUX;
      IF VI_LDIAS > 0 THEN
         VI_BRES := 1;--Verdadero
      ELSE
         VI_nNumError := -20019;
         RAISE ERROR_PROCESO;
      END IF;
   ELSE
      VI_nNumError := -20010;
      RAISE ERROR_PROCESO;
   END IF;
Fin RA-200511290218, PBARRIA 02-12-2005
*/
-- -----------Validacion 8---------------------------------------------------------
-- BA,BAJA DE ABONADOS
ELSIF  VP_SCODACTABO = 'BA' THEN
   IF VP_SCODSITUACION IN ('AAA','SAA') THEN
      VI_BRES := 1;--Verdadero
   ELSE
      VI_nNumError := -20013;
      RAISE ERROR_PROCESO;
   END IF;
-- -----------Validacion 9---------------------------------------------------------
-- MG,MODIFICACION GENERALES ABONADO
-- NF,MODIF. NUMEROS FRECUENTES
ELSIF VP_SCODACTABO IN ('MG','NF') THEN
   IF VP_SCODSITUACION IN ('AAA','SAA') THEN
      VI_BRES := 1;--Verdadero
   ELSE
      VI_nNumError := -20013;
      RAISE ERROR_PROCESO;
   END IF;
-- -----------Validacion 10--------------------------------------------------------
-- PI,CAMBIO P.TARIFARIO INMEDIATO
ELSIF  VP_SCODACTABO ='PI'  THEN
   IF VP_SCODSITUACION = 'AAA' THEN
      VI_BRES := 1;--Verdadero
   ELSE
      VI_nNumError := -20010;
      RAISE ERROR_PROCESO;
   END IF;
-- -----------Validacion 11---------------------------------------------------------
-- Resto de las actuaciones
ELSE
   VI_BRES := 1;--Verdadero
END IF;
RETURN VI_BRES;
EXCEPTION
   WHEN ERROR_PROCESO THEN
      IF VI_nNumError = -20010 THEN
         VI_sMsgError := '<<El Abonado no cumple las condiciones para ejecutar una OOSS. Su situacion actual es '||VI_DES_SITUACION||' y debe estar en Alta Activa de Abonado>>';
      ELSIF VI_nNumError = -20011 THEN
         VI_sMsgError := '<<El Abonado no cumple las condiciones para ejecutar una OOSS, ya que se encuentra como NO SUSPENDIBLE>>';
      ELSIF VI_nNumError = -20012 THEN
         VI_sMsgError := 'Error al faltar indicador de suspension.';
      ELSIF VI_nNumError = -20013 THEN
         VI_sMsgError := '<<El Abonado no cumple las condiciones para ejecutar una OOSS. Su situacion actual es '||VI_DES_SITUACION||' y debe estar en Alta o Suspension Activa de Abonado>>';
      ELSIF VI_nNumError = -20014 THEN
         VI_sMsgError := '<<El abonado no tiene realizado un Aviso de Siniestro>>';
      ELSIF VI_nNumError = -20015 THEN
         VI_sMsgError := '<<El Abonado no cumple las condiciones para ejecutar una OOSS. Su situacion actual es '||VI_DES_SITUACION||' y debe estar en S.Activa Vta.Documentada, S.Activa Vta.Cumplimentada, S.Activa Vta.Terreno, S.Activa Vta.Oficina o S.Activa Abonado>>';
      ELSIF VI_nNumError = -20016 THEN
         VI_sMsgError := '<<OOSS "Cambio de Arriendo a Compra" no existe>>';
      ELSIF VI_nNumError = -20017 THEN
         VI_sMsgError := '<<El Abonado no cumple las condiciones para ejecutar una OOSS, ya que ha sido dado de baja por Traspaso>>';
      ELSIF VI_nNumError = -20018 THEN
         VI_sMsgError := '<<El Abonado no cumple las condiciones para ejecutar una OOSS. Su situacion actual es '||VI_DES_SITUACION||' y debe estar en Baja Activa de Abonado>>';
      /* Inicio RA-200511290218, PBARRIA 02-12-2005
      ELSIF VI_nNumError = -20019 THEN
         VI_sMsgError := '<<El Abonado no cumple las condiciones para ejecutar una OOSS ya que le quedan '||ABS(VI_LDIAS)||' dias para cumplir fecha del termino del Plan Tarifario anterior>>';
      Fin RA-200511290218, PBARRIA 02-12-2005 */
      ELSE
         VI_nNumError := -20022;
         VI_sMsgError := '<<El Abonado no cumple las condiciones para ejecutar una OOSS. Su situacion actual es '||VI_DES_SITUACION||' y su suspension no fue por Mora. Se requiere que se encuentre en Alta Activa de Abonado>>';
      END IF;
      RAISE_APPLICATION_ERROR (VI_nNumError,VI_sMsgError);
   WHEN NO_DATA_FOUND THEN
      VI_nNumError := -20021;
      VI_sMsgError := 'Error al obtener datos generales';
      RAISE_APPLICATION_ERROR (VI_nNumError,VI_sMsgError);
   WHEN OTHERS THEN
      VI_nNumError := -20023;
      VI_sMsgError := 'Error no controlado en el procedimiento';
      RAISE_APPLICATION_ERROR (VI_nNumError,VI_sMsgError);
END;
/
SHOW ERRORS
