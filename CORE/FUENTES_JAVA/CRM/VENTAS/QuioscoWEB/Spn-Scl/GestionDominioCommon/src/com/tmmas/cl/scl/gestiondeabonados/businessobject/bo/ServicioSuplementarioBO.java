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
 * 19/03/2007              Wildo Ramos             		 Versión Inicial
 */
package com.tmmas.cl.scl.gestiondeabonados.businessobject.bo;

import java.util.ArrayList;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dao.ServicioSuplementarioDAO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.DescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ExisteSSAbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReglaCompatibilidadSSDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReglasSSuplementariosDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SSuplementariosDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ServicioSuplementarioDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WsAgregaEliminaSSInDTO;

public class ServicioSuplementarioBO {

	private ServicioSuplementarioDAO servicioSuplementarioDAO  = new ServicioSuplementarioDAO();
	private static Category cat = Category.getInstance(ServicioSuplementarioBO.class);
	
	public void creaSSAbonado(ServicioSuplementarioDTO entrada)throws GeneralException{
		cat.debug("Inicio:creaSSAbonado()");
		servicioSuplementarioDAO.creaSSAbonado(entrada); 
		cat.debug("Fin:creaSSAbonado()");
	}//fin creaSSAbonado

	public ServicioSuplementarioDTO[] getSSAbonado(ServicioSuplementarioDTO entrada)throws GeneralException{
		cat.debug("Inicio:getSSAbonado()");
		ServicioSuplementarioDTO[] resultado;
		resultado = servicioSuplementarioDAO.getListaSSAbonado(entrada); 
		cat.debug("Fin:getSSAbonado()");
		return resultado;
	}//fin getSSAbonado	

	public PrecioCargoDTO[] getCargoServSupl(ServicioSuplementarioDTO entrada) throws GeneralException{
		PrecioCargoDTO[] resultado = null;
		cat.debug("Inicio:getCargoServSupl()");
		resultado = servicioSuplementarioDAO.getCargoServSupl(entrada);
		cat.debug("Fin:getCargoServSupl()");
		return resultado;
	}//fin getCargoServSupl
	
	/**
	 * Busca Descuentos asociados al cargo del Servicio Suplementario
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public DescuentoDTO[] getDescuentoCargo(ParametrosDescuentoDTO entrada) throws GeneralException{
		DescuentoDTO[] resultado = null;
		cat.debug("Inicio:getDescuentoCargo()");
		if (entrada.getClaseDescuento().equals(entrada.getClaseDescuentoArticulo()))
			resultado = servicioSuplementarioDAO.getDescuentoCargoArticulo(entrada);
		else
			resultado = servicioSuplementarioDAO.getDescuentoCargoConcepto(entrada);
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
		DescuentoDTO resultado = servicioSuplementarioDAO.getCodigoDescuentoManual(entrada);
		cat.debug("Fin:getCodigoDescuentoManual()");
		return resultado;
	}//fin getCodigoDescuentoManual
	
	/**
	 * Obtiene lista de SS del abonado para enviar movimiento a centrales 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public ServicioSuplementarioDTO[] getSSAbonadoParaCentrales(ServicioSuplementarioDTO entrada)throws GeneralException{
		cat.debug("Inicio:getSSAbonadoParaCentrales()");
		ServicioSuplementarioDTO[] resultado;
		resultado = servicioSuplementarioDAO.getListaSSAbonadoParaCentral(entrada); 
		cat.debug("Fin:getSSAbonadoParaCentrales()");
		return resultado;
	}//fin getSSAbonadoParaCentrales
	
	/**
	 * Obtiene lista de SS del abonado que no son enviados a centrales
	   para completar cadena clase servicio del abonado
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public ServicioSuplementarioDTO[] getSSAbonadoNoCentrales(ServicioSuplementarioDTO entrada)throws GeneralException{
		cat.debug("Inicio:getSSAbonadoNoCentrales()");
		ServicioSuplementarioDTO[] resultado;
		resultado = servicioSuplementarioDAO.getSSAbonadoNoCentrales(entrada); 
		cat.debug("Fin:getSSAbonadoNoCentrales()");
		return resultado;
	}//fin getSSAbonadoNoCentrales
	

	public SSuplementariosDTO[] getSSincluidosEnPlan(String codigoPlanTarifario) 
	throws GeneralException{
		cat.debug("Inicio:getSSincluidosEnPlan()");
		SSuplementariosDTO[] resultado;
		resultado = servicioSuplementarioDAO.getSSincluidosEnPlan(codigoPlanTarifario); 
		cat.debug("Fin:getSSincluidosEnPlan()");
		return resultado;
	}//fin getSSincluidosEnPlan	
	

	public SSuplementariosDTO[] getSSOpcionalesAlPlan(String codigoPlanTarifario, String codigoArticulo, String codigCentral) 
	throws GeneralException{
		cat.debug("Inicio:getSSOpcionalesAlPlanOpc()");
		SSuplementariosDTO[] resultado;
		SSuplementariosDTO[] resultado2;
		SSuplementariosDTO[] resultado3;
		boolean existe = false;
		ArrayList lista = new ArrayList();
		
		resultado = servicioSuplementarioDAO.getSSOpcionalesAlPlan(codigoPlanTarifario, codigoArticulo, codigCentral);
		
		if (resultado == null){
			resultado = servicioSuplementarioDAO.getSSOpcionalesAlPlan(codigoPlanTarifario, codigoArticulo, codigCentral);			
		}
				
		resultado2 = servicioSuplementarioDAO.getSSincluidosEnPlan(codigoPlanTarifario);
		
		for (int i=0; i < resultado.length;i++){
			existe = false;
			for (int j=0; j< resultado2.length;j++){
				cat.debug("opcionles[i].getCodigoServicio()  ["+resultado[i].getCodigoServicio()+"]");
				cat.debug("inclidos[j].getCodigoServicio()   ["+resultado2[j].getCodigoServicio()+"]");
				
				cat.debug(" resultado[i].getCodigoNivel()    ["+ resultado[i].getCodigoNivel()+"]");
				cat.debug("resultado2[j].getCodigoNivel()    ["+resultado2[j].getCodigoNivel()+"]");
				
				cat.debug("resultado[i].getCodigoServSupl()  ["+resultado[i].getCodigoServSupl()+"]");
				cat.debug("resultado2[j].getCodigoServSupl() ["+resultado2[j].getCodigoServSupl()+"]");
				
				if (resultado[i].getCodigoServicio().equals(resultado2[j].getCodigoServicio()) &&  resultado[i].getCodigoNivel().equals(resultado2[j].getCodigoNivel()) && resultado[i].getCodigoServSupl().equals(resultado2[j].getCodigoServSupl())){
					cat.debug("existe [TRUE]");
					existe = true;
					break;
				}
			}
			if (!existe){
				cat.debug("existe [FALSE] se agrega");
				lista.add(resultado[i]);
			}
		}
		resultado3 =(SSuplementariosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
				lista.toArray(), SSuplementariosDTO.class);
		
		cat.debug("Fin:getSSOpcionalesAlPlanOpc()");
		return resultado3;
	}	
		
	public ReglasSSuplementariosDTO[] getReglaSSporServicio(String codigoServicioS) 
	throws GeneralException{
		cat.debug("Inicio:getReglaSSporServicio()");
		ReglasSSuplementariosDTO[] resultado;
		resultado = servicioSuplementarioDAO.getReglaSSporServicio(codigoServicioS); 
		cat.debug("Fin:getReglaSSporServicio()");
		return resultado;
	}//fin getSSincluidosEnPlan
	
	public void setAgregaSS(AbonadoDTO abonado, WsAgregaEliminaSSInDTO[] sSuplementarios) 
	throws GeneralException{
		cat.debug("Inicio:setAgregaSS()");		
		servicioSuplementarioDAO.setAgregaSS(abonado, sSuplementarios); 
		cat.debug("Fin:setAgregaSS()");		
	}
	
	public void setEliminarSS(AbonadoDTO abonado, WsAgregaEliminaSSInDTO[] sSuplementarios)
	throws GeneralException{
		cat.debug("Inicio:setEliminarSS()");
		servicioSuplementarioDAO.setEliminarSS(abonado, sSuplementarios); 
		cat.debug("Fin:setEliminarSS()");
	}
	
	public ReglaCompatibilidadSSDTO[] getReglasCompatibilidadSS() 
	throws GeneralException{
		cat.debug("Inicio:getReglasCompatibilidadSS()");
		cat.debug("fin:getReglasCompatibilidadSS()");
		return servicioSuplementarioDAO.getReglasCompatibilidadSS();
	}
	
	public ExisteSSAbonadoDTO validaExisteSSAbondo(ExisteSSAbonadoDTO existeSSAbonadoDTO) 
	throws GeneralException{
		ExisteSSAbonadoDTO resultado;
		cat.debug("Inicio:validaExisteSSAbondo()");
		resultado = servicioSuplementarioDAO.validaExisteSSAbondo(existeSSAbonadoDTO); 
		cat.debug("Fin:validaExisteSSAbondo()");
		return resultado;
	}
	
}//fin ServicioSuplementario

