package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.DetEstadoProcesoOSSDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.RegistroPlanDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.vendedor.dto.UsuarioVendedorDTO;
import com.tmmas.scl.vendedor.dto.VendedorDTO;
import com.tmmas.scl.vendedor.negocio.ejb.session.VendedorFacadeSTL;

public class VendedorComisionable {
	private final Logger logger = Logger.getLogger(VendedorComisionable.class);

	private Global global = Global.getInstance();

	private FacadeMaker facadeMaker = FacadeMaker.getInstance();

	/**
	 * Completa los datos del vendedor
	 * 
	 * @param registroPlan
	 * @param listaDetalles
	 * @param session
	 * @return
	 */
	public UsuarioVendedorDTO handlerVendedorComisionable(
			RegistroPlanDTO registroPlan,
			DetEstadoProcesoOSSDTO[] listaDetalles, HttpSession session) {
		logger.debug("handlerVendedorComisionable():start");
		// Obtiene de la sesion un posible vendedor comisionable
		// Si el objeto de sesion es nulo es porque nunca se habilito el
		// vendedor configurable
		// De lo contrario el vendedor pudo haber sido ingresado o fue tomadio
		// de la sesion del usuario que se loguea
		logger.debug("Obteniendo vendedor comisionable de la sesion...");
		UsuarioVendedorDTO usuarioVendedor = (UsuarioVendedorDTO) session
				.getAttribute("UsuarioVendedorComisionable");
		if (usuarioVendedor == null) {
			logger
					.debug("El vendedor comisionable es nulo. Vendedor comisionable no configurado");
		} else {
			logger
					.debug("Hay un vendedor Comisionista configurado ya sea en sesion o ingresado manualmente");
			boolean vendedorenSesion = usuarioVendedor.isVendedorenSesion();
			logger.debug("vendedorenSesion[" + vendedorenSesion + "]");
			if (vendedorenSesion) {
				logger.debug("Se toma el vendedor de la sesion del usuario");
			} else {
				logger.debug("Se toma el vendedor ingresado por pantalla");
			}

			VendedorDTO vendedor = usuarioVendedor.getVendedor();
			int n = listaDetalles.length;
			logger.debug("Numero secuencial de OOSS[" + n + "]");
			String num_OOSS[] = new String[n];

			for (int i = 0; i < listaDetalles.length; i++) {
				DetEstadoProcesoOSSDTO detalle = listaDetalles[i];
				logger.debug("detalle.getNumOOSS()[" + detalle.getNumOOSS()
						+ "]");
				num_OOSS[i] = String.valueOf(detalle.getNumOOSS());
			}
			usuarioVendedor.setNumOOSS(num_OOSS);
			logger.debug("combinatoria           : "
					+ registroPlan.getParamRegistroPlan().getCombinatoria());
			logger.debug("tipOOSS                : "
					+ registroPlan.getParamRegistroPlan().getTipOOSS());

			vendedor
					.setCod_os(registroPlan.getParamRegistroPlan().getTipOOSS());
			vendedor.setNumOOSS(String.valueOf(registroPlan
					.getParamRegistroPlan().getNumOOSS()));
			vendedor.setSub_tipo(registroPlan.getParamRegistroPlan()
					.getCombinatoria());
		}

		logger.debug("handlerVendedorComisionable():end");
		return usuarioVendedor;
	}

	/**
	 * Inserta la informacion del vendedor comisionable si aplica
	 * 
	 * @param usuarioVendedor
	 * @throws IssCusOrdException
	 */
	public void insertarVendedorComisionable(UsuarioVendedorDTO usuarioVendedor,VendedorDTO vendedordePantalla)
			throws IssCusOrdException {
		logger.debug("insertarVendedorComisionable():start");
		if (usuarioVendedor == null) {
			logger
					.debug("No hay un vendedor Comisionista configurado. No se hace nada con respecto a el vendedor...");
		} else {
			logger
					.debug("Hay un vendedor Comisionista configurado ya sea en sesion o ingresado manualmente");
			boolean vendedorenSesion = usuarioVendedor.isVendedorenSesion();
			logger.debug("vendedorenSesion[" + vendedorenSesion + "]");
			if (vendedorenSesion) {
				logger.debug("Se toma el vendedor de la sesion del usuario");
			} else {
				usuarioVendedor.setVendedor(vendedordePantalla);
				logger.debug("Se toma el vendedor ingresado por pantalla");
			}
			VendedorDTO vendedor = usuarioVendedor.getVendedor();

			if (vendedor != null) {
				int n = usuarioVendedor.getNumOOSS().length;
				logger.debug("n[" + n + "]");
				for (int i = 0; i < n; i++) {
					logger.debug("iteracion[" + i + "]");
					logger
							.debug("Registrando informacion de vendedor existente..");
					
					vendedor.setNumOOSS(usuarioVendedor.getNumOOSS()[i]);
					logger.debug("NumOOSS[" + vendedor.getNumOOSS() + "]");
					try {
						logger.debug("getVendedorFacade:antes");
						VendedorFacadeSTL facade = facadeMaker
								.getVendedorFacade();
						logger.debug("getVendedorFacade:despues");

						logger.debug("registrarInformacionVendedor():antes");
						facade.registrarInformacionVendedor(vendedor);
						logger.debug("registrarInformacionVendedor():despues");
					} catch (Exception e) {
						logger.debug("Exception", e);
						throw new IssCusOrdException(e);
					}
				}
				logger
						.debug("Registrando informacion de vendedor existente en forma exitosa..");
			} else {
				logger
						.debug("Error de configuración con el vendedor. El vendedor deberia estar asignado");
				throw new IssCusOrdException(
						"Error de configuración con el vendedor. El vendedor deberia estar asignado");

			}
		}
		logger.debug("insertarVendedorComisionable():end");
	}

}
