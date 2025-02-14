package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.RegistroVentaBOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.RegistroVentaDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.RegistroVentaDAOIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.GaVentasDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroVentaDTO;



public class RegistroVenta implements RegistroVentaBOIT {
	
	private RegistroVentaDAOIT registroVentaDAO  = new RegistroVentaDAO();
	private static Logger cat = Logger.getLogger(RegistroVenta.class);
	
	/**
	 * Obtiene secuencia de la Transacabo
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerBillException
	 */
	
	public RegistroVentaDTO getSecuenciaTransacabo(RegistroVentaDTO parametroEntrada)throws CustomerBillException{
		RegistroVentaDTO resultado = new RegistroVentaDTO();
		cat.debug("Inicio:getSecuenciaTransacabo()");
		resultado =registroVentaDAO.getSecuenciaTransacabo(parametroEntrada); 
		cat.debug("Fin:getSecuenciaTransacabo()");
		return resultado;
	}//fin getSecuenciaTransacabo
	
	/**
	 * Obtiene secuencia del paquete para agregar datos a tabla cargos
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerBillException
	 */
	
	public RegistroVentaDTO getSecuenciaPaquete(RegistroVentaDTO parametroEntrada)
	throws CustomerBillException{
		RegistroVentaDTO resultado = new RegistroVentaDTO();
		cat.debug("Inicio:getSecuenciaPaquete()");
		resultado =registroVentaDAO.getSecuenciaPaquete(parametroEntrada); 
		cat.debug("Fin:getSecuenciaPaquete()");
		return resultado;
	}
	
	
	
	
	public String getCodPlazaCliente(Long CodCliente)throws CustomerBillException{
		String  retValue;
		cat.debug("Inicio:getCodPlazaCliente()");
		retValue =registroVentaDAO.getCodPlazaCliente(CodCliente); 
		cat.debug("Fin:getCodPlazaCliente()");
		return retValue;
	}
	
	public String getCodPlazaOficina(String CodOficina)throws CustomerBillException{
		
		String retValue;
		cat.debug("Inicio:getCodPlazaOficina()");
		retValue =registroVentaDAO.getCodPlazaOficina(CodOficina); 
		cat.debug("Fin:getCodPlazaOficina()");
		return retValue;
	}
	
	
	
	
	public void updateVentasEscenarioB(GaVentasDTO gaVentasDTO)throws CustomerBillException{
		cat.debug("Inicio:updateVentasEscenarioB()");
		registroVentaDAO.updateVentasEscenarioB(gaVentasDTO); 
		cat.debug("Fin:updateVentasEscenarioB()");
		
	}
	
	
	
	public void updateVentasEscenarioC(GaVentasDTO gaVentasDTO)throws CustomerBillException{
		cat.debug("Inicio:updateVentasEscenarioC()");
		registroVentaDAO.updateVentasEscenarioC(gaVentasDTO); 
		cat.debug("Fin:updateVentasEscenarioC()");
		
	}
	
	
	public void updateVentasEscenarioD(GaVentasDTO gaVentasDTO)throws CustomerBillException{
		
		cat.debug("Inicio:updateVentasEscenarioD()");
		registroVentaDAO.updateVentasEscenarioD(gaVentasDTO); 
		cat.debug("Fin:updateVentasEscenarioD()");
		
	}
	/**
	 * Obtiene secuencia del paquete para agregar datos a tabla cargos
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerBillException
	 */
	
	public void updateVentasEscenarioA(GaVentasDTO gaVentasDTO)throws CustomerBillException{
		
		cat.debug("Inicio:updateVentasEscenarioA()");
		registroVentaDAO.updateVentasEscenarioA(gaVentasDTO); 
		cat.debug("Fin:updateVentasEscenarioA()");
		
	}
		
	public void updateVenta(GaVentasDTO gaVentasDTO)throws CustomerBillException{
		cat.debug("Inicio:updateVenta()");
		registroVentaDAO.updateVenta(gaVentasDTO); 
		cat.debug("Fin:updateVenta()");
		
	}

	public void desreservaCelular(GaVentasDTO entrada) throws CustomerBillException {
		cat.debug("Inicio:desreservaCelular()");
		registroVentaDAO.desreservaCelular(entrada); 
		cat.debug("Fin:desreservaCelular()");
		
	}
		
		
		
}
