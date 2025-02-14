CREATE OR REPLACE TRIGGER PV_RECORRIDO_BEDEL_TG
BEFORE DELETE ON PV_ERECORRIDO
REFERENCING OLD AS OLD
FOR EACH ROW
/*
<NOMBRE>	: PV_RECORRIDO_BEDEL_TG </NOMBRE>
<FECHACREA>	: 02/08/2004 <FECHACREA/>
<MODULO >	: Gestion Abonados </MODULO >
<AUTOR >    : Patricio Gallegos C. </AUTOR >
<VERSION >  : 1.0 </VERSION >
<DESCRIPCION> : Informa al Gestor de contacto o retensiones el nuevo estado de la orden de servicio, al realizar
una anulacion o reproceso.</DESCRIPCION>
<FECHAMOD >   : DD/MM/YYYY </FECHAMOD >
<DESCMOD >   :  Breve descripcion de Modificacion </DESCMOD >
<ParamSal >  : </ParamSal>
*/

DECLARE

TN_NumOsPadre   PV_IORSERV.num_ospadre%TYPE;
TN_CodEstado	PV_IORSERV.cod_estado%TYPE;
TN_NumIntentos	PV_IORSERV.num_intentos%TYPE;
TN_MaxIntentos	PV_IORSERV.num_intentos%TYPE;
TN_IdGestor		PV_IORSERV.id_gestor%TYPE;
TV_CodModulo	PV_IORSERV.cod_modulo%TYPE;
TN_CodEstCanc	PV_IORSERV.cod_estado%TYPE;

BEGIN
	 SELECT cod_estado, num_intentos, id_gestor, cod_modulo, num_ospadre
	 INTO TN_CodEstado, TN_NumIntentos, TN_IdGestor,TV_CodModulo,TN_NumOsPadre
	 FROM PV_IORSERV
	 WHERE num_os=:OLD.num_os;

	 IF TN_IdGestor IS NOT NULL AND TV_CodModulo IS NOT NULL THEN

		 Select TO_NUMBER(val_parametro)
		 INTO TN_CodEstCanc
		 From GED_PARAMETROS
		 Where Nom_parametro='EST_OOSS_CANCELADA'
		 And Cod_Modulo='GA'
		 And cod_producto=1;

		 SELECT TO_NUMBER(val_parametro)
		 INTO TN_MaxIntentos
		 FROM GED_PARAMETROS
		 WHERE nom_parametro='MAX_INTENTOS'
		 AND cod_modulo='GA'
		 AND cod_producto=1;

		 IF ((TN_NumOsPadre IS NULL OR :OLD.num_os=TN_NumOsPadre ) AND TN_CodEstado=TN_CodEstCanc)
		 	AND :OLD.cod_estado IN (10,15) AND :OLD.tip_estado=3 AND NVL(TN_NumIntentos,0)<TN_MaxIntentos  THEN
		 	PV_INFORMAR_ESTADO_TAFI_PR(TV_CodModulo,TN_IdGestor,NULL,NULL,'CERRADA','ANULADA - ADM.SOLICITUDES.');
		 END IF;

		 IF :OLD.cod_estado>=15 AND :OLD.tip_estado=4 AND NVL(TN_NumIntentos,0)<TN_MaxIntentos AND TN_CodEstado>=15 AND TN_CodEstado<990 THEN
		 	PV_INFORMAR_ESTADO_TAFI_PR(TV_CodModulo,TN_IdGestor,NULL,NULL,'ASIGNADA','REPROCESADA EN EL INTENTO N? ' || NVL(TN_NumIntentos,0) || ' - ADM.SOLICITUDES.' );
		 END IF;

	 END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR  (-20002,'ERROR INESPERADO EN TRIGGER : ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);
        NULL;
END;
/
SHOW ERRORS
