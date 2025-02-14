CREATE OR REPLACE TYPE PV_CAM_SIMCARD_OT AS OBJECT
(
  NumSerieAnt                    varchar2    (25   ),
  Numserie                       varchar2    (25   ),
  CodUsoLinea                    number      (2    ),
  lCod_OOSS                      varchar2    (5    ),
  numventa                       number      (8    ),
  NumAbonado                     number      (8    ),
  NumCelular                     number      (15   ),
  sCodPlanTarif                  varchar2    (3    ),
  CodModVenta                    number      (2    ),
  CodArticulo                    number      (6    ),
  CodBodega                      number      (6    ),
  CodCuota                       varchar2    (2    ),
  CodEstado                      number      (2    ),
  CodStock                       number      (2    ),
  CodTecnologia                  varchar2    (7    ),
  DesEquipo                      varchar2    (40   ),
  IndProcEqui                    varchar2    (1    ),
  NumImei                        varchar2    (25   ),
  IndPropiedad                   varchar2    (1    ),
  CauCambio                      varchar2    (2    ),
  CodCliente                     number      (8    ),
  CodProducto                    number      (1    ),
  CodModulo                      varchar2    (2    ),
  usuario                        varchar2    (30   ),
  CodActuacion                   number      (5    ),
  CodServicio                    varchar2    (255  ),
  MoviCentral1                   number      (9    ),
  NumMovimiento                  number      (9    ),
  NumTerminal                    varchar2    (1    ),
  NumTerminal_new                varchar2    (1    ),
  SerElectric                    varchar2    (25   ),
  CodCentral                     varchar2    (15   ),
  CodCentralPlex                 varchar2    (15   ),  --deberia ser null
  CodActabo                      varchar2    (2    ),
  CodTiplan                      varchar2    (5    ),
  FEC_ALTA                       DATE,
  Inte                           varchar2    (1    ),
  NumMin                         varchar2    (20   ),
  NUM_IMSI_OLD                   varchar2    (15   ),
  NUM_IMSI_NEW                   varchar2    (15   ),
  promocelular                   number      (1    ),
  EN_autentificacion             number      (1    ),
  num_reserva                    number      (10   ),     ---Numero de reserva del equipo (tabla GA_RESERVART)
  cod_servSupl                   number      (2    ),     ---Codigo de Servicio Suplementario
  GRUPO_TEC_GSM                  VARCHAR2    (10   ),
  TAREA                          number      (10   ),
  ind_vta_externa                number      (1    ),
  cod_tipcomis                   VARCHAR2    (2    ),
  NumPeriodo                     number      (4    ),
  CodProm                        number      (5    ),
  CargaPer                       number      (5    ),
  CargaTot                       number      (5    ),
  Ind_Comodato                   number      (1    ),
  habil_Amistar                  VARCHAR2    (1    ),
  tip_terminal                   VARCHAR2    (1    ),
  CodActaboAux                   VARCHAR2    (3    ),
  numMovimientoBloqDesb			 NUMBER		 (10   ),
  CONSTRUCTOR FUNCTION PV_CAM_SIMCARD_OT RETURN self AS result
  ,MEMBER FUNCTION to_debug RETURN VARCHAR2
)  NOT FINAL;
/
SHOW ERRORS
CREATE OR REPLACE type body PV_CAM_SIMCARD_OT is CONSTRUCTOR
FUNCTION PV_CAM_SIMCARD_OT RETURN SELF AS RESULT
  AS
    BEGIN
    NumSerieAnt            := NULL;
    Numserie               := NULL;
    CodUsoLinea            := NULL;
    lCod_OOSS              := NULL;
    numventa               := NULL;
    NumAbonado             := NULL;
    NumCelular             := NULL;
    sCodPlanTarif          := NULL;
    CodModVenta            := NULL;
    CodArticulo            := NULL;
    CodBodega              := NULL;
    CodCuota               := NULL;
    CodEstado              := NULL;
    CodStock               := NULL;
    CodTecnologia          := NULL;
    DesEquipo              := NULL;
    IndProcEqui            := NULL;
    NumImei                := NULL;
    IndPropiedad           := NULL;
    CauCambio              := NULL;
    CodCliente             := NULL;
    CodProducto            := NULL;
    CodModulo              := NULL;
    usuario                := NULL;
    CodActuacion           := NULL;
    CodServicio            := NULL;
    MoviCentral1           := NULL;
    NumMovimiento          := NULL;
    NumTerminal            := NULL;
    NumTerminal_new        := NULL;
    SerElectric            := NULL;
    CodCentral             := NULL;
    CodCentralPlex         := NULL;
    CodActabo              := NULL;
    CodTiplan              := NULL;
    FEC_ALTA               := NULL;
    Inte                   := NULL;
    NumMin                 := NULL;
    NUM_IMSI_OLD           := NULL;
    NUM_IMSI_NEW           := NULL;
    promocelular           := NULL;
    EN_autentificacion     := NULL;
    num_reserva            := NULL;
    cod_servSupl           := NULL;
    GRUPO_TEC_GSM          := NULL;
    TAREA                  := NULL;
    ind_vta_externa        := NULL;
    cod_tipcomis           := NULL;
    NumPeriodo             := NULL;
    CodProm                := NULL;
    CargaPer               := NULL;
    CargaTot               := NULL;
    Ind_Comodato           := NULL;
    habil_Amistar          := NULL;
    tip_terminal           := NULL;
	CodActaboAux           := NULL;
	numMovimientoBloqDesb  := NULL;
    RETURN;
  END;
  MEMBER FUNCTION to_debug RETURN VARCHAR2 is
    ret varchar2(4000);
    BEGIN
       ret := 'EV_cambioserie.NumSerieAnt := '    ||  NumSerieAnt || ';' || chr(13)
       ||     'EV_cambioserie.Numserie := '       ||  Numserie || ';' || chr(13)
       ||     'EV_cambioserie.CodUsoLinea := '    ||  to_char(CodUsoLinea) || ';' || chr(13)
       ||     'EV_cambioserie.lCod_OOSS := '      ||  lCod_OOSS || ';' || chr(13)
       ||     'EV_cambioserie.numventa := '       ||  to_char(numventa) || ';' || chr(13)
       ||     'EV_cambioserie.NumAbonado := '     ||  to_char(NumAbonado) || ';' || chr(13)
       ||     'EV_cambioserie.NumCelular := '     ||  to_char(NumCelular) || ';' || chr(13)
       ||     'EV_cambioserie.sCodPlanTarif := '  ||  sCodPlanTarif || ';' || chr(13)
       ||     'EV_cambioserie.CodModVenta := '    ||  to_char(CodModVenta) || ';' || chr(13)
       ||     'EV_cambioserie.CodArticulo := '     ||  to_char(CodArticulo) || ';' || chr(13)
       ||     'EV_cambioserie.CodBodega := '       ||  to_char(CodBodega) || ';' || chr(13)
       ||     'EV_cambioserie.CodCuota := '        ||  CodCuota || ';' || chr(13)
       ||     'EV_cambioserie.CodEstado := '       ||  to_char(CodEstado) || ';' || chr(13)
       ||     'EV_cambioserie.CodStock := '        ||  to_char(CodStock) || ';' || chr(13)
       ||     'EV_cambioserie.CodTecnologia := '   ||  CodTecnologia || ';' || chr(13)
       ||     'EV_cambioserie.DesEquipo := '       ||  DesEquipo || ';' || chr(13)
       ||     'EV_cambioserie.IndProcEqui := '     ||  IndProcEqui || ';' || chr(13)
       ||     'EV_cambioserie.NumImei := '         ||  to_char(NumImei) || ';' || chr(13)
       ||     'EV_cambioserie.IndPropiedad := '    ||  IndPropiedad || ';' || chr(13)
       ||     'EV_cambioserie.CauCambio := '       ||  CauCambio || ';' || chr(13)
       ||     'EV_cambioserie.CodCliente := '      ||  to_char(CodCliente) || ';' || chr(13)
       ||     'EV_cambioserie.CodProducto := '     ||  to_char(CodProducto) || ';' || chr(13)
       ||     'EV_cambioserie.CodModulo := '       ||  CodModulo || ';' || chr(13)
       ||     'EV_cambioserie.usuario := '         ||  usuario || ';' || chr(13)
       ||     'EV_cambioserie.CodActuacion := '    ||  to_char(CodActuacion) || ';' || chr(13)
       ||     'EV_cambioserie.CodServicio := '     ||  CodServicio || ';' || chr(13)
       ||     'EV_cambioserie.MoviCentral1 := '    ||  to_char(MoviCentral1) || ';' || chr(13)
       ||     'EV_cambioserie.NumMovimiento := '   ||  to_char(NumMovimiento) || ';' || chr(13)
       ||     'EV_cambioserie.NumTerminal := '     ||  NumTerminal || ';' || chr(13)
       ||     'EV_cambioserie.NumTerminal_new := ' ||  NumTerminal_new || ';' || chr(13)
       ||     'EV_cambioserie.SerElectric := '     ||  SerElectric || ';' || chr(13)
       ||     'EV_cambioserie.CodCentral := '      ||  CodCentral || ';' || chr(13)
       ||     'EV_cambioserie.CodCentralPlex := '  ||  CodCentralPlex || ';' || chr(13)
       ||     'EV_cambioserie.CodActabo := '       ||  CodActabo || ';' || chr(13)
       ||     'EV_cambioserie.CodTiplan := '       ||  CodTiplan || ';' || chr(13)
       ||     'EV_cambioserie.FEC_ALTA := '        ||  to_char(FEC_ALTA, 'dd-mm-yyy') || ';' || chr(13)
       ||     'EV_cambioserie.Inte := '            ||  Inte || ';' || chr(13)
       ||     'EV_cambioserie.NumMin := '          ||  NumMin || ';' || chr(13)
       ||     'EV_cambioserie.NUM_IMSI_OLD := '    ||  NUM_IMSI_OLD || ';' || chr(13)
       ||     'EV_cambioserie.NUM_IMSI_NEW := '    ||  NUM_IMSI_NEW || ';' || chr(13)
       ||     'EV_cambioserie.promocelular := '       ||  to_char(promocelular) || ';' || chr(13)
       ||     'EV_cambioserie.EN_autentificacion := ' ||  to_char(EN_autentificacion) || ';' || chr(13)
       ||     'EV_cambioserie.num_reserva := '        ||  to_char(num_reserva) || ';' || chr(13)
       ||     'EV_cambioserie.cod_servSupl := '       ||  to_char(cod_servSupl) || ';' || chr(13)
       ||     'EV_cambioserie.GRUPO_TEC_GSM := '      ||  GRUPO_TEC_GSM || ';' || chr(13)
       ||     'EV_cambioserie.TAREA := '              ||  to_char(TAREA) || ';' || chr(13)
       ||     'EV_cambioserie.ind_vta_externa := '    ||  to_char(ind_vta_externa) || ';' || chr(13)
       ||     'EV_cambioserie.cod_tipcomis := '       ||  cod_tipcomis || ';' || chr(13)
       ||     'EV_cambioserie.NumPeriodo := '         ||  to_char(NumPeriodo) || ';' || chr(13)
       ||     'EV_cambioserie.CodProm := '            ||  to_char(CodProm) || ';' || chr(13)
       ||     'EV_cambioserie.CargaPer := '           ||  to_char(CargaPer) || ';' || chr(13)
       ||     'EV_cambioserie.CargaTot := '           ||  to_char(CargaTot) || ';' || chr(13)
       ||     'EV_cambioserie.Ind_Comodato := '       ||  to_char(Ind_Comodato) || ';' || chr(13)
       ||     'EV_cambioserie.habil_Amistar := '      ||  habil_Amistar || ';' || chr(13)
       ||     'EV_cambioserie.tip_terminal	 := '      ||  tip_terminal || ';' || chr(13);
/*       ||     'EV_cambioserie.CodActaboAux	 := '      ||  CodActaboAux || ';' || chr(13);
       ||     'EV_cambioserie.numMovimientoBloqDesb	 := '  ||  to_char(numMovimientoBloqDesb) || ';' || chr(13);*/
      RETURN ret;
  END;
END;
/
SHOW ERRORS
