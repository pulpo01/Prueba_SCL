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
 * 26/02/2007     H&eacute;ctor Hermosilla				Versión Inicial
 */
package com.tmmas.cl.scl.productdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioListOutDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionTasacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionTasacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dao.PlanTarifarioDAO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.PlanTarifarioDTO;

public class PlanTarifario extends ProductComponent{
	private PlanTarifarioDAO planTarifarioDAO = new PlanTarifarioDAO();
	private static Category cat = Category.getInstance(PlanTarifario.class);
	
	/**
	 * Obtiene todos los atributos del Plan Tarifario. No se define atributos 
	 * debido a que el BO solo procesa y los datos
	 * se retornan a traves de un DTO. 
	 * 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	

	public PlanTarifarioDTO getPlanTarifario(PlanTarifarioDTO entrada) throws ProductDomainException{
		PlanTarifarioDTO resultado = null;
		cat.debug("Inicio:getPlanTarifario()");
		resultado = planTarifarioDAO.getPlanTarifario(entrada);
		cat.debug("Fin:getPlanTarifario()");
		return resultado;
	}
	
	/**
	 * Verifica si Existe o no un Plan Tarifario especifico 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public ResultadoValidacionTasacionDTO existePlanTarifario(ParametrosValidacionTasacionDTO entrada) throws ProductDomainException{
		ResultadoValidacionTasacionDTO resultado = null;
		cat.debug("Inicio:getPlanTarifario()");
		resultado = planTarifarioDAO.existePlanTarifario(entrada);
		if (resultado.getResultadoBase() == 1){
			resultado.setResultado(true);
		}
		else if (resultado.getResultadoBase() ==0){
			resultado.setResultado(false);
		}
		cat.debug("Fin:getPlanTarifario()");
		return resultado;
	}
	
	/**
	 * Busca Valores asociados al Cargo Basico del Plan Tarifario
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public PrecioCargoDTO[] getCargoBasico(PlanTarifarioDTO entrada) throws ProductDomainException{
		PrecioCargoDTO[] resultado = null;
		cat.debug("Inicio:getCargoBasico()");
		resultado = planTarifarioDAO.getCargoBasico(entrada);
		cat.debug("Fin:getCargoBasico()");
		return resultado;
	}//fin getCargoBasico

	
	/**
	 * Busca Descuentos asociados al Cargo Basico del Plan Tarifario
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public DescuentoDTO[] getDescuentoCargoBasico(ParametrosDescuentoDTO entrada) throws ProductDomainException{
		DescuentoDTO[] resultado = null;
		cat.debug("Inicio:getDescuentoCargoBasico()");
		if (entrada.getClaseDescuentoArticulo().equals(entrada.getClaseDescuento()))
			resultado = planTarifarioDAO.getDescuentoCargoBasicoArticulo(entrada);
		else
			resultado = planTarifarioDAO.getDescuentoCargoBasicoConcepto(entrada);
		cat.debug("Fin:getDescuentoCargoBasico()");
		return resultado;
	}//fin getDescuentoCargoBasico
	
	/**
	 * Busca la categoria del Plan Tarifario
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public PlanTarifarioDTO getCategoriaPlanTarifario(PlanTarifarioDTO entrada) throws ProductDomainException{
		PlanTarifarioDTO resultado = new PlanTarifarioDTO();
		cat.debug("Inicio:getCategoriaPlanTarifario()");
		resultado = planTarifarioDAO.getCategoriaPlanTarifario(entrada);
		cat.debug("Fin:getCategoriaPlanTarifario()");
		return resultado;
	}//fin getCategoriaPlanTarifario
	
	/**
	 * Busca el tipo del Plan Tarifario
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public PlanTarifarioDTO getTipoPlanTarifario(PlanTarifarioDTO entrada) throws ProductDomainException{
		PlanTarifarioDTO resultado = new PlanTarifarioDTO();
		cat.debug("Inicio:getTipoPlanTarifario()");
		resultado = planTarifarioDAO.getCategoriaPlanTarifario(entrada);
		cat.debug("Fin:getTipoPlanTarifario()");
		return resultado;
	}//fin getTipoPlanTarifario
	
	/**
	 * Obtiene Codigo Concepto Facturable del descuento manual 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws ProductDomainException{
		cat.debug("Inicio:getCodigoDescuentoManual()");
		DescuentoDTO resultado = planTarifarioDAO.getCodigoDescuentoManual(entrada);
		cat.debug("Fin:getCodigoDescuentoManual()");
		return resultado;
	}//fin getCodigoDescuentoManual

	/**
	 * Obtiene limites de consumos para el plan tarifario
	 * @param entrada
	 * @return PlanTarifarioDTO[]
	 * @throws ProductDomainException
	 */
	public PlanTarifarioDTO[] getListLimiteConsumo(PlanTarifarioDTO entrada)
	throws ProductDomainException{
		PlanTarifarioDTO[] resultado = null;
		cat.debug("Inicio:getListLimiteConsumo()");
		resultado = planTarifarioDAO.getListLimiteConsumo(entrada);
		cat.debug("Fin:getListLimiteConsumo()");
		return resultado;		
	}//fin getListLimiteConsumo

	/**
	 * Obtiene planes tarifarios comercializables y no comercializables
	 * @param entrada
	 * @return PlanTarifarioDTO[]
	 * @throws ProductDomainException
	 */
	public PlanTarifarioDTO[] getListPlanTarifario(PlanTarifarioDTO entrada)
	throws ProductDomainException{
		PlanTarifarioDTO[] resultado = null;
		cat.debug("Inicio:getListPlanTarifario()");
		resultado = planTarifarioDAO.getListPlanTarifario(entrada);
		cat.debug("Fin:getListPlanTarifario()");
		return resultado;
	}//fin getListPlanTarifario

	/**
	 * Obtiene planes tarifarios segun numero identificador, tipo de identificador y tipo de plan
	 * @param entrada
	 * @return PlanTarifarioDTO[]
	 * @throws ProductDomainException
	 */
	public PlanTarifarioDTO[] getListPlanTarifarioNumIdentTipoPlan(PlanTarifarioDTO entrada)
	throws ProductDomainException{
		PlanTarifarioDTO[] resultado = null;
		cat.debug("Inicio:getListPlanTarifarioNumIdentTipoPlan()");
		resultado = planTarifarioDAO.getListPlanTarifarioNumIdentTipoPlan(entrada);
		cat.debug("Fin:getListPlanTarifarioNumIdentTipoPlan()");
		return resultado;
	}//fin getListPlanTarifarioNumIdentTipoPlan

	
	/**
	 * Obtiene planes tarifarios segun numero identificador, tipo de identificador,
	 * tipo de plan
	 * @param entrada
	 * @return PlanTarifarioDTO[]
	 * @throws ProductDomainException
	 */
	public PlanTarifarioDTO[] getListPlanTarifarioPorPlanORango(PlanTarifarioDTO entrada)
	throws ProductDomainException{
		PlanTarifarioDTO[] resultado = null;
		cat.debug("Inicio:getListPlanTarifarioPorPlanORango()");
		resultado = planTarifarioDAO.getListPlanTarifarioPorPlanORango(entrada);
		cat.debug("Fin:getListPlanTarifarioPorPlanORango()");
		return resultado;
	}//fin getListPlanTarifarioPorPlanORango
	/** Servicios Activaciones WEB - Colombia 
	 * Obtine planes tarifarios 
	 * @param PlanTarifarioDTO (entrada)
	 * @return PlanTarifarioDTO (resultado)
	 * @throws ProductDomainException
	 * wjrc - Agosto 2007 */		
	public PlanTarifarioDTO[] getListPlanTarif(PlanTarifarioDTO entrada)
	throws ProductDomainException{
		PlanTarifarioDTO[] resultado = null;
		cat.debug("Inicio:getListPlanTarif");
		resultado = planTarifarioDAO.getListPlanTarif(entrada);
		cat.debug("Fin:getListPlanTarif)");
		return resultado;
	}//fin getListPlanTarif	

	/** COL08009 
	 * mti - Abril 2008*/
	public LstPTaPlanTarifarioListOutDTO lstPlanTarif(LstPTaPlanTarifarioInDTO entrada)
	throws ProductDomainException{
		LstPTaPlanTarifarioListOutDTO resultado = null;
		cat.debug("Inicio:lstPlanTarif");
		resultado = planTarifarioDAO.lstPlanTarif(entrada);
		cat.debug("Fin:lstPlanTarif)");
		return resultado;
	}//fin getListPlanTarif	

	/** POSVENTA(CPU) 
	 * mti - Julio 2008*/
	public LstPTaPlanTarifarioListOutDTO lstPlanTarifPosventa(LstPTaPlanTarifarioInDTO entrada)
	throws ProductDomainException{
		LstPTaPlanTarifarioListOutDTO resultado = null;
		cat.debug("Inicio:lstPlanTarifPosventa");
		resultado = planTarifarioDAO.lstPlanTarifPosventa(entrada);
		cat.debug("Fin:lstPlanTarifPosventa)");
		return resultado;
	}//fin lstPlanTarifPosventa	
	
	//P-CSR-11002 JLGN 01-07-2011
	public long getCargoPlanTarif(String codPlanTarif)
	throws CustomerDomainException, ProductDomainException{
		long resultado = 0;
		cat.debug("Inicio:getCargoPlanTarif");
		resultado = planTarifarioDAO.getCargoPlanTarif(codPlanTarif);
		cat.debug("Fin:getCargoPlanTarif)");
		return resultado;
	}//Fin P-CSR-11002 JLGN 01-07-2011 
	
	
}//fin PlanTarifario
