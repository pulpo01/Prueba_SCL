package com.tmmas.cl.scl.altacliente.presentacion.helper;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.scl.altacliente.presentacion.delegate.AltaClienteDelegate;
import com.tmmas.cl.scl.altacliente.presentacion.dto.CuentaAjaxDTO;
import com.tmmas.cl.scl.altacliente.presentacion.dto.RetornoListaAjaxDTO;
import com.tmmas.cl.scl.altacliente.presentacion.dto.RetornoValidacionAjaxDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.NumeroIdentificacionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.BusquedaCuentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CuentaDTO;

public class BuscaCuentaAJAX
{
	private final Logger logger = Logger.getLogger(BuscaCuentaAJAX.class);

	private Global global = Global.getInstance();

	AltaClienteDelegate delegate = AltaClienteDelegate.getInstance();

	public RetornoValidacionAjaxDTO validarIdentificador(String tipoIdentif, String numIdentif)
	{
		logger.debug("validarIdentificador:inicio()");
		RetornoValidacionAjaxDTO retorno = new RetornoValidacionAjaxDTO();
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);

		if (!validarSesion(sesion))
		{
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		NumeroIdentificacionDTO param = new NumeroIdentificacionDTO();
		retorno.setValido(true);
		try
		{
			param.setCodigoModulo(global.getValor("codigo.modulo.GE"));
			param.setCorrelativo(Long.valueOf(global.getValor("param.identificador.correlativo")));
			param.setTipoIdentif(tipoIdentif);
			param.setNumIdentif(numIdentif);
			param = delegate.validarIdentificador(param);
			retorno.setIdentificadorFormateado(param.getFormatoNIT());
		}
		catch (Exception e)
		{
			retorno.setValido(false);
		}
		logger.debug("validarIdentificador:fin()");
		return retorno;
	}

	public RetornoListaAjaxDTO obtenerCuentas(String codCuenta, String codTipoIdentificacion, String numIdentificacion,
			String tipoCuenta, String telefonoContacto, String nombreCuenta, String nombreResponsable)
	{
		logger.debug("Inicio");
		RetornoListaAjaxDTO r = new RetornoListaAjaxDTO();
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);

		if (!validarSesion(sesion))
		{
			r.setCodError("-100");
			r.setMsgError("Su sesión ha expirado");
			return r;
		}

		CuentaAjaxDTO[] listaRetorno = null;
		CuentaDTO[] listaCuentas = null;
		try
		{
			BusquedaCuentaDTO dto = new BusquedaCuentaDTO();
			dto.setCodCuenta(codCuenta);
			dto.setCodTipoIdentificacion(codTipoIdentificacion);
			dto.setNumIdentificacion(numIdentificacion);
			dto.setCodTipoCuenta(tipoCuenta);
			dto.setTelefonoContacto(telefonoContacto);
			dto.setNombreCuenta(nombreCuenta);
			dto.setNombreResponsable(nombreResponsable);
			logger.debug(dto.toString());

			listaCuentas = delegate.getCuentas(dto);

			listaRetorno = new CuentaAjaxDTO[listaCuentas.length];
			for (int i = 0; i < listaCuentas.length; i++)
			{
				CuentaAjaxDTO ajaxDTO = new CuentaAjaxDTO();
				ajaxDTO.setCodigoCuenta(listaCuentas[i].getCodigoCuenta());
				ajaxDTO.setCodigoTipoIdentificacion(listaCuentas[i].getCodigoTipIdentif());
				ajaxDTO.setNumeroIdentificacion(listaCuentas[i].getNumeroIdentificacion());
				ajaxDTO.setTipoCuenta(listaCuentas[i].getTipoCuenta());
				ajaxDTO.setNombreCuenta(listaCuentas[i].getNombreCuenta());
				ajaxDTO.setNombreResponsable(listaCuentas[i].getResponsable());
				listaRetorno[i] = ajaxDTO;
			}
			sesion.setAttribute("listaCuentas", listaRetorno);
		}
		catch (Exception e)
		{
			String mensaje = e.getMessage() == null ? "Ocurrio un error al obtener cuentas " : e.getMessage();
			r.setCodError("1");
			r.setMsgError(mensaje);
		}
		r.setLista(listaRetorno);
		logger.debug("Fin");
		return r;
	}

	private boolean validarSesion(HttpSession sesion)
	{
		if (sesion == null)
			return false;
		ParametrosGlobalesDTO sessionData = (ParametrosGlobalesDTO) sesion.getAttribute("paramGlobal");
		if (sessionData == null)
			return false;
		return true;
	}
}
