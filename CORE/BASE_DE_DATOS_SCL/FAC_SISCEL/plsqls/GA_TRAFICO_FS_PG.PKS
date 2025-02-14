CREATE OR REPLACE PACKAGE GA_TRAFICO_FS_PG
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "GA_TRAFICO_FS_PG"
    Lenguaje="PL/SQL"
    Fecha="09-05-2005"
    Versión="1.0"
    Diseñador=""Fernando Garcia E."
    Programador="Jubitza Villanueva G."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package que agrupa un conjunto de servicios para la mascara servicios TOL</Descripción>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/
IS
  CV_version	     CONSTANT  VARCHAR2(10):='1.0';
  CV_error_no_clasif CONSTANT  varchar2(30):='Error no clasificado';
  TYPE refcursor     IS REF CURSOR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_DET_LLAMADA_LDI_FS_PR (EN_num_celular   IN         ga_abocel.num_celular%TYPE,
                                     SN_unidades      OUT NOCOPY NUMBER,
                            		 SD_datem   	  OUT NOCOPY DATE,
									 SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                              		 SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError
);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_DET_LLAMADA_FF_FS_PR(EN_num_celular   IN         ga_abocel.num_celular%TYPE,
                                   SN_unidades      OUT NOCOPY NUMBER,
				   				   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
				   				   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError
);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_DET_FRANJA_FS_PR (EN_num_celular  IN           ga_abocel.num_celular%TYPE,
                				SC_min_hor	    OUT NOCOPY   refcursor,
                				SC_min_tip_dia  OUT NOCOPY   refcursor,
                				SN_plan_min_lib OUT NOCOPY   NUMBER,
                				SN_usado	  	OUT NOCOPY   NUMBER,
                				SN_nousado	  	OUT NOCOPY   NUMBER,
                				SD_fec_corte	OUT NOCOPY   DATE,
                				SN_ind_planesp	OUT NOCOPY   NUMBER,
                				SN_valor		OUT NOCOPY   NUMBER,
                				SN_Bs2bs		OUT NOCOPY   NUMBER,
                				SC_min_planesp	OUT NOCOPY   refcursor,
                				SN_cod_retorno  OUT NOCOPY   ge_errores_pg.CodError,
                				SV_mens_retorno OUT NOCOPY   ge_errores_pg.MsgError
);
END GA_TRAFICO_FS_PG;
/
SHOW ERRORS
