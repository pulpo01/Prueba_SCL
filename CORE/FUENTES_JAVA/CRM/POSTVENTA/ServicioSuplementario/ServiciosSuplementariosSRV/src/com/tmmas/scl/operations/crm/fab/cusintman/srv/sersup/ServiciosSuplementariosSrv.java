/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 01/06/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.operations.crm.fab.cusintman.srv.sersup;

import java.util.ArrayList;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.ProductDomain.dto.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.ProductDomain.bo.DatosGeneralesBOFactory;
import com.tmmas.scl.framework.ProductDomain.bo.NumeracionCelularBOFactory;
import com.tmmas.scl.framework.ProductDomain.bo.SeriesBOFactory;
import com.tmmas.scl.framework.ProductDomain.bo.ServiciosSuplementariosBOFactory;
import com.tmmas.scl.framework.ProductDomain.bo.SiniestroBOFactory;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.DatosGeneralesBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.DatosGeneralesBOIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.NumeracionCelularBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.NumeracionCelularBOIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SeriesBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SeriesBOIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.ServiciosSuplementariosBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.ServiciosSuplementariosBOIT;
import com.tmmas.scl.framework.ProductDomain.dto.GaAboMailTODTO;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SiniestroBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SiniestroBOIT;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CategoriaTributariaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.DatosCentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.DatosNumeracionDTO;
import com.tmmas.scl.framework.ProductDomain.dto.GaServSuPlDTO;
import com.tmmas.scl.framework.ProductDomain.dto.GaServSupDefDTO;
import com.tmmas.scl.framework.ProductDomain.dto.MesesProrrogasDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.NumeracionCelularDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RegistroVentaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ReglasSSDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SSuplementarioDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SeleccionNumeroCelularDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SeleccionNumeroCelularRangoDTO;
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
import com.tmmas.scl.framework.aplicationDomain.bo.UsuarioSistemaBOFactory;
import com.tmmas.scl.framework.aplicationDomain.bo.interfeces.UsuarioSistemaBOFactoryIT;
import com.tmmas.scl.framework.aplicationDomain.bo.interfeces.UsuarioSistemaBOIT;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.OperadoraLocalDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.aplicationDomain.exception.AplicationException;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.customerDomain.bo.ClienteBOFactory;
import com.tmmas.scl.framework.customerDomain.bo.VendedorBOFactory;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.ClienteBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.ClienteIT;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.VendedorBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.VendedorBOIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.customerDomain.dto.VendedorDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.sersup.helper.Global;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.sersup.interfaces.ServiciosSuplementariosSrvIF;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;


public class ServiciosSuplementariosSrv implements ServiciosSuplementariosSrvIF {

	private final Logger logger = Logger.getLogger(ServiciosSuplementariosSrv.class);
	
	private Global global = Global.getInstance();	
	private AbonadoBOFactoryIT factoryBO11 = new AbonadoBOFactory();
	private AbonadoIT abonadoBO = factoryBO11.getBusinessObject1();	
	
	
//	 ---------------------------------------------------------------------------
	
	private ClienteBOFactoryIT factoryBO13 = new ClienteBOFactory();
	private ClienteIT clienteBO = factoryBO13.getBusinessObject1();
	private DatosGeneralesBOFactoryIT factoryBO14 = new DatosGeneralesBOFactory();
	private UsuarioSistemaBOFactoryIT factoryBO2 = new UsuarioSistemaBOFactory();
	private SeriesBOFactoryIT factoryBO3 = new SeriesBOFactory();	
	private SiniestroBOFactoryIT factoryBO5 = new SiniestroBOFactory();	
	private DatosGeneralesBOIT datosGeneralesBO = factoryBO14.getBusinessObject1();
	private UsuarioSistemaBOIT usuarioSistemaBO = factoryBO2.getBusinessObject1();
	private SeriesBOIT seriesBO = factoryBO3.getBusinessObject1();
	private SiniestroBOIT siniestroBO = factoryBO5.getBusinessObject1();
	private ServiciosSuplementariosBOFactoryIT factoryBO6 = new ServiciosSuplementariosBOFactory();
	private ServiciosSuplementariosBOIT serviciosSuplmentariosBO = factoryBO6.getBusinessObject1();
	private VendedorBOFactoryIT factoryBO1 = new VendedorBOFactory();
	private VendedorBOIT vendedorBO = factoryBO1.getBusinessObject1();
	private NumeracionCelularBOFactoryIT factoryBO10 = new NumeracionCelularBOFactory();
	private NumeracionCelularBOIT numeracionCelularBO = factoryBO10.getBusinessObject1();
	
//	 ----------------------------------------------------------------------------------------------------------------------------
	
	public ReglasSSDTO[] getReglasdeValidacionSS(UsuarioAbonadoDTO usuarioAbonado, AbonadoDTO abonado) throws CustomerException {
		ReglasSSDTO[] respuesta = null;
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerEstadoVendedor():start");
				respuesta = serviciosSuplmentariosBO.getReglasdeValidacionSS(usuarioAbonado, abonado);
			logger.debug("obtenerEstadoVendedor():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CustomerException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}
		return respuesta;
		
	}	// getReglasdeValidacionSS
	
	public VendedorDTO obtenerEstadoVendedor(VendedorDTO vendedor) throws CustomerException {
		VendedorDTO respuesta = null;
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerEstadoVendedor():start");
				respuesta = vendedorBO.obtenerEstadoVendedor(vendedor);
			logger.debug("obtenerEstadoVendedor():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CustomerException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}
		return respuesta;
		
	}	// obtenerEstadoVendedor
	
// --------------------------------------------------------------------------------

	public void bloquearVendedor(VendedorDTO vendedor) throws CustomerException {
	
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("bloquearVendedor():start");
				vendedorBO.bloquearVendedor(vendedor);
			logger.debug("bloquearVendedor():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CustomerException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}
		
	}	// bloquearVendedor
	
// --------------------------------------------------------------------------------

	public void desbloquearVendedor(VendedorDTO vendedor) throws CustomerException {
	
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("desbloquearVendedor():start");
				vendedorBO.desbloquearVendedor(vendedor);
			logger.debug("desbloquearVendedor():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CustomerException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}
		
	}	// desbloquearVendedor
	
// --------------------------------------------------------------------------------
	
	
//	 --------------------------------------------------------------------------------
	
	public BodegaDTO[] obtenerBodegas(SesionDTO sesion) throws ProductException {
		BodegaDTO[] respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerBodegas():start");
				respuesta = datosGeneralesBO.obtenerBodegas(sesion);
			logger.debug("obtenerBodegas():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return respuesta;
		
	}	// obtenerBodegas
	
// --------------------------------------------------------------------------------
	
	public CausaCamSerieDTO[] obtenerCausaCambioSerie () throws ProductException	{
		
		CausaCamSerieDTO[] respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerCausaCambioSerie():start");
				respuesta = datosGeneralesBO.obtenerCausaCambioSerie();
			logger.debug("obtenerCausaCambioSerie():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return respuesta;		

	} 	// obtenerCausaCambioSerie
	
//	 --------------------------------------------------------------------------------
	
	
	public TipoDeContratoDTO[] obtenerTiposDeContrato(SesionDTO sessionDTO) throws ProductException	{
		TipoDeContratoDTO[] respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerTiposDeContrato():start");
				respuesta = datosGeneralesBO.obtenerTiposDeContrato(sessionDTO);
			logger.debug("obtenerTiposDeContrato():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return respuesta;		
		
	}	// obtenerTiposDeContrato

//	 --------------------------------------------------------------------------------
	
	public TecnologiaDTO[] obtenerTecnologia () throws ProductException {
		TecnologiaDTO[] respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerTecnologia():start");
				respuesta = datosGeneralesBO.obtenerTecnologia();
			logger.debug("obtenerTecnologia():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return respuesta;		
		
	}	// obtenerTecnologia
	
//	 --------------------------------------------------------------------------------
	
	public MesesProrrogasDTO[] obtenerMesesProrroga () throws ProductException {	
	
		MesesProrrogasDTO[] respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerMesesProrroga():start");
				respuesta = datosGeneralesBO.obtenerMesesProrroga();
			logger.debug("obtenerMesesProrroga():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;		
		
	}	// obtenerTecnologia
	
//	 --------------------------------------------------------------------------------
	
	public ModalidadPagoDTO[] obtenerModalidadPago (SesionDTO Sesion, CausaCamSerieDTO CausaCamSerie) throws ProductException{
		
		ModalidadPagoDTO[] respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerModalidadPago():start");
				respuesta = datosGeneralesBO.obtenerModalidadPago(Sesion, CausaCamSerie);
			logger.debug("obtenerModalidadPago():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;		
		
	}	// obtenerModalidadPago
	
//	 --------------------------------------------------------------------------------	
	
	public ModalidadPagoDTO[] obtenerModalidadPagoSimcard (SesionDTO Sesion, CausaCamSerieDTO CausaCamSerie) throws ProductException{
		
		ModalidadPagoDTO[] respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerModalidadPagoSimcard():start");
				respuesta = datosGeneralesBO.obtenerModalidadPagoSimcard(Sesion, CausaCamSerie);
			logger.debug("obtenerModalidadPagoSimcard():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;		
		
	}	// obtenerModalidadPagoSimcard
	
//	 --------------------------------------------------------------------------------	

	public TipoTerminalDTO[] obtenerTipoTerminal (TecnologiaDTO tecnologia) throws ProductException{
		
		TipoTerminalDTO[] respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerTipoTerminal():start");
				respuesta = datosGeneralesBO.obtenerTipoterminal(tecnologia);
			logger.debug("obtenerTipoTerminal():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;		
		
	}	// obtenerTipoTerminal
	
//	 --------------------------------------------------------------------------------	
	
	public CuotaDTO[] obtenerCuotas (SesionDTO sesion, ModalidadPagoDTO modalidadPago) throws ProductException{
		
		CuotaDTO[] respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerCuotas():start");
				respuesta = datosGeneralesBO.obtenerCuotas(sesion, modalidadPago);
			logger.debug("obtenerCuotas():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;		
		
	}	// obtenerTipoTerminal
	
//	 --------------------------------------------------------------------------------	

	public CategoriaTributariaDTO[] obtenerCatTributaria (SesionDTO sesion) throws ProductException{
		CategoriaTributariaDTO[] respuesta = null;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerCatTributaria():start");
				respuesta = datosGeneralesBO.obtenerCatTributaria(sesion);
			logger.debug("obtenerCatTributaria():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}

		return respuesta;		
		
	}	// obtenerTipoTerminal
	
//	 --------------------------------------------------------------------------------	

	public UsosVentaDTO[] obtenerUsosVenta () throws ProductException
	{
		UsosVentaDTO[] respuesta = null;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerUsosVenta():start");
				respuesta = datosGeneralesBO.obtenerUsosVenta();
			logger.debug("obtenerUsosVenta():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}

		return respuesta;		
		
	}	// obtenerTipoTerminal
	
//	 --------------------------------------------------------------------------------	

	public CentralDTO[] obtenerCentralTecnologiaHlr (SerieDTO serie, TecnologiaDTO tecnologia) throws ProductException {
		CentralDTO[] respuesta = null;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerCentralTecnologiaHlr():start");
				respuesta = datosGeneralesBO.obtenerCentralTecnologiaHlr(serie, tecnologia);
			logger.debug("obtenerCentralTecnologiaHlr():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}

		return respuesta;		
		
	}	// obtenerCentralTecnologiaHlr
	
//	 --------------------------------------------------------------------------------	

	public void validaCausaCamSerie (SesionDTO sesion, CausaCamSerieDTO causaCamSerie) throws ProductException{
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("validaCausaCamSerie():start");
				datosGeneralesBO.validaCausaCamSerie(sesion, causaCamSerie);
			logger.debug("validaCausaCamSerie():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
	}	// validaCausaCamSerie
	
//	 --------------------------------------------------------------------------------	
		
	public MensajeRetornoDTO ejecutaRestrccion(RestriccionesDTO restricciones) throws ProductException {

		MensajeRetornoDTO respuesta = null;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("ejecutaRestrccion():start");
				respuesta = datosGeneralesBO.ejecutaRestrccion(restricciones);
			logger.debug("ejecutaRestrccion():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;		
	
	}	// ejecutaRestrccion
	
//	 --------------------------------------------------------------------------------	
		
	public UsuarioSistemaDTO obtenerInformacionUsuario(UsuarioSistemaDTO usuarioSistema) throws AplicationException {

		UsuarioSistemaDTO respuesta = null;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("ejecutaRestrccion():start");
				respuesta = usuarioSistemaBO.obtenerInformacionUsuario(usuarioSistema);
			logger.debug("ejecutaRestrccion():end");
			
		} catch (AplicationException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AplicationException(e);
		}
		
		return respuesta;		
	
	}	// obtenerInformacionUsuario
	
//	 --------------------------------------------------------------------------------	
				
	public void reservaSimcard (String accionProceso,
								SerieDTO serie, 
								UsuarioSistemaDTO usuarioSistema, 
								UsuarioAbonadoDTO usuarioAbonado, 
								String parametros,
								CausaCamSerieDTO causa,
								TipoTerminalDTO terminal,
								ModalidadPagoDTO modalidadPago) throws ProductException,CustomerException {
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("reservaSimcard():start");
			
			if (accionProceso.equals("bloquear"))	{
				String codigoPrograma = global.getValor("codigoPrograma");
			    String versionPrograma = global.getValor("versionPrograma");
			    Long versionProgramaLong = new Long (versionPrograma);
	
			    // Tomo el valor del properties y ejecuto las restricciones
			    RestriccionesDTO restriccion = new RestriccionesDTO();	                                                                                                                                                                                                                                                                                                                
			    restriccion.setCod_actuacion(global.getValor("ACT_SIMCARD"));
			    restriccion.setCod_modulo(global.getValor("MODULO_SIMCARD"));
			    restriccion.setCod_producto(1);
			    restriccion.setCod_evento("ONCLICK");	
			    restriccion.setParam_entrada(parametros);
	
			    // 1- Ejecuto las restricciones
			    MensajeRetornoDTO mensaje = ejecutaRestrccion(restriccion);
			    
			    // 2 - Obtengo la info del numero de serie
		    	SerieDTO infoSerie = seriesBO.recInfoSerie(serie);
	
		    	// Significa que la serie esta bloqueada
		    	if (!(infoSerie.getCod_estado() >= 1 && infoSerie.getCod_estado() <= 3))
		    		throw new ProductException("La serie solicitada se encuentra bloqueda.");
		    	
		    	// 3 - Valido si la bodega es valida para este numero de serie
		    	SesionDTO sesion = new SesionDTO();
		    	sesion.setCod_programa(codigoPrograma);
		    	sesion.setCodCliente(usuarioAbonado.getCod_cliente());
		    	sesion.setNum_version(versionProgramaLong.longValue());
		    	sesion.setUsuario(usuarioSistema);
		    	sesion.setNumAbonado(usuarioAbonado.getNum_abonado());
				
		    	UsoArticuloDTO usoArticulos = new UsoArticuloDTO();
		    	usoArticulos.setCod_uso(serie.getCod_uso());
		    	
		    	seriesBO.validaBodegaSerie(usoArticulos, terminal, usuarioAbonado, sesion, serie);
		    	
		    	// 4 - Valido si el vendedor tiene acceso a la bodega de la serie 
		    	VendedorDTO vendedor = new VendedorDTO();
		    	vendedor.setCod_vendedor(usuarioSistema.getCod_vendedor());
		    	
		    	BodegaDTO bodega = new BodegaDTO();
		    	Long codBodega = new Long(infoSerie.getCod_bodega());
		    	bodega.setCod_bodega(codBodega.toString());
		    	
		    	vendedorBO.validaVendedorbodega(vendedor, sesion, bodega);
		    	
		    	// 5 - Valida que la serie este relacionada a un plan comercial
		    	datosGeneralesBO.verificaPlancomercial(sesion, causa, modalidadPago, usoArticulos, terminal, serie);
		    	 
		    	// 6- Ejecuto el bloqueo de la serie
			    seriesBO.reservaSimcard(serie);
			    
		    	// ------------------------------------------------------------------------
			} // if bloquear
			else	{
		    	// 1- Ejecuto el desbloqueo de la serie
			    seriesBO.desReservaSimcard(serie);
			}
				
			logger.debug("reservaSimcard():end");
			
		} catch (ProductException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProductException[" + loge + "]");
			throw new CustomerException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (CustomerException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerException[" + loge + "]");
			throw new CustomerException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("Exception[" + loge + "]");
			throw new CustomerException(e.getMessage(), e.getCause());
		}
		
	}	// reservaSimcard
	
//	 --------------------------------------------------------------------------------
	
	public CausaSiniestroDTO[] obtenerCausasSiniestro(UsuarioAbonadoDTO usuarioAbonado, String actAbo) throws ProductException {
		
		CausaSiniestroDTO[] respuesta ;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerCausasSiniestro():start");
			respuesta = siniestroBO.obtenerCausasSiniestro(usuarioAbonado, actAbo);
			logger.debug("obtenerCausasSiniestro():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;
		
	}	// obtenerCausasSiniestro
	
//	 --------------------------------------------------------------------------------	
	
	public TipoSiniestroDTO[] obtenerTiposDeSiniestros(UsuarioAbonadoDTO usuarioAbonado) throws ProductException {
		
		TipoSiniestroDTO[] respuesta;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerTiposDeSiniestros():start");
			respuesta = siniestroBO.obtenerTiposDeSiniestros(usuarioAbonado);
			logger.debug("obtenerTiposDeSiniestros():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;
		
	}	// obtenerTiposDeSiniestros
	
//	 --------------------------------------------------------------------------------	
	
	public TipoSuspencionDTO[] obtenerTiposDeSuspencion() throws ProductException {

		TipoSuspencionDTO[] respuesta ;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerTiposDeSuspencion():start");
			respuesta = siniestroBO.obtenerTiposDeSuspencion();
			logger.debug("obtenerTiposDeSuspencion():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;
		
	}	// obtenerTiposDeSuspencion
	
//	 --------------------------------------------------------------------------------		
	
	public SolicitudAvisoDeSiniestroDTO grabaAvisoDeSiniestro (UsuarioAbonadoDTO usuarioAbonado, TipoSiniestroDTO tipoSiniestro, TipoSuspencionDTO tipoSuspencion, CausaSiniestroDTO causaSiniestro, UsuarioSistemaDTO usuarioSistema, String actabo, String num_os, String comentario) throws ProductException {

		SolicitudAvisoDeSiniestroDTO respuesta ;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("grabaAvisoDeSiniestro():start");
			respuesta = siniestroBO.grabaAvisoDeSiniestro(usuarioAbonado, tipoSiniestro, tipoSuspencion, causaSiniestro, usuarioSistema, actabo, num_os, comentario);
			logger.debug("grabaAvisoDeSiniestro():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;
		
	}	// grabaAvisoDeSiniestro
	
//	 --------------------------------------------------------------------------------			

	public void registraCambioSimcard(UsuarioAbonadoDTO usuarioAbonado, SerieDTO serie, UsoArticuloDTO usoArticulo, CuotaDTO cuota, SesionDTO sesion, ModalidadPagoDTO modalidadPago, BodegaDTO bodega, String actabo, String codModulo, CausaCamSerieDTO causaCamSerie) throws ProductException{

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("registraCambioSimcard():start");
			seriesBO.registraCambioSimcard(usuarioAbonado, serie, usoArticulo, cuota, sesion, modalidadPago, bodega, actabo, codModulo, causaCamSerie);
			logger.debug("registraCambioSimcard():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
	}	// registraCambioSimcard
	
//	 --------------------------------------------------------------------------------		
	
	public SerieDTO recInfoSerie (SerieDTO serie) throws ProductException {
		
		SerieDTO respuesta = null;
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("recInfoSerie():start");
				respuesta = seriesBO.recInfoSerie(serie);
			logger.debug("recInfoSerie():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;
		
	}  // recInfoSerie

// --------------------------------------------------------------------------------	
	
	public SiniestrosDTO[] recDatosSiniestroAboando (UsuarioAbonadoDTO usuarioAbonado) throws ProductException {
		SiniestrosDTO[] respuesta ;
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("recDatosSiniestroAboando():start");
				respuesta = siniestroBO.recDatosSiniestroAboando(usuarioAbonado);
			logger.debug("recDatosSiniestroAboando():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;
		
	}  // recDatosSiniestroAboando

// --------------------------------------------------------------------------------	
	
	public SSuplementarioDTO[] obtenerServiciosDisplonibles(UsuarioAbonadoDTO usuarioAbonado, SesionDTO sesion) throws ProductException{

		SSuplementarioDTO[] respuesta = null;
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerServiciosDisplonibles():start");
				respuesta = serviciosSuplmentariosBO.obtenerServiciosDisplonibles(usuarioAbonado, sesion);
			logger.debug("obtenerServiciosDisplonibles():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;
		
	}  // obtenerServiciosDisplonibles

// --------------------------------------------------------------------------------	
		
	public SSuplementarioDTO[] obtenerServiciosContratados(UsuarioAbonadoDTO usuarioAbonado, long opcion) throws ProductException{
		SSuplementarioDTO[] respuesta = null;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerServiciosContratados():start");
				respuesta = serviciosSuplmentariosBO.obtenerServiciosContratados(usuarioAbonado, opcion);
			logger.debug("obtenerServiciosContratados():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;
		
	}  // obtenerServiciosContratados

// --------------------------------------------------------------------------------	

	public void anulaSinistroAbonado(SiniestrosDTO Siniestros, UsuarioAbonadoDTO usuarioAbonado, SesionDTO sesion) throws ProductException {

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("anulaSinistroAbonado():start");
			siniestroBO.anulaSinistroAbonado(Siniestros, usuarioAbonado, sesion);
			logger.debug("anulaSinistroAbonado():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
	}	// anulaSinistroAbonado
	
//	 --------------------------------------------------------------------------------
	
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws CusIntManException {
		ClienteDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosCliente():start");
			respuesta = clienteBO.obtenerDatosCliente(cliente);
			logger.debug("obtenerDatosCliente():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		return respuesta;
	}
	
	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado)
	throws CusIntManException {
		AbonadoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosAbonado():start");
			respuesta = abonadoBO.obtenerDatosAbonado(abonado);
			logger.debug("obtenerDatosAbonado():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		return respuesta;		
	}

// ---------------------------------------------------------------------------
	
	public UsuarioAbonadoDTO obtenerDatosUsuarioAbonado(UsuarioAbonadoDTO UsuarioAbonado)
	throws CusIntManException {
		UsuarioAbonadoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosUsuarioAbonado():start");
			respuesta = abonadoBO.obtenerDatosUsuarioCelular(UsuarioAbonado);
			logger.debug("obtenerDatosUsuarioAbonado():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		return respuesta;		
	
	}  // obtenerDatosUsuarioAbonado

//	 ---------------------------------------------------------------------------

	public void actDesactSS(ClienteOSSesionDTO sessionData, String listServAct, String listServDesac, String montoTotal, UsuarioSistemaDTO usuarioSistema, String comentario) throws CusIntManException {
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registrarSS():start");
			serviciosSuplmentariosBO.actDesactSS(sessionData, listServAct, listServDesac, montoTotal, usuarioSistema, comentario );
			logger.debug("registrarSS():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		
	}  // actDesactSS

//	 ---------------------------------------------------------------------------
	
	public SSuplementarioDTO[] getServiciosBBContratados(UsuarioAbonadoDTO usuarioAbonado) throws CusIntManException {
		
		SSuplementarioDTO[] resultado = null;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("getFlagBlackberryActivado():start");
			resultado = serviciosSuplmentariosBO.getServiciosBBContratados(usuarioAbonado);
			logger.debug("getFlagBlackberryActivado():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		
		return resultado;		
			
	}  // getFlagBlackberryActivado

//	 ---------------------------------------------------------------------------------------------------------------
	public GaServSupDefDTO[] getObtieneListCodServPorDef(GaServSupDefDTO gaServSupDefDTO) throws CusIntManException {
		GaServSupDefDTO[] resultado = null;

		try {
			logger.debug("getObtieneListCodServPorDef():start");
				resultado = serviciosSuplmentariosBO.getObtieneListCodServPorDef(gaServSupDefDTO);
			logger.debug("getObtieneListCodServPorDef():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		
		return resultado;
	}
	//---------------------------------------------------------------------------------------------------------------
	
	public GaServSuPlDTO getEstadoCorreoServSupl(GaServSuPlDTO gaServSuPlDTO) throws CusIntManException {
		GaServSuPlDTO resultado = null;

		try {
			logger.debug("getEstadoCorreoServSupl():start");
				resultado = serviciosSuplmentariosBO.getEstadoCorreoServSupl(gaServSuPlDTO);
			logger.debug("getEstadoCorreoServSupl():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		
		return resultado;
	}
	//---------------------------------------------------------------------------------------------------------------
	
	public GaAboMailTODTO[] getAbomailTOxNumAbonado (GaAboMailTODTO gaAboMailTODTO)throws  CusIntManException {
		GaAboMailTODTO[] resultado = null;

		try {
			logger.debug("getAbomailTOxNumAbonado():start");
			resultado = serviciosSuplmentariosBO.getAbomailTOxNumAbonado(gaAboMailTODTO);
			logger.debug("getAbomailTOxNumAbonado():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		
		return resultado;
	}
	//---------------------------------------------------------------------------------------------------------------
	
	public OperadoraLocalDTO obtenerOperadoraLocal() throws CusIntManException {
		OperadoraLocalDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerOperadoraLocal():start");
			respuesta = datosGeneralesBO.obtenerOperadoraLocal();
			logger.debug("obtenerOperadoraLocal():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		return respuesta;		
	}

	//---------------------------------------------------------------------------------------------------------------
	
	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO entrada) throws CusIntManException {
		ParametrosGeneralesDTO resultado = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("getParametroGeneral():start");
			resultado = datosGeneralesBO.getParametroGeneral(entrada);
			logger.debug("getParametroGeneral():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		return resultado;		
	}
	
	//---------------------------------------------------------------------------------------------------------------

	public DatosCentralDTO obtenerDatosCentral(int codCentral) throws CusIntManException {

		DatosCentralDTO resultado = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosCentral():start");
			resultado = datosGeneralesBO.obtenerDatosCentral(codCentral);
			logger.debug("obtenerDatosCentral():end");
		} catch (ProductException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		return resultado;	
		
	} // obtenerDatosCentral
	
//	---------------------------------------------------------------------------------------------------------------

	public void reponerNumeracion(NumeracionCelularDTO numeracionCelularVO) throws CusIntManException {

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("reponerNumeracion():start");
			numeracionCelularBO.reponerNumeracion(numeracionCelularVO);
			logger.debug("reponerNumeracion():end");
		} catch (ProductException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		
	} // reponerNumeracion

	
//	---------------------------------------------------------------------------------------------------------------

	public SeleccionNumeroCelularDTO[]  obtenerNumeracionReservada(DatosNumeracionDTO datosNumeracionDTO) throws CusIntManException {

		SeleccionNumeroCelularDTO[] arrayNumerosReservados = null;
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerNumeracionReservada():start");
			arrayNumerosReservados = numeracionCelularBO.obtenerNumeracionReservada(datosNumeracionDTO);
			logger.debug("obtenerNumeracionReservada():end");
		} catch (ProductException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		
		return arrayNumerosReservados;
		
	} // obtenerNumeracionReservada
	
	
//	---------------------------------------------------------------------------------------------------------------

	public String obtieneCategoria(DatosNumeracionDTO datosNumeracionVO) throws CusIntManException {

		String arrCat = "";
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtieneCategoria():start");
			String[] arregloCategorias = numeracionCelularBO.obtieneCategoria(datosNumeracionVO);

		    if(arregloCategorias.length > 0)
		    	arrCat += arregloCategorias[0];
		    for (int j = 1; j < arregloCategorias.length; j++) {
				arrCat += "," + arregloCategorias[j];
			}	    
		    
			logger.debug("obtieneCategoria():end");
		} catch (ProductException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		
		return arrCat;
		
	} // obtieneCategoria

//	---------------------------------------------------------------------------------------------------------------
	
	public String obtenerCeldaAbonado(long numAbonado) throws CusIntManException {

		String codCelda = null;
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerCeldaAbonado():start");
			codCelda = abonadoBO.obtenerCeldaAbonado(numAbonado);
			logger.debug("obtenerCeldaAbonado():end");
		} catch (CustomerException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		
		return codCelda;
		
	} // obtenerCeldaAbonado
	
	
//	---------------------------------------------------------------------------------------------------------------

	public DatosNumeracionDTO obtieneNumeracionAutomatica(DatosNumeracionDTO datosNumeracionDTO) throws CusIntManException {

		DatosNumeracionDTO retorno = null;
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtieneNumeracionAutomatica():start");
			retorno = numeracionCelularBO.obtieneNumeracionAutomatica(datosNumeracionDTO);
			logger.debug("obtieneNumeracionAutomatica():end");
		} catch (ProductException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		
		return retorno;
		
	} // obtieneNumeracionAutomatica
	
	
//	---------------------------------------------------------------------------------------------------------------

	public SeleccionNumeroCelularDTO[] obtieneNumeracionReutilizable(DatosNumeracionDTO datosNumeracionVO)  throws CusIntManException {

		SeleccionNumeroCelularDTO[] retorno = null;
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtieneNumeracionReutilizable():start");
			retorno = numeracionCelularBO.obtieneNumeracionReutilizable(datosNumeracionVO);
			logger.debug("obtieneNumeracionReutilizable():end");
		} catch (ProductException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		
		return retorno;
		
	} // obtieneNumeracionReutilizable
	
	
//	---------------------------------------------------------------------------------------------------------------

	public SeleccionNumeroCelularRangoDTO[] obtenerNumeracionRango(DatosNumeracionDTO datosNumeracionVO) throws CusIntManException {

		SeleccionNumeroCelularRangoDTO[] retorno = null;
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerNumeracionRango():start");
			retorno = numeracionCelularBO.obtenerNumeracionRango(datosNumeracionVO);
			logger.debug("obtenerNumeracionRango():end");
		} catch (ProductException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		
		return retorno;
		
	} // obtenerNumeracionRango
	
	
//	---------------------------------------------------------------------------------------------------------------	
	
	public void reservaNumeroCelular(NumeracionCelularDTO numeracionCelularVO) throws CusIntManException {

		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("reservaNumeroCelular():start");
			numeracionCelularBO.reservaNumeroCelular(numeracionCelularVO);
			logger.debug("reservaNumeroCelular():end");
		} catch (ProductException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		
	} // reservaNumeroCelular
	
	
//	---------------------------------------------------------------------------------------------------------------	

	public void insertarNumeroCelularReservado(NumeracionCelularDTO numeracionCelularVO) throws CusIntManException {

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("insertarNumeroCelularReservado():start");
			numeracionCelularBO.insertarNumeroCelularReservado(numeracionCelularVO);
			logger.debug("insertarNumeroCelularReservado():end");
		} catch (ProductException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		
	} // insertarNumeroCelularReservado
	
	
//	---------------------------------------------------------------------------------------------------------------
	
	public void desReservaNumeroCelular(NumeracionCelularDTO numeracionCelularVO) throws CusIntManException {

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("desReservaNumeroCelular():start");
			numeracionCelularBO.desReservaNumeroCelular(numeracionCelularVO);
			logger.debug("desReservaNumeroCelular():end");
		} catch (ProductException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		
	} // desReservaNumeroCelular
	
	
//	---------------------------------------------------------------------------------------------------------------

	
	public void actualizaNroFax(long numAbonado, String numeroFax) throws CusIntManException {

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizaNroFax():start");
			numeracionCelularBO.actualizaNroFax(numAbonado, numeroFax);
			logger.debug("actualizaNroFax():end");
		} catch (ProductException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		
	} // actualizaNroFax
	
	
//	---------------------------------------------------------------------------------------------------------------

}
