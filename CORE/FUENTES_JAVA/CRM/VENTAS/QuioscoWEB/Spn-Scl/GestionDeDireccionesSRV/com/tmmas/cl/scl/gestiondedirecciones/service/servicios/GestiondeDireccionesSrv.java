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
package com.tmmas.cl.scl.gestiondedirecciones.service.servicios;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.EstadoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.NumeroCalleDireccionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.NumeroPisoDireccionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ObservacionDireccionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.interfaz.TipoAtributoDireccion;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo.CiudadBO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo.ComunaBO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo.DireccionBO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo.EstadoBO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo.ProvinciaBO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo.PuebloBO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo.RegionBO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo.TipoCalleBO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ComunaDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ComunaDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ComunaSPNDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ConceptoDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DescripcionDireccionDosDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DescripcionDireccionUnoDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.EstadoDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.NombreCalleDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.PuebloDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.TipoCalleDireccionDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.bo.DatosGeneralesBO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.DatosGeneralesDTO;



public class GestiondeDireccionesSrv {
	
	private CompositeConfiguration config;
	private final Logger logger = Logger.getLogger(GestiondeDireccionesSrv.class);
	
	private RegionBO BORegion = new RegionBO();
	private ProvinciaBO BOProvincia = new ProvinciaBO();	
	private CiudadBO BOCiudad = new CiudadBO();
	private ComunaBO BOComuna = new ComunaBO();
	private PuebloBO BOPueblo = new PuebloBO();	

	public GestiondeDireccionesSrv() {
		System.out.println("GestiondeDireccionesSrv(): Start");
		config = UtilProperty.getConfiguration("GestiondeDireccionesSrv.properties","com/tmmas/cl/scl/gestiondedirecciones/service/properties/servicios.properties");
		System.out.println("GestiondeDireccionesSrv.log ["+config.getString("GestiondeDireccionesSrv.log")+"]");
		UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
		logger.debug("GestiondeDireccionesSrv():End");
	}		
	
	public DireccionDTO getDatosDireccion(DireccionDTO direccionDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
		logger.debug("Inicio:getDatosDireccion");
		try{
			
			DatosGeneralesBO datosGeneralesBO = new DatosGeneralesBO();
			if (direccionDTO==null)
				direccionDTO = new DireccionDTO();
			
			//INICIO CSR-11002
			//(direccionDTO.setCodigoOperadora(datosGeneralesBO.getCodigoOperadora());
			direccionDTO.setCodigoOperadora(config.getString("codigo.operadora.direcciones"));
			logger.debug("OPERADORA_DIRECCION: " + direccionDTO.getCodigoOperadora());
			//FIN CSR-11002
			
			DireccionBO direccionBO = new DireccionBO();
			direccionDTO = direccionBO.getConfiguracionDireccion(direccionDTO);
			if (direccionDTO.getConceptoDireccionDTOs()!=null){
				RegionBO regionBO = new RegionBO();
				EstadoBO estadoBO = new EstadoBO();
				TipoCalleBO tipoCalleBO = new TipoCalleBO();
				
				for (int i=0;i<direccionDTO.getConceptoDireccionDTOs().length;i++){
					//Busca Region
					switch (direccionDTO.getConceptoDireccionDTOs()[i].getCodigoConcepto()) {
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
					/*case TipoAtributoDireccion.tipoCalle:
						TipoCalleDireccionDTO tipoCalleDireccionDTO = tipoCalleBO.getListadoTiposCalles();
						direccionDTO.getConceptoDireccionDTOs()[i].setDatosDireccionDTO(tipoCalleDireccionDTO.getDatosDireccionDTO());
						break;*/ // CSR-11002
					}				
				}
			}
			logger.debug("Fin:getDatosDireccion");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}catch(Exception e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new GeneralException(e);
		}
		return direccionDTO;
	}
	
	public RegionDTO[] getListadoRegiones() throws GeneralException{		 
		UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
		logger.debug("Inicio:getCiudad()");
		RegionDTO[] regiones = null;
		try{
			regiones = BORegion.getListadoRegiones();
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}catch(Exception e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new GeneralException(e);
		}
		logger.debug("Fin:getCiudad()");
		return regiones;
	}	
	
	
	public ProvinciaDTO[] getListadoProvincias(RegionDTO region) throws GeneralException{		 
		UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
		logger.debug("Inicio:getCiudad()");
		ProvinciaDTO[] Provincias = null;
		try{
			Provincias = BOProvincia.getListadoProvincias(region);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}catch(Exception e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new GeneralException(e);
		}
		logger.debug("Fin:getCiudad()");
		return Provincias;
	}	
		
	public CiudadDTO[] getListadoCiudaddes(ProvinciaDTO provincia) throws GeneralException{		 
		UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
		logger.debug("Inicio:getCiudad()");
		CiudadDTO[] ciudades = null;
		try{
			ciudades = BOCiudad.getListadoCiudades(provincia);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}catch(Exception e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new GeneralException(e);
		}
		logger.debug("Fin:getCiudad()");
		return ciudades;
	}
	
	public ComunaSPNDTO[] getListadoComunas(CiudadDTO ciudad) throws GeneralException{		 
		UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
		logger.debug("Inicio:getCiudad()");
		ComunaSPNDTO[] comunas = null;
		try{
			comunas = BOComuna.getListadoComunas(ciudad);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}catch(Exception e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new GeneralException(e);
		}
		logger.debug("Fin:getCiudad()");
		return comunas;
	}	
	
	
	public ProvinciaDireccionDTO getProvincia(ProvinciaDireccionDTO provinciaDireccionDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
		logger.debug("Inicio:getProvincia()");
		try{
			provinciaDireccionDTO = BOProvincia.getListadoProvincias(provinciaDireccionDTO);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}catch(Exception e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new GeneralException(e);
		}
		logger.debug("Fin:getProvincia()");
		return provinciaDireccionDTO;
	}	
	
	public CiudadDireccionDTO getCiudad(CiudadDireccionDTO ciudadDireccionDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
		logger.debug("Inicio:getCiudad()");
		try{
			ciudadDireccionDTO  = BOCiudad.getListadoCiudades(ciudadDireccionDTO);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}catch(Exception e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new GeneralException(e);
		}
		logger.debug("Fin:getCiudad()");
		return ciudadDireccionDTO;
	}
	
	public ComunaDireccionDTO getComuna(ComunaDireccionDTO comunaDireccionDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
		logger.debug("Inicio:getComuna()");
		try{ 
			comunaDireccionDTO  = BOComuna.getListadoComunas(comunaDireccionDTO);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}catch(Exception e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new GeneralException(e);
		}
		logger.debug("Fin:getComuna()");
		return comunaDireccionDTO;
	}
	
	public DireccionNegocioDTO[] setDireccion(DireccionNegocioDTO[] direccionNegocioDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
		logger.debug("Inicio:setDireccion()");
		try{
			DireccionBO direccionBO= new DireccionBO();
			DatosGeneralesBO datosGeneralesBO = new DatosGeneralesBO();
			DatosGeneralesDTO datosGeneralesDTO = new DatosGeneralesDTO();
			datosGeneralesDTO.setCodigoSecuencia(config.getString("secuencia.direccion"));

			
			for (int i=0 ; i<direccionNegocioDTO.length;i++){
				datosGeneralesDTO.setCodigoSecuencia(config.getString("secuencia.direccion"));				
				datosGeneralesDTO = datosGeneralesBO.getSecuencia(datosGeneralesDTO);
				direccionNegocioDTO[i].setCodigo(String.valueOf(datosGeneralesDTO.getSecuencia()));						
			}
			direccionBO.setDireccion(direccionNegocioDTO);			
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}catch(Exception e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new GeneralException(e);
		}
		logger.debug("Fin:setDireccion()");
		return direccionNegocioDTO;
	}
		
	public DireccionNegocioDTO setDireccion(DireccionNegocioDTO direccionNegocioDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
		logger.debug("Inicio:setDireccion()");
		try{
			DireccionBO direccionBO= new DireccionBO();
			DatosGeneralesBO datosGeneralesBO = new DatosGeneralesBO();
			DatosGeneralesDTO datosGeneralesDTO = new DatosGeneralesDTO();
			datosGeneralesDTO.setCodigoSecuencia(config.getString("secuencia.direccion"));
			datosGeneralesDTO.setCodigoSecuencia(config.getString("secuencia.direccion"));				
			datosGeneralesDTO = datosGeneralesBO.getSecuencia(datosGeneralesDTO);
			direccionNegocioDTO.setCodigo(String.valueOf(datosGeneralesDTO.getSecuencia()));									
			direccionBO.setDireccion(direccionNegocioDTO);			
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}catch(Exception e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new GeneralException(e);
		}
		logger.debug("Fin:setDireccion()");
		return direccionNegocioDTO;
	}	
	
	public void updDireccion(DireccionNegocioDTO direccionNegocioDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
		logger.debug("Inicio:updDireccion()");
		try{
			DireccionBO direccionBO= new DireccionBO();
			direccionBO.updDireccion(direccionNegocioDTO);
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}catch(Exception e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new GeneralException(e);
		}
		logger.debug("Fin:updDireccion()");
	}
	
	public DireccionDTO getDireccionCodigo(DireccionDTO direccionDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
		logger.debug("Inicio:getDireccionCodigo()");
		try{
			DireccionBO direccionBO= new DireccionBO();
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
			
			
			//TODO: 11JUL2008 Incidencia 68041 RP
			DescripcionDireccionUnoDTO descripcionDireccionUnoDTO = new DescripcionDireccionUnoDTO();
			DescripcionDireccionDosDTO descripcionDireccionDosDTO = new DescripcionDireccionDosDTO();
			descripcionDireccionUnoDTO.setDescripcion(direccionNegocioDTO.getDescripcionDireccion1());
			descripcionDireccionUnoDTO.setCodigoConcepto(TipoAtributoDireccion.direccion1);
			descripcionDireccionDosDTO.setDescripcion(direccionNegocioDTO.getDescripcionDireccion2());
			descripcionDireccionDosDTO.setCodigoConcepto(TipoAtributoDireccion.direccion2);
			//TODO: 11JUL2008 Fin solución Incidencia 68041 RP
			
			
			ObservacionDireccionDTO observacionDireccionDTO = new ObservacionDireccionDTO();
			observacionDireccionDTO.setDescripcion(direccionNegocioDTO.getObservacionDescripcion());
			observacionDireccionDTO.setCodigoConcepto(TipoAtributoDireccion.observacion);
			
			
			RegionDireccionDTO.indiceDefecto = "-1";
			if (direccionNegocioDTO.getRegion()!=null){
				RegionDireccionDTO.indiceDefecto = direccionNegocioDTO.getRegion();
			}
			logger.debug("region defecto: "+ RegionDireccionDTO.indiceDefecto);
			ProvinciaDireccionDTO provinciaDireccionDTO = new ProvinciaDireccionDTO();
			provinciaDireccionDTO.setCodigoConcepto(TipoAtributoDireccion.provincia);
			provinciaDireccionDTO.setCodigoRegion(direccionNegocioDTO.getRegion());
			provinciaDireccionDTO = getProvincia(provinciaDireccionDTO);
			ProvinciaDireccionDTO.indiceDefecto = "-1";
			if (direccionNegocioDTO.getRegion()!=null){
				ProvinciaDireccionDTO.indiceDefecto = direccionNegocioDTO.getProvincia();
			}
			
			CiudadDireccionDTO ciudadDireccionDTO = new CiudadDireccionDTO();
			ciudadDireccionDTO.setCodigoConcepto(TipoAtributoDireccion.ciudad);
			ciudadDireccionDTO.setCodigoRegion(direccionNegocioDTO.getRegion());
			ciudadDireccionDTO.setCodigoProvincia(direccionNegocioDTO.getProvincia());
			ciudadDireccionDTO = getCiudad(ciudadDireccionDTO);
			CiudadDireccionDTO.indiceDefecto = "-1";
			if (direccionNegocioDTO.getProvincia()!=null){
				CiudadDireccionDTO.indiceDefecto = direccionNegocioDTO.getCiudad();
			}
			
			
			ComunaDireccionDTO comunaDireccionDTO = new ComunaDireccionDTO();
			comunaDireccionDTO.setCodigoConcepto(TipoAtributoDireccion.comuna);
			comunaDireccionDTO.setCodigoRegion(direccionNegocioDTO.getRegion());
			comunaDireccionDTO.setCodigoProvincia(direccionNegocioDTO.getProvincia());
			comunaDireccionDTO.setCodigoCiudad(direccionNegocioDTO.getCiudad());
			comunaDireccionDTO = getComuna(comunaDireccionDTO);
			
			ComunaDireccionDTO.indiceDefecto = "-1";
			if (direccionNegocioDTO.getComuna()!=null){
				ComunaDireccionDTO.indiceDefecto = direccionNegocioDTO.getComuna();
			}
//			TODO: 11JUL2008 Incidencia 68041 RP
			//ConceptoDireccionDTO[] conceptoDireccionDTOs = new ConceptoDireccionDTO[7];
			ConceptoDireccionDTO[] conceptoDireccionDTOs = new ConceptoDireccionDTO[9];
//			TODO: 11JUL2008 Fin solución Incidencia 68041 RP			
			conceptoDireccionDTOs[0]=nombreCalleDireccionDTO;
			conceptoDireccionDTOs[1]=numeroCalleDireccionDTO;
			conceptoDireccionDTOs[2]=numeroPisoDireccionDTO;
			conceptoDireccionDTOs[3]=provinciaDireccionDTO;
			conceptoDireccionDTOs[4]=ciudadDireccionDTO;
			conceptoDireccionDTOs[5]=comunaDireccionDTO;
			conceptoDireccionDTOs[6]=observacionDireccionDTO;
//			TODO: 11JUL2008 Incidencia 68041 RP
			conceptoDireccionDTOs[7]=descripcionDireccionUnoDTO;
			conceptoDireccionDTOs[8]=descripcionDireccionDosDTO;
//			TODO: 11JUL2008 Fin solución Incidencia 68041 RP			
			
			direccionDTO.setConceptoDireccionDTOs(null);
			direccionDTO.setConceptoDireccionDTOs(conceptoDireccionDTOs);
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}catch(Exception e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new GeneralException(e);
		}
		logger.debug("Fin:getDireccionCodigo()");
		return direccionDTO;
	}
	
	
	
	public DireccionNegocioDTO getDireccion(DireccionNegocioDTO direccionNegocioDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
		logger.debug("Inicio:getDireccion()");
		DireccionNegocioDTO direccionNegocioDTO2 = null;
		try{
			DireccionBO direccionBO= new DireccionBO();
			direccionNegocioDTO2 = direccionBO.getDireccion(direccionNegocioDTO);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}catch(Exception e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new GeneralException(e);
		}
		logger.debug("Fin:getDireccion()");
		return direccionNegocioDTO2;
	}
	
	public void eliminaDireccion(DireccionNegocioDTO direccionNegocioDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
		logger.debug("Inicio:eliminaDireccion()");
		try{
			DireccionBO direccionBO= new DireccionBO();
			direccionBO.eliminaDireccion(direccionNegocioDTO);
			
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}catch(Exception e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new GeneralException(e);
		}
		logger.debug("Fin:eliminaDireccion()");
	}
	
	
	public PuebloDTO[] getListadoPueblos(EstadoDTO estado) throws GeneralException{		 
		UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
		logger.debug("Inicio:getPueblos()");
		PuebloDTO[] Pueblos = null;
		try{
			Pueblos = BOPueblo.getListadoPueblos(estado);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		}catch(Exception e){
			UtilLog.setLog(config.getString("GestiondeDireccionesSrv.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			new GeneralException(e);
		}
		logger.debug("Fin:getPueblos()");
		return Pueblos;
	}	
	
}
