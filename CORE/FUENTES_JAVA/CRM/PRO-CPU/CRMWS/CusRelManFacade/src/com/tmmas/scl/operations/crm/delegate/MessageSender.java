package com.tmmas.scl.operations.crm.delegate;

import javax.jms.QueueSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.processmgr.AsyncProcessParameterObject;
import com.tmmas.cl.framework.util.MessagePublisher;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.operations.crm.delegate.helper.FacadeMaker;
import com.tmmas.scl.operations.crm.delegate.helper.Global;
import com.tmmas.scl.operations.crm.f.sel.negsal.cmd.AnulacionContratacionVenAsinSRVORC;
import com.tmmas.scl.operations.crm.f.sel.negsal.cmd.ContratacionOfertaComercialVenAsinSRVORC;
import com.tmmas.scl.operations.crm.f.sel.negsal.cmd.DescontratarOfertaComercialVenAsinSRVORC;
import com.tmmas.scl.operations.crm.f.sel.negsal.cmd.DescontratarPorVentaOfertaComercialVenAsinSRVORC;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;

public class MessageSender 
{
	
	private final Logger logger = Logger.getLogger(FacadeMaker.class);	
	private static Global global=Global.getInstance();	
	
	public MessageSender()
	{
		String log = global.getValor("delegate.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
	}
	
	public RetornoDTO sendToQueueAnulacionVenta(VentaDTO dto)
	{
		AsyncProcessParameterObject paramProceso;
		RetornoDTO retorno=new RetornoDTO();	
		
		logger.debug("sendToQueueAnulacionVenta():start");
		
		String sNombreMethodo = new String("ejecutarVenta:");
		
		logger.info(sNombreMethodo+"star");
		try
		{
			logger.debug(sNombreMethodo+"Antes de generar mensaje");
			logger.debug(sNombreMethodo+"Genero objeto AnulacionContratacionVenAsinSRVORC");
			paramProceso = new AsyncProcessParameterObject(dto);
			AnulacionContratacionVenAsinSRVORC generaQuueeCmd = new AnulacionContratacionVenAsinSRVORC(paramProceso);
			logger.debug(sNombreMethodo+"Genero objeto MessagePuSerializableblisher -> Factory :" +global.getJndiFactory()+ " Queue :" + global.getJndiQueueVenta());
			MessagePublisher messagePublisher = new MessagePublisher(global.getJndiFactory(), global.getJndiQueueVenta());				
			logger.debug(sNombreMethodo+"Envio mensaje");
			messagePublisher.sendObjectToQueue(false,QueueSession.AUTO_ACKNOWLEDGE, generaQuueeCmd);
			logger.debug(sNombreMethodo+"Mensaje fue generado satisfactoriamente");
			retorno.setCodigo("0");
			retorno.setDescripcion("Mensaje fue generado satisfactoriamente");
			retorno.setResultado(true);
			logger.debug("sendToQueueAnulacionVenta():end");
		}
		catch(Exception e)
		{
			logger.debug(sNombreMethodo+"Error al crear mensaje, se procede a modificar estado del proceso a error", e);
		}
		logger.info(sNombreMethodo+"():end");
		
		return retorno;
	}
	
	public RetornoDTO sendToQueueActivacionVenta(OfertaComercialDTO dto)
	{
		AsyncProcessParameterObject paramProceso;
		RetornoDTO retorno=new RetornoDTO();		
			
		logger.debug("sendToQueueActivacionVenta():start");
		
		String sNombreMethodo = new String("ejecutarVenta:");
		
		logger.info(sNombreMethodo+"star");
		try
		{
			logger.debug(sNombreMethodo+"Antes de generar mensaje");
			logger.debug(sNombreMethodo+"Genero objeto AnulacionContratacionVenAsinSRVORC");
			paramProceso = new AsyncProcessParameterObject(dto);
			ContratacionOfertaComercialVenAsinSRVORC generaQuueeCmd = new ContratacionOfertaComercialVenAsinSRVORC(paramProceso);
			logger.debug(sNombreMethodo+"Genero objeto MessagePuSerializableblisher -> Factory :" +global.getJndiFactory()+ " Queue :" + global.getJndiQueueVenta());
			MessagePublisher messagePublisher = new MessagePublisher(global.getJndiFactory(), global.getJndiQueueVenta());				
			logger.debug(sNombreMethodo+"Envio mensaje");
			messagePublisher.sendObjectToQueue(false,QueueSession.AUTO_ACKNOWLEDGE, generaQuueeCmd);
			logger.debug(sNombreMethodo+"Mensaje fue generado satisfactoriamente");
			retorno.setCodigo("0");
			retorno.setDescripcion("Mensaje fue generado satisfactoriamente");
			retorno.setResultado(true);
			logger.debug("sendToQueueActivacionVenta():end");
		}
		catch(Exception e)
		{
			logger.debug(sNombreMethodo+"Error al crear mensaje, se procede a modificar estado del proceso a error", e);
		}
		logger.info(sNombreMethodo+"():end");
		
		return retorno;
	}
	
	public RetornoDTO sendToQueueDescontratarVenta(ProductoContratadoListDTO dto)
	{
		AsyncProcessParameterObject paramProceso;
		RetornoDTO retorno=new RetornoDTO();		
			
		logger.debug("sendToQueueDescontratarVenta():start");
		
		String sNombreMethodo = new String("ejecutarDescontratar:");
		
		logger.info(sNombreMethodo+"star");
		try
		{
			logger.debug(sNombreMethodo+"Antes de generar mensaje");
			logger.debug(sNombreMethodo+"Genero objeto DescontratarOfertaComercialVenAsinSRVORC");
			paramProceso = new AsyncProcessParameterObject(dto);
			DescontratarOfertaComercialVenAsinSRVORC generaQuueeCmd = new DescontratarOfertaComercialVenAsinSRVORC(paramProceso);
			logger.debug(sNombreMethodo+"Genero objeto MessagePuSerializableblisher -> Factory :" +global.getJndiFactory()+ " Queue :" + global.getJndiQueueVenta());
			MessagePublisher messagePublisher = new MessagePublisher(global.getJndiFactory(), global.getJndiQueueVenta());				
			logger.debug(sNombreMethodo+"Envio mensaje");
			messagePublisher.sendObjectToQueue(false,QueueSession.AUTO_ACKNOWLEDGE, generaQuueeCmd);
			logger.debug(sNombreMethodo+"Mensaje fue generado satisfactoriamente");
			retorno.setCodigo("0");
			retorno.setDescripcion("Mensaje fue generado satisfactoriamente");
			retorno.setResultado(true);
			logger.debug("sendToQueueDescontratarVenta():end");
		}
		catch(Exception e)
		{
			logger.debug(sNombreMethodo+"Error al crear mensaje, se procede a modificar estado del proceso a error", e);
		}
		logger.info(sNombreMethodo+"():end");
		
		return retorno;
	}

	
	public RetornoDTO sendToQueueRechazoVenta(VentaDTO dto)
	{
		AsyncProcessParameterObject paramProceso;
		RetornoDTO retorno=new RetornoDTO();		
			
		logger.debug("sendToQueueRechazoVenta():start");
		
		String sNombreMethodo = new String("ejecutarDescontratarVenta:");
		
		logger.info(sNombreMethodo+"star");
		try
		{
			logger.debug(sNombreMethodo+"Antes de generar mensaje");
			logger.debug(sNombreMethodo+"Genero objeto DescontratarPorVentaOfertaComercialVenAsinSRVORC");
			paramProceso = new AsyncProcessParameterObject(dto);
			DescontratarPorVentaOfertaComercialVenAsinSRVORC generaQuueeCmd = new DescontratarPorVentaOfertaComercialVenAsinSRVORC(paramProceso);
			logger.debug(sNombreMethodo+"Genero objeto MessagePuSerializableblisher -> Factory :" +global.getJndiFactory()+ " Queue :" + global.getJndiQueueVenta());
			MessagePublisher messagePublisher = new MessagePublisher(global.getJndiFactory(), global.getJndiQueueVenta());				
			logger.debug(sNombreMethodo+"Envio mensaje");
			messagePublisher.sendObjectToQueue(false,QueueSession.AUTO_ACKNOWLEDGE, generaQuueeCmd);
			logger.debug(sNombreMethodo+"Mensaje fue generado satisfactoriamente");
			retorno.setCodigo("0");
			retorno.setDescripcion("Mensaje fue generado satisfactoriamente");
			retorno.setResultado(true);
			logger.debug("sendToQueueRechazoVenta():end");
		}
		catch(Exception e)
		{
			logger.debug(sNombreMethodo+"Error al crear mensaje, se procede a modificar estado del proceso a error", e);
		}
		logger.info(sNombreMethodo+"():end");
		
		return retorno;
	}
}
