CREATE OR REPLACE PACKAGE FA_TRAZAPROC_SP_PG
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "FA_TRAZAPROC_SP_PG"
          Lenguaje="PL/SQL"
          Fecha="21-03-2007"
          Versión="1.0"
          Diseñador=""
          Programador="Javier Garcia"
          Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción></Descripción>
      <Parámetros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Parámetros>
</Elemento>
</Documentación>
*/
IS
   cv_error_no_clasif      VARCHAR2 (50) := 'No es posible clasificar el error';
   cv_cod_modulo           VARCHAR2 (2)  := 'FA';
   cv_version              VARCHAR2 (2)  := '1';


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




   PROCEDURE FA_INS_FA_TRAZAPROC_PR (   Reg_Fa_TrazaProc        IN         FA_TRAZAPROC%ROWTYPE,
										SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento
							            );

   PROCEDURE FA_SEL_FA_TRAZAPROC_PR (
   			 							EN_Cod_ciclfact         IN         FA_TRAZAPROC.COD_CICLFACT%TYPE,
										EN_Cod_proceso          IN 		   FA_TRAZAPROC.COD_PROCESO%TYPE,
										EV_host_id              IN 		   FA_TRAZAPROC.HOST_ID%TYPE,
   			 							Reg_Fa_TrazaProc        OUT NOCOPY FA_TRAZAPROC%ROWTYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento);

   PROCEDURE FA_UPD_FA_TRAZAPROC_PR (
   			 							EN_Cod_ciclfact         IN         FA_TRAZAPROC.COD_CICLFACT%TYPE,
										EN_Cod_proceso          IN 		   FA_TRAZAPROC.COD_PROCESO%TYPE,
										EV_host_id              IN 		   FA_TRAZAPROC.HOST_ID%TYPE,
   			 							Reg_Fa_TrazaProc        IN 		   FA_TRAZAPROC%ROWTYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento);

   PROCEDURE FA_DEL_FA_TRAZAPROC_PR (   EN_Cod_ciclfact         IN 	       FA_TRAZAPROC.COD_CICLFACT%TYPE,
										EN_Cod_proceso          IN 		   FA_TRAZAPROC.COD_PROCESO%TYPE,
										EV_host_id              IN 		   FA_TRAZAPROC.HOST_ID%TYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento);




END FA_TRAZAPROC_SP_PG;
/
SHOW ERRORS
