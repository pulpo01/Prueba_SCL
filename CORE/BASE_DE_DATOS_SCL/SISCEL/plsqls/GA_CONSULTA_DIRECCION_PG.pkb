CREATE OR REPLACE PACKAGE BODY ga_consulta_direccion_pg

AS

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_direccion_pr(
                               EN_num_celular     IN  ga_abocel.num_celular%TYPE,
                               EN_cod_tipdir      IN  ge_tipdireccion.cod_tipdireccion%TYPE,
                               SV_des_tipdir      OUT NOCOPY ge_tipdireccion.des_tipdireccion%TYPE,
                               SV_nom_calle       OUT NOCOPY ge_direcciones.nom_calle%TYPE,
                               SV_num_calle       OUT NOCOPY ge_direcciones.num_calle%TYPE,
                               SV_num_piso        OUT NOCOPY ge_direcciones.num_piso%TYPE,
                               SV_cod_region      OUT NOCOPY ge_direcciones.cod_region%TYPE,
                               SV_des_region      OUT NOCOPY ge_regiones.des_region%TYPE,
                               SV_cod_provincia   OUT NOCOPY ge_direcciones.cod_provincia%TYPE,
                               SV_des_provincia   OUT NOCOPY ge_provincias.des_provincia%TYPE,
                               SV_cod_ciudad      OUT NOCOPY ge_direcciones.cod_ciudad%TYPE,
                               SV_des_ciudad      OUT NOCOPY ge_ciudades.des_ciudad%TYPE,
                               SV_cod_comuna      OUT NOCOPY ge_direcciones.cod_comuna%TYPE,
                               SV_des_comuna      OUT NOCOPY ge_comunas.des_comuna%TYPE,
                               SV_cod_postal      OUT NOCOPY ge_direcciones.zip%TYPE,
                               SV_observacion     OUT NOCOPY ge_direcciones.obs_direccion%TYPE,
                               SV_des_dir1        OUT NOCOPY ge_direcciones.des_direc1%TYPE,
                               SV_des_dir2        OUT NOCOPY ge_direcciones.des_direc2%TYPE,
                               SN_cod_cliente     OUT NOCOPY ge_clientes.cod_cliente%TYPE,
                               SV_nom_cliente     OUT NOCOPY VARCHAR2,
                               SV_cod_tecnologia  OUT NOCOPY ga_abocel.cod_tecnologia%TYPE,
                               SD_fec_activ       OUT NOCOPY ga_abocel.fec_activacion%TYPE,
                               SN_cod_retorno     OUT NOCOPY  ge_errores_pg.CodError,
                               SV_mens_retorno    OUT NOCOPY  ge_errores_pg.MsgError,
                               SN_num_evento      OUT NOCOPY  ge_errores_pg.Evento
) IS
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_DIRECCION_PR"
      Lenguaje="PL/SQL"
      Fecha="06-06-2005"
      Versión="1.0"
      Diseñador=""Oscar Jorquera"
      Programador="Oscar Jorquera"
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripción>Capa de negocio Consulta la dirección dependiendo de un número celular y el código tipo de dirección</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SV_des_tipdir" Tipo="Varchar">descripción del tipo de dirección</param>
            <param nom="SV_nom_calle" Tipo="Varchar">nombre de la calle</param>
            <param nom="SV_num_calle" Tipo="NUMERICO">Número de la calle</param>
            <param nom="SV_num_piso" Tipo="NUMERICO">Número de Piso</param>
            <param nom="SV_cod_region" Tipo="Varchar">Código de región</param>
            <param nom="SV_des_region"  Tipo="VARCHAR">descripción de la región</param>
            <param nom="SV_cod_provincia" Tipo="VARCHAR">Código de la Provincia</param>
            <param nom="SV_des_provincia" Tipo="VARCHAR">Descripción de la Provincia</param>
            <param nom="SV_cod_ciudad"  Tipo="VARCHAR">Código de Ciudad</param>
            <param nom="SV_des_ciudad" Tipo="VARCHAR">Descripción de la ciudad</param>
            <param nom="SV_cod_comuna" Tipo="VARCHAR">Codigo de Comuna</param>
            <param nom="SV_des_comuna"  Tipo="VARCHAR" >Descripción de la Comuna</param>
            <param nom="SV_cod_postal"  Tipo="VARCHAR" >Código Postal</param>
            <param nom="SV_observacion"  Tipo="VARCHAR" >Observación</param>
            <param nom="SV_des_dir1"  Tipo="VARCHAR" >Descripción Dirección 1</param>
            <param nom="SV_des_dir2"  Tipo="VARCHAR" >Descripción Dirección 2</param>
            <param nom="SN_cod_cliente"  Tipo="NUMERICO" >Código Cliente</param>
            <param nom="SV_nom_cliente"  Tipo="VARCHAR" >Nombre Cliente</param>
            <param nom="SV_cod_tecnologia"  Tipo="VARCHAR" >Código de Tecnología</param>
            <param nom="SV_cod_tecnologia"  Tipo="VARCHAR" >Código de Tecnología</param>
            <param nom="SD_fec_activ"  Tipo="DATE" >Fecha de Activación</param>
            <param nom="SN_cod_retorno"  Tipo="VARCHAR" >Código de Retorno (descripción de error)</param>
            <param nom="sv_mens_retorno"  Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento"  Tipo="NUMERICO" >Número de Evento</param>
       </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

SN_cod_dir             ge_direcciones.cod_direccion%TYPE;
EN_cod_dir             ge_direcciones.cod_direccion%TYPE;
LV_cod_producto        ga_abocel.cod_producto%TYPE;
LV_nom_responsable     ga_cuentas.nom_responsable%TYPE;
LV_cod_estado          ga_abocel.cod_estado%TYPE;
LV_des_retorno         VARCHAR2(2000);
LV_contador            NUMBER;

tipdir_no_enc          EXCEPTION;
error_carga_datoscli   EXCEPTION;
error_obtdirec_cli     EXCEPTION;
error_obtdesdirec_cli  EXCEPTION;
num_cel_no_enc         EXCEPTION;
error_noaplica_prepago EXCEPTION;

LV_sSql                ge_errores_pg.vQuery;

BEGIN
   SN_num_evento   := 0;
   SN_cod_retorno  := 0;
   SV_mens_retorno := '';

   IF EN_num_celular IS NULL or EN_num_celular <= 0 THEN
      RAISE num_cel_no_enc;
   END IF;

   IF EN_cod_tipdir IS NULL or EN_cod_tipdir <= 0 THEN
      RAISE tipdir_no_enc;
   END IF;

   LV_sSql := 'SELECT COUNT(1)';
   LV_sSql := LV_sSql ||'INTO LV_contador ';
   LV_sSql := LV_sSql ||'FROM ge_tipdireccion a ';
   LV_sSql := LV_sSql ||'WHERE a.cod_tipdireccion='||EN_cod_tipdir;

   SELECT COUNT(1)
   INTO   LV_contador
   FROM   ge_tipdireccion a
   WHERE  a.cod_tipdireccion = EN_cod_tipdir;

   IF LV_contador =0 THEN
      RAISE tipdir_no_enc;
   END IF;

   IF NOT ga_segmentacion_pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, SN_cod_cliente, SV_nom_cliente, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave, GV_tip_plantarif, GV_cod_plantarif, SV_cod_tecnologia, GV_cod_perfil,
                                                  GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei, GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, LV_cod_estado,
                                                  LV_cod_producto, LV_nom_responsable, GV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento ) THEN
      RAISE error_carga_datoscli;
   END IF;

   IF GV_tip_abonado = 1 THEN --Prepago
      RAISE error_noaplica_prepago;
   END IF;

   LV_sSql := 'SELECT fec_activacion'
           || ' INTO SD_fec_activ'
           || ' FROM ga_abocel'
           || ' WHERE num_abonado = '||GN_num_abonado;

   SELECT fec_activacion
     INTO SD_fec_activ
     FROM ga_abocel
    WHERE num_abonado = GN_num_abonado;

   ga_obtiene_direccli_pr(SN_cod_cliente, EN_cod_tipdir, SN_cod_dir, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

   IF SN_cod_retorno <> 0 THEN
      RAISE error_obtdirec_cli;
   END IF;

   EN_cod_dir := SN_cod_dir;

   ga_obtiene_desdirec_pr(EN_cod_dir, EN_cod_tipdir, SV_nom_calle, SV_num_calle, SV_num_piso, SV_cod_region, SV_des_region, SV_cod_provincia, SV_des_provincia, SV_cod_ciudad, SV_des_ciudad, SV_cod_comuna, SV_des_comuna, SV_cod_postal, SV_observacion, SV_des_dir1,
                          SV_des_dir2, SV_des_tipdir, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

      IF SN_cod_retorno <> 0 THEN
         RAISE error_obtdesdirec_cli;
      END IF;

EXCEPTION

   WHEN num_cel_no_enc THEN
        SN_cod_retorno:=142;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno, SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_retorno := SUBSTR('ga_consulta_direccion_pr('||EN_num_celular||','||EN_cod_tipdir||'); - ' || SQLERRM,1,CN_largoerrtec);
        SV_mens_retorno:= SUBSTR(SV_mens_retorno,1,CN_largodesc);
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||','||CV_subversion, USER, 'ga_consulta_direccion_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

   WHEN tipdir_no_enc THEN
        SN_cod_retorno:=149;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_retorno := SUBSTR('ga_consulta_direccion_pr('||EN_num_celular||','||EN_cod_tipdir||'); - ' || SQLERRM,1,CN_largoerrtec);
        SV_mens_retorno:= SUBSTR(SV_mens_retorno,1,CN_largodesc);
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_consulta_direccion_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

   WHEN error_carga_datoscli THEN
        LV_des_retorno := SUBSTR('ga_consulta_direccion_pr('||EN_num_celular||','||EN_cod_tipdir||'); - ' || SQLERRM,1,CN_largoerrtec);
        SV_mens_retorno:= SUBSTR(SV_mens_retorno,1,CN_largodesc);
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_consulta_direccion_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

   WHEN error_noaplica_prepago THEN
        SN_cod_retorno:=314;      -- Incorporar código correcto
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_retorno := SUBSTR('ga_consulta_direccion_pr('||EN_num_celular||','||EN_cod_tipdir||'); - ' || SQLERRM,1,CN_largoerrtec);
        SV_mens_retorno:= SUBSTR(SV_mens_retorno,1,CN_largodesc);
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_consulta_direccion_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

   WHEN error_obtdirec_cli THEN
        LV_des_retorno := SUBSTR('ga_consulta_direccion_pr('||EN_num_celular||','||EN_cod_tipdir||'); - ' || SQLERRM,1,CN_largoerrtec);
        SV_mens_retorno:= SUBSTR(SV_mens_retorno,1,CN_largodesc);
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_consulta_direccion_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

   WHEN error_obtdesdirec_cli THEN
        LV_des_retorno :=SUBSTR('ga_consulta_direccion_pr('||EN_num_celular||','||EN_cod_tipdir||'); - ' || SQLERRM,1,CN_largoerrtec);
        SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_consulta_direccion_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

   WHEN OTHERS THEN
       SN_cod_retorno  := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_retorno  :=SUBSTR('ga_consulta_direccion_pr('||EN_num_celular||','||EN_cod_tipdir||'); - ' || SQLERRM,1,CN_largoerrtec);
       SV_mens_retorno :=SUBSTR(SV_mens_retorno,1,CN_largodesc);
       SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_consulta_direccion_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

END ga_consulta_direccion_pr;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ga_consulta_direcfact_pr(
                                EN_num_celular     IN  ga_abocel.num_celular%TYPE,
                                SV_des_tipdir      OUT NOCOPY ge_tipdireccion.des_tipdireccion%TYPE,
                                SV_nom_calle       OUT NOCOPY ge_direcciones.nom_calle%TYPE,
                                SV_num_calle       OUT NOCOPY ge_direcciones.num_calle%TYPE,
                                SV_num_piso        OUT NOCOPY ge_direcciones.num_piso%TYPE,
                                SV_cod_region      OUT NOCOPY ge_direcciones.cod_region%TYPE,
                                SV_des_region      OUT NOCOPY ge_regiones.des_region%TYPE,
                                SV_cod_provincia   OUT NOCOPY ge_direcciones.cod_provincia%TYPE,
                                SV_des_provincia   OUT NOCOPY ge_provincias.des_provincia%TYPE,
                                SV_cod_ciudad      OUT NOCOPY ge_direcciones.cod_ciudad%TYPE,
                                SV_des_ciudad      OUT NOCOPY ge_ciudades.des_ciudad%TYPE,
                                SV_cod_comuna      OUT NOCOPY ge_direcciones.cod_comuna%TYPE,
                                SV_des_comuna      OUT NOCOPY ge_comunas.des_comuna%TYPE,
                                SV_cod_postal      OUT NOCOPY ge_direcciones.zip%TYPE,
                                SV_observacion     OUT NOCOPY ge_direcciones.obs_direccion%TYPE,
                                SV_des_dir1        OUT NOCOPY ge_direcciones.des_direc1%TYPE,
                                SV_des_dir2        OUT NOCOPY ge_direcciones.des_direc2%TYPE,
                                SN_cod_cliente     OUT NOCOPY ge_clientes.cod_cliente%TYPE,
                                SV_nom_cliente     OUT NOCOPY VARCHAR2,
                                SV_cod_tecnologia  OUT NOCOPY ga_abocel.cod_tecnologia%TYPE,
                                SD_fec_activ       OUT NOCOPY ga_abocel.fec_activacion%TYPE,
                                SN_cod_retorno     OUT NOCOPY  ge_errores_pg.CodError,
                                SV_mens_retorno    OUT NOCOPY  ge_errores_pg.MsgError,
                                SN_num_evento      OUT NOCOPY  ge_errores_pg.Evento )
IS
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_DIRECFACT_PR"
      Lenguaje="PL/SQL"
      Fecha="06-06-2005"
      Versión="1.0"
      Diseñador=""Oscar Jorquera"
      Programador="Oscar Jorquera"
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripción>Capa de negocio Consulta la dirección dependiendo de un número celular y el código tipo de dirección</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SV_des_tipdir" Tipo="Varchar">descripción del tipo de dirección</param>
            <param nom="SV_nom_calle" Tipo="Varchar">nombre de la calle</param>
            <param nom="SV_num_calle" Tipo="NUMERICO">Número de la calle</param>
            <param nom="SV_num_piso" Tipo="NUMERICO">Número de Piso</param>
            <param nom="SV_cod_region" Tipo="Varchar">Código de región</param>
            <param nom="SV_des_region"  Tipo="VARCHAR">descripción de la región</param>
            <param nom="SV_cod_provincia" Tipo="VARCHAR">Código de la Provincia</param>
            <param nom="SV_des_provincia" Tipo="VARCHAR">Descripción de la Provincia</param>
            <param nom="SV_cod_ciudad"  Tipo="VARCHAR">Código de Ciudad</param>
            <param nom="SV_des_ciudad" Tipo="VARCHAR">Descripción de la ciudad</param>
            <param nom="SV_cod_comuna" Tipo="VARCHAR">Codigo de Comuna</param>
            <param nom="SV_des_comuna"  Tipo="VARCHAR" >Descripción de la Comuna</param>
            <param nom="SV_cod_postal"  Tipo="VARCHAR" >Código Postal</param>
            <param nom="SV_observacion"  Tipo="VARCHAR" >Observación</param>
            <param nom="SV_des_dir1"  Tipo="VARCHAR" >Descripción Dirección 1</param>
            <param nom="SV_des_dir2"  Tipo="VARCHAR" >Descripción Dirección 2</param>
            <param nom="SN_cod_cliente"  Tipo="NUMERICO" >Código Cliente</param>
            <param nom="SV_nom_cliente"  Tipo="VARCHAR" >Nombre Cliente</param>
            <param nom="SV_cod_tecnologia"  Tipo="VARCHAR" >Código de Tecnología</param>
            <param nom="SV_cod_tecnologia"  Tipo="VARCHAR" >Código de Tecnología</param>
            <param nom="SD_fec_activ"  Tipo="DATE" >Fecha de Activación</param>
            <param nom="SN_cod_retorno"  Tipo="VARCHAR" >Código de Retorno (descripción de error)</param>
            <param nom="sv_mens_retorno"  Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento"  Tipo="NUMERICO" >Número de Evento</param>
       </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
error_ejecucion	   EXCEPTION;
LN_cod_atencion    ci_atencion_clientes.cod_atencion%TYPE;

LV_des_error 	 ge_errores_pg.DesEvent;
LV_sSql        	 ge_errores_pg.vQuery;

BEGIN

   SN_num_evento   := 0;
   SN_cod_retorno  := 0;
   SV_mens_retorno := '';
   LN_cod_atencion := 513;

   ga_consulta_direccion_pr(EN_num_celular, CV_cod_tipdireccion, SV_des_tipdir, SV_nom_calle,
                            SV_num_calle, SV_num_piso, SV_cod_region, SV_des_region, SV_cod_provincia,
                            SV_des_provincia, SV_cod_ciudad, SV_des_ciudad, SV_cod_comuna,
                            SV_des_comuna, SV_cod_postal, SV_observacion, SV_des_dir1,
                            SV_des_dir2, SN_cod_cliente, SV_nom_cliente, SV_cod_tecnologia,
                            SD_fec_activ, SN_cod_retorno, SV_mens_retorno, SN_num_evento );

   IF SN_cod_retorno <> 0 THEN
	    RAISE error_ejecucion;
   END IF;

   ga_segmentacion_pg.ga_reg_atencion_cliente_pr
   						(EN_num_celular, LN_cod_atencion, CV_mens_atendio,
						 CV_nom_usuario, SN_cod_retorno , SV_mens_retorno, SN_num_evento );
   IF SN_cod_retorno <> 0 THEN
	    RAISE error_ejecucion;
   END IF;

EXCEPTION
     WHEN error_ejecucion THEN
		  LV_des_error := 'ga_consulta_direcfact_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_direcfact_pr', LV_sSql, SN_cod_retorno, LV_des_error );


END ga_consulta_direcfact_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ga_obtiene_direccli_pr(EN_codcliente   IN ge_clientes.cod_cliente%TYPE,
                                 EV_tipdireccion IN ge_tipdireccion.cod_tipdireccion%TYPE,
                                 SN_coddireccion OUT NOCOPY ge_direcciones.cod_direccion%TYPE,
                                 SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS

/*
   <Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "ga_obtiene_direccli_pr"
      Lenguaje="PL/SQL"
      Fecha="06-06-2005"
      Versión="1.0"
      Diseñador=""ROBERTO PEREZ VARAS"
      Programador="Oscar Jorquera"
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripción>Capa de negocio Obtiene el código de dirección del cliente dependiendo del código de cliente y el tipo de dirección</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
            <param nom="EV_tipdireccion" Tipo="VARCHAR>tipo de dirección</param>
         </Entrada>
         <Salida>
            <param nom="SN_coddireccion" Tipo="NUMERICO">Código de dirección</param>
            <param nom="SN_cod_retorno"  Tipo="VARCHAR" >Código de Retorno (descripción de error)</param>
            <param nom="sv_mens_retorno"  Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento"  Tipo="NUMERICO" >Número de Evento</param>
       </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_cod_cliente    ge_clientes.cod_cliente%TYPE;
LV_tipdireccion   ge_tipdireccion.cod_tipdireccion%TYPE;
LN_cod_direccion  ge_direcciones.cod_direccion%TYPE;
LN_cod_error      NUMBER;
LV_des_retorno    VARCHAR2(2000);

LV_sSql           ge_errores_pg.vQuery;

cod_cli_no_val    EXCEPTION;
error_ejecucion   EXCEPTION;

BEGIN
   SN_num_evento   := 0;
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;

   LV_cod_cliente  := EN_codcliente;
   LV_tipdireccion := EV_tipdireccion;

   IF LV_cod_cliente IS NULL THEN
      RAISE cod_cli_no_val;
   END IF;

   LV_sSql := 'SELECT cod_direccion ';
   LV_sSql := LV_sSql ||'INTO   LN_cod_direccion ';
   LV_sSql := LV_sSql ||'FROM   ga_direccli ';
   LV_sSql := LV_sSql ||'WHERE  cod_cliente=LV_cod_cliente ';
   LV_sSql := LV_sSql ||'   AND cod_tipdireccion=LV_tipdireccion';

   SELECT dire.cod_direccion
   INTO   LN_cod_direccion
   FROM   ga_direccli dire
   WHERE  dire.cod_cliente      = LV_cod_cliente
   AND 	  dire.cod_tipdireccion = LV_tipdireccion;

   SN_coddireccion:= LN_cod_direccion;

EXCEPTION
    WHEN cod_cli_no_val THEN
        SN_cod_retorno := 145 ;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_retorno :=SUBSTR('ga_obtiene_direccli_pr('||EN_codcliente||','||EV_tipdireccion||'); - ' || SQLERRM,1,CN_largoerrtec);
        SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_obtiene_direccli_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

   WHEN NO_DATA_FOUND THEN
        SN_cod_retorno := 275;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_retorno :=SUBSTR('cod_dir_no_enc: ga_obtiene_direccli_pr('||EN_codcliente||','||EV_tipdireccion||'); - ' || SQLERRM,1,CN_largoerrtec);
        SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_obtiene_direccli_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

   WHEN OTHERS THEN
        SN_cod_retorno := '156';
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_retorno :=SUBSTR('ga_obtiene_direccli_pr('||EN_codcliente||','||EV_tipdireccion||'); - ' || SQLERRM,1,CN_largoerrtec);
        SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_obtiene_direccli_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

END ga_obtiene_direccli_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ga_obtiene_desdirec_pr( EN_cod_direccion   IN ge_direcciones.cod_direccion%TYPE,
                                  EN_cod_tipdirec    IN ge_tipdireccion.cod_tipdireccion%TYPE,
                                  SV_nom_calle       OUT NOCOPY ge_direcciones.nom_calle%TYPE,
                                  SV_num_calle       OUT NOCOPY ge_direcciones.num_calle%TYPE,
                                  SV_num_piso        OUT NOCOPY ge_direcciones.num_piso%TYPE,
                                  SN_cod_region      OUT NOCOPY ge_direcciones.cod_region%TYPE,
                                  SV_des_region      OUT NOCOPY ge_regiones.des_region%TYPE,
                                  SN_cod_provincia   OUT NOCOPY ge_direcciones.cod_provincia%TYPE,
                                  SV_des_provincia   OUT NOCOPY ge_provincias.des_provincia%TYPE,
                                  SN_cod_ciudad      OUT NOCOPY ge_direcciones.cod_ciudad%TYPE,
                                  SV_des_ciudad      OUT NOCOPY ge_ciudades.des_ciudad%TYPE,
                                  SN_cod_comuna      OUT NOCOPY ge_direcciones.cod_comuna%TYPE,
                                  SV_des_comuna      OUT NOCOPY ge_comunas.des_comuna%TYPE,
                                  SV_cod_postal      OUT NOCOPY ge_direcciones.zip%TYPE,
                                  SV_observacion    OUT NOCOPY ge_direcciones.obs_direccion%TYPE,
                                  SV_des_direcc1     OUT NOCOPY ge_direcciones.des_direc1%TYPE,
                                  SV_des_direcc2     OUT NOCOPY ge_direcciones.des_direc2%TYPE,
                                  SV_des_tipdirec    OUT NOCOPY ge_tipdireccion.des_tipdireccion%TYPE,
                                  SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "ga_obtiene_desdirec_pr"
      Lenguaje="PL/SQL"
      Fecha="06-06-2005"
      Versión="1.0"
      Diseñador=""ROBERTO PEREZ VARAS"
      Programador="Oscar Jorquera"
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripción>Obtiene el código de dirección del cliente dependiendo del código de cliente y el tipo de dirección</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_direccion" Tipo="NUMERICO">Código de dirección</param>
         <param nom="EN_cod_tipdirec" Tipo="VARCHAR>Código tipo de dirección</param>
         </Entrada>
         <Salida>
            <param nom="SV_nom_calle" Tipo="VARCHAR">Nombre Calle</param>
            <param nom="SV_num_calle" Tipo="NUMERICO">Número Calle</param>
            <param nom="SV_num_piso" Tipo="VARCHAR">Número Piso</param>
            <param nom="SN_cod_region" Tipo="NUMERICO">Código Región</param>
            <param nom="SV_des_region" Tipo="VARCHAR">Descripción Región</param>
            <param nom="SN_cod_provincia" Tipo="NUMERICO>Código Provincia</param>
            <param nom="SV_des_provincia" Tipo="VARCHAR">Descripción Provincia</param>
            <param nom="SN_cod_ciudad" Tipo="NUMERICO">Código Ciudad</param>
            <param nom="SV_des_ciudad" Tipo="VARCHAR">Código Ciudad</param>
            <param nom="SN_cod_comuna" Tipo="NUMERICO">Código Comuna</param>
            <param nom="SV_des_comuna" Tipo="VARCHAR">Descripción Comuna</param>
            <param nom="SV_cod_postal" Tipo="VARCHAR">Código Postal</param>
            <param nom="SV_observacion" Tipo="VARCHAR">Observacion</param>
            <param nom="SV_des_direcc1" Tipo="VARCHAR">dirección 1</param>
            <param nom="SV_des_direcc2" Tipo="VARCHAR">dirección 2</param>
            <param nom="SV_des_tipdirec" Tipo="VARCHAR">Descripción Tipo dirección</param>
            <param nom="SV_des_tipdirec" Tipo="VARCHAR">Descripción Tipo dirección</param>
            <param nom="SN_cod_retorno"  Tipo="VARCHAR" >Código de Retorno (descripción de error)</param>
            <param nom="sv_mens_retorno"  Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento"  Tipo="NUMERICO" >Número de Evento</param>
       </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_codoperadora   ge_operadora_scl_local.cod_operadora_scl%TYPE;
LV_nom_column     ge_paramdir.NOM_COLUMN%TYPE;
LV_campos         VARCHAR2(256);
LV_cod_paramdir   ge_paramdir.cod_paramdir%TYPE;
LV_casilla        ge_direcciones.num_casilla%TYPE;
LV_pueblo         ge_direcciones.cod_pueblo%TYPE;
LV_estado         ge_direcciones.cod_estado%TYPE;
LV_sSql           ge_errores_pg.vQuery;
LV_relpos         VARCHAR2(64);
/*INICIO 185620 CSR 20062012- BRC
LV_valor1         VARCHAR2(64);
LV_valor2         VARCHAR2(64);
LV_valor3         VARCHAR2(64);
LV_valor4         VARCHAR2(64);
LV_valor5         VARCHAR2(64);
LV_valor6         VARCHAR2(64);
LV_valor7         VARCHAR2(64);
LV_valor8         VARCHAR2(255);
LV_valor9         VARCHAR2(255);
LV_valor10        VARCHAR2(255);
LV_valor11        VARCHAR2(64);
LV_valor12        VARCHAR2(64);
LV_valor13        VARCHAR2(64);
LV_valor14        VARCHAR2(64);
*/

LV_valor1         ge_direcciones.cod_region%TYPE;
LV_valor2         ge_direcciones.cod_provincia%TYPE;
LV_valor3         ge_direcciones.cod_ciudad%TYPE;
LV_valor4         ge_direcciones.cod_comuna%TYPE;
LV_valor5         ge_direcciones.nom_calle%TYPE;
LV_valor6         ge_direcciones.num_calle%TYPE;
LV_valor7         ge_direcciones.obs_direccion%TYPE;
LV_valor8         ge_direcciones.des_direc1%TYPE;
LV_valor9         ge_direcciones.zip%TYPE;
LV_valor10        ge_direcciones.cod_tipocalle%TYPE;
LV_valor11        VARCHAR2(64);
LV_valor12        VARCHAR2(64);
LV_valor13        VARCHAR2(64);
LV_valor14        VARCHAR2(64);



/*FIN  185620 CSR 20062012- BRC*/

LV_contador       NUMBER(2);
LV_des_retorno    VARCHAR2(2000);

cod_direc_no_valido           EXCEPTION;
error_no_cod_operadora        EXCEPTION;
cod_operadora_no_rec          EXCEPTION;
error_execute_no_data         EXCEPTION;
error_execute_too_many_rows   EXCEPTION;
error_no_region               EXCEPTION;
error_carga_region            EXCEPTION;
error_no_provincia            EXCEPTION;
error_carga_prov              EXCEPTION;
error_no_ciudad               EXCEPTION;
error_carga_ciudad            EXCEPTION;
error_no_comuna               EXCEPTION;
error_carga_comuna            EXCEPTION;
error_no_codtipdirec          EXCEPTION;
error_carga_codtipdirec       EXCEPTION;

CURSOR Cur_param_direccion IS
SELECT b.cod_paramdir, a.nom_column
   FROM  ge_paramdir a, ge_paramdiroperad b
   WHERE b.cod_operad = LV_codoperadora
     AND b.cod_paramdir = a.cod_paramdir;
/* Ejemplo
0	COD_REGION
1	COD_PROVINCIA
2	COD_CIUDAD
3	COD_COMUNA
4	NOM_CALLE
5	NUM_CALLE
6	NUM_PISO
8	OBS_DIRECCION
13	ZI
*/

BEGIN
   SN_num_evento    := 0;
   SN_cod_retorno   := 0;
   SV_mens_retorno  := '';

   LV_codoperadora:=NULL;
   LV_campos:=NULL;
   LV_cod_paramdir:=NULL;
   LV_relpos:=NULL;
   LV_valor1:=NULL;
   LV_valor2:=NULL;
   LV_valor3:=NULL;
   LV_valor4:=NULL;
   LV_valor5:=NULL;
   LV_valor6:=NULL;
   LV_valor7:=NULL;
   LV_valor8:=NULL;
   LV_valor9:=NULL;
   LV_valor10:=NULL;
   LV_valor11:=NULL;
   LV_valor12:=NULL;
   LV_valor13:=NULL;
   LV_valor14:=NULL;

   IF EN_cod_direccion IS NULL THEN
      RAISE cod_direc_no_valido;
   END IF;

   LV_sSql := 'SELECT cod_operadora_scl INTO LV_codoperadora FROM ge_operadora_scl_local';

   BEGIN
      LV_sSql := 'SELECT RTRIM(LTRIM(des_tipdireccion)) INTO SV_des_tipdirec ';
      LV_sSql := LV_sSql || ' FROM ge_tipdireccion ';
      LV_sSql := LV_sSql || ' WHERE  cod_tipdireccion='||EN_cod_tipdirec;

      SELECT cod_operadora_scl
         INTO LV_codoperadora
         FROM ge_operadora_scl_local;

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            RAISE error_no_cod_operadora;
   END;

   LV_contador:=0;
   OPEN Cur_param_direccion;
   LOOP
      FETCH Cur_param_direccion INTO LV_cod_paramdir, LV_nom_column;
      EXIT WHEN Cur_param_direccion%NOTFOUND;
         LV_campos:=LV_campos || LV_nom_column || ',';
         LV_relpos:=LV_relpos || LV_cod_paramdir || '^';
         LV_contador:=LV_contador+1;
   END LOOP;
   CLOSE Cur_param_direccion;
   LV_campos:=SUBSTR(LV_campos,1,LENGTH(LV_campos)-1);

   LV_ssql:='SELECT ' || LV_campos;
   LV_ssql:=LV_ssql || ' FROM ge_direcciones WHERE cod_direccion=' || EN_cod_direccion;

   BEGIN
       IF LV_contador=1 THEN
          EXECUTE IMMEDIATE LV_ssql INTO LV_valor1;
       ELSIF LV_contador=2 THEN
          EXECUTE IMMEDIATE LV_ssql INTO LV_valor1, LV_valor2;
       ELSIF LV_contador=3 THEN
          EXECUTE IMMEDIATE LV_ssql INTO LV_valor1, LV_valor2, LV_valor3;
       ELSIF LV_contador=4 THEN
          EXECUTE IMMEDIATE LV_ssql INTO LV_valor1, LV_valor2, LV_valor3, LV_valor4;
       ELSIF LV_contador=5 THEN
          EXECUTE IMMEDIATE LV_ssql INTO LV_valor1, LV_valor2, LV_valor3, LV_valor4, LV_valor5;
       ELSIF LV_contador=6 THEN
          EXECUTE IMMEDIATE LV_ssql INTO LV_valor1, LV_valor2, LV_valor3, LV_valor4, LV_valor5, LV_valor6;
       ELSIF LV_contador=7 THEN
          EXECUTE IMMEDIATE LV_ssql INTO LV_valor1, LV_valor2, LV_valor3, LV_valor4, LV_valor5, LV_valor6, LV_valor7;
       ELSIF LV_contador=8 THEN
          EXECUTE IMMEDIATE LV_ssql INTO LV_valor1, LV_valor2, LV_valor3, LV_valor4, LV_valor5, LV_valor6, LV_valor7, LV_valor8;
       ELSIF LV_contador=9 THEN
          EXECUTE IMMEDIATE LV_ssql INTO LV_valor1, LV_valor2, LV_valor3, LV_valor4, LV_valor5, LV_valor6, LV_valor7, LV_valor8, LV_valor9;
       ELSIF LV_contador=10 THEN
          EXECUTE IMMEDIATE LV_ssql INTO LV_valor1, LV_valor2, LV_valor3, LV_valor4, LV_valor5, LV_valor6, LV_valor7, LV_valor8, LV_valor9, LV_valor10;
       ELSIF   LV_contador=11 THEN
          EXECUTE IMMEDIATE LV_ssql INTO LV_valor1, LV_valor2, LV_valor3, LV_valor4, LV_valor5, LV_valor6, LV_valor7, LV_valor8, LV_valor9, LV_valor10, LV_valor11;
       ELSIF   LV_contador=12 THEN
          EXECUTE IMMEDIATE LV_ssql INTO LV_valor1, LV_valor2, LV_valor3, LV_valor4, LV_valor5, LV_valor6, LV_valor7, LV_valor8, LV_valor9, LV_valor10, LV_valor11, LV_valor12;
       ELSIF   LV_contador=13 THEN
          EXECUTE IMMEDIATE LV_ssql INTO LV_valor1, LV_valor2, LV_valor3, LV_valor4, LV_valor5, LV_valor6, LV_valor7, LV_valor8, LV_valor9, LV_valor10, LV_valor11, LV_valor12, LV_valor13;
       ELSIF   LV_contador=14 THEN
          EXECUTE IMMEDIATE LV_ssql INTO LV_valor1, LV_valor2, LV_valor3, LV_valor4, LV_valor5, LV_valor6, LV_valor7, LV_valor8, LV_valor9, LV_valor10, LV_valor11, LV_valor12, LV_valor13, LV_valor14;
       END IF;

       EXCEPTION
          WHEN NO_DATA_FOUND THEN
             RAISE error_execute_no_data;
          WHEN TOO_MANY_ROWS THEN
             RAISE error_execute_too_many_rows;
   END;

   LV_cod_paramdir:=NULL;
   LV_contador:=1;
   LOOP  -- contador
      IF LV_relpos IS NULL THEN
         EXIT;
      END IF;
      LV_cod_paramdir:=SUBSTR(LV_relpos,1,INSTR(LV_relpos,'^')-1);
      LV_relpos:=SUBSTR(LV_relpos,INSTR(LV_relpos,'^')+1,LENGTH(LV_relpos));
      IF LV_contador=1 THEN
         IF LV_cod_paramdir='0' THEN
            SN_cod_region:=LV_valor1;
         ELSIF LV_cod_paramdir='1' THEN
            SN_cod_provincia:=LV_valor1;
         ELSIF LV_cod_paramdir='2' THEN
            SN_cod_ciudad:=LV_valor1;
         ELSIF LV_cod_paramdir='3' THEN
            SN_cod_comuna:=LV_valor1;
         ELSIF LV_cod_paramdir='4' THEN
            SV_nom_calle:=LV_valor1;
         ELSIF LV_cod_paramdir='5' THEN
            SV_num_calle:=LV_valor1;
         ELSIF LV_cod_paramdir='6' THEN
            SV_num_piso:=LV_valor1;
         ELSIF LV_cod_paramdir='7' THEN
            LV_casilla:=LV_valor1;
         ELSIF LV_cod_paramdir='8' THEN
            SV_observacion:=LV_valor1;
         ELSIF LV_cod_paramdir='9' THEN
            SV_des_direcc1:=LV_valor1;
         ELSIF LV_cod_paramdir='10' THEN
            SV_des_direcc2:=LV_valor1;
         ELSIF LV_cod_paramdir='11' THEN
            LV_pueblo:=LV_valor1;
         ELSIF LV_cod_paramdir='12' THEN
            LV_estado:=LV_valor1;
         ELSIF LV_cod_paramdir='13' THEN
            SV_cod_postal:=LV_valor1;
         END IF;
      ELSIF LV_contador=2 THEN
         IF LV_cod_paramdir='0' THEN
            SN_cod_region:=LV_valor2;
         ELSIF LV_cod_paramdir='1' THEN
            SN_cod_provincia:=LV_valor2;
         ELSIF LV_cod_paramdir='2' THEN
            SN_cod_ciudad:=LV_valor2;
         ELSIF LV_cod_paramdir='3' THEN
            SN_cod_comuna:=LV_valor2;
         ELSIF LV_cod_paramdir='4' THEN
            SV_nom_calle:=LV_valor2;
         ELSIF LV_cod_paramdir='5' THEN
            SV_num_calle:=LV_valor2;
         ELSIF LV_cod_paramdir='6' THEN
            SV_num_piso:=LV_valor2;
         ELSIF LV_cod_paramdir='7' THEN
            LV_casilla:=LV_valor2;
         ELSIF LV_cod_paramdir='8' THEN
            SV_observacion:=LV_valor2;
         ELSIF LV_cod_paramdir='9' THEN
            SV_des_direcc1:=LV_valor2;
         ELSIF LV_cod_paramdir='10' THEN
            SV_des_direcc2:=LV_valor2;
         ELSIF LV_cod_paramdir='11' THEN
            LV_pueblo:=LV_valor2;
         ELSIF LV_cod_paramdir='12' THEN
            LV_estado:=LV_valor2;
         ELSIF LV_cod_paramdir='13' THEN
            SV_cod_postal:=LV_valor2;
         END IF;
      ELSIF LV_contador=3 THEN
         IF LV_cod_paramdir='0' THEN
            SN_cod_region:=LV_valor3;
         ELSIF LV_cod_paramdir='1' THEN
            SN_cod_provincia:=LV_valor3;
         ELSIF LV_cod_paramdir='2' THEN
            SN_cod_ciudad:=LV_valor3;
         ELSIF LV_cod_paramdir='3' THEN
            SN_cod_comuna:=LV_valor3;
         ELSIF LV_cod_paramdir='4' THEN
            SV_nom_calle:=LV_valor3;
         ELSIF LV_cod_paramdir='5' THEN
            SV_num_calle:=LV_valor3;
         ELSIF LV_cod_paramdir='6' THEN
            SV_num_piso:=LV_valor3;
         ELSIF LV_cod_paramdir='7' THEN
            LV_casilla:=LV_valor3;
         ELSIF LV_cod_paramdir='8' THEN
            SV_observacion:=LV_valor3;
         ELSIF LV_cod_paramdir='9' THEN
            SV_des_direcc1:=LV_valor3;
         ELSIF LV_cod_paramdir='10' THEN
            SV_des_direcc2:=LV_valor3;
         ELSIF LV_cod_paramdir='11' THEN
            LV_pueblo:=LV_valor3;
         ELSIF LV_cod_paramdir='12' THEN
            LV_estado:=LV_valor3;
         ELSIF LV_cod_paramdir='13' THEN
            SV_cod_postal:=LV_valor3;
         END IF;
      ELSIF LV_contador=4 THEN
         IF LV_cod_paramdir='0' THEN
            SN_cod_region:=LV_valor4;
         ELSIF LV_cod_paramdir='1' THEN
            SN_cod_provincia:=LV_valor4;
         ELSIF LV_cod_paramdir='2' THEN
            SN_cod_ciudad:=LV_valor4;
         ELSIF LV_cod_paramdir='3' THEN
            SN_cod_comuna:=LV_valor4;
         ELSIF LV_cod_paramdir='4' THEN
            SV_nom_calle:=LV_valor4;
         ELSIF LV_cod_paramdir='5' THEN
            SV_num_calle:=LV_valor4;
         ELSIF LV_cod_paramdir='6' THEN
            SV_num_piso:=LV_valor4;
         ELSIF LV_cod_paramdir='7' THEN
            LV_casilla:=LV_valor4;
         ELSIF LV_cod_paramdir='8' THEN
            SV_observacion:=LV_valor4;
         ELSIF LV_cod_paramdir='9' THEN
            SV_des_direcc1:=LV_valor4;
         ELSIF LV_cod_paramdir='10' THEN
            SV_des_direcc2:=LV_valor4;
         ELSIF LV_cod_paramdir='11' THEN
            LV_pueblo:=LV_valor4;
         ELSIF LV_cod_paramdir='12' THEN
            LV_estado:=LV_valor4;
         ELSIF LV_cod_paramdir='13' THEN
            SV_cod_postal:=LV_valor4;
         END IF;
      ELSIF LV_contador=5 THEN
         IF LV_cod_paramdir='0' THEN
            SN_cod_region:=LV_valor5;
         ELSIF LV_cod_paramdir='1' THEN
            SN_cod_provincia:=LV_valor5;
         ELSIF LV_cod_paramdir='2' THEN
            SN_cod_ciudad:=LV_valor5;
         ELSIF LV_cod_paramdir='3' THEN
            SN_cod_comuna:=LV_valor5;
         ELSIF LV_cod_paramdir='4' THEN
            SV_nom_calle:=LV_valor5;
         ELSIF LV_cod_paramdir='5' THEN
            SV_num_calle:=LV_valor5;
         ELSIF LV_cod_paramdir='6' THEN
            SV_num_piso:=LV_valor5;
         ELSIF LV_cod_paramdir='7' THEN
            LV_casilla:=LV_valor5;
         ELSIF LV_cod_paramdir='8' THEN
            SV_observacion:=LV_valor5;
         ELSIF LV_cod_paramdir='9' THEN
            SV_des_direcc1:=LV_valor5;
         ELSIF LV_cod_paramdir='10' THEN
            SV_des_direcc2:=LV_valor5;
         ELSIF LV_cod_paramdir='11' THEN
            LV_pueblo:=LV_valor5;
         ELSIF LV_cod_paramdir='12' THEN
            LV_estado:=LV_valor5;
         ELSIF LV_cod_paramdir='13' THEN
            SV_cod_postal:=LV_valor5;
         END IF;
      ELSIF LV_contador=6 THEN
         IF LV_cod_paramdir='0' THEN
            SN_cod_region:=LV_valor6;
         ELSIF LV_cod_paramdir='1' THEN
            SN_cod_provincia:=LV_valor6;
         ELSIF LV_cod_paramdir='2' THEN
            SN_cod_ciudad:=LV_valor6;
         ELSIF LV_cod_paramdir='3' THEN
            SN_cod_comuna:=LV_valor6;
         ELSIF LV_cod_paramdir='4' THEN
            SV_nom_calle:=LV_valor6;
         ELSIF LV_cod_paramdir='5' THEN
            SV_num_calle:=LV_valor6;
         ELSIF LV_cod_paramdir='6' THEN
            SV_num_piso:=LV_valor6;
         ELSIF LV_cod_paramdir='7' THEN
            LV_casilla:=LV_valor6;
         ELSIF LV_cod_paramdir='8' THEN
            SV_observacion:=LV_valor6;
         ELSIF LV_cod_paramdir='9' THEN
            SV_des_direcc1:=LV_valor6;
         ELSIF LV_cod_paramdir='10' THEN
            SV_des_direcc2:=LV_valor6;
         ELSIF LV_cod_paramdir='11' THEN
            LV_pueblo:=LV_valor6;
         ELSIF LV_cod_paramdir='12' THEN
            LV_estado:=LV_valor6;
         ELSIF LV_cod_paramdir='13' THEN
            SV_cod_postal:=LV_valor6;
         END IF;
      ELSIF LV_contador=7 THEN
         IF LV_cod_paramdir='0' THEN
            SN_cod_region:=LV_valor7;
         ELSIF LV_cod_paramdir='1' THEN
            SN_cod_provincia:=LV_valor7;
         ELSIF LV_cod_paramdir='2' THEN
            SN_cod_ciudad:=LV_valor7;
         ELSIF LV_cod_paramdir='3' THEN
            SN_cod_comuna:=LV_valor7;
         ELSIF LV_cod_paramdir='4' THEN
            SV_nom_calle:=LV_valor7;
         ELSIF LV_cod_paramdir='5' THEN
            SV_num_calle:=LV_valor7;
         ELSIF LV_cod_paramdir='6' THEN
            SV_num_piso:=LV_valor7;
         ELSIF LV_cod_paramdir='7' THEN
            LV_casilla:=LV_valor7;
         ELSIF LV_cod_paramdir='8' THEN
            SV_observacion:=LV_valor7;
         ELSIF LV_cod_paramdir='9' THEN
            SV_des_direcc1:=LV_valor7;
         ELSIF LV_cod_paramdir='10' THEN
            SV_des_direcc2:=LV_valor7;
         ELSIF LV_cod_paramdir='11' THEN
            LV_pueblo:=LV_valor7;
         ELSIF LV_cod_paramdir='12' THEN
            LV_estado:=LV_valor7;
         ELSIF LV_cod_paramdir='13' THEN
            SV_cod_postal:=LV_valor7;
         END IF;
      ELSIF LV_contador=8 THEN
         IF LV_cod_paramdir='0' THEN
            SN_cod_region:=LV_valor8;
         ELSIF LV_cod_paramdir='1' THEN
            SN_cod_provincia:=LV_valor8;
         ELSIF LV_cod_paramdir='2' THEN
            SN_cod_ciudad:=LV_valor8;
         ELSIF LV_cod_paramdir='3' THEN
            SN_cod_comuna:=LV_valor8;
         ELSIF LV_cod_paramdir='4' THEN
            SV_nom_calle:=LV_valor8;
         ELSIF LV_cod_paramdir='5' THEN
            SV_num_calle:=LV_valor8;
         ELSIF LV_cod_paramdir='6' THEN
            SV_num_piso:=LV_valor8;
         ELSIF LV_cod_paramdir='7' THEN
            LV_casilla:=LV_valor8;
         ELSIF LV_cod_paramdir='8' THEN
            SV_observacion:=LV_valor8;
         ELSIF LV_cod_paramdir='9' THEN
            SV_des_direcc1:=LV_valor8;
         ELSIF LV_cod_paramdir='10' THEN
            SV_des_direcc2:=LV_valor8;
         ELSIF LV_cod_paramdir='11' THEN
            LV_pueblo:=LV_valor8;
         ELSIF LV_cod_paramdir='12' THEN
            LV_estado:=LV_valor8;
         ELSIF LV_cod_paramdir='13' THEN
            SV_cod_postal:=LV_valor8;
         END IF;
      ELSIF LV_contador=9 THEN
         IF LV_cod_paramdir='0' THEN
            SN_cod_region:=LV_valor9;
         ELSIF LV_cod_paramdir='1' THEN
            SN_cod_provincia:=LV_valor9;
         ELSIF LV_cod_paramdir='2' THEN
            SN_cod_ciudad:=LV_valor9;
         ELSIF LV_cod_paramdir='3' THEN
            SN_cod_comuna:=LV_valor9;
         ELSIF LV_cod_paramdir='4' THEN
            SV_nom_calle:=LV_valor9;
         ELSIF LV_cod_paramdir='5' THEN
            SV_num_calle:=LV_valor9;
         ELSIF LV_cod_paramdir='6' THEN
            SV_num_piso:=LV_valor9;
         ELSIF LV_cod_paramdir='7' THEN
            LV_casilla:=LV_valor9;
         ELSIF LV_cod_paramdir='8' THEN
            SV_observacion:=LV_valor9;
         ELSIF LV_cod_paramdir='9' THEN
            SV_des_direcc1:=LV_valor9;
         ELSIF LV_cod_paramdir='10' THEN
            SV_des_direcc2:=LV_valor9;
         ELSIF LV_cod_paramdir='11' THEN
            LV_pueblo:=LV_valor9;
         ELSIF LV_cod_paramdir='12' THEN
            LV_estado:=LV_valor9;
         ELSIF LV_cod_paramdir='13' THEN
            SV_cod_postal:=LV_valor9;
         END IF;
      ELSIF LV_contador=10 THEN
         IF LV_cod_paramdir='0' THEN
            SN_cod_region:=LV_valor10;
         ELSIF LV_cod_paramdir='1' THEN
            SN_cod_provincia:=LV_valor10;
         ELSIF LV_cod_paramdir='2' THEN
            SN_cod_ciudad:=LV_valor10;
         ELSIF LV_cod_paramdir='3' THEN
            SN_cod_comuna:=LV_valor10;
         ELSIF LV_cod_paramdir='4' THEN
            SV_nom_calle:=LV_valor10;
         ELSIF LV_cod_paramdir='5' THEN
            SV_num_calle:=LV_valor10;
         ELSIF LV_cod_paramdir='6' THEN
            SV_num_piso:=LV_valor10;
         ELSIF LV_cod_paramdir='7' THEN
            LV_casilla:=LV_valor10;
         ELSIF LV_cod_paramdir='8' THEN
            SV_observacion:=LV_valor10;
         ELSIF LV_cod_paramdir='9' THEN
            SV_des_direcc1:=LV_valor10;
         ELSIF LV_cod_paramdir='10' THEN
            SV_des_direcc2:=LV_valor10;
         ELSIF LV_cod_paramdir='11' THEN
            LV_pueblo:=LV_valor10;
         ELSIF LV_cod_paramdir='12' THEN
            LV_estado:=LV_valor10;
         ELSIF LV_cod_paramdir='13' THEN
            SV_cod_postal:=LV_valor10;
         END IF;
      ELSIF LV_contador=11 THEN
         IF LV_cod_paramdir='0' THEN
            SN_cod_region:=LV_valor11;
         ELSIF LV_cod_paramdir='1' THEN
            SN_cod_provincia:=LV_valor11;
         ELSIF LV_cod_paramdir='2' THEN
            SN_cod_ciudad:=LV_valor11;
         ELSIF LV_cod_paramdir='3' THEN
            SN_cod_comuna:=LV_valor11;
         ELSIF LV_cod_paramdir='4' THEN
            SV_nom_calle:=LV_valor11;
         ELSIF LV_cod_paramdir='5' THEN
            SV_num_calle:=LV_valor11;
         ELSIF LV_cod_paramdir='6' THEN
            SV_num_piso:=LV_valor11;
         ELSIF LV_cod_paramdir='7' THEN
            LV_casilla:=LV_valor11;
         ELSIF LV_cod_paramdir='8' THEN
            SV_observacion:=LV_valor11;
         ELSIF LV_cod_paramdir='9' THEN
            SV_des_direcc1:=LV_valor11;
         ELSIF LV_cod_paramdir='10' THEN
            SV_des_direcc2:=LV_valor11;
         ELSIF LV_cod_paramdir='11' THEN
            LV_pueblo:=LV_valor11;
         ELSIF LV_cod_paramdir='12' THEN
            LV_estado:=LV_valor11;
         ELSIF LV_cod_paramdir='13' THEN
            SV_cod_postal:=LV_valor11;
         END IF;
      ELSIF LV_contador=12 THEN
         IF LV_cod_paramdir='0' THEN
            SN_cod_region:=LV_valor12;
         ELSIF LV_cod_paramdir='1' THEN
            SN_cod_provincia:=LV_valor12;
         ELSIF LV_cod_paramdir='2' THEN
            SN_cod_ciudad:=LV_valor12;
         ELSIF LV_cod_paramdir='3' THEN
            SN_cod_comuna:=LV_valor12;
         ELSIF LV_cod_paramdir='4' THEN
            SV_nom_calle:=LV_valor12;
         ELSIF LV_cod_paramdir='5' THEN
            SV_num_calle:=LV_valor12;
         ELSIF LV_cod_paramdir='6' THEN
            SV_num_piso:=LV_valor12;
         ELSIF LV_cod_paramdir='7' THEN
            LV_casilla:=LV_valor12;
         ELSIF LV_cod_paramdir='8' THEN
            SV_observacion:=LV_valor12;
         ELSIF LV_cod_paramdir='9' THEN
            SV_des_direcc1:=LV_valor12;
         ELSIF LV_cod_paramdir='10' THEN
            SV_des_direcc2:=LV_valor12;
         ELSIF LV_cod_paramdir='11' THEN
            LV_pueblo:=LV_valor12;
         ELSIF LV_cod_paramdir='12' THEN
            LV_estado:=LV_valor12;
         ELSIF LV_cod_paramdir='13' THEN
            SV_cod_postal:=LV_valor12;
         END IF;
      ELSIF LV_contador=13 THEN
         IF LV_cod_paramdir='0' THEN
            SN_cod_region:=LV_valor13;
         ELSIF LV_cod_paramdir='1' THEN
            SN_cod_provincia:=LV_valor13;
         ELSIF LV_cod_paramdir='2' THEN
            SN_cod_ciudad:=LV_valor13;
         ELSIF LV_cod_paramdir='3' THEN
            SN_cod_comuna:=LV_valor13;
         ELSIF LV_cod_paramdir='4' THEN
            SV_nom_calle:=LV_valor13;
         ELSIF LV_cod_paramdir='5' THEN
            SV_num_calle:=LV_valor13;
         ELSIF LV_cod_paramdir='6' THEN
            SV_num_piso:=LV_valor13;
         ELSIF LV_cod_paramdir='7' THEN
            LV_casilla:=LV_valor13;
         ELSIF LV_cod_paramdir='8' THEN
            SV_observacion:=LV_valor13;
         ELSIF LV_cod_paramdir='9' THEN
            SV_des_direcc1:=LV_valor13;
         ELSIF LV_cod_paramdir='10' THEN
            SV_des_direcc2:=LV_valor13;
         ELSIF LV_cod_paramdir='11' THEN
            LV_pueblo:=LV_valor13;
         ELSIF LV_cod_paramdir='12' THEN
            LV_estado:=LV_valor13;
         ELSIF LV_cod_paramdir='13' THEN
            SV_cod_postal:=LV_valor13;
         END IF;
      ELSIF LV_contador=14 THEN
         IF LV_cod_paramdir='0' THEN
            SN_cod_region:=LV_valor14;
         ELSIF LV_cod_paramdir='1' THEN
            SN_cod_provincia:=LV_valor14;
         ELSIF LV_cod_paramdir='2' THEN
            SN_cod_ciudad:=LV_valor14;
         ELSIF LV_cod_paramdir='3' THEN
            SN_cod_comuna:=LV_valor14;
         ELSIF LV_cod_paramdir='4' THEN
            SV_nom_calle:=LV_valor14;
         ELSIF LV_cod_paramdir='5' THEN
            SV_num_calle:=LV_valor14;
         ELSIF LV_cod_paramdir='6' THEN
            SV_num_piso:=LV_valor14;
         ELSIF LV_cod_paramdir='7' THEN
            LV_casilla:=LV_valor14;
         ELSIF LV_cod_paramdir='8' THEN
            SV_observacion:=LV_valor14;
         ELSIF LV_cod_paramdir='9' THEN
            SV_des_direcc1:=LV_valor14;
         ELSIF LV_cod_paramdir='10' THEN
            SV_des_direcc2:=LV_valor14;
         ELSIF LV_cod_paramdir='11' THEN
            LV_pueblo:=LV_valor14;
         ELSIF LV_cod_paramdir='12' THEN
            LV_estado:=LV_valor14;
         ELSIF LV_cod_paramdir='13' THEN
            SV_cod_postal:=LV_valor14;
         END IF;
      END IF;
      LV_contador:=LV_contador+1;
   END LOOP; --contador

   BEGIN
      IF SN_cod_region IS NOT NULL THEN
         LV_sSql := 'SELECT des_region INTO SV_des_region FROM ge_regiones ';
         LV_sSql := LV_sSql ||' WHERE  cod_region='||SN_cod_region;

         SELECT regi.des_region
         INTO 	SV_des_region
         FROM 	ge_regiones regi
         WHERE  regi.cod_region = SN_cod_region;
      ELSE
         RAISE error_no_region;
      END IF;

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            RAISE error_no_region;
   END;

   BEGIN
      IF SN_cod_provincia IS NOT NULL THEN
         LV_sSql := 'SELECT des_provincia INTO SV_des_provincia FROM ge_provincias ';
         LV_sSql := LV_sSql ||'WHERE  cod_provincia='||SN_cod_provincia;
         LV_sSql := LV_sSql ||' AND cod_region='||SN_cod_region;

         SELECT provi.des_provincia
         INTO   SV_des_provincia
         FROM   ge_provincias provi
         WHERE  provi.cod_provincia= SN_cod_provincia
         AND    provi.cod_region   = SN_cod_region;
      ELSE
         RAISE error_no_provincia;
      END IF;
          EXCEPTION
              WHEN NO_DATA_FOUND THEN
                RAISE error_no_provincia;
   END;

   BEGIN
      IF SN_cod_ciudad IS NOT NULL THEN
         LV_sSql := ' SELECT des_ciudad INTO SV_des_ciudad FROM ge_ciudades ';
         LV_sSql := LV_sSql ||' WHERE  cod_region='||SN_cod_region;
         LV_sSql := LV_sSql ||'   AND cod_provincia='||SN_cod_provincia;
         LV_sSql := LV_sSql ||' AND cod_ciudad='||SN_cod_ciudad;

         SELECT ciu.des_ciudad
         INTO   SV_des_ciudad
         FROM   ge_ciudades ciu
         WHERE  ciu.cod_region   = SN_cod_region
         AND    ciu.cod_provincia= SN_cod_provincia
         AND    ciu.cod_ciudad   = SN_cod_ciudad;
      ELSE
         RAISE error_no_ciudad;
      END IF;

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            RAISE error_no_ciudad;
   END;

   BEGIN
      IF SN_cod_comuna IS NOT NULL THEN

         LV_sSql := 'SELECT des_comuna INTO SV_des_comuna FROM ge_comunas ';
         LV_sSql := LV_sSql ||' WHERE  cod_region='||SN_cod_region;
         LV_sSql := LV_sSql ||' AND cod_provincia='||SN_cod_provincia;
         LV_sSql := LV_sSql ||' AND cod_comuna='||SN_cod_comuna;

         SELECT comu.des_comuna
         INTO 	SV_des_comuna
         FROM 	ge_comunas comu
         WHERE  comu.cod_region   = SN_cod_region
         AND 	comu.cod_provincia= SN_cod_provincia
         AND 	comu.cod_comuna   = SN_cod_comuna;
      ELSE
         RAISE error_no_comuna;
      END IF;

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            RAISE error_no_comuna;
   END;

   BEGIN
      IF EN_cod_tipdirec IS NOT NULL THEN
         LV_sSql := 'SELECT RTRIM(LTRIM(des_tipdireccion)) INTO SV_des_tipdirec ';
         LV_sSql := LV_sSql || ' FROM ge_tipdireccion ';
         LV_sSql := LV_sSql || ' WHERE  cod_tipdireccion='||EN_cod_tipdirec;

         SELECT RTRIM(LTRIM(tipd.des_tipdireccion))
         INTO   SV_des_tipdirec
         FROM   ge_tipdireccion tipd
         WHERE  tipd.cod_tipdireccion = EN_cod_tipdirec;
      ELSE
         RAISE error_no_codtipdirec;
      END IF;

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            RAISE error_no_codtipdirec;
   END;

   EXCEPTION
      WHEN cod_direc_no_valido THEN
         SN_cod_retorno := 275;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         LV_des_retorno := SUBSTR('ga_obtiene_desdirec_pr('||EN_cod_direccion||','||EN_cod_tipdirec||'); - ' || SQLERRM,1,CN_largoerrtec);
         SV_mens_retorno:= SUBSTR(SV_mens_retorno,1,CN_largodesc);
         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_obtiene_desdirec_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

      WHEN error_no_cod_operadora THEN
         SN_cod_retorno := 156; --Pedir codigo
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         LV_des_retorno := SUBSTR('ga_obtiene_desdirec_pr('||EN_cod_direccion||','||EN_cod_tipdirec||'); - ' || SQLERRM,1,CN_largoerrtec);
         SV_mens_retorno:= SUBSTR(SV_mens_retorno,1,CN_largodesc);
         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_obtiene_desdirec_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

      WHEN error_execute_no_data THEN
         SN_cod_retorno := 98;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         LV_des_retorno :=SUBSTR('ga_obtiene_desdirec_pr('||EN_cod_direccion||','||EN_cod_tipdirec||'); - ' || SQLERRM,1,CN_largoerrtec);
         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_obtiene_desdirec_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

      WHEN error_execute_too_many_rows    THEN
         SN_cod_retorno := 98;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         LV_des_retorno :=SUBSTR('ga_obtiene_desdirec_pr('||EN_cod_direccion||','||EN_cod_tipdirec||'); - ' || SQLERRM,1,CN_largoerrtec);
         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_obtiene_desdirec_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

      WHEN error_no_region THEN
         SN_cod_retorno := 304 ;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         LV_des_retorno :=SUBSTR('ga_obtiene_desdirec_pr('||EN_cod_direccion||','||EN_cod_tipdirec||'); - ' || SQLERRM,1,CN_largoerrtec);
         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_obtiene_desdirec_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

      WHEN error_carga_region THEN
         SN_cod_retorno := 273;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         LV_des_retorno :=SUBSTR('ga_obtiene_desdirec_pr('||EN_cod_direccion||','||EN_cod_tipdirec||'); - ' || SQLERRM,1,CN_largoerrtec);
         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_obtiene_desdirec_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

      WHEN error_no_provincia THEN
         SN_cod_retorno := 305;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         LV_des_retorno :=SUBSTR('ga_obtiene_desdirec_pr('||EN_cod_direccion||','||EN_cod_tipdirec||'); - ' || SQLERRM,1,CN_largoerrtec);
         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_obtiene_desdirec_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

      WHEN error_carga_prov THEN
         SN_cod_retorno := 272;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         LV_des_retorno :=SUBSTR('ga_obtiene_desdirec_pr('||EN_cod_direccion||','||EN_cod_tipdirec||'); - ' || SQLERRM,1,CN_largoerrtec);
         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_obtiene_desdirec_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

      WHEN error_no_ciudad THEN
         SN_cod_retorno := 271;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         LV_des_retorno :=SUBSTR('ga_obtiene_desdirec_pr('||EN_cod_direccion||','||EN_cod_tipdirec||'); - ' || SQLERRM,1,CN_largoerrtec);
         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_obtiene_desdirec_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

       WHEN error_carga_ciudad THEN
         SN_cod_retorno := 271;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         LV_des_retorno :=SUBSTR('ga_obtiene_desdirec_pr('||EN_cod_direccion||','||EN_cod_tipdirec||'); - ' || SQLERRM,1,CN_largoerrtec);
         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_obtiene_desdirec_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

      WHEN error_no_comuna THEN
         SN_cod_retorno := 307;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         LV_des_retorno :=SUBSTR('ga_obtiene_desdirec_pr('||EN_cod_direccion||','||EN_cod_tipdirec||'); - ' || SQLERRM,1,CN_largoerrtec);
         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_obtiene_desdirec_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

      WHEN error_carga_comuna THEN
         SN_cod_retorno := 270;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         LV_des_retorno :=SUBSTR('ga_obtiene_desdirec_pr('||EN_cod_direccion||','||EN_cod_tipdirec||'); - ' || SQLERRM,1,CN_largoerrtec);
         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_obtiene_desdirec_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

      WHEN error_no_codtipdirec THEN
         SN_cod_retorno := 313;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         LV_des_retorno :=SUBSTR('ga_obtiene_desdirec_pr('||EN_cod_direccion||','||EN_cod_tipdirec||'); - ' || SQLERRM,1,CN_largoerrtec);
         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_obtiene_desdirec_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

      WHEN error_carga_codtipdirec THEN
         SN_cod_retorno := 269;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         LV_des_retorno :=SUBSTR('ga_obtiene_desdirec_pr('||EN_cod_direccion||','||EN_cod_tipdirec||'); - ' || SQLERRM,1,CN_largoerrtec);
         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_obtiene_desdirec_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

        WHEN OTHERS THEN
         SN_cod_retorno := 156;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         LV_des_retorno :=SUBSTR('ga_obtiene_desdirec_pr('||EN_cod_direccion||','||EN_cod_tipdirec||'); - ' || SQLERRM,1,CN_largoerrtec);
         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_obtiene_desdirec_pr', LV_sSql, SN_cod_retorno, LV_des_retorno );

END ga_obtiene_desdirec_pr;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_direccion_pr(
   EN_cod_direccion    IN 		  ge_direcciones.cod_direccion%TYPE,
   SV_obs_direccion    OUT NOCOPY ge_direcciones.obs_direccion%TYPE,
   SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
   SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
   SN_num_evento       OUT NOCOPY ge_errores_pg.Evento
) IS
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_DIRECCION_PR"
      Lenguaje="PL/SQL"
      Fecha="26-08-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Obtiene datos de una dirección</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_direccion"   Tipo="NUMERICO">Código de la dirección</param>
         </Entrada>
         <Salida>
            <param nom="SV_obs_direccion    Tipo="CARACTER">Observación de una dirección</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
        V_des_error     ge_errores_pg.DesEvent;
        sSql            ge_errores_pg.vQuery;

BEGIN
   	    --Inicializar variables
		SN_cod_retorno:=0;
        SN_num_evento:=0;
		SV_obs_direccion:=NULL;

        sSql:='SELECT direccion.OBS_DIRECCION '||
		      'INTO SV_obs_direccion '||
	          'FROM GE_DIRECCIONES direccion '||
	          'WHERE direccion.COD_DIRECCION='||EN_cod_direccion;

        SELECT direccion.OBS_DIRECCION
		  INTO SV_obs_direccion
	      FROM GE_DIRECCIONES direccion
	     WHERE direccion.COD_DIRECCION=EN_cod_direccion;

EXCEPTION
WHEN  OTHERS   THEN
      SN_cod_retorno:=156;
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno:=CV_error_no_clasIF;
      END IF;
      V_des_error:='others: GA_CONSULTA_DIRECCION_PR('||EN_cod_direccion||'); - ' || SQLERRM;
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'GA_CONSULTA_DIRECCION_PR', sSql, SQLCODE, V_des_error );
END  GA_CONSULTA_DIRECCION_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_version_fn RETURN VARCHAR2
/*
<Documentación
  TipoDoc = "Función>
   <Elemento
      Nombre = "GA_VERSION_FN"
      Lenguaje="PL/SQL"
      Fecha="26-12-2004"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>Versión y subversión del package</Retorno>
      <Descripción>Mostrar versión y subversión del package</Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
BEGIN
   RETURN('Version : '||CV_version||' <--> SubVersion : '||CV_subversion);
END;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END ga_consulta_direccion_pg;
/
SHOW ERRORS
