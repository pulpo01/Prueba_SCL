package com.tmmas.cl.scl.tasacion.service.servicios;
import javax.ejb.SessionContext;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionTasacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionTasacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Cliente;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.productdomain.businessobject.bo.PlanTarifario;
import com.tmmas.cl.scl.productdomain.businessobject.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.tasacion.service.helper.Global;


public class TasacionSrv {
	
	private PlanTarifario planTarifarioBO  = new PlanTarifario();	
	private Cliente clienteBO = new Cliente();	
	Global global = Global.getInstance();
	
	private final Logger logger = Logger.getLogger(TasacionSrv.class);
	private SessionContext context = null;
	private CompositeConfiguration config;
	
	public TasacionSrv()
	{
		logger.debug("AltaClienteSrv():Begin");
		config = UtilProperty.getConfigurationfromExternalFile("PortalVentas.properties");
		UtilLog.setLog(config.getString("TasacionSrv.log"));
		logger.debug("AltaClienteSrv():End");
	}
	
	public ResultadoValidacionTasacionDTO validacionLinea(ParametrosValidacionTasacionDTO parametroEntrada)
		throws ProductDomainException,CustomerDomainException
	{
		ResultadoValidacionTasacionDTO resultado = new ResultadoValidacionTasacionDTO();
		logger.debug("Inicio:ValidacionLinea()");
		parametroEntrada.setCodigoProducto(global.getCodigoProducto());
		parametroEntrada.setCodigoTecnologia(global.getValor("codigo.tecnologia.GSM"));
		
		resultado = planTarifarioBO.existePlanTarifario(parametroEntrada);	
		if (!resultado.isResultado())
		{			
			resultado.setEstado("NOK");
			resultado.setDetalleEstado("Codigo Plan Tarifario no existe o no es válido");
		}else{			
			resultado.setEstado("OK");
			resultado.setDetalleEstado("-");
			PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
			planTarifario.setCodigoProducto(parametroEntrada.getCodigoProducto());
			planTarifario.setCodigoTecnologia(parametroEntrada.getCodigoTecnologia());
			planTarifario.setCodigoPlanTarifario(parametroEntrada.getCodigoPlanTarifario());
			planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);
			resultado.setImporteCargoBasico(planTarifario.getImporteCargoBasico());			
			resultado.setTotalImporteCargoBasico(planTarifario.getImporteCargoBasico() + parametroEntrada.getTotalImporteCargoBasico()); 
			ClienteDTO cliente = new ClienteDTO();
			cliente.setCodigoCliente(parametroEntrada.getCodigoCliente());
			cliente = clienteBO.getCliente(cliente);			
			
			if (cliente.getCodigoEmpresa() > 0 && 
					!cliente.getCodigoPlanTarifario().equals(parametroEntrada.getCodigoPlanTarifario()))
			{
					resultado.setEstado("NOK");
					resultado.setCodigoError("-2217");
					resultado.setDetalleEstado("Plan Tarifario no corresponde al asignado a la Empresa");					
			}else if(!planTarifario.getTipoPlanTarifario().equals(global.getValor("identificador.individual")))
			{
				resultado.setEstado("NOK");
				resultado.setCodigoError("-2218");
				resultado.setDetalleEstado("Plan Tarifario no es de tipo Individual");
			}
			
			//Validaciones asociadas al tipo de producto
			//Tipo producto = 0(pospago)			
			if( parametroEntrada.getTipoProducto().trim().equals("0"))
			{
				if(!planTarifario.getCodigoTipoPlan().trim().equals("2"))
				{
					resultado.setEstado("NOK");
					resultado.setCodigoError("-2217");
					resultado.setDetalleEstado("El tipo de plan tarifario no corresponde a Tipo Producto Pospago");
				}	else{
					resultado.setEstado("OK");					
					resultado.setDetalleEstado("-");
				}
			}else if( parametroEntrada.getTipoProducto().trim().equals("2"))
			{ //Tipo producto = 2(hibrido)
				if(!planTarifario.getCodigoTipoPlan().trim().equals("3"))
				{
					resultado.setEstado("NOK");
					resultado.setCodigoError("-2217");
					resultado.setDetalleEstado("El tipo de plan tarifario no corresponde a Tipo Producto Hibrido");
				}else{
					resultado.setEstado("OK");
					resultado.setDetalleEstado("-");
				}
			}else{
				resultado.setEstado("OK");
				resultado.setDetalleEstado("-");
			}
		}		
		logger.debug("Fin:ValidacionLinea()");		
		return resultado;
	}	
	
	
	public PlanTarifarioDTO getPlanTarifario(PlanTarifarioDTO entrada)
		throws ProductDomainException
	{
		PlanTarifarioDTO resultado = new PlanTarifarioDTO();		
		logger.debug("Inicio:getPlanTarifario()");
		entrada.setCodigoProducto(global.getCodigoProducto());
		entrada.setCodigoTecnologia(global.getValor("codigo.tecnologia.GSM"));
		resultado = planTarifarioBO.getPlanTarifario(entrada);	
		logger.debug("Fin:getPlanTarifario()");
		return resultado;
	}
	
}