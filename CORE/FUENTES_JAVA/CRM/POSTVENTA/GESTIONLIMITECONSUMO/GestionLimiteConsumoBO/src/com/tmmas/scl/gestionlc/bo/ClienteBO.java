package com.tmmas.scl.gestionlc.bo;

/**
 * Copyright © 2009 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------ Autor  ------------ Cambios -------
 * 12-03-2011   Sergio Vidal        Versión Inicial
 *
 **/
import com.tmmas.scl.gestionlc.bo.common.GestionLimiteConsumoAbstractBO;
import com.tmmas.scl.gestionlc.common.dto.ClienteDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.ClienteDAO;

public class ClienteBO extends GestionLimiteConsumoAbstractBO {

    private ClienteDAO clienteDAO = new ClienteDAO();

    public ClienteDTO obtenerOperadoraCliente(ClienteDTO pClienteDTO) throws GestionLimiteConsumoException {

        loggerInfo("Inicio(BO):obtenerOperadoraCliente");

        ClienteDTO clienteDTO = clienteDAO.obtenerOperadoraCliente(pClienteDTO);

        loggerInfo("Fin(BO):obtenerOperadoraCliente");

        return clienteDTO;

    }

}
