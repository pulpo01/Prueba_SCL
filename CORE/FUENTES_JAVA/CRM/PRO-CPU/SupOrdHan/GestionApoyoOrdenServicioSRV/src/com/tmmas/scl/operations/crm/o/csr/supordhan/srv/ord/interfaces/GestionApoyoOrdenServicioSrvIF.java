package com.tmmas.scl.operations.crm.o.csr.supordhan.srv.ord.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.CargoClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.LimiteLineasDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.LineasClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.MorosidadClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ObtencionLineasClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.AbonadoSecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CITIPORSERVDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CantSecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CausaCambioPlanListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ContratoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConvertActAboDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.DescuentoVendedorDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.DireccionOficinaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.IngresoVentaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ModalidadPagoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OficinaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OperadoraLocalDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.PenalizacionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.PrestacionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RangoAntiguedadDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ServCuentaSegDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ArchivoFacturaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CausaBajaListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GaAbocelDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ObtencionSecuenciasDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.LimiteConsumoAbonadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanCicloDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ServicioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BolsaDinamicaDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.ParamCargosAbonadoCeroDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.CartaGeneralDTO;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;

public interface GestionApoyoOrdenServicioSrvIF {

	public RetornoDTO anularCargoBolsaDinamica(BolsaDinamicaDTO bolsa) throws SupOrdHanException;
	
	public CargoClienteDTO obtenerCargoBasicoActual(CargoClienteDTO cliente) throws SupOrdHanException;
	
	public RetornoDTO validarTipoPlanCliente(ClienteDTO cliente) throws SupOrdHanException;
	
	public AbonadoDTO obtenerDatosCambPlanServ(AbonadoDTO abonado) throws SupOrdHanException;
	
	public RetornoDTO actualizarAboCtaSeg(GaAbocelDTO abonado) throws SupOrdHanException;	
	
	public RetornoDTO migrarAbonado(GaAbocelDTO abonado) throws SupOrdHanException;
	
	public GaAbocelDTO obtenerFecCumPlan(GaAbocelDTO abonado) throws SupOrdHanException;	
	
	public ConvertActAboDTO obtenerConverActAbo(ConvertActAboDTO param) throws SupOrdHanException;
	
	public RetornoDTO validarServiciosDuplicados(AbonadoDTO abonado) throws SupOrdHanException;
	
	public RetornoDTO bajaSSPrepago(AbonadoDTO abonado) throws SupOrdHanException;
	
	public RetornoDTO bajaRegTarif(AbonadoDTO abonado) throws SupOrdHanException;
	
	public ServicioDTO obtenerGrupoNivelContratado(AbonadoDTO abonado) throws SupOrdHanException;
	
	public CausaBajaListDTO obtenerCausaBaja() throws SupOrdHanException;	
	
	public PlanCicloDTO obtenerCicloFreedom(PlanCicloDTO plan) throws SupOrdHanException;	
	
	public RetornoDTO insertarTransacabo(SecuenciaDTO secuencia) throws SupOrdHanException;
	
	public PlanTarifarioDTO obtenerCategPlan(PlanTarifarioDTO plan) throws SupOrdHanException;	
	
	public ClienteDTO obtenerPlanComercial(ClienteDTO cliente) throws SupOrdHanException;	
	
	public ClienteDTO obtenerValorCalculado(ClienteDTO cliente) throws SupOrdHanException;
	
	public RangoAntiguedadDTO obtenerRangoAntiguedad(RangoAntiguedadDTO param) throws SupOrdHanException;
	
	public UsuarioDTO obtenerVendedor(UsuarioDTO usuario) throws SupOrdHanException;
	
	public CartaGeneralDTO obtenerTextoCarta(CartaGeneralDTO cartaGeneral) throws SupOrdHanException;
	
	public ArchivoFacturaDTO obtenerRutaFactura(ArchivoFacturaDTO factura) throws SupOrdHanException;
	
	public DescuentoVendedorDTO obtenerDescuentoVendedor(DescuentoVendedorDTO vendedor) throws SupOrdHanException;
	
	public PenalizacionDTO obtenerPenalizacion(PenalizacionDTO param) throws SupOrdHanException;
	
	public DireccionOficinaDTO obtenerDireccionOficina(String codOficina) throws SupOrdHanException;
	
	public Integer obtenerVendedorRaiz(Integer codVendedor) throws SupOrdHanException;
	
	public String obtenerOperadora(Long codCliente) throws SupOrdHanException;
	
	public ServCuentaSegDTO tratarServCtaSeg(ServCuentaSegDTO param) throws SupOrdHanException;
	
	public RetornoDTO registrarMovControlada(AbonadoDTO abonado) throws SupOrdHanException;
	
	public ContratoDTO obtenerTipoContrato(ContratoDTO contrato) throws SupOrdHanException;
	
	public ModalidadPagoDTO obtenerModalidadPago(ModalidadPagoDTO modalidad) throws SupOrdHanException;
	
	public VendedorDTO obtenerVendedor(VendedorDTO vendedor) throws SupOrdHanException;
	
	public LineasClienteDTO obtenerCantidadLineasCliente(LineasClienteDTO cliente) throws SupOrdHanException;	
	
	public MorosidadClienteDTO obtenerMorosidadCliente(MorosidadClienteDTO cliente) throws SupOrdHanException;
	
	public AbonadoDTO obtenerCodigoModalidad(AbonadoDTO abonado) throws SupOrdHanException;
	
	public LimiteLineasDTO obtenerLimiteLineas(ObtencionLineasClienteDTO lineas) throws SupOrdHanException;

	public RetornoDTO validarSituaCliEmp(ClienteDTO cliente) throws SupOrdHanException;
	
	public RetornoDTO validarClienteNPW(ClienteDTO cliente) throws SupOrdHanException;
	
	public PlanTarifarioDTO obtenerPlanTarifario(PlanTarifarioDTO plan) throws SupOrdHanException;
	
	public RetornoDTO validarOriDesUso(AbonadoDTO abonado) throws SupOrdHanException;
	
	public RetornoDTO insertarContratoCuenta(GaAbocelDTO contratoCuenta) throws SupOrdHanException;
	
	public RetornoDTO validaListaNegra(AbonadoDTO abonado ) throws SupOrdHanException;

	public RetornoDTO insertarGaVenta (IngresoVentaDTO venta ) throws SupOrdHanException;
	
	public RetornoDTO validarSolicitudesBaja(AbonadoDTO abonado) throws SupOrdHanException;

	public RetornoDTO validarReversa(OrdenServicioDTO ordenServicioDto)throws SupOrdHanException;
	
	public RetornoDTO validarNumPer(AbonadoDTO abonado) throws SupOrdHanException;
	
	public RetornoDTO actualizarUsoIntarcel(AbonadoDTO abonado) throws SupOrdHanException;
	
	public int validarCarta(OrdenServicioDTO ordenServicio) throws SupOrdHanException;
	
	public SecuenciaDTO[] obtenerNumeroDeSecuencias(CantSecuenciaDTO param) throws SupOrdHanException ;
	
	public  OficinaDTO obtenerDatosOficina(OficinaDTO param) throws SupOrdHanException;
	
	public AbonadoSecuenciaDTO[] obtenerSecuenciasAbonados(ObtencionSecuenciasDTO param) throws SupOrdHanException;
	//INI COL INC_72181 EV 13-12-08
	public RetornoDTO getValidacionAbonadoCero(ParamCargosAbonadoCeroDTO inValue)throws SupOrdHanException;
	//INI COL INC_72181 EV 13-12-08
	
	public  CITIPORSERVDTO obtenerTiporserv(CITIPORSERVDTO param) throws SupOrdHanException;
	
	public PrestacionListDTO obtenerPrestaciones() throws SupOrdHanException;

	public CausaCambioPlanListDTO obtenerCausasCambioPlan() throws SupOrdHanException;
	
	public OperadoraLocalDTO obtenerOperadoraLocal() throws SupOrdHanException;
	
	public PlanTarifarioDTO[] obtenerLimitesPlan(PlanTarifarioDTO planTarifario) throws SupOrdHanException;
	
	public RetornoDTO actualizaLimiteConsumoPlan(PlanTarifarioDTO planTarifario) throws SupOrdHanException;
	
	public RetornoDTO actualizarLimiteConsumoFinal(LimiteConsumoAbonadoDTO entrada)	throws SupOrdHanException;
	
	public PlanTarifarioDTO obtenerDatosPlanTarifario(String codPlanTarif) throws SupOrdHanException;
}
