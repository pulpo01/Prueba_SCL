package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.AtributosCargoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.AtributosMigracionDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.MonedaDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.PrecioDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.CargosObtenidosDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.CargoWebDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ListaProdContratadosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class CargosAboLimiteConsumoAction extends BaseAction{
	
	private final Logger logger = Logger.getLogger(CargosAboLimiteConsumoAction.class);
	private Global global = Global.getInstance();
	
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();

	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)throws Exception {
				
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		logger.debug("No se cobran cargos abono a limites de consumo");
		String SIGUIENTE="frameworkCargos";
		HttpSession session = request.getSession(false);
		
		ListaProdContratadosForm listaProdContratadosForm = (ListaProdContratadosForm)form;
		boolean condicionesCK = listaProdContratadosForm.isCondicionesCK();
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	    
		//CambiarPlanForm cambiarPlanForm = (CambiarPlanForm)session.getAttribute("CambiarPlanForm");
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");

	    /**
	     * @author rlozano
	     * @description Se debe ir a buscar cargos. El action de cargos discrimina si aplica o no la pantalla de descuentos.
	     * @date 23-10-2008
	     */
		/*if (condicionesCK==true){
	        sessionData.setObtenerCargos("NO");
		}else {
			sessionData.setObtenerCargos("SI");			
		}	*/		
		sessionData.setObtenerCargos("SI");	

		ArrayList listaCargosAMostrar=(ArrayList) session.getAttribute("listaCargosAMostrar");
		ArrayList listaCargosRecurrentes=(ArrayList) session.getAttribute("listaCargosRecurrentes");
		
		ObtencionCargosDTO obtCargos = new ObtencionCargosDTO();
		ObtencionCargosDTO obtCargosRec = new ObtencionCargosDTO();
		CargosDTO [] cargos = new CargosDTO [listaCargosAMostrar.size()];
		CargosDTO [] cargosRec = new CargosDTO [listaCargosRecurrentes.size()];
		
		extraerCargos(sessionData, listaCargosAMostrar, cargos);
		extraerCargos(sessionData, listaCargosRecurrentes, cargosRec);
		
		obtCargos.setCargos(cargos);
		obtCargosRec.setCargos(cargosRec);
		
		CargosObtenidosDTO cargosObtenidos = new CargosObtenidosDTO();
		cargosObtenidos.setOcacionales(obtCargos);
	   	cargosObtenidos.setRecurrentes(obtCargosRec);
	   	sessionData.setCargosObtenidos(cargosObtenidos);
		
		return mapping.findForward(SIGUIENTE);
	}

	private void extraerCargos(ClienteOSSesionDTO sessionData, ArrayList listaCargos, CargosDTO[] cargos) {
		CargoWebDTO cargoWeb;
		for(int i=0;i<listaCargos.size();i++)
		{
			cargoWeb = (CargoWebDTO) listaCargos.get(i);
			CargosDTO cargo = new CargosDTO();
			
			PrecioDTO precio = new PrecioDTO();
			precio.setMonto(Float.parseFloat(cargoWeb.getImporte()));
			precio.setCodigoConcepto(cargoWeb.getCodConcepto());
			precio.setDescripcionConcepto(cargoWeb.getDescripcion());
			precio.setFechaAplicacion(null);
			precio.setValorMaximo("0");
			precio.setValorMinimo("0");
			precio.setIndicadorAutMan("0");//TODO 0 es cargo automatico; 1 cargo manual
			
			MonedaDTO moneda = new MonedaDTO();
			moneda.setCodigo(cargoWeb.getMoneda());
			moneda.setDescripcion(cargoWeb.getDesMoneda());
			
			precio.setUnidad(moneda);
			AtributosMigracionDTO atrMig = new AtributosMigracionDTO();
			atrMig.setInd_equipo("0");
			atrMig.setInd_paquete("0");
			atrMig.setNumAbonado(""+sessionData.getAbonados()[0].getNumAbonado());
			logger.debug("CargosContDescPlanAction extraerCargos atrMig.setNumAbonado : "+sessionData.getAbonados()[0].getNumAbonado());
			precio.setDatosAnexos(atrMig);
			cargo.setPrecio(precio);
			cargo.setCantidad(Integer.parseInt(cargoWeb.getCantidad()));
			
			
			if(cargoWeb.getDescuentos() != null && 
			   cargoWeb.getDescuentos().getDescuentoList() != null && 
			   cargoWeb.getDescuentos().getDescuentoList().length>0 &&
			   cargoWeb.getDescuentos().getDescuentoList()[0] != null)
			{
				DescuentoDTO descuento = new DescuentoDTO();
				if(cargoWeb.getDescuentos().getDescuentoList()[0].getValDescuento() !=null)
				{
					//(+) EV 07/01/09
					if("M".equals(cargoWeb.getDescuentos().getDescuentoList()[0].getTipDescuento())){
						descuento.setMonto(Float.parseFloat(cargoWeb.getDescuentos().getDescuentoList()[0].getValDescuento())*Integer.parseInt(cargoWeb.getCantidad()));
					}else{
						descuento.setMonto(Float.parseFloat(cargoWeb.getDescuentos().getDescuentoList()[0].getValDescuento()));
					}
					//(-) EV 07/01/09
				}
				descuento.setTipo("0");//TODO revisar tipo auto o manual
				descuento.setCodigoConceptoCargo(cargoWeb.getDescuentos().getDescuentoList()[0].getCodConcepto());
				descuento.setCodigoConcepto(cargoWeb.getDescuentos().getDescuentoList()[0].getCodConceptoDescuento());
				descuento.setTipoAplicacion("1");
				if("M".equals(cargoWeb.getDescuentos().getDescuentoList()[0].getTipDescuento()))
				{
					descuento.setTipoAplicacion("0");
				}
				descuento.setCodigoMoneda(cargoWeb.getDescuentos().getDescuentoList()[0].getCodMoneda());
				
				DescuentoDTO[] descuentoArr = new DescuentoDTO[1];
				descuentoArr[0]=descuento;
				cargo.setDescuento(descuentoArr);
			}

			AtributosCargoDTO atrCargos = new AtributosCargoDTO();
			atrCargos.setNumAbonado(String.valueOf(sessionData.getCliente().getAbonados().getAbonados()[0].getNumAbonado()));
			cargo.setAtributo(atrCargos);
			cargos[i] =  cargo;
		}
	}

}
