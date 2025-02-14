/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 14/01/2008	     	Daniel Sagredo        				Versión Inicial
 */
package com.tmmas.scl.operations.crm.fab.cusintman.srv.avisin;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.ProductDomain.bo.DatosGeneralesBOFactory;
import com.tmmas.scl.framework.ProductDomain.bo.SeriesBOFactory;
import com.tmmas.scl.framework.ProductDomain.bo.ServiciosSuplementariosBOFactory;
import com.tmmas.scl.framework.ProductDomain.bo.SiniestroBOFactory;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.DatosGeneralesBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.DatosGeneralesBOIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SeriesBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SeriesBOIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.ServiciosSuplementariosBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.ServiciosSuplementariosBOIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SiniestroBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SiniestroBOIT;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CambioPlanPendienteDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.MesesProrrogasDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
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
import com.tmmas.scl.operations.crm.fab.cusintman.srv.avisin.helper.Global;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.avisin.interfaces.AvisoDeSiniestroSrvIF;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;

public class AvisoDeSiniestroSrv implements AvisoDeSiniestroSrvIF {

	private final Logger logger = Logger.getLogger(AvisoDeSiniestroSrv.class);
	
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
	private ServiciosSuplementariosBOFactoryIT factoryBO6 = new ServiciosSuplementariosBOFactory();
	private DatosGeneralesBOIT datosGeneralesBO = factoryBO14.getBusinessObject1();
	private UsuarioSistemaBOIT usuarioSistemaBO = factoryBO2.getBusinessObject1();
	private SeriesBOIT seriesBO = factoryBO3.getBusinessObject1();
	private SiniestroBOIT siniestroBO = factoryBO5.getBusinessObject1();
	private ServiciosSuplementariosBOIT serviciosSuplmentariosBO = factoryBO6.getBusinessObject1();
	private VendedorBOFactoryIT factoryBO1 = new VendedorBOFactory();
	private VendedorBOIT vendedorBO = factoryBO1.getBusinessObject1();	
	
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
	
	//Inicio Inc. 174755/CSR-11002/06-09-2011/FDL
	//public SolicitudAvisoDeSiniestroDTO grabaAvisoDeSiniestro (UsuarioAbonadoDTO usuarioAbonado, TipoSiniestroDTO tipoSiniestro, TipoSuspencionDTO tipoSuspencion, CausaSiniestroDTO causaSiniestro, UsuarioSistemaDTO usuarioSistema, String actabo, String num_os, String comentario) throws ProductException {
	public SolicitudAvisoDeSiniestroDTO grabaAvisoDeSiniestro (UsuarioAbonadoDTO usuarioAbonado, TipoSiniestroDTO tipoSiniestro, TipoSuspencionDTO tipoSuspencion, CausaSiniestroDTO causaSiniestro, UsuarioSistemaDTO usuarioSistema, String actabo, String num_os, String comentario, String numeroDesvio) throws ProductException {

		SolicitudAvisoDeSiniestroDTO respuesta ;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("grabaAvisoDeSiniestro():start");
			respuesta = siniestroBO.grabaAvisoDeSiniestro(usuarioAbonado, tipoSiniestro, tipoSuspencion, causaSiniestro, usuarioSistema, actabo, num_os, comentario, numeroDesvio);
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
	//Fin Inc. 174755/CSR-11002/06-09-2011/FDL

	
//	 --------------------------------------------------------------------------------		
	
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws CusIntManException {
		ClienteDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosCliente():start");
			respuesta = clienteBO.obtenerDatosCliente2(cliente);
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

	public CambioPlanPendienteDTO validarCambioPlanPendiente(CambioPlanPendienteDTO cambioPlan) throws ProductException {
		CambioPlanPendienteDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validarCambioPlanPendiente():start");
			respuesta = siniestroBO.validarCambioPlanPendiente(cambioPlan);
			logger.debug("validarCambioPlanPendiente():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return respuesta;	
	}

//	 ---------------------------------------------------------------------------

	public OperadoraLocalDTO obtenerOperadoraLocal() throws GeneralException {
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
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return respuesta;		
	}

//	 ---------------------------------------------------------------------------
	
	//Inicio Inc. 174755/CSR-11002/06-09-2011/FDL
	public String verificaNumeroDesviado(String numeroDesviado) throws GeneralException {
		String validacionNumero;
		try {		
			logger.debug("verificaNumeroDesviado():start");
			validacionNumero = datosGeneralesBO.verificaNumeroDesviado(numeroDesviado);
			logger.debug("verificaNumeroDesviado():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return validacionNumero;		
	}
	//Fin Inc. 174755/CSR-11002/06-09-2011/FDL
}
