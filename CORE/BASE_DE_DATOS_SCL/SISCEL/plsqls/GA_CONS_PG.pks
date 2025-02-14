CREATE OR REPLACE PACKAGE GA_CONS_PG
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "GA_CONS_PG."
    Lenguaje="PL/SQL"
    Fecha="02-05-2005"
    Versión="1.0"
    Diseñador="AAA"
    Programador="SSSS"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Consulta de abonados....</Descripción>
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
  CV_abonado_en_baja		CONSTANT  ga_abocel.cod_situacion%TYPE:='BAA';
  CV_cod_modulo			    CONSTANT  ged_parametros.cod_modulo%TYPE:='GA';
  CN_largoquery				CONSTANT  NUMBER:=3000;
  CN_largoerrtec			CONSTANT  NUMBER:=500;
  CN_largodesc				CONSTANT  NUMBER:=1000;
  TYPE refcursor 			IS REF CURSOR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_valida_formato_fecha_FN (
   EV_formato_fec     IN      VARCHAR2,
   SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_valida_existabonado_fn (
   EN_num_celular   IN           ga_abocel.num_celular%TYPE,
   SN_num_abonado   OUT NOCOPY   ga_abocel.num_abonado%TYPE,
   SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento,
   SV_comportamiento IN VARCHAR2 DEFAULT 'NO') RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_cons_facturas_pr (
      EN_num_celular     IN  ga_abocel.num_celular%TYPE,
      EV_formato_fec     IN  VARCHAR2,
      EN_cantfacturas    IN  NUMBER,
      SC_fact_clie       OUT NOCOPY   refcursor,
      SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
      SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
      SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END GA_CONS_PG;
/
SHOW ERRORS
