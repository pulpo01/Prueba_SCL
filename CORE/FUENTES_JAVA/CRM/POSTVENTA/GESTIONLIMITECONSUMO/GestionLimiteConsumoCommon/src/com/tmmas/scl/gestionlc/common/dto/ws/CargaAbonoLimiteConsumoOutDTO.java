package com.tmmas.scl.gestionlc.common.dto.ws;

import java.io.Serializable;

import com.tmmas.scl.gestionlc.common.dto.AbonadoDTO;
import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoUmbralDTO;
import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoUtilizadoDTO;
import com.tmmas.scl.gestionlc.common.dto.common.GestionLimiteConsumoOutDTO;

public class CargaAbonoLimiteConsumoOutDTO extends GestionLimiteConsumoOutDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private AbonadoDTO abonado;
    private LimiteConsumoUmbralDTO limiteConsumoUmbral;
    private LimiteConsumoUtilizadoDTO limiteConsumoUtilizado;
    private String strDescGrupoTecnologico;
    private String strDescSituacion;
    private Double douMontoMaximoAbono;
    private String strCantidadDecimal;
    private String getStrEstadoVenta;

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
     * @return the limiteConsumoUmbral
     */
    public LimiteConsumoUmbralDTO getLimiteConsumoUmbral() {
        return limiteConsumoUmbral;
    }

    /**
     * @param limiteConsumoUmbral
     *            the limiteConsumoUmbral to set
     */
    public void setLimiteConsumoUmbral(LimiteConsumoUmbralDTO limiteConsumoUmbral) {
        this.limiteConsumoUmbral = limiteConsumoUmbral;
    }

    /**
     * @return the limiteConsumoUtilizado
     */
    public LimiteConsumoUtilizadoDTO getLimiteConsumoUtilizado() {
        return limiteConsumoUtilizado;
    }

    /**
     * @param limiteConsumoUtilizado
     *            the limiteConsumoUtilizado to set
     */
    public void setLimiteConsumoUtilizado(LimiteConsumoUtilizadoDTO limiteConsumoUtilizado) {
        this.limiteConsumoUtilizado = limiteConsumoUtilizado;
    }

    /**
     * @return the strDescGrupoTecnologico
     */
    public String getStrDescGrupoTecnologico() {
        return strDescGrupoTecnologico;
    }

    /**
     * @param strDescGrupoTecnologico
     *            the strDescGrupoTecnologico to set
     */
    public void setStrDescGrupoTecnologico(String strDescGrupoTecnologico) {
        this.strDescGrupoTecnologico = strDescGrupoTecnologico;
    }

    /**
     * @return the strDescSituacion
     */
    public String getStrDescSituacion() {
        return strDescSituacion;
    }

    /**
     * @param strDescSituacion
     *            the strDescSituacion to set
     */
    public void setStrDescSituacion(String strDescSituacion) {
        this.strDescSituacion = strDescSituacion;
    }

    /**
     * @return the douMontoMaximoAbono
     */
    public Double getDouMontoMaximoAbono() {
        return douMontoMaximoAbono;
    }

    /**
     * @param douMontoMaximoAbono
     *            the douMontoMaximoAbono to set
     */
    public void setDouMontoMaximoAbono(Double douMontoMaximoAbono) {
        this.douMontoMaximoAbono = douMontoMaximoAbono;
    }

    /**
     * @return the strCantidadDecimal
     */
    public String getStrCantidadDecimal() {
        return strCantidadDecimal;
    }

    /**
     * @param strCantidadDecimal
     *            the strCantidadDecimal to set
     */
    public void setStrCantidadDecimal(String strCantidadDecimal) {
        this.strCantidadDecimal = strCantidadDecimal;
    }

    //inicio incedencia 169415 09/06/2011 FDL
    /**
     * @return the getStrEstadoVenta
     */
    public String getGetStrEstadoVenta() {
        return getStrEstadoVenta;
    }

    /**
     * @param getStrEstadoVenta the getStrEstadoVenta to set
     */
    public void setGetStrEstadoVenta(String getStrEstadoVenta) {
        this.getStrEstadoVenta = getStrEstadoVenta;
    }
  //fin incedencia 169415 09/06/2011 FDL

}
