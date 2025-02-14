CREATE OR REPLACE PACKAGE GA_SERVICIOS_ARTPLAN_PG
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "GA_SERVICIOS_ARTPLAN_PG"
    Lenguaje="PL/SQL"
    Fecha="26-04-2005"
    Versión="1.0"
    Diseñador=""Christian Estay M."
    Programador="Christian Estay M."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package que agrupa un conjunto de servicios para la actualización del plan a tarvez del articulo XO-200508190402</Descripción>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/
IS
 SUBTYPE num_cel          IS         ga_aboamist.num_celular%TYPE;
 SUBTYPE cod_plan         IS         ta_plantarif.cod_plantarif%TYPE;
 CV_error_no_clasif       CONSTANT   VARCHAR2(30):='Error no clasificado';
 CN_largoquery			  CONSTANT   NUMBER:=3000;
 CN_largoerrtec			  CONSTANT   NUMBER:=500;
 CN_largodesc			  CONSTANT   NUMBER:=1000;
 CV_cod_modulo			  CONSTANT   ged_parametros.cod_modulo%TYPE:='GA';
 CV_actuacion			  CONSTANT   PV_ACTUAC_RESTRICCION.cod_actuacion%TYPE:='GG';
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_MOD_PLANARTI_PR (EN_num_celular       IN    ga_abocel.num_celular%TYPE,
						      SV_plan_actual      OUT    NOCOPY   ta_plantarif.cod_plantarif%TYPE,
							  SN_cod_retorno      OUT    NOCOPY   ge_errores_pg.CodError,
                              SV_mens_retorno     OUT    NOCOPY   ge_errores_pg.MsgError,
	                          SN_num_evento       OUT    NOCOPY   ge_errores_pg.Evento
                             );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CAMBPLANARTI_PR (EN_num_abonado       IN    ga_aboamist.num_abonado%TYPE,
		  					  EV_num_serie		   IN    ga_aboamist.num_serie%TYPE,
						      SV_plan_actual      OUT    NOCOPY   ta_plantarif.cod_plantarif%TYPE,
							  SN_cod_retorno      OUT    NOCOPY   ge_errores_pg.CodError,
                              SV_mens_retorno     OUT    NOCOPY   ge_errores_pg.MsgError,
							  SN_num_evento       OUT    NOCOPY   ge_errores_pg.Evento
                             );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END GA_SERVICIOS_ARTPLAN_PG;
/
SHOW ERRORS
