package com.tmmas.cl.scl.portalventas.web.helper;

import org.apache.log4j.Logger;

import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;

public class MenuAJAX {
	private final Logger logger = Logger.getLogger(MenuAJAX.class);

	private Global global = Global.getInstance();

	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	public void desbloqueaVendedor(String codVendedor) {
		logger.info("desbloqueaVendedor:inicio()");
		logger.debug("codVendedor [" + codVendedor + "]");
		VendedorDTO entrada = new VendedorDTO();
		entrada.setCodigoVendedor(codVendedor);
		entrada.setCodigoAccionBloqueo(global.getValor("accion.desbloqueo.vendedor"));
		try {
			delegate.bloqueaDesbloqueaVendedor(entrada);
		}
		catch (Exception e) {
			logger.debug("Error al desbloquear vendedor " + codVendedor);
		}
		logger.info("desbloqueaVendedor:fin()");
	}
}
