CREATE OR REPLACE PACKAGE PV_PENALIZACION_PG
AS
/*--   
        <Documentacion TipoDoc = "PACKAGE>
            Elemento Nombre = "PV_PENALIZACION_PG"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¤ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno>  </Retorno>
        <Descripcion>
            Penalizacion por Cliente / Abonado
        </Descripcion>
        <Parametros>
        <Entrada>
        </Entrada>
        <Salida>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
        
TYPE trecord IS RECORD (
      num_abonado ga_abocel.num_abonado%type,
      fec_emision fa_histdocu.fec_emision%type,
      tot_notcredito number(14,4)
   );
TYPE trecord_tab IS TABLE OF trecord INDEX BY BINARY_INTEGER;
  nc_abonado trecord_tab;


TYPE trecord_notcred IS RECORD (
      num_abonado ga_abocel.num_abonado%type,
      num_count   number
   );
TYPE trecord_tab_notacred IS TABLE OF trecord_notcred INDEX BY BINARY_INTEGER;
  nc_abo trecord_tab_notacred;

--Definicion de record
type rec_abonado IS RECORD (
     ind_movilfijo       varchar2(1),
     cod_prestacion      ga_abocel.cod_prestacion%type,
     ind_procequi        ga_equipaboser.ind_procequi%type,
     fec_fincontra       ga_abocel.fec_fincontra%type,
     fec_acepventa       ga_abocel.fec_acepventa%type,
     des_articulo        al_articulos.des_articulo%type,
     imp_cargo           ga_equipaboser.imp_cargo%type,
     mto_cargo           ga_equipaboser.imp_cargo%type,
     nom_cliente         ge_clientes.nom_cliente%type,
     nom_apeclien1       ge_clientes.nom_apeclien1%type,
     nom_apeclien2       ge_clientes.nom_apeclien2%type,
     fec_renovacion      pv_registra_renovacion_os_to.fec_ingreso%type,
     cod_tipcontrato     ga_tipcontrato.cod_tipcontrato%type,
     des_tipcontrato     ga_tipcontrato.des_tipcontrato%type,
     cod_plantarif       ta_plantarif.cod_plantarif%type,
     des_plantarif       ta_plantarif.des_plantarif%type,
     num_contrato        ga_abocel.num_contrato%type,
     num_anexo           ga_abocel.num_anexo%type,
     cod_cuenta          ga_abocel.cod_cuenta%type,
     cod_producto        ga_abocel.cod_producto%type,
     cod_indemnizacion   ga_abocel.cod_indemnizacion%type,
     fec_alta            ga_abocel.fec_alta%type,
     fec_prorroga        ga_abocel.fec_prorroga%type,
     meses_minimo        ga_tipcontrato.meses_minimo%type,
     imp_cargobasico     ta_cargosbasico.imp_cargobasico%type,
     num_celular         ga_abocel.num_celular%type,
     cod_grupo           ta_plantarif.cod_grupo%type,
     cod_planserv        ga_abocel.cod_planserv%type,
     cod_modventa        ga_abocel.cod_modventa%type,
     cod_ciclo           ga_abocel.cod_ciclo%type,
     mto_valor_referencia  ga_abocel.mto_valor_referencia%type
);

rec rec_abonado;
--Definicion de record
type rec_cancelado IS RECORD (
         num_cuota     co_cancelados.num_cuota%type,
         sec_cuota     co_cancelados.sec_cuota%type
);
reccuota rec_cancelado;

--Definicion de record
type rec_fecha IS RECORD (
         vigcontrato number,
         mes         number,
         dias        number,
         dias_mes    number,
         descripcion varchar2(50)
);
recfincontrato rec_fecha;
recsuspension  rec_fecha;

--definicion de table record
TYPE rec_sistema IS RECORD (
    valor_texto    ga_parametros_sistema_vw.valor_texto%type,
    valor_numerico ga_parametros_sistema_vw.valor_numerico%type,
    valor_dominio  ga_parametros_sistema_vw.valor_dominio%type
   );

rec_param rec_sistema;



--Definicion de Constantes
CV_MODULO_GA         CONSTANT VARCHAR2(2)  := 'GA';
CV_MODULO_GE         CONSTANT VARCHAR2(2)  := 'GE';
CV_ERROR_NO_CLASIF   CONSTANT VARCHAR2(30) := 'Error no clasificado';
CV_COD_PRODUCTO      CONSTANT NUMBER(1)    := 1;
CN_LARGOERRTEC       CONSTANT NUMBER       := 4000;
CN_LARGODESC         CONSTANT NUMBER       := 2000;
CV_FORMATO_SEL1      CONSTANT VARCHAR2(20) := 'FORMATO_SEL1';
CV_FORMATO_SEL2      CONSTANT VARCHAR2(20) := 'FORMATO_SEL2';
CV_FORMATO_SEL18     CONSTANT VARCHAR2(20) := 'FORMATO_SEL18';
CV_CAUSA_GARANTIA    CONSTANT VARCHAR2(20) := 'CAUSA_GARANTIA';
CV_CAUSA_DEDUCIBLE   CONSTANT VARCHAR2(20) := 'CAUSA_DEDUCIBLE';
CV_COD_OPER_TMG      CONSTANT VARCHAR2(3)  := 'TMG';
CV_COD_OPER_TMS      CONSTANT VARCHAR2(3)  := 'TMS';
CV_COD_SUS           CONSTANT VARCHAR2(3)  := 'SUS';
CV_COD_PRG           CONSTANT VARCHAR2(3)  := 'PRG';
CV_COD_REH           CONSTANT VARCHAR2(3)  := 'REH';
/*
CN_FACTOR            CONSTANT NUMBER       := 365;
CN_FACTORBIS         CONSTANT NUMBER       := 366;
*/
CV_PROCEDENCIA       CONSTANT ge_errores_pg.DesEvent := 'Articulo de procedencia Externa.';
CV_PENALIZACION      CONSTANT ge_errores_pg.DesEvent := 'Prestaci¢n con Deducible, Penalizaci¢n = 0.';
CV_MOVILFIJO         CONSTANT ge_errores_pg.DesEvent := 'Penalizaci¢n solo para Prestaciones N£meros M¢vil ¢ Fijos.';
CV_GRP_PREST_TM      CONSTANT ge_prestaciones_td.grp_prestacion%type  := 'TM';
CV_GRP_PREST_TF      CONSTANT ge_prestaciones_td.grp_prestacion%type  := 'TF';
CV_EXTERNO           CONSTANT ga_equipaboser.ind_procequi%type:='E';
CV_INTERNO           CONSTANT ga_equipaboser.ind_procequi%type:='I';
CV_NOMPARAMEVENEST   CONSTANT ga_parametros_sistema_vw.nom_parametro%type:='BAJA_INDEM_ESTAND';
CV_NOMPARAMSERVEST   CONSTANT ga_parametros_sistema_vw.nom_parametro%type:='COD_SERV_STANDARD';
CV_NOMPARAMCOBR      CONSTANT ga_parametros_sistema_vw.nom_parametro%TYPE:='COBRO_INDEM';
CV_NOMPARAMACTU      CONSTANT ga_parametros_sistema_vw.nom_parametro%TYPE:='ACTUACION_BAJA';
CV_NOMPARAMSERO      CONSTANT ga_parametros_sistema_vw.nom_parametro%TYPE:='SERV_OCASIONAL';
CV_NOMPARAMEVENESC   CONSTANT ga_parametros_sistema_vw.nom_parametro%type:='BAJA_INDEM_ESCAL';
CV_NOMPARAMSERVESC   CONSTANT ga_parametros_sistema_vw.nom_parametro%type:='COD_SERV_ESCAL';
CV_IND_AUTMAN        CONSTANT VARCHAR2(1)  := 'A';
CV_CLIENTEVPN        CONSTANT ge_valores_dominios_vw.valor%type:='CLIENTEVPN';
CV_CREDITO           CONSTANT VARCHAR2(1)  := '7';
CV_CREDITO_CONSIGNACION CONSTANT VARCHAR2(1)  := '8';

--Definicion de Variables Globales
GV_cod_oper        ge_parametros_sistema_vw.valor_texto%type;
GV_formato_sel1    ged_parametros.val_parametro%type;
GV_formato_sel2    ged_parametros.val_parametro%type;
GN_NC              fa_datosgener.cod_notacre%type;

--definicion del cursor
TYPE cursorTYPE IS REF CURSOR;  -- define control ref cursor type  --

--Definicion de Procedimientos / Funciones Publicas
PROCEDURE PV_PENALIZACION_PR(EN_cod_cliente    IN ga_abocel.cod_cliente%type,
                             EN_num_abonado    IN ga_abocel.num_abonado%type,
                             cursor_pen        OUT NOCOPY cursorTYPE);

PROCEDURE PV_INDEMNIZACION_PR (EN_num_abonado       IN  ga_abocel.num_abonado%type,
                               EV_modulo            IN  ge_modulos.cod_modulo%type,
                               SV_ind_autman        OUT NOCOPY varchar2,
                               SV_imp_cargo            OUT NOCOPY varchar2,
                               SV_cod_concepto      OUT NOCOPY varchar2,
                               SV_cod_retorno       OUT NOCOPY varchar2,
                               SV_mens_retorno      OUT NOCOPY varchar2);

PROCEDURE PV_PENALIZASTANDARD_PR(EN_cod_cliente    IN ga_abocel.cod_cliente%type,
                                 EN_num_abonado    IN ga_abocel.num_abonado%type,
                                 EV_cod_modulo     IN ge_modulos.cod_modulo%type,
                                 SV_imp_cargo      OUT NOCOPY varchar2,
                                 SV_ind_autman     OUT NOCOPY varchar2,
                                 SV_cod_retorno    OUT NOCOPY varchar2,
                                 SV_mens_retorno   OUT NOCOPY varchar2);
END;
/
SHOW ERROR