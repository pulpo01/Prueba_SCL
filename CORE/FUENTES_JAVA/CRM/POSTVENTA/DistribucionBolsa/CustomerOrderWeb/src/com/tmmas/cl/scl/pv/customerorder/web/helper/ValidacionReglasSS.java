package com.tmmas.cl.scl.pv.customerorder.web.helper;

import java.util.ArrayList;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ReglasSSDTO;

public class ValidacionReglasSS {

	private Category logger = Category.getInstance(ValidacionReglasSS.class);
	
	private CompositeConfiguration config;
	
	private void ValidacionReglasSS() {
		setPropertieFile();
	}
	
	
	
	private void setPropertieFile() {
		String strRuta = "/com/tmmas/cl/CustomerOrderWeb/web/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strArchivoProperties= "CustomerOrderWeb.properties";
		String strArchivoLog="CustomerOrderWeb.log";
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
	
		config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		
		UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		logger.debug("Inicio CommentariesAction");

	}
	
	
	public ProductDTO[] ValidaCheckedSS(ReglasSSDTO[] reglas,ProductDTO[] installes, ProductDTO[] unInstalles, 
			ProductDTO producto, StringBuffer incompatible)
	{
		int i;
		StringBuffer incompaso = new StringBuffer();
		ProductDTO lig = null;
		ArrayList listaLigadura = new ArrayList();
		ProductDTO ligaduras[];
		if(validaIncompatibles(reglas,installes,producto.getId(),incompatible)){
			lig = new ProductDTO();
			lig.setId(producto.getId());		
			listaLigadura.add(lig);
			for (i=0; i<reglas.length; i++){
				logger.debug("producto.getId()=["+producto.getId()+"] -- reglas[i].getCodServicio()=["+reglas[i].getCodServicio()+"] -- reglas[i].getTipoRelacion()["+reglas[i].getTipoRelacion()+"]");
			    if( producto.getId().equals(reglas[i].getCodServicio()) && reglas[i].getTipoRelacion() == 1){			    	
			    	if(validaIncompatibles(reglas,installes,reglas[i].getCodServDef(), incompaso) && validaExistencia(unInstalles, reglas[i].getCodServDef() )){
			    		logger.debug("LIGADURA--"+reglas[i].getCodServDef());
			    		lig = new ProductDTO();
			    		lig.setId(reglas[i].getCodServDef());			    			
			    		listaLigadura.add(lig);
			    	}			   
			    }			
			}
		}
		ligaduras = (ProductDTO[])listaLigadura.toArray(new ProductDTO[listaLigadura.size()]);
		return ligaduras;
	}
	
	public ProductDTO[] ValidaUnCheckedSS(ReglasSSDTO[] reglas,ProductDTO[] installes, ProductDTO producto, ProductDTO[] unInstalles)
	{		
		ProductDTO tranferencia[];
		int i;
		ArrayList listaTranferencia = new ArrayList();

		
		for (i=0; i<reglas.length; i++){
			logger.debug("producto.getId()=["+producto.getId()+"] -- reglas[i].getCodServicio()=["+reglas[i].getCodServicio()+"] -- reglas[i].getTipoRelacion()["+reglas[i].getTipoRelacion()+"]");		
		    if( producto.getId().equals(reglas[i].getCodServicio()) && reglas[i].getTipoRelacion() == 2 && validaExistencia(unInstalles, reglas[i].getCodServDef() )){
		    	logger.debug("Tranferencia--"+reglas[i].getCodServDef());
	    		ProductDTO lig = new ProductDTO();
	    		lig.setId(reglas[i].getCodServDef());			    			
	    		listaTranferencia.add(lig);
	    		
		    }			
		}
		tranferencia = (ProductDTO[])listaTranferencia.toArray(new ProductDTO[listaTranferencia.size()]);
		return tranferencia;
	}

	private boolean validaIncompatibles(ReglasSSDTO[] reglas, ProductDTO[] installes, String producto, StringBuffer incompatible )
	{	
				
		int i;
		int j;
		incompatible.append("");
		
		for (i=0; i<installes.length; i++){	
			for (j=0; j<reglas.length; j++){	
				logger.debug("installes[i].getId() = reglas[j].getCodServicio() = "+installes[i].getId()+"  -- "+reglas[j].getCodServicio());
				logger.debug("reglas[j].getTipoRelacion() = 3 ["+reglas[j].getTipoRelacion()+"]");
				logger.debug("reglas[j].getCodServDef() = producto -- "+reglas[j].getCodServDef()+" -- "+producto);
			    if( installes[i].getId().equals(reglas[j].getCodServicio()) && reglas[j].getTipoRelacion() == 3 && reglas[j].getCodServDef().equalsIgnoreCase(producto)){
			    
			    	if (incompatible.length() > 0){
			    		incompatible.append(", "+installes[i].getId());
			    	}else{
			    		incompatible.append(installes[i].getId());
			    	}
			    }
			}
			
	    }
		if(incompatible.length() > 0){
			return false;
		}else{
			return true;
		}
	}
	
	private boolean validaExistencia(ProductDTO[] unInstalles, String producto )
	{	
		
		int i;
		for (i=0; i<unInstalles.length; i++){	
			logger.debug("unInstalles[i].getId() = producto--"+unInstalles[i].getId()+" -- "+producto);
			if( unInstalles[i].getId().equalsIgnoreCase(producto)){
				logger.debug("return true");
                return true;   
			}				
	    } 		
		return false; 		
	}	
}
