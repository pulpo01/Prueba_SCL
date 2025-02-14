package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;
import java.util.Date;

import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;

public class SerieDTO implements Serializable{


	private static final long serialVersionUID = 1L;
	private String num_serie;
	private long   cod_bodega;
	private long   tip_stock;
	private long   cod_articulo;
	private long   cod_uso;
	private long   cod_estado;
	private long   num_desde;
	private Date   fec_entrada;
    private long   ind_telefono;
    private long   cap_code;
    private long   num_telefono;
	private String num_seriemec;
	private long   prc_copra;
	private long   cod_producto;
	private long   cod_central;
	private String cod_subalm;
	private long   cod_cat;
	private String plan;
	private long   carga;
	private long   num_sec_loca;
	private String cod_hlr;
	private String cod_plaza;
	private MensajeRetornoDTO mensajeRetorno;
	
	private long cod_vendedor;
	private int codCanal;
	private int codModVenta;
	private String tipArticulo;
	private String codTecnologia;
	private String tipTerminal;
	
	public MensajeRetornoDTO getMensajeRetorno() {
		return mensajeRetorno;
	}
	public void setMensajeRetorno(MensajeRetornoDTO mensajeRetorno) {
		this.mensajeRetorno = mensajeRetorno;
	}
	
	public long getCap_code() {
		return cap_code;
	}
	public void setCap_code(long cap_code) {
		this.cap_code = cap_code;
	}
	public long getCarga() {
		return carga;
	}
	public void setCarga(long carga) {
		this.carga = carga;
	}
	public long getCod_articulo() {
		return cod_articulo;
	}
	public void setCod_articulo(long cod_articulo) {
		this.cod_articulo = cod_articulo;
	}
	public long getCod_bodega() {
		return cod_bodega;
	}
	public void setCod_bodega(long cod_bodega) {
		this.cod_bodega = cod_bodega;
	}
	public long getCod_cat() {
		return cod_cat;
	}
	public void setCod_cat(long cod_cat) {
		this.cod_cat = cod_cat;
	}
	public long getCod_central() {
		return cod_central;
	}
	public void setCod_central(long cod_central) {
		this.cod_central = cod_central;
	}
	public long getCod_estado() {
		return cod_estado;
	}
	public void setCod_estado(long cod_estado) {
		this.cod_estado = cod_estado;
	}
	public String getCod_hlr() {
		return cod_hlr;
	}
	public void setCod_hlr(String cod_hlr) {
		this.cod_hlr = cod_hlr;
	}
	public String getCod_plaza() {
		return cod_plaza;
	}
	public void setCod_plaza(String cod_plaza) {
		this.cod_plaza = cod_plaza;
	}
	public long getCod_producto() {
		return cod_producto;
	}
	public void setCod_producto(long cod_producto) {
		this.cod_producto = cod_producto;
	}
	public String getCod_subalm() {
		return cod_subalm;
	}
	public void setCod_subalm(String cod_subalm) {
		this.cod_subalm = cod_subalm;
	}
	public long getCod_uso() {
		return cod_uso;
	}
	public void setCod_uso(long cod_uso) {
		this.cod_uso = cod_uso;
	}
	public Date getFec_entrada() {
		return fec_entrada;
	}
	public void setFec_entrada(Date fec_entrada) {
		this.fec_entrada = fec_entrada;
	}
	public long getInd_telefono() {
		return ind_telefono;
	}
	public void setInd_telefono(long ind_telefono) {
		this.ind_telefono = ind_telefono;
	}
	public long getNum_desde() {
		return num_desde;
	}
	public void setNum_desde(long num_desde) {
		this.num_desde = num_desde;
	}
	public long getNum_sec_loca() {
		return num_sec_loca;
	}
	public void setNum_sec_loca(long num_sec_loca) {
		this.num_sec_loca = num_sec_loca;
	}
	public String getNum_seriemec() {
		return num_seriemec;
	}
	public void setNum_seriemec(String num_seriemec) {
		this.num_seriemec = num_seriemec;
	}
	public String getNum_serie() {
		return num_serie;
	}
	public void setNum_serie(String num_series) {
		this.num_serie = num_series;
	}
	public long getNum_telefono() {
		return num_telefono;
	}
	public void setNum_telefono(long num_telefono) {
		this.num_telefono = num_telefono;
	}
	public String getPlan() {
		return plan;
	}
	public void setPlan(String plan) {
		this.plan = plan;
	}
	public long getPrc_copra() {
		return prc_copra;
	}
	public void setPrc_copra(long prc_copra) {
		this.prc_copra = prc_copra;
	}
	public long getTip_stock() {
		return tip_stock;
	}
	public void setTip_stock(long tip_stock) {
		this.tip_stock = tip_stock;
	}
	public long getCod_vendedor() {
		return cod_vendedor;
	}
	public void setCod_vendedor(long cod_vendedor) {
		this.cod_vendedor = cod_vendedor;
	}
	public int getCodCanal() {
		return codCanal;
	}
	public void setCodCanal(int codCanal) {
		this.codCanal = codCanal;
	}
	public int getCodModVenta() {
		return codModVenta;
	}
	public void setCodModVenta(int codModVenta) {
		this.codModVenta = codModVenta;
	}
	public String getTipArticulo() {
		return tipArticulo;
	}
	public void setTipArticulo(String tipArticulo) {
		this.tipArticulo = tipArticulo;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getTipTerminal() {
		return tipTerminal;
	}
	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}		
}
