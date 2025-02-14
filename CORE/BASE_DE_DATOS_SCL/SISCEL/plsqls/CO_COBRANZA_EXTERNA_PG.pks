CREATE OR REPLACE PACKAGE CO_COBRANZA_EXTERNA_PG AS

   TYPE refCursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
   CV_cod_modulo_GE        CONSTANT VARCHAR2 (2)  := 'GE';
   CV_cod_modulo_CO        CONSTANT VARCHAR2 (2)  := 'CO';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';
   CV_gsFormato2           CONSTANT VARCHAR2 (20) := 'FORMATO_SEL2';
   CV_gsFormato4           CONSTANT VARCHAR2 (20) := 'FORMATO_SEL4';
   CV_gsFormato7           CONSTANT VARCHAR2 (20) := 'FORMATO_SEL7';

   CV_estado_pd            CONSTANT VARCHAR2 (2)  := 'PD';

   CV_cod_aplic            CONSTANT VARCHAR2 (3)  := 'PVA';
   CN_producto             CONSTANT NUMBER        := 1;


   CN_0                    CONSTANT NUMBER (1)     :=  0;
   CV_0                    CONSTANT VARCHAR2 (1)   := '0';
   CV_1                    CONSTANT VARCHAR2 (1)   := '1';

------------------------------------------------------------------------------------------------------
PROCEDURE CO_CARGA_EMPRESAS_PR(SO_Lista_empresa        OUT NOCOPY refCursor,
                               SV_mens_retorno         OUT NOCOPY ge_errores_td.det_msgerror%TYPE);
                                 
PROCEDURE CO_ACTUALIZA_EMPRESA_PR (  EO_Cod_entidad    IN              CO_ENTCOB.COD_ENTIDAD%type,
                                     EO_Des_entidad    IN              CO_ENTCOB.DES_ENTIDAD%TYPE,
                                     EO_Direccion      IN              CO_ENTCOB.DIRECCION%type,
                                     EO_Telefono       IN              CO_ENTCOB.TELEFONO%type,
                                     EO_Email          IN              CO_ENTCOB.EMAIL%type,
                                     EO_Tip_comision   IN              CO_ENTCOB.TIP_COMISION%type,
                                     EO_Tip_entidad    IN              CO_ENTCOB.TIP_ENTIDAD%TYPE,
                                     SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                     SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                     SN_num_evento     OUT NOCOPY      ge_errores_pg.evento);
                                     
PROCEDURE CO_INSERTA_EMPRESA_PR (  EO_Cod_entidad    IN              CO_ENTCOB.COD_ENTIDAD%type,
                                   EO_Des_entidad    IN              CO_ENTCOB.DES_ENTIDAD%type,
                                   EO_Direccion      IN              CO_ENTCOB.DIRECCION%type,
                                   EO_Telefono       IN              CO_ENTCOB.TELEFONO%type,
                                   EO_Email          IN              CO_ENTCOB.EMAIL%type,
                                   EO_Tip_comision   IN              CO_ENTCOB.TIP_COMISION%type,
                                   EO_Tip_entidad    IN              CO_ENTCOB.TIP_ENTIDAD%TYPE,
                                   SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento     OUT NOCOPY      ge_errores_pg.evento);
                                   
PROCEDURE CO_ELIMINA_EMPRESA_PR (  EO_Cod_entidad    IN              CO_ENTCOB.COD_ENTIDAD%type,
                                   SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento     OUT NOCOPY      ge_errores_pg.evento);
                                   
PROCEDURE CO_CARGA_INMUNES_PR(SO_Lista_inmunes        OUT NOCOPY refCursor,
                               SV_mens_retorno        OUT NOCOPY ge_errores_td.det_msgerror%TYPE);
                               
PROCEDURE CO_CARGA_CLIENTE_INMUNE_PR(EO_cliente IN co_cobex_inmune_to.cod_cliente%TYPE,
                               EO_fecdesde IN VARCHAR2,
                               SO_Lista_inmunes        OUT NOCOPY refCursor,
                               SV_mens_retorno         OUT NOCOPY ge_errores_td.det_msgerror%TYPE);
                                                              
PROCEDURE CO_INSERTA_INMUNES_PR (  EO_Cod_cliente      IN              CO_COBEX_INMUNE_TO.COD_CLIENTE%type,
                                   EO_Fec_inmunidad    IN              VARCHAR2,
                                   EO_Fec_desde        IN              VARCHAR2,
                                   EO_Fec_hasta        IN              VARCHAR2,                                   
                                   SN_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento       OUT NOCOPY      ge_errores_pg.evento);
                                   
PROCEDURE CO_ELIMINA_INMUNES_PR (  EO_Cod_cliente    IN              CO_COBEX_INMUNE_TO.COD_CLIENTE%type,
                                   EO_Fec_desde      IN              VARCHAR2,
                                   SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento     OUT NOCOPY      ge_errores_pg.evento);
                                                                                                     
PROCEDURE CO_OBTIENE_DATCLIE_PR(EO_Cod_cliente       IN  CO_COBEX_INMUNE_TO.COD_CLIENTE%type,
                                SO_Lista_cliente     OUT NOCOPY refCursor,
                                SV_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE);                                                                                                          

PROCEDURE CO_OBTIENE_REASIGNAR_PR(EO_Cod_entidad      IN CO_ENTCOB.COD_ENTIDAD%type,
                                  EO_Cod_rango        IN CO_PARAM_COBEX_TO.COD_RANGO%TYPE,
                                  EO_Cod_ciclo     IN CO_PARAM_COBEX_TO.COD_CICLO%type,
                                  EO_Cod_categoria    IN CO_PARAM_COBEX_TO.COD_CATEGORIA%type,
                                  EO_cod_segmento     IN CO_PARAM_COBEX_TO.COD_SEGMENTO%type,
                                  EO_cod_calificacion IN CO_PARAM_COBEX_TO.COD_CALIFICACION%type,
                                  EO_mto_Desde        IN CO_PARAM_COBEX_TO.MTO_DESDE%TYPE,
                                  EO_mto_Hasta        IN CO_PARAM_COBEX_TO.MTO_HASTA%TYPE,                                  
                                  SO_Lista_cliente   OUT NOCOPY refCursor,
                                  SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE);

PROCEDURE CO_REASIGNA_MOROSOS_PR ( EO_Cod_entidad    IN              CO_ENTCOB.COD_ENTIDAD%type,
                                   EO_Cod_cliente    IN              CO_MOROSOS.COD_CLIENTE%type,
                                   EO_Num_secuencia  IN              CO_PARAM_COBEX_TO.NUM_SECUENCIA%TYPE,
                                   EO_Cod_rango      IN              CO_PARAM_COBEX_TO.COD_RANGO%TYPE,
                                   SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento     OUT NOCOPY      ge_errores_pg.evento);                                                  

PROCEDURE CO_CONSULTA_INMUNES_PR(EO_Cod_categoria    IN  CO_PARAM_COBEX_TO.COD_CATEGORIA%type,
                                 EO_Cod_segmento     IN  GE_CLIENTES.COD_SEGMENTO%type,
                                 EO_Cod_calificacion IN  GE_CLIENTES.COD_CALIFICACION%type,
                                 EO_Fec_desde        IN  VARCHAR2,
                                 EO_Fec_hasta        IN  VARCHAR2,
                                 SO_Lista_inmunes    OUT NOCOPY refCursor,
                                 SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE);     

PROCEDURE CO_CARGA_CBO_EMPRE_PR(SO_Lista_cbo         OUT NOCOPY refCursor,
                                SV_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE);
                                
PROCEDURE CO_CARGA_CBO_EMPRE_VIG_PR(SO_Lista_cbo     OUT NOCOPY refCursor,
                                SV_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE);
                                
PROCEDURE CO_CARGA_CBO_EMPRE_RANGO_PR(EV_cod_rango CO_ENTIDAD_RANGO_TD.cod_rango%TYPE,
                                SO_Lista_cbo         OUT NOCOPY refCursor,
                                SV_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE);                                                                
                                
PROCEDURE CO_CARGA_CBO_CICLO_PR(SO_Lista_cbo         OUT NOCOPY refCursor,
                                SV_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE);                                                                             

PROCEDURE CO_CARGA_CBO_CATEG_PR(SO_Lista_cbo         OUT NOCOPY refCursor,
                                SV_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE);
                                                     
PROCEDURE CO_CARGA_CBO_SEGME_PR(SO_Lista_cbo         OUT NOCOPY refCursor,
                                SV_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE);
                                
PROCEDURE CO_CARGA_CBO_CALIF_PR(SO_Lista_cbo         OUT NOCOPY refCursor,
                                SV_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE);
                                
PROCEDURE CO_CARGA_CBO_PRODU_PR(SO_Lista_cbo         OUT NOCOPY refCursor,
                                SV_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE);                                

PROCEDURE CO_CONSULTA_MOROSOS_PR(EO_Cod_categoria    IN         CO_PARAM_COBEX_TO.COD_CATEGORIA%type,
                                 EO_Cod_segmento     IN         GE_CLIENTES.COD_SEGMENTO%type,
                                 EO_Cod_calificacion IN         GE_CLIENTES.COD_CALIFICACION%type,
                                 EO_Fec_desde        IN         VARCHAR2,
                                 EO_Fec_hasta        IN         VARCHAR2,
                                 SO_Lista_morosos    OUT NOCOPY refCursor,
                                 SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE);                                

PROCEDURE CO_OBTIENE_CARTERA_PREMORA_PR(EO_Num_secuencia CO_PARAM_COBEX_TO.NUM_SECUENCIA%TYPE,
                                        EO_Cod_entidad      IN         CO_PARAM_COBEX_TO.COD_ENTIDAD%TYPE,
                                        EO_Cod_ciclo        IN         CO_PARAM_COBEX_TO.COD_CICLO%TYPE,
                                        EO_Cod_categoria    IN         CO_PARAM_COBEX_TO.COD_CATEGORIA%type,
                                        EO_Cod_segmento     IN         GE_CLIENTES.COD_SEGMENTO%type,
                                        EO_Cod_calificacion IN         GE_CLIENTES.COD_CALIFICACION%type,
                                        EO_monto_desde      IN         CO_PARAM_COBEX_TO.MTO_DESDE%TYPE,
                                        EO_monto_hasta      IN         CO_PARAM_COBEX_TO.MTO_HASTA%TYPE,
                                        SO_Lista_morosos    OUT NOCOPY refCursor,
                                        SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE);     
                                     
PROCEDURE CO_INSERTA_CONFIGURACION_PR (  Ev_Cod_rango        IN CO_PARAM_COBEX_TO.COD_RANGO%type,
                                         EO_Tip_gestion      IN CO_PARAM_COBEX_TO.TIP_GESTION%type,
                                         EO_Cod_entidad      IN CO_PARAM_COBEX_TO.COD_ENTIDAD%type,
                                         EO_Cod_ciclo     IN CO_PARAM_COBEX_TO.COD_CICLO%type,
                                         EO_Cod_categoria    IN CO_PARAM_COBEX_TO.COD_CATEGORIA%type,
                                         EO_cod_segmento     IN CO_PARAM_COBEX_TO.COD_SEGMENTO%type,
                                         EO_cod_calificacion IN CO_PARAM_COBEX_TO.COD_CALIFICACION%type,
                                         EO_mto_Desde        IN CO_PARAM_COBEX_TO.MTO_DESDE%TYPE,
                                         EO_mto_Hasta        IN CO_PARAM_COBEX_TO.MTO_HASTA%TYPE,
                                         EO_IND_HISTORICO    IN CO_PARAM_COBEX_TO.IND_HISTORICO%TYPE,
                                         EO_NUM_VECESMORA    IN CO_PARAM_COBEX_TO.NUM_VECESMORA%TYPE,
                                         EO_NUM_MESES        IN CO_PARAM_COBEX_TO.NUM_MESES%TYPE,
                                         EO_cod_estado       IN CO_PARAM_COBEX_TO.COD_ESTADO%TYPE,
                                         SN_num_secuencia   OUT NOCOPY refCursor,
                                         SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE);                                                                  
                                       
PROCEDURE CO_CARGA_CBO_RANGO_PR(SO_Lista_cbo        OUT NOCOPY refCursor,
                                SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE);    
                                
PROCEDURE CO_CARGA_CONFIGURACION_PR(EV_estado1 VARCHAR2,
                                    EV_estado2 VARCHAR2,
                                    SO_Lista_configuracion        OUT NOCOPY refCursor,
                                    SV_mens_retorno               OUT NOCOPY ge_errores_td.det_msgerror%TYPE);

PROCEDURE CO_CARGA_CONFIGURACION_PEN_PR(SO_Lista_configuracion        OUT NOCOPY refCursor,
                                        SV_mens_retorno               OUT NOCOPY ge_errores_td.det_msgerror%TYPE);
                               
PROCEDURE CO_CARGA_CONFIGURACION_PRO_PR(SO_Lista_configuracion        OUT NOCOPY refCursor,
                                        SV_mens_retorno               OUT NOCOPY ge_errores_td.det_msgerror%TYPE);                                                              
                               
PROCEDURE CO_ELIMINA_CONFIGURACION_PR (  EO_Num_secuencia  IN              CO_PARAM_COBEX_TO.NUM_SECUENCIA%type,
                                         SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                         SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                         SN_num_evento     OUT NOCOPY      ge_errores_pg.evento);
                                   
PROCEDURE CO_REASIGNA_EMPRESA_PR (EO_Num_secuencia IN              CO_PARAM_COBEX_TO.NUM_SECUENCIA%type,
                                   EO_Cod_entidad  IN              CO_ENTCOB.COD_ENTIDAD%type,
                                   EO_Cod_cliente  IN              CO_MOROSOS.COD_CLIENTE%type,
                                   SN_cod_retorno  OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento   OUT NOCOPY      ge_errores_pg.evento);
                                   
PROCEDURE CO_EXCLUYE_CLIENTE_PR ( EO_Num_secuencia IN              CO_PARAM_COBEX_TO.NUM_SECUENCIA%type,
                                   EO_Cod_cliente  IN              CO_MOROSOS.COD_CLIENTE%type,
                                   SN_cod_retorno  OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento   OUT NOCOPY      ge_errores_pg.evento);   
                                   
PROCEDURE CO_VISA_CONFIGURACION_PR (EO_Num_secuencia    IN              CO_PARAM_COBEX_TO.NUM_SECUENCIA%type,
                                   SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento     OUT NOCOPY      ge_errores_pg.evento);  
                                   
PROCEDURE CO_CARGA_PORCENTAJES_PR(SO_Lista_empresa        OUT NOCOPY refCursor,
                               SV_mens_retorno         OUT NOCOPY ge_errores_td.det_msgerror%TYPE);
                               

PROCEDURE CO_INSERTA_RANGO_PR (  EO_Cod_entidad  IN              CO_ENTIDAD_RANGO_TD.COD_ENTIDAD%type,
                                   EO_Cod_rango    IN              CO_ENTIDAD_RANGO_TD.COD_RANGO%type,
                                   EO_Porcentaje      IN           CO_ENTIDAD_RANGO_TD.PRC_ASIGNACION%type,
                                   SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento     OUT NOCOPY      ge_errores_pg.evento);
                                          
PROCEDURE CO_ELIMINA_RANGO_PR (  EO_Cod_entidad  IN              CO_ENTIDAD_RANGO_TD.COD_ENTIDAD%type,
                                   EO_Cod_rango    IN              CO_ENTIDAD_RANGO_TD.COD_RANGO%type,
                                   SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento     OUT NOCOPY      ge_errores_pg.evento);                                                                                                                                                               

PROCEDURE CO_CARGA_CBO_EMPRE_RAN_PR(EO_Cod_rango    IN  CO_ENTIDAD_RANGO_TD.COD_RANGO%type,
                                SO_Lista_cbo        OUT NOCOPY refCursor,
                                SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE);    
                                
PROCEDURE CO_PORCENTAJE_RANGO_PR (EO_Cod_entidad  IN              CO_ENTIDAD_RANGO_TD.COD_ENTIDAD%type,
                                  EO_Cod_rango    IN              CO_ENTIDAD_RANGO_TD.COD_RANGO%type,
                                   EO_Porcentaje     OUT NOCOPY      refCursor,
                                   SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE);   
                                   
                                    
PROCEDURE CO_VALIDA_RANGO_INMUNIDAD_PR(EO_CodCliente IN CO_COBEX_INMUNE_TO.COD_CLIENTE%TYPE,
                               EO_FecDesde IN VARCHAR2,
                               EO_FecHasta IN VARCHAR2,                               
                               SO_Lista_inmunes        OUT NOCOPY refCursor,
                               SV_mens_retorno        OUT NOCOPY ge_errores_td.det_msgerror%TYPE);                                                                                                                                                                                                                                                                                                                                                                                      

PROCEDURE CO_CARGA_TIPENTIDAD_PR(SO_Lista_entidad        OUT NOCOPY refCursor,
                               SV_mens_retorno         OUT NOCOPY ge_errores_td.det_msgerror%TYPE);

END CO_COBRANZA_EXTERNA_PG;
/
SHOW ERRORS

