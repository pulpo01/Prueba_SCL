package com.tmmas.scl.operations.crm.fab.cim.manreq.web.form;

import java.util.List;

import org.apache.struts.action.ActionForm;

import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.TablaCargosDTO;

public class CargosForm extends ActionForm{
	private String []tipoDescuentoManual;
	private String botonSeleccionado;
	private String rbCiclo;
	private String cbTipoDocumento;
	private String cbNumCuotas;
	private String cbModPago;
	private TablaCargosDTO [] tablaCargos;
	private String[] descuentoUnitarioMan;
	private String total;
	private String [] totales;
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
	private String []tipoDescuentoOriginal;
	private ObtencionCargosDTO cargosSeleccionados;
	private ObtencionCargosDTO cargosMerge;
	private String combinatoria;
	
	
	public String getCombinatoria() {
		return combinatoria;
	}

	public void setCombinatoria(String combinatoria) {
		this.combinatoria = combinatoria;
	}

	public long getNumVenta() {
		return numVenta;
	}

	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}

	public List getCuotasList() {
		return cuotasList;
	}

	public void setCuotasList(List cuotasList) {
		this.cuotasList = cuotasList;
	}

	public List getDocumentosList() {
		return documentosList;
	}

	public void setDocumentosList(List documentosList) {
		this.documentosList = documentosList;
	}

	public List getFormaPagoList() {
		return formaPagoList;
	}

	public void setFormaPagoList(List formaPagoList) {
		this.formaPagoList = formaPagoList;
	}

	public List getTipDescuentosList() {
		return tipDescuentosList;
	}

	public void setTipDescuentosList(List tipDescuentosList) {
		this.tipDescuentosList = tipDescuentosList;
	}

	public String getIndCreaDescuento() {
		return indCreaDescuento;
	}

	public void setIndCreaDescuento(String indCreaDescuento) {
		this.indCreaDescuento = indCreaDescuento;
	}

	public String getRangoInfPorcDescuento() {
		return rangoInfPorcDescuento;
	}

	public void setRangoInfPorcDescuento(String rangoInfPorcDescuento) {
		this.rangoInfPorcDescuento = rangoInfPorcDescuento;
	}

	public String getRangoSupPorcDescuento() {
		return rangoSupPorcDescuento;
	}

	public void setRangoSupPorcDescuento(String rangoSupPorcDescuento) {
		this.rangoSupPorcDescuento = rangoSupPorcDescuento;
	}

	public String[] getDescuentoUnitarioMan() {
		return descuentoUnitarioMan;
	}

	public void setDescuentoUnitarioMan(String[] descuentoUnitarioMan) {
		for(int i = 0; i<getTablaCargos().length;i++){
			getTablaCargos()[i].setDescuentoUnitarioMan(descuentoUnitarioMan[i]);
		}
		this.descuentoUnitarioMan = descuentoUnitarioMan;
	}

	public String getCbModPago() {
		return cbModPago;
	}

	public void setCbModPago(String cbModPago) {
		this.cbModPago = cbModPago;
	}

	public String getCbNumCuotas() {
		return cbNumCuotas;
	}

	public void setCbNumCuotas(String cbNumCuotas) {
		this.cbNumCuotas = cbNumCuotas;
	}

	public String getCbTipoDocumento() {
		return cbTipoDocumento;
	}

	public void setCbTipoDocumento(String cbTipoDocumento) {
		this.cbTipoDocumento = cbTipoDocumento;
	}

	public String getRbCiclo() {
		return rbCiclo;
	}

	public void setRbCiclo(String rbCiclo) {
		this.rbCiclo = rbCiclo;
	}

	public TablaCargosDTO[] getTablaCargos() {
		return tablaCargos;
	}

	public void setTablaCargos(TablaCargosDTO[] tablaCargos) {
		this.tablaCargos = tablaCargos;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	public String[] getTotales() {
		return totales;
	}

	public void setTotales(String[] totales) {
		System.out.println(totales.length);
		for(int i = 0; i< totales.length;i++){
			getTablaCargos()[i].setSaldo(totales[i]);
		}
		this.totales = totales;
	}

	public String[] getSelectedValorCheck() {
		return selectedValorCheck;
	}

	public void setSelectedValorCheck(String[] selectedValorCheck) {
		this.selectedValorCheck = selectedValorCheck;
	}

	public String getBotonSeleccionado() {
		return botonSeleccionado;
	}

	public void setBotonSeleccionado(String botonSeleccionado) {
		this.botonSeleccionado = botonSeleccionado;
	}

	public String[] getTipoDescuentoManual() {
		return tipoDescuentoManual;
	}

	public void setTipoDescuentoManual(String[] tipoDescuentoManual) {
		for(int a=0;a<tipoDescuentoManual.length;a++){
			getTablaCargos()[a].setTipoDescuentoManual(tipoDescuentoManual[a]);
		}
		this.tipoDescuentoManual = tipoDescuentoManual;
	}

	public String getCumpleDescuento() {
		return cumpleDescuento;
	}

	public void setCumpleDescuento(String cumpleDescuento) {
		this.cumpleDescuento = cumpleDescuento;
	}

	public ObtencionCargosDTO getCargosSeleccionados() {
		return cargosSeleccionados;
	}

	public void setCargosSeleccionados(ObtencionCargosDTO cargosSeleccionados) {
		this.cargosSeleccionados = cargosSeleccionados;
	}

	public String[] getTipoDescuentoOriginal() {
		return tipoDescuentoOriginal;
	}

	public void setTipoDescuentoOriginal(String[] tipoDescuentoOriginal) {
		this.tipoDescuentoOriginal = tipoDescuentoOriginal;
	}

	public ObtencionCargosDTO getCargosMerge() {
		return cargosMerge;
	}

	public void setCargosMerge(ObtencionCargosDTO cargosMerge) {
		this.cargosMerge = cargosMerge;
	}
}