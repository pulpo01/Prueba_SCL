package com.tmmas.cl.scl.gestiondeabonados.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dao.SerieDAO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.CantidadStockSerieDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SerieDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.NombreCalleDireccionDTO;

public class SerieBO {
	
	private SerieDAO serieDAO  = new SerieDAO();
	private static Category cat = Category.getInstance(SerieBO.class);
	Global global = Global.getInstance();
	
	public SerieDTO salidaDefinitivaSerie(SerieDTO serie)  
	throws GeneralException{
		cat.debug("Inicio:salidaDefinitivaSerie()");
		serie = serieDAO.salidaDefinitivaSerie(serie); 
		cat.debug("Fin:salidaDefinitivaSerie()");
		return serie;
	}//fin salidaDefinitivaSerie		
	
	public SerieDTO reservaSerie(SerieDTO serie)  
	throws GeneralException{
		cat.debug("Inicio:reservaSerie()");
		serie = serieDAO.reservaSerie(serie); 
		cat.debug("Fin:reservaSerie()");
		return serie;
	}//fin salidaDefinitivaSerie
	
	public SerieDTO desReservaSerie(SerieDTO serie)  
	throws GeneralException{
		cat.debug("Inicio:desReservaSerie()");
		serie = serieDAO.desReservaSerie(serie); 
		cat.debug("Fin:desReservaSerie()");
		return serie;
	}//fin salidaDefinitivaSerie	
	
	
	public CantidadStockSerieDTO getCantidadStockSerie(CantidadStockSerieDTO cantidadStockSerieDTO) throws GeneralException{
		cat.debug("Inicio:getCantidadStockSerie()");
		cantidadStockSerieDTO=serieDAO.getCantidadStockSerie(cantidadStockSerieDTO);
		cat.debug("cantidad stock: " + cantidadStockSerieDTO.getCantidadStock());
		cat.debug("Fin:getCantidadStockSerie()");
		
		return cantidadStockSerieDTO;
	}


}
