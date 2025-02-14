package com.tmmas.scl.framework.ProductDomain.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.ProductDomain.bo.interfaces.ServiciosSuplementariosBOIT;
import com.tmmas.scl.framework.ProductDomain.dao.ServiciosSuplementariosDAO;
import com.tmmas.scl.framework.ProductDomain.dao.interfaces.ServiciosSuplementariosDAOIT;
import com.tmmas.scl.framework.ProductDomain.dto.GaAboMailTODTO;
import com.tmmas.scl.framework.ProductDomain.dto.GaServSuPlDTO;
import com.tmmas.scl.framework.ProductDomain.dto.GaServSupDefDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ReglasSSDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SSuplementarioDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;

public class ServiciosSuplementariosBO implements ServiciosSuplementariosBOIT{


	private ServiciosSuplementariosDAOIT serviciosSuplementariosDAO = new ServiciosSuplementariosDAO();		
	private final Logger logger = Logger.getLogger(ServiciosSuplementariosBO.class);

	public ReglasSSDTO[] getReglasdeValidacionSS(UsuarioAbonadoDTO usuarioAbonado, AbonadoDTO abonado) throws ProductException {
		ReglasSSDTO[] resultado = null;
		try{
			logger.debug("obtenerServiciosDisplonibles():start");
			resultado= serviciosSuplementariosDAO.getReglasdeValidacionSS(usuarioAbonado, abonado);
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		logger.debug("obtenerServiciosDisplonibles():end");
		return resultado;

	}
	public SSuplementarioDTO[] obtenerServiciosDisplonibles(UsuarioAbonadoDTO usuarioAbonado, SesionDTO sesion) throws ProductException{

		SSuplementarioDTO[] respuesta = null;
		try {
			logger.debug("obtenerServiciosDisplonibles():start");
			respuesta = serviciosSuplementariosDAO.obtenerServiciosDisplonibles(usuarioAbonado, sesion);
			logger.debug("obtenerServiciosDisplonibles():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return respuesta;			

	}

	public SSuplementarioDTO[] obtenerServiciosContratados(UsuarioAbonadoDTO usuarioAbonado, long opcion) throws ProductException{
		SSuplementarioDTO[] respuesta = null;
		try {
			logger.debug("obtenerServiciosContratados():start");
			respuesta = serviciosSuplementariosDAO.obtenerServiciosContratados(usuarioAbonado, opcion);
			logger.debug("obtenerServiciosContratados():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return respuesta;					
	}

	// ----------------------------------------------------------------------------------------------------------------------------------------
	
	public void actDesactSS(ClienteOSSesionDTO sessionData, String listServAct, String listServDesac, String montoTotal, UsuarioSistemaDTO usuarioSistema, String comentario) throws ProductException {

		try {
			logger.debug("registrarSS():start");
			serviciosSuplementariosDAO.actDesactSS(sessionData, listServAct, listServDesac, montoTotal, usuarioSistema, comentario);
			logger.debug("registrarSS():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
				
	}	// registrarSS
	
	// ----------------------------------------------------------------------------------------------------------------------------------------

	public SSuplementarioDTO[] getServiciosBBContratados(UsuarioAbonadoDTO usuarioAbonado) throws ProductException	{
		
		SSuplementarioDTO[] resultado = null;

		try {
			logger.debug("getFlagBlackberryActivado():start");
				resultado = serviciosSuplementariosDAO.getServiciosBBContratados(usuarioAbonado);
			logger.debug("getFlagBlackberryActivado():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}			
		
		return resultado;
		
	}	// getFlagBlackberryActivado
	public GaServSupDefDTO[] getObtieneListCodServPorDef(GaServSupDefDTO gaServSupDefDTO) throws ProductException {
		GaServSupDefDTO[] resultado = null;

		try {
			logger.debug("getObtieneListCodServPorDef():start");
				resultado = serviciosSuplementariosDAO.getObtieneListCodServPorDef(gaServSupDefDTO);
			logger.debug("getObtieneListCodServPorDef():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}			
		
		return resultado;
	}
	public GaServSuPlDTO getEstadoCorreoServSupl(GaServSuPlDTO gaServSuPlDTO) throws ProductException {
		// TODO Auto-generated method stub
		GaServSuPlDTO resultado = null;

		try {
			logger.debug("getEstadoCorreoServSupl():start");
				resultado = serviciosSuplementariosDAO.getEstadoCorreoServSupl(gaServSuPlDTO);
			logger.debug("getEstadoCorreoServSupl():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}			
		
		return resultado;
	}
	public GaAboMailTODTO[] getAbomailTOxNumAbonado(GaAboMailTODTO gaAboMailTODTO) throws ProductException {
		GaAboMailTODTO[] resultado = null;
		try {
			logger.debug("getObtieneListCodServPorDef():start");
				resultado = serviciosSuplementariosDAO.getAbomailTOxNumAbonado(gaAboMailTODTO);
			logger.debug("getObtieneListCodServPorDef():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}			
		
		return resultado;
	}
	
	// ----------------------------------------------------------------------------------------------------------------------------------------
		
	
}
