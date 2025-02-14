package com.tmmas.scl.operations.crm.fab.cusintman.srv.camser.interfaces;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.ProductDomain.dto.ArticuloInDTO;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CategoriaTributariaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.MesesProrrogasDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SSuplementarioDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SiniestrosDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SolicitudAvisoDeSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TecnologiaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoDeContratoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSuspencionDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoTerminalDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsoArticuloDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsosVentaDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.OperadoraLocalDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.aplicationDomain.exception.AplicationException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ArticuloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.customerDomain.dto.VendedorDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCambioSerieDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SimcardDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;

import com.tmmas.cl.scl.socketps.common.dto.SaldoDTO; // RRG 23-09-2008 COL 70904

public interface CambioDeSerieSrvIF {	
	
	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws CusIntManException;	
	public UsuarioAbonadoDTO obtenerDatosUsuarioAbonado(UsuarioAbonadoDTO UsuarioAbonado) throws CusIntManException;
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws CusIntManException;
	public BodegaDTO[] obtenerBodegas(SesionDTO sesion) throws ProductException;	
	public CausaCamSerieDTO[] obtenerCausaCambioSerie () throws ProductException;
	public TipoDeContratoDTO[] obtenerTiposDeContrato(SesionDTO sessionDTO) throws ProductException;
	public MesesProrrogasDTO[] obtenerMesesProrroga () throws ProductException;
	public TecnologiaDTO[] obtenerTecnologia () throws ProductException;
	public ModalidadPagoDTO[] obtenerModalidadPago (SesionDTO Sesion, CausaCamSerieDTO CausaCamSerie) throws ProductException;
	public TipoTerminalDTO[] obtenerTipoTerminal (TecnologiaDTO tecnologia) throws ProductException;
	public CuotaDTO[] obtenerCuotas (SesionDTO sesion, ModalidadPagoDTO modalidadPago) throws ProductException;
	public CategoriaTributariaDTO[] obtenerCatTributaria (SesionDTO sesion) throws ProductException;
	public UsosVentaDTO[] obtenerUsosVenta () throws ProductException;
	public CentralDTO[] obtenerCentralTecnologiaHlr (SerieDTO serie, TecnologiaDTO tecnologia) throws ProductException;
	public ModalidadPagoDTO[] obtenerModalidadPagoSimcard (SesionDTO Sesion, CausaCamSerieDTO CausaCamSerie) throws ProductException;
	public void validaCausaCamSerie (SesionDTO sesion, CausaCamSerieDTO causaCamSerie) throws ProductException;
	public MensajeRetornoDTO ejecutaRestrccion(RestriccionesDTO Restricciones) throws ProductException;
	public UsuarioSistemaDTO obtenerInformacionUsuario(UsuarioSistemaDTO usuarioSistema) throws AplicationException;
	public CausaSiniestroDTO[] obtenerCausasSiniestro(UsuarioAbonadoDTO usuarioAbonado, String actAbo) throws ProductException;
	public TipoSiniestroDTO[] obtenerTiposDeSiniestros(UsuarioAbonadoDTO usuarioAbonado) throws ProductException;
	public TipoSuspencionDTO[] obtenerTiposDeSuspencion() throws ProductException;
	public SolicitudAvisoDeSiniestroDTO grabaAvisoDeSiniestro (UsuarioAbonadoDTO usuarioAbonado, TipoSiniestroDTO tipoSiniestro, TipoSuspencionDTO tipoSuspencion, CausaSiniestroDTO causaSiniestro, UsuarioSistemaDTO usuarioSistema, String actabo, String num_os, String comentario) throws ProductException;
	public void registraCambioSimcard(UsuarioAbonadoDTO usuarioAbonado, SerieDTO serie, UsoArticuloDTO usoArticulo, CuotaDTO cuota, SesionDTO sesion, ModalidadPagoDTO modalidadPago, BodegaDTO bodega, String actabo, String codModulo, CausaCamSerieDTO causaCamSerie) throws ProductException;
	public SerieDTO recInfoSerie (SerieDTO serie) throws ProductException; 
	public SiniestrosDTO[] recDatosSiniestroAboando (UsuarioAbonadoDTO usuarioAbonado) throws ProductException;
	public void anulaSinistroAbonado(SiniestrosDTO Siniestros, UsuarioAbonadoDTO usuarioAbonado, SesionDTO sesion) throws ProductException;
	public VendedorDTO obtenerEstadoVendedor(VendedorDTO Vendedor) throws CustomerException;
	public void bloquearVendedor(VendedorDTO Vendedor) throws CustomerException;
	//public SerieDTO reservaSimcard (String accionProceso, SerieDTO serie, UsuarioSistemaDTO usuarioSistema, UsuarioAbonadoDTO usuarioAbonado, String parametros, CausaCamSerieDTO causa, TipoTerminalDTO terminal, ModalidadPagoDTO modalidadPago,String tipoAccion) throws ProductException, CustomerException;
	public SerieDTO reservaSimcard (String accionProceso, SerieDTO serie, UsuarioSistemaDTO usuarioSistema, UsuarioAbonadoDTO usuarioAbonado, String parametros, CausaCamSerieDTO causa, TipoTerminalDTO terminal, ModalidadPagoDTO modalidadPago,String tipoAccion, String prmSerieInternta ) throws ProductException, CustomerException;
	
	//public String registraCambioDeSerie(ParametrosCambioSerieDTO parametros) throws ProductException;
	public String registraCambioDeSerie(ParametrosCambioSerieDTO parametros, SaldoDTO parametroSaldo) throws ProductException;
	public ArticuloDTO[] obtenerListaArticulos (ArticuloDTO articuloDTO) throws ProductException;
	public TerminalDTO obtenerTerminal (TerminalDTO terminalDTO) throws ProductException;
	public RetornoDTO verificaConcFactGarantia(ParametroDTO parametrosDTO )throws GeneralException;
	public RetornoDTO validaSeleccionCausa(ParametrosCambioSerieDTO parametrosCambioSerieDTO)throws GeneralException;
	public SimcardDTO obtenerSimcard (SimcardDTO simcardDTO) throws ProductException;
	public PlanTarifarioDTO getCategoriaPlanTarifario(PlanTarifarioDTO planTarifarioDTO)throws GeneralException;
	public UsuarioAbonadoDTO getPlanTarifarioDefault(UsuarioAbonadoDTO usuarioAbonadoDTO)throws GeneralException;
	public OperadoraLocalDTO obtenerOperadoraLocal() throws GeneralException;
	
	public BodegaDTO[] obtieneBodega(BodegaDTO entrada) throws GeneralException;
	public SerieDTO[] obtieneSerie(SerieDTO entrada) throws GeneralException;
	public SerieDTO[] obtieneSeries(SerieDTO entrada) throws GeneralException;
	public SerieDTO[] obtieneSeriesSinUso(SerieDTO entrada) throws GeneralException;//177697 PAH
	public ArticuloInDTO[] obtieneArticulos(ArticuloInDTO entrada) throws GeneralException;
	public RetornoDTO validaSerieExternaEquipo (SerieDTO serie) throws GeneralException;
	public RetornoDTO validaSerieExterna(SerieDTO serie) throws GeneralException;
	
	public String consultarSeguroAbonado(Long numAbonado) throws GeneralException;
}  // CambioDeSerieSrvIF
