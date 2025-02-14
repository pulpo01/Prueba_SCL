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
 * 14/05/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.productdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.TOLException;
import com.tmmas.cl.scl.productdomain.businessobject.dao.DistribucionBolsaDAO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.BolsaAbonadoDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.DistribucionBolsaDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.LimiteClienteDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ProductListDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.TipoPrestacionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class DistribucionBolsa extends ProductComponent{
	
	private DistribucionBolsaDAO distribucionBolsaDAO  = new DistribucionBolsaDAO();
	private static Category cat = Category.getInstance(DistribucionBolsa.class);
	Global global = Global.getInstance();
	
	
    /** Metodos propios **/
	public DistribucionBolsaDTO obtenerDatosBolsa(String codPlanTarif) 
		throws ProductDomainException
	{
		cat.debug("Inicio:obtenerDatosBolsa()");
		DistribucionBolsaDTO resultado = distribucionBolsaDAO.obtenerDatosBolsa(codPlanTarif); 
		cat.debug("Fin:obtenerDatosBolsa()");
		return resultado;
	}//fin obtenerDatosBolsa
	
	public TipoPrestacionDTO validarPlanDist(Long codCliente)
		throws ProductDomainException
	{
		cat.debug("Inicio:obtenerDatosBolsa()");
		TipoPrestacionDTO resultado = distribucionBolsaDAO.validarPlanDist(codCliente); 
		cat.debug("Fin:obtenerDatosBolsa()");
		return resultado;
	}//fin obtenerDatosBolsa
	
	public PlanTarifarioDTO[] obtenerPlanesDistribuidos(Long numVenta) 
		throws ProductDomainException
	{
		cat.info("obtenerPlanesDistribuidos:star");
		PlanTarifarioDTO[]  resultado = distribucionBolsaDAO.obtenerPlanesDistribuidos(numVenta);
		cat.info("obtenerPlanesDistribuidos:star");		
		return resultado;
	} //obtenerPlanesDistribuidos
			
	public PlanTarifarioDTO[] obtenerPlanesDistribuidosAutomaticos(Long numVenta) 
		throws ProductDomainException
	{
		cat.info("obtenerPlanesDistribuidosAutomaticos:star");
		PlanTarifarioDTO[]  resultado = distribucionBolsaDAO.obtenerPlanesDistribuidosAutomaticos(numVenta);
		cat.info("obtenerPlanesDistribuidosAutomaticos:star");		
		return resultado;
	} //obtenerPlanesDistribuidos	
	
	/** Metodos traidos desde TOL**/ 
	public void installServiceBundle(ProductListDTO prodList) 
		throws TOLException 
	{
		cat.debug("installServiceBundle():start");
		distribucionBolsaDAO.installServiceBundle(prodList); 
		cat.debug("installServiceBundle():end");
	}//fin installServiceBundle
	
	
	public void createStorageAndFreeUnitStock(DistribucionBolsaDTO dto) 
		throws TOLException
	{
		cat.info("createStorageAndFreeUnitStock:star");
		distribucionBolsaDAO.createStorageAndFreeUnitStock(dto);
		cat.info("createStorageAndFreeUnitStock:end");
	}//fin createStorageAndFreeUnitStock
	           
	public void createStorageFreeUnitStock(DistribucionBolsaDTO dto) 
		throws TOLException
	{
		cat.info("createStorageFreeUnitStock:star");
		distribucionBolsaDAO.createStorageFreeUnitStock(dto);
		cat.info("createStorageFreeUnitStock:end");
	}//createStorageFreeUnitStock
	
	public void deleteStorageFreeUnitStock(DistribucionBolsaDTO dto) 
		throws TOLException
	{
		cat.info("deleteStorageFreeUnitStock:star");
		distribucionBolsaDAO.deleteStorageFreeUnitStock(dto);
		cat.info("deleteStorageFreeUnitStock:end");	
	}//deleteStorageFreeUnitStock
	
	
	public void deleteFreeUnitStock(DistribucionBolsaDTO dto) 
		throws TOLException
	{
		cat.info("deleteFreeUnitStock:star");	
		distribucionBolsaDAO.deleteFreeUnitStock(dto); 
		cat.info("deleteFreeUnitStock:end");		
	}//deleteFreeUnitStock
	
	public BolsaAbonadoDTO[] getFreeUnitStock(CustomerAccountDTO dto)
		throws TOLException
	{
		cat.info("getFreeUnitStock:star");		
		BolsaAbonadoDTO[] ArregloBolsaAbonado = distribucionBolsaDAO.getFreeUnitStock(dto);
		cat.info("getFreeUnitStock:end");
		return ArregloBolsaAbonado;				
	}//getFreeUnitStock
	
	public boolean setFreeUnitStock(DistribucionBolsaDTO dto) 
		throws TOLException
	{
		cat.info("setFreeUnitStock:star");
		boolean resultado = distribucionBolsaDAO.setFreeUnitStock(dto);
		cat.info("setFreeUnitStock:end");	
		return resultado;					
	}//setFreeUnitStock
	
	
	public void uninstallServiceBundle(ProductListDTO prodList)
		throws TOLException
	{
		cat.debug("uninstallServiceBundle():start");
		distribucionBolsaDAO.uninstallServiceBundle(prodList);
		cat.debug("uninstallServiceBundle():end");
	}//uninstallServiceBundle
	
	
	public void validServiceBundleAttributes(ProductListDTO prodList) 
		throws TOLException
	{
		cat.debug("validServiceBundleAttributes():start");
		distribucionBolsaDAO.validServiceBundleAttributes(prodList);
		cat.debug("validServiceBundleAttributes():end");
	}//	validServiceBundleAttributes
		
	
	public void modificaLimiteTOL(ProductListDTO prodList)
		throws TOLException
	{
		cat.debug("modificaLimiteTOL():start");
		distribucionBolsaDAO.modificaLimiteTOL(prodList);
		cat.debug("modificaLimiteTOL():end");
	}//modificaLimiteTOL
	
	
	public void createServiceBundleAttributes(ProductListDTO prodList)
		throws TOLException
	{
		cat.debug("createServiceBundleAttributes():start");
		distribucionBolsaDAO.createServiceBundleAttributes(prodList);
		cat.debug("createServiceBundleAttributes():end");
	}//createServiceBundleAttributes
	
	
	
	public LimiteClienteDTO getServiceLimitProfileValue(LimiteClienteDTO dto) 
		throws TOLException
	{
		cat.info("getServiceLimitProfileValue:star");
		LimiteClienteDTO resultado = distribucionBolsaDAO.getServiceLimitProfileValue(dto);
		cat.info("getServiceLimitProfileValue:star");		
		return resultado;
	} //getServiceLimitProfileValue
	
	
	
	
}//fin class DistribucionBolsa
