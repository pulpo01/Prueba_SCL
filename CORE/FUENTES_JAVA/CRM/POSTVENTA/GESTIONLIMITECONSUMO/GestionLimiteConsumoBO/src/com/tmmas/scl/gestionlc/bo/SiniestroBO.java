package com.tmmas.scl.gestionlc.bo;

/**
 * Copyright © 2009 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.<br>
 *
 * @Fecha 16-04-2011<br>
 * @Autor Sergio Vidal<br>
 *
 **/
import com.tmmas.scl.gestionlc.bo.common.GestionLimiteConsumoAbstractBO;
import com.tmmas.scl.gestionlc.common.dto.AbonadoDTO;
import com.tmmas.scl.gestionlc.common.dto.DatosGeneralesSiniestroDTO;
import com.tmmas.scl.gestionlc.common.dto.ParametroDTO;
import com.tmmas.scl.gestionlc.common.dto.SiniestroDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.common.helper.GlobalProperties;
import com.tmmas.scl.gestionlc.dao.SiniestroDAO;

public class SiniestroBO extends GestionLimiteConsumoAbstractBO {
    private static GlobalProperties global = GlobalProperties.getInstance();

    private SiniestroDAO siniestroDAO = new SiniestroDAO();

    public SiniestroDTO obtenerDatosSiniestro(SiniestroDTO pSiniestroDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):obtenerDatosSiniestro");

        SiniestroDTO siniestroDTO = siniestroDAO.obtenerDatosSiniestro(pSiniestroDTO);

        loggerInfo("Fin(BO):obtenerDatosSiniestro");
        return siniestroDTO;
    }

    public void validaOrdenRestitucion(SiniestroDTO siniestroDTO, Short shoCantSiniestros) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):validaOrdenRestitucion");
        int iIndEjecSim = 0;
        int iIndEjecTerm = 0;
        loggerDebug("shoCantSiniestros.shortValue(" + shoCantSiniestros.shortValue() + ") > 1");
        if (shoCantSiniestros.shortValue() > 1) {
            loggerDebug("siniestroDTO.getStrTipTerminal(" + siniestroDTO.getStrTipTerminal() + ").equals('G')");
            if ("G".equals(siniestroDTO.getStrTipTerminal())) {
                iIndEjecSim = 1;
            } else if ("T".equals(siniestroDTO.getStrTipTerminal())) {
                iIndEjecTerm = 1;
            }
            loggerDebug("if (iIndEjecSim(" + iIndEjecSim + ") == 1 && iIndEjecTerm(" + iIndEjecTerm + ") == 0) {");
            if (iIndEjecSim == 1 && iIndEjecTerm == 0) {
                throw new GestionLimiteConsumoException("ERR.0013", 0);
            }
        }
        loggerInfo("Fin(BO):validaOrdenRestitucion");
    }

    public DatosGeneralesSiniestroDTO obtenerCodCargosBasicos(SiniestroDTO siniestroDTO, AbonadoDTO abonadoDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):obtenerCodCargosBasicos");

        DatosGeneralesSiniestroDTO datosGeneralesSiniestroDTO = new DatosGeneralesSiniestroDTO();
        datosGeneralesSiniestroDTO = siniestroDAO.obtenerCodCargosBasicos(siniestroDTO, abonadoDTO);

        loggerInfo("Fin(BO):obtenerCodCargosBasicos");
        return datosGeneralesSiniestroDTO;
    }

    public void validaFechas(SiniestroDTO siniestroDTO, String strFechaRestitucion) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):validaFechas");

        Integer intDiasSin = 0;
        Integer intDiasFor = 0;
        Integer intDiasRes = 0;
        Integer intDiasAnu = 0;

        loggerDebug("getDiasPasados(siniestroDTO.getStrFechaSiniestro(" + siniestroDTO.getStrFechaSiniestro() + "));");
        intDiasSin = getDiasPasados(siniestroDTO.getStrFechaSiniestro());

        loggerDebug("getDiasPasados(siniestroDTO.getStrFechaFormaliza(" + siniestroDTO.getStrFechaFormaliza() + "));");
        if (siniestroDTO.getStrFechaFormaliza() == null || "".equals(siniestroDTO.getStrFechaFormaliza())) {
            throw new GestionLimiteConsumoException("ERR.0020", 0);
        } else {
            intDiasFor = getDiasPasados(siniestroDTO.getStrFechaFormaliza());
            if (intDiasFor.intValue() > intDiasSin.intValue()) {
                throw new GestionLimiteConsumoException("ERR.0020", 0);
            }
        }

        loggerDebug("getDiasPasados(siniestroDTO.getStrFechaAnula(" + siniestroDTO.getStrFechaAnula() + "));");
        if (siniestroDTO.getStrFechaAnula() != null && !"".equals(siniestroDTO.getStrFechaAnula())) {
            intDiasAnu = getDiasPasados(siniestroDTO.getStrFechaAnula());
            if (intDiasAnu.intValue() > intDiasFor.intValue()) {
                throw new GestionLimiteConsumoException("ERR.0021", 0);
            }
            if (intDiasAnu.intValue() > intDiasSin.intValue()) {
                throw new GestionLimiteConsumoException("ERR.0022", 0);
            }
        }

        loggerDebug("getDiasPasados(strFechaRestitucion(" + strFechaRestitucion + "));");
        if (strFechaRestitucion == null || "".equals(strFechaRestitucion)) {
            throw new GestionLimiteConsumoException("ERR.0023", 0);
        } else {
            intDiasRes = getDiasPasados(strFechaRestitucion);
            if (intDiasRes.intValue() > intDiasFor.intValue()) {
                throw new GestionLimiteConsumoException("ERR.0023", 0);
            }
        }

        Integer intDiasAct = new Integer(0);

        loggerDebug("intDiasAct " + intDiasAct);
        loggerDebug("intDiasSin " + intDiasSin);
        loggerDebug("intDiasFor " + intDiasFor);
        loggerDebug("intDiasAnu " + intDiasAnu);
        loggerDebug("intDiasRes " + intDiasRes);
        if (intDiasAct.intValue() > intDiasSin.intValue() || intDiasAct.intValue() > intDiasFor.intValue() || intDiasAct.intValue() > intDiasAnu.intValue()
                || intDiasAct.intValue() > intDiasRes.intValue()) {
            throw new GestionLimiteConsumoException("ERR.0024", 0);
        }

        loggerInfo("Fin(BO):validaFechas");
    }

    public Integer getDiasPasados(String strFecha) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):getDiasPasados");
        Integer intDias = 0;
        GeneralBO generalBO = new GeneralBO();

        intDias = generalBO.getDiasPasados(strFecha);
        loggerDebug("DIAS[" + intDias + "]");

        loggerInfo("Fin(BO):getDiasPasados");
        return intDias;
    }

    public boolean chequeaTerminal(Short shoCantRegistros, String strTipTerminal, String strCodTecnologia) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):chequeaTerminal");
        boolean bResultado = false;
        GeneralBO generalBO = new GeneralBO();

        ParametroDTO parametroDTO = new ParametroDTO();
        loggerDebug("shoCantRegistros.shortValue(): " + shoCantRegistros.shortValue());
        loggerDebug("strTipTerminal: " + strTipTerminal);
        if (shoCantRegistros.shortValue() == 2) {
            parametroDTO.setStrNombreParametro("COD_SIMCARD_GSM");
            parametroDTO.setStrCodigoModulo("AL");
            parametroDTO = generalBO.obtieneParametros(parametroDTO);

            loggerDebug("parametroDTO.getStrValorParametro(): " + parametroDTO.getStrValorParametro());
            if (strTipTerminal.equals(parametroDTO.getStrValorParametro())) {
                bResultado = true;
            } else {
                bResultado = false;
            }

        } else {
            parametroDTO.setStrNombreParametro("GRUPO_TEC_GSM");
            parametroDTO.setStrCodigoModulo("GA");
            parametroDTO = generalBO.obtieneParametros(parametroDTO);
            loggerDebug("strCodTecnologia: " + strCodTecnologia);
            loggerDebug("parametroDTO.getStrValorParametro(): " + parametroDTO.getStrValorParametro());
            if (strCodTecnologia.equals(parametroDTO.getStrValorParametro())) {
                bResultado = true;
            } else {
                parametroDTO.setStrNombreParametro("GRUPO_TEC_DMA");
                parametroDTO.setStrCodigoModulo("GA");
                parametroDTO = generalBO.obtieneParametros(parametroDTO);
                if (strCodTecnologia.equals(parametroDTO.getStrValorParametro())) {
                    bResultado = true;
                }
            }
        }

        loggerDebug("bResultado: " + bResultado);
        loggerInfo("Fin(BO):chequeaTerminal");
        return bResultado;
    }

    /**
     * restituye siniestro
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void restituirSiniestro(SiniestroDTO siniestroDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):restituirSiniestro");

        siniestroDAO.restituirSiniestro(siniestroDTO);

        loggerInfo("Fin(BO):restituirSiniestro");
    }

    /**
     * pasa el siniestro a historico
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void pasoHistorico(SiniestroDTO siniestroDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):pasoHistorico");

        siniestroDAO.pasoHistorico(siniestroDTO);
        loggerInfo("Fin(BO):pasoHistorico");
    }

}
