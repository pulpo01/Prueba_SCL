/*P-CSR-11002 JLGN 04-05-2011*/
package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

public class DatosClienteBuroDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private String flagTipCliente;
	private String keyRef; 
	//Inicio datos generales
	private String nombre;
	private String apellido1;
	private String apellido2;
	private String numeroCedula;
	private String fallecido;
	private String codFallecido;
	//Inicio datos PEPS(persona expuesta politicamente)
	private String esPEP;
	private String institucionPEP;
	private String cargoPEP;
	private String periodoPEP;
	//Fin datos PEPS(persona expuesta politicamente)
	private String fechaVencimientoCedula;
	private String sexo;
	private String fechaNacimiento;
	private String paisNacimiento;
	private String prefijoPais;
	private String codPaisNacimiento;
	private String ciudadNacimiento;
	private String codCiudadNacimiento;
	private String edad;
	private String estadoCivil;
	private String codEstadoCivil;
	private String cantidadEventos;
	//Inicio datos Direccion
	private String codProvincia;
	private String desProvincia;
	private String codCanton;
	private String desCanton;
	private String codDistrito;
	private String desDistrito;
	private String bloqueo;
	private String codigoBloqueo;
	private String desDireccion;
	private String codComuna;
	//Fin datos Direccion
	//Inicio Datos Cedula Juridica
	private String fechaVencimiento;
	private String tomo;
	private String folio;
	//P-CSR-11002 JLGN 16-06-2011
	private String razonSocial;
	private String asiento;
	private String clasificacion;
	private String actividad;
	private String telefono;
	private String personeriaSociedad;
	private String domicilio;
	private String representacion;
	//Inicio datos tipo nombramiento	
	private TipoNombramientoDTO[] tipoNombramientoDTO;	
	//Fin datos tipo nombramiento
	//Fin Datos Cedula Juridica
	private String celular;	
	//Fin datos generales
	//Inicio datos Calificador
	private String tipProducto;
	private String tipSegmento;
	private String datosGenerales;
	private String laboral;
	private String histConsulta;
	private String RefCredito;
	private String libEntradaHistorico; //Juicio
	private String libEntradaActivo; //Juicio
	private String resulCalificacion;
	//P-CSR-11002 JLGN 31-05-2011
	private String limiteDeCredito;	
	private String codInterno;
	//P-CSR-11002 JLGN 14-11-2011
	private String limiteDeCreditoConCargo;
	//Fin datos Calificador
	//Inicio Datos Informacion Laboral
	//Inicio Datos Trabajo
	private String nombreTrabajo;
	private String nombreComercial;
	private String provinciaPatrono;
	private String cantonPatrono;
	private String distritoPatrono;
	private String codTipPatrono;
	private String cedulaTrabajo;
	private String finesTrabajo;
	private String ocupacion;
	private String codOcupacion;
	private String salario;
	private String prom3Meses;
	private String prom6Meses;
	private String prom12Meses;
	private String fechaRegistro;
	private String tiempoLaboral;
	private String mesesLaboral;
	//Inicio Datos Morosidad
	private String montoDeuda;
	private String numCuotas;
	//Fin Datos Morosidad
	//Inicio datos Direccion trabajo
	private String desDirecTrabajo;
	//Fin datos Direccion trabajo
	private String centralTelefonica;
	//Fin Datos Trabajo
	//Fin Datos Informacion Laboral
	//Inicio Datos Historico Laboral
	private DatosLaboralHistoricoBuroDTO[] datosLaboralHist; 
	//Fin Datos Historico Laboral
	//Inicio Datos Parientes
	private String nombreConyuge;
	private String apellido1Conyuge;
	private String apellido2Conyuge;
	private String nombreCompletoConyuge;
	private String fallecidoConyuge;
	private String codFallecidoConyuge;
	private String cedulaConyuge;
	private String nomRelacion;
	private String codRelacion;
	private String laboraConyuge;
	//Inicio Datos posibles Hijos
	private DatosHijoClienteBuroDTO hijosCliente[];
	//Fin Datos posibles Hijos
	private String nombreMadre;
	private String codParentescoMadre;
	private String fallecidaMadre;
	private String codFallecidaMadre;
	private String cedulaMadre;
	private String nombrePadre;
	private String codParentescoPadre;
	private String fallecidaPadre;
	private String codFallecidaPadre;
	private String cedulaPadre;	
	//Fin Datos Parientes
	//Inicio Datos Sociedad
	private String nombreSociedad;
	private String cedulaSociedad;
	private String puestoSociedad;
	private String fechaConsultadaSociedad;
	//Fin Datos Sociedad
	//Inicio Inc. 179734 JLGN 01-01-2012 
	private String flagDDA; 
	private String mensError;
	
	public String getMensError() {
		return mensError;
	}
	public void setMensError(String mensError) {
		this.mensError = mensError;
	}
	public String getFlagDDA() {
		return flagDDA;
	}
	public void setFlagDDA(String flagDDA) {
		this.flagDDA = flagDDA;
	}
	//Fin Inc. 179734 JLGN 01-01-2012 Domiciliación Débito Automático
	public String getApellido1() {
		return apellido1;
	}
	public void setApellido1(String apellido1) {
		this.apellido1 = apellido1;
	}
	public String getApellido1Conyuge() {
		return apellido1Conyuge;
	}
	public void setApellido1Conyuge(String apellido1Conyuge) {
		this.apellido1Conyuge = apellido1Conyuge;
	}
	public String getApellido2() {
		return apellido2;
	}
	public void setApellido2(String apellido2) {
		this.apellido2 = apellido2;
	}
	public String getApellido2Conyuge() {
		return apellido2Conyuge;
	}
	public void setApellido2Conyuge(String apellido2Conyuge) {
		this.apellido2Conyuge = apellido2Conyuge;
	}
	public String getBloqueo() {
		return bloqueo;
	}
	public void setBloqueo(String bloqueo) {
		this.bloqueo = bloqueo;
	}
	public String getCantidadEventos() {
		return cantidadEventos;
	}
	public void setCantidadEventos(String cantidadEventos) {
		this.cantidadEventos = cantidadEventos;
	}
	public String getCantonPatrono() {
		return cantonPatrono;
	}
	public void setCantonPatrono(String cantonPatrono) {
		this.cantonPatrono = cantonPatrono;
	}
	public String getCargoPEP() {
		return cargoPEP;
	}
	public void setCargoPEP(String cargoPEP) {
		this.cargoPEP = cargoPEP;
	}
	public String getCedulaConyuge() {
		return cedulaConyuge;
	}
	public void setCedulaConyuge(String cedulaConyuge) {
		this.cedulaConyuge = cedulaConyuge;
	}
	public String getCedulaMadre() {
		return cedulaMadre;
	}
	public void setCedulaMadre(String cedulaMadre) {
		this.cedulaMadre = cedulaMadre;
	}
	public String getCedulaPadre() {
		return cedulaPadre;
	}
	public void setCedulaPadre(String cedulaPadre) {
		this.cedulaPadre = cedulaPadre;
	}
	public String getCedulaSociedad() {
		return cedulaSociedad;
	}
	public void setCedulaSociedad(String cedulaSociedad) {
		this.cedulaSociedad = cedulaSociedad;
	}
	public String getCedulaTrabajo() {
		return cedulaTrabajo;
	}
	public void setCedulaTrabajo(String cedulaTrabajo) {
		this.cedulaTrabajo = cedulaTrabajo;
	}
	public String getCelular() {
		return celular;
	}
	public void setCelular(String celular) {
		this.celular = celular;
	}
	public String getCentralTelefonica() {
		return centralTelefonica;
	}
	public void setCentralTelefonica(String centralTelefonica) {
		this.centralTelefonica = centralTelefonica;
	}
	public String getCiudadNacimiento() {
		return ciudadNacimiento;
	}
	public void setCiudadNacimiento(String ciudadNacimiento) {
		this.ciudadNacimiento = ciudadNacimiento;
	}
	public String getCodCanton() {
		return codCanton;
	}
	public void setCodCanton(String codCanton) {
		this.codCanton = codCanton;
	}
	public String getCodCiudadNacimiento() {
		return codCiudadNacimiento;
	}
	public void setCodCiudadNacimiento(String codCiudadNacimiento) {
		this.codCiudadNacimiento = codCiudadNacimiento;
	}
	public String getCodDistrito() {
		return codDistrito;
	}
	public void setCodDistrito(String codDistrito) {
		this.codDistrito = codDistrito;
	}
	public String getCodEstadoCivil() {
		return codEstadoCivil;
	}
	public void setCodEstadoCivil(String codEstadoCivil) {
		this.codEstadoCivil = codEstadoCivil;
	}
	public String getCodFallecidaMadre() {
		return codFallecidaMadre;
	}
	public void setCodFallecidaMadre(String codFallecidaMadre) {
		this.codFallecidaMadre = codFallecidaMadre;
	}
	public String getCodFallecidaPadre() {
		return codFallecidaPadre;
	}
	public void setCodFallecidaPadre(String codFallecidaPadre) {
		this.codFallecidaPadre = codFallecidaPadre;
	}
	public String getCodFallecido() {
		return codFallecido;
	}
	public void setCodFallecido(String codFallecido) {
		this.codFallecido = codFallecido;
	}
	public String getCodFallecidoConyuge() {
		return codFallecidoConyuge;
	}
	public void setCodFallecidoConyuge(String codFallecidoConyuge) {
		this.codFallecidoConyuge = codFallecidoConyuge;
	}
	public String getCodigoBloqueo() {
		return codigoBloqueo;
	}
	public void setCodigoBloqueo(String codigoBloqueo) {
		this.codigoBloqueo = codigoBloqueo;
	}
	public String getCodInterno() {
		return codInterno;
	}
	public void setCodInterno(String codInterno) {
		this.codInterno = codInterno;
	}
	public String getCodOcupacion() {
		return codOcupacion;
	}
	public void setCodOcupacion(String codOcupacion) {
		this.codOcupacion = codOcupacion;
	}
	public String getCodPaisNacimiento() {
		return codPaisNacimiento;
	}
	public void setCodPaisNacimiento(String codPaisNacimiento) {
		this.codPaisNacimiento = codPaisNacimiento;
	}
	public String getCodParentescoMadre() {
		return codParentescoMadre;
	}
	public void setCodParentescoMadre(String codParentescoMadre) {
		this.codParentescoMadre = codParentescoMadre;
	}
	public String getCodParentescoPadre() {
		return codParentescoPadre;
	}
	public void setCodParentescoPadre(String codParentescoPadre) {
		this.codParentescoPadre = codParentescoPadre;
	}
	public String getCodProvincia() {
		return codProvincia;
	}
	public void setCodProvincia(String codProvincia) {
		this.codProvincia = codProvincia;
	}
	public String getCodRelacion() {
		return codRelacion;
	}
	public void setCodRelacion(String codRelacion) {
		this.codRelacion = codRelacion;
	}
	public String getCodTipPatrono() {
		return codTipPatrono;
	}
	public void setCodTipPatrono(String codTipPatrono) {
		this.codTipPatrono = codTipPatrono;
	}
	public String getDatosGenerales() {
		return datosGenerales;
	}
	public void setDatosGenerales(String datosGenerales) {
		this.datosGenerales = datosGenerales;
	}
	public DatosLaboralHistoricoBuroDTO[] getDatosLaboralHist() {
		return datosLaboralHist;
	}
	public void setDatosLaboralHist(DatosLaboralHistoricoBuroDTO[] datosLaboralHist) {
		this.datosLaboralHist = datosLaboralHist;
	}
	public String getDesDireccion() {
		return desDireccion;
	}
	public void setDesDireccion(String desDireccion) {
		this.desDireccion = desDireccion;
	}
	public String getDesDirecTrabajo() {
		return desDirecTrabajo;
	}
	public void setDesDirecTrabajo(String desDirecTrabajo) {
		this.desDirecTrabajo = desDirecTrabajo;
	}
	public String getDistritoPatrono() {
		return distritoPatrono;
	}
	public void setDistritoPatrono(String distritoPatrono) {
		this.distritoPatrono = distritoPatrono;
	}
	public String getEdad() {
		return edad;
	}
	public void setEdad(String edad) {
		this.edad = edad;
	}
	public String getEsPEP() {
		return esPEP;
	}
	public void setEsPEP(String esPEP) {
		this.esPEP = esPEP;
	}
	public String getEstadoCivil() {
		return estadoCivil;
	}
	public void setEstadoCivil(String estadoCivil) {
		this.estadoCivil = estadoCivil;
	}
	public String getFallecidaMadre() {
		return fallecidaMadre;
	}
	public void setFallecidaMadre(String fallecidaMadre) {
		this.fallecidaMadre = fallecidaMadre;
	}
	public String getFallecidaPadre() {
		return fallecidaPadre;
	}
	public void setFallecidaPadre(String fallecidaPadre) {
		this.fallecidaPadre = fallecidaPadre;
	}
	public String getFallecido() {
		return fallecido;
	}
	public void setFallecido(String fallecido) {
		this.fallecido = fallecido;
	}
	public String getFallecidoConyuge() {
		return fallecidoConyuge;
	}
	public void setFallecidoConyuge(String fallecidoConyuge) {
		this.fallecidoConyuge = fallecidoConyuge;
	}
	public String getFechaConsultadaSociedad() {
		return fechaConsultadaSociedad;
	}
	public void setFechaConsultadaSociedad(String fechaConsultadaSociedad) {
		this.fechaConsultadaSociedad = fechaConsultadaSociedad;
	}
	public String getFechaNacimiento() {
		return fechaNacimiento;
	}
	public void setFechaNacimiento(String fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}
	public String getFechaRegistro() {
		return fechaRegistro;
	}
	public void setFechaRegistro(String fechaRegistro) {
		this.fechaRegistro = fechaRegistro;
	}
	public String getFechaVencimientoCedula() {
		return fechaVencimientoCedula;
	}
	public void setFechaVencimientoCedula(String fechaVencimientoCedula) {
		this.fechaVencimientoCedula = fechaVencimientoCedula;
	}
	public String getFinesTrabajo() {
		return finesTrabajo;
	}
	public void setFinesTrabajo(String finesTrabajo) {
		this.finesTrabajo = finesTrabajo;
	}
	public DatosHijoClienteBuroDTO[] getHijosCliente() {
		return hijosCliente;
	}
	public void setHijosCliente(DatosHijoClienteBuroDTO[] hijosCliente) {
		this.hijosCliente = hijosCliente;
	}
	public String getHistConsulta() {
		return histConsulta;
	}
	public void setHistConsulta(String histConsulta) {
		this.histConsulta = histConsulta;
	}
	public String getInstitucionPEP() {
		return institucionPEP;
	}
	public void setInstitucionPEP(String institucionPEP) {
		this.institucionPEP = institucionPEP;
	}
	public String getKeyRef() {
		return keyRef;
	}
	public void setKeyRef(String keyRef) {
		this.keyRef = keyRef;
	}
	public String getLaboraConyuge() {
		return laboraConyuge;
	}
	public void setLaboraConyuge(String laboraConyuge) {
		this.laboraConyuge = laboraConyuge;
	}
	public String getLaboral() {
		return laboral;
	}
	public void setLaboral(String laboral) {
		this.laboral = laboral;
	}
	public String getLibEntradaActivo() {
		return libEntradaActivo;
	}
	public void setLibEntradaActivo(String libEntradaActivo) {
		this.libEntradaActivo = libEntradaActivo;
	}
	public String getLibEntradaHistorico() {
		return libEntradaHistorico;
	}
	public void setLibEntradaHistorico(String libEntradaHistorico) {
		this.libEntradaHistorico = libEntradaHistorico;
	}
	public String getMesesLaboral() {
		return mesesLaboral;
	}
	public void setMesesLaboral(String mesesLaboral) {
		this.mesesLaboral = mesesLaboral;
	}
	public String getMontoDeuda() {
		return montoDeuda;
	}
	public void setMontoDeuda(String montoDeuda) {
		this.montoDeuda = montoDeuda;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getNombreComercial() {
		return nombreComercial;
	}
	public void setNombreComercial(String nombreComercial) {
		this.nombreComercial = nombreComercial;
	}
	public String getNombreCompletoConyuge() {
		return nombreCompletoConyuge;
	}
	public void setNombreCompletoConyuge(String nombreCompletoConyuge) {
		this.nombreCompletoConyuge = nombreCompletoConyuge;
	}
	public String getNombreConyuge() {
		return nombreConyuge;
	}
	public void setNombreConyuge(String nombreConyuge) {
		this.nombreConyuge = nombreConyuge;
	}
	public String getNombreMadre() {
		return nombreMadre;
	}
	public void setNombreMadre(String nombreMadre) {
		this.nombreMadre = nombreMadre;
	}
	public String getNombrePadre() {
		return nombrePadre;
	}
	public void setNombrePadre(String nombrePadre) {
		this.nombrePadre = nombrePadre;
	}
	public String getNombreSociedad() {
		return nombreSociedad;
	}
	public void setNombreSociedad(String nombreSociedad) {
		this.nombreSociedad = nombreSociedad;
	}
	public String getNombreTrabajo() {
		return nombreTrabajo;
	}
	public void setNombreTrabajo(String nombreTrabajo) {
		this.nombreTrabajo = nombreTrabajo;
	}
	public String getNomRelacion() {
		return nomRelacion;
	}
	public void setNomRelacion(String nomRelacion) {
		this.nomRelacion = nomRelacion;
	}
	public String getNumCuotas() {
		return numCuotas;
	}
	public void setNumCuotas(String numCuotas) {
		this.numCuotas = numCuotas;
	}
	public String getNumeroCedula() {
		return numeroCedula;
	}
	public void setNumeroCedula(String numeroCedula) {
		this.numeroCedula = numeroCedula;
	}
	public String getOcupacion() {
		return ocupacion;
	}
	public void setOcupacion(String ocupacion) {
		this.ocupacion = ocupacion;
	}
	public String getPaisNacimiento() {
		return paisNacimiento;
	}
	public void setPaisNacimiento(String paisNacimiento) {
		this.paisNacimiento = paisNacimiento;
	}
	public String getPeriodoPEP() {
		return periodoPEP;
	}
	public void setPeriodoPEP(String periodoPEP) {
		this.periodoPEP = periodoPEP;
	}
	public String getProm12Meses() {
		return prom12Meses;
	}
	public void setProm12Meses(String prom12Meses) {
		this.prom12Meses = prom12Meses;
	}
	public String getProm3Meses() {
		return prom3Meses;
	}
	public void setProm3Meses(String prom3Meses) {
		this.prom3Meses = prom3Meses;
	}
	public String getProm6Meses() {
		return prom6Meses;
	}
	public void setProm6Meses(String prom6Meses) {
		this.prom6Meses = prom6Meses;
	}
	public String getProvinciaPatrono() {
		return provinciaPatrono;
	}
	public void setProvinciaPatrono(String provinciaPatrono) {
		this.provinciaPatrono = provinciaPatrono;
	}
	public String getPuestoSociedad() {
		return puestoSociedad;
	}
	public void setPuestoSociedad(String puestoSociedad) {
		this.puestoSociedad = puestoSociedad;
	}
	public String getRefCredito() {
		return RefCredito;
	}
	public void setRefCredito(String refCredito) {
		RefCredito = refCredito;
	}
	public String getResulCalificacion() {
		return resulCalificacion;
	}
	public void setResulCalificacion(String resulCalificacion) {
		this.resulCalificacion = resulCalificacion;
	}
	public String getSalario() {
		return salario;
	}
	public void setSalario(String salario) {
		this.salario = salario;
	}
	public String getSexo() {
		return sexo;
	}
	public void setSexo(String sexo) {
		this.sexo = sexo;
	}
	public String getTiempoLaboral() {
		return tiempoLaboral;
	}
	public void setTiempoLaboral(String tiempoLaboral) {
		this.tiempoLaboral = tiempoLaboral;
	}
	public String getTipProducto() {
		return tipProducto;
	}
	public void setTipProducto(String tipProducto) {
		this.tipProducto = tipProducto;
	}
	public String getTipSegmento() {
		return tipSegmento;
	}
	public void setTipSegmento(String tipSegmento) {
		this.tipSegmento = tipSegmento;
	}
	public String getActividad() {
		return actividad;
	}
	public void setActividad(String actividad) {
		this.actividad = actividad;
	}	
	public String getAsiento() {
		return asiento;
	}
	public void setAsiento(String asiento) {
		this.asiento = asiento;
	}	
	public String getClasificacion() {
		return clasificacion;
	}
	public void setClasificacion(String clasificacion) {
		this.clasificacion = clasificacion;
	}
	public String getDomicilio() {
		return domicilio;
	}
	public void setDomicilio(String domicilio) {
		this.domicilio = domicilio;
	}
	public String getFolio() {
		return folio;
	}
	public void setFolio(String folio) {
		this.folio = folio;
	}
	public String getPersoneriaSociedad() {
		return personeriaSociedad;
	}
	public void setPersoneriaSociedad(String personeriaSociedad) {
		this.personeriaSociedad = personeriaSociedad;
	}
	public String getRepresentacion() {
		return representacion;
	}
	public void setRepresentacion(String representacion) {
		this.representacion = representacion;
	}
	public String getTelefono() {
		return telefono;
	}
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	public String getTomo() {
		return tomo;
	}
	public void setTomo(String tomo) {
		this.tomo = tomo;
	}
	public String getFechaVencimiento() {
		return fechaVencimiento;
	}
	public void setFechaVencimiento(String fechaVencimiento) {
		this.fechaVencimiento = fechaVencimiento;
	}
	public TipoNombramientoDTO[] getTipoNombramientoDTO() {
		return tipoNombramientoDTO;
	}
	public void setTipoNombramientoDTO(TipoNombramientoDTO[] tipoNombramientoDTO) {
		this.tipoNombramientoDTO = tipoNombramientoDTO;
	}
	public String getFlagTipCliente() {
		return flagTipCliente;
	}
	public void setFlagTipCliente(String flagTipCliente) {
		this.flagTipCliente = flagTipCliente;
	}
	public String getDesCanton() {
		return desCanton;
	}
	public void setDesCanton(String desCanton) {
		this.desCanton = desCanton;
	}
	public String getDesDistrito() {
		return desDistrito;
	}
	public void setDesDistrito(String desDistrito) {
		this.desDistrito = desDistrito;
	}
	public String getDesProvincia() {
		return desProvincia;
	}
	public void setDesProvincia(String desProvincia) {
		this.desProvincia = desProvincia;
	}
	public String getLimiteDeCredito() {
		return limiteDeCredito;
	}
	public void setLimiteDeCredito(String limiteDeCredito) {
		this.limiteDeCredito = limiteDeCredito;
	}
	public String getCodComuna() {
		return codComuna;
	}
	public void setCodComuna(String codComuna) {
		this.codComuna = codComuna;
	}
	public String getRazonSocial() {
		return razonSocial;
	}
	public void setRazonSocial(String razonSocial) {
		this.razonSocial = razonSocial;
	}
	public String getPrefijoPais() {
		return prefijoPais;
	}
	public void setPrefijoPais(String prefijoPais) {
		this.prefijoPais = prefijoPais;
	}
	public String getLimiteDeCreditoConCargo() {
		return limiteDeCreditoConCargo;
	}
	public void setLimiteDeCreditoConCargo(String limiteDeCreditoConCargo) {
		this.limiteDeCreditoConCargo = limiteDeCreditoConCargo;
	}		
}
