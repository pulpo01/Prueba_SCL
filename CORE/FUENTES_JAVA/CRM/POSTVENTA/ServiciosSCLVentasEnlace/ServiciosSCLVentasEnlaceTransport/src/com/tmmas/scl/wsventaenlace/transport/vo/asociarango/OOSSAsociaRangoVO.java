package com.tmmas.scl.wsventaenlace.transport.vo.asociarango;

import java.util.List;

import com.tmmas.scl.wsventaenlace.transport.vo.AbonadoVO;

public class OOSSAsociaRangoVO {
	private static final long serialVersionUID = 1L;
	private AbonadoVO abonado;
	private long numPiloto;

	private List rangosAsociados;
	private List rangosDisponibles;

	private List pilotosAdicionados;
	private List pilotosEliminados;

	private RangoVO rangoVO;
	private NumeroPilotoVO numeroPilotoVO;
	private NumeroPilotoHVO numeroPilotoHVO;

	private String codModulo;
	private String nomTabla;
	private String nomColumna;
	private String codValor;
	private String desValor;
	
	private Integer codCentral;

	public NumeroPilotoVO getNumeroPilotoVO() {
		return numeroPilotoVO;
	}

	public void setNumeroPilotoVO(NumeroPilotoVO numeroPilotoVO) {
		this.numeroPilotoVO = numeroPilotoVO;
	}

	public AbonadoVO getAbonado() {
		return abonado;
	}

	public void setAbonado(AbonadoVO abonado) {
		this.abonado = abonado;
	}

	public List getPilotosAdicionados() {
		return pilotosAdicionados;
	}

	public void setPilotosAdicionados(List pilotosAdicionados) {
		this.pilotosAdicionados = pilotosAdicionados;
	}

	public List getPilotosEliminados() {
		return pilotosEliminados;
	}

	public void setPilotosEliminados(List pilotosEliminados) {
		this.pilotosEliminados = pilotosEliminados;
	}

	public List getRangosAsociados() {
		return rangosAsociados;
	}

	public void setRangosAsociados(List rangosAsociados) {
		this.rangosAsociados = rangosAsociados;
	}

	public List getRangosDisponibles() {
		return rangosDisponibles;
	}

	public void setRangosDisponibles(List rangosDisponibles) {
		this.rangosDisponibles = rangosDisponibles;
	}

	public long getNumPiloto() {
		return numPiloto;
	}

	public void setNumPiloto(long numPiloto) {
		this.numPiloto = numPiloto;
	}

	public RangoVO getRangoVO() {
		return rangoVO;
	}

	public void setRangoVO(RangoVO rangoVO) {
		this.rangoVO = rangoVO;
	}

	public NumeroPilotoHVO getNumeroPilotoHVO() {
		return numeroPilotoHVO;
	}

	public void setNumeroPilotoHVO(NumeroPilotoHVO numeroPilotoHVO) {
		this.numeroPilotoHVO = numeroPilotoHVO;
	}

	public String getCodModulo() {
		return codModulo;
	}

	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}

	public String getCodValor() {
		return codValor;
	}

	public void setCodValor(String codValor) {
		this.codValor = codValor;
	}

	public String getDesValor() {
		return desValor;
	}

	public void setDesValor(String desValor) {
		this.desValor = desValor;
	}

	public String getNomColumna() {
		return nomColumna;
	}

	public void setNomColumna(String nomColumna) {
		this.nomColumna = nomColumna;
	}

	public String getNomTabla() {
		return nomTabla;
	}

	public void setNomTabla(String nomTabla) {
		this.nomTabla = nomTabla;
	}

	public Integer getCodCentral() {
		return codCentral;
	}

	public void setCodCentral(Integer codCentral) {
		this.codCentral = codCentral;
	}

}
