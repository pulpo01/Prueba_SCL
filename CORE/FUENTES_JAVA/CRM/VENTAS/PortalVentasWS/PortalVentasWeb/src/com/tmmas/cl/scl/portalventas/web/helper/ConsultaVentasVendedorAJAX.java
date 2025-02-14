package com.tmmas.cl.scl.portalventas.web.helper;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.altacliente.presentacion.dto.RetornoListaAjaxDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ListadoVentasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.VendedorAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.VentaAjaxDTO;

public class ConsultaVentasVendedorAJAX {
	private final Logger logger = Logger.getLogger(ConsultaVentasVendedorAJAX.class);

	private Global global = Global.getInstance();

	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	/*
	 * Carga la lista de vendedores dependiendo de la oficina seleccionada
	 */
	public RetornoListaAjaxDTO obtenerVendedores(String codOficina) {
		logger.debug("obtenerVendedores:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		VendedorAjaxDTO[] listaRetorno = null;
		VendedorDTO[] listaDistribuidores = null;
		try {
			VendedorDTO vendedorDTO = new VendedorDTO();
			vendedorDTO.setCodigoOficina(codOficina);
			logger.debug("codOficina=" + codOficina);
			listaDistribuidores = delegate.getListadoVendedoresXOficina(vendedorDTO);

			listaRetorno = new VendedorAjaxDTO[listaDistribuidores.length];
			for (int i = 0; i < listaDistribuidores.length; i++) {
				VendedorAjaxDTO vendedor = new VendedorAjaxDTO();
				vendedor.setCodigoVendedor(listaDistribuidores[i].getCodigoVendedor());
				vendedor.setNombreVendedor(listaDistribuidores[i].getNombreVendedor());
				listaRetorno[i] = vendedor;
			}

		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener vendedores " + mensaje);
		}
		retorno.setLista(listaRetorno);
		logger.debug("obtenerVendedores:fin()");
		return retorno;
	}

	public RetornoListaAjaxDTO obtenerVentasxVendedor(String numVenta, String codVendedor, String codOficina,
			String codCliente, String fechaDesde, String fechaHasta, String codEstadoVenta, String indOrigen) {
		logger.info("obtenerVentasxVendedor, inicio()");
		logger.debug("numVenta [" + numVenta + "]");
		logger.debug("codVendedor [" + codVendedor + "]");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}
		VentaAjaxDTO[] listaRetorno = null;
		ListadoVentasDTO[] listaVentas = null;
		long encontrados = 0;
		final String mensajeError = "Ocurrio un error al obtener ventas";
		try {
			if (numVenta.trim().equals(""))
				numVenta = "0";
			if (codVendedor.trim().equals(""))
				codVendedor = "0";
			if (codOficina.trim().equals(""))
				codOficina = "0";
			if (codCliente.trim().equals(""))
				codCliente = "0";
			if (codEstadoVenta.equals(""))
				codEstadoVenta = "0";
			ListadoVentasDTO listadoVentasDTO = new ListadoVentasDTO();
			listadoVentasDTO.setNroVenta(new Long(numVenta));
			listadoVentasDTO.setCodigoVendedor(new Long(codVendedor));
			listadoVentasDTO.setCodCliente(new Long(codCliente));
			listadoVentasDTO.setCodOficina(codOficina);
			listadoVentasDTO.setFechaDesde(fechaDesde);
			listadoVentasDTO.setFechaHasta(fechaHasta);
			listadoVentasDTO.setCodEstadoVenta(codEstadoVenta);
			listadoVentasDTO.setOrigen(indOrigen);
			listaVentas = delegate.getVentasXVendedor(listadoVentasDTO);
			if (listaVentas != null) {
				listaRetorno = new VentaAjaxDTO[listaVentas.length];
				for (int i = 0; i < listaVentas.length; i++) {
					VentaAjaxDTO venta = new VentaAjaxDTO();
					venta.setNroVenta(listaVentas[i].getNroVenta().toString());
					venta.setFechaVenta(listaVentas[i].getFechaVenta());
					venta.setNombreCliente(listaVentas[i].getNombreCliente());
					venta.setNombreVendedor(listaVentas[i].getNombreVendedor());
					venta.setNombreDealer(listaVentas[i].getNombreDealer());
					venta.setTipoVenta(listaVentas[i].getTipoVenta());
					venta.setEstado(listaVentas[i].getCodEstadoVenta());
					venta.setCodOficina(listaVentas[i].getCodOficina());
					venta.setCodVendedor(listaVentas[i].getCodigoVendedor().toString());
					venta.setCodCliente(listaVentas[i].getCodCliente().toString());
					venta.setCodModVenta(listaVentas[i].getCodModVenta());
					venta.setIndTipoVenta(listaVentas[i].getIndTipoVenta());
					venta.setNumTransaccionVenta(listaVentas[i].getNumTransaccionVenta());
					venta.setCodTipoContrato(listaVentas[i].getCodTipoContrato());
					venta.setCodTipoDocumento(listaVentas[i].getCodTipoDocumento());
					venta.setCodCuota(listaVentas[i].getCodCuota());
					venta.setIndOfiter(listaVentas[i].getIndOfiter());
					venta.setCodTipoCliente(listaVentas[i].getCodTipoCliente());
					venta.setCodTipoSolicitud(listaVentas[i].getCodTipoSolicitud());
					venta.setIndEstVenta(listaVentas[i].getIndEstVenta());
					listaRetorno[i] = venta;
				}
				encontrados = listaRetorno.length;
			}
			sesion.setAttribute("listaPreVenta", listaRetorno);
		}
		catch (VentasException e) {
			String mensaje = e.getDescripcionEvento() == null ? mensajeError : e.getDescripcionEvento();
			retorno.setMsgError(mensaje);
			retorno.setCodError(e.getCodigo());
			logger.error("retorno.getMsgError() [" + retorno.getMsgError() + "]");
			logger.error("retorno.getCodError() [" + retorno.getCodError() + "]");
			logger.error(StackTraceUtl.getStackTrace(e));
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? mensajeError : e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError(mensaje);
			logger.error("retorno.getMsgError() [" + retorno.getMsgError() + "]");
			logger.error("retorno.getCodError() [" + retorno.getCodError() + "]");
			logger.error(StackTraceUtl.getStackTrace(e));
		}
		logger.debug("encontrados [" + encontrados + "]");
		retorno.setLista(listaRetorno);
		logger.info("obtenerVentasxVendedor, fin");
		return retorno;
	}
	
	/*
	public RetornoListaAjaxDTO obtenerVentasVendedorXFiltros(String numVenta, String codVendedor, String codOficina,
			String codCliente, String fechaDesde, String fechaHasta, String codEstadoVenta, String indOrigen,
			String numCelular) {
		logger.info("obtenerVentasVendedorXFiltros, inicio()");
		logger.debug("numVenta [" + numVenta + "]");
		logger.debug("codVendedor [" + codVendedor + "]");
		logger.debug("numCelular [" + numCelular + "]");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		if (!Utilidades.validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}
		VentaAjaxDTO[] listaRetorno = null;
		ListadoVentasDTO[] lista = null;
		long encontrados = 0;
		final String mensajeError = "Ocurrio un error al obtener ventas";
		try {
			if (numVenta.trim().equals(""))
				numVenta = "0";
			if (codVendedor.trim().equals(""))
				codVendedor = "0";
			if (codOficina.trim().equals(""))
				codOficina = "0";
			if (codCliente.trim().equals(""))
				codCliente = "0";
			if (codEstadoVenta.equals(""))
				codEstadoVenta = "0";
			ListadoVentasDTO b = new ListadoVentasDTO();
			b.setNroVenta(new Long(numVenta));
			b.setCodigoVendedor(new Long(codVendedor));
			b.setCodCliente(new Long(codCliente));
			b.setCodOficina(codOficina);
			b.setFechaDesde(fechaDesde);
			b.setFechaHasta(fechaHasta);
			b.setCodEstadoVenta(codEstadoVenta);
			b.setOrigen(indOrigen);
			//b.setNumCelular(numCelular);
			lista = delegate.getVentasXVendedor(b);
			if (lista != null) {
				listaRetorno = new VentaAjaxDTO[lista.length];
				for (int i = 0; i < lista.length; i++) {
					VentaAjaxDTO venta = new VentaAjaxDTO();
					final ListadoVentasDTO item = lista[i];
					venta.setNroVenta(item.getNroVenta().toString());
					venta.setFechaVenta(item.getFechaVenta());
					venta.setNombreCliente(item.getNombreCliente());
					venta.setNombreVendedor(item.getNombreVendedor());
					venta.setNombreDealer(item.getNombreDealer());
					venta.setTipoVenta(item.getTipoVenta());
					venta.setEstado(item.getCodEstadoVenta());
					venta.setCodOficina(item.getCodOficina());
					venta.setCodVendedor(item.getCodigoVendedor().toString());
					venta.setCodCliente(item.getCodCliente().toString());
					venta.setCodModVenta(item.getCodModVenta());
					venta.setIndTipoVenta(item.getIndTipoVenta());
					venta.setNumTransaccionVenta(item.getNumTransaccionVenta());
					venta.setCodTipoContrato(item.getCodTipoContrato());
					venta.setCodTipoDocumento(item.getCodTipoDocumento());
					venta.setCodCuota(item.getCodCuota());
					venta.setIndOfiter(item.getIndOfiter());
					venta.setCodTipoCliente(item.getCodTipoCliente());
					venta.setCodTipoSolicitud(item.getCodTipoSolicitud());
					venta.setIndEstVenta(item.getIndEstVenta());
					listaRetorno[i] = venta;
				}
				encontrados = listaRetorno.length;
			}
			sesion.setAttribute("listaPreVenta", listaRetorno);
		}
		catch (VentasException e) {
			String mensaje = e.getDescripcionEvento() == null ? mensajeError : e.getDescripcionEvento();
			retorno.setMsgError(mensaje);
			retorno.setCodError(e.getCodigo());
			logger.error("retorno.getMsgError() [" + retorno.getMsgError() + "]");
			logger.error("retorno.getCodError() [" + retorno.getCodError() + "]");
			logger.error(StackTraceUtl.getStackTrace(e));
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? mensajeError : e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError(mensaje);
			logger.error("retorno.getMsgError() [" + retorno.getMsgError() + "]");
			logger.error("retorno.getCodError() [" + retorno.getCodError() + "]");
			logger.error(StackTraceUtl.getStackTrace(e));
		}
		logger.debug("encontrados [" + encontrados + "]");
		retorno.setLista(listaRetorno);
		logger.info("obtenerVentasVendedorXFiltros, fin");
		return retorno;
	}*/

	private boolean validarSesion(HttpSession sesion) {
		if (sesion == null)
			return false;
		ParametrosGlobalesDTO sessionData = (ParametrosGlobalesDTO) sesion.getAttribute("paramGlobal");
		if (sessionData == null)
			return false;
		return true;
	}
}
