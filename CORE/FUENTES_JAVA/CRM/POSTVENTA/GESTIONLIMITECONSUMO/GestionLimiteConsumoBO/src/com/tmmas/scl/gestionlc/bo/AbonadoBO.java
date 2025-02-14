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
 * 12-03-2011       Sergio Vidal      Versión Inicial
 *
 **/
import com.tmmas.scl.gestionlc.bo.common.GestionLimiteConsumoAbstractBO;
import com.tmmas.scl.gestionlc.common.dto.AbonadoDTO;
import com.tmmas.scl.gestionlc.common.dto.SiniestroDTO;
import com.tmmas.scl.gestionlc.common.dto.UsuarioDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.AbonadoDAO;

public class AbonadoBO extends GestionLimiteConsumoAbstractBO {

    private AbonadoDAO abonadoDAO = new AbonadoDAO();

    public void validarOOSSPendiente(AbonadoDTO abonadoDTO, String strCodOS) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):validarOOSSPendiente");

        abonadoDAO.validarOOSSPendiente(abonadoDTO, strCodOS);

        loggerInfo("Fin(BO):validarOOSSPendiente");
    }

    public AbonadoDTO obtenerDatosAbonado(AbonadoDTO pAbonadoDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):obtenerDatosAbonado");

        AbonadoDTO abonadoDTO = abonadoDAO.obtenerDatosAbonado(pAbonadoDTO);

        loggerInfo("Fin(BO):obtenerDatosAbonado");
        return abonadoDTO;
    }

    public SiniestroDTO[] obtenerSiniestros(AbonadoDTO abonadoDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):obtenerSiniestros");

        SiniestroDTO[] siniestroDTOs = abonadoDAO.obtenerSiniestros(abonadoDTO);

        loggerInfo("Fin(BO):obtenerSiniestros");
        return siniestroDTOs;
    }

    public void validarAvisoSiniestro(AbonadoDTO abonadoDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):validarAvisoSiniestro");

        abonadoDAO.validarAvisoSiniestro(abonadoDTO);

        loggerInfo("Fin(BO):validarAvisoSiniestro");
    }

    public AbonadoDTO obtenerCicloPendiente(AbonadoDTO pAbonadoDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):obtenerCicloPendiente");

        AbonadoDTO abonadoDTO = abonadoDAO.obtenerCicloPendiente(pAbonadoDTO);

        loggerInfo("Fin(BO):obtenerCicloPendiente");

        return abonadoDTO;
    }

    public void validarRecambio(AbonadoDTO abonadoDTO, UsuarioDTO usuarioDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):validarRecambio");

        abonadoDAO.validarRecambio(abonadoDTO, usuarioDTO);

        loggerInfo("Fin(BO):validarRecambio");
    }

}
