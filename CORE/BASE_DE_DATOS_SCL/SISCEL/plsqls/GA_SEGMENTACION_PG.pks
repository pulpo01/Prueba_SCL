CREATE OR REPLACE PACKAGE Ga_Segmentacion_Pg
/*
<Documentación
 TipoDoc = "Package">
 <Elemento
     Nombre = "GA_SEGMENTACION_PG"
     Lenguaje="PL/SQL"
     Fecha="18-06-2005"
     Versión="2.0"
     Diseñador="Carlos Navarro H. - Marcelo Godoy S."
     Programador="Marcelo Godoy S. - Carlos Navarro H."
	 Fecha de modificación="07-09-2005"
     Diseñador de modificación="Fernando Garcia"
     Programador de modificación="Jubitza Villanueva G."
	 Descripción de modificación="Se agrega funcionalidad ga_responsable_cuenta_pr"
     Ambiente Desarrollo="BD">
     <Retorno>NA</Retorno>
     <Descripción>Package negocio de consulta de segmentación y validación del celular</Descripción>
     <Parámetros>
        <Entrada>NA</Entrada>
        <Salida>NA</Salida>
     </Parámetros>
  </Elemento>
 </Documentación>
*/
IS
   CV_version            CONSTANT VARCHAR2(2):='2';
   CV_subversion         CONSTANT VARCHAR2(2) :='0';
   cv_error_no_clasif    CONSTANT VARCHAR2(30):='Error no clasificado';
   cv_cod_modulo         CONSTANT VARCHAR(2):= 'GA';
   cn_cod_producto       CONSTANT NUMBER(1):= 1;
   cn_largoquery         CONSTANT NUMBER(4):= 3000;
   cn_largodesc          CONSTANT NUMBER(3):= 100;
   cn_largoerrtec        CONSTANT NUMBER(3):= 500;
   cn_largo_nomcli       CONSTANT NUMBER(2):= 91;
   cn_1                  CONSTANT NUMBER(1):= 1;
   cn_2                  CONSTANT NUMBER(1):= 2;
   cn_4                  CONSTANT NUMBER(1):= 4;
   cn_8                  CONSTANT NUMBER(1):= 8;
   -- Estructura de ga_segmentacion.ga_origen_cliente_pr --
   gn_num_abonado                GA_ABOCEL.NUM_ABONADO%TYPE;
   gn_cod_cliente                GA_ABOCEL.cod_cliente%TYPE;
   gn_cod_ciclo                  GA_ABOCEL.cod_ciclo%TYPE;
   gn_fono_contacto              VARCHAR2 (15);
   gn_cod_cuenta                 GA_ABOCEL.cod_cuenta%TYPE;
   gv_cod_transaccion            VARCHAR2 (2);
   gv_nom_abocli                 VARCHAR2 (91);
   gv_cod_situacion              GA_ABOCEL.cod_situacion%TYPE;
   gv_cod_clave                  VARCHAR2 (7);
   gv_tip_plantarif              GA_ABOCEL.tip_plantarif%TYPE;
   gv_cod_plantarif              GA_ABOCEL.cod_plantarif%TYPE;
   -- gv_cod_tecnología             GA_ABOCEL.cod_tecnologia%TYPE;RA-200511170  PBR 10/01/2006
   gv_cod_perfil                 VARCHAR2 (70);
   gv_num_serie                  GA_ABOCEL.num_serie%TYPE;
   gv_num_imei                   GA_ABOCEL.num_imei%TYPE;
   gv_num_min_mdn                GA_ABOCEL.num_min_mdn%TYPE;
   gv_num_min                    GA_ABOCEL.num_min%TYPE;
   gv_num_seriehex               GA_ABOCEL.num_seriehex%TYPE;
   gv_num_seriemec               GA_ABOCEL.num_seriemec%TYPE;
   gv_tip_terminal               GA_ABOCEL.tip_terminal%TYPE;
   gv_tip_abonado                TA_PLANTARIF.cod_tiplan%TYPE;
   gv_des_plantarif              TA_PLANTARIF.des_plantarif%TYPE;
   gv_cod_estado                 GA_ABOCEL.cod_estado%TYPE;
   gv_cod_tecnologia             GA_ABOCEL.cod_tecnologia%TYPE;
   gn_cod_producto               GA_ABOCEL.cod_producto%TYPE;
   gv_nom_responsable            GA_CUENTAS.nom_responsable%TYPE;
   cv_nom_usuario                CI_REG_ATENCION_CLIENTES.nom_usuarora%TYPE:=USER;

   cv_mens_atendio       CONSTANT VARCHAR2(23):='Se atendió al celular: ';
   cv_cod_tipdocum       CONSTANT VARCHAR2(30):='COD_TIPDOCUM';
   cv_co_cartera         CONSTANT VARCHAR2(30):='CO_CARTERA';
   CV_comportamiento	 CONSTANT VARCHAR2(2):='SI';
   CV_nom_tabla			 CONSTANT GED_CODIGOS.nom_tabla%TYPE:='GA_TIP_CUENTA_VALIDOS_TO';
   CV_nom_columna		 CONSTANT GED_CODIGOS.nom_columna%TYPE:='TIP_CUENTA';
   CV_nom_param_valida   CONSTANT GED_PARAMETROS.nom_parametro%TYPE:='NUM_ABONADOS_CLIENTE';
   CV_ejecute_validacion CONSTANT VARCHAR2(2):='SI';

   SUBTYPE codcliente         IS GE_CLIENTES.cod_cliente%TYPE;
   SUBTYPE codtipident        IS GA_CUENTAS.cod_tipident%TYPE;
   SUBTYPE numident           IS GA_CUENTAS.num_ident%TYPE;
   SUBTYPE nomresponsable     IS GA_CUENTAS.nom_responsable%TYPE;
   SUBTYPE obsdireccion       IS GE_DIRECCIONES.obs_direccion%TYPE;

   LV_PREFIJOX		    VARCHAR2(4);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ga_valida_cliente_fn (
        EN_cod_cliente    IN         GE_CLIENTES.cod_cliente%TYPE,
        EV_comportamiento IN         VARCHAR2 DEFAULT 'NO',
        SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
   RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ga_valida_codigos_fn(
        EV_cod_modulo     IN         GED_CODIGOS.cod_modulo%TYPE,
        EV_nom_tabla      IN         GED_CODIGOS.nom_tabla%TYPE,
        EV_nom_columna    IN         GED_CODIGOS.nom_columna%TYPE,
        EV_cod_valor      IN         GED_CODIGOS.cod_valor%TYPE,
        SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
   RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_cantidad_abonados_pr(
        EN_cod_cliente    IN         GE_CLIENTES.cod_cliente%TYPE,
        EN_tipo_abonado   IN         NUMBER,
        SN_cantidad       OUT NOCOPY NUMBER,
        SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION ga_valida_existabonado_fn (
      en_num_celular    IN              GA_ABOCEL.num_celular%TYPE,
      sn_num_abonado    OUT NOCOPY      GA_ABOCEL.NUM_ABONADO%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION ga_recupera_valor_cliente_fn (
      en_num_abonado    IN              GA_ABOCEL.NUM_ABONADO%TYPE,
--      sv_val_cliente    OUT NOCOPY      GE_VALORES_CLI.des_valor%TYPE, --34157, 14-09-2006 EFR/post-venta
      sv_val_cliente    OUT NOCOPY      ga_valor_cli.cod_valor%TYPE, --34157, 14-09-2006 EFR/post-venta
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION ga_valida_num_celular_fn (
      en_num_celular    IN              GA_ABOCEL.num_celular%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ga_recupera_parametros_fn (
      ev_nom_parametro   IN              GED_PARAMETROS.nom_parametro%TYPE,
      ev_cod_modulo      IN              GED_PARAMETROS.cod_modulo%TYPE,
      en_cod_producto    IN              GED_PARAMETROS.cod_producto%TYPE,
      ev_comportamiento  IN              VARCHAR2,
      sv_val_parametro   OUT NOCOPY      GED_PARAMETROS.val_parametro%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION ga_recupera_parametros_fn (
      ev_nom_parametro   IN              GED_PARAMETROS.nom_parametro%TYPE,
      ev_cod_modulo      IN              GED_PARAMETROS.cod_modulo%TYPE,
      en_cod_producto    IN              GED_PARAMETROS.cod_producto%TYPE,
      sv_val_parametro   OUT NOCOPY      GED_PARAMETROS.val_parametro%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_reg_atencion_cliente_pr (
      en_num_celular    IN              GA_ABOCEL.num_celular%TYPE,
      en_cod_atencion   IN              CI_REG_ATENCION_CLIENTES.cod_atencion%TYPE,
      ev_obs_atencion   IN              CI_REG_ATENCION_CLIENTES.obs_atencion%TYPE,
      ev_nom_usuario    IN              CI_REG_ATENCION_CLIENTES.nom_usuarora%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION ga_origen_cliente_fn (
      en_num_celular       IN              GA_ABOCEL.num_celular%TYPE,
      sn_num_abonado       OUT NOCOPY      GA_ABOCEL.NUM_ABONADO%TYPE,
      sn_cod_cliente       OUT NOCOPY      GA_ABOCEL.cod_cliente%TYPE,
      sv_nom_abocli        OUT NOCOPY      VARCHAR2,
      sv_cod_situacion     OUT NOCOPY      GA_ABOCEL.cod_situacion%TYPE,
      sn_cod_cuenta        OUT NOCOPY      GA_ABOCEL.cod_cuenta%TYPE,
      sv_cod_clave         OUT NOCOPY      GA_ABOCEL.cod_password%TYPE,
      sv_tip_plantarif     OUT NOCOPY      GA_ABOCEL.tip_plantarif%TYPE,
      sv_cod_plantarif     OUT NOCOPY      GA_ABOCEL.cod_plantarif%TYPE,
      sv_cod_tecnología    OUT NOCOPY      GA_ABOCEL.cod_tecnologia%TYPE,
      sv_cod_perfil        OUT NOCOPY      VARCHAR2,
      sn_cod_ciclo         OUT NOCOPY      GA_ABOCEL.cod_ciclo%TYPE,
      sn_fono_contacto     OUT NOCOPY      VARCHAR2,
      sv_num_serie         OUT NOCOPY      VARCHAR2,
      sv_num_imei          OUT NOCOPY      VARCHAR2,
      sv_num_min_mdn       OUT NOCOPY      VARCHAR2,
      sv_num_min           OUT NOCOPY      VARCHAR2,
      sv_num_seriehex      OUT NOCOPY      VARCHAR2,
      sv_num_seriemec      OUT NOCOPY      VARCHAR2,
      sv_tip_terminal      OUT NOCOPY      VARCHAR2,
      sv_tip_abonado       OUT NOCOPY      VARCHAR2,
      sv_cod_estado        OUT NOCOPY      VARCHAR2,
      sn_cod_producto      OUT NOCOPY      GA_ABOCEL.cod_producto%TYPE,
      sv_nom_responsable   OUT NOCOPY      VARCHAR2,
      sv_des_plantarif     OUT NOCOPY      VARCHAR2,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

----------------------------------------------------------------------------------------------------------------------

PROCEDURE ga_consulta_segmentacion_pr (
  								EN_num_celular		 IN NUMBER,
								SN_num_abonado		 OUT NOCOPY GA_ABOCEL.NUM_ABONADO%TYPE,
								SV_nom_abocli		 OUT NOCOPY VARCHAR2,
								SV_cod_perfil		 OUT NOCOPY VARCHAR2,
								SV_signo_saldo_cta	 OUT NOCOPY VARCHAR2,
								SV_saldo_cta		 OUT NOCOPY VARCHAR2,
								SV_saldo_30_dias 	 OUT NOCOPY VARCHAR2,
								SV_saldo_60_dias	 OUT NOCOPY VARCHAR2,
								SV_saldo_90_dias	 OUT NOCOPY VARCHAR2,
								SV_saldo_120_dias	 OUT NOCOPY VARCHAR2,
								SV_cod_suspendido	 OUT NOCOPY VARCHAR2,
								SV_valor_ult_pago	 OUT NOCOPY VARCHAR2,
								SV_fecha_ult_pago	 OUT NOCOPY DATE,
								SV_fecha_limite_pago OUT NOCOPY DATE,
								/* Inicio modificacion by SAQL/Soporte 16/03/2006 - RA-200603160913 */
								/* SN_cod_cuenta		 OUT NOCOPY NUMBER, */
								SN_COD_CLIENTE		 OUT NOCOPY NUMBER,
								/* Fin modificacion by SAQL/Soporte 16/03/2006 - RA-200603160913 */
								SV_estado_servicio	 OUT NOCOPY VARCHAR2,
								SV_cod_clave		 OUT NOCOPY VARCHAR2,
								SV_cod_plantarif	 OUT NOCOPY VARCHAR2,
								SV_fecha_corte		 OUT NOCOPY DATE,
								/* Inicio modificacion by SAQL/Soporte 07/10/2006 - 34683 */
								/* SN_cont_tasación	 OUT NOCOPY NUMBER, */
								SN_cont_tasacion	 OUT NOCOPY NUMBER,
								/* Fin modificacion by SAQL/Soporte 07/10/2006 - 34683 */
								SV_ind_servicios	 OUT NOCOPY VARCHAR2,
								SV_des_plantarif	 OUT NOCOPY VARCHAR2,
								SN_VAL_MINTOTAL	     OUT NOCOPY	NUMBER,
								SN_VAL_USADO         OUT NOCOPY NUMBER,
								SN_VAL_DISPONIBLE    OUT NOCOPY	NUMBER,
								SN_USADO_BOLSA       OUT NOCOPY	NUMBER,
								SN_DISPONIBLE_BOLSA  OUT NOCOPY NUMBER,
								SV_PLANX01      	 OUT NOCOPY VARCHAR2,
		 					  	SV_PLANX02      	 OUT NOCOPY VARCHAR2,
							  	SV_PLANX03      	 OUT NOCOPY VARCHAR2,
							  	SV_PLANX04      	 OUT NOCOPY VARCHAR2,
							  	SV_PLANX05      	 OUT NOCOPY VARCHAR2,
							  	SV_PLANX06      	 OUT NOCOPY VARCHAR2,
							  	SV_PLANX07      	 OUT NOCOPY VARCHAR2,
							  	SV_PLANX08      	 OUT NOCOPY VARCHAR2,
							  	SV_PLANX09      	 OUT NOCOPY VARCHAR2,
							  	SV_PLANX10      	 OUT NOCOPY VARCHAR2,
								SN_cod_retorno		 OUT NOCOPY NUMBER,
								SV_mens_retorno		 OUT NOCOPY VARCHAR2,
								SN_num_evento		 OUT NOCOPY NUMBER
	  						  );

----------------------------------------------------------------------------------------------------------------------

   PROCEDURE ga_consulta_nomcliente_pr (
      en_num_celular    IN              NUMBER,
      sv_nom_cliente    OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2,
      sn_num_evento     OUT NOCOPY      NUMBER
   );

----------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_fonocontacto_pr (
      en_num_celular     IN              NUMBER,
      sv_fono_contacto   OUT NOCOPY      VARCHAR2,
      sn_cod_retorno     OUT NOCOPY      NUMBER,
      sv_mens_retorno    OUT NOCOPY      VARCHAR2,
      sn_num_evento      OUT NOCOPY      NUMBER
   );

----------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_numabonado_pr (
      en_num_celular    IN              NUMBER,
      sn_num_abonado    OUT NOCOPY      NUMBER,
      sn_cod_retorno    OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2,
      sn_num_evento     OUT NOCOPY      NUMBER
   );

----------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_tipoplan_pr (
      en_num_celular     IN              NUMBER,
      sv_tip_plantarif   OUT NOCOPY      VARCHAR2,
      sn_cod_retorno     OUT NOCOPY      NUMBER,
      sv_mens_retorno    OUT NOCOPY      VARCHAR2,
      sn_num_evento      OUT NOCOPY      NUMBER
   );

----------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_numcelular_pr (
      en_num_celular    IN              NUMBER,
      sn_cod_retorno    OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2,
      sn_num_evento     OUT NOCOPY      NUMBER
   );

----------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_responsable_pr (
      en_num_celular    IN              NUMBER,
      sv_responsable    OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2,
      sn_num_evento     OUT NOCOPY      NUMBER
   );

----------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_producto_pr (
      en_num_celular    IN              NUMBER,
      sv_des_producto   OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2,
      sn_num_evento     OUT NOCOPY      NUMBER
   );

----------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_ejecuta_restriccion_pr (
      ev_cod_modulo      IN              VARCHAR2,
      en_cod_producto    IN              NUMBER,
      ev_cod_actuacion   IN              VARCHAR2,
      ev_num_evento      IN              VARCHAR2,
      ev_param_entrada   IN              VARCHAR2,
      sn_cod_retorno     OUT NOCOPY      NUMBER,
      sv_mens_retorno    OUT NOCOPY      VARCHAR2,
      sn_num_evento      OUT NOCOPY      NUMBER
   );
----------------------------------------------------------------------------------------------------------------------
    PROCEDURE ga_responsable_cuenta_pr (
	  EN_cod_cliente     IN              GE_CLIENTES.cod_cliente%TYPE,
	  SV_cod_tipident    OUT NOCOPY 	 GA_CUENTAS.cod_tipident%TYPE,
      SV_num_ident       OUT NOCOPY 	 GA_CUENTAS.num_ident%TYPE,
      SV_nom_responsable OUT NOCOPY 	 GA_CUENTAS.nom_responsable%TYPE,
      SV_obs_direccion   OUT NOCOPY 	 GE_DIRECCIONES.obs_direccion%TYPE,
      SN_cod_retorno     OUT NOCOPY 	 ge_errores_pg.coderror,
      SV_mens_retorno    OUT NOCOPY 	 ge_errores_pg.msgerror,
      SN_num_evento      OUT NOCOPY 	 ge_errores_pg.evento
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ga_version_fn RETURN VARCHAR2;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END Ga_Segmentacion_Pg;
/
SHOW ERRORS
