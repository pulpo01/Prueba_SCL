package com.tmmas.scl.operations.crm.f.sel.negsal.srv;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.businessObject.bo.RegistroVentaBOFactory;
import com.tmmas.scl.framework.customerDomain.customerBillABE.businessObject.bo.interfaces.RegistroVentaBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerBillABE.businessObject.bo.interfaces.RegistroVentaBOIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.OrdenServicioBOFactory;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.OrdenServicioBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.OrdenServicioIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.DireccionOficinaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.IngresoVentaDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.exception.NegSalException;
import com.tmmas.scl.operations.crm.f.sel.negsal.helper.Global;
import com.tmmas.scl.operations.crm.f.sel.negsal.interfaces.GestionPresupuestoSrvIF;

public class GestionPresupuestoSrv implements GestionPresupuestoSrvIF{

	private final Logger logger = Logger.getLogger(GestionPresupuestoSrv.class);
	
	private OrdenServicioBOFactoryIT factoryBO1 = new OrdenServicioBOFactory();
	private RegistroVentaBOFactoryIT factoryBO2 = new RegistroVentaBOFactory();
	
	private OrdenServicioIT ordenServicioBO = factoryBO1.getBusinessObject1();
	private RegistroVentaBOIT registroVentaBO = factoryBO2.getBusinessObject1();
	
	private Global global = Global.getInstance();
	
	public RetornoDTO registrarVenta(IngresoVentaDTO venta) throws NegSalException{
		RetornoDTO respuesta = null;
		logger.debug("registrarVenta():start");
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
			
			//parametros entrada :
			//numVenta
			//codCliente
			//usuario
			//codModVenta
			//codCuota
			//codTipDocum
			
			venta.setCodProducto(Integer.parseInt(global.getValor("codigo.producto"))); //codProducto
			venta.setFecVenta(new java.util.Date()); //fecVenta
			venta.setNumUnidades(1); //numUnidades
			venta.setIndEstVenta(global.getValor("estado.venta.aceptada")); //indEstVenta
			venta.setIndTipVenta(1); //indTipVenta
			venta.setTipFoliacion(global.getValor("tipo.foliacion.autofoliado"));//tipFoliacion
			venta.setIndVenta(global.getValor("indicador.tipo.venta.web"));
			
		    int codModVentaRegalo = Integer.parseInt(global.getValor("codigo.modalidad.venta.regalo"));
		    int codModVentaComodato= Integer.parseInt(global.getValor("codigo.modalidad.venta.comodato"));
		    
			if (venta.getCodModVenta()==codModVentaRegalo || venta.getCodModVenta()==codModVentaComodato){
				venta.setIndPasoCob(1); //indPasoCob
			}else{
				venta.setIndPasoCob(0);
			}
			logger.debug("CodProducto:"+venta.getCodProducto());
			
			//obtener vendedor  (usuario)
			UsuarioDTO usuario = new UsuarioDTO();
			usuario.setNombre(venta.getNomUsuarioVenta());
			usuario = ordenServicioBO.obtenerVendedor(usuario);
			venta.setCodVendedor(usuario.getCodigo()); //codVendedor
			venta.setCodOficina(usuario.getCodOficina()); //codOficina
			venta.setCodTipComis(usuario.getCodTipComis()); //codTipComis
			logger.debug("usuario.codigo:"+usuario.getCodigo());
			
			//obtener direccion oficina
			DireccionOficinaDTO direccion = new DireccionOficinaDTO();
			direccion = ordenServicioBO.obtenerDireccionOficina(venta.getCodOficina());
			venta.setCodRegion(direccion.getCodRegion()); //codRegion
			venta.setCodProvincia(direccion.getCodProvincia()); //codProvincia
			venta.setCodCiudad(direccion.getCodCiudad()); //codCiudad
			venta.setCodPlaza(direccion.getCodPlaza()); //codPlaza
			
			//obtener vendedor raiz (vendedor)
			venta.setCodVendedorAgente(ordenServicioBO.obtenerVendedorRaiz(new Integer(venta.getCodVendedor())).intValue());
			
			//obtener codigo operadora (cliente)
			venta.setCodOperadora(ordenServicioBO.obtenerOperadora(new Long(venta.getCodCliente())));

			if (venta.getCodPlaza()==null || venta.getCodPlaza().equals("") 
					|| venta.getCodOperadora()==null || venta.getCodOperadora().equals("")){
				throw new NegSalException("1",0, "Error al recuperar datos para Insertar Venta");
			}
		
			//Validar que exista tipo de comisionista
			if (venta.getCodTipComis()==null || venta.getCodTipComis().equals("")){
				throw new NegSalException("1",0, "Error vendedor sin código de comisionista para Insertar Venta");
			}
			
 		    respuesta = ordenServicioBO.registrarVenta(venta);
			logger.debug("registrarVenta():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new NegSalException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new NegSalException(e);
		}
		return respuesta;		
	}
}
