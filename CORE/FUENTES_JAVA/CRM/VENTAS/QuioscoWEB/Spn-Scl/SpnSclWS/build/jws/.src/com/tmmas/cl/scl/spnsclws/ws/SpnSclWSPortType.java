package com.tmmas.cl.scl.spnsclws.ws;

/**
 * Generated interface, please do not edit.
 * Date: [Mon Aug 01 09:00:41 CLT 2011]
 */

public interface SpnSclWSPortType extends java.rmi.Remote {

  /**
   * Web Method: rechazoVenta ...
   */
  com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RechazoVentaOutDTO rechazoVenta(com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in.WsRechazoVentaInDTO rechazoVenta,int rollback)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: getListadoCiudades ...
   */
  com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoCiudadesOutDTO getListadoCiudades(com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDTO provinciaDTO)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: setMarcaAbonadoPortado ...
   */
  com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.OutAbonadoPortadoDTO setMarcaAbonadoPortado(com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoPortadoDTO abonadoPortadoDTO)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: deleteTienda ...
   */
  void deleteTienda(java.lang.Long codTienda)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: cancelaVenta ...
   */
  com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RechazoVentaOutDTO cancelaVenta(com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in.WsRechazoVentaInDTO cancelaVenta,int rollback)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: getConsultaPlanesTarifarios ...
   */
  com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListConsultaPlanTarifarioOutDTO getConsultaPlanesTarifarios(com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsConsultaPlanTarifarioInDTO consultaPlanTarifarioIn)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: solicitaBajaAbonado ...
   */
  com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonado(com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSSolicitudBajaAbonadoDTO solicitudBajaAbonadoDTO,int rollback)
      throws java.rmi.RemoteException;
  /**
   * Web Method: getDetalleUltimaLlamadasRoamingTOL ...
   */
  com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.RoamingOUTDTO getDetalleUltimaLlamadasRoamingTOL(com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.RoamingDTO rommingDTO)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: recuperaArrayTipificacion ...
   */
  com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TipificaClientizaDTO[] recuperaArrayTipificacion()
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: clientePorNumeroCelular ...
   */
  com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DatosClienteDTO clientePorNumeroCelular(long numeroCelular)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: foo ...
   */
  java.lang.String foo(java.lang.String param)
      throws java.rmi.RemoteException;
  /**
   * Web Method: getListadoRegiones ...
   */
  com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoRegionesOutDTO getListadoRegiones()
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: getTiendaVendedor ...
   */
  com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendaVendedorOutDTO getTiendaVendedor(java.lang.String codTienda)
      throws java.rmi.RemoteException;
  /**
   * Web Method: deleteTipificacion ...
   */
  void deleteTipificacion(java.lang.Long codArticulo)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: recCampanaBeneficio ...
   */
  com.tmmas.cl.scl.commonapp.dto.WsBeneficioPromocionOutDTO[] recCampanaBeneficio(com.tmmas.cl.scl.commonapp.dto.WsBeneficioPromocionInDTO beneficioPromocion)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: getListaCaja ...
   */
  com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsCajaOutDTO getListaCaja(java.lang.String codOficina)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: reservaDesreserva ...
   */
  com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReservaOutDTO reservaDesreserva(com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReservaDTO solicitaReservaDTO,java.lang.String tipoSolicitud,int rollback)
      throws java.rmi.RemoteException;
  /**
   * Web Method: updateTipificacion ...
   */
  void updateTipificacion(com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TipificaClientizaDTO tipificaClientizaDTO)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: agregarDirecciones ...
   */
  com.tmmas.cl.scl.commonapp.dto.WsDireccionesOutDTO agregarDirecciones(com.tmmas.cl.scl.commonapp.dto.WsDireccionInDTO[] WsDireccionesIn,int rollback)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: getCategoriasCambio ...
   */
  com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoCategoriaCambioDTO getCategoriasCambio()
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: AltaCuentaSubCuenta ...
   */
  com.tmmas.cl.scl.commonapp.dto.WsAltaCuentaSubCuentaOutDTO AltaCuentaSubCuenta(com.tmmas.cl.scl.commonapp.dto.WsAltaCuentaSubCuentaInDTO cuentaIn,int rollback)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: pruebaJMS ...
   */
  java.lang.String pruebaJMS(java.lang.String prueba)
      throws java.rmi.RemoteException;
  /**
   * Web Method: AltaDeLinea ...
   */
  com.tmmas.cl.scl.commonapp.dto.WsCunetaAltaDeLineaOutDTO AltaDeLinea(com.tmmas.cl.scl.commonapp.dto.WsCunetaAltaDeLineaDTO altaLinea,int rollback)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: getListCategorias ...
   */
  com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoCategoriasClienteOutDTO getListCategorias()
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: getCentralesQuiosco ...
   */
  com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSCentralQuioscoOutDTO getCentralesQuiosco()
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: insertTienda ...
   */
  com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsInsertTiendaOutDTO insertTienda(com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TiendaDTO tiendaDTO)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: registraCampanaBeneficio ...
   */
  void registraCampanaBeneficio(com.tmmas.cl.scl.commonapp.dto.WsRegistraCampanaByPInDTO registraCampanaByPIn)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: getTiendas ...
   */
  com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendasOutDTO getTiendas()
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: getListadoPlanesTarifarios ...
   */
  com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListPlanTarifarioOutDTO getListadoPlanesTarifarios(com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsPlanTarifarioInDTO inWSLstPlanTarifDTO)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: getImpuesto ...
   */
  float getImpuesto(java.lang.String codigoVendedor)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: solicitaBajaAbonadoPrepago ...
   */
  com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoPrepago(com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSSolicitudBajaAbonadoDTO solicitudBajaAbonadoDTO,int rollback)
      throws java.rmi.RemoteException;
  /**
   * Web Method: AltaDeStructuraComercial ...
   */
  com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraComercialOutDTO AltaDeStructuraComercial(com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsCreaStructuraComercialInDTO WsCreaStructuraComercial)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: getCargosFacturacion ...
   */
  com.tmmas.cl.scl.commonapp.dto.WsConsCargosVentaOutDTO getCargosFacturacion(com.tmmas.cl.scl.commonapp.dto.WsConsCargosVentaInDTO WsFacturacionVentaIn)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: WSMigracionClientePrepagoAPostpago ...
   */
  com.tmmas.scl.serviciospostventasiga.transport.MigracionPrepagoPostpagoDTO WSMigracionClientePrepagoAPostpago(com.tmmas.scl.serviciospostventasiga.transport.MigracionDTO migracionDTO)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: recuperaDatoTipificacion ...
   */
  com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TipificacionDTO[] recuperaDatoTipificacion(java.lang.String datoTipificacion,java.lang.String codVendedor)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: getZip ...
   */
  java.lang.String getZip(com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DireccionDTO direccion)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: getListadoTarjetas ...
   */
  com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTarjetaOutDTO getListadoTarjetas()
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: setDesMarcaAbonadoPortado ...
   */
  com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.OutAbonadoPortadoDTO setDesMarcaAbonadoPortado(com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoPortadoDTO abonadoPortadoDTO)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: agregarDireccion ...
   */
  com.tmmas.cl.scl.commonapp.dto.WsDireccionOutDTO agregarDireccion(com.tmmas.cl.scl.commonapp.dto.WsDireccionInDTO WsDireccionesIn,int rollback)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: getListadoBancosPAC ...
   */
  com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListBancoOutDTO getListadoBancosPAC()
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: AltaCliente ...
   */
  com.tmmas.cl.scl.commonapp.dto.WsAltaClienteOutDTO AltaCliente(com.tmmas.cl.scl.commonapp.dto.WsCuentaInNDTO cuenta,int rollback)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: getSSincluidosEnPlan ...
   */
  com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WsOutSSuplementariosDTO getSSincluidosEnPlan(java.lang.String codigoPlanTarifario)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: obtieneListaTienda ...
   */
  com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TiendaDTO[] obtieneListaTienda()
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: setAgregaEliminaSS ...
   */
  com.tmmas.cl.scl.commonapp.dto.SSuplementarioOutDTO setAgregaEliminaSS(com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WsAgregaEliminaSSInDTO[] sSuplemenAgregar,com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WsAgregaEliminaSSInDTO[] sSuplemenEliminar,java.lang.Long NumeroCelular,java.lang.String NomUsuario,int rollback)
      throws java.rmi.RemoteException;
  /**
   * Web Method: AltaDeLineaBusito ...
   */
  com.tmmas.cl.scl.spnsclwscommon.busito.dto.AltaDeLineaBusitoOutDTO AltaDeLineaBusito(com.tmmas.cl.scl.spnsclwscommon.busito.dto.AltaDeLineaBusitoInDTO altaDeLineaBusitoIn)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: aceptacionVenta ...
   */
  com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.AceptacionVentaOutDTO aceptacionVenta(com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in.WsAceptacionVentaInDTO aceptacionVenta,int rollback)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: getSSOpcionalesAlPlan ...
   */
  com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WsOutSSuplementariosDTO getSSOpcionalesAlPlan(java.lang.String codigoPlanTarifario,java.lang.String codigoArticulo,java.lang.String codigCentral)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: cierreVenta ...
   */
  com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CierreVentaOutDTO cierreVenta(com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in.WsCierreVentaInDTO cierreVenta,int rollback)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: insertarTipificacion ...
   */
  com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsInsertTipificacionOutDTO insertarTipificacion(com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TipificaClientizaDTO tipificaClientizaDTO)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: getTiposIdentificacion ...
   */
  com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoTiposIdentificacionOutDTO getTiposIdentificacion()
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: updateTienda ...
   */
  com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsUpdateTiendaOutDTO updateTienda(com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TiendaDTO tiendaModDTO)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: recuperarAltaAsincrono ...
   */
  com.tmmas.cl.scl.commonapp.dto.WsCunetaAltaDeLineaOutDTO recuperarAltaAsincrono(java.lang.String id_transaccion)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: getListadoProvincias ...
   */
  com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoProvinciasOutDTO getListadoProvincias(com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO regionDTO)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: getListadoComunas ...
   */
  com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoComunasOutDTO getListadoComunas(com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDTO ciudadDTO)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
  /**
   * Web Method: ProcesoDeFacturacion ...
   */
  com.tmmas.cl.scl.commonapp.dto.WsFacturacionVentaOutDTO ProcesoDeFacturacion(com.tmmas.cl.scl.commonapp.dto.WsFacturacionVentaInDTO wsFacturacionVentaIn,int rollback)
      throws java.rmi.RemoteException, com.tmmas.cl.framework.exception.GeneralException;
}
