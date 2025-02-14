/**
 * SpnSclWS.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.tmmas.cl.scl.spnsclws.ws;

public interface SpnSclWS extends java.rmi.Remote {
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsClasificacionOutDTO getClasificaciones() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RechazoVentaOutDTO rechazoVenta(in.dto.commonapp.spnsclwscommon.scl.cl.tmmas.com.WsRechazoVentaInDTO rechazoVenta, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListTipoPagoOutDTO getListadoTipoPago() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListPlanTarifarioOutDTO getListadoPlanTarifario() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCiudadesOutDTO getListadoCiudades(dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ProvinciaDTO provinciaDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public void deleteTienda(java.lang.Long codTienda) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RechazoVentaOutDTO cancelaVenta(in.dto.commonapp.spnsclwscommon.scl.cl.tmmas.com.WsRechazoVentaInDTO cancelaVenta, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListConsultaPlanTarifarioOutDTO getConsultaPlanesTarifarios(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsConsultaPlanTarifarioInDTO consultaPlanTarifarioIn) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonado(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoDTO solicitudBajaAbonadoDTO, int rollback) throws java.rmi.RemoteException;
    public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.RoamingOUTDTO getDetalleUltimaLlamadasRoamingTOL(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.RoamingDTO rommingDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificaClientizaDTO[] recuperaArrayTipificacion() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsCrediticiaOutDTO getCrediticia() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.DatosClienteDTO clientePorNumeroCelular(long numeroCelular) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public java.lang.String foo(java.lang.String param) throws java.rmi.RemoteException;
    public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsListTipoPrestacionOutDTO getTiposPrestacion(java.lang.String codGrupoPrestacion, java.lang.String tipoCliente) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoRegionesOutDTO getListadoRegiones() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsTiendaVendedorOutDTO getTiendaVendedor(java.lang.String codTienda) throws java.rmi.RemoteException;
    public void deleteTipificacion(java.lang.Long codArticulo) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.scl.cl.tmmas.com.WsBeneficioPromocionOutDTO[] recCampanaBeneficio(dto.commonapp.scl.cl.tmmas.com.WsBeneficioPromocionInDTO beneficioPromocion) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsCajaOutDTO getListaCaja(java.lang.String codOficina) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.ReservaOutDTO reservaDesreserva(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.ReservaDTO solicitaReservaDTO, java.lang.String tipoSolicitud, int rollback) throws java.rmi.RemoteException;
    public void updateTipificacion(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificaClientizaDTO tipificaClientizaDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.scl.cl.tmmas.com.WsDireccionesOutDTO agregarDirecciones(dto.commonapp.scl.cl.tmmas.com.WsDireccionInDTO[] wsDireccionesIn, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCategoriaCambioDTO getCategoriasCambio() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.scl.cl.tmmas.com.WsAltaCuentaSubCuentaOutDTO altaCuentaSubCuenta(dto.commonapp.scl.cl.tmmas.com.WsAltaCuentaSubCuentaInDTO cuentaIn, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public java.lang.String pruebaJMS(java.lang.String prueba) throws java.rmi.RemoteException;
    public dto.commonapp.scl.cl.tmmas.com.WsCunetaAltaDeLineaOutDTO altaDeLinea(dto.commonapp.scl.cl.tmmas.com.WsCunetaAltaDeLineaDTO altaLinea, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSCentralQuioscoOutDTO getCentralesQuiosco() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoCategoriasClienteOutDTO getListCategorias() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsInsertTiendaOutDTO insertTienda(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TiendaDTO tiendaDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public void registraCampanaBeneficio(dto.commonapp.scl.cl.tmmas.com.WsRegistraCampanaByPInDTO registraCampanaByPIn) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsTiendasOutDTO getTiendas() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListPlanTarifarioOutDTO getListadoPlanesTarifarios(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsPlanTarifarioInDTO inWSLstPlanTarifDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public float getImpuesto(java.lang.String codigoVendedor) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoPrepago(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSSolicitudBajaAbonadoDTO solicitudBajaAbonadoDTO, int rollback) throws java.rmi.RemoteException;
    public dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraComercialOutDTO altaDeStructuraComercial(dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsCreaStructuraComercialInDTO wsCreaStructuraComercial) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.scl.cl.tmmas.com.WsConsCargosVentaOutDTO getCargosFacturacion(dto.commonapp.scl.cl.tmmas.com.WsConsCargosVentaInDTO wsFacturacionVentaIn) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public transport.serviciospostventasiga.scl.tmmas.com.MigracionPrepagoPostpagoDTO WSMigracionClientePrepagoAPostpago(transport.serviciospostventasiga.scl.tmmas.com.MigracionDTO migracionDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificacionDTO[] recuperaDatoTipificacion(java.lang.String datoTipificacion, java.lang.String codVendedor) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public java.lang.String getZip(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.DireccionDTO direccion) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListTarjetaOutDTO getListadoTarjetas() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.scl.cl.tmmas.com.WsDireccionOutDTO agregarDireccion(dto.commonapp.scl.cl.tmmas.com.WsDireccionInDTO wsDireccionesIn, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.scl.cl.tmmas.com.WsAltaClienteOutDTO altaCliente(dto.commonapp.scl.cl.tmmas.com.WsCuentaInNDTO cuenta, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListBancoOutDTO getListadoBancosPAC() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsOutSSuplementariosDTO getSSincluidosEnPlan(java.lang.String codigoPlanTarifario) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TiendaDTO[] obtieneListaTienda() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.scl.cl.tmmas.com.SSuplementarioOutDTO setAgregaEliminaSS(dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsAgregaEliminaSSInDTO[] sSuplemenAgregar, dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsAgregaEliminaSSInDTO[] sSuplemenEliminar, java.lang.Long numeroCelular, java.lang.String nomUsuario, int rollback) throws java.rmi.RemoteException;
    public dto.busito.spnsclwscommon.scl.cl.tmmas.com.AltaDeLineaBusitoOutDTO altaDeLineaBusito(dto.busito.spnsclwscommon.scl.cl.tmmas.com.AltaDeLineaBusitoInDTO altaDeLineaBusitoIn) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.AceptacionVentaOutDTO aceptacionVenta(in.dto.commonapp.spnsclwscommon.scl.cl.tmmas.com.WsAceptacionVentaInDTO aceptacionVenta, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WsOutSSuplementariosDTO getSSOpcionalesAlPlan(java.lang.String codigoPlanTarifario, java.lang.String codigoArticulo, java.lang.String codigCentral) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.CierreVentaOutDTO cierreVenta(in.dto.commonapp.spnsclwscommon.scl.cl.tmmas.com.WsCierreVentaInDTO cierreVenta, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.WsDatosDireccionOutDTO getDatosDireccion(dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.DireccionDTO direccionDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsInsertTipificacionOutDTO insertarTipificacion(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TipificaClientizaDTO tipificaClientizaDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoTiposIdentificacionOutDTO getTiposIdentificacion() throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsUpdateTiendaOutDTO updateTienda(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.TiendaDTO tiendaModDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.scl.cl.tmmas.com.WsCunetaAltaDeLineaOutDTO recuperarAltaAsincrono(java.lang.String id_transaccion) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoProvinciasOutDTO getListadoProvincias(dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.RegionDTO regionDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsListadoComunasOutDTO getListadoComunas(dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.CiudadDTO ciudadDTO) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
    public dto.commonapp.scl.cl.tmmas.com.WsFacturacionVentaOutDTO procesoDeFacturacion(dto.commonapp.scl.cl.tmmas.com.WsFacturacionVentaInDTO wsFacturacionVentaIn, int rollback) throws java.rmi.RemoteException, exception.framework.cl.tmmas.com.GeneralException;
}
