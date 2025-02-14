/*
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 27/01/2007     H&eacute;ctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionVentasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.RegistroEvaluacionRiesgoDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroEvaluacionRiesgoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class RegistroEvaluacionRiesgo {
	
	private RegistroEvaluacionRiesgoDAO registroEvaluacionRiesgoDAO  = new RegistroEvaluacionRiesgoDAO();
	private static Category cat = Category.getInstance(RegistroEvaluacionRiesgo.class);
	Global global = Global.getInstance();

	public ResultadoValidacionVentaDTO  existeEvaluacionRiesgo(ParametrosValidacionVentasDTO parametrosValidacionVentasDTO)throws CustomerDomainException{
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		cat.debug("Inicio:getExisteEvaluacionRiesgo()");
		resultado = registroEvaluacionRiesgoDAO.existeEvaluacionRiesgo(parametrosValidacionVentasDTO);
		if (resultado.getResultadoBase() ==Integer.parseInt(global.getValor("valor.verdadero"))){
			resultado.setResultado(true);
		}
		else if (resultado.getResultadoBase() ==Integer.parseInt(global.getValor("valor.falso"))){
			resultado.setResultado(false);
		}
		cat.debug("Fin:getExisteEvaluacionRiesgo()");
		return resultado;
	}	
	public ResultadoValidacionVentaDTO  existeEvalRiesgoPlanTarif(ParametrosValidacionVentasDTO parametrosValidacionVentasDTO)throws CustomerDomainException{
		
		cat.debug("Inicio:existeEvalRiesgoPlanTarif()");
		ResultadoValidacionVentaDTO resultado = registroEvaluacionRiesgoDAO.existeEvalRiesgoPlanTarif(parametrosValidacionVentasDTO);
		if (resultado.getResultadoBase() ==Integer.parseInt(global.getValor("valor.verdadero"))){
			resultado.setResultado(true);
		}
		else if (resultado.getResultadoBase() ==Integer.parseInt(global.getValor("valor.falso"))){
			resultado.setResultado(false);
		}
		cat.debug("Fin:existeEvalRiesgoPlanTarif()");
		return resultado;
	}
	
	public RegistroEvaluacionRiesgoDTO  getEvaluacionRiesgo(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO)throws CustomerDomainException{
		cat.debug("Inicio:getEvaluacionRiesgo()");
		RegistroEvaluacionRiesgoDTO resultado = registroEvaluacionRiesgoDAO.getEvaluacionRiesgo(registroEvaluacionRiesgoDTO); 
		cat.debug("Fin:getEvaluacionRiesgo()");
		return resultado;
	}	
	public RegistroEvaluacionRiesgoDTO  getEvalRiesgoPlanTarif(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO)throws CustomerDomainException{
		
		cat.debug("Inicio:getEvalRiesgoPlanTarif()");
		RegistroEvaluacionRiesgoDTO resultado =  registroEvaluacionRiesgoDAO.getEvalRiesgoPlanTarif(registroEvaluacionRiesgoDTO); 
		cat.debug("Fin:getEvalRiesgoPlanTarif()");
		return resultado;
	}

	public RegistroEvaluacionRiesgoDTO getRegEvaluacionRiesgo(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO)
	throws CustomerDomainException{
		 
		cat.debug("Inicio:RegistroEvaluacionRiesgoDTO()");
		RegistroEvaluacionRiesgoDTO resultado = registroEvaluacionRiesgoDAO.getRegEvaluacionRiesgo(registroEvaluacionRiesgoDTO); 
		cat.debug("Fin:RegistroEvaluacionRiesgoDTO()");
		return resultado;
	}//fin RegistroEvaluacionRiesgoDTO

	/**
	 * Obtiene planes tarifarios autorizados
	 * @param registroEvaluacionRiesgoDTO
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroEvaluacionRiesgoDTO[] getListPlanTarifarioAutoriz(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO) 
	throws CustomerDomainException{
		cat.debug("Inicio:getListPlanTarifarioAutoriz()");
		RegistroEvaluacionRiesgoDTO[] resultado = registroEvaluacionRiesgoDAO.getListPlanTarifarioAutoriz(registroEvaluacionRiesgoDTO); 
		cat.debug("Fin:getListPlanTarifarioAutoriz()");
		return resultado;
	}//fin getListPlanTarifarioAutoriz

	/**
	 * Verifica si existe excepcion para el numero de identificador
	 * @param registroEvaluacionRiesgoDTO
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroEvaluacionRiesgoDTO existeExcepcion(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO) 
	throws CustomerDomainException{
		RegistroEvaluacionRiesgoDTO resultado = null;
		cat.debug("Inicio:existeExcepcion()");
		resultado = registroEvaluacionRiesgoDAO.getExcepcion(registroEvaluacionRiesgoDTO); 
		cat.debug("Fin:existeExcepcion()");
		return resultado;		
	}//fin existeExcepcion
	
	/**
	 * Obtiene evaluación de riesgo vigente asociada al cliente
	 * @param registroEvaluacionRiesgoDTO
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroEvaluacionRiesgoDTO  getEvaluacionRiesgoVigenteCliente(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO)
	throws CustomerDomainException{
		cat.debug("Inicio:getEvaluacionRiesgoVigenteCliente()");
		RegistroEvaluacionRiesgoDTO resultado = registroEvaluacionRiesgoDAO.getEvaluacionRiesgoVigenteCliente(registroEvaluacionRiesgoDTO); 
		cat.debug("Fin:getEvaluacionRiesgoVigenteCliente()");
		return resultado;
	}	
	
	/**
	 * Actualiza cantidad de terminales vendidos asociados a la evaluacion de riesgo.
	 * 
	 * @author Héctor Hermosilla
	 * @param registroEvaluacionRiesgoDTO
	 * @return 
	 * @throws CustomerDomainException
	 */
	public void actualizaTerminalesVendidos(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO)throws CustomerDomainException{
		cat.debug("Inicio:actualizaTerminalesVendidos()");
		registroEvaluacionRiesgoDAO.actualizaTerminalesVendidos(registroEvaluacionRiesgoDTO); 
		cat.debug("Fin:actualizaTerminalesVendidos()");
	}	

	/**
	 * Inserta relacion entre la solicitud y la venta
	 * @author wjrc	
	 * @param registroEvaluacionRiesgoDTO
	 * @return 
	 * @throws CustomerDomainException
	 */
	public void insSolicitudVenta(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO) 
	throws CustomerDomainException{
		cat.debug("Inicio:insSolicitudVenta()");
		registroEvaluacionRiesgoDAO.insSolicitudVenta(registroEvaluacionRiesgoDTO); 
		cat.debug("Fin:insSolicitudVenta()");
	}//fin insSolicitudVenta
	
	
	
	public RegistroEvaluacionRiesgoDTO validaExistenciaEvRiesgo(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgo) 
	throws CustomerDomainException{
		cat.debug("Inicio:validaExistenciaEvRiesgo()");
		RegistroEvaluacionRiesgoDTO respuesta = new RegistroEvaluacionRiesgoDTO();
		respuesta = registroEvaluacionRiesgoDAO.validaExistenciaEvRiesgo(registroEvaluacionRiesgo);
		cat.debug("Fin:validaExistenciaEvRiesgo()");
		return respuesta;		
	}
	
	public void validaPlanTarifarioEvRiesgo(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgo) 
	throws CustomerDomainException{
		cat.debug("Inicio:validaPlanTarifarioEvRiesgo()");
		registroEvaluacionRiesgoDAO.validaPlanTarifarioEvRiesgo(registroEvaluacionRiesgo); 
		cat.debug("Fin:validaPlanTarifarioEvRiesgo()");
	}
	
	public void bloqueaSolicitudEvRiesgo(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgo) 
	throws CustomerDomainException{
		cat.debug("Inicio:bloqueaSolicitudEvRiesgo()");
		registroEvaluacionRiesgo.setCodigoEstado(3);		
		registroEvaluacionRiesgoDAO.cambiaEstadoSolicitudEvRiesgo(registroEvaluacionRiesgo); 
		cat.debug("Fin:bloqueaSolicitudEvRiesgo()");		
	}
	
	public void desBloqueaEstadoSolicitudEvRiesgo(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgo) 
	throws CustomerDomainException{
		cat.debug("Inicio:desBloqueaEstadoSolicitudEvRiesgo()");
		registroEvaluacionRiesgo.setCodigoEstado(1);
		registroEvaluacionRiesgoDAO.cambiaEstadoSolicitudEvRiesgo(registroEvaluacionRiesgo); 
		cat.debug("Fin:desBloqueaEstadoSolicitudEvRiesgo()");
		
	}	
	
	public void udp_EvRiesgo_registroPlanes(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgo) 
	throws CustomerDomainException{
		cat.debug("Inicio:udp_EvRiesgo_registroPlanes()");
		registroEvaluacionRiesgoDAO.udp_EvRiesgo_registroPlanes(registroEvaluacionRiesgo); 
		cat.debug("Fin:udp_EvRiesgo_registroPlanes()");					
	}
		
}//fin CLASS RegistroEvaluacionRiesgo
