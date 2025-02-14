CREATE OR REPLACE PACKAGE PV_OBTIENEDESCRIPCIONSS_PG IS

   type des_servicio is table of GA_SERVSUPL.DES_SERVICIO%TYPE     INDEX BY BINARY_INTEGER;
   type tip_estado   is table of Varchar2(10)                      INDEX BY BINARY_INTEGER;
   type servicio_des is table of PV_CAMCOM.CLASE_SERVICIO_DES%TYPE INDEX BY BINARY_INTEGER;
   type servicio_act is table of PV_CAMCOM.CLASE_SERVICIO_ACT%TYPE INDEX BY BINARY_INTEGER;


   PROCEDURE PV_OBTIENEDESCRIPCIONSS_PR(PNumOs IN PV_CAMCOM.num_os%TYPE,
   			 							Des    OUT servicio_des,
										Act    OUT servicio_act,
										Coment OUT des_servicio,
										Estado OUT tip_estado);

END PV_OBTIENEDESCRIPCIONSS_PG;
/
SHOW ERRORS
