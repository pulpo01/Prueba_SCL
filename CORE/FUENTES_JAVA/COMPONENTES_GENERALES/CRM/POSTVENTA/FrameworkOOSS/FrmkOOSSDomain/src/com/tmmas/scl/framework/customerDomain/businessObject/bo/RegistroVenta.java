package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import org.apache.log4j.Category;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.RegistroVentaBOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.RegistroVentaDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.RegistroVentaDAOIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CelularDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosRegistroCargosDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroVentaDTO;



public class RegistroVenta implements RegistroVentaBOIT {
	
	private RegistroVentaDAOIT registroVentaDAO  = new RegistroVentaDAO();
	private static Category cat = Category.getInstance(RegistroVenta.class);
	
	/**
	 * Obtiene secuencia de la venta
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	
	public RegistroVentaDTO getSecuenciaVenta(RegistroVentaDTO parametroEntrada)throws CustomerBillException{
		RegistroVentaDTO resultado = new RegistroVentaDTO();
		cat.debug("Inicio:getSecuenciaVenta()");
		resultado =registroVentaDAO.getSecuenciaVenta(parametroEntrada); 
		cat.debug("Fin:getSecuenciaVenta()");
		return resultado;
	}
	
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
	 * Obtiene Prefijo de numero telefonico
	 * @param entrada
	 * @return resultado
	 * @throws CustomerBillException
	 */

	public RegistroVentaDTO getPrefijoMin(RegistroVentaDTO entrada) throws CustomerBillException{
		RegistroVentaDTO resultado = new RegistroVentaDTO();
		cat.debug("Inicio:getPrefijoMin()");
		resultado =registroVentaDAO.getPrefijoMin(entrada); 
		cat.debug("Fin:getPrefijoMin()");
		return resultado;
	}
	
	/**
	 * Obtiene numero celular automatico
	 * @param celular
	 * @return resultado
	 * @throws CustomerBillException
	 */
	public CelularDTO getNumeroCelularAut(CelularDTO celular)throws CustomerBillException{
		CelularDTO resultado = new CelularDTO();
		cat.debug("Inicio:getNumeroCelularAut()");
		resultado =registroVentaDAO.getNumeroCelularAut(celular); 
		cat.debug("Fin:getNumeroCelularAut()");
		return resultado;
	}//fin getNumeroCelularAut
	
	/**
	 * Genera reserva numero celular
	 * @param celular
	 * @return resultado
	 * @throws CustomerBillException
	 */

	public CelularDTO setReservaNumeroCelular(CelularDTO celular)throws CustomerBillException{
		CelularDTO resultado = new CelularDTO();
		cat.debug("Inicio:setReservaNumeroCelular()");
		resultado =registroVentaDAO.setReservaNumeroCelular(celular); 
		cat.debug("Fin:setReservaNumeroCelular()");
		return resultado;
	}//fin setReservaNumeroCelular
	
	
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

	
	/**
	 * Obtiene secuencia del paquete para agregar datos a tabla cargos
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerBillException
	 */
	
	public RegistroVentaDTO existePlanFreedomEnVenta(ParametrosRegistroCargosDTO parametrosCargos,ParametrosGeneralesDTO parametroProporVta,ParametrosGeneralesDTO parametroProporc1,ParametrosGeneralesDTO parametroProporc2)
	throws CustomerBillException{
		RegistroVentaDTO resultado = null;
		cat.debug("Inicio:existePlanFreedomEnVenta()");
		resultado =registroVentaDAO.existePlanFreedomEnVenta(parametrosCargos,parametroProporVta,parametroProporc1,parametroProporc2); 
		cat.debug("Fin:existePlanFreedomEnVenta()");
		return resultado;
	}

	
		
		
		/**
		 * @author rlozano
		 * @description Metodo que encapsula llamado getNumUnidades 
		 * @param String
		 * @return String retVal 
		 * @throws CustomerBillException
		 */
		
		public String getNumUnidades(String numVentas)throws CustomerBillException{
			cat.debug("Inicio:getNumUnidades()");
			String retVal=null;
			retVal=registroVentaDAO.getNumUnidades(numVentas);
			cat.debug("Fin:getNumUnidades()");
			return retVal;
		}
		
		/**
		 * @author rlozano
		 * @param CodCliente
		 * @return Long
		 * @throws CustomerBillException
		 */
		public Long getCodPlazaCliente(Long CodCliente)throws CustomerBillException{
			cat.debug("Inicio:getCodPlazaCliente()");
			Long retVal=null;
			retVal=registroVentaDAO.getCodPlazaCliente(CodCliente);
			cat.debug("Fin:getCodPlazaCliente()");
			return retVal;
		}
	
		/**
		 * @author rlozano
		 * @param CodOficina
		 * @return Long
		 * @throws CustomerBillException
		 */
		public Long getCodPlazaOficina(Long CodOficina)throws CustomerBillException{
			cat.debug("Inicio:getCodPlazaOficina()");
			Long retVal=null;
			retVal=registroVentaDAO.getCodPlazaOficina(CodOficina);
			cat.debug("Fin:getCodPlazaOficina()");
			return retVal;
		}
		
		
		
		
}
