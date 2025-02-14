package com.tmmas.scl.operations.frmkooss.web.businessObject.dao;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

import com.tmmas.scl.framework.commonDoman.dataTransferObject.ControlDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.PaginaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.SeccionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ValoresJSPPorDefectoDTO;


public class ParseoXML {
	
	
	public ValoresJSPPorDefectoDTO cargaXML(String dir){
		
		SAXBuilder builder = new SAXBuilder();
		Document doc = null;
		//System.out.println("dir="+dir);
		File fichero = new File(dir);
		
		/*
		URL url = null;
		try{
		url = fichero.toURL();
		}catch (MalformedURLException e){
			
		}
		System.out.println("Objeto URL: " + url);
		*/
		
		try {
			doc = builder.build(fichero);
			
		} catch (JDOMException e) {
		
			e.printStackTrace();
		} catch (IOException e) {
		
			e.printStackTrace();
		}
		/*
		Element elem=doc.getRootElement();
		Element elem2=elem.getChild("informacion");
		Element elem3=elem2.getChild("ordenDeServicio");
		List elementos =elem3.getChildren();
		*/
				
		/*
		List ordenes = doc.getRootElement().getChild("informacion").getChildren();
		
		for (int contOS = 0; contOS<ordenes.size();contOS++){
			Element ordenServicio = (Element)ordenes.get(contOS);
			if (ordenServicio.getAttributeValue("id").equalsIgnoreCase("OS1")){
				List listaPaginas = ordenServicio.getChildren();
			}
		}
		
		*/
		
	
		List listaPaginas = doc.getRootElement().getChild("informacion").getChild("ordenDeServicio").getChildren();
		
		ValoresJSPPorDefectoDTO defecto=new ValoresJSPPorDefectoDTO();	
		
		for (int contPag = 0; contPag<listaPaginas.size();contPag++){
			Element elemento = (Element)listaPaginas.get(contPag);
			
			//System.out.println("----------PAGINA-----------------");
			//System.out.println(elemento.getAttributeValue("id"));
			
			defecto.getPaginas().put(elemento.getAttributeValue("id"), new PaginaDTO());
			
			List listaSecciones = elemento.getChildren();
			
			for(int contSecc=0; contSecc<listaSecciones.size();contSecc++){
				elemento = (Element)listaSecciones.get(contSecc);
				
				//System.out.println("----------SECCION-----------------");
				//System.out.println(elemento.getAttributeValue("id"));
				//System.out.println(elemento.getAttributeValue("visible"));
				//System.out.println("PaginaPadre------"+elemento.getParentElement().getAttributeValue("id"));
				/*
				Map mapPag = defecto.getPaginas();
				PaginaDTO paginaDTO= (PaginaDTO)mapPag.get(elemento.getParentElement().getAttribute("id"));
				paginaDTO.addSeccion(elemento.getAttributeValue("id"), new SeccionDTO());
				*/
				((PaginaDTO)defecto.getPaginas().get(elemento.getParentElement().getAttributeValue("id"))).addSeccion(elemento.getAttributeValue("id"), new SeccionDTO());
				((SeccionDTO)((PaginaDTO)defecto.getPaginas().get(elemento.getParentElement().getAttributeValue("id"))).getSecciones().get(elemento.getAttributeValue("id"))).setVisible(elemento.getAttributeValue("visible"));
				
				List listaControles = ((Element)elemento.getChild("controles")).getChildren();
				for(int contCont=0; contCont<listaControles.size();contCont++){
					elemento = (Element)listaControles.get(contCont);
					//System.out.println("Parseando Controles");
					//System.out.println("----------CONTROL-----------------");
					//System.out.println(elemento.getAttributeValue("id"));
					//System.out.println(elemento.getAttributeValue("tipo"));
		
					//System.out.println((elemento.getChildText("habilitado")));
					//System.out.println((elemento.getChildText("visible")));
					//System.out.println((elemento.getChildText("valordefecto")));
					//System.out.println("PaginaPadre-----"+elemento.getParentElement().getParentElement().getAttributeValue("id"));
					//System.out.println("SeccionPadre----"+elemento.getParentElement().getParentElement().getParentElement().getAttributeValue("id"));
				
					
					((SeccionDTO)((PaginaDTO)defecto.getPaginas().get(elemento.getParentElement().getParentElement().getParentElement().getAttributeValue("id"))).getSecciones().get(elemento.getParentElement().getParentElement().getAttributeValue("id"))).addControl(elemento.getAttributeValue("id"), new ControlDTO());
					((ControlDTO)((SeccionDTO)((PaginaDTO)defecto.getPaginas().get(elemento.getParentElement().getParentElement().getParentElement().getAttributeValue("id"))).getSecciones().get(elemento.getParentElement().getParentElement().getAttributeValue("id"))).obtControl(elemento.getAttributeValue("id"))).setId(elemento.getAttributeValue("id"));
					((ControlDTO)((SeccionDTO)((PaginaDTO)defecto.getPaginas().get(elemento.getParentElement().getParentElement().getParentElement().getAttributeValue("id"))).getSecciones().get(elemento.getParentElement().getParentElement().getAttributeValue("id"))).obtControl(elemento.getAttributeValue("id"))).setTipo(elemento.getAttributeValue("tipo"));
					((ControlDTO)((SeccionDTO)((PaginaDTO)defecto.getPaginas().get(elemento.getParentElement().getParentElement().getParentElement().getAttributeValue("id"))).getSecciones().get(elemento.getParentElement().getParentElement().getAttributeValue("id"))).obtControl(elemento.getAttributeValue("id"))).setHabilitado(elemento.getChildText("habilitado"));
					((ControlDTO)((SeccionDTO)((PaginaDTO)defecto.getPaginas().get(elemento.getParentElement().getParentElement().getParentElement().getAttributeValue("id"))).getSecciones().get(elemento.getParentElement().getParentElement().getAttributeValue("id"))).obtControl(elemento.getAttributeValue("id"))).setVisible(elemento.getChildText("visible"));
					((ControlDTO)((SeccionDTO)((PaginaDTO)defecto.getPaginas().get(elemento.getParentElement().getParentElement().getParentElement().getAttributeValue("id"))).getSecciones().get(elemento.getParentElement().getParentElement().getAttributeValue("id"))).obtControl(elemento.getAttributeValue("id"))).setValorDefecto(elemento.getChildText("valordefecto"));
				}
				
			}
				
		}
		
		return defecto;
	
	}
	
	
	
}
