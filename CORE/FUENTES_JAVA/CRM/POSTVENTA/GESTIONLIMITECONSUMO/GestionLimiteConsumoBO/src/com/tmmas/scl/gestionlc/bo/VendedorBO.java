package com.tmmas.scl.gestionlc.bo;

import com.tmmas.scl.gestionlc.bo.common.GestionLimiteConsumoAbstractBO;
import com.tmmas.scl.gestionlc.common.dto.UsuarioDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.VendedorDAO;

public class VendedorBO extends GestionLimiteConsumoAbstractBO {

    private VendedorDAO vendedorDAO = new VendedorDAO();

    public void bloqueaDesbloqueaVendedor(UsuarioDTO usuarioDTO, String strOperacion) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):bloqueaDesbloqueaVendedor");

        vendedorDAO.bloqueaDesbloqueaVendedor(usuarioDTO, strOperacion);

        loggerInfo("Fin(BO):bloqueaDesbloqueaVendedor");
    }

    public void validarEstadoVendedor(UsuarioDTO usuarioDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):validarEstadoVendedor");

        vendedorDAO.validarEstadoVendedor(usuarioDTO);

        loggerInfo("Fin(BO):validarEstadoVendedor");
    }
}
