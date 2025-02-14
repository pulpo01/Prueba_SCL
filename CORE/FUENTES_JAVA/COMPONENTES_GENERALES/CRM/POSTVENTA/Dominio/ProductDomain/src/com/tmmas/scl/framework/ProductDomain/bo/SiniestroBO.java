package com.tmmas.scl.framework.ProductDomain.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SiniestroBOIT;
import com.tmmas.scl.framework.ProductDomain.dao.SiniestroDAO;
import com.tmmas.scl.framework.ProductDomain.dao.interfaces.SiniestroDAOIT;
import com.tmmas.scl.framework.ProductDomain.dto.CambioPlanPendienteDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SiniestrosDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SolicitudAvisoDeSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSuspencionDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;

public class SiniestroBO implements SiniestroBOIT{

	private SiniestroDAOIT SiniestroDAO = new SiniestroDAO();
	private final Logger logger = Logger.getLogger(SiniestroBO.class);
	
	public CausaSiniestroDTO[] obtenerCausasSiniestro(UsuarioAbonadoDTO usuarioAbonado, String Actabo) throws ProductException {
		CausaSiniestroDTO[] respuesta ;
		try {
			logger.debug("recInfoSerie():start");
			respuesta = SiniestroDAO.obtenerCausasSiniestro(usuarioAbonado,Actabo);
			logger.debug("recInfoSerie():end");
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

	public TipoSiniestroDTO[] obtenerTiposDeSiniestros(UsuarioAbonadoDTO usuarioAbonado) throws ProductException {
		TipoSiniestroDTO[] respuesta ;
		try {
			logger.debug("recInfoSerie():start");
			respuesta = SiniestroDAO.obtenerTiposDeSiniestros(usuarioAbonado);
			logger.debug("recInfoSerie():end");
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

	public TipoSuspencionDTO[] obtenerTiposDeSuspencion() throws ProductException {
		TipoSuspencionDTO[] respuesta ;
		try {
			logger.debug("recInfoSerie():start");
			respuesta = SiniestroDAO.obtenerTiposDeSuspencion();
			logger.debug("recInfoSerie():end");
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
	//Inicio Inc. 174755/CSR-11002/06-09-2011/FDL
	//public SolicitudAvisoDeSiniestroDTO grabaAvisoDeSiniestro (UsuarioAbonadoDTO usuarioAbonado, TipoSiniestroDTO tipoSiniestro, TipoSuspencionDTO tipoSuspencion, CausaSiniestroDTO causaSiniestro, UsuarioSistemaDTO usuarioSistema, String actabo, String num_os, String comentario) throws ProductException {
	public SolicitudAvisoDeSiniestroDTO grabaAvisoDeSiniestro (UsuarioAbonadoDTO usuarioAbonado, TipoSiniestroDTO tipoSiniestro, TipoSuspencionDTO tipoSuspencion, CausaSiniestroDTO causaSiniestro, UsuarioSistemaDTO usuarioSistema, String actabo, String num_os, String comentario, String numeroDesvio) throws ProductException {	
		SolicitudAvisoDeSiniestroDTO respuesta ;
		try {
			logger.debug("grabaAvisoDeSiniestro():start");
			respuesta = SiniestroDAO.grabaAvisoDeSiniestro(usuarioAbonado, tipoSiniestro, tipoSuspencion, causaSiniestro, usuarioSistema, actabo, num_os, comentario, numeroDesvio);
			logger.debug("grabaAvisoDeSiniestro():end");
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
	//Fin Inc. 174755/CSR-11002/06-09-2011/FDL

	
	public SiniestrosDTO[] recDatosSiniestroAboando (UsuarioAbonadoDTO usuarioAbonado) throws ProductException{
		SiniestrosDTO[] respuesta ;
		try {
			logger.debug("recDatosSiniestroAboando():start");
			respuesta = SiniestroDAO.recDatosSiniestroAboando(usuarioAbonado);
			logger.debug("recDatosSiniestroAboando():end");
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

	public void anulaSinistroAbonado(SiniestrosDTO Siniestros, UsuarioAbonadoDTO usuarioAbonado, SesionDTO sesion) throws ProductException {
		try {
			logger.debug("anulaSinistroAbonado():start");
			SiniestroDAO.anulaSinistroAbonado(Siniestros, usuarioAbonado, sesion);
			logger.debug("recDatosSiniestroAboando():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
	}

	public CambioPlanPendienteDTO validarCambioPlanPendiente(CambioPlanPendienteDTO cambioPlan) throws ProductException {
		CambioPlanPendienteDTO resultado = null;
		try {
			logger.debug("validarCambioPlanPendiente():start");
			resultado = SiniestroDAO.validarCambioPlanPendiente(cambioPlan);
			logger.debug("validarCambioPlanPendiente():end");
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

	//Incluido santiago ventura 23-03-2010
	public void anulaNumeroConstanciaPolicial (SiniestrosDTO siniestros) throws ProductException{
		try {
			logger.debug("anulaNumeroConstanciaPolicial():start");
			SiniestroDAO.anulaNumeroConstanciaPolicial(siniestros);
			logger.debug("anulaNumeroConstanciaPolicial():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
	}

}
