package com.tmmas.scl.operations.crm.f.s.manpro.test;


import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteListDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CatalogoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.EspecProductoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.web.delegate.ManageProspectBussinessDelegate;

public class TestAction extends Action 
{
	public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request, HttpServletResponse response) throws Exception 
	{
		ManageProspectBussinessDelegate delegate=ManageProspectBussinessDelegate.getInstance();
		
		ClienteDTO cliente=new ClienteDTO();
		cliente.setCodCliente(3517965);
		
		ClienteListDTO clienteList=null;
		
		VentaDTO dtoEntradaVenta=new VentaDTO();	
		dtoEntradaVenta.setIdVenta("3517965");	
		dtoEntradaVenta.setCliente(cliente);
		
		AbonadoDTO abon=new AbonadoDTO();
		abon.setNumAbonado(8567852);	
		
		NumeroDTO numero=new NumeroDTO();
		numero.setNro("6865874099");
		
		cliente=delegate.obtenerDatosClienteCuenta(dtoEntradaVenta); //[OK]			
				
		
		abon=delegate.obtenerDatosAbonado(abon);
		
		clienteList=delegate.buscarCliente(numero);	// [OK]
		
		//MAN PRO OFF INV
		//----------------------------------------------------------------------------------------------------------------------------
		ProductoOfertadoListDTO retorno=new ProductoOfertadoListDTO();			
		ProductoOfertadoListDTO dtoEntrada=new ProductoOfertadoListDTO();

		dtoEntrada.setCargoList(new CargoListDTO());
		dtoEntrada.setEspecProdList(new EspecProductoListDTO());
		ProductoOfertadoDTO[] prod=new ProductoOfertadoDTO[10];
		
		for(int i=0;i<10;i++)
		{
			prod[i]=new ProductoOfertadoDTO();
			prod[i].setIdProductoOfertado(String.valueOf(i+1));				
		}
		
		dtoEntrada.setProductoList(prod);
		
		AbonadoDTO abonado=new AbonadoDTO();
		abonado.setNumAbonado(16842670);
		abonado.setCodCliente(64985647);
		
		PlanTarifarioDTO planTarifario= new PlanTarifarioDTO();
		CatalogoDTO catalogo=new CatalogoDTO();
		
		Calendar cal= Calendar.getInstance();			
		cal.set(3000, 6, 31);
		
		catalogo.setCodCanal("VT");
		catalogo.setFecInicioVigencia(new Date());
		catalogo.setFecTerminoVigencia(new Date(cal.getTimeInMillis()));
		
		abonado.setCatalogo(catalogo);
		
		
		abonado.setPlanTarifario(new PlanTarifarioDTO());
		abonado.getPlanTarifario().setPaqueteDefault(new PaqueteDTO());
		abonado.getPlanTarifario().getPaqueteDefault().setCodProdPadre("13");
		
		PaqueteDTO paquete=new PaqueteDTO();
		paquete.setCodProdPadre("PFR092");
		
		retorno=delegate.obtenerDetalleProductos(dtoEntrada);	//[OK]		
		
		retorno=delegate.obtenerProductosPorDefecto(abonado); //[OK]
		
		retorno=delegate.obtenerProductosOfertables(abonado);	//[OK]
		
		retorno=delegate.obtenerProductosOfertablesPorPaquete(paquete); //[OK]			

		
		ProductoOfertadoListDTO restLista=new ProductoOfertadoListDTO();
		
		restLista.setCargoList(new CargoListDTO());
		restLista.setEspecProdList(new EspecProductoListDTO());
		restLista.setProductoList(new ProductoOfertadoDTO[10]);
		
		//delegate.obtenerRestriccionesLista(restLista); // [NO OK]
		
		
		
				
		return mapping.findForward("producto");
	}
}