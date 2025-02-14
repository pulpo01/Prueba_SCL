/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 01/06/2007	     	Elizabeth Vera        				Versión Inicial
 * 16/10/2007			Raúl Lozano							método obtieneAbonadosBeneficiarios
 */
package com.tmmas.scl.operations.crm.fab.cim.mancon.srvabo;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.AbonadoBeneficiarioBOFactory;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.AbonadoVetadoBOFactory;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.AbonadoBeneficiarioBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.AbonadoBeneficiarioBOIT;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.AbonadoVetadoBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.AbonadoVetadoBOIT;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoVetadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CalificacionAbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ConsultaHibridoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.FiltroAbonadosDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ValidaFiltroAbonadosDTO;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;
import com.tmmas.scl.operations.crm.fab.cim.mancon.srvabo.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.mancon.srvabo.interfaces.GestionAbonadoSrvIF;

public class GestionAbonadoSrv implements GestionAbonadoSrvIF {

	private final Logger logger = Logger.getLogger(GestionAbonadoSrv.class);
	
	private AbonadoBOFactoryIT factoryBO1 = new AbonadoBOFactory();
	private AbonadoIT abonadoBO = factoryBO1.getBusinessObject1();
	
	private AbonadoBeneficiarioBOFactoryIT aboBeneFactory=new AbonadoBeneficiarioBOFactory();
	private AbonadoBeneficiarioBOIT abonadoBeneficiarioBO =aboBeneFactory.getBusinessObject1();
	
	private AbonadoVetadoBOFactoryIT aboVetadoFactory=new AbonadoVetadoBOFactory();
	private AbonadoVetadoBOIT abonadoVetadoBO =aboVetadoFactory.getBusinessObject1();
	
	private Global global = Global.getInstance();	
	
	
	public AbonadoListDTO obtenerListaAbonados(ClienteDTO cliente)
			throws ManConException {
		AbonadoListDTO abonados = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerListaAbonados():start");
			abonados = abonadoBO.obtenerListaAbonados(cliente);
			logger.debug("obtenerListaAbonados():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return abonados;		
	}

	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado)
	throws ManConException {
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
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return respuesta;		
	}	
	
	public AbonadoDTO obtenerDatosAbonado2(AbonadoDTO abonado) throws ManConException
	{		
		AbonadoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosAbonado2():start");
			respuesta = abonadoBO.obtenerDatosAbonado2(abonado);	
			logger.debug("obtenerDatosAbonado2():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return respuesta;
	}
	
	public RetornoDTO consultaHibrido(ConsultaHibridoDTO consulta) throws ManConException{
		RetornoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("consultaHibrido():start");
			respuesta = abonadoBO.consultaHibrido(consulta);
			logger.debug("consultaHibrido():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return respuesta;	
	}
	
	public AbonadoBeneficiarioListDTO obtieneAbonadosBeneficiarios(AbonadoDTO abonadoDTO)throws ManConException {
		AbonadoBeneficiarioListDTO abonados = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtieneAbonadosBeneficiarios():start");
			abonados = abonadoBeneficiarioBO.obtieneAbonadosBeneficiarios(abonadoDTO);
			logger.debug("obtieneAbonadosBeneficiarios():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		 catch (Exception e) {
			 logger.debug("Exception[", e);
			 throw new ManConException(e);
		 }
		 return abonados;		
		}
	
	
	public AbonadoBeneficiarioListDTO obtieneAbonadosBeneficiariosPorNumCelular(AbonadoDTO abonadoDTO)throws ManConException {
		AbonadoBeneficiarioListDTO abonados = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtieneAbonadosBeneficiariosPorNumCelular():start");
			logger.debug("abonadoDTO.getNumCelular():::"+abonadoDTO.getNumCelular());
			abonados = abonadoBeneficiarioBO.obtieneAbonadosBeneficiariosPorNumCelular(abonadoDTO);
			logger.debug("obtieneAbonadosBeneficiariosPorNumCelular():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		 catch (Exception e) {
			 logger.debug("Exception[", e);
			 throw new ManConException(e);
		 }
		 return abonados;		
		}
		
	public RetornoDTO agregaAbonadosBeneficiarios(AbonadoBeneficiarioListDTO abonadoBeneficiarioListDTO)throws ManConException {
		RetornoDTO retValue = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("insertAbonadosBeneficiarios():start");
			retValue = abonadoBeneficiarioBO.insertAbonadosBeneficiarios(abonadoBeneficiarioListDTO);
			logger.debug("insertAbonadosBeneficiarios():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		 catch (Exception e) {
			 logger.debug("Exception[", e);
			 throw new ManConException(e);
		 }
		 return retValue;		
	}
	
	public RetornoDTO eliminaAbonadoBeneficiario(AbonadoBeneficiarioListDTO abonadoBeneficiarioListDTO)throws ManConException {
		RetornoDTO retValue = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("deleteAbonadoBeneficiario():start");
			if(abonadoBeneficiarioListDTO!=null){
				boolean isAboBenef=abonadoBeneficiarioListDTO.getAbonadoBeneficiarioList()!=null?true:false;
				for(int k=0;k<abonadoBeneficiarioListDTO.getAbonadoBeneficiarioList().length;k++){
					retValue = abonadoBeneficiarioBO.deleteAbonadoBeneficiario(abonadoBeneficiarioListDTO.getAbonadoBeneficiarioList()[k]);
				}
			}
			logger.debug("deleteAbonadoBeneficiario():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		 catch (Exception e) {
			 logger.debug("Exception[", e);
			 throw new ManConException(e);
		 }
		 return retValue;		
	}

	public RetornoDTO caducaEliminaAbonadoBeneficiario(AbonadoBeneficiarioListDTO abonadoBeneficiarioList) throws ManConException 
	{
		RetornoDTO retValue = null;
		try 
		{
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("caducaEliminaAbonadoBeneficiario():start");
			retValue=abonadoBeneficiarioBO.caducaEliminaAbonadoBeneficiario(abonadoBeneficiarioList);
			logger.debug("caducaEliminaAbonadoBeneficiario():end");
		}
		catch (GeneralException e) 
		{
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) 
		{
			 logger.debug("Exception[", e);
			 throw new ManConException(e);
		}
		return retValue;		
	}

	public AbonadoDTO obtenerNumeroMovimientoAlta(AbonadoDTO abonado) throws ManConException 
	{		
		AbonadoDTO retValue = null;
		try 
		{
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerNumeroMovimientoAlta():start");
			retValue=abonadoBO.obtenerNumeroMovimientoAlta(abonado);
			logger.debug("obtenerNumeroMovimientoAlta():end");
		}
		catch (GeneralException e) 
		{
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) 
		{
			 logger.debug("Exception[", e);
			 throw new ManConException(e);
		}
		return retValue;		
	}
	
	public AbonadoDTO obtenerDatosAbonadoByNumCelular(AbonadoDTO abonado) throws ManConException {
		AbonadoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosAbonadoByNumCelular():start");
			respuesta = abonadoBO.obtenerDatosAbonadoByNumCelular(abonado);
			logger.debug("obtenerDatosAbonadoByNumCelular():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return respuesta;		
	}
	
	public AbonadoVetadoListDTO obtieneAbonadosVetados(AbonadoDTO abonadoDTO)throws ManConException {
		AbonadoVetadoListDTO abonados = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtieneAbonadosVetados():start");
			abonados = abonadoVetadoBO.obtieneAbonadosVetados(abonadoDTO);
			logger.debug("obtieneAbonadosVetados():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		 catch (Exception e) {
			 logger.debug("Exception[", e);
			 throw new ManConException(e);
		 }
		 return abonados;		
		}
	
	public RetornoDTO actualizarAbonadoVetadoTerminoVigencia(AbonadoVetadoListDTO abonadoVetadoLisDTO)throws ManConException {
		RetornoDTO retValue = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizarAbonadoVetadoTerminoVigencia():start");
			if(abonadoVetadoLisDTO!=null){
				boolean isAboBenef=abonadoVetadoLisDTO.getAbonadoVetadoList()!=null?true:false;
				for(int k=0;k<abonadoVetadoLisDTO.getAbonadoVetadoList().length;k++){
					retValue = abonadoVetadoBO.actualizarAbonadoVetadoTerminoVigencia(abonadoVetadoLisDTO.getAbonadoVetadoList()[k]);
				}
			}
			logger.debug("actualizarAbonadoVetadoTerminoVigencia():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		 catch (Exception e) {
			 logger.debug("Exception[", e);
			 throw new ManConException(e);
		 }
		 return retValue;		
		}
	
	public RetornoDTO agregarAbonadosVetados(AbonadoVetadoListDTO abonadoVetadoListDTO)throws ManConException {
		RetornoDTO retValue = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("agregarAbonadosVetados():start");
			retValue = abonadoVetadoBO.agregarAbonadosVetados(abonadoVetadoListDTO);
			logger.debug("agregarAbonadosVetados():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		 catch (Exception e) {
			 logger.debug("Exception[", e);
			 throw new ManConException(e);
		 }
		 return retValue;		
		}
		
	public AbonadoListDTO obtenerListaAbonadosFiltrados(FiltroAbonadosDTO filtro) throws ManConException{
		AbonadoListDTO retValue = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerListaAbonadosFiltrados():start");
			retValue = abonadoBO.obtenerListaAbonadosFiltrados(filtro);
			logger.debug("obtenerListaAbonadosFiltrados():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		 catch (Exception e) {
			 logger.debug("Exception[", e);
			 throw new ManConException(e);
		 }
		 return retValue;
	}
	
	public RetornoDTO validaFiltroAbonados(ValidaFiltroAbonadosDTO filtro) throws ManConException{
		RetornoDTO retValue = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaFiltroAbonados():start");
			retValue = abonadoBO.validaFiltroAbonados(filtro);
			logger.debug("validaFiltroAbonados():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		 catch (Exception e) {
			 logger.debug("Exception[", e);
			 throw new ManConException(e);
		 }
		 return retValue;
	}	

	public CuentaPersonalDTO obtenerNumeroPersonal(CuentaPersonalDTO cuentaPersonalDTO) throws ManConException {
		CuentaPersonalDTO retValue = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerNumeroPersonal():start");
			retValue = abonadoBO.obtenerNumeroPersonal(cuentaPersonalDTO);
			logger.debug("obtenerNumeroPersonal():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		 catch (Exception e) {
			 logger.debug("Exception[", e);
			 throw new ManConException(e);
		 }
		 return retValue;		
	}
	
	public AbonadoDTO obtenerAbonadoEmpresa(ClienteDTO cliente) throws ManConException {
		AbonadoDTO abonado = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerAbonadoEmpresa():start");
			abonado = abonadoBO.obtenerAbonadoEmpresa(cliente);
			logger.debug("obtenerAbonadoEmpresa():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		 catch (Exception e) {
			 logger.debug("Exception[", e);
			 throw new ManConException(e);
		 }
		 return abonado;		
	}
	
	public AbonadoListDTO obtieneBloqueAbonados(FiltroAbonadosDTO bloque) throws ManConException{
		AbonadoListDTO abonado = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtieneBloqueAbonados():start");
			abonado = abonadoBO.obtieneBloqueAbonados(bloque);
			logger.debug("obtieneBloqueAbonados():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		 catch (Exception e) {
			 logger.debug("Exception[", e);
			 throw new ManConException(e);
		 }
		 return abonado;		
	}
	// INICIO RRG 17-02-2009 COL 78551
	public int validaAbonadoBajaProgramada(long numAbonado) throws ManConException {

		int abonado;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaAbonadoBajaProgramada():start");
			abonado = abonadoVetadoBO.validaAbonadoBajaProgramada(numAbonado);
			logger.debug("validaAbonadoBajaProgramada():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		 catch (Exception e) {
			 logger.debug("Exception[", e);
			 throw new ManConException(e);
		 }
		 return abonado;

	}
// FIN RRG 17-02-2009 COL 78551
	
	public CalificacionAbonadoDTO obtieneCalificacionAbonado(CalificacionAbonadoDTO abonado) throws ManConException{
		CalificacionAbonadoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtieneCalificacionAbonado():start");
			retorno = abonadoBO.obtieneCalificacionAbonado(abonado);
			logger.debug("obtieneCalificacionAbonado():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		 catch (Exception e) {
			 logger.debug("Exception[", e);
			 throw new ManConException(e);
		 }
		 
		 return retorno;
	}
		
}




