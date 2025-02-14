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

package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstVtaRegistroResultadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CargoSolicitudDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ListadoVentasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosRegistroCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.RegistroVentaDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AlPetiGuiasAboDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CelularDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosContrato;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FichaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FichaContratoPrestacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FichaSalidaBodegaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.GaDocVentasDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.GaVentasDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.MatrizEstadosDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.PagareDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.TipoSolicitudDTO;



public class RegistroVenta {
	
	private RegistroVentaDAO registroVentaDAO  = new RegistroVentaDAO();
	private static Category cat = Category.getInstance(RegistroVenta.class);
	
	/**
	 * Obtiene secuencia de la venta
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	
	public RegistroVentaDTO getSecuenciaVenta(RegistroVentaDTO parametroEntrada)
		throws CustomerDomainException
	{
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
	 * @throws CustomerDomainException
	 */
	
	public RegistroVentaDTO getSecuenciaTransacabo(RegistroVentaDTO parametroEntrada)
		throws CustomerDomainException
	{
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
	 * @throws CustomerDomainException
	 */

	public RegistroVentaDTO getPrefijoMin(RegistroVentaDTO entrada) 
		throws CustomerDomainException
	{
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
	 * @throws CustomerDomainException
	 */
	public CelularDTO getNumeroCelularAut(CelularDTO celular)
		throws CustomerDomainException
	{
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
	 * @throws CustomerDomainException
	 */

	public CelularDTO setReservaNumeroCelular(CelularDTO celular)
		throws CustomerDomainException
	{
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
	 * @throws CustomerDomainException
	 */
	
	public RegistroVentaDTO getSecuenciaPaquete(RegistroVentaDTO parametroEntrada)
		throws CustomerDomainException
	{
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
	 * @throws CustomerDomainException
	 */
	
	public RegistroVentaDTO existePlanFreedomEnVenta(ParametrosRegistroCargosDTO parametrosCargos,
			ParametrosGeneralesDTO parametroProporVta,ParametrosGeneralesDTO parametroProporc1,ParametrosGeneralesDTO parametroProporc2)
		throws CustomerDomainException
	{
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
	 * @throws CustomerDomainException
	 */	
		
		public String getCodProcesoVenta(MatrizEstadosDTO matrizEstadosDTO)
			throws CustomerDomainException
		{
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
		 * @throws CustomerDomainException
		 * @description Método que encapsula el llamado a codigo de estado Final de la Venta
		 */
		
		public String getCodEstadoFinalVenta(MatrizEstadosDTO matrizEstadosDTO)
			throws CustomerDomainException
		{
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
		 * @throws CustomerDomainException
		 */
		
		public void insertVenta(GaVentasDTO gaVentasDTO)
			throws CustomerDomainException
		{
			cat.debug("Inicio:insertVenta()");
			registroVentaDAO.insertVenta(gaVentasDTO);
			cat.debug("Fin:insertVenta()");
		}
		/**
		 * @author rlozano
		 * @description Metodo que encapsula llamado getNumUnidades 
		 * @param String
		 * @return String retVal 
		 * @throws CustomerDomainException
		 */
		
		public String getNumUnidades(String numVentas)
			throws CustomerDomainException
		{
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
		 * @throws CustomerDomainException
		 */
		public Long getCodPlazaCliente(Long CodCliente)
			throws CustomerDomainException
		{
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
		 * @throws CustomerDomainException
		 */
		public String getCodPlazaOficina(String CodOficina)
			throws CustomerDomainException
		{
			cat.debug("Inicio:getCodPlazaOficina()");
			String retVal=null;
			retVal=registroVentaDAO.getCodPlazaOficina(CodOficina);
			cat.debug("Fin:getCodPlazaOficina()");
			return retVal;
		}
		
		/**
		 * @author rlozano
		 * @param gaVentasDTO
		 * @throws CustomerDomainException
		 * @descripcion flujo alternativo en el cierre de ventas
		 */
		public void updateVentasEscenarioA(GaVentasDTO gaVentasDTO)
			throws CustomerDomainException
		{
			cat.debug("Inicio:updateVentasEscenarioA()");
			 registroVentaDAO.updateVentasEscenarioA(gaVentasDTO);
			cat.debug("Fin:updateVentasEscenarioA()");
		}
		
		/**
		 * @author rlozano
		 * @param gaVentasDTO
		 * @throws CustomerDomainException
		 * @descripcion flujo alternativo en el cierre de ventas
		 */
		public void updateVentasEscenarioB(GaVentasDTO gaVentasDTO)
			throws CustomerDomainException
		{
			cat.debug("Inicio:updateVentasEscenarioB()");
			 registroVentaDAO.updateVentasEscenarioB(gaVentasDTO);
			cat.debug("Fin:updateVentasEscenarioB()");
		}
		
		/**
		 * @author rlozano
		 * @param gaVentasDTO
		 * @throws CustomerDomainException
		 * @descripcion flujo alternativo en el cierre de ventas
		 */
		public void updateVentasEscenarioC(GaVentasDTO gaVentasDTO)
			throws CustomerDomainException
		{
			cat.debug("Inicio:updateVentasEscenarioC()");
			 registroVentaDAO.updateVentasEscenarioC(gaVentasDTO);
			cat.debug("Fin:updateVentasEscenarioC()");
		}
		
		/**
		 * @author rlozano
		 * @param gaVentasDTO
		 * @throws CustomerDomainException
		 * @descripcion flujo alternativo en el cierre de ventas
		 */
		public void updateVentasEscenarioD(GaVentasDTO gaVentasDTO)
			throws CustomerDomainException
		{
			cat.debug("Inicio:updateVentasEscenarioD()");
			 registroVentaDAO.updateVentasEscenarioD(gaVentasDTO);
			cat.debug("Fin:updateVentasEscenarioD()");
		}
		
		/**
		 * @author Héctor Hermosilla
		 * @param 
		 * @throws CustomerDomainException
		 * @descripcion actualiza la venta en el proceso de cierre
		 */
		public void updateVentas(GaVentasDTO gaVentasDTO)
			throws CustomerDomainException
		{
			cat.debug("Inicio:updateVentasEscenarioD()");
			 registroVentaDAO.updateVenta(gaVentasDTO);
			cat.debug("Fin:updateVentasEscenarioD()");
		}

		/**
		 * Obtiene numMDN
		 * @param entrada
		 * @return entrada
		 * @throws CustomerDomainException
		 */
		public RegistroVentaDTO getMinMDN(RegistroVentaDTO entrada) 
			throws CustomerDomainException
		{
			RegistroVentaDTO resultado = null;
			cat.debug("Inicio:getMinMDN()");
			resultado =registroVentaDAO.getMinMDN(entrada); 
			cat.debug("Fin:getMinMDN()");
			return resultado;
		}//fin getMinMDN

		/** Servicios Activaciones WEB - Colombia
		 * Obtine datos del cliente
		 * @param RegistroVentaDTO (entrada)
		 * @return RegistroVentaDTO (resultado)
		 * @throws CustomerDomainException
	     * wjrc - Agosto 2007 */
		public LstVtaRegistroResultadoDTO getListVentas(RegistroVentaDTO entrada) 
			throws CustomerDomainException
		{
			cat.debug("Inicio:getListVentas()");
			LstVtaRegistroResultadoDTO resultado = registroVentaDAO.getListVentas(entrada);
			cat.debug("Fin:getListVentas()");
			return resultado;
		}//fin getListVentas
		
		/** Servicios Activaciones WEB - Colombia
		 * Obtine origen de la venta
		 * @param RegistroVentaDTO (entrada)
		 * @return RegistroVentaDTO (resultado)
		 * @throws CustomerDomainException
	     * wjrc - Agosto 2007 */		
		public RegistroVentaDTO getOrigenVenta(RegistroVentaDTO entrada) 
		throws CustomerDomainException{
			RegistroVentaDTO resultado = null;
			cat.debug("Inicio:getOrigenVenta()");
			resultado =registroVentaDAO.getOrigenVenta(entrada); 
			cat.debug("Fin:getOrigenVenta()");
			return resultado;			
		}//fin getOrigenVenta
		
		public GaDocVentasDTO insertGaDocVentas(GaDocVentasDTO gaDocVentasDTO)
			throws CustomerDomainException
		{
			cat.debug("Inicio:insertGaDocVentas()");
			gaDocVentasDTO=registroVentaDAO.insertGaDocVentas(gaDocVentasDTO);
			cat.debug("Fin:insertGaDocVentas()");
			return gaDocVentasDTO;
		}
		
		public AlPetiGuiasAboDTO insetAlPetiGuiasAbo(AlPetiGuiasAboDTO alPetiGuiasAboDTO)
			throws CustomerDomainException
		{
			cat.debug("Inicio:insertAlPetiGuiasAbo()");
			alPetiGuiasAboDTO=registroVentaDAO.insertAlPetiGuiasAbo(alPetiGuiasAboDTO);
			cat.debug("Fin:insertAlPetiGuiasAbo()");
			return alPetiGuiasAboDTO;
		}
		
		/**
		 * Obtiene secuencia generica
		 * @param parametroEntrada
		 * @return resultado
		 * @throws CustomerDomainException
		 */
		
		public Long getSecuenciaGenerica(String nombreSecuencia)
			throws CustomerDomainException
		{
			Long resultado =null;
			cat.debug("Inicio:getSecuenciaTransacabo()");
			resultado =registroVentaDAO.getSecuenciaGenerica(nombreSecuencia); 
			cat.debug("Fin:getSecuenciaTransacabo()");
			return resultado;
		}//fin getSecuenciaTransacabo
		
		/**
		 * Realiza reversa de la venta
		 * @param gaVentasDTO
		 * @return 
		 * @throws CustomerDomainException
		 */
		public void reversaVenta(GaVentasDTO gaVentasDTO) 
			throws CustomerDomainException{
			cat.debug("Inicio:reversaVenta()");
			registroVentaDAO.reversaVenta(gaVentasDTO);
			cat.debug("Fin:reversaVenta()");
		}//fin reversaVenta
		
		/**
		 * Lista evntas por vendedor
		 * @param parametroEntrada
		 * @return resultado
		 * @throws CustomerDomainException
		 */		
		public ListadoVentasDTO[] getVentasXVendedor(ListadoVentasDTO entrada)
			throws CustomerDomainException
		{
			ListadoVentasDTO[] resultado = null;
			cat.debug("Inicio:getVentasXVendedor()");
			resultado =registroVentaDAO.getVentasXVendedor(entrada); 
			cat.debug("Fin:getVentasXVendedor()");
			return resultado;
		}
		
		public CargoSolicitudDTO[] getCargosVta(CargoSolicitudDTO entrada)
			throws CustomerDomainException
		{
			CargoSolicitudDTO[] resultado = null;
			cat.debug("Inicio:getCargosVta()");
			resultado =registroVentaDAO.getCargosVta(entrada); 
			cat.debug("Fin:getCargosVta()");
			return resultado;
		}
		
		public void updateSituacionVenta(GaVentasDTO gaVentasDTO)
			throws CustomerDomainException
		{
			cat.debug("Inicio:updateSituacionVentas()");
			registroVentaDAO.updateSituacionVenta(gaVentasDTO);
			cat.debug("Fin:updateSituacionVentas()");
		}
		
		public void updateVentaDesbloqueo(GaVentasDTO entrada)
			throws CustomerDomainException
		{
			cat.debug("Inicio:updateVentaDesbloqueo()");
			registroVentaDAO.updateVentaDesbloqueo(entrada);
			cat.debug("Fin:updateVentaDesbloqueo()");
		}
		
		public void reversaCargosFormalizacion(Long entrada)
			throws CustomerDomainException
		{
			cat.debug("Inicio:reversaCargosFormalizacion()");
			registroVentaDAO.reversaCargosFormalizacion(entrada);
			cat.debug("Fin:reversaCargosFormalizacion()");
		}
		
		public Long verificaVentaCero_Regalo(Long numVenta)
			throws CustomerDomainException
		{
			cat.debug("Inicio:verificaVentaCero_Regalo()");
			Long resultado = registroVentaDAO.verificaVentaCero_Regalo(numVenta);
			cat.debug("Fin:verificaVentaCero_Regalo()");
			return resultado;
		}
		
		public String obtenerEstadoContratacionPA(Long numVenta) 
			throws CustomerDomainException
		{
			cat.debug("Inicio:obtenerEstadoContratacionPA()");
			String resultado = registroVentaDAO.obtenerEstadoContratacionPA(numVenta);
			cat.debug("Fin:obtenerEstadoContratacionPA()");
			return resultado;
		}
		
		public PagareDTO obtenerDatosPagare(Long numVenta)
			throws CustomerDomainException
		{
			cat.debug("Inicio:obtenerDatosPagare()");
			PagareDTO resultado = registroVentaDAO.obtenerDatosPagare(numVenta);
			cat.debug("Fin:obtenerDatosPagare()");
			return resultado;
		}
		
		public FichaClienteDTO obtenerDatosFichaCliente(Long numAbonado)
			throws CustomerDomainException
		{
			cat.debug("Inicio:obtenerDatosFichaCliente()");
			FichaClienteDTO resultado = registroVentaDAO.obtenerDatosFichaCliente(numAbonado);
			cat.debug("Fin:obtenerDatosFichaCliente()");
			return resultado;
		}
		
		public FichaSalidaBodegaDTO obtenerDatosSalidaBodega(Long numVenta)
			throws CustomerDomainException
		{
			cat.debug("Inicio:obtenerDatosSalidaBodega()");
			FichaSalidaBodegaDTO resultado = registroVentaDAO.obtenerDatosSalidaBodega(numVenta);
			cat.debug("Fin:obtenerDatosSalidaBodega()");
			return resultado;
		}
		
		public FichaContratoPrestacionDTO obtenerDatosContratoPrestacion(Long numVenta)
			throws CustomerDomainException
		{
			cat.debug("Inicio:obtenerDatosContratoPrestacion()");
			FichaContratoPrestacionDTO resultado = registroVentaDAO.obtenerDatosContratoPrestacion(numVenta);
			cat.debug("Fin:obtenerDatosContratoPrestacion()");
			return resultado;
		}
		
		public Long obtenerVentasAnteriores( Long numVenta , Long codCliente)
			throws CustomerDomainException
		{
			cat.debug("Inicio:obtenerVentasAnteriores()");
			Long resultado = registroVentaDAO.obtenerVentasAnteriores(numVenta, codCliente); 
			cat.debug("Fin:obtenerVentasAnteriores()");
			return resultado;
		}//fin obtenerVentasAnteriores
	
		public Long obtenerVentasAnterioresPorPlan( Long numVenta, Long codCliente, String codPlanTarif)
			throws CustomerDomainException
		{
			cat.debug("Inicio:obtenerVentasAnterioresPorPlan()");
			Long resultado = registroVentaDAO.obtenerVentasAnterioresPorPlan(numVenta, codCliente, codPlanTarif); 
			cat.debug("Fin:obtenerVentasAnterioresPorPlan()");
			return resultado;
		}//fin obtenerVentasAnterioresPorPlan
		
		public TipoSolicitudDTO[] obtenerTiposSolicitudes() 
			throws CustomerDomainException
		{
			cat.debug("Inicio:obtenerTiposSolicitudes()");
			TipoSolicitudDTO[] resultado = registroVentaDAO.obtenerTiposSolicitudes(); 
			cat.debug("Fin:obtenerTiposSolicitudes()");
			return resultado;
			
		}
		
		public CargoSolicitudDTO[] getCargosPARecSolicitud(CargoSolicitudDTO entrada)
			throws CustomerDomainException
		{	
			CargoSolicitudDTO[] resultado = null;
			cat.debug("Inicio:getCargosPARecSolicitud()");
			resultado =registroVentaDAO.getCargosPARecSolicitud(entrada); 
			cat.debug("Fin:getCargosPARecSolicitud()");
			return resultado;
		}
		
		public void updateAbonadoPreactivo(Long numAbonado)
			throws CustomerDomainException
		{
			cat.debug("Inicio:updateAbonadoPreactivo()");
			registroVentaDAO.updateAbonadoPreactivo(numAbonado);
			cat.debug("Fin:updateAbonadoPreactivo()");
		}
		
		public void liberarSeriesYTelefono(Long numAbonado) 
			throws CustomerDomainException
		{
			cat.debug("Inicio:liberarSeriesYTelefono()");
			registroVentaDAO.liberarSeriesYTelefono(numAbonado);
			cat.debug("Fin:liberarSeriesYTelefono()");
		}//fin reversaVenta
		
		//Inicio P-CSR-11002 JLGN 26-05-2011
		public DatosContrato datosVenta(String numVenta) 
			throws CustomerDomainException
		{
			DatosContrato resultado = null;
			cat.debug("Inicio:fechaVenta()");
			resultado = registroVentaDAO.datosVenta(numVenta);
			cat.debug("Fin:fechaVenta()");
			return resultado;
		}//fin fechaVenta
		//Fin P-CSR-11002 JLGN 26-05-2011
		
//FIN MERGE		
}//fin class RegistroVenta
