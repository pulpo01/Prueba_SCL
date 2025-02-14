package com.tmmas.cl.scl.gestiondeabonados.businessobject.bo;

import java.io.Serializable;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dao.SerieKitDAO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SerieKitDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SimcardSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TerminalSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;

public class SerieKitBO {
	
	private SerieKitDAO SerieKit = new SerieKitDAO();
	private static Category cat = Category.getInstance(SerieKitBO.class);
	Global global = Global.getInstance();
	
	public SerieKitDTO validaSerieKit(SerieKitDTO serieKit)
	throws GeneralException{
		cat.debug("Inicio:validaSerieKit()");
		serieKit = SerieKit.validaSerieKit(serieKit); 
		cat.debug("Fin:validaSerieKit()");
		return serieKit;
	}	
	
	public SimcardSNPNDTO getSerieSimcardKit(SerieKitDTO serieKit) 
	throws GeneralException{
		cat.debug("Inicio:getSerieSimcardKit()");
		SimcardSNPNDTO serieSimKit = SerieKit.getSerieSimcardKit(serieKit); 
		cat.debug("Fin:getSerieSimcardKit()");
		return serieSimKit;
	}	
	
	public TerminalSNPNDTO getSerieTerminalKit(SerieKitDTO serieKit) 
	throws GeneralException{
		cat.debug("Inicio:getSerieTerminalKit()");
		TerminalSNPNDTO serieTermKit = SerieKit.getSerieTerminalKit(serieKit); 
		cat.debug("Fin:getSerieTerminalKit()");
		return serieTermKit;
	}	

}
