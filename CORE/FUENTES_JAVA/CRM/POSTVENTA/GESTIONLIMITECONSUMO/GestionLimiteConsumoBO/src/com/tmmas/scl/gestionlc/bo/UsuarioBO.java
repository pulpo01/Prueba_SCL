package com.tmmas.scl.gestionlc.bo;

import com.tmmas.scl.gestionlc.bo.common.GestionLimiteConsumoAbstractBO;
import com.tmmas.scl.gestionlc.common.dto.UsuarioDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.UsuarioDAO;

public class UsuarioBO extends GestionLimiteConsumoAbstractBO {

    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    public UsuarioDTO obtenerDatosUsuario(UsuarioDTO pUsuarioDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):obtenerDatosUsuario");

        UsuarioDTO usuarioDTO = usuarioDAO.obtieneDatosUsuario(pUsuarioDTO);

        loggerInfo("Fin(BO):obtenerDatosUsuario");
        return usuarioDTO;
    }

}
