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
import com.tmmas.scl.framework.ProductDomain.dto.DatosCentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TecnologiaDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.CambioSimCardBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.BuscaSimcardForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.frmkooss.web.dto.ArticuloAjaxDTO;
import com.tmmas.scl.operations.frmkooss.web.dto.SerieAjaxDTO;
import com.tmmas.scl.vendedor.dto.VendedorDTO;

public class BuscaSimcardAction extends DispatchAction {
	
	private final Logger logger = Logger.getLogger(BuscaSimcardAction.class);
	private Global global = Global.getInstance();
	private CambioSimCardBussinessDelegate delegate = CambioSimCardBussinessDelegate.getInstance();

	public ActionForward inicioSimcard(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("inicioSimcard, inicio");
		BuscaSimcardForm buscaSimcardForm = (BuscaSimcardForm)form;
		buscaSimcardForm.setLinkOrigen("SIMCARD");
		buscaSimcardForm.setCodProcedencia(global.getValor("serie.procedencia.interna"));
		inicializar(buscaSimcardForm,request);

		logger.debug("inicioSimcard, fin");
		
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
		BuscaSimcardForm buscaSimcardForm = (BuscaSimcardForm)form;
		VendedorDTO vendedorDTO = new VendedorDTO();
		// Se obtiene usuario del sistema
		UsuarioSistemaDTO usuarioSistema = new UsuarioSistemaDTO();		
		long codVendedor = 0;
		try{
			//String codProcedencia = "";
			String codHLR = "";
		
			//(+)busca modalidad de venta y vendedor
			if (sesion.getAttribute("oossComisionable").toString().equals("SI") && sesion.getAttribute("Vendedor")!=null) {
				vendedorDTO=(VendedorDTO)sesion.getAttribute("Vendedor");
				codVendedor = Long.parseLong(vendedorDTO.getCod_vendedor());				
			} else if (codVendedor==0){
				usuarioSistema = (UsuarioSistemaDTO)sesion.getAttribute("usuarioSistema");
				codVendedor = usuarioSistema.getCod_vendedor();				
			}
									
			usuarioAbonado = (UsuarioAbonadoDTO)sesion.getAttribute("usuarioAbonado");		
			long codModVenta = usuarioAbonado.getCod_modventa();
			//if( codVendedor != null && !codVendedor.trim().equals(""))	{
				//codProcedencia = "1";
			//}	
			//(-)
			
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
			
      	    
			//Obtener Datos de la central
			ClienteOSSesionDTO sessionData = (ClienteOSSesionDTO)sesion.getAttribute("ClienteOOSS");
			AbonadoDTO[] abonados = sessionData.getAbonados();
			int codCentral = abonados[0].getCodCentral();
			DatosCentralDTO datosCentralDTO = delegate.obtenerDatosCentral(codCentral);
			serieDTO.setCod_central(datosCentralDTO.getCod_central());
			serieDTO.setCod_hlr(datosCentralDTO.getCod_hlr());	
			
			TecnologiaDTO tecnologia = new TecnologiaDTO();
			tecnologia.setCod_tecnologia(articuloDTO.getCod_tecnologia());
										
			serieDTO.setCod_bodega(Long.parseLong(buscaSimcardForm.getCodBodega()));
			serieDTO.setCod_articulo(Long.parseLong(buscaSimcardForm.getCodArticulo()));
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
			logger.debug("cod hlr: "+serieDTO.getCod_hlr());
			logger.debug("cod central: "+serieDTO.getCod_central());
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
			if (serieAjaxDTOs!=null && serieAjaxDTOs.length>0) {
				buscaSimcardForm.setSerieAjaxDTOs(serieAjaxDTOs);
				sesion.setAttribute("listaSeries",serieAjaxDTOs);
				buscaSimcardForm.setMensaje("");
			} else {
				buscaSimcardForm.setSerieAjaxDTOs(null);
				buscaSimcardForm.setMensaje("No se encontraron números de series para los datos seleccionados.");
			}			
		}catch(Exception e){
        	String mensaje = e.getMessage()==null?" ":", "+e.getMessage();
			logger.error("Ocurrio un error al obtener series "+mensaje, e);
			buscaSimcardForm.setSerieAjaxDTOs(null);
			buscaSimcardForm.setMensaje("No se encontraron números de series para los datos seleccionados.");
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
		BuscaSimcardForm buscaSimcardForm = (BuscaSimcardForm)form;		
		String codHLR = "";
		VendedorDTO vendedorDTO = new VendedorDTO();
		try{
			long codVendedor = 0;
			long codModVenta = 0;					
			//String codProcedencia = "";
			String serie = "";			
			//(+) busca modalidad de venta y vendedor				
			serie = buscaSimcardForm.getTxtFiltro(); 	

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
			
			//Obtener Datos de la central
			ClienteOSSesionDTO sessionData = (ClienteOSSesionDTO)sesion.getAttribute("ClienteOOSS");
			AbonadoDTO[] abonados = sessionData.getAbonados();
			int codCentral = abonados[0].getCodCentral();
			DatosCentralDTO datosCentralDTO = delegate.obtenerDatosCentral(codCentral);
		
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
					
			
			serieDTO.setCod_central(datosCentralDTO.getCod_central());
			
			TecnologiaDTO tecnologia = new TecnologiaDTO();
			tecnologia.setCod_tecnologia(articuloDTO.getCod_tecnologia());
			
		
			serieDTO.setCod_hlr(datosCentralDTO.getCod_hlr());
			
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
				buscaSimcardForm.setSerieAjaxDTOs(serieAjaxDTOs);
				sesion.setAttribute("listaSeries",serieAjaxDTOs);
				buscaSimcardForm.setMensaje("");
			} else {
				buscaSimcardForm.setSerieAjaxDTOs(null);
				buscaSimcardForm.setMensaje("No se encontraron números de series para los datos seleccionados.");
			}			
		}catch(Exception e){
        	String mensaje = e.getMessage()==null?" ":", "+e.getMessage();
			logger.error("Ocurrio un error al obtener series "+mensaje, e);
			buscaSimcardForm.setSerieAjaxDTOs(null);
			buscaSimcardForm.setMensaje("No se encontraron números de series para los datos seleccionados.");
		}
		logger.debug("obtenerSeries:fin()");		
		
		return mapping.findForward("inicio");
	}
		
	
	public ActionForward cancelar(ActionMapping mapping, BuscaSimcardForm buscaSimcardForm,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.debug("cancelar, inicio");
		HttpSession sesion = request.getSession(false);
		sesion.removeAttribute("serieSel");
		buscaSimcardForm.setSerieAjaxDTOs(null);
		logger.debug("cancelar, fin");
		
		return mapping.findForward("inicio");
		
	}
	public ActionForward irAMenu(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		
		return mapping.findForward("irAMenu");
	}
	
	private void inicializar(BuscaSimcardForm buscaSimcardForm,HttpServletRequest request ) throws Exception  {
		HttpSession sesion= request.getSession(false);
		
		SerieAjaxDTO serieSel = null;
		//(+)Actualiza numero ya ingresado
		if (sesion.getAttribute("serieSel")!=null){
			serieSel = (SerieAjaxDTO)sesion.getAttribute("serieSel");
			buscaSimcardForm.setNumeroSerieSel(serieSel.getNumSerie());
			buscaSimcardForm.setCodProcedencia(serieSel.getCodProcedencia());
			buscaSimcardForm.setCodArticulo(serieSel.getCodArticuloEquipo());
			
		}else{
			buscaSimcardForm.setNumeroSerieSel("");
			if (buscaSimcardForm.getLinkOrigen().equals("SIMCARD")){				
				buscaSimcardForm.setEquipoAnteriorRes("");
			}
		}
		//(-)
		
		//carga combo procedencia
		if (buscaSimcardForm.getArrayProcedencia()==null){
			DatosGeneralesDTO[] arrayProcedencia = new DatosGeneralesDTO[2];
			DatosGeneralesDTO datosGenerales = new DatosGeneralesDTO();
			datosGenerales.setCodigoParametro(global.getValor("serie.procedencia.interna"));
			datosGenerales.setValorParametro("INTERNA");
			arrayProcedencia[0] = datosGenerales;
			datosGenerales = new DatosGeneralesDTO();
			datosGenerales.setCodigoParametro(global.getValor("serie.procedencia.externa"));
			datosGenerales.setValorParametro("EXTERNA");
			arrayProcedencia[1] = datosGenerales;
			buscaSimcardForm.setArrayProcedencia(arrayProcedencia);
		}
		logger.debug("buscaSimcardForm.getArrayProcedencia().length= "+buscaSimcardForm.getArrayProcedencia().length);	
		//carga combo de bodegas
		
		// Se obtiene usuario del sistema
		UsuarioSistemaDTO usuarioSistema = new UsuarioSistemaDTO();
		usuarioSistema = (UsuarioSistemaDTO)sesion.getAttribute("usuarioSistema");
				
		//Se obtiene Vendedor				
		VendedorDTO vendedor = null;
		if (buscaSimcardForm.getArrayBodegas()==null){
			long  codVendedor = usuarioSistema.getCod_vendedor();
			BodegaDTO bodegaDTO = new BodegaDTO();
			//bodegaDTO.setCodVendedor((Long.parseLong(codVendedor)));
			bodegaDTO.setCodVendedor(codVendedor);
			BodegaDTO[] arrayBodegas = delegate.getBodegasXVendedor(bodegaDTO);
			buscaSimcardForm.setArrayBodegas(arrayBodegas);
			//for (int x = 0; x < arrayBodegas.length; x++) {
				//logger.debug("arrayBodegas[x].getCod_bodega()= "+arrayBodegas[x].getCod_bodega());
				//logger.debug("arrayBodegas[x].getDes_bodega()= "+arrayBodegas[x].getDes_bodega());
			//}

		}
		logger.debug("Total Bodegas = "+buscaSimcardForm.getArrayBodegas().length);
		//Obtener Central del Abonado
		UsuarioAbonadoDTO usuarioAbonado = (UsuarioAbonadoDTO)sesion.getAttribute("usuarioAbonado");
		//central	
		String modalidadPago  = (request.getParameter("modalidadPago")==null?"":(String)request.getParameter("modalidadPago"));	
		usuarioAbonado.setCod_modventa(Long.parseLong(modalidadPago));
		sesion.setAttribute("usuarioAbonado", usuarioAbonado);
		
		//carga combo de articulos
		
			String indEquipo = "";	
			if (buscaSimcardForm.getLinkOrigen().equals("SIMCARD")) indEquipo="S";
			
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
				buscaSimcardForm.setArrayArticulos(arrayArticulosAjax);
				logger.debug("buscaSimcardForm.getArrayArticulos().length= "+buscaSimcardForm.getArrayArticulos().length);	
			}
	
		//limpia combos
		//buscaSimcardForm.setCodCriterioBusqueda("");
		//buscaSimcardForm.setCodBodega("");
		//buscaSimcardForm.setCodArticulo("");
		buscaSimcardForm.setMensaje("");
		if (buscaSimcardForm.getEquipoAnteriorRes()== null) buscaSimcardForm.setEquipoAnteriorRes("");	
		
		//carga datos anteriores
		if (!buscaSimcardForm.getNumeroSerieSel().equals("") 
				&& buscaSimcardForm.getCodProcedencia().equals(global.getValor("serie.procedencia.interna"))){
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
		buscaSimcardForm.setCodArticuloKIT(parametro.getValor());				
	}//fin inicializar

}
