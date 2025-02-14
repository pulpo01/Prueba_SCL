package com.tmmas.scl.operations.crm.f.s.manpro.web.helper;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.log4j.Logger;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ControlDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.PaginaDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ValoresDefectoPaginaDTO;


public class ParseoXML {
	
	private final Logger logger = Logger.getLogger(ParseoXML.class);
	
	public ValoresDefectoPaginaDTO cargaXML(String dir){
		
		SAXBuilder builder = new SAXBuilder();
		Document doc = null;
		File fichero = new File(dir);
		
		try {
			doc = builder.build(fichero);
			
		} catch (JDOMException e) {
		
			e.printStackTrace();
		} catch (IOException e) {
		
			e.printStackTrace();
		}
	
		List listaPaginas = doc.getRootElement().getChild("informacion").getChild("ordenDeServicio").getChildren();
		
		ValoresDefectoPaginaDTO defecto=new ValoresDefectoPaginaDTO();	
		
		for (int contPag = 0; contPag<listaPaginas.size();contPag++){
			Element elemento = (Element)listaPaginas.get(contPag);
			
			defecto.getPaginas().put(elemento.getAttributeValue("id"), new PaginaDTO());
			
			List listaSecciones = elemento.getChildren();
			
			for(int contSecc=0; contSecc<listaSecciones.size();contSecc++){
				elemento = (Element)listaSecciones.get(contSecc);
				
				((PaginaDTO)defecto.getPaginas().get(elemento.getParentElement().getAttributeValue("id"))).addSeccion(elemento.getAttributeValue("id"), new SeccionDTO());
				
				List listaControles = ((Element)elemento.getChild("controles")).getChildren();
				for(int contCont=0; contCont<listaControles.size();contCont++){
					elemento = (Element)listaControles.get(contCont);
					
					((SeccionDTO)((PaginaDTO)defecto.getPaginas().get(elemento.getParentElement().getParentElement().getParentElement().getAttributeValue("id"))).getSecciones().get(elemento.getParentElement().getParentElement().getAttributeValue("id"))).addControl(elemento.getAttributeValue("id"), new ControlDTO());
					((ControlDTO)((SeccionDTO)((PaginaDTO)defecto.getPaginas().get(elemento.getParentElement().getParentElement().getParentElement().getAttributeValue("id"))).getSecciones().get(elemento.getParentElement().getParentElement().getAttributeValue("id"))).obtControl(elemento.getAttributeValue("id"))).setId(elemento.getAttributeValue("id"));
					((ControlDTO)((SeccionDTO)((PaginaDTO)defecto.getPaginas().get(elemento.getParentElement().getParentElement().getParentElement().getAttributeValue("id"))).getSecciones().get(elemento.getParentElement().getParentElement().getAttributeValue("id"))).obtControl(elemento.getAttributeValue("id"))).setValorDefecto(elemento.getChildText("valordefecto"));
					
					logger.debug("-------Parseando Controles--------");
					logger.debug("----------CONTROL-----------------");
					logger.debug(elemento.getAttributeValue("id"));
					logger.debug(elemento.getChildText("valordefecto"));
					logger.debug("PaginaPadre-----"+elemento.getParentElement().getParentElement().getAttributeValue("id"));
					logger.debug("SeccionPadre----"+elemento.getParentElement().getParentElement().getParentElement().getAttributeValue("id"));
					
				}
				
			}//fin for contSecc
				
		}//fin for contPag
		
		return defecto;
	}
	
	public SeccionDTO obtenerSeccion(ValoresDefectoPaginaDTO defpag, String pagina, String seccion){
		PaginaDTO paginaDTO= new PaginaDTO();
		SeccionDTO seccionDTO=new SeccionDTO();
		if(defpag!=null){
			paginaDTO = defpag.obtPagina(pagina);
			if (paginaDTO!=null){
				seccionDTO = paginaDTO.obtSeccion(seccion);
				if (seccionDTO!=null){
					return seccionDTO;
				}
			}
		}
		return null;
	}
	
}