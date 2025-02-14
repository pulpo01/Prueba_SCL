package com.tmmas.cl.scl.spnsclws.ws;

public class SpnSclWSProxy implements com.tmmas.cl.scl.spnsclws.ws.SpnSclWS {
  private String _endpoint = null;
  private com.tmmas.cl.scl.spnsclws.ws.SpnSclWS spnSclWS = null;
  
  public SpnSclWSProxy() {
    _initSpnSclWSProxy();
  }
  
  public SpnSclWSProxy(String endpoint) {
    _endpoint = endpoint;
    _initSpnSclWSProxy();
  }
  
  private void _initSpnSclWSProxy() {
    try {
      spnSclWS = (new com.tmmas.cl.scl.spnsclws.ws.SpnSclWSServiceLocator()).getSpnSclWSSoapPort();
      if (spnSclWS != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)spnSclWS)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)spnSclWS)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (spnSclWS != null)
      ((javax.xml.rpc.Stub)spnSclWS)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.tmmas.cl.scl.spnsclws.ws.SpnSclWS getSpnSclWS() {
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS;
  }
  
  public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsClasificacionOutDTO getClasificaciones() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getClasificaciones();
  }
  
  public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RechazoVentaOutDTO rechazoVenta(in.dto.commonapp.spnsclwscommon.scl.cl.tmmas.com.WsRechazoVentaInDTO rechazoVenta, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.rechazoVenta(rechazoVenta, rollback);
  }
  
  public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListTipoPagoOutDTO getListadoTipoPago() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getListadoTipoPago();
  }
  
  public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListPlanTarifarioOutDTO getListadoPlanTarifario() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getListadoPlanTarifario();
  }
  
  public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCiudadesOutDTO getListadoCiudades(dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ProvinciaDTO provinciaDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getListadoCiudades(provinciaDTO);
  }
  
  public void deleteTienda(java.lang.Long codTienda) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    spnSclWS.deleteTienda(codTienda);
  }
  
  public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RechazoVentaOutDTO cancelaVenta(in.dto.commonapp.spnsclwscommon.scl.cl.tmmas.com.WsRechazoVentaInDTO cancelaVenta, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.cancelaVenta(cancelaVenta, rollback);
  }
  
  public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListConsultaPlanTarifarioOutDTO getConsultaPlanesTarifarios(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsConsultaPlanTarifarioInDTO consultaPlanTarifarioIn) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getConsultaPlanesTarifarios(consultaPlanTarifarioIn);
  }
  
  public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonado(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoDTO solicitudBajaAbonadoDTO, int rollback) throws java.rmi.RemoteException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.solicitaBajaAbonado(solicitudBajaAbonadoDTO, rollback);
  }
  
  public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.RoamingOUTDTO getDetalleUltimaLlamadasRoamingTOL(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.RoamingDTO rommingDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getDetalleUltimaLlamadasRoamingTOL(rommingDTO);
  }
  
  public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificaClientizaDTO[] recuperaArrayTipificacion() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.recuperaArrayTipificacion();
  }
  
  public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsCrediticiaOutDTO getCrediticia() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getCrediticia();
  }
  
  public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.DatosClienteDTO clientePorNumeroCelular(long numeroCelular) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.clientePorNumeroCelular(numeroCelular);
  }
  
  public java.lang.String foo(java.lang.String param) throws java.rmi.RemoteException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.foo(param);
  }
  
  public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsListTipoPrestacionOutDTO getTiposPrestacion(java.lang.String codGrupoPrestacion, java.lang.String tipoCliente) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getTiposPrestacion(codGrupoPrestacion, tipoCliente);
  }
  
  public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoRegionesOutDTO getListadoRegiones() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getListadoRegiones();
  }
  
  public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsTiendaVendedorOutDTO getTiendaVendedor(java.lang.String codTienda) throws java.rmi.RemoteException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getTiendaVendedor(codTienda);
  }
  
  public void deleteTipificacion(java.lang.Long codArticulo) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    spnSclWS.deleteTipificacion(codArticulo);
  }
  
  public dto.commonapp.scl.cl.tmmas.com.WsBeneficioPromocionOutDTO[] recCampanaBeneficio(dto.commonapp.scl.cl.tmmas.com.WsBeneficioPromocionInDTO beneficioPromocion) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.recCampanaBeneficio(beneficioPromocion);
  }
  
  public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsCajaOutDTO getListaCaja(java.lang.String codOficina) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getListaCaja(codOficina);
  }
  
  public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.ReservaOutDTO reservaDesreserva(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.ReservaDTO solicitaReservaDTO, java.lang.String tipoSolicitud, int rollback) throws java.rmi.RemoteException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.reservaDesreserva(solicitaReservaDTO, tipoSolicitud, rollback);
  }
  
  public void updateTipificacion(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificaClientizaDTO tipificaClientizaDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    spnSclWS.updateTipificacion(tipificaClientizaDTO);
  }
  
  public dto.commonapp.scl.cl.tmmas.com.WsDireccionesOutDTO agregarDirecciones(dto.commonapp.scl.cl.tmmas.com.WsDireccionInDTO[] wsDireccionesIn, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.agregarDirecciones(wsDireccionesIn, rollback);
  }
  
  public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCategoriaCambioDTO getCategoriasCambio() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getCategoriasCambio();
  }
  
  public dto.commonapp.scl.cl.tmmas.com.WsAltaCuentaSubCuentaOutDTO altaCuentaSubCuenta(dto.commonapp.scl.cl.tmmas.com.WsAltaCuentaSubCuentaInDTO cuentaIn, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.altaCuentaSubCuenta(cuentaIn, rollback);
  }
  
  public java.lang.String pruebaJMS(java.lang.String prueba) throws java.rmi.RemoteException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.pruebaJMS(prueba);
  }
  
  public dto.commonapp.scl.cl.tmmas.com.WsCunetaAltaDeLineaOutDTO altaDeLinea(dto.commonapp.scl.cl.tmmas.com.WsCunetaAltaDeLineaDTO altaLinea, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.altaDeLinea(altaLinea, rollback);
  }
  
  public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSCentralQuioscoOutDTO getCentralesQuiosco() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getCentralesQuiosco();
  }
  
  public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCategoriasClienteOutDTO getListCategorias() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getListCategorias();
  }
  
  public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsInsertTiendaOutDTO insertTienda(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TiendaDTO tiendaDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.insertTienda(tiendaDTO);
  }
  
  public void registraCampanaBeneficio(dto.commonapp.scl.cl.tmmas.com.WsRegistraCampanaByPInDTO registraCampanaByPIn) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    spnSclWS.registraCampanaBeneficio(registraCampanaByPIn);
  }
  
  public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsTiendasOutDTO getTiendas() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getTiendas();
  }
  
  public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListPlanTarifarioOutDTO getListadoPlanesTarifarios(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsPlanTarifarioInDTO inWSLstPlanTarifDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getListadoPlanesTarifarios(inWSLstPlanTarifDTO);
  }
  
  public float getImpuesto(java.lang.String codigoVendedor) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getImpuesto(codigoVendedor);
  }
  
  public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoPrepago(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoDTO solicitudBajaAbonadoDTO, int rollback) throws java.rmi.RemoteException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.solicitaBajaAbonadoPrepago(solicitudBajaAbonadoDTO, rollback);
  }
  
  public dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraComercialOutDTO altaDeStructuraComercial(dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsCreaStructuraComercialInDTO wsCreaStructuraComercial) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.altaDeStructuraComercial(wsCreaStructuraComercial);
  }
  
  public dto.commonapp.scl.cl.tmmas.com.WsConsCargosVentaOutDTO getCargosFacturacion(dto.commonapp.scl.cl.tmmas.com.WsConsCargosVentaInDTO wsFacturacionVentaIn) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getCargosFacturacion(wsFacturacionVentaIn);
  }
  
  public transport.serviciospostventasiga.scl.tmmas.com.MigracionPrepagoPostpagoDTO WSMigracionClientePrepagoAPostpago(transport.serviciospostventasiga.scl.tmmas.com.MigracionDTO migracionDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.WSMigracionClientePrepagoAPostpago(migracionDTO);
  }
  
  public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificacionDTO[] recuperaDatoTipificacion(java.lang.String datoTipificacion, java.lang.String codVendedor) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.recuperaDatoTipificacion(datoTipificacion, codVendedor);
  }
  
  public java.lang.String getZip(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.DireccionDTO direccion) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getZip(direccion);
  }
  
  public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListTarjetaOutDTO getListadoTarjetas() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getListadoTarjetas();
  }
  
  public dto.commonapp.scl.cl.tmmas.com.WsDireccionOutDTO agregarDireccion(dto.commonapp.scl.cl.tmmas.com.WsDireccionInDTO wsDireccionesIn, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.agregarDireccion(wsDireccionesIn, rollback);
  }
  
  public dto.commonapp.scl.cl.tmmas.com.WsAltaClienteOutDTO altaCliente(dto.commonapp.scl.cl.tmmas.com.WsCuentaInNDTO cuenta, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.altaCliente(cuenta, rollback);
  }
  
  public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListBancoOutDTO getListadoBancosPAC() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getListadoBancosPAC();
  }
  
  public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsOutSSuplementariosDTO getSSincluidosEnPlan(java.lang.String codigoPlanTarifario) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getSSincluidosEnPlan(codigoPlanTarifario);
  }
  
  public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TiendaDTO[] obtieneListaTienda() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.obtieneListaTienda();
  }
  
  public dto.commonapp.scl.cl.tmmas.com.SSuplementarioOutDTO setAgregaEliminaSS(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsAgregaEliminaSSInDTO[] sSuplemenAgregar, dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsAgregaEliminaSSInDTO[] sSuplemenEliminar, java.lang.Long numeroCelular, java.lang.String nomUsuario, int rollback) throws java.rmi.RemoteException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.setAgregaEliminaSS(sSuplemenAgregar, sSuplemenEliminar, numeroCelular, nomUsuario, rollback);
  }
  
  public dto.busito.spnsclwscommon.scl.cl.tmmas.com.AltaDeLineaBusitoOutDTO altaDeLineaBusito(dto.busito.spnsclwscommon.scl.cl.tmmas.com.AltaDeLineaBusitoInDTO altaDeLineaBusitoIn) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.altaDeLineaBusito(altaDeLineaBusitoIn);
  }
  
  public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.AceptacionVentaOutDTO aceptacionVenta(in.dto.commonapp.spnsclwscommon.scl.cl.tmmas.com.WsAceptacionVentaInDTO aceptacionVenta, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.aceptacionVenta(aceptacionVenta, rollback);
  }
  
  public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsOutSSuplementariosDTO getSSOpcionalesAlPlan(java.lang.String codigoPlanTarifario, java.lang.String codigoArticulo, java.lang.String codigCentral) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getSSOpcionalesAlPlan(codigoPlanTarifario, codigoArticulo, codigCentral);
  }
  
  public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.CierreVentaOutDTO cierreVenta(in.dto.commonapp.spnsclwscommon.scl.cl.tmmas.com.WsCierreVentaInDTO cierreVenta, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.cierreVenta(cierreVenta, rollback);
  }
  
  public dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.WsDatosDireccionOutDTO getDatosDireccion(dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.DireccionDTO direccionDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getDatosDireccion(direccionDTO);
  }
  
  public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsInsertTipificacionOutDTO insertarTipificacion(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificaClientizaDTO tipificaClientizaDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.insertarTipificacion(tipificaClientizaDTO);
  }
  
  public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoTiposIdentificacionOutDTO getTiposIdentificacion() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getTiposIdentificacion();
  }
  
  public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsUpdateTiendaOutDTO updateTienda(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TiendaDTO tiendaModDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.updateTienda(tiendaModDTO);
  }
  
  public dto.commonapp.scl.cl.tmmas.com.WsCunetaAltaDeLineaOutDTO recuperarAltaAsincrono(java.lang.String id_transaccion) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.recuperarAltaAsincrono(id_transaccion);
  }
  
  public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoProvinciasOutDTO getListadoProvincias(dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.RegionDTO regionDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getListadoProvincias(regionDTO);
  }
  
  public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoComunasOutDTO getListadoComunas(dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.CiudadDTO ciudadDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.getListadoComunas(ciudadDTO);
  }
  
  public dto.commonapp.scl.cl.tmmas.com.WsFacturacionVentaOutDTO procesoDeFacturacion(dto.commonapp.scl.cl.tmmas.com.WsFacturacionVentaInDTO wsFacturacionVentaIn, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException{
    if (spnSclWS == null)
      _initSpnSclWSProxy();
    return spnSclWS.procesoDeFacturacion(wsFacturacionVentaIn, rollback);
  }
  
  
}