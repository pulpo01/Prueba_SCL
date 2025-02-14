package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.commonbusinessentities.dto.ws.FacturaInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.FacturaOutDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.FacturaDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CobroAdelantadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FacturaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FolioDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ProrrateoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;
                     
public class Factura extends CustomerAccountProductInvolvement{
	Global global = Global.getInstance();
	private static Category cat = Category.getInstance(Factura.class);
	private FacturaDAO facturaDAO  = new FacturaDAO();

	/**
	 * Obtiene los datos de la factura 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public FacturaOutDTO getPathFactura(FacturaInDTO entrada) 
		throws CustomerDomainException
	{		   
			cat.debug("Inicio:getPathFactura()");			
			FacturaOutDTO resultado= new FacturaOutDTO();			  
			cat.debug("getPathFactura:Llamado a funciones antes");			
			  
			//recupera nombre de la factura
			resultado.setNombrePDF(facturaDAO.getNombrePDFFactura(entrada.getFolio()));
			//recupera path de la factura
			resultado.setRutaPDF(facturaDAO.getPathPDFFactura());
			cat.debug("getPathFactura:funciones Despues");
			  
		return resultado;
	}

	public FacturaDTO getDatosCicloFacturacion()
		throws CustomerDomainException
	{
		cat.debug("getDatosCicloFacturacion():start");
		FacturaDTO facturaDTO =  facturaDAO.getDatosCicloFacturacion();
		cat.debug("getDatosCicloFacturacion():end");
		return facturaDTO;
	}
	
	public FolioDTO getFolio(FolioDTO entrada)
		throws CustomerDomainException
	{
		cat.debug("getFolio():start");
		FolioDTO folioDTO=new FolioDTO();
		folioDTO =  facturaDAO.getFolio(entrada);
		cat.debug("getFolio():end");
		return folioDTO;
	}
	
	public ProrrateoDTO getProrrateo(ProrrateoDTO entrada)
		throws CustomerDomainException
	{
		cat.debug("getProrrateo():start");		
		ProrrateoDTO resultado = facturaDAO.getProrrateo(entrada);
		cat.debug("getProrrateo():end");
		return resultado;
	}
	
	public void insertaCobroAdelantado(CobroAdelantadoDTO entrada)
		throws CustomerDomainException
	{
		cat.debug("insertaCobroAdelantado():start");		
		facturaDAO.insertaCobroAdelantado(entrada);
		cat.debug("insertaCobroAdelantado():end");		
	}
	
	public PrecioDTO obtenerMontoImporteCargoRec(Long codCargo)
		throws CustomerDomainException
	{
		cat.debug("obtenerMontoImporteCargoRec():start");		
		PrecioDTO resultado = facturaDAO.obtenerMontoImporteCargoRec(codCargo);
		cat.debug("obtenerMontoImporteCargoRec():end");	
		return resultado;
	}

	
}
