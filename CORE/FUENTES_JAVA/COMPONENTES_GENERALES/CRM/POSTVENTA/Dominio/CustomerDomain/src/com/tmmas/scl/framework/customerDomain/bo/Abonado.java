package com.tmmas.scl.framework.customerDomain.bo;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.customerDomain.dao.AbonadoDAO;
import com.tmmas.scl.framework.customerDomain.dao.interfaces.AbonadoDAOIT;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.customerDomain.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;



public class Abonado implements AbonadoIT {

	private AbonadoDAOIT abonadoDAO = new AbonadoDAO();	
	private final Logger logger = Logger.getLogger(Abonado.class);
	private final Global global = Global.getInstance();

	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws CustomerException{

		AbonadoDTO respuesta = null;
		try {
			logger.debug("obtenerDatosAbonado():start");
			respuesta = abonadoDAO.obtenerDatosAbonado(abonado);
			logger.debug("obtenerDatosAbonado():end");
		} catch (CustomerException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return respuesta;			
		
	}
	

	public String obtenerCeldaAbonado(long numAbonado) throws CustomerException{

		String codCelda = null;
		try {
			logger.debug("obtenerDatosAbonado():start");
			codCelda = abonadoDAO.obtenerCeldaAbonado(numAbonado);
			logger.debug("obtenerDatosAbonado():end");
		} catch (CustomerException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return codCelda;			
		
	}
	
	
	public UsuarioAbonadoDTO obtenerDatosUsuarioCelular(UsuarioAbonadoDTO UsuarioAbonado)
	throws CustomerException {
		
		try {
			logger.debug("obtenerDatosUsuarioCelular():start");
			UsuarioAbonado = abonadoDAO.obtenerDatosUsuarioCelular(UsuarioAbonado);
			logger.debug("obtenerDatosUsuarioCelular():end");
		} catch (CustomerException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return UsuarioAbonado;			
		
	}	
	
	public UsuarioAbonadoDTO getPlanTarifarioDefault(UsuarioAbonadoDTO usuarioAbonadoDTO)throws CustomerException{
	
		try {
			logger.debug("getPlanTarifarioDefault():start");
			usuarioAbonadoDTO = abonadoDAO.getPlanTarifarioDefault(usuarioAbonadoDTO);
			logger.debug("getPlanTarifarioDefault():end");
		} catch (CustomerException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return usuarioAbonadoDTO;	
	}


	/**
	 * Obtiene los datos del abonado para las OOSS Aviso y Anulacion de Siniestro.
	 * Package: PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_ABOCLIENTE2_PR
	 * @param cliente del tipo ClienteDTO
	 * @return AbonadoDTO
	 * @throws CustomerException
	 * @author Santiago Ventura
	 * @date 15-04-2010 
	 */	
	public AbonadoDTO obtenerDatosAbonado2(AbonadoDTO abonado) throws CustomerException {
		AbonadoDTO respuesta = null;
		try {
			logger.debug("obtenerDatosAbonado2():start");
			respuesta = abonadoDAO.obtenerDatosAbonado2(abonado);
			logger.debug("obtenerDatosAbonado2():end");
		} catch (CustomerException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return respuesta;
	}
}