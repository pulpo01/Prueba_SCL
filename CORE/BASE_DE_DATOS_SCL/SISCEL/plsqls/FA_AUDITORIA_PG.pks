CREATE OR REPLACE PACKAGE FA_AUDITORIA_PG
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "FA_AUDITORIA_PG"
    Lenguaje="PL/SQL"
    Fecha="22-11-2005"
    Versión="1.0"
    Diseñador="Luis Santana L."
    Programador="Luis Santana L."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package que agrupa el mantenimiento de impuestos, sobre los reportes tributarios y reportes de auditorias de ECU-05017
</Descripción>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/
IS
CV_version          CONSTANT  VARCHAR2(2):='1';
CV_subversion       CONSTANT  VARCHAR2(2):='0';
CV_error_no_clasif  CONSTANT  VARCHAR2(30):='Error no clasificado';
CV_cod_modulo       CONSTANT  ged_parametros.cod_modulo%TYPE   :='FA';
CN_cod_producto     CONSTANT  ged_parametros.cod_producto%TYPE :=1;
CV_cod_modparam     CONSTANT  ged_parametros.cod_modulo%TYPE   :='GE';
CV_formato_sel2     CONSTANT  ged_parametros.nom_parametro%TYPE:='FORMATO_SEL2';
CV_formato_sel7     CONSTANT  ged_parametros.nom_parametro%TYPE:='FORMATO_SEL7';
----------------------------------------------------------------------------------------------------
FUNCTION fa_version_fn  RETURN VARCHAR2;
----------------------------------------------------------------------------------------------------
PROCEDURE fa_impuesto_in_pr (EN_num_transaccion IN ga_transacabo.num_transaccion%type,
                             EN_cod_catimpos    IN ge_impuestos.cod_catimpos%type,
                             EN_cod_zonaimpo    IN ge_impuestos.cod_zonaimpo%type,
                             EN_cod_zonaabon    IN ge_impuestos.cod_zonaabon%type,
                             EN_cod_tipimpues   IN ge_impuestos.cod_tipimpues%type,
                             EN_cod_grpservi    IN ge_impuestos.cod_grpservi%type,
                             EV_fec_desde       IN VARCHAR2,
                             EN_cod_concgene    IN ge_impuestos.cod_concgene%type,
                             EV_fec_hasta       IN VARCHAR2,
                             EN_prc_impuesto    IN ge_impuestos.prc_impuesto%type);
----------------------------------------------------------------------------------------------------
PROCEDURE fa_impuesto_up_pr (EN_num_transaccion IN ga_transacabo.num_transaccion%type,
                             EN_cod_catimpos    IN ge_impuestos.cod_catimpos%type,
                             EN_cod_zonaimpo    IN ge_impuestos.cod_zonaimpo%type,
                             EN_cod_zonaabon    IN ge_impuestos.cod_zonaabon%type,
                             EN_cod_tipimpues   IN ge_impuestos.cod_tipimpues%type,
                             EN_cod_grpservi    IN ge_impuestos.cod_grpservi%type,
                             EV_fec_desde       IN VARCHAR2,
                             EN_cod_concgene    IN ge_impuestos.cod_concgene%type,
                             EV_fec_hasta       IN VARCHAR2,
                             EN_prc_impuesto    IN ge_impuestos.prc_impuesto%type,
                                                         EN_TipoActual      IN Number,
                                                         EV_fec_desdePost   IN VARCHAR2 DEFAULT NULL);
----------------------------------------------------------------------------------------------------
PROCEDURE fa_impuesto_de_pr (EN_num_transaccion IN ga_transacabo.num_transaccion%type,
                             EN_cod_catimpos    IN ge_impuestos.cod_catimpos%type,
                             EN_cod_zonaimpo    IN ge_impuestos.cod_zonaimpo%type,
                             EN_cod_zonaabon    IN ge_impuestos.cod_zonaabon%type,
                             EN_cod_tipimpues   IN ge_impuestos.cod_tipimpues%type,
                             EN_cod_grpservi    IN ge_impuestos.cod_grpservi%type,
                             EV_fec_desde       IN VARCHAR2);
----------------------------------------------------------------------------------------------------
FUNCTION fa_categoria_imp_fn(EN_cod_catimpos  IN ge_impuestos.cod_catimpos%type) RETURN BOOLEAN;
----------------------------------------------------------------------------------------------------
FUNCTION fa_zona_imp_fn     (EN_cod_zonaimpo  IN ge_impuestos.cod_zonaimpo%type) RETURN BOOLEAN;
----------------------------------------------------------------------------------------------------
FUNCTION fa_tipo_impuesto_fn(EN_cod_tipimpues IN ge_impuestos.cod_tipimpues%type)RETURN BOOLEAN;
----------------------------------------------------------------------------------------------------
FUNCTION fa_grpservicios_fn (EN_cod_grpservi  IN ge_impuestos.cod_grpservi%type) RETURN BOOLEAN;
----------------------------------------------------------------------------------------------------
FUNCTION fa_concepto_fac_fn (EN_cod_concgene  IN ge_impuestos.cod_concgene%type) RETURN BOOLEAN;
----------------------------------------------------------------------------------------------------
END FA_AUDITORIA_PG;
/
SHOW ERRORS
