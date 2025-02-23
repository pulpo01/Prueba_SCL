CREATE OR REPLACE PACKAGE FA_CICLOCLI_SP_PG
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "FA_CICLOCLI_SP_PG"
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




   PROCEDURE FA_INS_FA_CICLOCLI_PR (    Reg_Fa_CicloCli         IN         FA_CICLOCLI%ROWTYPE,
										SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento
							            );

   PROCEDURE FA_SEL_FA_CICLOCLI_PR (
   			 							EN_Cod_Cliente          IN         FA_CICLOCLI.COD_CLIENTE%TYPE,
										EN_Cod_Ciclo            IN   	   FA_CICLOCLI.COD_CICLO%TYPE,
										EN_Cod_Producto         IN 		   FA_CICLOCLI.COD_PRODUCTO%TYPE,
										EN_Num_Abonado			IN 		   FA_CICLOCLI.NUM_ABONADO%TYPE,
   			 							Reg_Fa_CicloCli         OUT NOCOPY FA_CICLOCLI%ROWTYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento);

   PROCEDURE FA_UPD_FA_CICLOCLI_PR (
   			 							EN_Cod_Cliente          IN         FA_CICLOCLI.COD_CLIENTE%TYPE,
										EN_Cod_Ciclo            IN 		   FA_CICLOCLI.COD_CICLO%TYPE,
										EN_Cod_Producto         IN 		   FA_CICLOCLI.COD_PRODUCTO%TYPE,
										EN_Num_Abonado			IN 		   FA_CICLOCLI.NUM_ABONADO%TYPE,
   			 							Reg_Fa_CicloCli         IN 		   FA_CICLOCLI%ROWTYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento);

   PROCEDURE FA_DEL_FA_CICLOCLI_PR (    EN_Cod_Cliente          IN         FA_CICLOCLI.COD_CLIENTE%TYPE,
										EN_Cod_Ciclo            IN 		   FA_CICLOCLI.COD_CICLO%TYPE,
										EN_Cod_Producto         IN 		   FA_CICLOCLI.COD_PRODUCTO%TYPE,
										EN_Num_Abonado			IN 		   FA_CICLOCLI.NUM_ABONADO%TYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento);




END FA_CICLOCLI_SP_PG;
/
SHOW ERROR