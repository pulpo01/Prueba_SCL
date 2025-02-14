CREATE OR REPLACE TRIGGER PV_AFUP_ORSERV_TG
AFTER UPDATE OF COD_ESTADO ON CI_ORSERV
REFERENCING NEW AS NEW
FOR EACH ROW
/*
<NOMBRE>	: PV_AFUP_ORSERV_TG </NOMBRE>
<FECHACREA>	: 05/04/2004 <FECHACREA/>
<AUTOR >    : Patricio Gallegos C. </AUTOR >
<DESCRIPCION> : Para modificar estado del abonado o en caso de error debe deshacer orden de servicio restaurando
los datos del abonado </DESCRIPCION>
*/


DECLARE
   TN_CodEstEjec		ICC_INTERFAZ_CONSULTAS_TO.cod_estado%TYPE;
   SN_rent		  number(1):=0;
BEGIN
  TN_CodEstEjec:=to_number(GE_FN_DEVVALPARAM('GA',1,'COD_EST_TRX_EJEC'));

	 IF :NEW.tip_inter=1 AND PV_SEQTRXPLATAF_FN(NULL,:NEW.cod_inter) AND :NEW.cod_estado=TN_CodEstEjec THEN
	 	P_MODIFICA_ESTADOABO(1,:NEW.cod_inter,NULL,SN_rent,SYSDATE,0);
	 END IF;

EXCEPTION
   WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20250,SQLERRM);
END;
/
SHOW ERRORS
