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
 * 25/04/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.frameworkcargossrv.service.implementacion;

//import com.tmmas.cl.scl.crmcommon.commonapp.dto.ConfiguradorTareaPrebillingDTO;
//import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrebillingDTO;
//import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
//import com.tmmas.cl.scl.customerdomain.businessobject.bo.RegistroVenta;
//import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.frameworkcargos.base.TareasRegistroCargos;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.RegistroVentaBOFactory;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.RegistroVentaBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.RegistroVentaBOIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ConfiguradorTareaPrebillingDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrebillingDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroVentaDTO;



public class PreBillingVE extends TareasRegistroCargos{
	private ConfiguradorTareaPrebillingDTO parametrosPrebilling;
    //TODO : Factorys Arq Colombia Mix
	private RegistroVentaBOFactoryIT regVentaFactory=new RegistroVentaBOFactory();
	private RegistroVentaBOIT registroVentaBO=regVentaFactory.getBusinessObject1();


	public PreBillingVE(ConfiguradorTareaPrebillingDTO parametros) {
		super(parametros);
		this.parametrosPrebilling = parametros;
		// TODO Auto-generated constructor stub
	}
	/**
	 * Valida si se ejecuta el prebilling solo si la facturación no es a ciclo
	 * @param 
	 * @return 
	 * @throws 
	 */
	public boolean validaciones() {
		// TODO Auto-generated method stub
		if (!parametrosPrebilling.isFacturacionaCiclo())
			return true;
		else
			return false;
	}

	public boolean esPrebilling() {
		// TODO Auto-generated method stub
		return parametrosPrebilling.isPrebilling();
	}

	
	public void tarea() {
	}
	/**
	 * Genera los parametros necesarios para ejecutar el prebilling
	 * @param 
	 * @return 
	 * @throws 
	 */
	public void tarea(PrebillingDTO datos){
		// TODO Auto-generated method stub
		try{
			//RegistroVenta registroVentaBO = new RegistroVenta();
			RegistroVentaDTO registroVenta = new RegistroVentaDTO();
			//Obtiene secuencia transacabo
			registroVenta.setCodigoSecuencia(parametrosPrebilling.getNombreSecuenciaTransacabo());
			registroVenta = registroVentaBO.getSecuenciaTransacabo(registroVenta);
			datos.setSecuenciaTransacabo(String.valueOf(registroVenta.getNumeroTransaccionVenta()));
			datos.setActuacionPrebilling(parametrosPrebilling.getActuacionPrebilling());
			datos.setCategoriaTributaria(parametrosPrebilling.getCategoriaTributaria());
			datos.setCodigoCliente(parametrosPrebilling.getCodigoCliente());
			datos.setModalidadVenta(parametrosPrebilling.getModalidadVenta());
			datos.setNumeroTransaccionVenta(parametrosPrebilling.getNumeroTransaccionVenta());
			datos.setNumeroVenta(parametrosPrebilling.getNumeroVenta());
			datos.setProductoGeneral(parametrosPrebilling.getProductoGeneral());
		}catch(CustomerBillException e){
			e.printStackTrace();
		}
	}

}
