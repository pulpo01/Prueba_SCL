package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

import com.tmmas.scl.gestionlc.common.dto.AbonadoDTO;
import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.PlanTarifarioOutDTO;
import com.tmmas.scl.gestionlc.common.dto.SegmentacionOutDTO;
import com.tmmas.scl.gestionlc.common.dto.common.GestionLimiteConsumoOutDTO;

/**
 * Clase que rescata los parametros de salida del LimiteConsumoDAO
 */
public class CargaModificacionLimiteConsumoOutDTO extends GestionLimiteConsumoOutDTO implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    private AbonadoDTO abonado;
    private LimiteConsumoOutDTO limiteConsumo;
    private SegmentacionOutDTO segmentacion;
    private PlanTarifarioOutDTO planTarifario;
    private String strNumDecimal;
    private Integer intLimPendiente;
    private String strEstadoVenta;

    /**
     * @return the abonado
     */
    public AbonadoDTO getAbonado() {
        return abonado;
    }

    /**
     * @param abonado
     *            the abonado to set
     */
    public void setAbonado(AbonadoDTO abonado) {
        this.abonado = abonado;
    }

    /**
     * @return the limiteConsumo
     */
    public LimiteConsumoOutDTO getLimiteConsumo() {
        return limiteConsumo;
    }

    /**
     * @param limiteConsumo
     *            the limiteConsumo to set
     */
    public void setLimiteConsumo(LimiteConsumoOutDTO limiteConsumo) {
        this.limiteConsumo = limiteConsumo;
    }

    /**
     * @return the segmentacion
     */
    public SegmentacionOutDTO getSegmentacion() {
        return segmentacion;
    }

    /**
     * @param segmentacion
     *            the segmentacion to set
     */
    public void setSegmentacion(SegmentacionOutDTO segmentacion) {
        this.segmentacion = segmentacion;
    }

    /**
     * @return the planTarifario
     */
    public PlanTarifarioOutDTO getPlanTarifario() {
        return planTarifario;
    }

    /**
     * @param planTarifario
     *            the planTarifario to set
     */
    public void setPlanTarifario(PlanTarifarioOutDTO planTarifario) {
        this.planTarifario = planTarifario;
    }

    /**
     * @return the strNumDecimal
     */
    public String getStrNumDecimal() {
        return strNumDecimal;
    }

    /**
     * @param strNumDecimal
     *            the strNumDecimal to set
     */
    public void setStrNumDecimal(String strNumDecimal) {
        this.strNumDecimal = strNumDecimal;
    }

    /**
     * @return the intLimPendiente
     */
    public Integer getIntLimPendiente() {
        return intLimPendiente;
    }

    /**
     * @param intLimPendiente
     *            the intLimPendiente to set
     */
    public void setIntLimPendiente(Integer intLimPendiente) {
        this.intLimPendiente = intLimPendiente;
    }

    //inicio incedencia 169415 09/06/2011 FDL
    /**
     * @return the strEstadoVenta
     */
    public String getStrEstadoVenta() {
        return strEstadoVenta;
    }

    /**
     * @param strEstadoVenta the strEstadoVenta to set
     */
    public void setStrEstadoVenta(String strEstadoVenta) {
        this.strEstadoVenta = strEstadoVenta;
    }
    //fin incedencia 169415 09/06/2011 FDL

}
