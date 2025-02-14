CREATE OR REPLACE PACKAGE FA_PROCFACTPREC_SP_PG
/*
<Documentaci�n TipoDoc = "Package">
   <Elemento Nombre = "FA_PROCFACTPREC_SP_PG"
          Lenguaje="PL/SQL"
          Fecha="21-03-2007"
          Versi�n="1.0"
          Dise�ador=""
          Programador="Javier Garcia"
          Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripci�n></Descripci�n>
      <Par�metros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Par�metros>
</Elemento>
</Documentaci�n>
*/
IS
   cv_error_no_clasif      VARCHAR2 (50) := 'No es posible clasificar el error';
   cv_cod_modulo           VARCHAR2 (2)  := 'FA';
   cv_version              VARCHAR2 (2)  := '1';


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




   PROCEDURE FA_INS_FA_PROCFACTPREC_PR (Reg_Fa_Proc             IN         FA_PROCFACTPREC%ROWTYPE,
										SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento
							            );

   PROCEDURE FA_SEL_FA_PROCFACTPREC_PR (EN_Cod_Proceso          IN         FA_PROCFACTPREC.COD_PROCESO%TYPE,
										EN_Cod_Procprec         IN 		   FA_PROCFACTPREC.COD_PROCPREC%TYPE,
   			 							Reg_Fa_Proc             OUT NOCOPY FA_PROCFACTPREC%ROWTYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento);

   PROCEDURE FA_UPD_FA_PROCFACTPREC_PR (EN_Cod_Proceso          IN         FA_PROCFACTPREC.COD_PROCESO%TYPE,
										EN_Cod_Procprec         IN 		   FA_PROCFACTPREC.COD_PROCPREC%TYPE,
   			 							Reg_Fa_Proc             IN 		   FA_PROCFACTPREC%ROWTYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento);

   PROCEDURE FA_DEL_FA_PROCFACTPREC_PR (EN_Cod_Proceso          IN 	       FA_PROCFACTPREC.COD_PROCESO%TYPE,
										EN_Cod_Procprec         IN 		   FA_PROCFACTPREC.COD_PROCPREC%TYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento);




END FA_PROCFACTPREC_SP_PG;
/
SHOW ERRORS
