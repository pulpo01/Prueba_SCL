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
 * 23/02/2007     Roberto P&eacute;rez Varas      					Versión Inicial
 */
package com.tmmas.cl.scl.gestiondeabonados.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dao.SimcardDAO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.CargosSimcarPrepagoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.DescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosCargoSimcardDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosValidacionLogisticaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ProcesoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ResultadoValidacionLogisticaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SimcardSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TerminalSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;

public class SimcardBO extends ArticuloBO{
	private SimcardDAO simcardDAO  = new SimcardDAO();
	private static Category cat = Category.getInstance(SimcardBO.class);
	Global global = Global.getInstance();

	public ResultadoValidacionLogisticaDTO validaLargoSerieSimcar(ParametrosValidacionLogisticaDTO entrada)
	throws GeneralException{

		cat.debug("Inicio:validaLargoSerieSimcard()");
		ResultadoValidacionLogisticaDTO resultado = simcardDAO.getLargoSerieSimcard(entrada);
		/*if (resultado.getLargoSerie() == entrada.getNumeroSerie().length())
				resultado.setResultado(true);
			else
				resultado.setResultado(false);*/
		cat.debug("Fin:validaLargoSerieSimcard()");
		return resultado;
	}// fin validaLargoSerieTerminal

	public ResultadoValidacionLogisticaDTO existeSerieSimcard(ParametrosValidacionLogisticaDTO entrada)
	throws GeneralException{

		cat.debug("Inicio:existeSerieSimcard()");
		ResultadoValidacionLogisticaDTO resultado = simcardDAO.existeSerieSimcard(entrada); 
		if (resultado.getResultadoBase() == 1){
			resultado.setResultado(true);
		}
		else if (resultado.getResultadoBase() == 0){
			resultado.setResultado(false);
		}
		cat.debug("Fin:existeSerieSimcard()");
		return resultado;
	}//fin  existeSerieSimcard

	public SimcardSNPNDTO getSimcard(SimcardSNPNDTO entrada)
	throws GeneralException{
		cat.debug("Inicio:getSimcard()");
		SimcardSNPNDTO resultado = simcardDAO.getSimcard(entrada); 
		cat.debug("Fin:getSimcard()");
		return resultado;
	}//fin getSimcard

	public PrecioCargoDTO[] getPrecioCargoSimcard_PrecioLista(ParametrosCargoSimcardDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:getPrecioCargoSimcard_PrecioLista()");
		PrecioCargoDTO[] resultado =simcardDAO.getPrecioCargoSimcard_PrecioLista(entrada); 
		cat.debug("Fin:getPrecioCargoSimcard_PrecioLista()");
		return resultado;
	}//fin getPrecioCargoSimcard_PrecioLista

	public PrecioCargoDTO[] getPrecioCargoSimcard_NoPrecioLista(ParametrosCargoSimcardDTO entrada) 
	throws GeneralException{

		cat.debug("Inicio:getPrecioCargoSimcard_NoPrecioLista()");
		PrecioCargoDTO[] resultado = simcardDAO.getPrecioCargoSimcard_NoPrecioLista(entrada); 
		cat.debug("Fin:getPrecioCargoSimcard_NoPrecioLista()");
		return resultado;
	}//fin getPrecioCargoSimcard_NoPrecioLista

	/**
	 * Busca Descuentos asociados al Cargo de la simcard
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public DescuentoDTO[] getDescuentoCargo(ParametrosDescuentoDTO entrada) throws GeneralException{
		DescuentoDTO[] resultado = null;
		cat.debug("Inicio:getDescuentoCargo()");
		if (entrada.getClaseDescuento().equals(entrada.getClaseDescuentoArticulo()))
			resultado = simcardDAO.getDescuentoCargoArticulo(entrada);
		else
			resultado = simcardDAO.getDescuentoCargoConcepto(entrada);
		cat.debug("Fin:getDescuentoCargo()");
		return resultado;
	}//fin getDescuentoCargo

	/**
	 * Obtiene Codigo Concepto Facturable del descuento manual 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */

	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws GeneralException{
		cat.debug("Inicio:getCodigoDescuentoManual()");
		DescuentoDTO resultado = simcardDAO.getCodigoDescuentoManual(entrada);
		cat.debug("Fin:getCodigoDescuentoManual()");
		return resultado;
	}//fin getCodigoDescuentoManual

	/**
	 * Verifica que numero celular este bien reservado 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public ResultadoValidacionLogisticaDTO numeroReservadoOK(ParametrosValidacionLogisticaDTO entrada)
	throws GeneralException{

		cat.debug("Inicio:numeroReservadoOK()");
		ResultadoValidacionLogisticaDTO resultado =  simcardDAO.getNumeroReservadoOK(entrada); 
		if (resultado.getResultadoBase() == 1){
			resultado.setResultado(true);
		}
		else if (resultado.getResultadoBase() == 0){
			resultado.setResultado(false);
		}
		cat.debug("Fin:numeroReservadoOK()");
		return resultado;
	}//fin  numeroReservadoOK

	/**
	 * Obtiene el indicador de telefono para una simcard
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public SimcardSNPNDTO getIndicadorTelefono(SimcardSNPNDTO entrada)
	throws GeneralException{

		cat.debug("Inicio:getIndicadorTelefono()");
		SimcardSNPNDTO resultado = simcardDAO.getIndicadorTelefono(entrada); 
		cat.debug("Fin:getIndicadorTelefono()");
		return resultado;
	}//fin getIndicadorTelefono

	/**
	 * Valida autenticación de la serie 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public ProcesoDTO validaAutenticacionSerie(SimcardSNPNDTO entrada) 
	throws GeneralException{
		ProcesoDTO resultado = new ProcesoDTO();
		cat.debug("Inicio:validaAutenticacionSerie()");
		resultado = simcardDAO.validaAutenticacionSerie(entrada); 
		cat.debug("Fin:validaAutenticacionSerie()");
		return resultado;
	}

	/**
	 * Obtiene imsi de la simcard, utilizado para isertar movimiento en centrales 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public SimcardSNPNDTO getImsiSimcard(SimcardSNPNDTO simcard) 
	throws GeneralException{
		SimcardSNPNDTO resultado = new SimcardSNPNDTO();
		cat.debug("Inicio:getImsiSimcard()");
		resultado = simcardDAO.getImsiSimcard(simcard); 
		cat.debug("Fin:getImsiSimcard()");
		return resultado;
	}

	/**
	 * Actualiza stock simcard
	 * @param simcard
	 * @return resultado
	 * @throws GeneralException
	 */
	public SimcardSNPNDTO actualizaStockSimcard(SimcardSNPNDTO simcard) 
	throws GeneralException{
		SimcardSNPNDTO resultado = new SimcardSNPNDTO();
		cat.debug("Inicio:actualizaStockSimcard()");
		resultado = simcardDAO.actualizaStockSimcard(simcard); 
		cat.debug("Fin:actualizaStockSimcard()");
		return resultado;
	}//fin actualizaStockSimcard

		
		
	public void setNumeracionSimPortada(SimcardSNPNDTO simcard)  
	throws GeneralException{
		SimcardSNPNDTO resultado = new SimcardSNPNDTO();
		cat.debug("Inicio:setNumeracionSimPortada()");
		simcardDAO.setNumeracionSimPortada(simcard); 
		cat.debug("Fin:setNumeracionSimPortada()");
	}//fin actualizaStockSimcard	


	public CargosSimcarPrepagoDTO[] getCargosSimcardPrepago() 
	throws GeneralException{		
		CargosSimcarPrepagoDTO[] resultado = null;
		cat.debug("Inicio:getCargosSimcardPrepago()");
		resultado = simcardDAO.getCargosSimcardPrepago(); 
		cat.debug("Fin:getCargosSimcardPrepago()");
		return resultado;
	}//fin actualizaStockSimcard
	
	
	public SimcardSNPNDTO getSimcardAutomatico(SimcardSNPNDTO simcard)  
	throws GeneralException{
		SimcardSNPNDTO resultado = new SimcardSNPNDTO();
		cat.debug("Inicio:getSimcardAutomatico()");
		resultado = simcardDAO.getSimcardAutomatico(simcard); 
		cat.debug("Fin:getSimcardAutomatico()");
		return resultado;
	}//fin actualizaStockSimcard	

	
}//fin Class Simcard

