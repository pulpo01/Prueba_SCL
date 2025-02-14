package com.tmmas.scl.frameworkooss.srv.interfaces;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteCobroAdentadoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ContratoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoVendedorDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.IngresoVentaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarRenovaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerOrderException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ArchivoFacturaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CartaGeneralDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CuotasProductoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaFormasPagoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaTiposDocumentoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.DocumentoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.FormaPagoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RespuestaSolicitudDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;

public interface FrmkOOSSSrvIF {
	
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO secuencia) throws Exception;
	
	public FormaPagoListDTO obtenerFormasPago(BusquedaFormasPagoDTO param) throws GeneralException;
	
	public DocumentoListDTO obtenerTiposDocumentos(BusquedaTiposDocumentoDTO param) throws GeneralException;
	
	public RetornoDTO eliminarSolicitud(RegistroSolicitudDTO registro) throws GeneralException;
	
	public RetornoDTO eliminarPresupuesto(RegistroFacturacionDTO registro) throws GeneralException;
	
	public CuotasProductoDTO[] obtenerCuotasProducto() throws GeneralException;
	
	public UsuarioDTO obtenerVendedor(UsuarioDTO usuario) throws GeneralException;
	
	public CartaGeneralDTO obtenerTextoCarta(CartaGeneralDTO cartaGeneral) throws GeneralException;
	
	public DescuentoVendedorDTO obtenerDescuentoVendedor(DescuentoVendedorDTO vendedor) throws GeneralException;
	
	public RespuestaSolicitudDTO solicitarAprobacionDescuento(RegistroSolicitudListDTO registro)throws GeneralException;
	
	public RegistroSolicitudDTO consultarEstadoSolicitud(RegistroSolicitudDTO registro) throws GeneralException;
	
	public RetornoDTO registrarVenta(IngresoVentaDTO venta) throws GeneralException;
	
	public RetornoDTO aceptarPresupuesto(PresupuestoDTO presup) throws GeneralException;
	
	public ContratoDTO obtenerTipoContrato(ContratoDTO contrato) throws GeneralException;
	
	public ModalidadPagoDTO obtenerModalidadPago(ModalidadPagoDTO modalidad) throws GeneralException;
	
	public PresupuestoDTO obtenerDetallePresupuesto(PresupuestoDTO presup) throws GeneralException;
	
	public VendedorDTO obtenerVendedor(VendedorDTO vendedor) throws GeneralException;
	
	public RetornoDTO insertarConceptoDescuento(DescuentoDTO desc) throws GeneralException;
	
	public DescuentoDTO obtenerCodConceptoDescuento(DatosGeneralesDTO sec) throws GeneralException;
	
	public RetornoDTO eliminaCodConceptoDescuento(long numTransaccion) throws GeneralException;
	
	public ClienteDTO obtenerPlanComercial(ClienteDTO cliente) throws GeneralException;
	
	public RetornoDTO consultarEstadoFacturado(long numProceso) throws GeneralException;
	
	public ArchivoFacturaDTO obtenerRutaFactura(ArchivoFacturaDTO factura) throws GeneralException;
	
	public ParametroDTO obtenerParametroGeneral(ParametroDTO registro) throws GeneralException;
	
	public RetornoDTO registrarOOSSEnLinea(RegistrarOossEnLineaDTO registro) throws GeneralException;
	
	public RetornoDTO actualizaRenova(RegistrarRenovaDTO param) throws GeneralException;
	
	//Santiago Ventura 23-04-2010	
	public AbonadoDTO obtenerDatosAbonado2(AbonadoDTO abonado) throws GeneralException;		
	
    //Santiago Ventura 23-04-2010
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws GeneralException;

	public RetornoDTO insertarCobroAdelantado(ClienteCobroAdentadoDTO clienteCobroAdelantadoDTO) throws GeneralException;
	
	public boolean registrarCarta(CartaGeneralDTO dto, long numOS) throws GeneralException;
}
