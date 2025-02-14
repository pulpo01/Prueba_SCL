/**
 * WsClienteInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsClienteInDTO  implements java.io.Serializable {
    private dto.commonapp.scl.cl.tmmas.com.WsApoderadoInDTO apoderado;

    private dto.commonapp.scl.cl.tmmas.com.WsBancoInDTO banco;

    private java.lang.String codCrediticia;

    private java.lang.String codDireccionCorrespondencia;

    private java.lang.String codDireccionFacturacion;

    private java.lang.String codDireccionPersonal;

    private java.lang.String codSistemaPago;

    private java.lang.String codigoCategImpos;

    private java.lang.String codigoCategoria;

    private long codigoCiclo;

    private java.lang.String codigoOficina;

    private java.lang.String codigoPais;

    private java.lang.String codigoPlanTarifario;

    private java.lang.String codigoTipIdent2;

    private java.lang.String codigoTipoIdent;

    private java.lang.String codigoUso;

    private java.lang.String fechaNacimiento;

    private java.lang.String indicadorEstadoCivil;

    private java.lang.String indicadorSexo;

    private java.lang.String nombreApeclien1;

    private java.lang.String nombreApeclien2;

    private java.lang.String nombreCliente;

    private java.lang.String nombreEmail;

    private java.lang.String numIdent2;

    private java.lang.String numeroFax;

    private java.lang.String numeroIdent;

    private java.lang.String numeroIntGrupoFam;

    private java.lang.String pagoAtumaticoManual;

    private dto.commonapp.scl.cl.tmmas.com.WsResponsableInDTO responsable;

    private java.lang.String telefonoContac1;

    private java.lang.String telefonoContac2;

    public WsClienteInDTO() {
    }

    public WsClienteInDTO(
           dto.commonapp.scl.cl.tmmas.com.WsApoderadoInDTO apoderado,
           dto.commonapp.scl.cl.tmmas.com.WsBancoInDTO banco,
           java.lang.String codCrediticia,
           java.lang.String codDireccionCorrespondencia,
           java.lang.String codDireccionFacturacion,
           java.lang.String codDireccionPersonal,
           java.lang.String codSistemaPago,
           java.lang.String codigoCategImpos,
           java.lang.String codigoCategoria,
           long codigoCiclo,
           java.lang.String codigoOficina,
           java.lang.String codigoPais,
           java.lang.String codigoPlanTarifario,
           java.lang.String codigoTipIdent2,
           java.lang.String codigoTipoIdent,
           java.lang.String codigoUso,
           java.lang.String fechaNacimiento,
           java.lang.String indicadorEstadoCivil,
           java.lang.String indicadorSexo,
           java.lang.String nombreApeclien1,
           java.lang.String nombreApeclien2,
           java.lang.String nombreCliente,
           java.lang.String nombreEmail,
           java.lang.String numIdent2,
           java.lang.String numeroFax,
           java.lang.String numeroIdent,
           java.lang.String numeroIntGrupoFam,
           java.lang.String pagoAtumaticoManual,
           dto.commonapp.scl.cl.tmmas.com.WsResponsableInDTO responsable,
           java.lang.String telefonoContac1,
           java.lang.String telefonoContac2) {
           this.apoderado = apoderado;
           this.banco = banco;
           this.codCrediticia = codCrediticia;
           this.codDireccionCorrespondencia = codDireccionCorrespondencia;
           this.codDireccionFacturacion = codDireccionFacturacion;
           this.codDireccionPersonal = codDireccionPersonal;
           this.codSistemaPago = codSistemaPago;
           this.codigoCategImpos = codigoCategImpos;
           this.codigoCategoria = codigoCategoria;
           this.codigoCiclo = codigoCiclo;
           this.codigoOficina = codigoOficina;
           this.codigoPais = codigoPais;
           this.codigoPlanTarifario = codigoPlanTarifario;
           this.codigoTipIdent2 = codigoTipIdent2;
           this.codigoTipoIdent = codigoTipoIdent;
           this.codigoUso = codigoUso;
           this.fechaNacimiento = fechaNacimiento;
           this.indicadorEstadoCivil = indicadorEstadoCivil;
           this.indicadorSexo = indicadorSexo;
           this.nombreApeclien1 = nombreApeclien1;
           this.nombreApeclien2 = nombreApeclien2;
           this.nombreCliente = nombreCliente;
           this.nombreEmail = nombreEmail;
           this.numIdent2 = numIdent2;
           this.numeroFax = numeroFax;
           this.numeroIdent = numeroIdent;
           this.numeroIntGrupoFam = numeroIntGrupoFam;
           this.pagoAtumaticoManual = pagoAtumaticoManual;
           this.responsable = responsable;
           this.telefonoContac1 = telefonoContac1;
           this.telefonoContac2 = telefonoContac2;
    }


    /**
     * Gets the apoderado value for this WsClienteInDTO.
     * 
     * @return apoderado
     */
    public dto.commonapp.scl.cl.tmmas.com.WsApoderadoInDTO getApoderado() {
        return apoderado;
    }


    /**
     * Sets the apoderado value for this WsClienteInDTO.
     * 
     * @param apoderado
     */
    public void setApoderado(dto.commonapp.scl.cl.tmmas.com.WsApoderadoInDTO apoderado) {
        this.apoderado = apoderado;
    }


    /**
     * Gets the banco value for this WsClienteInDTO.
     * 
     * @return banco
     */
    public dto.commonapp.scl.cl.tmmas.com.WsBancoInDTO getBanco() {
        return banco;
    }


    /**
     * Sets the banco value for this WsClienteInDTO.
     * 
     * @param banco
     */
    public void setBanco(dto.commonapp.scl.cl.tmmas.com.WsBancoInDTO banco) {
        this.banco = banco;
    }


    /**
     * Gets the codCrediticia value for this WsClienteInDTO.
     * 
     * @return codCrediticia
     */
    public java.lang.String getCodCrediticia() {
        return codCrediticia;
    }


    /**
     * Sets the codCrediticia value for this WsClienteInDTO.
     * 
     * @param codCrediticia
     */
    public void setCodCrediticia(java.lang.String codCrediticia) {
        this.codCrediticia = codCrediticia;
    }


    /**
     * Gets the codDireccionCorrespondencia value for this WsClienteInDTO.
     * 
     * @return codDireccionCorrespondencia
     */
    public java.lang.String getCodDireccionCorrespondencia() {
        return codDireccionCorrespondencia;
    }


    /**
     * Sets the codDireccionCorrespondencia value for this WsClienteInDTO.
     * 
     * @param codDireccionCorrespondencia
     */
    public void setCodDireccionCorrespondencia(java.lang.String codDireccionCorrespondencia) {
        this.codDireccionCorrespondencia = codDireccionCorrespondencia;
    }


    /**
     * Gets the codDireccionFacturacion value for this WsClienteInDTO.
     * 
     * @return codDireccionFacturacion
     */
    public java.lang.String getCodDireccionFacturacion() {
        return codDireccionFacturacion;
    }


    /**
     * Sets the codDireccionFacturacion value for this WsClienteInDTO.
     * 
     * @param codDireccionFacturacion
     */
    public void setCodDireccionFacturacion(java.lang.String codDireccionFacturacion) {
        this.codDireccionFacturacion = codDireccionFacturacion;
    }


    /**
     * Gets the codDireccionPersonal value for this WsClienteInDTO.
     * 
     * @return codDireccionPersonal
     */
    public java.lang.String getCodDireccionPersonal() {
        return codDireccionPersonal;
    }


    /**
     * Sets the codDireccionPersonal value for this WsClienteInDTO.
     * 
     * @param codDireccionPersonal
     */
    public void setCodDireccionPersonal(java.lang.String codDireccionPersonal) {
        this.codDireccionPersonal = codDireccionPersonal;
    }


    /**
     * Gets the codSistemaPago value for this WsClienteInDTO.
     * 
     * @return codSistemaPago
     */
    public java.lang.String getCodSistemaPago() {
        return codSistemaPago;
    }


    /**
     * Sets the codSistemaPago value for this WsClienteInDTO.
     * 
     * @param codSistemaPago
     */
    public void setCodSistemaPago(java.lang.String codSistemaPago) {
        this.codSistemaPago = codSistemaPago;
    }


    /**
     * Gets the codigoCategImpos value for this WsClienteInDTO.
     * 
     * @return codigoCategImpos
     */
    public java.lang.String getCodigoCategImpos() {
        return codigoCategImpos;
    }


    /**
     * Sets the codigoCategImpos value for this WsClienteInDTO.
     * 
     * @param codigoCategImpos
     */
    public void setCodigoCategImpos(java.lang.String codigoCategImpos) {
        this.codigoCategImpos = codigoCategImpos;
    }


    /**
     * Gets the codigoCategoria value for this WsClienteInDTO.
     * 
     * @return codigoCategoria
     */
    public java.lang.String getCodigoCategoria() {
        return codigoCategoria;
    }


    /**
     * Sets the codigoCategoria value for this WsClienteInDTO.
     * 
     * @param codigoCategoria
     */
    public void setCodigoCategoria(java.lang.String codigoCategoria) {
        this.codigoCategoria = codigoCategoria;
    }


    /**
     * Gets the codigoCiclo value for this WsClienteInDTO.
     * 
     * @return codigoCiclo
     */
    public long getCodigoCiclo() {
        return codigoCiclo;
    }


    /**
     * Sets the codigoCiclo value for this WsClienteInDTO.
     * 
     * @param codigoCiclo
     */
    public void setCodigoCiclo(long codigoCiclo) {
        this.codigoCiclo = codigoCiclo;
    }


    /**
     * Gets the codigoOficina value for this WsClienteInDTO.
     * 
     * @return codigoOficina
     */
    public java.lang.String getCodigoOficina() {
        return codigoOficina;
    }


    /**
     * Sets the codigoOficina value for this WsClienteInDTO.
     * 
     * @param codigoOficina
     */
    public void setCodigoOficina(java.lang.String codigoOficina) {
        this.codigoOficina = codigoOficina;
    }


    /**
     * Gets the codigoPais value for this WsClienteInDTO.
     * 
     * @return codigoPais
     */
    public java.lang.String getCodigoPais() {
        return codigoPais;
    }


    /**
     * Sets the codigoPais value for this WsClienteInDTO.
     * 
     * @param codigoPais
     */
    public void setCodigoPais(java.lang.String codigoPais) {
        this.codigoPais = codigoPais;
    }


    /**
     * Gets the codigoPlanTarifario value for this WsClienteInDTO.
     * 
     * @return codigoPlanTarifario
     */
    public java.lang.String getCodigoPlanTarifario() {
        return codigoPlanTarifario;
    }


    /**
     * Sets the codigoPlanTarifario value for this WsClienteInDTO.
     * 
     * @param codigoPlanTarifario
     */
    public void setCodigoPlanTarifario(java.lang.String codigoPlanTarifario) {
        this.codigoPlanTarifario = codigoPlanTarifario;
    }


    /**
     * Gets the codigoTipIdent2 value for this WsClienteInDTO.
     * 
     * @return codigoTipIdent2
     */
    public java.lang.String getCodigoTipIdent2() {
        return codigoTipIdent2;
    }


    /**
     * Sets the codigoTipIdent2 value for this WsClienteInDTO.
     * 
     * @param codigoTipIdent2
     */
    public void setCodigoTipIdent2(java.lang.String codigoTipIdent2) {
        this.codigoTipIdent2 = codigoTipIdent2;
    }


    /**
     * Gets the codigoTipoIdent value for this WsClienteInDTO.
     * 
     * @return codigoTipoIdent
     */
    public java.lang.String getCodigoTipoIdent() {
        return codigoTipoIdent;
    }


    /**
     * Sets the codigoTipoIdent value for this WsClienteInDTO.
     * 
     * @param codigoTipoIdent
     */
    public void setCodigoTipoIdent(java.lang.String codigoTipoIdent) {
        this.codigoTipoIdent = codigoTipoIdent;
    }


    /**
     * Gets the codigoUso value for this WsClienteInDTO.
     * 
     * @return codigoUso
     */
    public java.lang.String getCodigoUso() {
        return codigoUso;
    }


    /**
     * Sets the codigoUso value for this WsClienteInDTO.
     * 
     * @param codigoUso
     */
    public void setCodigoUso(java.lang.String codigoUso) {
        this.codigoUso = codigoUso;
    }


    /**
     * Gets the fechaNacimiento value for this WsClienteInDTO.
     * 
     * @return fechaNacimiento
     */
    public java.lang.String getFechaNacimiento() {
        return fechaNacimiento;
    }


    /**
     * Sets the fechaNacimiento value for this WsClienteInDTO.
     * 
     * @param fechaNacimiento
     */
    public void setFechaNacimiento(java.lang.String fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }


    /**
     * Gets the indicadorEstadoCivil value for this WsClienteInDTO.
     * 
     * @return indicadorEstadoCivil
     */
    public java.lang.String getIndicadorEstadoCivil() {
        return indicadorEstadoCivil;
    }


    /**
     * Sets the indicadorEstadoCivil value for this WsClienteInDTO.
     * 
     * @param indicadorEstadoCivil
     */
    public void setIndicadorEstadoCivil(java.lang.String indicadorEstadoCivil) {
        this.indicadorEstadoCivil = indicadorEstadoCivil;
    }


    /**
     * Gets the indicadorSexo value for this WsClienteInDTO.
     * 
     * @return indicadorSexo
     */
    public java.lang.String getIndicadorSexo() {
        return indicadorSexo;
    }


    /**
     * Sets the indicadorSexo value for this WsClienteInDTO.
     * 
     * @param indicadorSexo
     */
    public void setIndicadorSexo(java.lang.String indicadorSexo) {
        this.indicadorSexo = indicadorSexo;
    }


    /**
     * Gets the nombreApeclien1 value for this WsClienteInDTO.
     * 
     * @return nombreApeclien1
     */
    public java.lang.String getNombreApeclien1() {
        return nombreApeclien1;
    }


    /**
     * Sets the nombreApeclien1 value for this WsClienteInDTO.
     * 
     * @param nombreApeclien1
     */
    public void setNombreApeclien1(java.lang.String nombreApeclien1) {
        this.nombreApeclien1 = nombreApeclien1;
    }


    /**
     * Gets the nombreApeclien2 value for this WsClienteInDTO.
     * 
     * @return nombreApeclien2
     */
    public java.lang.String getNombreApeclien2() {
        return nombreApeclien2;
    }


    /**
     * Sets the nombreApeclien2 value for this WsClienteInDTO.
     * 
     * @param nombreApeclien2
     */
    public void setNombreApeclien2(java.lang.String nombreApeclien2) {
        this.nombreApeclien2 = nombreApeclien2;
    }


    /**
     * Gets the nombreCliente value for this WsClienteInDTO.
     * 
     * @return nombreCliente
     */
    public java.lang.String getNombreCliente() {
        return nombreCliente;
    }


    /**
     * Sets the nombreCliente value for this WsClienteInDTO.
     * 
     * @param nombreCliente
     */
    public void setNombreCliente(java.lang.String nombreCliente) {
        this.nombreCliente = nombreCliente;
    }


    /**
     * Gets the nombreEmail value for this WsClienteInDTO.
     * 
     * @return nombreEmail
     */
    public java.lang.String getNombreEmail() {
        return nombreEmail;
    }


    /**
     * Sets the nombreEmail value for this WsClienteInDTO.
     * 
     * @param nombreEmail
     */
    public void setNombreEmail(java.lang.String nombreEmail) {
        this.nombreEmail = nombreEmail;
    }


    /**
     * Gets the numIdent2 value for this WsClienteInDTO.
     * 
     * @return numIdent2
     */
    public java.lang.String getNumIdent2() {
        return numIdent2;
    }


    /**
     * Sets the numIdent2 value for this WsClienteInDTO.
     * 
     * @param numIdent2
     */
    public void setNumIdent2(java.lang.String numIdent2) {
        this.numIdent2 = numIdent2;
    }


    /**
     * Gets the numeroFax value for this WsClienteInDTO.
     * 
     * @return numeroFax
     */
    public java.lang.String getNumeroFax() {
        return numeroFax;
    }


    /**
     * Sets the numeroFax value for this WsClienteInDTO.
     * 
     * @param numeroFax
     */
    public void setNumeroFax(java.lang.String numeroFax) {
        this.numeroFax = numeroFax;
    }


    /**
     * Gets the numeroIdent value for this WsClienteInDTO.
     * 
     * @return numeroIdent
     */
    public java.lang.String getNumeroIdent() {
        return numeroIdent;
    }


    /**
     * Sets the numeroIdent value for this WsClienteInDTO.
     * 
     * @param numeroIdent
     */
    public void setNumeroIdent(java.lang.String numeroIdent) {
        this.numeroIdent = numeroIdent;
    }


    /**
     * Gets the numeroIntGrupoFam value for this WsClienteInDTO.
     * 
     * @return numeroIntGrupoFam
     */
    public java.lang.String getNumeroIntGrupoFam() {
        return numeroIntGrupoFam;
    }


    /**
     * Sets the numeroIntGrupoFam value for this WsClienteInDTO.
     * 
     * @param numeroIntGrupoFam
     */
    public void setNumeroIntGrupoFam(java.lang.String numeroIntGrupoFam) {
        this.numeroIntGrupoFam = numeroIntGrupoFam;
    }


    /**
     * Gets the pagoAtumaticoManual value for this WsClienteInDTO.
     * 
     * @return pagoAtumaticoManual
     */
    public java.lang.String getPagoAtumaticoManual() {
        return pagoAtumaticoManual;
    }


    /**
     * Sets the pagoAtumaticoManual value for this WsClienteInDTO.
     * 
     * @param pagoAtumaticoManual
     */
    public void setPagoAtumaticoManual(java.lang.String pagoAtumaticoManual) {
        this.pagoAtumaticoManual = pagoAtumaticoManual;
    }


    /**
     * Gets the responsable value for this WsClienteInDTO.
     * 
     * @return responsable
     */
    public dto.commonapp.scl.cl.tmmas.com.WsResponsableInDTO getResponsable() {
        return responsable;
    }


    /**
     * Sets the responsable value for this WsClienteInDTO.
     * 
     * @param responsable
     */
    public void setResponsable(dto.commonapp.scl.cl.tmmas.com.WsResponsableInDTO responsable) {
        this.responsable = responsable;
    }


    /**
     * Gets the telefonoContac1 value for this WsClienteInDTO.
     * 
     * @return telefonoContac1
     */
    public java.lang.String getTelefonoContac1() {
        return telefonoContac1;
    }


    /**
     * Sets the telefonoContac1 value for this WsClienteInDTO.
     * 
     * @param telefonoContac1
     */
    public void setTelefonoContac1(java.lang.String telefonoContac1) {
        this.telefonoContac1 = telefonoContac1;
    }


    /**
     * Gets the telefonoContac2 value for this WsClienteInDTO.
     * 
     * @return telefonoContac2
     */
    public java.lang.String getTelefonoContac2() {
        return telefonoContac2;
    }


    /**
     * Sets the telefonoContac2 value for this WsClienteInDTO.
     * 
     * @param telefonoContac2
     */
    public void setTelefonoContac2(java.lang.String telefonoContac2) {
        this.telefonoContac2 = telefonoContac2;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsClienteInDTO)) return false;
        WsClienteInDTO other = (WsClienteInDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.apoderado==null && other.getApoderado()==null) || 
             (this.apoderado!=null &&
              this.apoderado.equals(other.getApoderado()))) &&
            ((this.banco==null && other.getBanco()==null) || 
             (this.banco!=null &&
              this.banco.equals(other.getBanco()))) &&
            ((this.codCrediticia==null && other.getCodCrediticia()==null) || 
             (this.codCrediticia!=null &&
              this.codCrediticia.equals(other.getCodCrediticia()))) &&
            ((this.codDireccionCorrespondencia==null && other.getCodDireccionCorrespondencia()==null) || 
             (this.codDireccionCorrespondencia!=null &&
              this.codDireccionCorrespondencia.equals(other.getCodDireccionCorrespondencia()))) &&
            ((this.codDireccionFacturacion==null && other.getCodDireccionFacturacion()==null) || 
             (this.codDireccionFacturacion!=null &&
              this.codDireccionFacturacion.equals(other.getCodDireccionFacturacion()))) &&
            ((this.codDireccionPersonal==null && other.getCodDireccionPersonal()==null) || 
             (this.codDireccionPersonal!=null &&
              this.codDireccionPersonal.equals(other.getCodDireccionPersonal()))) &&
            ((this.codSistemaPago==null && other.getCodSistemaPago()==null) || 
             (this.codSistemaPago!=null &&
              this.codSistemaPago.equals(other.getCodSistemaPago()))) &&
            ((this.codigoCategImpos==null && other.getCodigoCategImpos()==null) || 
             (this.codigoCategImpos!=null &&
              this.codigoCategImpos.equals(other.getCodigoCategImpos()))) &&
            ((this.codigoCategoria==null && other.getCodigoCategoria()==null) || 
             (this.codigoCategoria!=null &&
              this.codigoCategoria.equals(other.getCodigoCategoria()))) &&
            this.codigoCiclo == other.getCodigoCiclo() &&
            ((this.codigoOficina==null && other.getCodigoOficina()==null) || 
             (this.codigoOficina!=null &&
              this.codigoOficina.equals(other.getCodigoOficina()))) &&
            ((this.codigoPais==null && other.getCodigoPais()==null) || 
             (this.codigoPais!=null &&
              this.codigoPais.equals(other.getCodigoPais()))) &&
            ((this.codigoPlanTarifario==null && other.getCodigoPlanTarifario()==null) || 
             (this.codigoPlanTarifario!=null &&
              this.codigoPlanTarifario.equals(other.getCodigoPlanTarifario()))) &&
            ((this.codigoTipIdent2==null && other.getCodigoTipIdent2()==null) || 
             (this.codigoTipIdent2!=null &&
              this.codigoTipIdent2.equals(other.getCodigoTipIdent2()))) &&
            ((this.codigoTipoIdent==null && other.getCodigoTipoIdent()==null) || 
             (this.codigoTipoIdent!=null &&
              this.codigoTipoIdent.equals(other.getCodigoTipoIdent()))) &&
            ((this.codigoUso==null && other.getCodigoUso()==null) || 
             (this.codigoUso!=null &&
              this.codigoUso.equals(other.getCodigoUso()))) &&
            ((this.fechaNacimiento==null && other.getFechaNacimiento()==null) || 
             (this.fechaNacimiento!=null &&
              this.fechaNacimiento.equals(other.getFechaNacimiento()))) &&
            ((this.indicadorEstadoCivil==null && other.getIndicadorEstadoCivil()==null) || 
             (this.indicadorEstadoCivil!=null &&
              this.indicadorEstadoCivil.equals(other.getIndicadorEstadoCivil()))) &&
            ((this.indicadorSexo==null && other.getIndicadorSexo()==null) || 
             (this.indicadorSexo!=null &&
              this.indicadorSexo.equals(other.getIndicadorSexo()))) &&
            ((this.nombreApeclien1==null && other.getNombreApeclien1()==null) || 
             (this.nombreApeclien1!=null &&
              this.nombreApeclien1.equals(other.getNombreApeclien1()))) &&
            ((this.nombreApeclien2==null && other.getNombreApeclien2()==null) || 
             (this.nombreApeclien2!=null &&
              this.nombreApeclien2.equals(other.getNombreApeclien2()))) &&
            ((this.nombreCliente==null && other.getNombreCliente()==null) || 
             (this.nombreCliente!=null &&
              this.nombreCliente.equals(other.getNombreCliente()))) &&
            ((this.nombreEmail==null && other.getNombreEmail()==null) || 
             (this.nombreEmail!=null &&
              this.nombreEmail.equals(other.getNombreEmail()))) &&
            ((this.numIdent2==null && other.getNumIdent2()==null) || 
             (this.numIdent2!=null &&
              this.numIdent2.equals(other.getNumIdent2()))) &&
            ((this.numeroFax==null && other.getNumeroFax()==null) || 
             (this.numeroFax!=null &&
              this.numeroFax.equals(other.getNumeroFax()))) &&
            ((this.numeroIdent==null && other.getNumeroIdent()==null) || 
             (this.numeroIdent!=null &&
              this.numeroIdent.equals(other.getNumeroIdent()))) &&
            ((this.numeroIntGrupoFam==null && other.getNumeroIntGrupoFam()==null) || 
             (this.numeroIntGrupoFam!=null &&
              this.numeroIntGrupoFam.equals(other.getNumeroIntGrupoFam()))) &&
            ((this.pagoAtumaticoManual==null && other.getPagoAtumaticoManual()==null) || 
             (this.pagoAtumaticoManual!=null &&
              this.pagoAtumaticoManual.equals(other.getPagoAtumaticoManual()))) &&
            ((this.responsable==null && other.getResponsable()==null) || 
             (this.responsable!=null &&
              this.responsable.equals(other.getResponsable()))) &&
            ((this.telefonoContac1==null && other.getTelefonoContac1()==null) || 
             (this.telefonoContac1!=null &&
              this.telefonoContac1.equals(other.getTelefonoContac1()))) &&
            ((this.telefonoContac2==null && other.getTelefonoContac2()==null) || 
             (this.telefonoContac2!=null &&
              this.telefonoContac2.equals(other.getTelefonoContac2())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = 1;
        if (getApoderado() != null) {
            _hashCode += getApoderado().hashCode();
        }
        if (getBanco() != null) {
            _hashCode += getBanco().hashCode();
        }
        if (getCodCrediticia() != null) {
            _hashCode += getCodCrediticia().hashCode();
        }
        if (getCodDireccionCorrespondencia() != null) {
            _hashCode += getCodDireccionCorrespondencia().hashCode();
        }
        if (getCodDireccionFacturacion() != null) {
            _hashCode += getCodDireccionFacturacion().hashCode();
        }
        if (getCodDireccionPersonal() != null) {
            _hashCode += getCodDireccionPersonal().hashCode();
        }
        if (getCodSistemaPago() != null) {
            _hashCode += getCodSistemaPago().hashCode();
        }
        if (getCodigoCategImpos() != null) {
            _hashCode += getCodigoCategImpos().hashCode();
        }
        if (getCodigoCategoria() != null) {
            _hashCode += getCodigoCategoria().hashCode();
        }
        _hashCode += new Long(getCodigoCiclo()).hashCode();
        if (getCodigoOficina() != null) {
            _hashCode += getCodigoOficina().hashCode();
        }
        if (getCodigoPais() != null) {
            _hashCode += getCodigoPais().hashCode();
        }
        if (getCodigoPlanTarifario() != null) {
            _hashCode += getCodigoPlanTarifario().hashCode();
        }
        if (getCodigoTipIdent2() != null) {
            _hashCode += getCodigoTipIdent2().hashCode();
        }
        if (getCodigoTipoIdent() != null) {
            _hashCode += getCodigoTipoIdent().hashCode();
        }
        if (getCodigoUso() != null) {
            _hashCode += getCodigoUso().hashCode();
        }
        if (getFechaNacimiento() != null) {
            _hashCode += getFechaNacimiento().hashCode();
        }
        if (getIndicadorEstadoCivil() != null) {
            _hashCode += getIndicadorEstadoCivil().hashCode();
        }
        if (getIndicadorSexo() != null) {
            _hashCode += getIndicadorSexo().hashCode();
        }
        if (getNombreApeclien1() != null) {
            _hashCode += getNombreApeclien1().hashCode();
        }
        if (getNombreApeclien2() != null) {
            _hashCode += getNombreApeclien2().hashCode();
        }
        if (getNombreCliente() != null) {
            _hashCode += getNombreCliente().hashCode();
        }
        if (getNombreEmail() != null) {
            _hashCode += getNombreEmail().hashCode();
        }
        if (getNumIdent2() != null) {
            _hashCode += getNumIdent2().hashCode();
        }
        if (getNumeroFax() != null) {
            _hashCode += getNumeroFax().hashCode();
        }
        if (getNumeroIdent() != null) {
            _hashCode += getNumeroIdent().hashCode();
        }
        if (getNumeroIntGrupoFam() != null) {
            _hashCode += getNumeroIntGrupoFam().hashCode();
        }
        if (getPagoAtumaticoManual() != null) {
            _hashCode += getPagoAtumaticoManual().hashCode();
        }
        if (getResponsable() != null) {
            _hashCode += getResponsable().hashCode();
        }
        if (getTelefonoContac1() != null) {
            _hashCode += getTelefonoContac1().hashCode();
        }
        if (getTelefonoContac2() != null) {
            _hashCode += getTelefonoContac2().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsClienteInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsClienteInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("apoderado");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "Apoderado"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsApoderadoInDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("banco");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "Banco"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsBancoInDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codCrediticia");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodCrediticia"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codDireccionCorrespondencia");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodDireccionCorrespondencia"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codDireccionFacturacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodDireccionFacturacion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codDireccionPersonal");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodDireccionPersonal"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codSistemaPago");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodSistemaPago"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCategImpos");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoCategImpos"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCategoria");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoCategoria"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCiclo");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoCiclo"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoOficina");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoOficina"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoPais");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoPais"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoPlanTarifario");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoPlanTarifario"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoTipIdent2");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoTipIdent2"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoTipoIdent");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoTipoIdent"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoUso");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoUso"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("fechaNacimiento");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "FechaNacimiento"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicadorEstadoCivil");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "IndicadorEstadoCivil"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicadorSexo");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "IndicadorSexo"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nombreApeclien1");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NombreApeclien1"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nombreApeclien2");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NombreApeclien2"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nombreCliente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NombreCliente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nombreEmail");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NombreEmail"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numIdent2");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NumIdent2"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroFax");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NumeroFax"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroIdent");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NumeroIdent"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroIntGrupoFam");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NumeroIntGrupoFam"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("pagoAtumaticoManual");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "PagoAtumaticoManual"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("responsable");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "Responsable"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsResponsableInDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("telefonoContac1");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "TelefonoContac1"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("telefonoContac2");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "TelefonoContac2"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
