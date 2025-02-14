CREATE OR REPLACE PACKAGE BODY PV_OBTIENEDESCRIPCIONSS_PG AS

   PROCEDURE PV_OBTIENEDESCRIPCIONSS_PR (PNumOs IN PV_CAMCOM.num_os%TYPE,
   			 							 Des    OUT servicio_des,
										 Act    OUT servicio_act,
										 Coment OUT des_servicio,
										 Estado OUT tip_estado) IS





   activar        pv_camcom.CLASE_SERVICIO_ACT%type;
   desactivar     pv_camcom.CLASE_SERVICIO_DES%type;
   v_nNumError	  NUMBER;
   v_sMsgError    VARCHAR2(1000);
   v_clase 		  PV_CAMCOM.CLASE_SERVICIO_ACT%TYPE;
   v_cod_servicio PV_CAMCOM.CLASE_SERVICIO_ACT%TYPE;
   v_des_servicio GA_SERVSUPL.DES_SERVICIO%TYPE;
   v_largo 		  pls_integer;
   v_largo2 	  pls_integer;
   v_ind     	  pls_integer;

   cursor c_clase_serv(PNumOs PV_CAMCOM.num_os%TYPE) is
   SELECT a.CLASE_SERVICIO_ACT, a.CLASE_SERVICIO_DES
   FROM PV_CAMCOM a
   WHERE a.NUM_OS = PNumOs
   UNION
   SELECT a.CLASE_SERVICIO_ACT, a.CLASE_SERVICIO_DES
   FROM PVH_CAMCOM a
   WHERE a.NUM_OS = PNumOs;

   cursor c_descrip(Des GA_SERVSUPL.cod_servsupl%TYPE, Act GA_SERVSUPL.cod_nivel%TYPE) is
   SELECT a.des_servicio
   FROM ga_servsupl a
   WHERE cod_servsupl = Des
   AND cod_nivel = Act;


BEGIN
   v_ind:=0;
   for v_clase_serv in c_clase_serv(PNumOs) loop

   --Activos
     v_clase:=v_clase_serv.CLASE_SERVICIO_ACT;
	 v_largo:=length(v_clase_serv.CLASE_SERVICIO_ACT);

	 while v_largo <> 0 loop
	   v_ind:=v_ind + 1;
	   v_cod_servicio:=substr(v_clase,1,6);
	   v_largo2:=length(v_cod_servicio);
	   v_clase:=substr(v_clase,v_largo2 + 1,v_largo);

	   Des(v_ind) := substr(v_cod_servicio,1,2);
	   Act(v_ind) := substr(v_cod_servicio,3,4);

	   for v_desc in c_descrip(Des(v_ind),Act(v_ind)) loop

		   Coment(v_ind) := v_desc.des_servicio;
   		   Estado(v_ind) := 'ACTIVO';

	   end loop;
	   v_largo:=length(v_clase);
	 end loop;

   --Desactivos
     v_clase:=v_clase_serv.CLASE_SERVICIO_DES;
	 v_largo:=length(v_clase_serv.CLASE_SERVICIO_DES);

	 while v_largo <> 0 loop
	   v_ind:=v_ind + 1;
	   v_cod_servicio:=substr(v_clase,1,6);
	   v_largo2:=length(v_cod_servicio);
	   v_clase:=substr(v_clase,v_largo2 + 1,v_largo);

	   Des(v_ind) := substr(v_cod_servicio,1,2);
	   Act(v_ind) := substr(v_cod_servicio,3,4);

	   for v_desc in c_descrip(Des(v_ind),Act(v_ind)) loop

		   Coment(v_ind) := v_desc.des_servicio;
   		   Estado(v_ind) := 'DESACTIVO';

	   end loop;
	   v_largo:=length(v_clase);
	 end loop;

   end loop;

   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       v_nNumError := -20003;
	   v_sMsgError := 'No se encontro el numero de OOSS para la Ficha y Modulo entregados';
       RAISE_APPLICATION_ERROR (v_nNumError,v_sMsgError);
     WHEN OTHERS THEN
	   v_nNumError := SQLCODE;
	   v_sMsgError := substr(SQLERRM,1,59);
       RAISE_APPLICATION_ERROR (v_nNumError,v_sMsgError);
END PV_OBTIENEDESCRIPCIONSS_PR;

END PV_OBTIENEDESCRIPCIONSS_PG;
/
SHOW ERRORS
