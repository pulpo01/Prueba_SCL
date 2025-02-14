package com.tmmas.cl.scl.ss911correofax.negocio.web.action;

import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.ss911correofax.dto.CodigosDTO;
import com.tmmas.cl.scl.ss911correofax.dto.ContactoAbonadoTT;
import com.tmmas.cl.scl.ss911correofax.dto.DireccionDTO;
import com.tmmas.cl.scl.ss911correofax.dto.GaContactoAbonadoToDTO;
import com.tmmas.cl.scl.ss911correofax.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.ss911correofax.negocio.web.delegate.ServSupl911CorreoFaxDelegate;
import com.tmmas.cl.scl.ss911correofax.negocio.web.form.Contactos911Form;

public class Contactos911Action extends BaseAction {
	protected Logger logger=Logger.getLogger(this.getClass());
	private CompositeConfiguration config;
	private ServSupl911CorreoFaxDelegate delegate = ServSupl911CorreoFaxDelegate
			.getInstance();

	protected ActionForward executeAction(ActionMapping actionMapping,ActionForm actionForm, HttpServletRequest httpServletRequest,	HttpServletResponse httpServletReponse) throws Exception {
		logger.info("executeAction:start");
		logger.info("opcion = "+httpServletRequest.getParameter("opcion"));
		String opcion = (httpServletRequest.getParameter("opcion")==null?"inicio":(String)httpServletRequest.getParameter("opcion"));
		if (opcion.equalsIgnoreCase("inicio")) {
			String matrizContactos = new String();
			HttpSession session = httpServletRequest.getSession(false);
			config = UtilProperty
					.getConfiguration(
							"ServSupl911CorreoFax.properties",
							"com/tmmas/cl/scl/ss911correofax/negocio/web/properties/webpropiedades.properties");
			String url = config.getString("url.componente.direcciones");
			session.setAttribute("url.componente.direcciones", url);

			CodigosDTO param = new CodigosDTO();
			param.setCodigoModulo("GA");
			param.setTabla("GA_CONTACTO_ABONADO_TO");
			param.setColumna("COD_PARENTESCO");
			CodigosDTO[] lista = delegate.getListCodigos(param);

			session.setAttribute("listaParentesco", lista);

			// (santiago ventura OOSS-MCSA911 26-03-2010)
			// Se obtiene el parametro from que indica el origen de la llamada al
			// componente			
			String numAbonado = new String("");
			String userName = new String("");
			ContactoAbonadoTT[] contactoAbonadoTTs = new ContactoAbonadoTT[0];
			
//			Obtiene valores de los grupos especiales 911 - FAX - CORREO MOVISTAR
			ParametrosGeneralesDTO largoNumTelefono = new ParametrosGeneralesDTO();
			largoNumTelefono.setCodigoproducto(config.getString("codigo.producto"));
			largoNumTelefono.setCodigomodulo(config.getString("codigo.modulo.VE"));
			largoNumTelefono.setNombreparametro("LARGO_N_TELECONTACTO");
			largoNumTelefono = delegate.getParametroGeneral(largoNumTelefono);
			session.setAttribute("icgLargoNumTelefono", largoNumTelefono.getValorparametro());
			
			String codServicio = new String();
			if (httpServletRequest.getParameter("numAbonado") != null && httpServletRequest.getParameter("codServicio") != null&& httpServletRequest.getParameter("userName") != null) {
				numAbonado = (String) httpServletRequest.getParameter("numAbonado");
				codServicio = (String) httpServletRequest.getParameter("codServicio");
				userName = (String) httpServletRequest.getParameter("userName");
				
				session.setAttribute("numAbonado", numAbonado);
				session.setAttribute("codServicio", codServicio);
				session.setAttribute("userName", userName);
				session.setAttribute("flgMantimiento", "SI");
				
				ContactoAbonadoTT contAbonTT = new ContactoAbonadoTT();
				contAbonTT.setNumAbonado(Long.parseLong(numAbonado));
				contAbonTT.setCodServicio(codServicio);
				contactoAbonadoTTs = delegate.obtenerListaContactos(contAbonTT);
				if (contactoAbonadoTTs!=null && contactoAbonadoTTs.length>0){
					matrizContactos = generaMatrizContactos(contactoAbonadoTTs, session);
				}
			} else {
				session.setAttribute("flgMantimiento", "NO");
			}

			session.setAttribute("matrizContactos", matrizContactos);
			logger.info("executeAction:end");
		} else if (opcion.equalsIgnoreCase("grabar")) {
			grabar(actionMapping, actionForm, httpServletRequest, httpServletReponse);
			opcion = "cerrar";
		}

		return actionMapping.findForward(opcion);
	}
	
	
	protected void grabar(ActionMapping actionMapping,ActionForm actionForm, HttpServletRequest httpServletRequest,HttpServletResponse httpServletReponse) throws Exception {
		logger.info("grabar:start");		
		eliminarAgregarContacto(actionMapping,actionForm, httpServletRequest,httpServletReponse);
		logger.info("grabar:end");		
	}
	
	
	
	private void eliminarAgregarContacto(ActionMapping actionMapping,ActionForm actionForm, HttpServletRequest httpServletRequest,HttpServletResponse httpServletReponse) throws Exception {
		logger.info("eliminarAgregarContacto:start");
		HttpSession session = httpServletRequest.getSession(false);	
		Contactos911Form contactos911Form = (Contactos911Form)actionForm;
		String contactosTabla = contactos911Form.getContactosTabla();
		String numAbonado = (String)session.getAttribute("numAbonado");
		ContactoAbonadoTT[] contactoAbonadoTTs = new ContactoAbonadoTT[0];
		contactoAbonadoTTs = generarArregloContactoAbonadoTT(contactosTabla,numAbonado,session);
		if (contactoAbonadoTTs.length>0) {
			delegate.deleteInsertPvContactoAbonadoTT(contactoAbonadoTTs);
		}		
		logger.info("eliminarAgregarContacto:end");
	}
	


	private ContactoAbonadoTT[] generarArregloContactoAbonadoTT(String contactosTabla, String numAbonado, HttpSession session) throws Exception{
		logger.info("generarArregloContactoAbonadoTT:start");
		ContactoAbonadoTT[] contactoAbonadoTTs = null;
		ContactoAbonadoTT contactoAbonadoTT = null;
		logger.info("contactosTabla = "+contactosTabla);
		
		contactosTabla = contactosTabla.replaceAll("undefined","");
		contactosTabla = contactosTabla.replaceAll("]\\,\\[","]|[");
		logger.info("contactosTabla = "+contactosTabla);
    	String tknPipeStr = "|";
    	StringTokenizer stzTokenPipe = new StringTokenizer(contactosTabla, tknPipeStr);
    	String usuarioAbonado = (session.getAttribute("usuarioAbonado")==null?"":(String)session.getAttribute("usuarioAbonado"));
    	String userName = (session.getAttribute("userName")==null?"":(String)session.getAttribute("userName"));
    	//contactoAbonadoTTs = new ContactoAbonadoTT[stzTokenPipe.countTokens()];
    	/*logger.info("contactoAbonadoTTs.length : " + contactoAbonadoTTs.length); 
    	String[] splitMtzContactos = new String[stzTokenPipe.countTokens()];
    	int index = 0;
        while(stzTokenPipe.hasMoreElements()) {
        	splitMtzContactos[index++] = stzTokenPipe.nextToken();
        }*/
        /***************************************************/
     
        StringTokenizer stlistContactos= new StringTokenizer(contactosTabla,"¬");
		String[] listaContactosA=new String[stlistContactos.countTokens()];
		contactoAbonadoTTs = new ContactoAbonadoTT[stlistContactos.countTokens()];
		ArrayList lstContactos=new ArrayList();
		int idx=0;
		while(stlistContactos.hasMoreTokens()){
			listaContactosA[idx]= stlistContactos.nextToken();
			idx++;
		}
		
		StringTokenizer st=null;
		if (listaContactosA.length>0)
		{
			for(int i=0;i<listaContactosA.length;i++){
				st=new StringTokenizer(listaContactosA[i],"|");
				String[] contacto=new String[st.countTokens()];
				idx=0;
				while (st.hasMoreTokens())
				{
					contacto[idx]=(String)st.nextToken();
					idx++;
				}
				int pos=i+1;
				contacto[9]=String.valueOf(pos);
				GaContactoAbonadoToDTO contactoAbonadoToDTO = new GaContactoAbonadoToDTO();
	        	contactoAbonadoToDTO.setNumAbonado(Long.parseLong(numAbonado));
	        	
	        	//obj.apellido1Contacto= tblContactos[i][0]; 
	    		// apellido1Contacto 
	    		contactoAbonadoToDTO.setApellido1Contacto(contacto[0]==null?"":contacto[0].replaceAll("'", ""));
	    		contactoAbonadoToDTO.setApellido2Contacto(contacto[10]==null?"":contacto[10].replaceAll("'", ""));
	    		
	        	//obj.nombreContacto = tblContactos[i][1]; 
	    		// nombreContacto 
	    		contactoAbonadoToDTO.setNombreContacto(contacto[1]==null?"":contacto[1].replaceAll("'", ""));
	    		
	        	//obj.codParentesco = tblContactos[i][2];
	    		// codParentesco
	    		contactoAbonadoToDTO.setCodParentesco(contacto[2]==null?"":contacto[2].replaceAll("'", ""));
	    		
	        	//obj.telefono = tblContactos[i][3];
	    		// telefono 
	    		String telf = (contacto[3]==null?"0":contacto[3].replaceAll("'", ""));
	    		contactoAbonadoToDTO.setTelefono(Long.parseLong(telf));
	    		
	        	//obj.placaVehicular = tblContactos[i][4];
	    		// placaVehicular 
	    		contactoAbonadoToDTO.setPlacaVehicular(contacto[4]==null?"":contacto[4].replaceAll("'", ""));
	    		
	        	//obj.colorVehiculo = tblContactos[i][5];    
	    		// colorVehiculo	
	    		contactoAbonadoToDTO.setColorVehiculo(contacto[5]==null?"":contacto[5].replaceAll("'", ""));
	    		
	        	//obj.anioVehiculo = tblContactos[i][6];    
	    		// anioVehiculo 	
	    		contactoAbonadoToDTO.setAnioVehiculo(Long.parseLong(contacto[6]==null?"0":contacto[6].replaceAll("'", "")));
	    		
	        	//obj.codDireccion = tblContactos[i][7];     
	    		// codDireccion 
	    		contactoAbonadoToDTO.setCodDireccion(Long.parseLong(contacto[11]==null||"".equals(contacto[12])?"0":contacto[11].replaceAll("'", "")));    		
	    		 
	    		DireccionDTO direccionDTO = new DireccionDTO();    		
	        	//obj.codProvincia = tblContactos[i][8];
	    		// codProvincia 
	    		String codProvincia = contacto[12];
	    		codProvincia=codProvincia==null?"":codProvincia;
	    		direccionDTO.setCodProvincia(codProvincia.replaceAll("'", ""));    	
	    		
	        	//obj.codRegion = tblContactos[i][9];
	    		String codRegion=contacto[13];
	    		codRegion=codRegion==null?"":codRegion;
	    		direccionDTO.setCodRegion(codRegion.replaceAll("'", ""));
	    		
	        	//obj.codCiudad = tblContactos[i][10];
	    		String codCiudad=contacto[14];
	    		codCiudad=codCiudad==null?"":codCiudad;
	    		direccionDTO.setCodCiudad(codCiudad.replaceAll("'", ""));
	    		
	        	//obj.codComuna = tblContactos[i][11];
	    		String codComuna=contacto[15];
	    		codComuna=codComuna==null?"":codComuna;
	    		direccionDTO.setCodComuna(codComuna.replaceAll("'", ""));
	    		
	        	//obj.nomCalle = tblContactos[i][12];
	    		String nomCalle= contacto[16];
	    		nomCalle=nomCalle==null?"":nomCalle;
	    		direccionDTO.setNomCalle(nomCalle.replaceAll("'", ""));
	    		
	        	//obj.numCalle = tblContactos[i][13];
	    		String numCalle= contacto[17];
	    		numCalle=numCalle==null?"":numCalle;
	    		direccionDTO.setNumCalle(numCalle.replaceAll("'", ""));
	    		
	        	//obj.numPiso = tblContactos[i][14];
	    		String numPiso= contacto[18];
	    		numPiso=numPiso==null?"":numPiso;
	    		
	    		direccionDTO.setNumPiso(numPiso.replaceAll("'", ""));
	    		
	        	//obj.numCasilla = tblContactos[i][15];
	    		String numCasilla=contacto[19];
	    		numCasilla=numCasilla==null?"":numCasilla;
	    		direccionDTO.setNumCasilla(numCasilla.replaceAll("'", ""));
	    		
	        	//obj.obsDireccion = tblContactos[i][16];
	    		String obsDireccion=contacto[20];
	    		obsDireccion=obsDireccion==null?"":obsDireccion;
	    		direccionDTO.setObsDireccion(obsDireccion.replaceAll("'", ""));
	    		
	        	//obj.desDirec1 = tblContactos[i][17];
	    		String desDirec1=contacto[21];
	    		desDirec1=desDirec1==null?"":desDirec1;
	    		direccionDTO.setDesDirec1(desDirec1.replaceAll("'", ""));
	    		
	    		String desDirec2=contacto[22];
	    		desDirec2=desDirec2==null?"":desDirec2;
	    		direccionDTO.setDesDirec2(desDirec2.replaceAll("'", ""));
	    		
	        	//obj.codPueblo = tblContactos[i][18];
	    		String codPueblo=contacto[23];
	    		codPueblo=codPueblo==null?"":codPueblo;
	    		direccionDTO.setCodPueblo(codPueblo.replaceAll("'", ""));
	    		
	        	//obj.codEstado = tblContactos[i][19];
	    		String codEstado=contacto[23];
	    		codEstado=codEstado==null?"":codEstado;
	    		direccionDTO.setCodEstado(codEstado.replaceAll("'", ""));
	    		
	        	//obj.zip = tblContactos[i][20];    
	    		String zip=contacto[25];
	    		zip=zip==null?"":zip;
	    		direccionDTO.setZip(zip.replaceAll("'", ""));
	    		
	        	//obj.codTipoCalle = tblContactos[i][21];    
	    		String codTipoCalle=contacto[26];
	    		codTipoCalle=codTipoCalle==null?"":codTipoCalle;
	    		direccionDTO.setCodTipoCalle(codTipoCalle.replaceAll("'", ""));
	    		
	        	//obj.desDireccion = tblContactos[i][22];
	    		//direccionDTO.setDesDirec1(contacto[22].replaceAll("'", ""));
	    		contactoAbonadoToDTO.setNomUsuarora(userName);
	    		contactoAbonadoToDTO.setIndVigente("1");
	    	 
	    		String codServicio = (String)session.getAttribute("codServicio");
	    		contactoAbonadoToDTO.setCodServicio(codServicio);
	    		long num_contacto = Long.parseLong(contacto[9].replaceAll("'", ""));
	    		contactoAbonadoToDTO.setNumContacto(num_contacto);
	    		contactoAbonadoTT= new ContactoAbonadoTT();
	    		contactoAbonadoTT.setNumAbonado(Long.parseLong(numAbonado));
	    		contactoAbonadoTT.setCodServicio(codServicio);
	    		contactoAbonadoTT.setContactoAbonadoToDTOs(contactoAbonadoToDTO);
	    		contactoAbonadoTT.setDireccionDTO(direccionDTO);    		
	    		contactoAbonadoTTs[i] = contactoAbonadoTT;
			}
			
			
		}
		
        
		 /***************************************************/
     /*   for(index=0; index < contactos.length; index++) {
        	contactoAbonadoTT = new ContactoAbonadoTT();
        	contactoAbonadoTT.setNumAbonado(Long.parseLong(numAbonado));        	        	        	
        	
        	splitMtzContactos[index] = splitMtzContactos[index].replaceAll("\\[", "");
        	splitMtzContactos[index] = splitMtzContactos[index].replaceAll("]", "");  
        	logger.info("Tokenizer : " + splitMtzContactos[index]);
        	//String[] contacto = splitMtzContactos[index].split(",");
        	
        	logger.info("contacto.length : " + contactos.length);
        	 
        	/*GaContactoAbonadoToDTO contactoAbonadoToDTO = new GaContactoAbonadoToDTO();
        	contactoAbonadoToDTO.setNumAbonado(Long.parseLong(numAbonado));
        	
        	//obj.apellido1Contacto= tblContactos[i][0]; 
    		// apellido1Contacto 
    		contactoAbonadoToDTO.setApellido1Contacto(contactos[index][0]==null?"":contactos[index][0].replaceAll("'", ""));
    		
        	//obj.nombreContacto = tblContactos[i][1]; 
    		// nombreContacto 
    		contactoAbonadoToDTO.setNombreContacto(contactos[index][1]==null?"":contactos[index][1].replaceAll("'", ""));
    		
        	//obj.codParentesco = tblContactos[i][2];
    		// codParentesco
    		contactoAbonadoToDTO.setCodParentesco(contactos[index]==null?"":contactos[index][2].replaceAll("'", ""));
    		
        	//obj.telefono = tblContactos[i][3];
    		// telefono 
    		String telf = (contactos[index][3]==null?"0":contactos[index][3].replaceAll("'", ""));
    		contactoAbonadoToDTO.setTelefono(Long.parseLong(telf));
    		
        	//obj.placaVehicular = tblContactos[i][4];
    		// placaVehicular 
    		contactoAbonadoToDTO.setPlacaVehicular(contactos[index][4]==null?"":contactos[index][4].replaceAll("'", ""));
    		
        	//obj.colorVehiculo = tblContactos[i][5];    
    		// colorVehiculo	
    		contactoAbonadoToDTO.setColorVehiculo(contactos[index][5]==null?"":contactos[index][5].replaceAll("'", ""));
    		
        	//obj.anioVehiculo = tblContactos[i][6];    
    		// anioVehiculo 	
    		contactoAbonadoToDTO.setAnioVehiculo(Long.parseLong(contactos[index][6]==null?"0":contactos[index][6].replaceAll("'", "")));
    		
        	//obj.codDireccion = tblContactos[i][7];     
    		// codDireccion 
    		contactoAbonadoToDTO.setCodDireccion(Long.parseLong(contactos[index][7]==null?"0":contactos[index][7].replaceAll("'", "")));    		
    		 
    		DireccionDTO direccionDTO = new DireccionDTO();    		
        	//obj.codProvincia = tblContactos[i][8];
    		// codProvincia 
    		direccionDTO.setCodProvincia(contactos[index][8].replaceAll("'", ""));    	
    		
        	//obj.codRegion = tblContactos[i][9];
    		// codRegion
    		direccionDTO.setCodRegion(contactos[index][9].replaceAll("'", ""));
    		
        	//obj.codCiudad = tblContactos[i][10];
    		// codCiudad
    		direccionDTO.setCodCiudad(contactos[index][10].replaceAll("'", ""));
    		
        	//obj.codComuna = tblContactos[i][11];
    		// codComuna
    		direccionDTO.setCodComuna(contactos[index][11].replaceAll("'", ""));
    		
        	//obj.nomCalle = tblContactos[i][12];
    		// nomCalle 
    		direccionDTO.setNomCalle(contactos[index][12].replaceAll("'", ""));
    		
        	//obj.numCalle = tblContactos[i][13];
    		// numCalle 
    		direccionDTO.setNumCalle(contactos[index][13].replaceAll("'", ""));
    		
        	//obj.numPiso = tblContactos[i][14];
    		// numPiso 
    		direccionDTO.setNumPiso(contactos[index][14].replaceAll("'", ""));
    		
        	//obj.numCasilla = tblContactos[i][15];
    		// numCasilla
    		direccionDTO.setNumCasilla(contactos[index][15].replaceAll("'", ""));
    		
        	//obj.obsDireccion = tblContactos[i][16];
    		// obsDireccion
    		direccionDTO.setObsDireccion(contactos[index][16].replaceAll("'", ""));
    		
        	//obj.desDirec1 = tblContactos[i][17];
    		// desDirec1
    		direccionDTO.setDesDirec1(contactos[index][17].replaceAll("'", ""));
    		
        	//obj.codPueblo = tblContactos[i][18];
    		// codPueblo
    		direccionDTO.setCodPueblo(contactos[index][18].replaceAll("'", ""));
    		
        	//obj.codEstado = tblContactos[i][19];
    		// codEstado
    		direccionDTO.setCodEstado(contactos[index][19].replaceAll("'", ""));
    		
        	//obj.zip = tblContactos[i][20];    
    		// zip
    		direccionDTO.setZip(contactos[index][20].replaceAll("'", ""));
    		
        	//obj.codTipoCalle = tblContactos[i][21];    
    		// codTipoCalle
    		direccionDTO.setCodTipoCalle(contactos[index][21].replaceAll("'", ""));
    		
        	//obj.desDireccion = tblContactos[i][22];
    		//direccionDTO.setDesDirec1(contacto[22].replaceAll("'", ""));
    		
    		String nousora = contactos[index][22].replaceAll("'", "");
    		if (nousora==null || nousora.equals("")){
    			contactoAbonadoToDTO.setNomUsuarora(userName);
    		} else{
    			contactoAbonadoToDTO.setNomUsuarora(contactos[index][22].replaceAll("'", ""));
    		}
    		
    		String codServicio = (String)session.getAttribute("codServicio");
    		contactoAbonadoToDTO.setCodServicio(codServicio);
    		long num_contacto = Long.parseLong(contactos[index][24].replaceAll("'", ""));
    		contactoAbonadoToDTO.setNumContacto(num_contacto);
    		contactoAbonadoTT.setNumAbonado(Long.parseLong(numAbonado));
    		contactoAbonadoTT.setCodServicio(codServicio);
    		contactoAbonadoTT.setContactoAbonadoToDTOs(contactoAbonadoToDTO);
    		contactoAbonadoTT.setDireccionDTO(direccionDTO);    		
    		contactoAbonadoTTs[index] = contactoAbonadoTT;
        }*/
        logger.info("generarArregloContactoAbonadoTT:end");
		return contactoAbonadoTTs;
	}

	private String generaMatrizContactos(ContactoAbonadoTT[] contactoAbonadoTTs, HttpSession session) {
		logger.info("generaMatrizContactos:start:start");
		String usuarioAbonado = (session.getAttribute("usuarioAbonado")==null?"":(String)session.getAttribute("usuarioAbonado"));
		StringBuffer texto = new StringBuffer();		
		//Contacto
		String apellido1Contacto =  new String();
		String apellido2Contacto;
		String nombreContacto =  new String();
		String parentesco =  new String();
		String telefono =  new String();
		String placaVehicular =  new String();
		String colorVehiculo =  new String();
		String anioVehiculo =  new String();
		String codDireccion =  new String();
		String nomUsuaora = new String();
		String numContacto;
		
		//Direccion
//		COD_REGION
		String codRegion =  new String();
//		COD_PROVINCIA
		String codProvincia =  new String();
//		COD_CIUDAD
		String codCiudad =  new String();
//		COD_COMUNA
		String codComuna =  new String();
//		NOM_CALLE
		String nomCalle =  new String();
//		NUM_CALLE
		String numCalle =  new String();
//		OBS_DIRECCION
		String obsDireccion =  new String();
//		DES_DIREC1
		String desDirec1 =  new String();
		
		String desDirec2 ="";
//		ZIP
		String zip =  new String();
//		COD_TIPOCALLE
		String codTipoCalle =  new String();
		String desDireccion =  new String();		
		String numPiso =  new String();
		String numCasilla =  new String();
		String codPueblo =  new String();
		String codEstado =  new String();
		String codServicio = new String();
	
		
		texto.append("\n\n arrayContactos = new Array(");				
		if (contactoAbonadoTTs.length>0){
			for (int fila = 0; fila < contactoAbonadoTTs.length; fila++) {
				ContactoAbonadoTT  contactoAbonadoTT = contactoAbonadoTTs[fila];
				GaContactoAbonadoToDTO contactoAbonadoToDTO = contactoAbonadoTT.getContactoAbonadoToDTOs();
				DireccionDTO direccionDTO = contactoAbonadoTT.getDireccionDTO();
				
				apellido1Contacto =  (contactoAbonadoToDTO.getApellido1Contacto()==null?"":contactoAbonadoToDTO.getApellido1Contacto());
				apellido2Contacto =  contactoAbonadoToDTO.getApellido2Contacto();
				apellido2Contacto =   apellido2Contacto==null?"":apellido2Contacto;
				nombreContacto =  (contactoAbonadoToDTO.getNombreContacto()==null?"":contactoAbonadoToDTO.getNombreContacto());
				parentesco =  (contactoAbonadoToDTO.getCodParentesco()==null?"":contactoAbonadoToDTO.getCodParentesco());
				telefono =  new String(); //VERIFICAR
				placaVehicular = (contactoAbonadoToDTO.getPlacaVehicular()==null?"":contactoAbonadoToDTO.getPlacaVehicular());
				colorVehiculo =  (contactoAbonadoToDTO.getColorVehiculo()==null?"":contactoAbonadoToDTO.getColorVehiculo());
				anioVehiculo =  String.valueOf(contactoAbonadoToDTO.getAnioVehiculo());
				codDireccion =  String.valueOf(contactoAbonadoToDTO.getCodDireccion());
				telefono = String.valueOf(contactoAbonadoToDTO.getTelefono());
				numContacto=String.valueOf(contactoAbonadoToDTO.getNumContacto());
				codProvincia =  (direccionDTO.getCodProvincia()==null?"":direccionDTO.getCodProvincia());
				codRegion =  (direccionDTO.getCodRegion()==null?"":direccionDTO.getCodRegion());
				codCiudad =  (direccionDTO.getCodCiudad()==null?"":direccionDTO.getCodCiudad());
				codComuna =  (direccionDTO.getCodComuna()==null?"":direccionDTO.getCodComuna());
				nomCalle = (direccionDTO.getNomCalle()==null?"":direccionDTO.getNomCalle());
				numCalle =  (direccionDTO.getNumCalle()==null?"":direccionDTO.getNumCalle());
				numPiso =  (direccionDTO.getNumPiso()==null?"":direccionDTO.getNumPiso());
				numCasilla =  (direccionDTO.getNumCasilla()==null?"":direccionDTO.getNumCasilla());
				obsDireccion = (direccionDTO.getObsDireccion()==null?"":direccionDTO.getObsDireccion());
				desDirec1 =  (direccionDTO.getDesDirec1()==null?"":direccionDTO.getDesDirec1());
				desDirec2 =   (direccionDTO.getDesDirec2()==null?"":direccionDTO.getDesDirec2());
				codPueblo =  (direccionDTO.getCodPueblo()==null?"":direccionDTO.getCodPueblo());
				codEstado =  (direccionDTO.getCodEstado()==null?"":direccionDTO.getCodEstado());
				zip =  (direccionDTO.getZip()==null?"":direccionDTO.getZip());
				codTipoCalle =  (direccionDTO.getCodTipoCalle()==null?"":direccionDTO.getCodTipoCalle());
				codServicio = (contactoAbonadoToDTO.getCodServicio()==null?"":contactoAbonadoToDTO.getCodServicio());		
				nomUsuaora =  (usuarioAbonado.equals("")?contactoAbonadoToDTO.getNomUsuarora():usuarioAbonado);
				
				desDireccion = (direccionDTO.getDesProvincia()==null?"":direccionDTO.getDesProvincia())+
				" "+ (direccionDTO.getDesRegion()==null?"":direccionDTO.getDesRegion())+
				" "+ (direccionDTO.getDesCiudad()==null?"":direccionDTO.getDesCiudad())+
				" "+ (direccionDTO.getDesComuna()==null?"":direccionDTO.getDesComuna())+
				" "+ nomCalle+ 
				" "+ obsDireccion+
				" "+ desDirec1+				
				" "+ zip+
				" "+ codTipoCalle;
				
				//desDireccion = direccionDTO.getDes()+" "+
				texto.append("\n ['"
						+ apellido1Contacto + "','"       
						+ nombreContacto + "','"          
						+ parentesco + "','"              
						+ telefono + "','"                
						+ placaVehicular + "','"          
						+ colorVehiculo + "','"		
						+ anioVehiculo + "','"		
						+ desDireccion+"','"	        
						+ codServicio + "','"             
						+ numContacto + "','"             
						+ apellido2Contacto + "','"       
						+ codDireccion + "','"            
						+ codProvincia + "','"            
						+ codRegion + "','"               
						+ codCiudad + "','"               
						+ codComuna + "','"    	        
						+ nomCalle + "','"     	        
						+ numCalle + "','"     	        
						+ numPiso + "','"                 
						+ numCasilla + "','"              
						+ obsDireccion + "','" 	        
						+ desDirec1 + "','"    	        
						+ desDirec2 + "','"    	        
						+ codPueblo + "','"               
						+ codEstado + "','"    	        
						+ zip + "','"                     
						+ codTipoCalle +"']");
				
			
				// Si no es el ultimo elemento le agrego el separador para delimitar
				// el elemento del array
				if (fila < contactoAbonadoTTs.length - 1)
					texto.append(",");															
			}
		}

		texto.append("\n );");
		logger.info("generaMatrizContactos:end");
		return texto.toString();

	} // generaMatrizCargos

}
