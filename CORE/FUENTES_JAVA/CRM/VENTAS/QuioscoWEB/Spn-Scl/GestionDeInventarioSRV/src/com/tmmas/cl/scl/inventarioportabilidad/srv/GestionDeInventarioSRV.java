package com.tmmas.cl.scl.inventarioportabilidad.srv;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.AbonadoBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.bo.SerieKitBO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AperturaRangoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.RoamingInDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.RoamingOUTDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SerieKitDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SimcardSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TerminalSNPNDTO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.bo.TasacionBO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;

public class GestionDeInventarioSRV {
	private CompositeConfiguration config;
	private final Logger logger = Logger.getLogger(GestionDeInventarioSRV.class);
	private TasacionBO	tasacionBO = new TasacionBO(); 
	private AbonadoBO abonadoBO = new AbonadoBO();
	private SerieKitBO BOSerieKit = new SerieKitBO(); 
	

	public GestionDeInventarioSRV() {
		System.out.println("GestionDeInventarioSRV(): Start");
		config = UtilProperty.getConfiguration("GestionDeInventarioSRV.properties","com/tmmas/cl/scl/inventarioportabilidad/service/properties/servicios.properties");
		System.out.println("GestionDeInventarioSRV.log ["+config.getString("GestionDeInventarioSRV.log")+"]");
		UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
		logger.debug("GestionDeInventarioSRV():End");
	}
	
	public RoamingOUTDTO getDetalleUltimaLlamadasRomingTOL(RoamingInDTO rommingDTO)throws GeneralException {
		RoamingOUTDTO retValue= null;  
		UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
		try{
			logger.debug(this.getClass().getName()+" getDetalleUltimaLlamadasRomingTOL:start");
			retValue=tasacionBO.getDetalleUltimaLlamadasRomingTOL(rommingDTO);
			UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
			logger.debug(this.getClass().getName()+" getDetalleUltimaLlamadasRomingTOL:end");
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
			logger.debug("GeneralException[", e);
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	public RetornoDTO getPreActivaAbonado(AbonadoDTO inWSPreActivaAbonadoDTO)throws GeneralException{ 
		//RSIS 001
		RetornoDTO retValue=new RetornoDTO();
		UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
		try{
			logger.debug("SpnSclWSBean: preactivaAbonado:start");
			retValue=abonadoBO.getPreActivaAbonado(inWSPreActivaAbonadoDTO);
			UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
			logger.debug("SpnSclWSBean: preactivaAbonado:end");
		}
		catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
			logger.debug("GeneralException[", e);
			//retValue.setMensajseError(e.getDescripcionEvento());
			//retValue.setCodError(e.getCodigo());
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	public RetornoDTO getAperturaRango (AperturaRangoDTO aperturaRangoDTO)throws GeneralException{
		RetornoDTO retValue=new RetornoDTO();
		UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
		try{
			logger.debug("SpnSclWSBean: preactivaAbonado:start");
			retValue=abonadoBO.getAperturaRango(aperturaRangoDTO);
			UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
			logger.debug("SpnSclWSBean: preactivaAbonado:end");
		}
		catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
			logger.debug("Codigo ["+e.getCodigo()+"]");
			logger.debug("getDescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("getCodigoEvento ["+e.getCodigoEvento()+"]");			
			logger.debug("GeneralException[", e);
			
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	public SerieKitDTO validaSerieKit(SerieKitDTO serieKit)
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
		try{
			logger.debug("validaSerieKitt:start");
			serieKit=BOSerieKit.validaSerieKit(serieKit);
			UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
			logger.debug("validaSerieKit:end");
		}
		catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
			logger.debug("Codigo ["+e.getCodigo()+"]");
			logger.debug("getDescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("getCodigoEvento ["+e.getCodigoEvento()+"]");			
			logger.debug("GeneralException[", e);
			
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return serieKit;
	}
	
	public SimcardSNPNDTO getSerieSimcardKit(SerieKitDTO serieKit) 
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
		SimcardSNPNDTO simcard = null;
		try{
			logger.debug("getSerieSimcardKit:start");
			simcard=BOSerieKit.getSerieSimcardKit(serieKit);
			UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
			logger.debug("getSerieSimcardKit:end");
		}
		catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
			logger.debug("Codigo ["+e.getCodigo()+"]");
			logger.debug("getDescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("getCodigoEvento ["+e.getCodigoEvento()+"]");			
			logger.debug("GeneralException[", e);
			
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return simcard;
	}	
	
	public TerminalSNPNDTO getSerieTerminalKit(SerieKitDTO serieKit) 
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
		TerminalSNPNDTO terminal = null;
		try{
			logger.debug("getSerieTerminalKit:start");
			terminal=BOSerieKit.getSerieTerminalKit(serieKit);
			UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
			logger.debug("getSerieTerminalKit:end");
		}
		catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
			logger.debug("Codigo ["+e.getCodigo()+"]");
			logger.debug("getDescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("getCodigoEvento ["+e.getCodigoEvento()+"]");			
			logger.debug("GeneralException[", e);
			
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeInventarioSRV.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return terminal;
	}	

}
