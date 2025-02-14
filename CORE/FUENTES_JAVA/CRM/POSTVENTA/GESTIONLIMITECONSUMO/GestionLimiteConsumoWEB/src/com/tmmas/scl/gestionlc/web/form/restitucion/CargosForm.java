package com.tmmas.scl.gestionlc.web.form.restitucion;

import java.util.List;

import org.apache.struts.action.ActionForm;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.gestionlc.common.dto.TablaCargosDTO;

public class CargosForm extends ActionForm {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    private String[] tipoDescuentoManual;
    private String botonSeleccionado;
    private String rbCiclo;
    private String cbTipoDocumento;
    private String cbNumCuotas;
    private String cbModPago;
    private TablaCargosDTO[] tablaCargos;
    private String[] descuentoUnitarioMan;
    private String total;
    private String[] totales;
    private String[] selectedValorCheck;
    private String cumpleDescuento;
    private String indCreaDescuento;
    private String rangoInfPorcDescuento;
    private String rangoSupPorcDescuento;
    private List documentosList;
    private List formaPagoList;
    private List tipDescuentosList;
    private List cuotasList;
    private long numVenta;
    private String[] tipoDescuentoOriginal;
    private ObtencionCargosDTO cargosSeleccionados;
    private ObtencionCargosDTO cargosMerge;

    /**
     * @return the tipoDescuentoManual
     */
    public String[] getTipoDescuentoManual() {
        return tipoDescuentoManual;
    }

    /**
     * @param tipoDescuentoManual
     *            the tipoDescuentoManual to set
     */
    public void setTipoDescuentoManual(String[] pTipoDescuentoManual) {

        for (int a = 0; a < pTipoDescuentoManual.length; a++) {
            getTablaCargos()[a].setTipoDescuentoManual(pTipoDescuentoManual[a]);
        }

        this.tipoDescuentoManual = pTipoDescuentoManual;
    }

    /**
     * @return the botonSeleccionado
     */
    public String getBotonSeleccionado() {
        return botonSeleccionado;
    }

    /**
     * @param botonSeleccionado
     *            the botonSeleccionado to set
     */
    public void setBotonSeleccionado(String pBotonSeleccionado) {
        this.botonSeleccionado = pBotonSeleccionado;
    }

    /**
     * @return the rbCiclo
     */
    public String getRbCiclo() {
        return rbCiclo;
    }

    /**
     * @param rbCiclo
     *            the rbCiclo to set
     */
    public void setRbCiclo(String pRbCiclo) {
        this.rbCiclo = pRbCiclo;
    }

    /**
     * @return the cbTipoDocumento
     */
    public String getCbTipoDocumento() {
        return cbTipoDocumento;
    }

    /**
     * @param cbTipoDocumento
     *            the cbTipoDocumento to set
     */
    public void setCbTipoDocumento(String pCbTipoDocumento) {
        this.cbTipoDocumento = pCbTipoDocumento;
    }

    /**
     * @return the cbNumCuotas
     */
    public String getCbNumCuotas() {
        return cbNumCuotas;
    }

    /**
     * @param cbNumCuotas
     *            the cbNumCuotas to set
     */
    public void setCbNumCuotas(String pCbNumCuotas) {
        this.cbNumCuotas = pCbNumCuotas;
    }

    /**
     * @return the cbModPago
     */
    public String getCbModPago() {
        return cbModPago;
    }

    /**
     * @param cbModPago
     *            the cbModPago to set
     */
    public void setCbModPago(String pCbModPago) {
        this.cbModPago = pCbModPago;
    }

    /**
     * @return the tablaCargos
     */
    public TablaCargosDTO[] getTablaCargos() {
        return tablaCargos;
    }

    /**
     * @param tablaCargos
     *            the tablaCargos to set
     */
    public void setTablaCargos(TablaCargosDTO[] pTablaCargos) {
        this.tablaCargos = pTablaCargos;
    }

    /**
     * @return the descuentoUnitarioMan
     */
    public String[] getDescuentoUnitarioMan() {
        return descuentoUnitarioMan;
    }

    /**
     * @param descuentoUnitarioMan
     *            the descuentoUnitarioMan to set
     */
    public void setDescuentoUnitarioMan(String[] pDescuentoUnitarioMan) {

        for (int i = 0; i < getTablaCargos().length; i++) {
            getTablaCargos()[i].setDescuentoUnitarioMan(pDescuentoUnitarioMan[i]);
        }

        this.descuentoUnitarioMan = pDescuentoUnitarioMan;
    }

    /**
     * @return the total
     */
    public String getTotal() {
        return total;
    }

    /**
     * @param total
     *            the total to set
     */
    public void setTotal(String pTotal) {
        this.total = pTotal;
    }

    /**
     * @return the totales
     */
    public String[] getTotales() {
        return totales;
    }

    /**
     * @param totales
     *            the totales to set
     */
    public void setTotales(String[] pTotales) {

        for (int i = 0; i < pTotales.length; i++) {
            getTablaCargos()[i].setSaldo(pTotales[i]);
        }

        this.totales = pTotales;
    }

    /**
     * @return the selectedValorCheck
     */
    public String[] getSelectedValorCheck() {
        return selectedValorCheck;
    }

    /**
     * @param selectedValorCheck
     *            the selectedValorCheck to set
     */
    public void setSelectedValorCheck(String[] pSelectedValorCheck) {
        this.selectedValorCheck = pSelectedValorCheck;
    }

    /**
     * @return the cumpleDescuento
     */
    public String getCumpleDescuento() {
        return cumpleDescuento;
    }

    /**
     * @param cumpleDescuento
     *            the cumpleDescuento to set
     */
    public void setCumpleDescuento(String pCumpleDescuento) {
        this.cumpleDescuento = pCumpleDescuento;
    }

    /**
     * @return the indCreaDescuento
     */
    public String getIndCreaDescuento() {
        return indCreaDescuento;
    }

    /**
     * @param indCreaDescuento
     *            the indCreaDescuento to set
     */
    public void setIndCreaDescuento(String pIndCreaDescuento) {
        this.indCreaDescuento = pIndCreaDescuento;
    }

    /**
     * @return the rangoInfPorcDescuento
     */
    public String getRangoInfPorcDescuento() {
        return rangoInfPorcDescuento;
    }

    /**
     * @param rangoInfPorcDescuento
     *            the rangoInfPorcDescuento to set
     */
    public void setRangoInfPorcDescuento(String pRangoInfPorcDescuento) {
        this.rangoInfPorcDescuento = pRangoInfPorcDescuento;
    }

    /**
     * @return the rangoSupPorcDescuento
     */
    public String getRangoSupPorcDescuento() {
        return rangoSupPorcDescuento;
    }

    /**
     * @param rangoSupPorcDescuento
     *            the rangoSupPorcDescuento to set
     */
    public void setRangoSupPorcDescuento(String pRangoSupPorcDescuento) {
        this.rangoSupPorcDescuento = pRangoSupPorcDescuento;
    }

    /**
     * @return the documentosList
     */
    public List getDocumentosList() {
        return documentosList;
    }

    /**
     * @param documentosList
     *            the documentosList to set
     */
    public void setDocumentosList(List pDocumentosList) {
        this.documentosList = pDocumentosList;
    }

    /**
     * @return the formaPagoList
     */
    public List getFormaPagoList() {
        return formaPagoList;
    }

    /**
     * @param formaPagoList
     *            the formaPagoList to set
     */
    public void setFormaPagoList(List pFormaPagoList) {
        this.formaPagoList = pFormaPagoList;
    }

    /**
     * @return the tipDescuentosList
     */
    public List getTipDescuentosList() {
        return tipDescuentosList;
    }

    /**
     * @param tipDescuentosList
     *            the tipDescuentosList to set
     */
    public void setTipDescuentosList(List pTipDescuentosList) {
        this.tipDescuentosList = pTipDescuentosList;
    }

    /**
     * @return the cuotasList
     */
    public List getCuotasList() {
        return cuotasList;
    }

    /**
     * @param cuotasList
     *            the cuotasList to set
     */
    public void setCuotasList(List pCuotasList) {
        this.cuotasList = pCuotasList;
    }

    /**
     * @return the numVenta
     */
    public long getNumVenta() {
        return numVenta;
    }

    /**
     * @param numVenta
     *            the numVenta to set
     */
    public void setNumVenta(long pNumVenta) {
        this.numVenta = pNumVenta;
    }

    /**
     * @return the tipoDescuentoOriginal
     */
    public String[] getTipoDescuentoOriginal() {
        return tipoDescuentoOriginal;
    }

    /**
     * @param tipoDescuentoOriginal
     *            the tipoDescuentoOriginal to set
     */
    public void setTipoDescuentoOriginal(String[] pTipoDescuentoOriginal) {
        this.tipoDescuentoOriginal = pTipoDescuentoOriginal;
    }

    /**
     * @return the cargosSeleccionados
     */
    public ObtencionCargosDTO getCargosSeleccionados() {
        return cargosSeleccionados;
    }

    /**
     * @param cargosSeleccionados
     *            the cargosSeleccionados to set
     */
    public void setCargosSeleccionados(ObtencionCargosDTO pCargosSeleccionados) {
        this.cargosSeleccionados = pCargosSeleccionados;
    }

    /**
     * @return the cargosMerge
     */
    public ObtencionCargosDTO getCargosMerge() {
        return cargosMerge;
    }

    /**
     * @param cargosMerge
     *            the cargosMerge to set
     */
    public void setCargosMerge(ObtencionCargosDTO pCargosMerge) {
        this.cargosMerge = pCargosMerge;
    }

}
