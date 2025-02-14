CREATE OR REPLACE PACKAGE PV_ACTCAMBIOS_OFVIRTUAL_PG

/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "PV_ACTCAMBIOS_OFVIRTUAL_PG"
    Lenguaje="PL/SQL"
    Fecha="14-11-2005"
    Versión="1.0"
    Diseñador="Christian Estay"
    Programador="CAGV"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package que permite realizar cambios al abonado>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/
---------------------------------------
--V1.1 INC 160153 GUA JRCH 28-12-2010
---------------------------------------
IS
       TYPE arreglo IS VARRAY(255) OF VARCHAR2(255);

     CV_error_no_clasIF            CONSTANT     VARCHAR2 (100):= 'Error NO Clasificado';
     CV_cod_modulo                CONSTANT      VARCHAR2(3) :='PV';
     CV_cod_situacionBAA           CONSTANT     GA_ABOAMIST.cod_situacion%TYPE  :='BAA';
     CV_cod_situacionBAP           CONSTANT     GA_ABOAMIST.cod_situacion%TYPE  :='BAP';
      CV_cod_tecnologia            CONSTANT     GA_ABOAMIST.cod_tecnologia%TYPE :='GSM';
     CV_cod_modulo_gral            CONSTANT     GA_ACTABO.cod_modulo%TYPE :='GA';
     CV_cod_actabo                CONSTANT     GA_ACTABO.cod_actabo%TYPE :='BP';
     CN_largoquery                CONSTANT     NUMBER:=3000;
       CN_largoerrtec                CONSTANT     NUMBER:=500;
       CN_largodesc                CONSTANT     NUMBER:=1000;
     LR_DatAbonado                GA_ABOCEL%ROWTYPE;
     LV_tabla_abo                VARCHAR2(15);

     GV_sSERVICIO_AUTENTICACION    VARCHAR(6);

-------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_cambioserie_PR(
    EN_num_celular      IN               GA_ABOCEL.num_celular%TYPE ,
    EV_num_serie_equ    IN              GA_ABOCEL.num_imei%TYPE ,
    EV_num_serie_sim    IN              GA_ABOCEL.num_serie%TYPE ,
    EN_cod_vendedor     IN              VE_VENDEDORES.cod_vendedor%TYPE ,
    EV_nom_usuario      IN              GE_SEG_USUARIO.nom_usuario%TYPE ,
    EV_cod_central      IN              GA_ABOCEL.cod_central%TYPE ,
    EN_imp_cargo        IN                GA_EQUIPABOSER.imp_cargo%TYPE ,
    EV_cod_tipcontrato    IN                GA_TIPCONTRATO.cod_tipcontrato%TYPE ,
    EV_num_contrato        IN                 GA_ABOCEL.num_contrato%TYPE ,
    EV_num_anexo        IN                GA_ABOCEL.num_anexo%TYPE ,
    EV_cod_causa        IN                GA_CAUCASER.cod_caucaser%TYPE ,
    EN_numTranEquipo    IN                GA_EQUIPABOSER.NUM_MOVIMIENTO%TYPE,
    EN_numTranSimcard    IN                GA_EQUIPABOSER.NUM_MOVIMIENTO%TYPE,
    EN_cod_uso            IN                ga_equipaboser.cod_uso%TYPE,
    EN_cod_articulo        IN                ga_equipaboser.cod_articulo%TYPE,
    EV_des_equipo        IN                ga_equipaboser.des_equipo%TYPE,
    EN_carga            IN                icc_movimiento.carga%TYPE,
    EV_prcventa         IN              ga_equipaboser.PRC_VENTA%TYPE,
    EV_tipdto           IN              ga_equipaboser.TIP_DTO%TYPE,
    EV_valdto           IN              ga_equipaboser.VAL_DTO%TYPE,
    SV_ind_operacion    OUT NOCOPY       PLS_INTEGER,
    SN_cod_retorno      OUT NOCOPY       ge_errores_pg.codError,
    SV_mens_retorno     OUT NOCOPY       ge_errores_pg.MsgError,
    SN_num_evento       OUT NOCOPY       ge_errores_pg.Evento);

-------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_obtiene_grupo_tecnologia_FN(
                            EV_cod_tecnologia    IN  AL_TECNOLOGIA.cod_tecnologia%TYPE ,
                            SV_cod_grupo        OUT NOCOPY   AL_TECNOLOGIA.cod_grupo%TYPE ,
                            SN_cod_retorno      OUT NOCOPY   ge_errores_pg.codError,
                            SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                            SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento);
-------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_RecPlantarifDes_PR (EV_plan_tarif_abo           IN ta_plantarif.cod_plantarif%TYPE,
                                   EV_cod_tecnologia_ori     IN ga_equipaboser.cod_tecnologia%TYPE,
                                 EV_cod_tecnologia_des       IN ga_equipaboser.cod_tecnologia%TYPE,
                                 SV_plan_tarif_des           OUT NOCOPY ta_plantarif.des_plantarif%TYPE,
                                 SN_cod_retorno               OUT NOCOPY ge_errores_pg.codError,
                                 SV_mens_retorno           OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_num_evento               OUT NOCOPY ge_errores_pg.Evento);
-------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_RecPrecioVenta_PR(EV_num_serie    IN al_series.NUM_SERIE%TYPE,
                               EV_num_abonado  IN ga_abocel.NUM_ABONADO%TYPE,
                               EV_cod_modventa IN al_precios_venta.COD_MODVENTA%TYPE,
                               SV_precio_venta        OUT NOCOPY al_precios_venta.PRC_VENTA%TYPE,
                               SN_cod_retorno        OUT NOCOPY ge_errores_pg.codError,
                               SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
                               SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);

--INI INC 160153 GUA JRCH 27-12-2010
PROCEDURE PV_UP_CARGOINME_EQUIP_PR ( EV_num_serie    IN  al_series.NUM_SERIE%type,
                                     EV_num_abonado  IN  ga_abocel.NUM_ABONADO%TYPE,
                                     SN_cod_retorno  OUT NOCOPY  ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY  ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY  ge_errores_pg.Evento
                                 );
--FIN INC 160153 GUA JRCH 27-12-2010
PROCEDURE PV_movi_equiposimcard_PR (  EN_num_serie        IN   al_series.NUM_SERIE%type,
                                      EN_NUM_VENTA        IN   GA_ABOCEL.NUM_VENTA%TYPE,
                                      EN_NUM_ABONADO      IN   GA_ABOCEL.NUM_ABONADO%TYPE,
                                      SN_cod_retorno      OUT  NOCOPY     ge_errores_pg.CodError,
                                      SV_mens_retorno     OUT  NOCOPY     ge_errores_pg.MsgError,
                                      SN_num_evento       OUT  NOCOPY     ge_errores_pg.Evento
                                 );
END Pv_Actcambios_Ofvirtual_Pg;
/
