package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.scl.framework.ProductDomain.dto.ArticuloInDTO;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TecnologiaDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.CambioSerieBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.BuscaSeriesForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.frmkooss.web.dto.ArticuloAjaxDTO;
import com.tmmas.scl.operations.frmkooss.web.dto.SerieAjaxDTO;
import com.tmmas.scl.vendedor.dto.VendedorDTO;

public class BuscaSeriesAction extends DispatchAction {
	
	private final Logger logger = Logger.getLogger(BuscaSeriesAction.class);
	private Global global = Global.getInstance();
	private CambioSerieBussinessDelegate delegate = CambioSerieBussinessDelegate.getInstance();

	public ActionForward inicioEquipo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("inicioEquipo, inicio");
		BuscaSeriesForm buscaSeriesForm = (BuscaSeriesForm)form;
		buscaSeriesForm.setLinkOrigen("EQUIPO");
		buscaSeriesForm.setCodProcedencia(global.getValor("serie.procedencia.interna"));
		inicializar(buscaSeriesForm,request);

		logger.debug("inicioEquipo, fin");
		
		return mapping.findForward("inicio");
	}
	
	public ActionForward obtenerSeriesBodega(ActionMapping mapping, ActionForm form,HttpServletRequest request, HttpServletResponse response)throws Exception {
		logger.debug("obtenerSeriesBodega:inicio()");

		HttpSession sesion= request.getSession(false);		
		//VendedorDTO vendedor = new VendedorDTO();		
		UsuarioAbonadoDTO usuarioAbonado = new UsuarioAbonadoDTO();
		SerieAjaxDTO[] serieAjaxDTOs = null;
		SerieDTO[] listaSeries = null;
		SimpleDateFormat formaBD = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		SimpleDateFormat formatJava = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
		BuscaSeriesForm buscaSeriesForm = (BuscaSeriesForm)form;
		VendedorDTO vendedorDTO = new VendedorDTO();
		try{
			//String codProcedencia = "";
			String codHLR = "";
			long codVendedor = 0;
			//(+)busca modalidad de venta y vendedor
						 
			// Se obtiene usuario del sistema
			UsuarioSistemaDTO usuarioSistema = new UsuarioSistemaDTO();
			usuarioSistema = (UsuarioSistemaDTO)sesion.getAttribute("usuarioSistema");
						
			usuarioAbonado = (UsuarioAbonadoDTO)sesion.getAttribute("usuarioAbonado");
			
			if (sesion.getAttribute("oossComisionable").toString().equals("SI")&& sesion.getAttribute("Vendedor")!=null) {
				vendedorDTO=(VendedorDTO)sesion.getAttribute("Vendedor");
				codVendedor = Long.parseLong(vendedorDTO.getCod_vendedor());			
			} else if (codVendedor==0){
				usuarioSistema = (UsuarioSistemaDTO)sesion.getAttribute("usuarioSistema");
				codVendedor = usuarioSistema.getCod_vendedor();				
			}				
			long codModVenta = usuarioAbonado.getCod_modventa();
	
			
			SerieDTO serieDTO = new SerieDTO();

			serieDTO.setCodCanal(Integer.parseInt(global.getValor("serie.procedencia.interna")));
			serieDTO.setCodModVenta(new Long(codModVenta).intValue());
			serieDTO.setCod_vendedor(codVendedor);//447
			//logger.debug("serieDTO.getCod_vendedor() = "+serieDTO.getCod_vendedor());
			serieDTO.setTipArticulo(global.getValor("codigo.tipo.articulo.serie"));
			ArticuloInDTO articuloDTO = (ArticuloInDTO)sesion.getAttribute("articulo");

			serieDTO.setCodTecnologia(articuloDTO.getCod_tecnologia());
			serieDTO.setTipTerminal(articuloDTO.getTipTerminal());
			serieDTO.setCod_uso(new Integer(articuloDTO.getCodUso()).longValue());
			
      	    
			CentralDTO centralDTO = new CentralDTO();
			centralDTO = (CentralDTO)sesion.getAttribute("central");			
			
			serieDTO.setCod_central(centralDTO.getCod_central());
			
			TecnologiaDTO tecnologia = new TecnologiaDTO();
			tecnologia.setCod_tecnologia(articuloDTO.getCod_tecnologia());
			CentralDTO[] listaCentral = delegate.obtenerCentralTecnologiaHlr(serieDTO, tecnologia );
			if (listaCentral!=null && listaCentral.length>0){
				codHLR = listaCentral[0].getCod_hlr();
			}
			serieDTO.setCod_hlr(codHLR);
			
		
			
			serieDTO.setCod_bodega(Long.parseLong(buscaSeriesForm.getCodBodega()));
			serieDTO.setCod_articulo(Long.parseLong(buscaSeriesForm.getCodArticulo()));
			logger.debug("canal (procedencia): "+serieDTO.getCodCanal());
			logger.debug("mod venta: "+serieDTO.getCodModVenta());
			logger.debug("vendedor: "+serieDTO.getCod_vendedor());
			logger.debug("tip articulo: "+serieDTO.getTipArticulo());
			logger.debug("tecnologia: "+serieDTO.getCodTecnologia());
			logger.debug("terminal: "+serieDTO.getTipTerminal());
			logger.debug("uso: "+serieDTO.getCod_uso());
			logger.debug("central: "+serieDTO.getCod_central());
			logger.debug("bodega: "+serieDTO.getCod_bodega());
			logger.debug("cod articulo: "+serieDTO.getCod_articulo());
			listaSeries = delegate.listarSerie(serieDTO);
			
			serieAjaxDTOs =  new SerieAjaxDTO[listaSeries.length];
			logger.debug("listaSeries.length: "+listaSeries.length);
			for(int i=0; i<listaSeries.length;i++){
				SerieAjaxDTO serieAjaxDTO = new SerieAjaxDTO();
				serieAjaxDTO.setNumTelefono(String.valueOf(listaSeries[i].getNum_telefono()));
				serieAjaxDTO.setNumSerie(listaSeries[i].getNum_serie());
				//serieAjaxDTO.setFecha(listaSeries[i].getFec_entrada());
				if (listaSeries[i].getFec_entrada()!=null){
					serieAjaxDTO.setFecha(formatJava.format(listaSeries[i].getFec_entrada()));
				}
				serieAjaxDTOs[i] = serieAjaxDTO;
			}
			logger.debug("series encontradas: "+serieAjaxDTOs.length);
			logger.debug("INC-157171 JMO 07-12-2010: Validacion imei con abon. AAA");
			if (serieAjaxDTOs!=null && serieAjaxDTOs.length>0) {
				buscaSeriesForm.setSerieAjaxDTOs(serieAjaxDTOs);
				sesion.setAttribute("listaSeries",serieAjaxDTOs);
				buscaSeriesForm.setMensaje("");
			} else {
				buscaSeriesForm.setSerieAjaxDTOs(null);
				buscaSeriesForm.setMensaje("No se encontraron números de series para los datos seleccionados.");
			}			
		}catch(Exception e){
        	String mensaje = e.getMessage()==null?" ":", "+e.getMessage();
			logger.error("Ocurrio un error al obtener series "+mensaje, e);
			buscaSeriesForm.setSerieAjaxDTOs(null);
			buscaSeriesForm.setMensaje("No se encontraron números de series para los datos seleccionados.");
		}
		
		logger.debug("obtenerSeriesBodega:fin()");		
		return mapping.findForward("inicio");
	}		
	
	public ActionForward obtenerSeries(ActionMapping mapping, ActionForm form,HttpServletRequest request, HttpServletResponse response)throws Exception {
		logger.debug("obtenerSeries:inicio()");
		HttpSession sesion= request.getSession(false);				
		UsuarioAbonadoDTO usuarioAbonado = new UsuarioAbonadoDTO();
		SerieAjaxDTO[] serieAjaxDTOs = null;
		SerieDTO[] listaSeries = null;
		SimpleDateFormat formaBD = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		SimpleDateFormat formatJava = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
		BuscaSeriesForm buscaSeriesForm = (BuscaSeriesForm)form;		
		String codHLR = "";
		VendedorDTO vendedorDTO = new VendedorDTO();
		try{
			long codVendedor = 0;
			long codModVenta = 0;					
			//String codProcedencia = "";
			String serie = "";			
			//(+) busca modalidad de venta y vendedor				
			serie = buscaSeriesForm.getTxtFiltro(); 	

			// Se obtiene usuario del sistema
			UsuarioSistemaDTO usuarioSistema = new UsuarioSistemaDTO();
		
			usuarioAbonado = (UsuarioAbonadoDTO)sesion.getAttribute("usuarioAbonado");
			if (sesion.getAttribute("oossComisionable").toString().equals("SI")&& sesion.getAttribute("Vendedor")!=null) {
				vendedorDTO=(VendedorDTO)sesion.getAttribute("Vendedor");
				codVendedor = Long.parseLong(vendedorDTO.getCod_vendedor());				
			} else if (codVendedor==0) {
				usuarioSistema = (UsuarioSistemaDTO)sesion.getAttribute("usuarioSistema");
				codVendedor = usuarioSistema.getCod_vendedor();				
			}	
			codModVenta = usuarioAbonado.getCod_modventa();
		
			SerieDTO serieDTO = new SerieDTO();
			serieDTO.setNum_serie(serie);
			serieDTO.setCodCanal(Integer.parseInt(global.getValor("serie.procedencia.interna")));
			serieDTO.setCodModVenta(new Long(codModVenta).intValue());
			serieDTO.setCod_vendedor(codVendedor);//447			
			serieDTO.setTipArticulo(global.getValor("codigo.tipo.articulo.serie"));
			ArticuloInDTO articuloDTO = (ArticuloInDTO)sesion.getAttribute("articulo");

			serieDTO.setCodTecnologia(articuloDTO.getCod_tecnologia());
			serieDTO.setTipTerminal(articuloDTO.getTipTerminal());
			serieDTO.setCod_uso(new Integer(articuloDTO.getCodUso()).longValue());
			
      	    
			CentralDTO centralDTO = new CentralDTO();
			centralDTO = (CentralDTO)sesion.getAttribute("central");			
			
			serieDTO.setCod_central(centralDTO.getCod_central());
			
			TecnologiaDTO tecnologia = new TecnologiaDTO();
			tecnologia.setCod_tecnologia(articuloDTO.getCod_tecnologia());
			
			CentralDTO[] listaCentral = delegate.obtenerCentralTecnologiaHlr(serieDTO, tecnologia );
			if (listaCentral!=null && listaCentral.length>0){
				codHLR = listaCentral[0].getCod_hlr();
			}
			serieDTO.setCod_hlr(codHLR);
			
			logger.debug("canal (procedencia): "+serieDTO.getCodCanal());
			logger.debug("mod venta: "+serieDTO.getCodModVenta());
			logger.debug("vendedor: "+serieDTO.getCod_vendedor());
			logger.debug("tip articulo: "+serieDTO.getTipArticulo());
			logger.debug("tecnologia: "+serieDTO.getCodTecnologia());
			logger.debug("terminal: "+serieDTO.getTipTerminal());
			logger.debug("uso: "+serieDTO.getCod_uso());
			logger.debug("central: "+serieDTO.getCod_central());
			logger.debug("numserie: "+serieDTO.getNum_serie());
			logger.debug("cod articulo: "+serieDTO.getCod_articulo());
			listaSeries = delegate.buscarSerie(serieDTO);
			
			serieAjaxDTOs =  new SerieAjaxDTO[listaSeries.length];
			for(int i=0; i<listaSeries.length;i++){
				SerieAjaxDTO serieAjaxDTO = new SerieAjaxDTO();
				serieAjaxDTO.setNumTelefono(String.valueOf(listaSeries[i].getNum_telefono()));
				serieAjaxDTO.setNumSerie(listaSeries[i].getNum_serie());
				//serieAjaxDTO.setFecha(listaSeries[i].getFec_entrada());
				if (listaSeries[i].getFec_entrada()!=null){
					serieAjaxDTO.setFecha(formatJava.format(listaSeries[i].getFec_entrada()));
				}
				serieAjaxDTOs[i] = serieAjaxDTO;
			}
			logger.debug("series encontradas: "+serieAjaxDTOs.length);
			if (serieAjaxDTOs!=null && serieAjaxDTOs.length>0) {
				buscaSeriesForm.setSerieAjaxDTOs(serieAjaxDTOs);
				sesion.setAttribute("listaSeries",serieAjaxDTOs);
				buscaSeriesForm.setMensaje("");
			} else {
				buscaSeriesForm.setSerieAjaxDTOs(null);
				buscaSeriesForm.setMensaje("No se encontraron números de series para los datos seleccionados.");
			}			
		}catch(Exception e){
        	String mensaje = e.getMessage()==null?" ":", "+e.getMessage();
			logger.error("Ocurrio un error al obtener series "+mensaje, e);
			buscaSeriesForm.setSerieAjaxDTOs(null);
			buscaSeriesForm.setMensaje("No se encontraron números de series para los datos seleccionados.");
		}
		logger.debug("obtenerSeries:fin()");		
		
		return mapping.findForward("inicio");
	}
		
	
	public ActionForward cancelar(ActionMapping mapping, BuscaSeriesForm buscaSeriesForm,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.debug("cancelar, inicio");
		HttpSession sesion = request.getSession(false);
		sesion.removeAttribute("serieSel");
		buscaSeriesForm.setSerieAjaxDTOs(null);
		logger.debug("cancelar, fin");
		
		return mapping.findForward("inicio");
		
	}
	public ActionForward irAMenu(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		
		return mapping.findForward("irAMenu");
	}
	
	private void inicializar(BuscaSeriesForm buscaSeriesForm,HttpServletRequest request ) throws Exception  {
		HttpSession sesion= request.getSession(false);
		
		SerieAjaxDTO serieSel = null;
		//(+)Actualiza numero ya ingresado
		if (sesion.getAttribute("serieSel")!=null){
			serieSel = (SerieAjaxDTO)sesion.getAttribute("serieSel");
			buscaSeriesForm.setNumeroSerieSel(serieSel.getNumSerie());
			buscaSeriesForm.setCodProcedencia(serieSel.getCodProcedencia());
			buscaSeriesForm.setCodArticulo(serieSel.getCodArticuloEquipo());
			
		}else{
			buscaSeriesForm.setNumeroSerieSel("");
			if (buscaSeriesForm.getLinkOrigen().equals("EQUIPO")){				
				buscaSeriesForm.setEquipoAnteriorRes("");
			}
		}
		//(-)
		
		//carga combo procedencia
		if (buscaSeriesForm.getArrayProcedencia()==null){
			DatosGeneralesDTO[] arrayProcedencia = new DatosGeneralesDTO[2];
			DatosGeneralesDTO datosGenerales = new DatosGeneralesDTO();
			datosGenerales.setCodigoParametro(global.getValor("serie.procedencia.interna"));
			datosGenerales.setValorParametro("INTERNA");
			arrayProcedencia[0] = datosGenerales;
			datosGenerales = new DatosGeneralesDTO();
			datosGenerales.setCodigoParametro(global.getValor("serie.procedencia.externa"));
			datosGenerales.setValorParametro("EXTERNA");
			arrayProcedencia[1] = datosGenerales;
			buscaSeriesForm.setArrayProcedencia(arrayProcedencia);
		}
		logger.debug("buscaSeriesForm.getArrayProcedencia().length= "+buscaSeriesForm.getArrayProcedencia().length);	
		//carga combo de bodegas
		
		// Se obtiene usuario del sistema
		UsuarioSistemaDTO usuarioSistema = new UsuarioSistemaDTO();
		usuarioSistema = (UsuarioSistemaDTO)sesion.getAttribute("usuarioSistema");
				
		//Se obtiene Vendedor				
		//VendedorDTO vendedor = null;
		if (buscaSeriesForm.getArrayBodegas()==null){
			long  codVendedor = usuarioSistema.getCod_vendedor();
			BodegaDTO bodegaDTO = new BodegaDTO();
			//bodegaDTO.setCodVendedor((Long.parseLong(codVendedor)));
			bodegaDTO.setCodVendedor(codVendedor);
			BodegaDTO[] arrayBodegas = delegate.getBodegasXVendedor(bodegaDTO);
			buscaSeriesForm.setArrayBodegas(arrayBodegas);
			//for (int x = 0; x < arrayBodegas.length; x++) {
				//logger.debug("arrayBodegas[x].getCod_bodega()= "+arrayBodegas[x].getCod_bodega());
				//logger.debug("arrayBodegas[x].getDes_bodega()= "+arrayBodegas[x].getDes_bodega());
			//}

		}
		logger.debug("Total Bodegas = "+buscaSeriesForm.getArrayBodegas().length);
		//Obtener Central del Abonado
		UsuarioAbonadoDTO usuarioAbonado = (UsuarioAbonadoDTO)sesion.getAttribute("usuarioAbonado");
		//central	
		String modalidadPago  = (request.getParameter("modalidadPago")==null?"":(String)request.getParameter("modalidadPago"));	
		usuarioAbonado.setCod_modventa(Long.parseLong(modalidadPago));
		sesion.setAttribute("usuarioAbonado", usuarioAbonado);
		
		//carga combo de articulos
		
			String indEquipo = "";	
			if (buscaSeriesForm.getLinkOrigen().equals("EQUIPO")) indEquipo="E";
			
			String codTecnologia = "";
			String tipTerminal = "";
			String codUso = "0";
			
			//(+) busca tecnologia, terminal, y uso
			//tecnologia
			codTecnologia = (request.getParameter("tecnologia")==null?"":(String)request.getParameter("tecnologia"));
			//tipoTerminal
			tipTerminal = (request.getParameter("tipoTerminal")==null?"":(String)request.getParameter("tipoTerminal"));			
			//usoVentaEquip			
			codUso = (request.getParameter("usoVentaEquip")==null?"":(String)request.getParameter("usoVentaEquip"));
				
			logger.debug("codTecnologia="+codTecnologia);
			logger.debug("tipTerminal="+tipTerminal);
			logger.debug("indEquipo="+indEquipo);
			logger.debug("codUso="+codUso);	
			logger.debug("modalidadPago="+modalidadPago);	
			
			ArticuloInDTO articuloDTO =new ArticuloInDTO();
			articuloDTO.setCod_tecnologia(codTecnologia);
			articuloDTO.setTipTerminal(tipTerminal);
			articuloDTO.setIndEquipo(indEquipo);
			articuloDTO.setCodUso(Integer.parseInt(codUso));			
			sesion.setAttribute("articulo", articuloDTO);
			
			CentralDTO centralDTO = new CentralDTO();
			centralDTO.setCod_central(Long.parseLong("0"));
			sesion.setAttribute("central", centralDTO);
			ArticuloInDTO[] arrayArticulos = delegate.getArticulos(articuloDTO);
			logger.debug("arrayArticulos.length= "+arrayArticulos.length);	
			if (arrayArticulos!=null){
				
				ArticuloAjaxDTO[] arrayArticulosAjax = new ArticuloAjaxDTO[arrayArticulos.length];
				
				for(int i=0; i<arrayArticulos.length;i++){
					ArticuloInDTO articuloIn = (ArticuloInDTO)arrayArticulos[i];
					ArticuloAjaxDTO articuloAjax = new ArticuloAjaxDTO();
					articuloAjax.setCodArticulo(String.valueOf(articuloIn.getCodArticulo()));
					articuloAjax.setDesArticulo(articuloIn.getDesArticulo());
					articuloAjax.setTipoArticulo(String.valueOf(articuloIn.getTipoArticulo()));
					arrayArticulosAjax[i] = articuloAjax;
					//logger.debug("arrayArticulosAjax[i].getCodArticulo()= "+arrayArticulosAjax[i].getCodArticulo());
					//logger.debug("arrayArticulosAjax[i].getDesArticulo()= "+arrayArticulosAjax[i].getDesArticulo());
					//logger.debug("arrayArticulosAjax[i].getTipoArticulo()= "+arrayArticulosAjax[i].getTipoArticulo());
				}
				logger.debug("Total de Artculos= "+arrayArticulosAjax.length);
				buscaSeriesForm.setArrayArticulos(arrayArticulosAjax);
				logger.debug("buscaSeriesForm.getArrayArticulos().length= "+buscaSeriesForm.getArrayArticulos().length);	
			}
	
		//limpia combos
		//buscaSeriesForm.setCodCriterioBusqueda("");
		//buscaSeriesForm.setCodBodega("");
		//buscaSeriesForm.setCodArticulo("");
		buscaSeriesForm.setMensaje("");
		if (buscaSeriesForm.getEquipoAnteriorRes()== null) buscaSeriesForm.setEquipoAnteriorRes("");	
		
		//carga datos anteriores
		if (!buscaSeriesForm.getNumeroSerieSel().equals("") 
				&& buscaSeriesForm.getCodProcedencia().equals(global.getValor("serie.procedencia.interna"))){
			SerieAjaxDTO[] listaSeries = new SerieAjaxDTO[1];
			listaSeries[0] = serieSel;
			sesion.setAttribute("listaSeries", listaSeries);	
		}
			
		//obtener parametro TIP_ARTICULO_KIT
		ParametrosGeneralesDTO parametrosKit = new ParametrosGeneralesDTO();
		
		ParametroDTO parametro = new ParametroDTO();
		parametro.setCodProducto(Integer.parseInt(global.getValor("codigo.producto")));
		parametro.setCodModulo(global.getValor("codigo.modulo.AL"));
		parametro.setNomParametro(global.getValor("parametro.tip_articulo_kit"));
		parametro = delegate.obtenerParametroGeneral(parametro);
		buscaSeriesForm.setCodArticuloKIT(parametro.getValor());				
	}//fin inicializar

}
