package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
import java.util.Date;

public class BloqueoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
  	private  Date      fechaSuspensionBd;       
  	private  String    numTerminal;     
  	private  Date      fechaSuspencionCentral;      
  	private  String    codigoCausaSusp;      
  	private  String    desCausasSusp;      
  	private  long      indFraude;       
  	private  String    codTipfraude;    
  	private  long      tipSuspencion;   
  	private  String    desValor;
  	private  String    desTipsuspension; 
	private RespuestaDTO respuesta;
	
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}


	public String getCodCaususp() {
		return codigoCausaSusp;
	}


	public void setCodCaususp(String codCaususp) {
		this.codigoCausaSusp = codCaususp;
	}


	public String getCodTipfraude() {
		return codTipfraude;
	}


	public void setCodTipfraude(String codTipfraude) {
		this.codTipfraude = codTipfraude;
	}


	public String getDesCaususp() {
		return desCausasSusp;
	}


	public void setDesCaususp(String desCaususp) {
		this.desCausasSusp = desCaususp;
	}


	public String getDesValor() {
		return desValor;
	}


	public void setDesValor(String desValor) {
		this.desValor = desValor;
	}


	public Date getFecSuspbd() {
		return fechaSuspensionBd;
	}


	public void setFecSuspbd(Date fecSuspbd) {
		this.fechaSuspensionBd = fecSuspbd;
	}


	public Date getFecSuspcen() {
		return fechaSuspencionCentral;
	}


	public void setFecSuspcen(Date fecSuspcen) {
		this.fechaSuspencionCentral = fecSuspcen;
	}


	public long getIndFraude() {
		return indFraude;
	}


	public void setIndFraude(long indFraude) {
		this.indFraude = indFraude;
	}


	public String getNumTerminal() {
		return numTerminal;
	}


	public void setNumTerminal(String numTerminal) {
		this.numTerminal = numTerminal;
	}


	public RespuestaDTO getRespuesta() {
		return respuesta;
	}


	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}


	public long getTipSuspencion() {
		return tipSuspencion;
	}


	public void setTipSuspencion(long tipSuspencion) {
		this.tipSuspencion = tipSuspencion;
	}


	public String getDesTipsuspension() {
		return desTipsuspension;
	}


	public void setDesTipsuspension(String desTipsuspension) {
		this.desTipsuspension = desTipsuspension;
	}
	     
     

	
	


}
