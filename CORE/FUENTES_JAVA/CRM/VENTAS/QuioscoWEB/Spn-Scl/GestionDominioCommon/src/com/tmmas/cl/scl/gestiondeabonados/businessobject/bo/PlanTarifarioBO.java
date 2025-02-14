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
package com.tmmas.cl.scl.gestiondeabonados.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dao.PlanTarifarioDAO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.DescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosValidacionTasacionDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PlanUsoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ResultadoValidacionTasacionDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSPlanTarifarioInDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsConsultaPlanTarifarioInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsConsultaPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListConsultaPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTipoPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsPlanTarifarioInDTO;

public class PlanTarifarioBO {
	private PlanTarifarioDAO planTarifarioDAO = new PlanTarifarioDAO();
	private static Category cat = Category.getInstance(PlanTarifarioBO.class);
	
	/**
	 * Obtiene todos los atributos del Plan Tarifario. No se define atributos 
	 * debido a que el BO solo procesa y los datos
	 * se retornan a traves de un DTO. 
	 * 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	

	public PlanTarifarioDTO getPlanTarifario(PlanTarifarioDTO entrada) throws GeneralException{
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
	 * @throws GeneralException
	 */
	public ResultadoValidacionTasacionDTO existePlanTarifario(ParametrosValidacionTasacionDTO entrada) throws GeneralException{
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
	 * @throws GeneralException
	 */
	public PrecioCargoDTO[] getCargoBasico(PlanTarifarioDTO entrada) throws GeneralException{
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
	 * @throws GeneralException
	 */
	public DescuentoDTO[] getDescuentoCargoBasico(ParametrosDescuentoDTO entrada) throws GeneralException{
		DescuentoDTO[] resultado = null;
		cat.debug("Inicio:getDescuentoCargoBasico()");
		if (entrada.getClaseDescuento().equals(entrada.getClaseDescuentoArticulo()))
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
	 * @throws GeneralException
	 */
	public PlanTarifarioDTO getCategoriaPlanTarifario(PlanTarifarioDTO entrada) throws GeneralException{
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
	 * @throws GeneralException
	 */
	public PlanTarifarioDTO getTipoPlanTarifario(PlanTarifarioDTO entrada) throws GeneralException{
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
	 * @throws GeneralException
	 */
	
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws GeneralException{
		cat.debug("Inicio:getCodigoDescuentoManual()");
		DescuentoDTO resultado = planTarifarioDAO.getCodigoDescuentoManual(entrada);
		cat.debug("Fin:getCodigoDescuentoManual()");
		return resultado;
	}//fin getCodigoDescuentoManual

	/**
	 * Obtiene limites de consumos para el plan tarifario
	 * @param entrada
	 * @return PlanTarifarioDTO[]
	 * @throws GeneralException
	 */
	public PlanTarifarioDTO[] getListLimiteConsumo(PlanTarifarioDTO entrada)
	throws GeneralException{
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
	 * @throws GeneralException
	 */
	public PlanTarifarioDTO[] getListPlanTarifario(PlanTarifarioDTO entrada)
	throws GeneralException{
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
	 * @throws GeneralException
	 */
	public PlanTarifarioDTO[] getListPlanTarifarioNumIdentTipoPlan(PlanTarifarioDTO entrada)
	throws GeneralException{
		PlanTarifarioDTO[] resultado = null;
		cat.debug("Inicio:getListPlanTarifarioNumIdentTipoPlan()");
		resultado = planTarifarioDAO.getListPlanTarifarioNumIdentTipoPlan(entrada);
		cat.debug("Fin:getListPlanTarifarioNumIdentTipoPlan()");
		return resultado;
	}//fin getListPlanTarifarioNumIdentTipoPlan
	
	/**
	 * Obtiene indicador vigencia relacion plan uso
	 * @param codCliente 
	 * @return resultado
	 * @throws CustomerDomainException
	 */		
	public String obtieneVigenciaPlanUso(PlanUsoDTO entrada)
		throws GeneralException		
	{
		cat.debug("Inicio:obtieneVigenciaPlanUso()");
		String resultado = planTarifarioDAO.obtieneVigenciaPlanUso(entrada);
		cat.debug("Fin:obtieneVigenciaPlanUso()");
		return resultado;
	}//fin obtieneVigenciaPlanUso
	
	/**
	 * Obtiene indicador vigencia relacion plan uso
	 * @param codCliente 
	 * @return resultado
	 * @throws CustomerDomainException
	 */		
	public String obtieneVigenciaPlanUsoSimcard(PlanUsoDTO entrada)
		throws GeneralException		
	{
		cat.debug("Inicio:obtieneVigenciaPlanUsoSimcard()");
		String resultado = planTarifarioDAO.obtieneVigenciaPlanUsoSimcard(entrada);
		cat.debug("Fin:obtieneVigenciaPlanUsoSimcard()");
		return resultado;
	}//fin obtieneVigenciaPlanUso
	
	/**
	 * Obtiene planes tarifarios tipo de plan sin aplicar ER
	 * @param entrada
	 * @return PlanTarifarioDTO[]
	 * @throws GeneralException
	 */
	public PlanTarifarioDTO[] getListPlanTarifarioNumIdentTipoPlanSinER(PlanTarifarioDTO entrada)
		throws GeneralException
	{
		PlanTarifarioDTO[] resultado = null;
		cat.debug("Inicio:getListPlanTarifarioNumIdentTipoPlanSinER()");
		resultado = planTarifarioDAO.getListPlanTarifarioNumIdentTipoPlanSinER(entrada);
		cat.debug("Fin:getListPlanTarifarioNumIdentTipoPlanSinER()");
		return resultado;
	}//fin getListPlanTarifarioNumIdentTipoPlanSinER
	
	
	/**
	 * Obtiene Lista de tipos de planes tarifarios
	 * @param planTarifarioDTO 
	 * @return resultado
	 * @throws GeneralException
	 */		
	public WsListTipoPlanTarifarioOutDTO getListadoTiposPlanesTarifarios()
	throws GeneralException
	{
		WsListTipoPlanTarifarioOutDTO resultado = null;
		cat.debug("Inicio:PlanTarifarioDAO:getListadoTiposPlanesTarifarios()");
		resultado = planTarifarioDAO.getListadoTiposPlanesTarifarios(); 
		cat.debug("Fin:PlanTarifarioDAO:getListadoTiposPlanesTarifarios()");
		return resultado;
	}//fin getListadoTiposPlanesTarifarios	
	
	/**
	 * Obtiene Lista de planes tarifario
	 * @param planTarifarioDTO 
	 * @return resultado
	 * @throws GeneralException
	 */		
	public WsListPlanTarifarioOutDTO getListadoPlanesTarifarios(WsPlanTarifarioInDTO inWSLstPlanTarifDTO)
	throws GeneralException
	{
		WsListPlanTarifarioOutDTO resultado = null;
		cat.debug("Inicio:PlanTarifarioDAO:getListadoPlanesTarifarios()");
		resultado = planTarifarioDAO.getListadoPlanesTarifarios(inWSLstPlanTarifDTO); 
		cat.debug("Fin:PlanTarifarioDAO:getListadoPlanesTarifarios()");
		return resultado;
	}//fin getListadoPlanesTarifarios
	
	
	public WSPlanTarifarioOutDTO getPlanTarifarioImporteImpuesto(WSPlanTarifarioInDTO entrada)
	throws GeneralException
	{	
		WSPlanTarifarioOutDTO resultado = null;
		cat.debug("Inicio:PlanTarifarioDAO:getPlanTarifarioImporteImpuesto()");
		resultado = planTarifarioDAO.getPlanTarifarioImporteImpuesto(entrada); 
		cat.debug("Fin:PlanTarifarioDAO:getPlanTarifarioImporteImpuesto()");
		return resultado;
	}//fin getListadoPlanesTarifarios	

	/**
	 * Obtiene Lista de planes tarifario
	 * @param planTarifarioDTO 
	 * @return resultado
	 * @throws GeneralException
	 */		
	public WsListConsultaPlanTarifarioOutDTO getConsultaPlanesTarifarios(WsConsultaPlanTarifarioInDTO consultaPlanTarifarioIn)
	throws GeneralException
	{
		WsListConsultaPlanTarifarioOutDTO resultado = null;
		cat.debug("Inicio:PlanTarifarioDAO:getListadoPlanesTarifarios()");
		resultado = planTarifarioDAO.getConsultaPlanesTarifarios(consultaPlanTarifarioIn); 
		cat.debug("Fin:PlanTarifarioDAO:getListadoPlanesTarifarios()");
		return resultado;
	}//fin getListadoPlanesTarifarios
	
	public void getPlanTarifarioClienteEMP(PlanTarifarioDTO planEntrada) throws GeneralException{
		cat.debug("Inicio:getPlanTarifarioClienteEMP()");
		planTarifarioDAO.getPlanTarifarioClienteEMP(planEntrada); 
		cat.debug("Fin:getPlanTarifarioClienteEMP()");
	}
	
	
}//fin PlanTarifario
