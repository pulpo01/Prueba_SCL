/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 17/05/2007	     	Elizabeth Vera        				Versión Inicial
 * 18/07/2007           Raúl Lozano 					  se agrega campos
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;


import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoListDTO;

public class ClienteDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long codCliente;
	private String nombres;
	private String apellido1;
	private String apellido2;
	private long codCuenta;
	private String codSubCuenta;
	private String desCuenta;
	private String desSubCuenta;
	private int codCiclo;
	private String limiteConsumo;	
	private String codTipoTerminal;
	private String desTipoTerminal;
	private String codPlanTarif;
	private String desPlanTarif;
	private String codCargoBasico;
	private String desCargoBasico;
	private String codTipoPlanTarif;
	private String desTipPlanTarif;
	private String codTipoPlan;
	private String desTipPlan;
	private String desLimiteConsumo;	
	private int numAbonados;
	private String numeroIdentificacion;
	private String  codigoTipoIdentificacion;
	private Timestamp fechaNacimiento;
	private String indicadorEstadoCivil;
	private String indicadorSexo;
	private String codigoActividad;
	private String codigoCelda;
	private String codigoCalidadCliente;
	private int indicativoFacturable;
	private String codigoCiclo;
	private String codigoEmpresa;
	private DireccionDTO direccion;
	
	private String codCategoria;
	private AbonadoListDTO abonados;
	
	private String nombreCompleto;
	private boolean planFreedom;
	
	private float impCargoBasico;
	
	private String codTecnologia;
	
	private int indFamiliar;
	private long codProdPadre;
	private String tipCuenta;
	private int flgRango;
	
	private long codEmpresa;
	
	private int codPlanCom;
	
	private String codValor;
	private String primeraVenta;
	
	private int codCicloFacturacion;
	
	
	
	public String getPrimeraVenta() {
		return primeraVenta;
	}
	public void setPrimeraVenta(String primeraVenta) {
		this.primeraVenta = primeraVenta;
	}
	public String getCodValor() {
		return codValor;
	}
	public void setCodValor(String codValor) {
		this.codValor = codValor;
	}
	public int getCodPlanCom() {
		return codPlanCom;
	}
	public void setCodPlanCom(int codPlanCom) {
		this.codPlanCom = codPlanCom;
	}
	public long getCodEmpresa() {
		return codEmpresa;
	}
	public void setCodEmpresa(long codEmpresa) {
		this.codEmpresa = codEmpresa;
	}
	public long getCodProdPadre() {
		return codProdPadre;
	}
	public void setCodProdPadre(long codProdPadre) {
		this.codProdPadre = codProdPadre;
	}
	public int getFlgRango() {
		return flgRango;
	}
	public void setFlgRango(int flgRango) {
		this.flgRango = flgRango;
	}
	public int getIndFamiliar() {
		return indFamiliar;
	}
	public void setIndFamiliar(int indFamiliar) {
		this.indFamiliar = indFamiliar;
	}
	public String getTipCuenta() {
		return tipCuenta;
	}
	public void setTipCuenta(String tipCuenta) {
		this.tipCuenta = tipCuenta;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public float getImpCargoBasico() {
		return impCargoBasico;
	}
	public void setImpCargoBasico(float impCargoBasico) {
		this.impCargoBasico = impCargoBasico;
	}
	public boolean isPlanFreedom() {
		return planFreedom;
	}
	public void setPlanFreedom(boolean planFreedom) {
		this.planFreedom = planFreedom;
	}
	public String getNombreCompleto() {
		return nombreCompleto;
	}
	public void setNombreCompleto(String nombreCompleto) {
		this.nombreCompleto = nombreCompleto;
	}
	public String getDesLimiteConsumo() {
				
		return desLimiteConsumo;
	}
	public void setDesLimiteConsumo(String desLimiteConsumo) {
		this.desLimiteConsumo = desLimiteConsumo;
	}
	public int getNumAbonados() {
		return numAbonados;
	}
	public void setNumAbonados(int numAbonados) {
		this.numAbonados = numAbonados;
	}
	public String getApellido1() {
		return apellido1;
	}
	public void setApellido1(String apellido1) {
		this.apellido1 = apellido1;
	}
	public String getApellido2() {
		return apellido2;
	}
	public void setApellido2(String apellido2) {
		this.apellido2 = apellido2;
	}
	public String getCodCargoBasico() {
		return codCargoBasico;
	}
	public void setCodCargoBasico(String codCargoBasico) {
		this.codCargoBasico = codCargoBasico;
	}
	public int getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(int codCiclo) {
		this.codCiclo = codCiclo;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodCuenta() {
		return codCuenta;
	}
	public void setCodCuenta(long codCuenta) {
		this.codCuenta = codCuenta;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getCodSubCuenta() {
		return codSubCuenta;
	}
	public void setCodSubCuenta(String codSubCuenta) {
		this.codSubCuenta = codSubCuenta;
	}
	public String getCodTipoPlan() {
		return codTipoPlan;
	}
	public void setCodTipoPlan(String codTipoPlan) {
		this.codTipoPlan = codTipoPlan;
	}
	public String getCodTipoPlanTarif() {
		return codTipoPlanTarif;
	}
	public void setCodTipoPlanTarif(String codTipoPlanTarif) {
		this.codTipoPlanTarif = codTipoPlanTarif;
	}
	public String getCodTipoTerminal() {
		return codTipoTerminal;
	}
	public void setCodTipoTerminal(String codTipoTerminal) {
		this.codTipoTerminal = codTipoTerminal;
	}
	public String getDesCargoBasico() {
		return desCargoBasico;
	}
	public void setDesCargoBasico(String desCargoBasico) {
		this.desCargoBasico = desCargoBasico;
	}
	public String getDesCuenta() {
		return desCuenta;
	}
	public void setDesCuenta(String desCuenta) {
		this.desCuenta = desCuenta;
	}
	public String getDesPlanTarif() {
		return desPlanTarif;
	}
	public void setDesPlanTarif(String desPlanTarif) {
		this.desPlanTarif = desPlanTarif;
	}
	public String getDesSubCuenta() {
		return desSubCuenta;
	}
	public void setDesSubCuenta(String desSubCuenta) {
		this.desSubCuenta = desSubCuenta;
	}
	public String getDesTipoTerminal() {
		return desTipoTerminal;
	}
	public void setDesTipoTerminal(String desTipoTerminal) {
		this.desTipoTerminal = desTipoTerminal;
	}
	public String getDesTipPlan() {
		return desTipPlan;
	}
	public void setDesTipPlan(String desTipPlan) {
		this.desTipPlan = desTipPlan;
	}
	public String getDesTipPlanTarif() {
		return desTipPlanTarif;
	}
	public void setDesTipPlanTarif(String desTipPlanTarif) {
		this.desTipPlanTarif = desTipPlanTarif;
	}
	public String getLimiteConsumo() {
		return limiteConsumo;
	}
	public void setLimiteConsumo(String limiteConsumo) {
		this.limiteConsumo = limiteConsumo;
	}
	public String getNombres() {
		return nombres;
	}
	public void setNombres(String nombres) {
		this.nombres = nombres;
	}
	public AbonadoListDTO getAbonados() {
		return abonados;
	}
	public void setAbonados(AbonadoListDTO abonados) {
		this.abonados = abonados;
	}
	public String getCodCategoria() {
		return codCategoria;
	}
	public void setCodCategoria(String codCategoria) {
		this.codCategoria = codCategoria;
	}
	public String getCodigoActividad() {
		return codigoActividad;
	}
	public void setCodigoActividad(String codigoActividad) {
		this.codigoActividad = codigoActividad;
	}
	public String getCodigoTipoIdentificacion() {
		return codigoTipoIdentificacion;
	}
	public void setCodigoTipoIdentificacion(String codigoTipoIdentificacion) {
		this.codigoTipoIdentificacion = codigoTipoIdentificacion;
	}
	public Timestamp getFechaNacimiento() {
		return fechaNacimiento;
	}
	public void setFechaNacimiento(Timestamp fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}
	public String getIndicadorEstadoCivil() {
		return indicadorEstadoCivil;
	}
	public void setIndicadorEstadoCivil(String indicadorEstadoCivil) {
		this.indicadorEstadoCivil = indicadorEstadoCivil;
	}
	public String getIndicadorSexo() {
		return indicadorSexo;
	}
	public void setIndicadorSexo(String indicadorSexo) {
		this.indicadorSexo = indicadorSexo;
	}
	public String getNumeroIdentificacion() {
		return numeroIdentificacion;
	}
	public void setNumeroIdentificacion(String numeroIdentificacion) {
		this.numeroIdentificacion = numeroIdentificacion;
	}
	public String getCodigoCalidadCliente() {
		return codigoCalidadCliente;
	}
	public void setCodigoCalidadCliente(String codigoCalidadCliente) {
		this.codigoCalidadCliente = codigoCalidadCliente;
	}
	public String getCodigoCelda() {
		return codigoCelda;
	}
	public void setCodigoCelda(String codigoCelda) {
		this.codigoCelda = codigoCelda;
	}
	public String getCodigoCiclo() {
		return codigoCiclo;
	}
	public void setCodigoCiclo(String codigoCiclo) {
		this.codigoCiclo = codigoCiclo;
	}
	public String getCodigoEmpresa() {
		return codigoEmpresa;
	}
	public void setCodigoEmpresa(String codigoEmpresa) {
		this.codigoEmpresa = codigoEmpresa;
	}
	public int getIndicativoFacturable() {
		return indicativoFacturable;
	}
	public void setIndicativoFacturable(int indicativoFacturable) {
		this.indicativoFacturable = indicativoFacturable;
	}
	public DireccionDTO getDireccion() {
		return direccion;
	}
	public void setDireccion(DireccionDTO direccion) {
		this.direccion = direccion;
	}
	public int getCodCicloFacturacion() {
		return codCicloFacturacion;
	}
	public void setCodCicloFacturacion(int codCicloFacturacion) {
		this.codCicloFacturacion = codCicloFacturacion;
	}
	
		
}
