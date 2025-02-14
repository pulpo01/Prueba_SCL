package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;
import java.util.Date;

import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ProgramaDTO;



public class GaVentasDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private Long numVenta;//NOT NULL,
	  private Long codProducto;//NOT NULL,
	  private String codOficina;//NOT NULL,
	  private String codTipcomis;//NOT NULL,
	  private Long codVendedor;//NOT NULL,
	  private Long codVendedorAgente;//NOT NULL,
	  private Long numUnidades;//NOT NULL,
	  private Date fecVenta;//NOT NULL,
	  private String codRegion;//NOT NULL,
	  private String codProvincia;//NOT NULL,
	  private String codCiudad;//NOT NULL,
	  private String indEstVenta;//NOT NULL,
	  private Long numTransaccion;//DEFAULT 0                     NOT NULL,
	  private Long indPasoCob;//DEFAULT 0                     NOT NULL,
	  private String nomUsuarVta;//DEFAULT 'SISCEL'              NOT NULL,
	  private String indVenta;//DEFAULT 'V'                   NOT NULL,
	  private String codMoneda;//
	  private String codCausaRec;
	  private Float impVenta;//            NUMBER(14,4),
	  private String codTipContrato;//
	  private int indComodato;
	  private String numContrato;//
	  private int indicadorContratoNuevo;
	  private Long indTipVenta;
	  private Long codCliente;//NUMBER(8),
	  private Long codModVenta;// NUMBER(2),
	  private String tipValor;
	  private String codCuota;//
	  private String codTipTarjeta;
	  private String numTarjeta;
	  private String codAutTarj;//VARCHAR2(20),
	  private Date  fecVenciTarj;//DATE,
	  private String codBancoTarj;//VARCHAR2(15),
	  private String numCTACORR ;//VARCHAR2(18),
	  private String numCheque;//VARCHAR2(20),
	  private String codBanco;//VARCHAR2(15),
	  private String codSucursal;//VARCHAR2(4),
	  private java.sql.Date fecCumplimenta;//DATE,
	  private Date fecRecDocum;//DATE,
	  private Date fecAcePrec;//DATE,
	  private String nomUsuarAcerec;//VARCHAR2(30),
	  private String nomUsuarRecDoc;//VARCHAR2(30),
	  private String nomUsuarCumpl;//VARCHAR2(30),
	  private String indOfiter;//DEFAULT 'O',
	  private String indChkDicom;//NUMBER(1),
	  private Long numConsulta;//NUMBER(8),
	  private Long codVenDealer;//NUMBER(6),
	  private Long numFolDealer;//NUMBER(10),
	  private Long codDocDealer;//NUMBER(2),
	  private Long indDocComp;//NUMBER(1),
	  private String obsInCump;//VARCHAR2(150),
	  private Long codCausaRep;//NUMBER(3),
	  private Date fecRecProv;//DATE,
	  private String nomUsuarRecProv;//VARCHAR2(30),
	  private Long numDias;//NUMBER(2),
	  private String obsRecProv;//VARCHAR2(200),
	  private Long impAbono;//NUMBER(14,4),
	  private Long indAbono;//NUMBER(1),
	  private Date fecRecepAdmVtas;//DATE,
	  private String usuRecepAdmVtas;//VARCHAR2(30),
	  private String ObsGralCumpl;//VARCHAR2(120),
	  private Long indContTelef;//NUMBER(1),
	  private Date fechaContTelef;//DATE,
	  private String usuarioContTelef;//VARCHAR2(30),
	  private Float mtoGarantia;
	  private String tipFoliacion;//CHAR(1),
	  private String codTipDocumento;//NUMBER(2),
	  private String codPlaza;//VARCHAR2(5),
	  private String codOperadora;//VARCHAR2(5),
	  private Long numProceso;//NUMBER(8)
	  private boolean isAciclo;
	  private boolean isCuotas;
	  private boolean isTrajCredito;
	  private boolean isCheque;
	  private String CodModPago;
	  private String formPago;
	  private String tipoPlanPostpago;
	  private String tipoPlanHibrido; 
	  private String tipoPlanPrepago;
	  private String codigoActuacionDefecto;
	  private String codigoUsuario;
	  private String parametroCodigoSimcardGSM;
	  private AbonadoDTO abonado;
	  private String numIdentCliente;
	  private String tipIdentCliente;
	  private String tipoCliente;
	  private String indicadorCuotas;
	  private int numeroMesesContrato;
	  private ProgramaDTO datosPrograma;
	  private String numeroMovtoAnterior;
	  private int numDecimalBD;
	  private String indPortado;
	  
	public int getNumDecimalBD() {
		return numDecimalBD;
	}
	public void setNumDecimalBD(int numDecimalBD) {
		this.numDecimalBD = numDecimalBD;
	}
	public String getNumeroMovtoAnterior() {
		return numeroMovtoAnterior;
	}
	public void setNumeroMovtoAnterior(String numeroMovtoAnterior) {
		this.numeroMovtoAnterior = numeroMovtoAnterior;
	}
	public ProgramaDTO getDatosPrograma() {
		return datosPrograma;
	}
	public void setDatosPrograma(ProgramaDTO datosPrograma) {
		this.datosPrograma = datosPrograma;
	}
	public int getNumeroMesesContrato() {
		return numeroMesesContrato;
	}
	public void setNumeroMesesContrato(int numeroMesesContrato) {
		this.numeroMesesContrato = numeroMesesContrato;
	}
	public String getTipoCliente() {
		return tipoCliente;
	}
	public void setTipoCliente(String tipoCliente) {
		this.tipoCliente = tipoCliente;
	}
	public AbonadoDTO getAbonado() {
		return abonado;
	}
	public void setAbonado(AbonadoDTO abonado) {
		this.abonado = abonado;
	}
	public String getParametroCodigoSimcardGSM() {
		return parametroCodigoSimcardGSM;
	}
	public void setParametroCodigoSimcardGSM(String parametroCodigoSimcardGSM) {
		this.parametroCodigoSimcardGSM = parametroCodigoSimcardGSM;
	}
	public String getCodigoUsuario() {
		return codigoUsuario;
	}
	public void setCodigoUsuario(String codigoUsuario) {
		this.codigoUsuario = codigoUsuario;
	}
	public String getCodigoActuacionDefecto() {
		return codigoActuacionDefecto;
	}
	public void setCodigoActuacionDefecto(String codigoActuacionDefecto) {
		this.codigoActuacionDefecto = codigoActuacionDefecto;
	}
	public String getCodModPago() {
		return CodModPago;
	}
	public void setCodModPago(String codModPago) {
		CodModPago = codModPago;
	}
	public boolean isCuotas() {
		return isCuotas;
	}
	public void setCuotas(boolean isCuotas) {
		this.isCuotas = isCuotas;
	}
	public boolean isTrajCredito() {
		return isTrajCredito;
	}
	public void setTrajCredito(boolean isTrajCredito) {
		this.isTrajCredito = isTrajCredito;
	}
	public boolean isAciclo() {
		return isAciclo;
	}
	public void setAciclo(boolean isAciclo) {
		this.isAciclo = isAciclo;
	}
	public String getCodAutTarj() {
		return codAutTarj;
	}
	public void setCodAutTarj(String codAutTarj) {
		this.codAutTarj = codAutTarj;
	}
	public String getCodBanco() {
		return codBanco;
	}
	public void setCodBanco(String codBanco) {
		this.codBanco = codBanco;
	}
	public String getCodBancoTarj() {
		return codBancoTarj;
	}
	public void setCodBancoTarj(String codBancoTarj) {
		this.codBancoTarj = codBancoTarj;
	}
	public String getCodCausaRec() {
		return codCausaRec;
	}
	public void setCodCausaRec(String codCausaRec) {
		this.codCausaRec = codCausaRec;
	}
	public Long getCodCausaRep() {
		return codCausaRep;
	}
	public void setCodCausaRep(Long codCausaRep) {
		this.codCausaRep = codCausaRep;
	}
	public String getCodCiudad() {
		return codCiudad;
	}
	public void setCodCiudad(String codCiudad) {
		this.codCiudad = codCiudad;
	}
	public Long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(Long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodCuota() {
		return codCuota;
	}
	public void setCodCuota(String codCuota) {
		this.codCuota = codCuota;
	}
	public Long getCodDocDealer() {
		return codDocDealer;
	}
	public void setCodDocDealer(Long codDocDealer) {
		this.codDocDealer = codDocDealer;
	}
	public Long getCodModVenta() {
		return codModVenta;
	}
	public void setCodModVenta(Long codModVenta) {
		this.codModVenta = codModVenta;
	}
	public String getCodMoneda() {
		return codMoneda;
	}
	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public String getCodOperadora() {
		return codOperadora;
	}
	public void setCodOperadora(String codOperadora) {
		this.codOperadora = codOperadora;
	}
	public String getCodPlaza() {
		return codPlaza;
	}
	public void setCodPlaza(String codPlaza) {
		this.codPlaza = codPlaza;
	}
	public Long getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(Long codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodProvincia() {
		return codProvincia;
	}
	public void setCodProvincia(String codProvincia) {
		this.codProvincia = codProvincia;
	}
	public String getCodRegion() {
		return codRegion;
	}
	public void setCodRegion(String codRegion) {
		this.codRegion = codRegion;
	}
	public String getCodSucursal() {
		return codSucursal;
	}
	public void setCodSucursal(String codSucursal) {
		this.codSucursal = codSucursal;
	}
	public String getCodTipcomis() {
		return codTipcomis;
	}
	public void setCodTipcomis(String codTipcomis) {
		this.codTipcomis = codTipcomis;
	}
	public String getCodTipContrato() {
		return codTipContrato;
	}
	public void setCodTipContrato(String codTipContrato) {
		this.codTipContrato = codTipContrato;
	}
	public String getCodTipDocumento() {
		return codTipDocumento;
	}
	public void setCodTipDocumento(String codTipDocumento) {
		this.codTipDocumento = codTipDocumento;
	}
	public String getCodTipTarjeta() {
		return codTipTarjeta;
	}
	public void setCodTipTarjeta(String codTipTarjeta) {
		this.codTipTarjeta = codTipTarjeta;
	}
	public Long getCodVenDealer() {
		return codVenDealer;
	}
	public void setCodVenDealer(Long codVenDealer) {
		this.codVenDealer = codVenDealer;
	}
	public Long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(Long codVendedor) {
		this.codVendedor = codVendedor;
	}
	public Long getCodVendedorAgente() {
		return codVendedorAgente;
	}
	public void setCodVendedorAgente(Long codVendedorAgente) {
		this.codVendedorAgente = codVendedorAgente;
	}
	public Date getFecAcePrec() {
		return fecAcePrec;
	}
	public void setFecAcePrec(Date fecAcePrec) {
		this.fecAcePrec = fecAcePrec;
	}
	public java.sql.Date getFecCumplimenta() {
		return fecCumplimenta;
	}
	public void setFecCumplimenta(java.sql.Date fecCumplimenta) {
		this.fecCumplimenta = fecCumplimenta;
	}
	public Date getFechaContTelef() {
		return fechaContTelef;
	}
	public void setFechaContTelef(Date fechaContTelef) {
		this.fechaContTelef = fechaContTelef;
	}
	public Date getFecRecDocum() {
		return fecRecDocum;
	}
	public void setFecRecDocum(Date fecRecDocum) {
		this.fecRecDocum = fecRecDocum;
	}
	public Date getFecRecepAdmVtas() {
		return fecRecepAdmVtas;
	}
	public void setFecRecepAdmVtas(Date fecRecepAdmVtas) {
		this.fecRecepAdmVtas = fecRecepAdmVtas;
	}
	public Date getFecRecProv() {
		return fecRecProv;
	}
	public void setFecRecProv(Date fecRecProv) {
		this.fecRecProv = fecRecProv;
	}
	public Date getFecVenciTarj() {
		return fecVenciTarj;
	}
	public void setFecVenciTarj(Date fecVenciTarj) {
		this.fecVenciTarj = fecVenciTarj;
	}
	public Date getFecVenta() {
		return fecVenta;
	}
	public void setFecVenta(Date fecVenta) {
		this.fecVenta = fecVenta;
	}
	public Long getImpAbono() {
		return impAbono;
	}
	public void setImpAbono(Long impAbono) {
		this.impAbono = impAbono;
	}
	public Float getImpVenta() {
		return impVenta;
	}
	public void setImpVenta(Float impVenta) {
		this.impVenta = impVenta;
	}
	public Long getIndAbono() {
		return indAbono;
	}
	public void setIndAbono(Long indAbono) {
		this.indAbono = indAbono;
	}
	public String getIndChkDicom() {
		return indChkDicom;
	}
	public void setIndChkDicom(String indChkDicom) {
		this.indChkDicom = indChkDicom;
	}
	public Long getIndContTelef() {
		return indContTelef;
	}
	public void setIndContTelef(Long indContTelef) {
		this.indContTelef = indContTelef;
	}
	public Long getIndDocComp() {
		return indDocComp;
	}
	public void setIndDocComp(Long indDocComp) {
		this.indDocComp = indDocComp;
	}
	public String getIndEstVenta() {
		return indEstVenta;
	}
	public void setIndEstVenta(String indEstVenta) {
		this.indEstVenta = indEstVenta;
	}
	public String getIndOfiter() {
		return indOfiter;
	}
	public void setIndOfiter(String indOfiter) {
		this.indOfiter = indOfiter;
	}
	public Long getIndPasoCob() {
		return indPasoCob;
	}
	public void setIndPasoCob(Long indPasoCob) {
		this.indPasoCob = indPasoCob;
	}
	public Long getIndTipVenta() {
		return indTipVenta;
	}
	public void setIndTipVenta(Long indTipVenta) {
		this.indTipVenta = indTipVenta;
	}
	public String getIndVenta() {
		return indVenta;
	}
	public void setIndVenta(String indVenta) {
		this.indVenta = indVenta;
	}
	public Float getMtoGarantia() {
		return mtoGarantia;
	}
	public void setMtoGarantia(Float mtoGarantia) {
		this.mtoGarantia = mtoGarantia;
	}
	public String getNomUsuarAcerec() {
		return nomUsuarAcerec;
	}
	public void setNomUsuarAcerec(String nomUsuarAcerec) {
		this.nomUsuarAcerec = nomUsuarAcerec;
	}
	public String getNomUsuarCumpl() {
		return nomUsuarCumpl;
	}
	public void setNomUsuarCumpl(String nomUsuarCumpl) {
		this.nomUsuarCumpl = nomUsuarCumpl;
	}
	public String getNomUsuarRecDoc() {
		return nomUsuarRecDoc;
	}
	public void setNomUsuarRecDoc(String nomUsuarRecDoc) {
		this.nomUsuarRecDoc = nomUsuarRecDoc;
	}
	public String getNomUsuarRecProv() {
		return nomUsuarRecProv;
	}
	public void setNomUsuarRecProv(String nomUsuarRecProv) {
		this.nomUsuarRecProv = nomUsuarRecProv;
	}
	public String getNomUsuarVta() {
		return nomUsuarVta;
	}
	public void setNomUsuarVta(String nomUsuarVta) {
		this.nomUsuarVta = nomUsuarVta;
	}
	public String getNumCheque() {
		return numCheque;
	}
	public void setNumCheque(String numCheque) {
		this.numCheque = numCheque;
	}
	public Long getNumConsulta() {
		return numConsulta;
	}
	public void setNumConsulta(Long numConsulta) {
		this.numConsulta = numConsulta;
	}
	public String getNumContrato() {
		return numContrato;
	}
	public void setNumContrato(String numContrato) {
		this.numContrato = numContrato;
	}
	public String getNumCTACORR() {
		return numCTACORR;
	}
	public void setNumCTACORR(String numCTACORR) {
		this.numCTACORR = numCTACORR;
	}
	public Long getNumDias() {
		return numDias;
	}
	public void setNumDias(Long numDias) {
		this.numDias = numDias;
	}
	public Long getNumFolDealer() {
		return numFolDealer;
	}
	public void setNumFolDealer(Long numFolDealer) {
		this.numFolDealer = numFolDealer;
	}
	public Long getNumProceso() {
		return numProceso;
	}
	public void setNumProceso(Long numProceso) {
		this.numProceso = numProceso;
	}
	public String getNumTarjeta() {
		return numTarjeta;
	}
	public void setNumTarjeta(String _numTarjeta) {
		this.numTarjeta = _numTarjeta;
	}
	public Long getNumTransaccion() {
		return numTransaccion;
	}
	public void setNumTransaccion(Long numTransaccion) {
		this.numTransaccion = numTransaccion;
	}
	public Long getNumUnidades() {
		return numUnidades;
	}
	public void setNumUnidades(Long numUnidades) {
		this.numUnidades = numUnidades;
	}
	public Long getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(Long numVenta) {
		this.numVenta = numVenta;
	}
	public String getObsGralCumpl() {
		return ObsGralCumpl;
	}
	public void setObsGralCumpl(String obsGralCumpl) {
		ObsGralCumpl = obsGralCumpl;
	}
	public String getObsInCump() {
		return obsInCump;
	}
	public void setObsInCump(String obsInCump) {
		this.obsInCump = obsInCump;
	}
	public String getObsRecProv() {
		return obsRecProv;
	}
	public void setObsRecProv(String obsRecProv) {
		this.obsRecProv = obsRecProv;
	}
	public String getTipFoliacion() {
		return tipFoliacion;
	}
	public void setTipFoliacion(String tipFoliacion) {
		this.tipFoliacion = tipFoliacion;
	}
	public String getTipValor() {
		return tipValor;
	}
	public void setTipValor(String tipValor) {
		this.tipValor = tipValor;
	}
	public String getUsuarioContTelef() {
		return usuarioContTelef;
	}
	public void setUsuarioContTelef(String usuarioContTelef) {
		this.usuarioContTelef = usuarioContTelef;
	}
	public String getUsuRecepAdmVtas() {
		return usuRecepAdmVtas;
	}
	public void setUsuRecepAdmVtas(String usuRecepAdmVtas) {
		this.usuRecepAdmVtas = usuRecepAdmVtas;
	}
	public String getFormPago() {
		return formPago;
	}
	public void setFormPago(String formPago) {
		this.formPago = formPago;
	}
	public boolean isCheque() {
		return isCheque;
	}
	public void setCheque(boolean isCheque) {
		this.isCheque = isCheque;
	}
	public String getTipoPlanHibrido() {
		return tipoPlanHibrido;
	}
	public void setTipoPlanHibrido(String tipoPlanHibrido) {
		this.tipoPlanHibrido = tipoPlanHibrido;
	}
	public String getTipoPlanPostpago() {
		return tipoPlanPostpago;
	}
	public void setTipoPlanPostpago(String tipoPlanPostpago) {
		this.tipoPlanPostpago = tipoPlanPostpago;
	}
	public String getNumIdentCliente() {
		return numIdentCliente;
	}
	public void setNumIdentCliente(String numIdentCliente) {
		this.numIdentCliente = numIdentCliente;
	}
	public String getTipIdentCliente() {
		return tipIdentCliente;
	}
	public void setTipIdentCliente(String tipIdentCliente) {
		this.tipIdentCliente = tipIdentCliente;
	}
	public String getIndicadorCuotas() {
		return indicadorCuotas;
	}
	public void setIndicadorCuotas(String indicadorCuotas) {
		this.indicadorCuotas = indicadorCuotas;
	}
	public int getIndComodato() {
		return indComodato;
	}
	public void setIndComodato(int indComodato) {
		this.indComodato = indComodato;
	}
	public int getIndicadorContratoNuevo() {
		return indicadorContratoNuevo;
	}
	public void setIndicadorContratoNuevo(int indicadorContratoNuevo) {
		this.indicadorContratoNuevo = indicadorContratoNuevo;
	}
	public String getIndPortado() {
		return indPortado;
	}
	public void setIndPortado(String indPortado) {
		this.indPortado = indPortado;
	}
	public String getTipoPlanPrepago() {
		return tipoPlanPrepago;
	}
	public void setTipoPlanPrepago(String tipoPlanPrepago) {
		this.tipoPlanPrepago = tipoPlanPrepago;
	}
}
