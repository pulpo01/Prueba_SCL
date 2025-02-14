package com.tmmas.scl.framework.ProductDomain.bo;

import java.sql.Date;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SuspensionVoluntariaBOIT;
import com.tmmas.scl.framework.ProductDomain.dao.SuspensionVoluntariaDAO;
import com.tmmas.scl.framework.ProductDomain.dao.interfaces.SuspensionVoluntariaDAOIT;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CausasSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.FechasSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PeriodoSuspencionAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SuspensionAbonadoDTO;

public class SuspensionVoluntariaBO implements SuspensionVoluntariaBOIT{


	private SuspensionVoluntariaDAOIT  SuspensionVoluntariaDAO = new SuspensionVoluntariaDAO();		
	private final Logger logger = Logger.getLogger(SuspensionVoluntariaBO.class);

//	 ----------------------------------------------------------------------------------------------------------------------------------------

	public SuspensionAbonadoDTO[] obtenerSuspensionesAbonado(UsuarioAbonadoDTO usuarioAbonado) throws ProductException	{
		logger.debug("obtenerSuspensionesAbonado():start");
		SuspensionAbonadoDTO[] respuesta = null;		
		try{
			respuesta = SuspensionVoluntariaDAO.obtenerSuspensionesAbonado(usuarioAbonado);
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		logger.debug("obtenerSuspensionesAbonado():end");
		
		return respuesta;

	} // obtenerSuspensionesAbonado

	// ----------------------------------------------------------------------------------------------------------------------------------------
	
	public CausasSuspensionDTO[] obtenerCausasSuspension() throws ProductException	{

		logger.debug("obtenerCausasSuspension():start");		
		CausasSuspensionDTO[] respuesta = null;
		
		try{
			respuesta = SuspensionVoluntariaDAO.obtenerCausasSuspension();
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		logger.debug("obtenerCausasSuspension():end");
		
		return respuesta;

	} // obtenerCausasSuspension

	// ----------------------------------------------------------------------------------------------------------------------------------------
		
	public DatosGeneralesSuspensionDTO obtenerDatosGeneralesSuspension() throws ProductException	{

		logger.debug("obtenerDatosGeneralesSuspension():start");		
		DatosGeneralesSuspensionDTO respuesta = null;
				
				try{
					respuesta = SuspensionVoluntariaDAO.obtenerDatosGeneralesSuspension();
				} catch (ProductException e) {
					logger.debug("ProductException[", e);
					throw e;
				}
				logger.debug("obtenerDatosGeneralesSuspension():end");
				
				return respuesta;

	} // obtenerCausasSuspension

	// ----------------------------------------------------------------------------------------------------------------------------------------
			
	public SuspensionAbonadoDTO[] obtenerSuspensionesHistoricasAbonado(long numAbonado, java.sql.Date fecIni, java.sql.Date fecFin ) throws ProductException {
		
		logger.debug("obtenerSuspensionesHistoricasAbonado():start");
		
		SuspensionAbonadoDTO[] respuesta = null;			
		try{
			respuesta = SuspensionVoluntariaDAO.obtenerSuspensionesHistoricasAbonado(numAbonado, fecIni, fecFin);
			SuspensionVoluntariaDAO.obtenerPeriodosHistAbonado(numAbonado, respuesta);
			
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		logger.debug("obtenerSuspensionesHistoricasAbonado():end");		
		
		return respuesta;
	}

	public PeriodoSuspencionAbonadoDTO[] obtenerPeriodosSuspensioAbonado(UsuarioAbonadoDTO usuarioAbonado) throws ProductException {
		logger.debug("obtenerPeriodosSuspensioAbonado():start");
		
		PeriodoSuspencionAbonadoDTO[] respuesta = null;			
		try{
			respuesta = SuspensionVoluntariaDAO.obtenerPeriodosSuspensioAbonado(usuarioAbonado);
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		logger.debug("obtenerPeriodosSuspensioAbonado():end");		
		
		return respuesta;
	}

	public void modificarSuspension(SuspensionAbonadoDTO suspensionAbonado) throws ProductException {
		logger.debug("modificarSuspension():start");
		SuspensionAbonadoDTO SuspensionAbonadoIn = new SuspensionAbonadoDTO(); 
		
		try{			
			SuspensionAbonadoIn = SuspensionVoluntariaDAO.recSuspencionAbonado(suspensionAbonado);			
			if (!SuspensionAbonadoIn.getFechaRehabilitacion().equals(suspensionAbonado.getFechaRehabilitacion())){
				SuspensionAbonadoIn.setFechaRehabilitacion(suspensionAbonado.getFechaRehabilitacion());
			}
			
			if (!SuspensionAbonadoIn.getFechaSuspension().equals(suspensionAbonado.getFechaSuspension())){
				SuspensionAbonadoIn.setFechaSuspension(suspensionAbonado.getFechaSuspension());
			}			
			
			
			SuspensionVoluntariaDAO.modificarSuspension(SuspensionAbonadoIn);
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		logger.debug("modificarSuspension():end");					
	}

	public void programarSuspension(SuspensionAbonadoDTO suspensionAbonado, ClienteOSSesionDTO sessionData) throws ProductException {
		logger.debug("programarSuspension():start");
		
		try{
			SuspensionVoluntariaDAO.programarSuspension(suspensionAbonado, sessionData);
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		
		logger.debug("programarSuspension():end");
		
	}
	
	public void anularSuspension(SuspensionAbonadoDTO suspensionAbonado) throws ProductException {
		logger.debug("programarSuspension():start");
		SuspensionAbonadoDTO SuspensionAbonadoIn = new SuspensionAbonadoDTO(); 
		
		try{			
			SuspensionAbonadoIn = SuspensionVoluntariaDAO.recSuspencionAbonado(suspensionAbonado);
			SuspensionAbonadoIn.setEstado("ANU");
			SuspensionVoluntariaDAO.anularSuspension(SuspensionAbonadoIn);
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}

		logger.debug("anularSuspension():end");
		
	}
	
	public FechasSuspensionDTO[] recuperarFechasSuspension(ClienteOSSesionDTO sessionData) throws ProductException {
		logger.debug("recuperarFechasSuspension():start");
		
		FechasSuspensionDTO[] respuesta = null;			
		try{
			respuesta = SuspensionVoluntariaDAO.recuperarFechasSuspension(sessionData);
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		logger.debug("recuperarFechasSuspension():end");		
		
		return respuesta;
	}
	
	public void agregaPeriodoSuspension(PeriodoSuspencionAbonadoDTO periodoSuspencionAbonado) throws ProductException{
		logger.debug("agregaPeriodoSuspension():start");
					
		try{
			SuspensionVoluntariaDAO.agregaPeriodoSuspension(periodoSuspencionAbonado);
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		logger.debug("agregaPeriodoSuspension():end");		
	}
	
}  // SuspensionVoluntariaBO
