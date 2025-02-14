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
 * 08/06/2007     Héctor Hermosilla             			Versión Inicial
 */
package com.tmmas.cl.scl.direccion.service.servicios;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;

import javax.ejb.SessionContext;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClienteComDTO;
import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioDTO;
import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioWebDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.CasillaDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.CiudadDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.CodigoPostalDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ComunaDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DatosConexionServidorDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DatosDireccionComputecDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DatosDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.EstadoDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.NombreCalleDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.NumeroCalleDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.NumeroPisoDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ObservacionDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ProvinciaDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.RegionDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.TipoCalleDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.interfaz.TipoAtributoDireccion;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Ciudad;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.CodigoPostal;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Comuna;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.DatosGenerales;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Direccion;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Estado;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Provincia;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Region;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.TipoCalle;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.direccion.service.helper.Global;
import com.tmmas.cl.scl.direccioncommon.commonapp.exception.DireccionException;
import com.tmmas.cl.scl.productdomain.businessobject.bo.ParametrosGenerales;



public class DireccionSrv {


	private final Logger logger = Logger.getLogger(DireccionSrv.class);
	private SessionContext context = null;
	private CompositeConfiguration config;
	
	Global global = Global.getInstance();
	
	public DireccionSrv(){
		logger.debug("AltaClienteSrv():Begin");
		config = UtilProperty.getConfigurationfromExternalFile("PortalVentas.properties");
		UtilLog.setLog(config.getString("DireccionSrv.log"));
		logger.debug("AltaClienteSrv():End");
	}
	
	public DireccionDTO getDatosDireccion(DireccionDTO direccionDTO) throws DireccionException{
		logger.debug("Inicio:getDatosDireccion");
		try{
			
			DatosGenerales datosGeneralesBO = new DatosGenerales();
			if (direccionDTO==null)
				direccionDTO = new DireccionDTO();
			// Obtiene parametro de tabla_zipcode
			ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales();
			ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA").trim());
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto").trim());
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.tabla.zipcode").trim());
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			direccionDTO.setTablaZipCode(parametrosGeneralesDTO.getValorparametro());
			
			// Obtiene configuracion de direccion
			//direccionDTO.setCodigoOperadora(datosGeneralesBO.getCodigoOperadora());
			direccionDTO.setCodigoOperadora(global.getValor("codigo.operadora.generica").trim());
			Direccion direccionBO = new Direccion();
			direccionDTO = direccionBO.getConfiguracionDireccion(direccionDTO);
			
			
			if (direccionDTO.getConceptoDireccionDTOs()!=null){
				TipoCalle tipoCalleBO = new TipoCalle();
				Region regionBO = new Region();
				Estado estadoBO = new Estado();
				
				for (int i=0;i<direccionDTO.getConceptoDireccionDTOs().length;i++){
					//Busca Region
					switch (direccionDTO.getConceptoDireccionDTOs()[i].getCodigoConcepto()) {
					case TipoAtributoDireccion.tipoCalle:
						TipoCalleDireccionDTO tipoCalleDireccionDTO = tipoCalleBO.getListadoTiposCalles();
						direccionDTO.getConceptoDireccionDTOs()[i].setDatosDireccionDTO(tipoCalleDireccionDTO.getDatosDireccionDTO());
						break;
					case TipoAtributoDireccion.region:
						RegionDireccionDTO regionDireccionDTO = regionBO.getListadoRegionesDireccion();
						direccionDTO.getConceptoDireccionDTOs()[i].setDatosDireccionDTO(regionDireccionDTO.getDatosDireccionDTO());
						break;
					case TipoAtributoDireccion.provincia:
						//RegionDireccionDTO regionDireccionDTO = regionBO.getListadoRegionesDireccion();
						//direccionDTO.getConceptoDireccionDTOs()[i].setDatosDireccionDTO(regionDireccionDTO.getDatosDireccionDTO());
						break;
					case TipoAtributoDireccion.ciudad:
						//RegionDireccionDTO regionDireccionDTO = regionBO.getListadoRegionesDireccion();
						//direccionDTO.getConceptoDireccionDTOs()[i].setDatosDireccionDTO(regionDireccionDTO.getDatosDireccionDTO());
						break;
					case TipoAtributoDireccion.estado:
						EstadoDireccionDTO estadoDTO = estadoBO.getListadoEstados();
						direccionDTO.getConceptoDireccionDTOs()[i].setDatosDireccionDTO(estadoDTO.getDatosDireccionDTO());
						break;
					}				
				}
			}
			logger.debug("Fin:getDatosDireccion");
		}catch(CustomerDomainException e){
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			
			new DireccionException(e);
		}catch(Exception e){
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			
			new DireccionException(e);
		}
		return direccionDTO;
	}
	
	public ProvinciaDireccionDTO getProvincia(ProvinciaDireccionDTO provinciaDireccionDTO) throws DireccionException{
		logger.debug("Inicio:getProvincia()");
		try{
			Provincia provinciaBO = new Provincia();
			provinciaDireccionDTO = provinciaBO.getListadoProvincias(provinciaDireccionDTO);
			
		}catch(CustomerDomainException e){
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new DireccionException(e);
		}catch(Exception e){
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new DireccionException(e);
		}
		logger.debug("Fin:getProvincia()");
		return provinciaDireccionDTO;
	}
	
	public CiudadDireccionDTO getCiudad(CiudadDireccionDTO ciudadDireccionDTO) throws DireccionException{
		logger.debug("Inicio:getCiudad()");
		try{
			
			Ciudad ciudadBO = new Ciudad();
			ciudadDireccionDTO  = ciudadBO.getListadoCiudades(ciudadDireccionDTO);
		}catch(CustomerDomainException e){
			new DireccionException(e);
		}catch(Exception e){
			new DireccionException(e);
		}
		logger.debug("Fin:getCiudad()");
		return ciudadDireccionDTO;
	}
	
	public ComunaDireccionDTO getComuna(ComunaDireccionDTO comunaDireccionDTO) throws DireccionException{
		logger.debug("Inicio:getComuna()");
		try{
			
			Comuna comunaBO = new Comuna(); 
			comunaDireccionDTO  = comunaBO.getListadoComunas(comunaDireccionDTO);
		}catch(CustomerDomainException e){
			new DireccionException(e);
		}catch(Exception e){
			new DireccionException(e);
		}
		logger.debug("Fin:getComuna()");
		return comunaDireccionDTO;
	}

	public TipoCalleDireccionDTO getTipoCalle() throws DireccionException{
		logger.debug("Inicio:getTipoCalle()");
		TipoCalleDireccionDTO tipoCalleDireccionDTO = null;
		try{
			TipoCalle tipoCalleBO = new TipoCalle();
			tipoCalleDireccionDTO = tipoCalleBO.getListadoTiposCalles(); 
		}catch(CustomerDomainException e){
			new DireccionException(e);
		}catch(Exception e){
			new DireccionException(e);
		}
		logger.debug("Fin:getTipoCalle()");
		return tipoCalleDireccionDTO;
	}

	
	
	public CodigoPostalDireccionDTO getCodigoPostal(CodigoPostalDireccionDTO codigoPostalDireccionDTO) throws DireccionException{
		logger.debug("Inicio:getCodigoPostal()");
		try{
			CodigoPostal codigoPostalBO = new CodigoPostal();
			codigoPostalDireccionDTO = codigoPostalBO.getListadoCodigosPostales(codigoPostalDireccionDTO);
			
		}catch(CustomerDomainException e){
			new DireccionException(e);
		}catch(Exception e){
			new DireccionException(e);
		}
		logger.debug("Fin:getCodigoPostal()");
		return codigoPostalDireccionDTO;
	}

	
	
	
	public DireccionNegocioDTO setDireccion(DireccionNegocioWebDTO direccionNegocioWebDTO) throws DireccionException{
		logger.debug("Inicio:setDireccion()");
		DireccionNegocioDTO direccionNegocioDTO = new DireccionNegocioDTO();
		try{			
			Direccion direccionBO= new Direccion();
			DatosGenerales datosGeneralesBO = new DatosGenerales();
			DatosGeneralesDTO datosGeneralesDTO = new DatosGeneralesDTO();
			datosGeneralesDTO.setCodigoSecuencia(global.getValor("secuencia.direccion"));
			datosGeneralesDTO = datosGeneralesBO.getSecuencia(datosGeneralesDTO);
			direccionNegocioDTO.setCodigo(String.valueOf(datosGeneralesDTO.getSecuencia()));
			direccionBO.setDireccion(direccionNegocioWebDTO);
			
		}catch(CustomerDomainException e){
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new DireccionException(e);
		}catch(Exception e){
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new DireccionException(e);
		}
		logger.debug("Fin:setDireccion()");
		return direccionNegocioDTO;
	}
	
	public void updDireccion(DireccionNegocioDTO direccionNegocioDTO) throws DireccionException{
		logger.debug("Inicio:updDireccion()");
		try{
			Direccion direccionBO= new Direccion();
			direccionBO.updDireccion(direccionNegocioDTO);
			
		}catch(CustomerDomainException e){
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new DireccionException(e);
		}catch(Exception e){
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new DireccionException(e);
		}
		logger.debug("Fin:updDireccion()");
	}
	
	public DireccionDTO getDireccionCodigo(DireccionDTO direccionDTO) throws DireccionException{
		logger.debug("Inicio:getDireccionCodigo()");
		try{
			Direccion direccionBO= new Direccion();
			DireccionNegocioDTO direccionNegocioDTO = new DireccionNegocioDTO();
			direccionNegocioDTO.setCodigo(String.valueOf(direccionDTO.getCodigoDirecion()));
			direccionNegocioDTO = direccionBO.getDireccionCodigo(direccionNegocioDTO);
			
			NombreCalleDireccionDTO nombreCalleDireccionDTO = new NombreCalleDireccionDTO();
			nombreCalleDireccionDTO.setDescripcion(direccionNegocioDTO.getCalle());
			nombreCalleDireccionDTO.setCodigoConcepto(TipoAtributoDireccion.calle);
			
			NumeroCalleDireccionDTO numeroCalleDireccionDTO = new NumeroCalleDireccionDTO();
			numeroCalleDireccionDTO.setDescripcion(direccionNegocioDTO.getNumero());
			numeroCalleDireccionDTO.setCodigoConcepto(TipoAtributoDireccion.numero);
			
			NumeroPisoDireccionDTO numeroPisoDireccionDTO = new NumeroPisoDireccionDTO();
			numeroPisoDireccionDTO.setDescripcion(direccionNegocioDTO.getPiso());
			numeroPisoDireccionDTO.setCodigoConcepto(TipoAtributoDireccion.piso);
			
			ObservacionDireccionDTO observacionDireccionDTO = new ObservacionDireccionDTO();
			observacionDireccionDTO.setDescripcion(direccionNegocioDTO.getObservacionDescripcion());
			observacionDireccionDTO.setCodigoConcepto(TipoAtributoDireccion.observacion);
			
			CasillaDireccionDTO casillaDireccionDTO = new CasillaDireccionDTO();
			casillaDireccionDTO.setDescripcion(direccionNegocioDTO.getCasilla());
			casillaDireccionDTO.setCodigoConcepto(TipoAtributoDireccion.casilla);
			
			RegionDireccionDTO regionDireccionDTO = new RegionDireccionDTO();
			regionDireccionDTO.setCodigoConcepto(TipoAtributoDireccion.region);
			regionDireccionDTO.indiceDefecto = "-1";
			if (direccionNegocioDTO.getRegion()!=null){
				regionDireccionDTO.indiceDefecto = direccionNegocioDTO.getRegion();
			}
			
			ProvinciaDireccionDTO provinciaDireccionDTO = new ProvinciaDireccionDTO();
			provinciaDireccionDTO.setCodigoConcepto(TipoAtributoDireccion.provincia);
			provinciaDireccionDTO.setCodigoRegion(direccionNegocioDTO.getRegion());
			provinciaDireccionDTO = getProvincia(provinciaDireccionDTO);
			provinciaDireccionDTO.indiceDefecto = "-1";
			if (direccionNegocioDTO.getRegion()!=null){
				provinciaDireccionDTO.indiceDefecto = direccionNegocioDTO.getProvincia();
			}
			
			CiudadDireccionDTO ciudadDireccionDTO = new CiudadDireccionDTO();
			ciudadDireccionDTO.setCodigoConcepto(TipoAtributoDireccion.ciudad);
			ciudadDireccionDTO.setCodigoRegion(direccionNegocioDTO.getRegion());
			ciudadDireccionDTO.setCodigoProvincia(direccionNegocioDTO.getProvincia());
			ciudadDireccionDTO = getCiudad(ciudadDireccionDTO);
			ciudadDireccionDTO.indiceDefecto = "-1";
			if (direccionNegocioDTO.getProvincia()!=null){
				ciudadDireccionDTO.indiceDefecto = direccionNegocioDTO.getCiudad();
			}
			
			
			ComunaDireccionDTO comunaDireccionDTO = new ComunaDireccionDTO();
			comunaDireccionDTO.setCodigoConcepto(TipoAtributoDireccion.comuna);
			comunaDireccionDTO.setCodigoRegion(direccionNegocioDTO.getRegion());
			comunaDireccionDTO.setCodigoProvincia(direccionNegocioDTO.getProvincia());
			comunaDireccionDTO.setCodigoCiudad(direccionNegocioDTO.getCiudad());
			comunaDireccionDTO = getComuna(comunaDireccionDTO);
			
			comunaDireccionDTO.indiceDefecto = "-1";
			if (direccionNegocioDTO.getComuna()!=null){
				comunaDireccionDTO.indiceDefecto = direccionNegocioDTO.getComuna();
			}

			TipoCalleDireccionDTO tipoCalleDireccionDTO = new TipoCalleDireccionDTO();
			tipoCalleDireccionDTO = getTipoCalle();
			tipoCalleDireccionDTO.setCodigoConcepto(TipoAtributoDireccion.tipoCalle);
			tipoCalleDireccionDTO.indiceDefecto = "-1";
			if (direccionNegocioDTO.getTipoCalle()!=null){
				tipoCalleDireccionDTO.indiceDefecto = direccionNegocioDTO.getTipoCalle();
			}
            
			CodigoPostalDireccionDTO codigoPostalDireccionDTO = new CodigoPostalDireccionDTO();
			codigoPostalDireccionDTO.setCodigoConcepto(TipoAtributoDireccion.zip);
			codigoPostalDireccionDTO.setCodigoZona(direccionNegocioDTO.getComuna());
			codigoPostalDireccionDTO = getCodigoPostal(codigoPostalDireccionDTO);
			if (direccionNegocioDTO.getZip()!=null){
				codigoPostalDireccionDTO.indiceDefecto = direccionNegocioDTO.getZip();
			}

			
			
			ConceptoDireccionDTO[] conceptoDireccionDTOs = new ConceptoDireccionDTO[11];
			conceptoDireccionDTOs[0]=nombreCalleDireccionDTO;
			conceptoDireccionDTOs[1]=numeroCalleDireccionDTO;
			conceptoDireccionDTOs[2]=numeroPisoDireccionDTO;
			conceptoDireccionDTOs[3]=provinciaDireccionDTO;
			conceptoDireccionDTOs[4]=ciudadDireccionDTO;
			conceptoDireccionDTOs[5]=comunaDireccionDTO;
			conceptoDireccionDTOs[6]=observacionDireccionDTO;
			conceptoDireccionDTOs[7]=casillaDireccionDTO;
			conceptoDireccionDTOs[8]=tipoCalleDireccionDTO;
			conceptoDireccionDTOs[9]=codigoPostalDireccionDTO;
			conceptoDireccionDTOs[10]=regionDireccionDTO;
			
			direccionDTO.setConceptoDireccionDTOs(null);
			direccionDTO.setConceptoDireccionDTOs(conceptoDireccionDTOs);
			
		}catch(CustomerDomainException e){
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new DireccionException(e);
		}catch(Exception e){
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new DireccionException(e);
		}
		logger.debug("Fin:getDireccionCodigo()");
		return direccionDTO;
	}
	
	
	
	public DireccionNegocioDTO getDireccion(DireccionNegocioDTO direccionNegocioDTO) throws DireccionException{
		logger.debug("Inicio:getDireccion()");
		DireccionNegocioDTO direccionNegocioDTO2 = null;
		try{
			Direccion direccionBO= new Direccion();
			direccionNegocioDTO2 = direccionBO.getDireccion(direccionNegocioDTO);
		}catch(CustomerDomainException e){
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new DireccionException(e);
		}catch(Exception e){
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new DireccionException(e);
		}
		logger.debug("Fin:getDireccion()");
		return direccionNegocioDTO2;
	}

	
	public List llamarServicioDireccionesComputec (ClienteComDTO cliente)
	throws DireccionException, RemoteException {
		List listaDirecciones = new ArrayList();
		ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
		ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales();
		Direccion direccionBO= new Direccion();
		DatosDireccionDTO datoLlamadaComputec = null;
		DatosConexionServidorDTO datosConexion = null;
		
		
		String mesg = null;
		logger.debug("Inicio:verificaLlamadaServicioExterno()");
		try{
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GA").trim());
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto").trim());
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.computec").trim());
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			String valorAplicaComputec = parametrosGeneralesDTO.getValorparametro();
			boolean aplicaComputec = valorAplicaComputec!=null && valorAplicaComputec.equals(global.getValor("aplica.computec.verdadero").trim())?true:false;
	        
			if (aplicaComputec){
	        	datoLlamadaComputec = direccionBO.getCadenaLLamadaComputec();
	        	String parametroCadenaComputec = global.getValor("parametro.cadena.computec").trim();
	        	if (datoLlamadaComputec!=null && datoLlamadaComputec.getDescripcion()!=null){
	        	  mesg = parametroCadenaComputec + datoLlamadaComputec.getDescripcion()+cliente.getNumeroIdentificacion()+"."+cliente.getNombreApellido1()+".<DIR>";
	        	  //mesg = "MARCHIV230001.2300.67GBJ.1.541455.POSADA.<DIR>";
	        	}
	
	        	datosConexion =	direccionBO.getDatosConexionComputec();	
	            String direccionIPServidor = datosConexion.getNombreIPServidor();
                int puerto = Integer.parseInt(datosConexion.getPuerto());
                String codigoRegistroDireccion = datosConexion.getCodigoRegistroDireccion();
                String codigoRegistroFinal = global.getValor("codigo.registro.final").trim();
                // Recuperacion de longitud de campos
                int len1 = Integer.parseInt(global.getValor("computec.campo1.length").trim());
                int len2 = Integer.parseInt(global.getValor("computec.campo2.length").trim());
                int len3 = Integer.parseInt(global.getValor("computec.campo3.length").trim());
                int len4 = Integer.parseInt(global.getValor("computec.campo4.length").trim());
                int len5 = Integer.parseInt(global.getValor("computec.campo5.length").trim());
                
            	Socket sock = new Socket(direccionIPServidor, puerto);
                BufferedReader is = new BufferedReader(new InputStreamReader(sock.getInputStream()));
                PrintWriter os = new PrintWriter(sock.getOutputStream(), true);
                os.print(mesg + "\r\n");
                os.flush();
                    
                StringBuffer registro = new StringBuffer();
                int c;
                int i=0;
                while ((c = is.read())!=-1 ){
            	    if (c!=3 && c!=13){
              		  registro.append((char)c);
              	    } 
                	else { 
                	  if (registro.length()>=2){                		  
						  String codRegistroDir = registro.substring(0,len1);
						  if (codRegistroDir.equals(codigoRegistroDireccion)){
		                     String ciudad = registro.substring(len1,len1+len2);
		                     String tipoCalle = registro.substring(len1+len2+len3,len1+len2+len3+len4);
		                     String calle = registro.substring(len1+len2+len3+len4,len1+len2+len3+len4+len5);
		                     DatosDireccionComputecDTO datosDirComputec = new DatosDireccionComputecDTO();
		                     datosDirComputec.setCodigoTipoCalle(tipoCalle);
		                     datosDirComputec.setDescripcionCiudad(ciudad);
		                     datosDirComputec.setDescripcionCalle(calle);
		                     datosDirComputec.setCodigo(Integer.toString(i++));
		                     datosDirComputec.setDescripcion(ciudad+" "+tipoCalle+" "+calle);
		                     listaDirecciones.add(datosDirComputec);
						  } 
						  else if (codRegistroDir.equals(codigoRegistroFinal)){
							 break;  
						  }  
						  registro = new StringBuffer();
                	  }
                	}//if	  
                } //while
                sock.close();
	        }//if
		}
       catch (java.io.IOException e) {
           String log = StackTraceUtl.getStackTrace(e);
 		   logger.debug("log error[" + log + "]");
       }
	   catch(Exception e){
		   String log = StackTraceUtl.getStackTrace(e);
		   logger.debug("log error[" + log + "]");
	 	   new DireccionException(e);
	   }
	   logger.debug("Fin:getDireccionCodigo()");
	   logger.debug("Fin:verificaLlamadaServicioExterno()");
	   return listaDirecciones;
	}
	
	
	
}
