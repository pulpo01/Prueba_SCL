CREATE OR REPLACE PACKAGE GA_CONSULTAS_PG
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "GA_CONSULTA_ABONADO_PG"
    Lenguaje="PL/SQL"
    Fecha="27-04-2005"
    Versión="2.0"
    Diseñador=""Fernando Garcia E."
    Programador="Jubitza Villanueva G."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package que permite retornar los atributos mas comunmente consultados del abonado ECU-050050</Descripción>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/
IS
  CV_version                CONSTANT   VARCHAR2(2) := '2';
  CV_subversion             CONSTANT   VARCHAR2(2) := '0';
  CV_error_no_clasif   CONSTANT   VARCHAR2(30):='Error no clasificado';
  CV_cod_modulo       CONSTANT   ged_parametros.cod_modulo%TYPE:='GA';
  CV_actuacion       CONSTANT   PV_ACTUAC_RESTRICCION.cod_actuacion%TYPE:='GG';
  CN_largoquery    CONSTANT   NUMBER:=3000;
  CN_largoerrtec   CONSTANT   NUMBER:=500;
  CN_largodesc    CONSTANT   NUMBER:=1000;
  CV_cod_modulo_ge   CONSTANT   ged_codigos.cod_modulo%TYPE:='GE';
  CV_nom_tabla     CONSTANT   ged_codigos.nom_tabla%TYPE:='TA_PLANTARIF';
  CV_nom_columna   CONSTANT   ged_codigos.nom_columna%TYPE:='COD_TIPLAN';
  CN_cod_producto   CONSTANT   ta_plantarif.cod_producto%TYPE:=1;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONSULTA_ABONADO_PR (EN_num_celular   IN  ga_abocel.num_celular%TYPE,
          SN_num_abonado   OUT NOCOPY  ga_abocel.num_abonado%TYPE,
          SN_cod_cliente   OUT NOCOPY  ga_abocel.cod_cliente%TYPE,
          SN_cod_producto  OUT NOCOPY  ga_abocel.cod_producto%TYPE,
          SV_cod_situacion OUT NOCOPY  ga_abocel.cod_situacion%TYPE,
           SV_tip_plantarif OUT NOCOPY  ga_abocel.tip_plantarif%TYPE,
          SV_cod_plantarif OUT NOCOPY  ga_abocel.cod_plantarif%TYPE,
          SV_num_serie     OUT NOCOPY  ga_abocel.num_serie%TYPE,
          SN_cod_ciclo    OUT NOCOPY  ga_abocel.cod_ciclo%TYPE,
          SV_tecnologia    OUT NOCOPY  ga_abocel.cod_tecnologia%TYPE,
          SV_num_imei      OUT NOCOPY  ga_abocel.num_imei%TYPE,
          SV_num_min_mdn   OUT NOCOPY  ga_abocel.num_min_mdn%TYPE,
          SV_cod_password  OUT NOCOPY  ga_abocel.cod_password%TYPE,
          SV_num_min       OUT NOCOPY  ga_abocel.num_min%TYPE,
          SV_tip_terminal  OUT NOCOPY  ga_abocel.tip_terminal%TYPE,
          SV_num_seriehex  OUT NOCOPY  ga_abocel.num_seriehex%TYPE,
          SV_num_seriemec  OUT NOCOPY  ga_abocel.num_seriemec%TYPE,
          SV_tipo_abonado  OUT NOCOPY  VARCHAR2,
          SN_cod_cuenta    OUT NOCOPY  ga_abocel.cod_cuenta%TYPE,
            SN_cod_retorno   OUT NOCOPY  ge_errores_pg.CodError,
             SV_mens_retorno  OUT NOCOPY  ge_errores_pg.MsgError,
             SN_num_evento    OUT NOCOPY  ge_errores_pg.Evento
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONSULTA_CLIENTE_PR (EN_cod_cliente   IN ga_abocel.cod_cliente%TYPE,
          SN_cod_cuenta    OUT NOCOPY  ge_clientes.cod_cuenta%TYPE,
          SN_cod_categoria OUT NOCOPY  ge_clientes.cod_categoria%TYPE,
           SV_cod_tipident  OUT NOCOPY  ge_clientes.cod_tipident%TYPE,
          SV_num_ident     OUT NOCOPY  ge_clientes.num_ident%TYPE,
          SV_des_tipident  OUT NOCOPY  ge_tipident.des_tipident%TYPE,
            SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
             SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
             SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONSULTA_CUENTA_PR (EN_cod_cuenta       IN  ga_cuentas.cod_cuenta%TYPE,
          SV_cod_catribut    OUT NOCOPY  ga_cuentas.cod_catribut%TYPE,
           SV_tip_cuenta      OUT NOCOPY  ga_cuentas.tip_cuenta%TYPE,
            SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
             SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
             SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
                                  );
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONSULTA_CUENTA_PR (EN_cod_cuenta       IN         ga_cuentas.cod_cuenta%TYPE,
              SV_cod_tipident     OUT NOCOPY ga_cuentas.cod_tipident%TYPE,
                  SV_num_ident        OUT NOCOPY ga_cuentas.num_ident%TYPE,
                  SV_nom_responsable  OUT NOCOPY ga_cuentas.nom_responsable%TYPE,
                  SN_cod_direccion    OUT NOCOPY ga_cuentas.cod_direccion%TYPE,
                  SV_tip_cuenta       OUT NOCOPY ga_cuentas.tip_cuenta%TYPE,
           SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
            SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
            SN_num_evento       OUT NOCOPY ge_errores_pg.Evento
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONSULTA_COMPOR_CLIENTE_PR (EN_cod_cliente   IN ga_abocel.cod_cliente%TYPE,
           SV_cod_valor     OUT NOCOPY  ge_valores_cli.cod_valor%TYPE,
           SV_des_valor     OUT NOCOPY  ge_valores_cli.des_valor%TYPE,
            SN_cod_retorno   OUT NOCOPY  ge_errores_pg.CodError,
             SV_mens_retorno  OUT NOCOPY  ge_errores_pg.MsgError,
             SN_num_evento    OUT NOCOPY  ge_errores_pg.Evento
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONSULTA_TIPO_PRODUCTO_PR (EV_cod_plantarif IN          ga_abocel.cod_plantarif%TYPE,
                SV_cod_tiplan    OUT NOCOPY  ged_codigos.cod_valor%TYPE,
             SV_des_tiplan    OUT NOCOPY  ged_codigos.des_valor%TYPE,
              SN_cod_retorno   OUT NOCOPY  ge_errores_pg.CodError,
               SV_mens_retorno  OUT NOCOPY  ge_errores_pg.MsgError,
               SN_num_evento    OUT NOCOPY  ge_errores_pg.Evento
                                    );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_version_fn  RETURN VARCHAR2;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONSULTA_ABONADO_PR (EN_num_abonado      IN          ga_abocel.num_abonado%TYPE,
								  SV_clase_servicio   OUT NOCOPY  ga_abocel.clase_servicio%TYPE,
								  SV_perfil_abonado   OUT NOCOPY  ga_abocel.perfil_abonado%TYPE,
								  SV_cod_planserv     OUT NOCOPY  ga_abocel.cod_planserv%TYPE,
								  SN_num_venta        OUT NOCOPY  ga_ventas.num_venta%TYPE,
  								  SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
   								  SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
   								  SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento
                                  );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END GA_CONSULTAS_PG;
/
SHOW ERRORS
