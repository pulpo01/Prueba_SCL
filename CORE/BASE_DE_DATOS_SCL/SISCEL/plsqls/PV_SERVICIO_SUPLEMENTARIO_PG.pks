CREATE OR REPLACE PACKAGE SISCEL.Pv_Servicio_Suplementario_Pg
 IS
 TYPE refCursor       IS REF CURSOR;
 -- CV_version		      CONSTANT VARCHAR2(10):='2.0'; -- COL 70065|02-10-2008
 -- CV_version		      CONSTANT VARCHAR2(10):='2.1'; -- COL 70065|02-10-2008
 -- CV_version		      CONSTANT VARCHAR2(10) := '2.2'; -- COL 70065|07-10-2008|SAQL
 -- CV_version		      CONSTANT VARCHAR2(10) := '2.3'; -- COL-71848|10-11-2008|GEZ
 -- CV_version		      CONSTANT VARCHAR2(10) := '2.4'; -- COL 71848|04-12-2008|SAQL
  CV_version		      CONSTANT VARCHAR2(10) := '2.5'; -- COL 75438|12-01-2009|EFR

 CV_evento            CONSTANT VARCHAR2(10) := 'FORMLOAD';
 CN_cod_ooss_ss       CONSTANT VARCHAR2(5) := '10120';
 CV_cod_actabo_ss     CONSTANT VARCHAR(2) := 'SS';
 CV_ejecuta_commit    CONSTANT ged_parametros.nom_parametro%TYPE:='EJECUTA_COMMIT';
 CV_si_ejecuta_commit CONSTANT ged_parametros.nom_parametro%TYPE:='SI';
 CV_cod_modulo        CONSTANT ged_parametros.cod_modulo%TYPE:='GA';
 CV_cod_producto_post CONSTANT ged_parametros.cod_producto%TYPE:=1;

   NCOD_VENDEDOR        GE_SEG_USUARIO.COD_VENDEDOR%TYPE; -- COL 70065|02-10-2008|SAQL


-- Inicio Modificacion - Rodrigo Munoz E. - TM-200411151097 - 30/11/2004
--FUNCTION PV_RETORNA_VERSION_SS_FN RETURN VARCHAR2;
FUNCTION RETORNA_VERSION RETURN VARCHAR2;
-- Fin Modificacion - Rodrigo Munoz E. - TM-200411151097 - 30/11/2004

PROCEDURE PV_REC_SS_DISPONIBLES_PR(EN_num_celular   IN NUMBER,
             EV_usuario  IN VARCHAR2,
           tss_diponibles   OUT refCursor,
           SV_mensaje  OUT VARCHAR2,
           SV_error     OUT VARCHAR2
);

PROCEDURE PV_RECUPERA_SS_DIS_PR(EN_num_celular    IN GA_ABOCEL.NUM_ABONADO%TYPE,
         EN_cod_sistema   IN ICG_CENTRAL.COD_SISTEMA%TYPE,
         tSS_disponibles  OUT refCursor,
         SV_error       OUT VARCHAR2,
         SV_proc    OUT VARCHAR2,
         SV_tabla    OUT VARCHAR2,
         SV_act     OUT VARCHAR2,
         SV_sqlcode    OUT VARCHAR2,
         SV_sqlerrm    OUT VARCHAR2
);

FUNCTION PV_CHEQUEA_ANT_EQUIPO_FN(EN_num_abonado  IN GA_ABOCEL.NUM_ABONADO%TYPE,
           EV_tip_terminal IN GA_ABOCEL.TIP_TERMINAL%TYPE,
         SV_error      OUT VARCHAR2,
         SV_proc       OUT VARCHAR2,
         SV_tabla      OUT VARCHAR2,
         SV_act        OUT VARCHAR2,
         SV_sqlcode      OUT VARCHAR2,
         SV_sqlerrm      OUT VARCHAR2
)RETURN BOOLEAN;

PROCEDURE PV_RECUPERA_SS_ACT_PR(EN_num_abonado   IN GA_ABOCEL.NUM_ABONADO%TYPE,
         EV_cod_planserv  IN GA_ABOCEL.COD_PLANSERV%TYPE,
         tSS_contratados  OUT refCursor,
         SV_mensaje    OUT VARCHAR2,
         SV_error       OUT VARCHAR2,
         SV_proc    OUT VARCHAR2,
         SV_tabla    OUT VARCHAR2,
         SV_act     OUT VARCHAR2,
         SV_sqlcode    OUT VARCHAR2,
         SV_sqlerrm    OUT VARCHAR2
);

PROCEDURE PV_REC_PARAM_SS_ACT_PR(EN_num_celular   IN GA_ABOCEL.NUM_CELULAR%TYPE,
           EN_cod_central   IN GA_ABOCEL.COD_CENTRAL%TYPE,
         SN_cod_sistema   OUT ICG_CENTRAL.COD_SISTEMA%TYPE,
         SN_cod_plancom   OUT VE_PLANCOM.COD_PLANCOM%TYPE,
         SV_mensaje    OUT VARCHAR2,
         SV_error       OUT VARCHAR2,
         SV_proc    OUT VARCHAR2,
         SV_tabla    OUT VARCHAR2,
         SV_act     OUT VARCHAR2,
         SV_sqlcode    OUT VARCHAR2,
         SV_sqlerrm    OUT VARCHAR2
);

PROCEDURE PV_REC_SS_ACTIVOS_PR(EN_num_celular   IN GA_ABOCEL.NUM_CELULAR%TYPE,
            EV_usuario  IN GA_ABOCEL.NOM_USUARORA%TYPE,
          tss_activos      OUT refCursor,
          SV_mensaje  OUT VARCHAR2,
          SV_error     OUT VARCHAR2
);

PROCEDURE PV_ACTIVA_SS_PR(EN_num_celular   IN NUMBER,
         EV_servsupl     IN VARCHAR2,
         EV_cadena_servicio IN VARCHAR2,
       EV_usuario   IN VARCHAR2,
       SN_num_solicitud   OUT NUMBER,
       SV_mensaje   OUT VARCHAR2,
       SV_error      OUT VARCHAR2
);

FUNCTION PV_ASIGNA_CARGOS_FN      ( EN_cod_cliente   IN GA_ABOCEL.COD_CLIENTE%TYPE,
          EV_cod_planserv  IN GA_ABOCEL.COD_PLANSERV%TYPE,
             EN_num_abonado      IN GA_ABOCEL.NUM_ABONADO%TYPE,
          EN_num_terminal     IN GA_ABOCEL.NUM_CELULAR%TYPE,
          ED_fec_alta         IN GA_ABOCEL.FEC_ALTA%TYPE,
          EV_usuario          IN GE_CARGOS.NOM_USUARORA%TYPE,
          EV_cadena_servicio  IN VARCHAR2,
          SN_imp_total  OUT PV_MOVIMIENTOS.CARGA%TYPE,
          SV_error           OUT VARCHAR2,
          SV_proc            OUT VARCHAR2,
                    SV_tabla           OUT VARCHAR2,
                     SV_act          OUT VARCHAR2,
                     SV_sqlcode         OUT VARCHAR2,
                     SV_sqlerrm         OUT VARCHAR2
                     ) RETURN BOOLEAN;

PROCEDURE PV_DESACTIVA_SS_PR(EN_num_celular      IN NUMBER,
             EV_servsupl      IN VARCHAR2,
           EV_cadena_servicio  IN VARCHAR2,
         EV_usuario    IN VARCHAR2,
         SN_num_solicitud   OUT NUMBER,
         SV_mensaje   OUT VARCHAR2,
         SV_error      OUT VARCHAR2
);

PROCEDURE PV_REC_PARAM_SS_DIS_PR(EN_cod_central   IN GA_ABOCEL.COD_CENTRAL%TYPE,
          SN_cod_sistema    OUT ICG_CENTRAL.COD_SISTEMA%TYPE,
          SV_error      OUT VARCHAR2,
          SV_proc       OUT VARCHAR2,
          SV_tabla      OUT VARCHAR2,
          SV_act        OUT VARCHAR2,
          SV_sqlcode      OUT VARCHAR2,
          SV_sqlerrm      OUT VARCHAR2
);



PROCEDURE PV_ESTADO_TRANSACCION_SS_PR(EN_num_celular     IN GA_ABOCEL.NUM_CELULAR%TYPE,
             EN_num_ooss        IN PV_CAMCOM.NUM_OS%TYPE,
           EV_usuario    IN VARCHAR2,
           SV_mensaje      OUT VARCHAR2,
           SV_resp_estado     OUT VARCHAR2,
           SV_error     OUT VARCHAR2
);

FUNCTION PV_VALIDA_OOSS_FN(EN_num_celular    IN GA_ABOCEL.NUM_CELULAR%TYPE,
                    EN_num_ooss       IN PV_CAMCOM.NUM_OS%TYPE,
         SV_error      OUT VARCHAR2,
         SV_proc       OUT VARCHAR2,
         SV_tabla      OUT VARCHAR2,
         SV_act        OUT VARCHAR2,
         SV_sqlcode      OUT VARCHAR2,
         SV_sqlerrm      OUT VARCHAR2
)RETURN BOOLEAN;

FUNCTION PV_RECUPERA_ESTADO_OOSS_FN(EN_num_ooss  IN NUMBER,
         SV_estado_ooss     OUT VARCHAR2,
         SV_error      OUT VARCHAR2,
         SV_proc       OUT VARCHAR2,
         SV_tabla      OUT VARCHAR2,
         SV_act        OUT VARCHAR2,
         SV_sqlcode      OUT VARCHAR2,
         SV_sqlerrm      OUT VARCHAR2
)RETURN BOOLEAN;


FUNCTION PV_PRE_REQUISITO_SS_FN (EN_COD_PRODUCTO  IN GA_ABOCEL.COD_PRODUCTO%TYPE,
          EN_COD_OS     IN GA_SERVSUP_DEF.COD_SERVDEF%TYPE,
         EN_COD_CENTRAL   IN ICG_CENTRAL.COD_CENTRAL%TYPE,
         EV_TIP_TERMINAL  IN ICG_SERVICIOTERCEN.TIP_TERMINAL%TYPE,
         EV_TIP_TECNOLOGIA  IN ICG_SERVICIOTERCEN.TIP_TECNOLOGIA%TYPE,
         SV_DES_SS     IN OUT SISCEL.GE_TABTYPE_VCH2ARRAY,
         SV_COD_SS     IN OUT SISCEL.GE_TABTYPE_VCH2ARRAY,
         SN_TOTAL_SS  OUT NUMBER,
         SV_PROC            OUT VARCHAR2,
               SV_TABLA           OUT VARCHAR2,
               SV_ACT          OUT VARCHAR2,
               SV_SQLCODE         OUT VARCHAR2,
               SV_SQLERRM         OUT VARCHAR2,
               SV_ERROR           OUT VARCHAR2
) RETURN BOOLEAN;


FUNCTION PV_DES_SS_FN  (EV_COD_SERVICIO     IN GA_SERVSUPL.COD_SERVICIO%TYPE,
          EN_COD_PRODUCTO  IN GA_SERVSUPL.COD_PRODUCTO%TYPE,
      SV_ERROR           OUT VARCHAR2,
      SV_PROC            OUT VARCHAR2,
                    SV_TABLA           OUT VARCHAR2,
                  SV_ACT             OUT VARCHAR2,
                     SV_SQLCODE         OUT VARCHAR2,
                     SV_SQLERRM         OUT VARCHAR2
) RETURN GA_SERVSUPL.DES_SERVICIO%TYPE;

--INI COL-71848|10-11-2008|GEZ
FUNCTION PV_CADENASS_ACTDES_ABO_FN(EN_NumAbonado  	 IN  			 ga_abocel.num_abonado%TYPE,
							       EV_AccionAct		 IN	 			 VARCHAR2,
							   	   EV_AccionDes		 IN	 			 VARCHAR2,
							   	   EV_FormatoDes	 IN	 			 VARCHAR2,
							   	   EV_Central		 IN	 			 VARCHAR2,
							   	   SVEstado			 OUT NOCOPY 	 VARCHAR2,
							   	   SVProc			 OUT NOCOPY 	 VARCHAR2,
							   	   SNCodMsg			 OUT NOCOPY 	 NUMBER,
							   	   SNEvento			 OUT NOCOPY 	 NUMBER,
							   	   SVTabla			 OUT NOCOPY 	 VARCHAR2,
							   	   SVAct			 OUT NOCOPY 	 VARCHAR2,
							   	   SVCode			 OUT NOCOPY 	 VARCHAR2,
							   	   SVErrm			 OUT NOCOPY 	 VARCHAR2)RETURN VARCHAR2;
--FIN COL-71848|10-11-2008|GEZ

-- INI COL|71848|04-12-2008|SAQL
PROCEDURE PV_CADENASS_ACTDES_ABO_PR(
   EN_NumAbonado  IN          ga_abocel.num_abonado%TYPE,
   EV_AccionAct   IN          VARCHAR2,
   EV_AccionDes   IN          VARCHAR2,
   EV_FormatoDes  IN          VARCHAR2,
   EV_Central     IN          VARCHAR2,
   SVCadena       OUT NOCOPY  VARCHAR2,
   SVEstado       OUT NOCOPY  VARCHAR2,
   SVProc         OUT NOCOPY  VARCHAR2,
   SNCodMsg       OUT NOCOPY  NUMBER,
   SNEvento       OUT NOCOPY  NUMBER,
   SVTabla        OUT NOCOPY  VARCHAR2,
   SVAct          OUT NOCOPY  VARCHAR2,
   SVCode         OUT NOCOPY  VARCHAR2,
   SVErrm         OUT NOCOPY  VARCHAR2
);
-- FIN COL|71848|04-12-2008|SAQL

END PV_SERVICIO_SUPLEMENTARIO_PG;
/
SHOW ERRORS
