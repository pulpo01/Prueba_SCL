package com.tmmas.scl.operations.crm.fab.cusintman.srv.suspvol;

import java.sql.Date;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.ProductDomain.bo.DatosGeneralesBOFactory;
import com.tmmas.scl.framework.ProductDomain.bo.SuspensionVoluntariaBO;
import com.tmmas.scl.framework.ProductDomain.bo.SuspensionVoluntariaBOFactory;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.DatosGeneralesBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.DatosGeneralesBOIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SuspensionVoluntariaBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SuspensionVoluntariaBOIT;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.aplicationDomain.bo.UsuarioSistemaBOFactory;
import com.tmmas.scl.framework.aplicationDomain.bo.interfeces.UsuarioSistemaBOFactoryIT;
import com.tmmas.scl.framework.aplicationDomain.bo.interfeces.UsuarioSistemaBOIT;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.OperadoraLocalDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.aplicationDomain.exception.AplicationException;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.customerDomain.bo.ClienteBOFactory;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.ClienteBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.ClienteIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CausasSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.FechasSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PeriodoSuspencionAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SuspensionAbonadoDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.suspvol.helper.Global;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.suspvol.interfaces.SuspensionVoluntariaSrvIF;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;

public class SuspensionVoluntariaSRV implements SuspensionVoluntariaSrvIF {
	
	private final Logger logger = Logger.getLogger(SuspensionVoluntariaSRV.class);
	
	private Global global = Global.getInstance();	
	private AbonadoBOFactoryIT factoryBO11 = new AbonadoBOFactory();
	private AbonadoIT abonadoBO = factoryBO11.getBusinessObject1();	
	
	
//	 ---------------------------------------------------------------------------
	
	private ClienteBOFactoryIT factoryBO13 = new ClienteBOFactory();
	private ClienteIT clienteBO = factoryBO13.getBusinessObject1();
	private DatosGeneralesBOFactoryIT factoryBO14 = new DatosGeneralesBOFactory();
	private UsuarioSistemaBOFactoryIT factoryBO2 = new UsuarioSistemaBOFactory();
	private DatosGeneralesBOIT datosGeneralesBO = factoryBO14.getBusinessObject1();
	private UsuarioSistemaBOIT usuarioSistemaBO = factoryBO2.getBusinessObject1();

	private SuspensionVoluntariaBOFactoryIT factoryBO3 = new SuspensionVoluntariaBOFactory();
	private SuspensionVoluntariaBOIT suspensionVoluntariaBO = factoryBO3.getBusinessObject1();

	// -----------------------------------------------------------------------------------------------------------------------------------	
	
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
	
	// -----------------------------------------------------------------------------------------------------------------------------------	
		
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
	
	// -----------------------------------------------------------------------------------------------------------------------------------	
	
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
	
	// -----------------------------------------------------------------------------------------------------------------------------------
	
	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws CusIntManException {
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

	// -----------------------------------------------------------------------------------------------------------------------------------
	
	public UsuarioAbonadoDTO obtenerDatosUsuarioAbonado(UsuarioAbonadoDTO UsuarioAbonado) throws CusIntManException {
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

	// -----------------------------------------------------------------------------------------------------------------------------------
		
	public SuspensionAbonadoDTO[] obtenerSuspensionesAbonado(UsuarioAbonadoDTO usuarioAbonado) throws ProductException {

		SuspensionAbonadoDTO[] respuesta = null;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerSuspensionesAbonado():start");
			respuesta = suspensionVoluntariaBO.obtenerSuspensionesAbonado(usuarioAbonado);
			logger.debug("obtenerSuspensionesAbonado():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return respuesta;		
	
	}  // obtenerSuspensionesAbonado

	// -----------------------------------------------------------------------------------------------------------------------------------	

	public CausasSuspensionDTO[] obtenerCausasSuspension() throws ProductException	{

		CausasSuspensionDTO[] respuesta = null;
	
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerCausasSuspension():start");
			respuesta = suspensionVoluntariaBO.obtenerCausasSuspension();
			logger.debug("obtenerCausasSuspension():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return respuesta;		
	
	}  // obtenerCausasSuspension
		
	// -----------------------------------------------------------------------------------------------------------------------------------
	
	public SuspensionAbonadoDTO[] obtenerSuspensionesHistoricasAbonado(long numAbonado, java.sql.Date fecIni, java.sql.Date fecFin ) throws ProductException	{
		
		SuspensionAbonadoDTO[] respuesta = null;
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerSuspensionesHistoricasAbonado():start");
			respuesta = suspensionVoluntariaBO.obtenerSuspensionesHistoricasAbonado(numAbonado, fecIni, fecFin);
			logger.debug("obtenerSuspensionesHistoricasAbonado():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return respuesta;		
	
	}  // obtenerSuspensionesHistoricasAbonado
		
	// -----------------------------------------------------------------------------------------------------------------------------------
	
	public FechasSuspensionDTO[] recuperarFechasSuspension(ClienteOSSesionDTO sessionData) throws ProductException	{
	
		FechasSuspensionDTO[] respuesta = null;
	
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("recuperarFechasSuspension():start");
			respuesta = suspensionVoluntariaBO.recuperarFechasSuspension(sessionData);
			logger.debug("recuperarFechasSuspension():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return respuesta;		

	}  // recuperarFechasSuspension
		
	// -----------------------------------------------------------------------------------------------------------------------------------
	
	public void programarSuspension(SuspensionAbonadoDTO suspensionAbonado, ClienteOSSesionDTO sessionData) throws ProductException {
			
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("programarSuspension():start");
				suspensionVoluntariaBO.programarSuspension(suspensionAbonado, sessionData);
			logger.debug("programarSuspension():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
	}  // programarSuspension
		
	// -----------------------------------------------------------------------------------------------------------------------------------
	
	public void modificarSuspension(SuspensionAbonadoDTO suspensionAbonado) throws ProductException {	
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("modificarSuspension():start");
				suspensionVoluntariaBO.modificarSuspension(suspensionAbonado);
			logger.debug("modificarSuspension():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
	}  // modificarSuspension
		
	// -----------------------------------------------------------------------------------------------------------------------------------
	
	public void anularSuspension(SuspensionAbonadoDTO suspensionAbonado) throws ProductException {	
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("anularSuspension():start");
				suspensionVoluntariaBO.anularSuspension(suspensionAbonado);
			logger.debug("anularSuspension():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
	}  // anularSuspension
		
	// -----------------------------------------------------------------------------------------------------------------------------------

	public DatosGeneralesSuspensionDTO obtenerDatosGeneralesSuspension() throws ProductException	{
		
		DatosGeneralesSuspensionDTO respuesta = null;
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosGeneralesSuspension():start");
			respuesta = suspensionVoluntariaBO.obtenerDatosGeneralesSuspension();
			logger.debug("obtenerDatosGeneralesSuspension():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return respuesta;			
		
	}  // obtenerDatosGeneralesSuspension

// -----------------------------------------------------------------------------------------------------------------------------------
	
	public PeriodoSuspencionAbonadoDTO[] obtenerPeriodosSuspensioAbonado(UsuarioAbonadoDTO usuarioAbonado) throws ProductException	{

		PeriodoSuspencionAbonadoDTO[] respuesta = null;
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerPeriodosSuspensioAbonado():start");
			respuesta = suspensionVoluntariaBO.obtenerPeriodosSuspensioAbonado(usuarioAbonado);
			logger.debug("obtenerPeriodosSuspensioAbonado():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return respuesta;					
		
	} // obtenerPeriodosSuspensioAbonado
	
//	 -----------------------------------------------------------------------------------------------------------------------------------
	
	public void agregaPeriodoSuspension(PeriodoSuspencionAbonadoDTO periodoSuspensionAbonado) throws ProductException	{
	
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("agregaPeriodoSuspension():start");
				suspensionVoluntariaBO.agregaPeriodoSuspension(periodoSuspensionAbonado);
			logger.debug("agregaPeriodoSuspension():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
	}  // agregaPeriodoSuspension
	
//	 -----------------------------------------------------------------------------------------------------------------------------------
	
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
//	 -----------------------------------------------------------------------------------------------------------------------------------	
}  // suspensionVoluntariaSRV
