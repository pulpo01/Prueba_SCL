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
 * 05/04/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.portalventas.web.helper;

import java.io.IOException;
import java.io.Reader;
import java.io.Serializable;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Category;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

import com.tmmas.cl.framework.exception.FrameworkException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.commonbusinessentities.dto.CargoXMLDTO;

public class TraspasoXMLDescuentoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private final Category cat = Category.getInstance(TraspasoXMLDescuentoDTO.class);
	
	public TraspasoXMLDescuentoDTO(){
	}
	
		public boolean validaXML(String textoXML) {
	        try {
	        	SAXBuilder builder=new SAXBuilder();
	        	builder.setIgnoringElementContentWhitespace(true);
	        	builder.setValidation(true);
	        	Reader stringReader=new StringReader(textoXML);
	        	Document anotherDocument=builder.build(stringReader);
	        	cat.debug("XML tamaño" + anotherDocument.getContentSize()); 
	            return true;
	        } catch (JDOMException e) {
	            cat.info("JDOMException[" + e.getMessage() + "]");
	            e.printStackTrace();
	        } catch (NullPointerException e) {
	            cat.info("NullPointerException[" + e.getMessage() + "]");
	            e.printStackTrace();
	        } catch (IOException e) {
	            cat.info("JDOMException[" + e.getMessage() + "]");
	            e.printStackTrace();
	        }
	        return false;
	    }



	    public CargoXMLDTO[] retornaCamposDetalleFormatoSalidaXML(String textoXML)
	            throws IOException, JDOMException, Exception {

	        cat.info("retornaCamposDetalleFormatoSalidaXML:start");
	        cat.info("textoXML : " + textoXML);
	        // parseo el xml
	        SAXBuilder builder = new SAXBuilder();
	        Document doc = null;
	        try {
	            cat.debug("Parseando xml...");
	            Reader stringReader=new StringReader(textoXML);
	        	doc=builder.build(stringReader);
	        	
	            cat.debug("Parseando xml fin...");
	        } catch (JDOMException e) {
	            cat.debug("JDOMException[" + e.getMessage() + "]");
	            e.printStackTrace();
	            throw new FrameworkException(e);
	        } catch (IOException e) {
	            cat.debug("IOException[" + e.getMessage() + "]");
	            e.printStackTrace();
	            throw new FrameworkException(e);
	        }

	        Element root = doc.getRootElement();

	        // Procedo a cargar detalle
	        try{
	            cat.debug("CargarDetalleSalida():start");
	            CargoXMLDTO[] listaDetailFile = CargarDetalleSalida(root);
	            cat.debug("CargarDetalleSalida():stop");
	            cat.info("retornaCamposDetalleFormatoSalidaXML:stop");
	            return listaDetailFile;
	        }catch (Exception e){
	            cat.info("retornaCamposDetalleFormatoSalidaXML:stop with errors");
	            cat.info("Exception : " + e.getMessage());
	            throw new Exception(e);
	        }
	    }

	    private CargoXMLDTO[] CargarDetalleSalida(Element elemento)
	            throws FrameworkException {
	        cat.debug("CargarDetalleSalida():start");
	        // Se parsea el xml de configuracion para el detalle
	        List listaDetailFile = new ArrayList();
	        List cargos = elemento.getChildren("cargo");
	        cat.debug("Numero de campos[" + cargos.size() + "]");
	        CargoXMLDTO detalleCargo = null;
	        for (int i = 0; i < cargos.size(); i++) {
	            detalleCargo = BuscarCampoSalida(cargos, i);
	            if (detalleCargo == null) 
	                cat.debug("Problema en la configuracion del xml al buscar los campos");
	           
	            cat.debug("Cargando campo[" + (i + 1) + "]");
	            listaDetailFile.add(detalleCargo);
	        }
	        cat.debug("CargarDetalleSalida():end");
	        CargoXMLDTO[]  listadoCargos =(CargoXMLDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaDetailFile.toArray(), CargoXMLDTO.class); 
	        return listadoCargos;

	    }

	    private CargoXMLDTO BuscarCampoSalida(List campos, int i) {
	        cat.debug("BuscarCampoSalida():start");
	        cat.debug("Buscando Campo Salida()[" + i + "]");
	        CargoXMLDTO detalleCargo = null;
	        Iterator it = campos.iterator();
	        int id = 0;
	        while (it.hasNext()) {
	        	Element cargo= (Element)it.next();
	            if (id == i) {
	                cat.debug("----Campo encontrado----");
	                detalleCargo = new CargoXMLDTO();
	                Element montoDescuentoManual =cargo.getChild("montoDescuentoManual");
	                float valorDctoManual = montoDescuentoManual.getText().equals("")?0.0f:Float.parseFloat(montoDescuentoManual.getText());
	                detalleCargo.setMontoDescuentoManual(valorDctoManual);
	                Element tipoDescuentoManual =cargo.getChild("tipoDescuentoManual");
	                detalleCargo.setTipoDescuentoManual(tipoDescuentoManual.getText());
	                Element infringeRangoDescuento =cargo.getChild("infringeRangoDescuento");
	                detalleCargo.setInfringeRangoDescuento(infringeRangoDescuento.getText());
	                cat.debug("----Campo encontrado Fin----");
	                break;
	            }
	            id++;
	        }
	        cat.debug("BuscarCampoSalida():end");
	        return detalleCargo;
	    }
	


}
