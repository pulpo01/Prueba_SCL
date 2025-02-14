/**
 * 
 */
package com.tmmas.cl.scl.integracionexterna.negocio.message;

import javax.jms.ObjectMessage;

import com.tmmas.cl.scl.integracionexterna.common.dto.DatosCorreoDTO;
import com.tmmas.cl.scl.integracionexterna.common.dto.TraspasoMasivoDTO;
import com.tmmas.cl.scl.integracionexterna.common.dto.ws.EntradaIntegracionExternaDTO;
import com.tmmas.cl.scl.integracionexterna.common.dto.ws.SalidaConsultaTraspasoDTO;
import com.tmmas.cl.scl.integracionexterna.common.dto.ws.TraspasoMasivoInDTO;
import com.tmmas.cl.scl.integracionexterna.common.exception.IntegracionExternaException;
import com.tmmas.cl.scl.integracionexterna.common.helper.GlobalProperties;
import com.tmmas.cl.scl.integracionexterna.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionexterna.srv.GeneralSRV;
import com.tmmas.cl.scl.integracionexterna.srv.MovimientoSRV;
import com.tmmas.cl.scl.integracionexterna.srv.TraspasoMasivoSRV;


/**
 * La clase TraspasoMasivoMDBBean representa el bean que gestiona los mensajes
 * de la cola de entrada en la ejecuci&oacute;n de los servicios.
 * El m&eacute;todo onMessage es llamado al activarse el bean.
 * 
 * <!-- begin-xdoclet-definition -->
 * @ejb.bean name="TraspasoMasivoMDB"    
 *     destination-type="javax.jms.Queue"
 *     
 *     transaction-type="Container"
 *
 *  @ejb.transaction type="Required"
 *  
 * @weblogic:pool initial-beans-in-free-pool="1"
 *     max-beans-in-free-pool="1"
 *
 * @weblogic:message-driven destination-jndi-name="TraspasoMasivoSerieQueue"
 *     connection-factory-jndi-name="IntegracionSICSACF"
 *
 * @weblogic:transaction-descriptor trans-timeout-seconds = "3000"
 *
 * <!-- end-xdoclet-definition -->
 * @generated
 * 
 * 
 **/

public class TraspasoMasivoMDBBean implements javax.ejb.MessageDrivenBean,
		javax.jms.MessageListener {
	
	private final LoggerHelper logger = LoggerHelper.getInstance();
	private GlobalProperties global = GlobalProperties.getInstance();
	TraspasoMasivoSRV traspasoMasivoSRV = new TraspasoMasivoSRV();

	/** 
	 * <!-- begin-xdoclet-definition --> 
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 */
	private static final long serialVersionUID = 1L;

	/** 
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * The context for the message-driven bean, set by the EJB container. 
	 * @generated
	 */
	private javax.ejb.MessageDrivenContext messageContext = null;

	/** 
	 * Required method for container to set context.
	 * @generated 
	 */
	public void setMessageDrivenContext(
			javax.ejb.MessageDrivenContext messageContext)
			throws javax.ejb.EJBException {
		this.messageContext = messageContext;
	}

	/** 
	 * Required creation method for message-driven beans. 
	 *
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.create-method 
	 * <!-- end-xdoclet-definition -->
	 * @generated
	 */
	public void ejbCreate() {
		//no specific action required for message-driven beans 
	}

	/** 
	 * Required removal method for message-driven beans. 
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void ejbRemove() {
		messageContext = null;
	}

	/** 
	 * This method implements the business logic for the EJB. 
	 * 
	 * <p>Make sure that the business logic accounts for asynchronous message processing. 
	 * For example, it cannot be assumed that the EJB receives messages in the order they were 
	 * sent by the client. Instance pooling within the container means that messages are not 
	 * received or processed in a sequential order, although individual onMessage() calls to 
	 * a given message-driven bean instance are serialized. 
	 * 
	 * <p>The <code>onMessage()</code> method is required, and must take a single parameter 
	 * of type javax.jms.Message. The throws clause (if used) must not include an application 
	 * exception. Must not be declared as final or static. 
	 *
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void onMessage(javax.jms.Message message) {
		loggerDebug("Se inicia onMessage TraspasoSeriesMDBBean: " + message);
		EntradaIntegracionExternaDTO inDTO = null;
		int numServicio;
		try{
			numServicio = message.getIntProperty("servicio");
			loggerDebug("Numero Servicio: "+numServicio);
			if (message instanceof ObjectMessage) {
				ObjectMessage objectMessage = (ObjectMessage) message; 
				inDTO = (EntradaIntegracionExternaDTO)objectMessage.getObject();
				if(null!=inDTO){
					switch(numServicio){
					case 0:{
						//Aca se invoca al servicio de Traspaso Masivo
						loggerDebug("Invoca Servicio traspasoMasivoSeries: "+numServicio);
						traspasoMasivoSeries(inDTO);
						loggerDebug("Finaliza Servicio traspasoMasivoSeries: "+numServicio);
						break;
					}
					case 1:{
						//Aca se invoca al servicio de Movimiento Traspaso DTS
						loggerDebug("invoca Servicio insertaAlMovmiento: "+numServicio);
						insertaAlMovmiento(inDTO);
						loggerDebug("Finaliza Servicio insertaAlMovmiento: "+numServicio);
						break;
					}
					default:
						break;
					}
				}
			}
		}catch (Throwable e) {
			e.printStackTrace();
			loggerError("ERROR: ");
			loggerError(e.getMessage());
			loggerError("Error en la ejecucion del servicio, realizando rollback");
			//messageContext.setRollbackOnly();
		}
		loggerDebug("Finaliza:" + message);
	}

	/**
	 * 
	 */
	public TraspasoMasivoMDBBean() {
		// TODO Auto-generated constructor stub
	}
	
	private void traspasoMasivoSeries(EntradaIntegracionExternaDTO integracionExternaDTO) throws IntegracionExternaException, Exception{
		String subject = null;
		String texto = null;
		TraspasoMasivoInDTO traspasoDTO = null;
		TraspasoMasivoDTO masivoDTO = null;
		try{
			loggerDebug("traspasoMasivoSeries: inicio");
			traspasoDTO = (TraspasoMasivoInDTO)integracionExternaDTO;
			masivoDTO = traspasoMasivoSRV.traspasoMasivoSeries(traspasoDTO);
			//Se consulta si quedaron series con error
			if(!traspasoMasivoSRV.consultaSeriesError(masivoDTO.getNumTraspasoMasivo(), global.getValor("AL.ErroresNormal"))){
				loggerDebug("Traspaso Masivo finalizo con Errores");
				traspasoMasivoSRV.actualizaTraspasoOP(masivoDTO.getNumTraspasoMasivo(), masivoDTO.getMasivoInDTO().getNumSecuencia(), global.getValor("AL.estadoError"));
				SalidaConsultaTraspasoDTO listaErrores = null;
				SalidaConsultaTraspasoDTO traspasoDTO2 = new SalidaConsultaTraspasoDTO();
				traspasoDTO2.setNumTraspasoMasivo(masivoDTO.getNumTraspasoMasivo());
				listaErrores = traspasoMasivoSRV.obtieneSeriesErrorTM(traspasoDTO2, global.getValor("AL.ErroresNormal"));
				
				StringBuffer mensajeError = new StringBuffer("");
				
				for (int i = 0; i <= listaErrores.getSeriesError().length - 1; i++) {
					mensajeError.append("<br>&nbsp &nbsp &nbsp &nbsp - Serie  <b>[" + listaErrores.getSeriesError()[i].getNumSerie() 
							+ "]</b> tiene el siguiente Error: <b>" + listaErrores.getSeriesError()[i].getDesErrorSerie()+"</b>");					
				}
				
				subject = global.getValor("mail.asunto.traspaso.conError").replace("[1]", masivoDTO.getMasivoInDTO().getNumSecuencia());
				texto = global.getValor("mail.html.antes") + global.getValor("mail.antes.traspaso.conErroneos").replace("[1]", masivoDTO.getMasivoInDTO().getNumSecuencia())+
						mensajeError.toString()+global.getValor("mail.html.despues");
				
			}else{			
				loggerDebug("Traspaso Masivo finalizo sin Errores");
				subject = global.getValor("mail.subject.traspaso.final").replace("[1]", masivoDTO.getMasivoInDTO().getNumSecuencia());
				texto = global.getValor("mail.html.antes") + global.getValor("mail.correo.traspaso.final").replace("[1]",masivoDTO.getMasivoInDTO().getNumSecuencia())+
						global.getValor("mail.html.despues");
			}	
			enviarCorreo(subject, texto);
			loggerDebug("traspasoMasivoSeries: fin");
		}catch(IntegracionExternaException e){
			loggerDebug("IntegracionExternaException: "+ e);
			if(e.getCodigo().equals("ERR.0005")||e.getCodigo().equals("ERR.0006")){
				SalidaConsultaTraspasoDTO listaErrores = null;
				
				if(e.getCodigo().equals("ERR.0005")){
					loggerDebug("Errores Criticos");	
					SalidaConsultaTraspasoDTO traspasoDTO2 = new SalidaConsultaTraspasoDTO();
					traspasoDTO2.setNumTraspasoMasivo(String.valueOf(e.getCodigoEvento()));
					listaErrores = traspasoMasivoSRV.obtieneSeriesErrorTM(traspasoDTO2, global.getValor("AL.ErroresCriticos"));
				}else{
					loggerDebug("Errores normales");
					SalidaConsultaTraspasoDTO traspasoDTO2 = new SalidaConsultaTraspasoDTO();
					traspasoDTO2.setNumTraspasoMasivo(String.valueOf(e.getCodigoEvento()));
					listaErrores = traspasoMasivoSRV.obtieneSeriesErrorTM(traspasoDTO2, global.getValor("AL.ErroresNormal"));					
				}
				
				StringBuffer mensajeError = new StringBuffer("");
				
				for (int i = 0; i <= listaErrores.getSeriesError().length - 1; i++) {
					mensajeError.append("<br>&nbsp &nbsp &nbsp &nbsp - Serie  <b>[" + listaErrores.getSeriesError()[i].getNumSerie() 
							+ "]</b> tiene el siguiente Error: <b>" + listaErrores.getSeriesError()[i].getDesErrorSerie()+"</b>");					
				}
				
				loggerError("Antes de Enviar Correo con Error");
				
				subject = global.getValor("mail.asunto.traspaso.error").replace("[1]", String.valueOf(traspasoDTO.getNumSecuencia()));
				texto = global.getValor("mail.html.antes") + global.getValor("mail.antes.traspaso.erroneos").replace("[1]", String.valueOf(e.getCodigoEvento()))+
						mensajeError.toString()+global.getValor("mail.html.despues");				
			}else{
				SalidaConsultaTraspasoDTO listaErrores = null;
				listaErrores = traspasoMasivoSRV.consultaEstadoTraspOP(traspasoDTO.getNumSecuencia());
				
				subject = global.getValor("mail.asunto.traspaso.error").replace("[1]", traspasoDTO.getNumSecuencia());
				texto = global.getValor("mail.html.antes") + global.getValor("mail.antes.traspaso.error").replace("[1]",traspasoDTO.getNumSecuencia().replace("[dError]", e.getDescripcionEvento()))+
						global.getValor("mail.html.despues");
				
			}			
			enviarCorreo(subject, texto);
			loggerError("Despues de Enviar Correo con Error");		
		}	
	}
	
	private void enviarCorreo(String subject, String texto)throws Exception {
		GeneralSRV generalSRV = new GeneralSRV();
		TraspasoMasivoSRV traspasoSRV = new TraspasoMasivoSRV();
		DatosCorreoDTO correoDTO = generalSRV.getDatosCorreo(global.getValor("mail.traspaso.correos"));
		traspasoSRV.setIpSMTP(correoDTO.getIpSmtp());
		traspasoSRV.setRemitenteMail(correoDTO.getRemitenteMail());
		traspasoSRV.setDestinosMail(correoDTO.getDestinosMail());		
		traspasoSRV.enviarCorreo(subject, texto);		
	}
	
	private void insertaAlMovmiento(EntradaIntegracionExternaDTO integracionExternaDTO) throws IntegracionExternaException, Exception{
		MovimientoSRV movimientoSRV = new MovimientoSRV();
		SalidaConsultaTraspasoDTO traspasoSalidaConsultaTraspasoDTO = null;
		String subject = null;
		String texto = null;
		TraspasoMasivoInDTO traspasoDTO = (TraspasoMasivoInDTO)integracionExternaDTO;
		try{
			loggerDebug("eliminaSeriesErroneas: inicio");			
			movimientoSRV.eliminaTempoErrorMov(traspasoDTO.getNumSecuencia(), global.getValor("AL.codModulo"), 
					global.getValor("AL.codProceso"), "1");
		
			traspasoMasivoSRV.actualizaTraspasoOP("1", traspasoDTO.getNumSecuencia(), global.getValor("AL.estadoProcesando"));
			
			loggerDebug("insertaAlMovmiento: inicio");
			movimientoSRV.insertaAlMovmiento(traspasoDTO);
			
			loggerDebug("Valida se existen series con error");
			traspasoSalidaConsultaTraspasoDTO = movimientoSRV.obtSeriesErrorMov(traspasoDTO.getNumSecuencia(), global.getValor("AL.codModulo"), 
					global.getValor("AL.codProceso"), "1");
			
			if(traspasoSalidaConsultaTraspasoDTO.getSeriesError().length > 0){
				loggerDebug("existen series con error");
				StringBuffer mensajeError = new StringBuffer("");
				
				for (int i = 0; i <= traspasoSalidaConsultaTraspasoDTO.getSeriesError().length - 1; i++) {
					mensajeError.append("<br>&nbsp &nbsp &nbsp &nbsp - Serie  <b>[" + traspasoSalidaConsultaTraspasoDTO.getSeriesError()[i].getNumSerie()
							+ "]</b> tiene el siguiente Error: <b>" + traspasoSalidaConsultaTraspasoDTO.getSeriesError()[i].getDesErrorSerie()+"</b>");					
				}	
				
				subject = global.getValor("mail.asunto.movimiento.error").replace("[1]", traspasoDTO.getNumSecuencia());
				texto = global.getValor("mail.html.antes") + global.getValor("mail.antes.movimiento.erroneos").replace("[nP]",traspasoDTO.getNumSecuencia())+
						mensajeError.toString() + global.getValor("mail.html.despues");
				
				traspasoMasivoSRV.actualizaTraspasoOP("1", traspasoDTO.getNumSecuencia(), global.getValor("AL.estadoError"));
				
			}else{	
				loggerDebug("no existen series con error");
				subject = global.getValor("mail.asunto.movimiento.ok").replace("[1]", traspasoDTO.getNumSecuencia());
				texto = global.getValor("mail.html.antes") + global.getValor("mail.correo.movimiento.ok").replace("[1]",traspasoDTO.getNumSecuencia())+ global.getValor("mail.html.despues");				
				loggerDebug("traspasoMasivoSeries: fin");
				traspasoMasivoSRV.actualizaTraspasoOP("1", traspasoDTO.getNumSecuencia(), global.getValor("AL.estadoFinalizado"));
			}	
			enviarCorreo(subject, texto);
		}catch(IntegracionExternaException e){
			loggerDebug("IntegracionExternaException: "+ e);
			subject = global.getValor("mail.asunto.traspaso.error").replace("[1]", traspasoDTO.getNumSecuencia());
			texto = global.getValor("mail.html.antes") + global.getValor("mail.antes.traspaso.error").replace("[1]",traspasoDTO.getNumSecuencia().replace("[dError]", e.getDescripcionEvento()))+
			global.getValor("mail.html.despues");
			enviarCorreo(subject, texto);
			messageContext.setRollbackOnly();			
		}	
	}
	
	// Metodos utulitarios de la clase
	public void loggerDebug(String mensaje) {
		logger.debug(mensaje, this.getClass().getName());
	}

	public void loggerInfo(String mensaje) {
		logger.info(mensaje, this.getClass().getName());
	}

	public void loggerError(String mensaje) {
		logger.error(mensaje, this.getClass().getName());
	}
}
