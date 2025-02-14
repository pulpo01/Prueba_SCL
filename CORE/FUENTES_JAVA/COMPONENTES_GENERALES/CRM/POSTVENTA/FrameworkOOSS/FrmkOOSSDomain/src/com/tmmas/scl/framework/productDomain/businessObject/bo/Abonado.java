package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.AbonadoDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.AbonadoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ConsultaHibridoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.GaAbocelDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.IntarcelDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ObtencionRolUsuarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ValidaPermanenciaDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public class Abonado implements AbonadoIT {

	private AbonadoDAOIT abonadoDAO = new AbonadoDAO();
	
	private final Logger logger = Logger.getLogger(Abonado.class);
	private Global global = Global.getInstance();

	public AbonadoListDTO obtenerListaAbonados(ClienteDTO cliente)
			throws ProductException {

		AbonadoListDTO planes = null;
		try {
			logger.debug("obtenerListaAbonados():start");
			planes = abonadoDAO.obtenerListaAbonados(cliente);
			logger.debug("obtenerListaAbonados():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return planes;	
		
	}

	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws ProductException{
		
		AbonadoDTO respuesta = null;
		try {
			logger.debug("obtenerDatosAbonado():start");
			respuesta = abonadoDAO.obtenerDatosAbonado(abonado);
			logger.debug("obtenerDatosAbonado():end");
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
	
	public RetornoDTO actualizaIntarcelAcciones(IntarcelDTO intarcel) throws ProductException{
		
		RetornoDTO retorno = null;
		try {
			logger.debug("actualizaIntarcelAcciones():start");
			retorno = abonadoDAO.actualizaIntarcelAcciones(intarcel);
			logger.debug("actualizaIntarcelAcciones():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;			
	}
	
	public RetornoDTO registraElimActIntarcel(IntarcelDTO intarcel) throws ProductException{
		RetornoDTO retorno = null;
		try {
			logger.debug("registraElimActIntarcel():start");
			retorno = abonadoDAO.registraElimActIntarcel(intarcel);
			logger.debug("registraElimActIntarcel():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;			
	}
	
	public RetornoDTO actualizaSituaAbo(AbonadoDTO abonado) throws ProductException{
		RetornoDTO retorno = null;
		try {
			logger.debug("actualizaSituaAbo():start");
			retorno = abonadoDAO.actualizaSituaAbo(abonado);
			logger.debug("actualizaSituaAbo():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;			
		
	}
	
	public RetornoDTO eliminaCuentaPersonal(CuentaPersonalDTO cuenta) throws ProductException{
		RetornoDTO retorno = null;
		try {
			logger.debug("eliminaCuentaPersonal():start");
			retorno = abonadoDAO.eliminaCuentaPersonal(cuenta);
			logger.debug("eliminaCuentaPersonal():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;	
	}
	
	public RetornoDTO reservaAmist(CuentaPersonalDTO cuenta) throws ProductException{
		RetornoDTO retorno = null;
		try {
			logger.debug("reservaAmist():start");
			retorno = abonadoDAO.reservaAmist(cuenta);
			logger.debug("reservaAmist():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;			
	}
	
	public RetornoDTO validaPermanencia(ValidaPermanenciaDTO param) throws ProductException{
		RetornoDTO retorno = null;
		try {
			logger.debug("validaPermanencia():start");
			retorno = abonadoDAO.validaPermanencia(param);
			logger.debug("validaPermanencia():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;		
	}

	public AbonadoListDTO obtenerAbonadosPorVenta(VentaDTO venta) throws ProductException 
	{
		AbonadoListDTO abonados = null;
		try {
			logger.debug("obtenerAbonadosPorVenta():start");
			abonados = abonadoDAO.obtenerAbonadosPorVenta(venta);
			
			// FOR PARA MANTENER EL CODIGO DEL CLIENTE
			for(int i=0;i<abonados.getAbonados().length;i++)
			{
				abonados.getAbonados()[i].setCodCliente(venta.getCliente().getCodCliente());
			}
			
			logger.debug("obtenerAbonadosPorVenta():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return abonados;	
	}
	
	public RetornoDTO consultaHibrido(ConsultaHibridoDTO consulta) throws ProductException{
		RetornoDTO retorno = null;
		try {
			logger.debug("consultaHibrido():start");
			retorno = abonadoDAO.consultaHibrido(consulta);
			logger.debug("consultaHibrido():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;			
	}

	public RetornoDTO actualizarAboCtaSeg(GaAbocelDTO abonado) throws ProductException{
		RetornoDTO retorno = null;
		try {
			logger.debug("actualizarAboCtaSeg():start");
			retorno = abonadoDAO.actualizarAboCtaSeg(abonado);
			logger.debug("actualizarAboCtaSeg():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;			
	}
	
	public RetornoDTO migrarAbonado(GaAbocelDTO abonado) throws ProductException{
		RetornoDTO retorno = null;
		try {
			logger.debug("migrarAbonado():start");
			retorno = abonadoDAO.migrarAbonado(abonado);
			logger.debug("migrarAbonado():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;		
	}
	
	public GaAbocelDTO obtenerFecCumPlan(GaAbocelDTO abonado) throws ProductException{
		GaAbocelDTO retorno = null;
		try {
			logger.debug("obtenerFecCumPlan():start");
			retorno = abonadoDAO.obtenerFecCumPlan(abonado);
			logger.debug("obtenerFecCumPlan():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;		
	}
	
	public RetornoDTO actualizarSituPerfil(AbonadoDTO abonado) throws ProductException{
		RetornoDTO retorno = null;
		try {
			logger.debug("actualizarSituPerfil():start");
			retorno = abonadoDAO.actualizarSituPerfil(abonado);
			logger.debug("actualizarSituPerfil():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;		
	}

	public AbonadoDTO obtenerNumeroMovimientoAlta(AbonadoDTO abonado) throws ProductException 
	{
		AbonadoDTO retorno = null;
		try {
			logger.debug("obtenerNumeroMovimientoAlta():start");
			retorno = abonadoDAO.obtenerNumeroMovimientoAlta(abonado);
			logger.debug("obtenerNumeroMovimientoAlta():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;		
	}
	
	public IntarcelDTO obtenerFecDesdeCtaSeg(IntarcelDTO intarcel) throws ProductException{
		IntarcelDTO retorno = null;
		try {
			logger.debug("obtenerFecDesdeCtaSeg():start");
			retorno = abonadoDAO.obtenerFecDesdeCtaSeg(intarcel);
			logger.debug("obtenerFecDesdeCtaSeg():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;			
	}

	public ObtencionRolUsuarioDTO obtenerRolUsuario(ObtencionRolUsuarioDTO obtRol) throws ProductException {
		ObtencionRolUsuarioDTO retorno = null;
		try {
			logger.debug("obtenerFecDesdeCtaSeg():start");
			retorno = abonadoDAO.obtenerRolUsuario(obtRol);
			logger.debug("obtenerFecDesdeCtaSeg():end");
		} catch (ProductException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}		
		return retorno;	
	}
}
