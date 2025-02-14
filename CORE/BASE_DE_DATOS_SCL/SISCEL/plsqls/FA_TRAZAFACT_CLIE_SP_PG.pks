CREATE OR REPLACE PACKAGE FA_TRAZAFACT_CLIE_SP_PG
/*
<Documentaci�n TipoDoc = "Package">
   <Elemento Nombre = "FA_TRAZAFACT_CLIE_SP_PG"
          Lenguaje="PL/SQL"
          Fecha="20-03-2007"
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




   PROCEDURE FA_INS_FA_TRAZAFACT_CLIE_PR (Reg_Fa_TrazaFact_clie IN         FA_TRAZAFACT_CLIE_TO%ROWTYPE,
										SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento
							            );

   PROCEDURE FA_SEL_FA_TRAZAFACT_CLIE_PR (
   			 							EN_Cod_Cliente          IN         FA_TRAZAFACT_CLIE_TO.COD_CLIENTE%TYPE,
										EN_Cod_Ciclo            IN 		   FA_TRAZAFACT_CLIE_TO.COD_CICLO%TYPE,
										EN_Ano                  IN 		   FA_TRAZAFACT_CLIE_TO.ANO_CICLO%TYPE,
										EN_Cod_Ciclfact         IN 		   FA_TRAZAFACT_CLIE_TO.COD_CICLFACT%TYPE,
										EN_Cod_Proceso			IN 		   FA_TRAZAFACT_CLIE_TO.COD_PROCESO%TYPE,
   			 							Reg_Fa_TrazaFact_clie   OUT NOCOPY FA_TRAZAFACT_CLIE_TO%ROWTYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento);

   PROCEDURE FA_UPD_FA_TRAZAFACT_CLIE_PR (
   			 							EN_Cod_Cliente          IN         FA_TRAZAFACT_CLIE_TO.COD_CLIENTE%TYPE,
										EN_Cod_Ciclo            IN 		   FA_TRAZAFACT_CLIE_TO.COD_CICLO%TYPE,
										EN_Ano                  IN 		   FA_TRAZAFACT_CLIE_TO.ANO_CICLO%TYPE,
										EN_Cod_Ciclfact         IN 		   FA_TRAZAFACT_CLIE_TO.COD_CICLFACT%TYPE,
										EN_Cod_Proceso			IN 		   FA_TRAZAFACT_CLIE_TO.COD_PROCESO%TYPE,
   			 							Reg_Fa_TrazaFact_clie   IN 		   FA_TRAZAFACT_CLIE_TO%ROWTYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento);

   PROCEDURE FA_DEL_FA_TRAZAFACT_CLIE_PR (EN_Cod_Cliente        IN         FA_TRAZAFACT_CLIE_TO.COD_CLIENTE%TYPE,
										EN_Cod_Ciclo            IN         FA_TRAZAFACT_CLIE_TO.COD_CICLO%TYPE,
										EN_Ano                  IN 		   FA_TRAZAFACT_CLIE_TO.ANO_CICLO%TYPE,
										EN_Cod_Ciclfact         IN 		   FA_TRAZAFACT_CLIE_TO.COD_CICLFACT%TYPE,
										EN_Cod_Proceso			IN 		   FA_TRAZAFACT_CLIE_TO.COD_PROCESO%TYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento);




END FA_TRAZAFACT_CLIE_SP_PG;
/
SHOW ERRORS
