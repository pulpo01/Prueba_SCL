package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

import java.util.Date;

import org.apache.commons.beanutils.converters.IntegerConverter;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.Formatting;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RestriccionesDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ParametrosCondicionesCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;

public class JCondicionesComerciales {
	private final Logger logger = Logger.getLogger(NumerosFrecuentes.class);
	private Global global = Global.getInstance();
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	private long codOSAnt;
	private String codActuacion;
	
	
public RetornoDTO getCondicionesComercialesOss(AbonadoListDTO abonadoListDTO, ParametrosCondicionesCPUDTO parametros)throws ManReqException{
		RetornoDTO retValue=null;
		SecuenciaDTO parametro = null;
		ConversionListDTO conversionList=null;
		try{
	
			ConversionDTO param = new ConversionDTO();
			param.setCodOOSS(parametros.getCodOOSS());
			param.setCodTipModi(parametros.getCombinatoriaGenerada());
			logger.debug("obtenerConversionOOSS():inicio");
			conversionList = delegate.obtenerConversionOOSS(param);
			this.codOSAnt = conversionList.getRegistros()[0].getCodOSAnt();
			this.codActuacion = conversionList.getRegistros()[0].getCodActuacion();
			logger.debug("codOSAnt              :"+codOSAnt);
			logger.debug("codActuacion          :"+codActuacion);
			logger.debug("obtenerConversionOOSS():fin");
			
			RestriccionesDTO restricciones = new RestriccionesDTO();
		    restricciones.setPrograma("GPA");
		    restricciones.setProceso("");
		    restricciones.setCodActuacion(this.codActuacion);
		    restricciones.setCodCliente(abonadoListDTO.getAbonados()[0].getCodCliente());
		    restricciones.setCodModGener("OSF");
		    restricciones.setCodOOSS(String.valueOf(this.codOSAnt));
		    restricciones.setCodVendedor(parametros.getUsuario());
		    restricciones.setDesactivacionSS(0);
		    restricciones.setPlanDestino(parametros.getCodPlanTarifSelec());
		    restricciones.setTipoPlanDestino(parametros.getTipoPlanTarifDestino());
		    restricciones.setFechaSistema(new Date());
		    restricciones.setCodTarea(0);
		    restricciones.setCodEvento(global.getValor("codigo.evento.cargar").trim());
		    restricciones.setCodModulo(global.getValor("codigo.modulo.GA"));
		    
				logger.debug("Metodo DWR : getCondicionesComercialesOss");
				logger.debug("=========================================");
			
			for (int i=0;i<abonadoListDTO.getAbonados().length;i++){
				
				restricciones.setNumAbonado(abonadoListDTO.getAbonados()[i].getNumAbonado());
				restricciones.setNumVenta(abonadoListDTO.getAbonados()[i].getNumVenta());
				try{
					restricciones.setCodUso(Integer.parseInt(abonadoListDTO.getAbonados()[i].getCodUso()));
				}
				catch(Exception e){
					restricciones.setCodUso(0);
				}
				restricciones.setCodCuentaOrigen(abonadoListDTO.getAbonados()[i].getCodCuenta());
				restricciones.setCodCuentaDestino(abonadoListDTO.getAbonados()[i].getCodCuenta());
				restricciones.setTipoPlan(abonadoListDTO.getAbonados()[i].getCodTipoPlanTarif());
				restricciones.setNumCiclo(abonadoListDTO.getAbonados()[i].getCodCiclo());
				restricciones.setCodCentral(abonadoListDTO.getAbonados()[i].getCodCentral());
				
				logger.debug("Numero Abonado		:"+restricciones.getNumAbonado());
				logger.debug("Numero venta			:"+restricciones.getNumVenta());
				logger.debug("Codigo Uso			:"+restricciones.getCodUso());
				logger.debug("Codigo Cuenta Origen	:"+restricciones.getCodCuentaOrigen());
				logger.debug("Codigo Cuenta Destino	:"+restricciones.getCodCuentaDestino());
				logger.debug("Tipo Plan				:"+restricciones.getTipoPlan());
				logger.debug("Numero Ciclo			:"+restricciones.getNumCiclo());
				logger.debug("Codigo Central		:"+restricciones.getCodCentral());
				parametro = new SecuenciaDTO();
			    parametro.setNomSecuencia("GA_SEQ_TRANSACABO");
				logger.debug("obtenerSecuencia():inicio");
				parametro = delegate.obtenerSecuencia(parametro);
				logger.debug("Secuencia de Parametro::"+parametro.getNumSecuencia());
				logger.debug("obtenerSecuencia():fin");
			    restricciones.setIdSecuencia(parametro.getNumSecuencia());
				retValue=delegate.validaRestriccionComerOoss(restricciones);
				if (!("0".equals(retValue.getCodigo()))){
					break;
				}
			}	
			
		}
		catch(GeneralException e){
			throw new ManReqException(e);
		}
		return retValue;
	}

}
