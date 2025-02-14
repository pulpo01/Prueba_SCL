CREATE OR REPLACE PACKAGE Ra_Reportes_Tributarios_Pg IS
/*
<Documentación
   TipoDoc = "Package">
   <Elemento
       Nombre = "RA_REPORTES_TRIBUTARIOS_PG"
       Lenguaje="PL/SQL"
       Fecha="18-06-2005"
       Versión="1.0"ra_con_TipAuditoria_pr
       Diseñador="Marcela Lucero. - Maritza Tapia."
       Programador="Maritza Tapia A."
       Ambiente Desarrollo="BD">
       <Retorno>NA</Retorno>
       <Descripción>Package De Reportes de Auditoria</Descripción>
       <Parámetros>
          <Entrada>NA</Entrada>
          <Salida>NA</Salida>
       </Parámetros>
    </Elemento>
   </Documentación>
*/


        TYPE refcursor IS REF CURSOR;

    CN_uno                  CONSTANT PLS_INTEGER   := 1;
    CN_cero                 CONSTANT PLS_INTEGER   := 0;
        CN_dos                  CONSTANT PLS_INTEGER   := 2;
        CN_11                   CONSTANT PLS_INTEGER   := 11;
        CN_12                   CONSTANT PLS_INTEGER   := 12;
        CN_13                   CONSTANT PLS_INTEGER   := 13;
        CN_14                   CONSTANT PLS_INTEGER   := 14;
    CV_cod_modulo           CONSTANT VARCHAR (2)   := 'RA';
    CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No Es Posible Recuperar Error Clasificado';
        CV_version                  CONSTANT VARCHAR2(5)   := '1.0';
        CV_subversion           CONSTANT VARCHAR2(1)   := '0';

        FUNCTION ra_consulta_parametro_fn(
                 EV_parametro IN GED_PARAMETROS.NOM_PARAMETRO%TYPE,
                 EV_modulo        IN GED_PARAMETROS.COD_MODULO%TYPE
                 )
        RETURN VARCHAR2;

        PROCEDURE ra_consultaUsuario_pr(
    tUsuario               OUT NOCOPY refcursor,
    SV_mens_retorno    OUT NOCOPY VARCHAR2
        );

        PROCEDURE ra_consultaoficina_pr (
    tOficina          OUT NOCOPY refcursor,
    SV_mens_retorno   OUT NOCOPY VARCHAR2
        );

        FUNCTION ra_consultasysdate_pr (
    EV_formato          IN  VARCHAR2,
    EV_dias         IN  VARCHAR2,
        EV_FecDesde     IN  VARCHAR2
        )
        RETURN VARCHAR2;

        PROCEDURE ra_Ingresa_Auditoria_pr(
        EV_tip_audit     IN  VARCHAR2,
        EV_valor_ant     IN      RA_AUDITORIA_TRIBUTARIA_TO.valor_ant%TYPE,
        EV_valor_nue     IN  RA_AUDITORIA_TRIBUTARIA_TO.valor_nue%TYPE,
        EV_proceso               IN      RA_AUDITORIA_TRIBUTARIA_TO.proceso_audit%TYPE,
        EV_proc_audit    IN      VARCHAR2,
        EV_correlativo   IN      VARCHAR2,
    SV_mens_retorno  OUT NOCOPY VARCHAR2
        );

        PROCEDURE ra_ingreso_caja_total_pr (
        EV_tip_audit   IN VARCHAR2,
        EV_valor_ant   IN RA_AUDITORIA_TRIBUTARIA_TO.valor_ant%TYPE,
        EV_valor_nue   IN RA_AUDITORIA_TRIBUTARIA_TO.valor_nue%TYPE,
        EV_proceso         IN RA_AUDITORIA_TRIBUTARIA_TO.proceso_audit%TYPE,
        EV_proc_audit  IN VARCHAR2,
        EV_correlativo IN VARCHAR2,
        EV_usuario    IN ge_seg_usuario.nom_usuario%TYPE,
        EV_oficina    IN ge_oficinas.cod_oficina%TYPE,
        EV_fecdesde       IN VARCHAR2,
        EV_fechasta       IN VARCHAR2,
        EV_formato    IN VARCHAR2,
        tCaja           OUT NOCOPY refcursor,
    SV_mens_retorno OUT NOCOPY VARCHAR2
        );

        PROCEDURE ra_consolidado_mensual_caja_pr (
        EV_tip_audit  IN VARCHAR2,
        EV_valor_ant  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_ant%TYPE,
        EV_valor_nue  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_nue%TYPE,
        EV_proceso        IN RA_AUDITORIA_TRIBUTARIA_TO.proceso_audit%TYPE,
        EV_proc_audit IN VARCHAR2,
        EV_correlativo   IN      VARCHAR2,
        EV_usuario    IN ge_seg_usuario.nom_usuario%TYPE,
        EV_oficina    IN ge_oficinas.cod_oficina%TYPE,
        EV_fecdesde       IN VARCHAR2,
        EV_fechasta       IN VARCHAR2,
        EV_formato    IN VARCHAR2,
        tCaja         OUT NOCOPY refcursor,
    SV_mens_retorno OUT NOCOPY VARCHAR2
        );

        PROCEDURE ra_menu_pr (
        EV_cod_programa   IN  ge_seg_perfiles.cod_programa%TYPE,
        EN_num_version    IN  ge_seg_perfiles.num_version%TYPE,
        EV_nom_usuario    IN  ge_seg_grpusuario.nom_usuario%TYPE,
        tMenu             OUT NOCOPY refcursor,
    SV_mens_retorno   OUT NOCOPY VARCHAR2
        );


        PROCEDURE ra_con_TipAuditoria_pr (
        EV_dominio        IN VARCHAR2,
        tTipAuditoria     OUT NOCOPY refcursor,
    SV_mens_retorno   OUT NOCOPY VARCHAR2
        );


        PROCEDURE ra_con_programas_pr (
        tProgramas        OUT NOCOPY refcursor,
    SV_mens_retorno   OUT NOCOPY VARCHAR2
        );

        PROCEDURE ra_con_tipDocumento_pr (
        tDocumentos       OUT NOCOPY refcursor,
    SV_mens_retorno   OUT NOCOPY VARCHAR2
        );

        PROCEDURE ra_con_UsuarioOficina_pr (
        EV_codprograma    IN  GE_PROGRAMAS.COD_PROGRAMA%TYPE,
        EV_version        IN  VARCHAR2,
        tUsuario              OUT NOCOPY refcursor,
    SV_mens_retorno   OUT NOCOPY VARCHAR2
        );

        FUNCTION ra_autoriza_fn(
                 EV_fechaEmision   IN VARCHAR2,
                 EV_formato         IN VARCHAR2
                 )
        RETURN AL_AUTORIZACION_FOLIO_TD.COD_AUTORIZACION%TYPE;

        PROCEDURE ra_DocTributario_mensual_pr (
        EV_tip_audit  IN VARCHAR2,
        EV_valor_ant  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_ant%TYPE,
        EV_valor_nue  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_nue%TYPE,
        EV_proceso        IN RA_AUDITORIA_TRIBUTARIA_TO.proceso_audit%TYPE,
        EV_proc_audit  IN VARCHAR2,
        EV_correlativo IN VARCHAR2,
        EV_usuario    IN ge_seg_usuario.nom_usuario%TYPE,
        EV_oficina    IN ge_oficinas.cod_oficina%TYPE,
        EV_fecdesde       IN VARCHAR2,
        EV_fechasta       IN VARCHAR2,
        EV_formato    IN VARCHAR2,
        EV_foliodesde IN VARCHAR2,
        EV_foliohasta IN VARCHAR2,
        EV_tipoDoc    IN VARCHAR2,
        tTributario     OUT NOCOPY refcursor,
    SV_mens_retorno OUT NOCOPY VARCHAR2
        );

        PROCEDURE ra_DocTributario_total_pr (
        EV_tip_audit  IN VARCHAR2,
        EV_valor_ant  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_ant%TYPE,
        EV_valor_nue  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_nue%TYPE,
        EV_proceso        IN RA_AUDITORIA_TRIBUTARIA_TO.proceso_audit%TYPE,
        EV_proc_audit  IN VARCHAR2,
        EV_correlativo IN VARCHAR2,
        EV_usuario    IN ge_seg_usuario.nom_usuario%TYPE,
        EV_oficina    IN ge_oficinas.cod_oficina%TYPE,
        EV_fecdesde       IN VARCHAR2,
        EV_fechasta       IN VARCHAR2,
        EV_formato    IN VARCHAR2,
        EV_foliodesde IN VARCHAR2,
        EV_foliohasta IN VARCHAR2,
        EV_tipoDoc    IN VARCHAR2,
        tTributario     OUT NOCOPY refcursor,
    SV_mens_retorno OUT NOCOPY VARCHAR2
        );


        PROCEDURE ra_Parametro_impuesto_pr (
        EV_tip_audit  IN VARCHAR2,
        EV_valor_ant  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_ant%TYPE,
        EV_valor_nue  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_nue%TYPE,
        EV_proceso        IN RA_AUDITORIA_TRIBUTARIA_TO.proceso_audit%TYPE,
        EV_proc_audit  IN VARCHAR2,
        EV_correlativo IN VARCHAR2,
        EV_proc        IN VARCHAR2,
        EV_tipo        IN VARCHAR2,
        EV_fecdesde       IN VARCHAR2,
        EV_fechasta       IN VARCHAR2,
        EV_formato    IN VARCHAR2,
        tImpuesto     OUT NOCOPY refcursor,
    SV_mens_retorno OUT NOCOPY VARCHAR2
        );

        PROCEDURE ra_Parametro_interes_pr (
        EV_tip_audit  IN VARCHAR2,
        EV_valor_ant  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_ant%TYPE,
        EV_valor_nue  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_nue%TYPE,
        EV_proceso        IN RA_AUDITORIA_TRIBUTARIA_TO.proceso_audit%TYPE,
        EV_proc_audit  IN VARCHAR2,
        EV_correlativo IN VARCHAR2,
        EV_proc        IN VARCHAR2,
        EV_tipo        IN VARCHAR2,
        EV_fecdesde       IN VARCHAR2,
        EV_fechasta       IN VARCHAR2,
        EV_formato    IN VARCHAR2,
        tInteres      OUT NOCOPY refcursor,
    SV_mens_retorno OUT NOCOPY VARCHAR2
        );

        PROCEDURE ra_Parametro_categorias_pr (
        EV_tip_audit  IN VARCHAR2,
        EV_valor_ant  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_ant%TYPE,
        EV_valor_nue  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_nue%TYPE,
        EV_proceso        IN RA_AUDITORIA_TRIBUTARIA_TO.proceso_audit%TYPE,
        EV_proc_audit  IN VARCHAR2,
        EV_correlativo IN VARCHAR2,
        EV_proc        IN VARCHAR2,
        EV_tipo        IN VARCHAR2,
        EV_fecdesde       IN VARCHAR2,
        EV_fechasta       IN VARCHAR2,
        EV_formato    IN VARCHAR2,
        tCategoria      OUT NOCOPY refcursor,
    SV_mens_retorno OUT NOCOPY VARCHAR2
        );

        PROCEDURE ra_con_reportes_pr (
        EV_tip_audit  IN VARCHAR2,
        EV_valor_ant  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_ant%TYPE,
        EV_valor_nue  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_nue%TYPE,
        EV_proceso        IN RA_AUDITORIA_TRIBUTARIA_TO.proceso_audit%TYPE,
        EV_proc_audit  IN VARCHAR2,
        EV_correlativo IN VARCHAR2,
        EV_proc        IN VARCHAR2,
        EV_usuario    IN ge_seg_usuario.nom_usuario%TYPE,
        EV_fecdesde       IN VARCHAR2,
        EV_fechasta       IN VARCHAR2,
        EV_formato    IN VARCHAR2,
        tReportes      OUT NOCOPY refcursor,
    SV_mens_retorno OUT NOCOPY VARCHAR2
        );

        PROCEDURE ra_con_ProcAuditoria_pr (
        tProcAuditoria            OUT NOCOPY refcursor,
    SV_mens_retorno   OUT NOCOPY VARCHAR2
        );
END Ra_Reportes_Tributarios_Pg;
/
SHOW ERRORS