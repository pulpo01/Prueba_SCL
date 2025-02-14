CREATE OR REPLACE PACKAGE VE_SOL_SCORING_PG AS

TYPE refcursor                  IS REF CURSOR;
cn_largoerrtec                  CONSTANT NUMBER        := 4000;
cn_largodesc                    CONSTANT NUMBER        := 2000;
cv_cod_modulo                   CONSTANT VARCHAR2 (2)  := 'VE';
CV_error_no_clasif   CONSTANT VARCHAR2(30) := 'Error no clasificado';
CN_VENTA             CONSTANT VARCHAR2(2):='VT';


 PROCEDURE VE_inserta_solScoring_PR(
    EV_APLICA_TARJETA       IN EV_ENTRADAWS_SCORING_TO.APLICA_TARJETA%TYPE,
    EV_PRIMER_NOMBRE        IN EV_ENTRADAWS_SCORING_TO.PRIMER_NOMBRE%TYPE,
    EV_SEGUNDO_NOMBRE       IN EV_ENTRADAWS_SCORING_TO.SEGUNDO_NOMBRE%TYPE,
    EV_PRIMER_APELLIDO      IN EV_ENTRADAWS_SCORING_TO.PRIMER_APELLIDO%TYPE,
    EV_SEGUNDO_APELLIDO     IN EV_ENTRADAWS_SCORING_TO.SEGUNDO_APELLIDO%TYPE,
    EV_COD_TIPDOCUMENTO     IN EV_ENTRADAWS_SCORING_TO.COD_TIPDOCUMENTO%TYPE,
    EV_NUM_DOCUMENTO        IN EV_ENTRADAWS_SCORING_TO.NUM_DOCUMENTO%TYPE,
    EV_NIT                  IN EV_ENTRADAWS_SCORING_TO.NIT%TYPE,
    EV_FECHA_NACIMIENTO     IN EV_ENTRADAWS_SCORING_TO.FECHA_NACIMIENTO%TYPE,
    EV_CAPACIDAD_PAGO       IN EV_ENTRADAWS_SCORING_TO.CAPACIDAD_PAGO%TYPE,
    EV_ANTIGUEDAD_LABORAL   IN EV_ENTRADAWS_SCORING_TO.ANTIGUEDAD_LABORAL%TYPE,
    EV_TIPO_PRODUCTO        IN EV_ENTRADAWS_SCORING_TO.TIPO_PRODUCTO%TYPE,
    EV_NOMUSUARORA          IN EV_ENTRADAWS_SCORING_TO.NOMUSUARORA%TYPE,
    EV_COD_CLIENTE          IN EV_ENTRADAWS_SCORING_TO.COD_CLIENTE%TYPE,
    EV_COD_TIPO_TARJETA     IN EV_ENTRADAWS_SCORING_TO.COD_TIPO_TARJETA%TYPE,
    EV_COD_NACIONALIDAD     IN EV_ENTRADAWS_SCORING_TO.COD_NACIONALIDAD%TYPE,
    EV_COD_NIVEL_ACADEMICO  IN EV_ENTRADAWS_SCORING_TO.COD_NIVEL_ACADEMICO%TYPE,
    EV_COD_ESTADO_CIVIL     IN EV_ENTRADAWS_SCORING_TO.COD_ESTADO_CIVIL%TYPE,
    EV_COD_TIPO_EMPRESA     IN EV_ENTRADAWS_SCORING_TO.COD_TIPO_EMPRESA%TYPE,
    EV_DES_TIPO_TARJETA     IN EV_ENTRADAWS_SCORING_TO.DES_TIPO_TARJETA%TYPE,
    EV_DES_NACIONALIDAD     IN EV_ENTRADAWS_SCORING_TO.DES_NACIONALIDAD%TYPE,
    EV_DES_NIVEL_ACADEMICO  IN EV_ENTRADAWS_SCORING_TO.DES_NIVEL_ACADEMICO%TYPE,
    EV_DES_ESTADO_CIVIL     IN EV_ENTRADAWS_SCORING_TO.DES_ESTADO_CIVIL%TYPE,
    EV_DES_TIPO_EMPRESA     IN EV_ENTRADAWS_SCORING_TO.DES_TIPO_EMPRESA%TYPE,
    EV_DES_TIPDOCUMENTO     IN EV_ENTRADAWS_SCORING_TO.DES_TIPDOCUMENTO%TYPE,
    EV_NUM_TARJETA          IN EV_ENTRADAWS_SCORING_TO.NUM_TARJETA%TYPE,
    EV_COD_BANCOTARJ        IN EV_ENTRADAWS_SCORING_TO.COD_BANCOTARJ%TYPE,
    EV_MES_VENCITARJ        IN EV_ENTRADAWS_SCORING_TO.MES_VENCITARJ%TYPE,
    EV_ANIO_VENCITARJ       IN EV_ENTRADAWS_SCORING_TO.ANIO_VENCITARJ%TYPE,
    EV_COD_TIPTARJETASCL    IN EV_ENTRADAWS_SCORING_TO.COD_TIPTARJETASCL%TYPE,
    SN_NUM_SOL_SCORING      OUT EV_ENTRADAWS_SCORING_TO.NUM_SOLSCORING%TYPE,
    SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento           OUT NOCOPY ge_errores_pg.Evento);


PROCEDURE VE_obtiene_SolicitudScoring_PR (EN_CODVENDEDOR   IN EV_DATOSGENER_SCORING_TO.COD_VENDEDOR%TYPE,
                                          EN_NUMSOLSCORING IN EV_ENTRADAWS_SCORING_TO.NUM_SOLSCORING%TYPE,
                                          EV_CODOFICINA    IN EV_DATOSGENER_SCORING_TO.COD_OFICINA%TYPE,
                                          EV_FECDESDE      IN VARCHAR2,
                                          EV_FECHASTA      IN VARCHAR2,
                                          EN_COD_CLIENTE   IN EV_ENTRADAWS_SCORING_TO.COD_CLIENTE%TYPE,
                                          EV_ESTADOSOL     IN EV_ESTADOSSCORING_TO.COD_ESTADO%TYPE,
                                          SC_CURSORDATOS   OUT NOCOPY REFCURSOR,
                                          SN_COD_RETORNO   OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                          SV_MENS_RETORNO  OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                          SN_NUM_EVENTO    OUT NOCOPY GE_ERRORES_PG.EVENTO);


	PROCEDURE VE_insert_datGenerScoring_PR(
			EV_NUM_SOLSCORING      IN EV_DATOSGENER_SCORING_TO.NUM_SOLSCORING%TYPE,
			EV_COD_OFICINA       	IN EV_DATOSGENER_SCORING_TO.COD_OFICINA%TYPE,
			EV_COD_TIPCOMIS        	IN EV_DATOSGENER_SCORING_TO.COD_TIPCOMIS%TYPE,
			EV_COD_MODVENTA       	IN EV_DATOSGENER_SCORING_TO.COD_MODVENTA%TYPE,
			EV_COD_TIPCONTRATO      IN EV_DATOSGENER_SCORING_TO.COD_TIPCONTRATO%TYPE,
			EV_COD_CUOTA     		IN EV_DATOSGENER_SCORING_TO.COD_CUOTA%TYPE,
			EV_COD_VENDEDOR     	IN EV_DATOSGENER_SCORING_TO.COD_VENDEDOR%TYPE,
			EV_COD_VENDEALER        IN EV_DATOSGENER_SCORING_TO.COD_VENDEALER%TYPE,
			EV_COD_AGENTE           IN EV_DATOSGENER_SCORING_TO.COD_AGENTE%TYPE,
            EV_COD_PERIODO          IN EV_DATOSGENER_SCORING_TO.COD_PERIODO%TYPE,
            EV_MONTO_PREAUTORIZADO  IN EV_DATOSGENER_SCORING_TO.MONTO_PREAUTORIZADO%TYPE,
            EV_FACTURA_TERCERO      IN EV_DATOSGENER_SCORING_TO.FACTURA_TERCERO%TYPE,
            EV_IND_VTA_EXTERNA      IN EV_DATOSGENER_SCORING_TO.IND_VTA_EXTERNA%TYPE,
			SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
			SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
			SN_num_evento           OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_inserta_estadoScoring_PR(EV_NUM_SOLSCORING    IN EV_DATOSGENER_SCORING_TO.NUM_SOLSCORING%TYPE,
			                              EV_COD_ESTADO        IN EV_ESTADOSSCORING_TO.COD_ESTADO%TYPE,
			                              EV_COD_VENDEDOR      IN EV_DATOSGENER_SCORING_TO.COD_VENDEDOR%TYPE,
			                              SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
			                              SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
			                              SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);

   PROCEDURE VE_obtiene_SolicitudScoring_PR(
										EV_NUM_SOLSCORING   IN EV_ENTRADAWS_SCORING_TO.NUM_SOLSCORING%TYPE,
										SC_CURSORDATOS      OUT NOCOPY REFCURSOR,
										SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_PG.CODERROR,
										SV_MENS_RETORNO     OUT NOCOPY GE_ERRORES_PG.MSGERROR,
										SN_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.EVENTO);

   PROCEDURE VE_obtiene_RepSolScoring_PR(
										EV_NUM_SOLSCORING       IN EV_ENTRADAWS_SCORING_TO.NUM_SOLSCORING%TYPE,
                                        EV_CANTIDAD_LINEAS      OUT NOCOPY NUMBER,
                                        EV_CANTIDAD_PLANESTARIF OUT NOCOPY NUMBER,
                                        EV_CANTIDAD_SERVSP      OUT NOCOPY NUMBER,
										SC_CURSORDATOS          OUT NOCOPY REFCURSOR,
                                        SC_CURSORPLANESTARIF    OUT NOCOPY REFCURSOR,
										SN_COD_RETORNO          OUT NOCOPY GE_ERRORES_PG.CODERROR,
										SV_MENS_RETORNO         OUT NOCOPY GE_ERRORES_PG.MSGERROR,
										SN_NUM_EVENTO           OUT NOCOPY GE_ERRORES_PG.EVENTO);

   PROCEDURE VE_obtiene_EstSolScoring_PR(
										EV_NUM_SOLSCORING   IN EV_ENTRADAWS_SCORING_TO.NUM_SOLSCORING%TYPE,
										SC_CURSORDATOS      OUT NOCOPY REFCURSOR,
										SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_PG.CODERROR,
										SV_MENS_RETORNO     OUT NOCOPY GE_ERRORES_PG.MSGERROR,
										SN_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.EVENTO);

    PROCEDURE VE_update_SolScoring_PR (
	    EV_NUM_SOLSCORING   IN EV_ENTRADAWS_SCORING_TO.NUM_SOLSCORING%TYPE,
        EV_CAPACIDAD_PAGO   IN EV_ENTRADAWS_SCORING_TO.CAPACIDAD_PAGO%TYPE,
        EV_TIPO_PRODUCTO    IN EV_ENTRADAWS_SCORING_TO.TIPO_PRODUCTO%TYPE,
		SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_PG.CODERROR,
		SV_MENS_RETORNO     OUT NOCOPY GE_ERRORES_PG.MSGERROR,
		SN_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.EVENTO);



    PROCEDURE VE_obtiene_lineasSolScoring_PR (EN_NUMSOLSCORING IN EV_ENTRADAWS_SCORING_TO.NUM_SOLSCORING%TYPE,
                                              SC_cursorDatos   OUT NOCOPY REFCURSOR,
                                              SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_inserta_lineaScoring_PR(
        EV_COD_ARTICULO             IN ev_prestsolic_scoring_to.COD_ARTICULO%TYPE,
        EV_COD_CELDA                IN ev_prestsolic_scoring_to.COD_CELDA%TYPE,
        EV_COD_CENTRAL              IN ev_prestsolic_scoring_to.COD_CENTRAL%TYPE,
        EV_COD_DEPARTAMENTO         IN ev_prestsolic_scoring_to.COD_DEPARTAMENTO%TYPE,
        EV_COD_MONEDACARGOBASICO    IN ev_prestsolic_scoring_to.COD_MONEDACARGOBASICO%TYPE,
        EV_COD_MONEDASEGURO         IN ev_prestsolic_scoring_to.COD_MONEDASEGURO%TYPE,
        EV_COD_MUNICIPIO            IN ev_prestsolic_scoring_to.COD_MUNICIPIO%TYPE,
        EV_COD_PLANSERV             IN ev_prestsolic_scoring_to.COD_PLANSERV%TYPE,
        EV_COD_PLANTARIF            IN ev_prestsolic_scoring_to.COD_PLANTARIF%TYPE,
        EV_COD_PRESTACION           IN ev_prestsolic_scoring_to.COD_PRESTACION%TYPE,
        EV_COD_SEGURO               IN ev_prestsolic_scoring_to.COD_SEGURO%TYPE,
        EV_COD_USO                  IN ev_prestsolic_scoring_to.COD_USO%TYPE,
        EV_COD_ZONA                 IN ev_prestsolic_scoring_to.COD_ZONA%TYPE,
        EV_IMPORTE_CARGOBASICO      IN ev_prestsolic_scoring_to.IMPORTE_CARGOBASICO%TYPE,
        EV_IMPORTE_EQUIPO           IN ev_prestsolic_scoring_to.IMPORTE_EQUIPO%TYPE,
        EV_IMPORTE_SEGURO           IN ev_prestsolic_scoring_to.IMPORTE_SEGURO%TYPE,
        EV_NUM_SOLSCORING           IN ev_prestsolic_scoring_to.NUM_SOLSCORING%TYPE,
        EV_COD_TECNOLOGIA           IN ev_prestsolic_scoring_to.COD_TECNOLOGIA%TYPE,
        EV_COD_SUBALM               IN ev_prestsolic_scoring_to.COD_SUBALM%TYPE,
        EV_COD_CAUSAVENTA           IN  ev_prestsolic_scoring_to.COD_CAUSAVENTA%TYPE,
        EV_COD_CAMPANA              IN  ev_prestsolic_scoring_to.COD_CAMPANA%TYPE,
        EV_COD_LIMCONSUMO           IN  ev_prestsolic_scoring_to.COD_LIMCONSUMO%TYPE,
        EV_IND_RENOVA               IN  ev_prestsolic_scoring_to.IND_RENOVA%TYPE,
        EV_TIP_TERMINAL             IN ev_prestsolic_scoring_to.TIP_TERMINAL%TYPE,
        EV_COD_CALIFICACION         IN ev_prestsolic_scoring_to.COD_CALIFICACION%TYPE,
        EN_IMP_LIMCONS              IN ev_prestsolic_scoring_to.IMP_LIMCONS%TYPE,
        SN_NUM_LINEASCORING         OUT ev_prestsolic_scoring_to.NUM_LINEASCORING%TYPE,
        SN_cod_retorno              OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno             OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento               OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_inserta_salidaScoring_PR(
        EV_NUM_SOLSCORING           IN EV_SALIDAWS_SCORING_TO.NUM_SOLSCORING%TYPE,
        EV_MENSAJE                  IN EV_SALIDAWS_SCORING_TO.MENSAJE%TYPE,
        EV_REFERENCIA               IN EV_SALIDAWS_SCORING_TO.REFERENCIA%TYPE,
        EV_CLASIFICACION            IN EV_SALIDAWS_SCORING_TO.CLASIFICACION%TYPE,
        EV_PUNTEO                   IN EV_SALIDAWS_SCORING_TO.PUNTEO%TYPE,
        SN_cod_retorno              OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno             OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento               OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_obtiene_lineaScoring_PR (EN_NUMLINEASCORING IN EV_PRESTSOLIC_SCORING_TO.NUM_LINEASCORING%TYPE,
                                          SC_cursorDatos   OUT NOCOPY REFCURSOR,
                                          SC_cursorSS      OUT NOCOPY REFCURSOR,
                                          SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_updLineaScoring_PR(EN_NUMLINEASCORING IN EV_PRESTSOLIC_SCORING_TO.NUM_LINEASCORING%TYPE,
                                    EN_NUMABONADO      IN EV_PRESTSOLIC_SCORING_TO.NUM_ABONADO%TYPE,
                                    SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_inserta_solScoringVta_PR(EN_NUM_SOLSCORING           IN EV_SOLSCORING_VENTA_TO.NUM_SOLSCORING%TYPE,
                                          EN_NUM_VENTA                IN EV_SOLSCORING_VENTA_TO.NUM_VENTA%TYPE,
                                          SN_cod_retorno              OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno             OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento               OUT NOCOPY ge_errores_pg.Evento);


   PROCEDURE VE_OBTIENE_ESTADOSDESTINO_PR ( EV_COD_PROGRAMA         IN  VE_ESTADOSOLIC_TD.COD_PROGRAMA%TYPE,
                                            EV_COD_ESTADOORIGEN     IN  VE_ESTADOSOLIC_TD.COD_ESTADOORIGEN%TYPE,
                                            EV_NOM_TABLA            IN  GED_CODIGOS.NOM_TABLA%TYPE,
                                            SC_cursorDatos          OUT NOCOPY REFCURSOR,
                                            SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento           OUT NOCOPY ge_errores_pg.Evento);

   PROCEDURE VE_calcula_capacidadpago_PR(EN_NUM_SOLSCORING           IN EV_SOLSCORING_VENTA_TO.NUM_SOLSCORING%TYPE,
                                         SN_CAPACIDAD_PAGO           OUT NOCOPY EV_ENTRADAWS_SCORING_TO.CAPACIDAD_PAGO%TYPE,
                                         SN_cod_retorno              OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno             OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento               OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_inserta_ServSup_PR(
            EV_NUM_SOLSCORING           IN EV_SS_SCORING_TO.NUM_SOLSCORING%TYPE,
			EV_NUM_LINEASCORING         IN EV_SS_SCORING_TO.NUM_LINEASCORING%TYPE,
            EV_COD_SERVICIO             IN EV_SS_SCORING_TO.COD_SERVICIO%TYPE,
            EV_IMPORTE_MENSUAL          IN EV_SS_SCORING_TO.IMPORTE_MENSUAL%TYPE,
			EV_COD_MONEDA_MENSUAL       IN EV_SS_SCORING_TO.COD_MONEDA_MENSUAL%TYPE,
            EV_IMPORTE_CONEXION          IN EV_SS_SCORING_TO.IMPORTE_CONEXION%TYPE,
			EV_COD_MONEDA_CONEXION         IN EV_SS_SCORING_TO.COD_MONEDA_CONEXION%TYPE,
            SN_cod_retorno              OUT NOCOPY ge_errores_pg.CodError,
            SV_mens_retorno             OUT NOCOPY ge_errores_pg.MsgError,
            SN_num_evento               OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_OBTIENE_NUMVENTA_PR ( EN_NUM_SOLSCORING       IN EV_SOLSCORING_VENTA_TO.NUM_SOLSCORING%TYPE,
                                       SN_NUM_VENTA            OUT NOCOPY EV_SOLSCORING_VENTA_TO.NUM_VENTA%TYPE,
                                       SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento           OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_OBTIENE_NUMSCORING_PR ( EN_NUM_VENTA          IN  EV_SOLSCORING_VENTA_TO.NUM_VENTA%TYPE,
                                       SN_NUM_SOLSCORING       OUT NOCOPY EV_SOLSCORING_VENTA_TO.NUM_SOLSCORING%TYPE,
                                       SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento           OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_obt_estScoring_X_tarjeta_PR (
        EV_COD_TIPTARJETASCL    IN EV_ENTRADAWS_SCORING_TO.COD_TIPTARJETASCL%TYPE,
        EV_NUM_TARJETA          IN EV_ENTRADAWS_SCORING_TO.NUM_TARJETA%TYPE,
        SC_CURSORDATOS          OUT NOCOPY REFCURSOR,
        SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento           OUT NOCOPY ge_errores_pg.Evento);
        
        
        
  PROCEDURE VE_get_ResultadoScoring_PR (
	    EV_NUM_SOLSCORING   IN EV_SALIDAWS_SCORING_TO.NUM_SOLSCORING%TYPE,
		SC_CURSORDATOS      OUT NOCOPY REFCURSOR,
		SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_PG.CODERROR,
		SV_MENS_RETORNO     OUT NOCOPY GE_ERRORES_PG.MSGERROR,
		SN_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.EVENTO);
        
 PROCEDURE VE_inserta_PA_PR( EV_NUM_SOLSCORING      IN EV_PA_SCORING_TO.NUM_SOLSCORING%TYPE,
			                 EV_NUM_LINEASCORING    IN EV_PA_SCORING_TO.NUM_LINEASSCORING%TYPE,
                             EN_COD_PROD_OFERTADO   IN EV_PA_SCORING_TO.COD_PROD_OFERTADO%TYPE,
                             EN_CANTIDAD            IN EV_PA_SCORING_TO.CANTIDAD%TYPE,
                             EN_COD_CLIENTE         IN EV_ENTRADAWS_SCORING_TO.COD_CLIENTE%TYPE,
                             SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
                             SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
                             SN_num_evento          OUT NOCOPY ge_errores_pg.Evento);

  PROCEDURE VE_consulta_PA_PR(EN_NUM_SOLSCORING      IN EV_PA_SCORING_TO.NUM_SOLSCORING%TYPE,
	                            SV_EXISTEN_PLANES      OUT NOCOPY VARCHAR2,
                                SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento          OUT NOCOPY ge_errores_pg.Evento);
                                
END VE_SOL_SCORING_PG;
/
SHOW ERRORS