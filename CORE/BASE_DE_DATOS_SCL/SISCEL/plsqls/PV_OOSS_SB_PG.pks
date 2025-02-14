CREATE OR REPLACE PACKAGE PV_OOSS_SB_PG

/*
<Documentaci�n TipoDoc = "Package">
   <Elemento Nombre = "PV_OOSS_SB_PG
          Lenguaje="PL/SQL"
          Fecha="10-08-2006"
          Versi�n="1.0"
          Dise�ador= "Oscar Jorquera"
		  Programador="Oscar Jorquera"
          Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripci�n>Package servicios base para Servicios Suplementarios</Descripci�n>
      <Par�metros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Par�metros>
</Elemento>
</Documentaci�n>
*/
AS


   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'PV';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';

 -- Pv_Bass_ss_Pg   CU_08

   PROCEDURE pv_inscribir_ooss_pr(
   		    so_orserv         	  	 IN OUT NOCOPY	PV_CI_ORSERV_QT,
      	 	sn_cod_retorno           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
      	 	sv_mens_retorno          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
      	 	sn_num_evento            OUT NOCOPY		ge_errores_pg.evento);


end PV_OOSS_SB_PG ;
/
SHOW ERRORS