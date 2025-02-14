/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 16/03/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.gestiondeabonados.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dao.RegistroVentaDAO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.CelularDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ListadoVentasDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.MatrizEstadosDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosRegistroCargosDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GaDocVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GaVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.ParametrosGeneralesDTO;


public class RegistroVentaBO {

	private RegistroVentaDAO registroVentaDAO  = new RegistroVentaDAO();
	private static Category cat = Category.getInstance(RegistroVentaBO.class);

	/**
	 * Obtiene secuencia de la venta
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */

	public RegistroVentaDTO getSecuenciaVenta(RegistroVentaDTO parametroEntrada)throws GeneralException{
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
	 * @throws GeneralException
	 */

	public RegistroVentaDTO getSecuenciaTransacabo(RegistroVentaDTO parametroEntrada)throws GeneralException{
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
	 * @throws GeneralException
	 */

	public RegistroVentaDTO getPrefijoMin(RegistroVentaDTO entrada) throws GeneralException{
		RegistroVentaDTO resultado = null;
		cat.debug("Inicio:getPrefijoMin()");
		resultado =registroVentaDAO.getPrefijoMin(entrada); 
		cat.debug("Fin:getPrefijoMin()");
		return resultado;
	}

	/**
	 * Obtiene numero celular automatico
	 * @param celular
	 * @return resultado
	 * @throws GeneralException
	 */
	public CelularDTO getNumeroCelularAut(CelularDTO celular)throws GeneralException{
		CelularDTO resultado = null;
		cat.debug("Inicio:getNumeroCelularAut()");
		resultado =registroVentaDAO.getNumeroCelularAut(celular); 
		cat.debug("Fin:getNumeroCelularAut()");
		return resultado;
	}//fin getNumeroCelularAut

	/**
	 * Genera reserva numero celular
	 * @param celular
	 * @return resultado
	 * @throws GeneralException
	 */

	public CelularDTO setReservaNumeroCelular(CelularDTO celular)throws GeneralException{
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
	 * @throws GeneralException
	 */

	public RegistroVentaDTO getSecuenciaPaquete(RegistroVentaDTO parametroEntrada)
	throws GeneralException{
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
	 * @throws GeneralException
	 */

	public RegistroVentaDTO existePlanFreedomEnVenta(ParametrosRegistroCargosDTO parametrosCargos,ParametrosGeneralesDTO parametroProporVta,ParametrosGeneralesDTO parametroProporc1,ParametrosGeneralesDTO parametroProporc2)
	throws GeneralException{
		RegistroVentaDTO resultado = null;
		cat.debug("Inicio:existePlanFreedomEnVenta()");
		resultado =registroVentaDAO.existePlanFreedomEnVenta(parametrosCargos,parametroProporVta,parametroProporc1,parametroProporc2); 
		cat.debug("Fin:existePlanFreedomEnVenta()");
		return resultado;
	}

	/**
	 * @author rlozano
	 * @description Metodo que encapsula llamado a getCodprocesoVenta
	 * @param matrizEstadosDTO
	 * @return String 
	 * @throws GeneralException
	 */	

	public String getCodProcesoVenta(MatrizEstadosDTO matrizEstadosDTO)throws GeneralException{
		cat.debug("Inicio:getCodProcesoVenta()");
		String retValue=null;
		retValue=registroVentaDAO.getCodProcesoVenta(matrizEstadosDTO);
		cat.debug("Fin:getCodProcesoVenta()");
		return retValue;
	}

	/**
	 * @author rlozano
	 * @param matrizEstadosDTO
	 * @return String 
	 * @throws GeneralException
	 * @description Método que encapsula el llamado a codigo de estado Final de la Venta
	 */

	public String getCodEstadoFinalVenta(MatrizEstadosDTO matrizEstadosDTO)throws GeneralException{
		cat.debug("Inicio:getCodEstadoFinalVenta()");
		String retValue=null;
		retValue=registroVentaDAO.getCodEstadoFinalVenta(matrizEstadosDTO);
		cat.debug("Fin:getCodEstadoFinalVenta()");
		return retValue;
	}

	/**
	 * @author rlozano
	 * @description Metodo que encapsula llamado a la Insercion de Ventas 
	 * @param gaVentasDTO
	 * @return
	 * @throws GeneralException
	 */

	public void insertVenta(GaVentasDTO gaVentasDTO)throws GeneralException{
		cat.debug("Inicio:insertVenta()");
		registroVentaDAO.insertVenta(gaVentasDTO);
		cat.debug("Fin:insertVenta()");
	}
	/**
	 * @author rlozano
	 * @description Metodo que encapsula llamado getNumUnidades 
	 * @param String
	 * @return String retVal 
	 * @throws GeneralException
	 */

	public String getNumUnidades(String numVentas)throws GeneralException{
		cat.debug("Inicio:getNumUnidades()");
		String retVal=null;
		retVal=registroVentaDAO.getNumUnidades(numVentas);
		cat.debug("Fin:getNumUnidades()");
		return retVal;
	}

	/**
	 * @author rlozano
	 * @param CodCliente
	 * @return String
	 * @throws GeneralException
	 */
	public String getCodPlazaCliente(Long CodCliente)throws GeneralException{
		cat.debug("Inicio:getCodPlazaCliente()");
		String retVal=null;
		retVal=registroVentaDAO.getCodPlazaCliente(CodCliente);
		cat.debug("Fin:getCodPlazaCliente()");
		return retVal;
	}

	/**
	 * @author rlozano
	 * @param CodOficina
	 * @return String
	 * @throws GeneralException
	 */
	public String getCodPlazaOficina(String CodOficina)throws GeneralException{
		cat.debug("Inicio:getCodPlazaOficina()");
		String retVal=null;
		retVal=registroVentaDAO.getCodPlazaOficina(CodOficina);
		cat.debug("Fin:getCodPlazaOficina()");
		return retVal;
	}

	/**
	 * @author rlozano
	 * @param gaVentasDTO
	 * @throws GeneralException
	 * @descripcion flujo alternativo en el cierre de ventas
	 */
	public void updateVentasEscenarioA(GaVentasDTO gaVentasDTO)throws GeneralException{
		cat.debug("Inicio:updateVentasEscenarioA()");
		registroVentaDAO.updateVentasEscenarioA(gaVentasDTO);
		cat.debug("Fin:updateVentasEscenarioA()");
	}

	/**
	 * @author rlozano
	 * @param gaVentasDTO
	 * @throws GeneralException
	 * @descripcion flujo alternativo en el cierre de ventas
	 */
	public void updateVentasEscenarioB(GaVentasDTO gaVentasDTO)throws GeneralException{
		cat.debug("Inicio:updateVentasEscenarioB()");
		registroVentaDAO.updateVentasEscenarioB(gaVentasDTO);
		cat.debug("Fin:updateVentasEscenarioB()");
	}

	/**
	 * @author rlozano
	 * @param gaVentasDTO
	 * @throws GeneralException
	 * @descripcion flujo alternativo en el cierre de ventas
	 */
	public void updateVentasEscenarioC(GaVentasDTO gaVentasDTO)throws GeneralException{
		cat.debug("Inicio:updateVentasEscenarioC()");
		registroVentaDAO.updateVentasEscenarioC(gaVentasDTO);
		cat.debug("Fin:updateVentasEscenarioC()");
	}

	/**
	 * @author rlozano
	 * @param gaVentasDTO
	 * @throws GeneralException
	 * @descripcion flujo alternativo en el cierre de ventas
	 */
	public void updateVentasEscenarioD(GaVentasDTO gaVentasDTO)throws GeneralException{
		cat.debug("Inicio:updateVentasEscenarioD()");
		registroVentaDAO.updateVentasEscenarioD(gaVentasDTO);
		cat.debug("Fin:updateVentasEscenarioD()");
	}


	/**
	 * Obtiene numMDN
	 * @param entrada
	 * @return entrada
	 * @throws GeneralException
	 */
	public RegistroVentaDTO getMinMDN(RegistroVentaDTO entrada) 
	throws GeneralException{
		RegistroVentaDTO resultado = null;
		cat.debug("Inicio:getMinMDN()");
		resultado =registroVentaDAO.getMinMDN(entrada); 
		cat.debug("Fin:getMinMDN()");
		return resultado;
	}//fin getMinMDN

	/**
	 * Realiza reversa de la venta
	 * @param gaVentasDTO
	 * @return 
	 * @throws GeneralException
	 */
	public void reversaVenta(GaVentasDTO gaVentasDTO) 
	throws GeneralException{
		cat.debug("Inicio:reversaVenta()");
		registroVentaDAO.reversaVenta(gaVentasDTO);
		cat.debug("Fin:reversaVenta()");
	}//fin reversaVenta

	//Incidencia 45086 15-11-2007
	/**
	 * Genera reserva numero celular
	 * @param celular
	 * @return resultado
	 * @throws GeneralException
	 */

	public void setNumeracionManual(CelularDTO celular)throws GeneralException{
		cat.debug("Inicio:setNumeracionManual()");
		registroVentaDAO.setNumeracionManual(celular); 
		cat.debug("Fin:setNumeracionManual()");
	}//fin setNumeracionManual

	/**
	 * Realiza desreserva de numero celular
	 * @param gaVentasDTO
	 * @return 
	 * @throws GeneralException
	 */
	public void desreservaCelular(GaVentasDTO gaVentasDTO) 
	throws GeneralException{
		cat.debug("Inicio:desreservaCelular()");
		registroVentaDAO.desreservaCelular(gaVentasDTO);
		cat.debug("Fin:desreservaCelular()");
	}//fin desreservaCelular

	/**
	 * Graba contrato en tabla ga_docventa
	 * @param gaVentasDTO
	 * @return gaDocVentasDTO
	 * @throws GeneralException
	 */

	public GaDocVentasDTO insertGaDocVentas(GaDocVentasDTO gaDocVentasDTO)
	throws GeneralException
	{
		cat.debug("Inicio:insertGaDocVentas()");
		gaDocVentasDTO=registroVentaDAO.insertGaDocVentas(gaDocVentasDTO);
		cat.debug("Fin:insertGaDocVentas()");
		return gaDocVentasDTO;
	}// insertGaDocVentas		
	//Fin 45086 15-11-2007

	/**
	 * Lista evntas por vendedor
	 * @param parametroEntrada
	 * @return resultado
	 * @throws GeneralException
	 */		
	public ListadoVentasDTO[] getVentasXVendedor(ListadoVentasDTO entrada)
	throws GeneralException
	{
		ListadoVentasDTO[] resultado = null;
		cat.debug("Inicio:getVentasXVendedor()");
		resultado =registroVentaDAO.getVentasXVendedor(entrada); 
		cat.debug("Fin:getVentasXVendedor()");
		return resultado;
	}


	public GaVentasDTO getVenta(GaVentasDTO gaVentasDTO) throws GeneralException
	{
		cat.debug("Inicio:getVentasXVendedor()");
		gaVentasDTO = registroVentaDAO.getVenta(gaVentasDTO); 
		cat.debug("Fin:getVentasXVendedor()");
		return gaVentasDTO;
	}

	public CelularDTO getInfoCelular(CelularDTO celular)throws GeneralException{
		CelularDTO resultado = null;
		cat.debug("Inicio:getInfoCelular()");
		resultado =registroVentaDAO.getInfoCelular(celular); 
		cat.debug("Fin:getInfoCelular()");
		return resultado;
	}//fin getNumeroCelularAut	

	public void setAceptacionVenta(GaVentasDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:setAceptacionVenta()");
		registroVentaDAO.setAceptacionVenta(entrada); 
		cat.debug("Fin:setAceptacionVenta()");
	}
	
	
	public void insertQuioscoVenta(GaVentasDTO gaVentas) throws GeneralException{		
		    cat.debug("++++++++++++++++++++++++++++++++++ Start : insertQuioscoVenta ++++++++++++++++++++++++++++++++++++++++++++");
			registroVentaDAO.insertQuioscoVenta(gaVentas); 
			cat.debug("++++++++++++++++++++++++++++++++++ End : insertQuioscoVenta ++++++++++++++++++++++++++++++++++++++++++++");
   }		

}//fin class RegistroVenta
