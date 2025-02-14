CREATE OR REPLACE PACKAGE GA_TRAFICO_PG
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "GA_TRAFICO_PG"
    Lenguaje="PL/SQL"
    Fecha="09-05-2005"
    Versión="1.0"
    Diseñador=""Fernando Garcia E."
    Programador="Jubitza Villanueva G."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package Capa de negocio Consultas TOL</Descripción>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/
IS
  CV_version	        	CONSTANT  VARCHAR2(10):='1.0';
  CV_error_no_clasif       	CONSTANT  VARCHAR2(30):='Error no clasificado';
  CV_separador          	CONSTANT  VARCHAR2(1):='|';
  TYPE refcursor 			IS REF CURSOR;
  CV_cod_modulo			    CONSTANT   ged_parametros.cod_modulo%TYPE:='GA';
  CV_actuacion			    CONSTANT   PV_ACTUAC_RESTRICCION.cod_actuacion%TYPE:='GG';
  CN_largoquery				CONSTANT   NUMBER:=3000;
  CN_largoerrtec			CONSTANT   NUMBER:=500;
  CN_largodesc				CONSTANT   NUMBER:=1000;
  SUBTYPE					Fecha_Tol_detfac IS tol_detfactura_00.DATE_START_CHARG%TYPE;
  CV_grupo_ff				CONSTANT   ged_parametros.nom_parametro%TYPE:='SYS_FF';
  CV_cod_producto_post	    CONSTANT   ged_parametros.cod_producto%TYPE:=1;
  CV_plan_especial          CONSTANT   ged_parametros.nom_parametro%TYPE:='PLAN_ESPECIAL1';
  CV_prod_postpago			CONSTANT   ged_codigos.cod_valor%TYPE:='2';

  GV_ParamOpero						   ged_parametros.val_parametro%TYPE;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_DET_LLAMADA_LDI_PR (EN_num_celular     IN           ga_abocel.num_celular%TYPE,
	                              SN_unidades   	 OUT NOCOPY   NUMBER,
				  				  SD_datem   		 OUT NOCOPY   DATE,
				  				  SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                                  SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                                  SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_DET_LLAMADA_FF_PR (EN_num_celular      IN           ga_abocel.num_celular%TYPE,
	                              SN_unidades   	 OUT NOCOPY   NUMBER,
				  				  SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                                  SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                                  SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_DET_FRANJA_PR    (EN_num_celular  IN           ga_abocel.num_celular%TYPE,
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
                				SV_mens_retorno OUT NOCOPY   ge_errores_pg.MsgError,
                                SN_num_evento   OUT NOCOPY   ge_errores_pg.Evento
                                );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END GA_TRAFICO_PG;
/
SHOW ERRORS
