package com.tmmas.scl.gestionlc.common.dto;

import java.io.Serializable;
import java.sql.Timestamp;

public class AbonadoDTO implements Serializable {
    /**
     *
     */
    private static final long serialVersionUID = 1L;

    private String strNomTablaAbonado;
    private Long lonNumAbonado;
    private Long lonNumCelular;
    private Short shoCodProducto;
    private Long lonCodCliente;
    private Long lonCodCuenta;
    private String strCodSubCuenta;
    private Long lonCodUsuario;
    private String strCodRegion;
    private String strCodProvincia;
    private String strCodCiudad;
    private String strCodCelda;
    private Short shoCodCentral;
    private Short shoCodUso;
    private String strCodSituacion;
    private String strIndProcAlta;
    private String strIndProcEqui;
    private Integer intCodVendedor;
    private Integer intCodVendedorAgente;
    private String strTipPlanTarif;
    private String strTipTerminal;
    private String strCodPlanTarif;
    private String strCodCargoBasico;
    private String strCodPlanServ;
    private String strCodLimConsumo;
    private String strNumSerie;
    private String strNumSerieHex;
    private String strNomUsuarora;
    private Timestamp timFecAlta;
    private Short shoNumPercontrato;
    private String strCodEstado;
    private String strNumSerieMec;
    private Long lonCodHolding;
    private Long lonCodEmpresa;
    private String strCodGrpServ;
    private Short shoIndSuperTel;
    private String strNumTeleFija;
    private Integer intCodOpredFija;
    private Integer intCodCarrier;
    private Short shoIndPrepago;
    private Short shoIndPlexSys;
    private Short shoCodCentralPlex;
    private Long lonNumCelularPlex;
    private Long lonNumVenta;
    private Short shoCodModVenta;
    private String strCodTipContrato;
    private String strNumContrato;
    private String strNumAnexo;
    private Timestamp timFecCumPlan;
    private Short shoCodCredMor;
    private Short shoCodCredCon;
    private Short shoCodCiclo;
    private Short shoIndFactur;
    private Short shoIndSuspen;
    private Short shoIndRehabi;
    private Short shoIndInsGuias;
    private Timestamp timFecFinContra;
    private Timestamp timFecRecDocum;
    private Timestamp timFecCumplimen;
    private Timestamp timFecAcepVenta;
    private Timestamp timFecActCen;
    private Timestamp timFecBaja;
    private Timestamp timFecBajaCen;
    private Timestamp timFecUltMod;
    private String strCodCausaBaja;
    private String strNumPersonal;
    private Short shoIndSeguro;
    private String strClaseServicio;
    private String strPerfilAbonado;
    private String strNumMin;
    private Integer intCodVendealer;
    private Short shoIndDisp;
    private String strCodPassword;
    private String strIndPassword;
    private Short shoCodAfinidad;
    private Timestamp timFecProrroga;
    private String strIndEqPrestado;
    private String strFlgContDigi;
    private Timestamp timFecAltantras;
    private Short shoCodIndemnizacion;
    private String strNumImei;
    private String strCodTecnologia;
    private String strNumMinMdn;
    private Timestamp timFecActivacion;
    private Short shoIndTelefono;
    private String strCodOficinaPrincipal;
    private String strCodCausaVenta;
    private String strCodOperador;
    private Integer intCodClienteDist;
    private Integer intSolPendienteCiclo;

    /**
     * @return the strNomTablaAbonado
     */
    public String getStrNomTablaAbonado() {
        return strNomTablaAbonado;
    }

    /**
     * @param strNomTablaAbonado
     *            the strNomTablaAbonado to set
     */
    public void setStrNomTablaAbonado(String strNomTablaAbonado) {
        this.strNomTablaAbonado = strNomTablaAbonado;
    }

    /**
     * @return the lonNumAbonado
     */
    public Long getLonNumAbonado() {
        return lonNumAbonado;
    }

    /**
     * @param lonNumAbonado
     *            the lonNumAbonado to set
     */
    public void setLonNumAbonado(Long lonNumAbonado) {
        this.lonNumAbonado = lonNumAbonado;
    }

    /**
     * @return the lonNumCelular
     */
    public Long getLonNumCelular() {
        return lonNumCelular;
    }

    /**
     * @param lonNumCelular
     *            the lonNumCelular to set
     */
    public void setLonNumCelular(Long lonNumCelular) {
        this.lonNumCelular = lonNumCelular;
    }

    /**
     * @return the shoCodProducto
     */
    public Short getShoCodProducto() {
        return shoCodProducto;
    }

    /**
     * @param shoCodProducto
     *            the shoCodProducto to set
     */
    public void setShoCodProducto(Short shoCodProducto) {
        this.shoCodProducto = shoCodProducto;
    }

    /**
     * @return the lonCodCliente
     */
    public Long getLonCodCliente() {
        return lonCodCliente;
    }

    /**
     * @param lonCodCliente
     *            the lonCodCliente to set
     */
    public void setLonCodCliente(Long lonCodCliente) {
        this.lonCodCliente = lonCodCliente;
    }

    /**
     * @return the lonCodCuenta
     */
    public Long getLonCodCuenta() {
        return lonCodCuenta;
    }

    /**
     * @param lonCodCuenta
     *            the lonCodCuenta to set
     */
    public void setLonCodCuenta(Long lonCodCuenta) {
        this.lonCodCuenta = lonCodCuenta;
    }

    /**
     * @return the strCodSubCuenta
     */
    public String getStrCodSubCuenta() {
        return strCodSubCuenta;
    }

    /**
     * @param strCodSubCuenta
     *            the strCodSubCuenta to set
     */
    public void setStrCodSubCuenta(String strCodSubCuenta) {
        this.strCodSubCuenta = strCodSubCuenta;
    }

    /**
     * @return the lonCodUsuario
     */
    public Long getLonCodUsuario() {
        return lonCodUsuario;
    }

    /**
     * @param lonCodUsuario
     *            the lonCodUsuario to set
     */
    public void setLonCodUsuario(Long lonCodUsuario) {
        this.lonCodUsuario = lonCodUsuario;
    }

    /**
     * @return the strCodRegion
     */
    public String getStrCodRegion() {
        return strCodRegion;
    }

    /**
     * @param strCodRegion
     *            the strCodRegion to set
     */
    public void setStrCodRegion(String strCodRegion) {
        this.strCodRegion = strCodRegion;
    }

    /**
     * @return the strCodProvincia
     */
    public String getStrCodProvincia() {
        return strCodProvincia;
    }

    /**
     * @param strCodProvincia
     *            the strCodProvincia to set
     */
    public void setStrCodProvincia(String strCodProvincia) {
        this.strCodProvincia = strCodProvincia;
    }

    /**
     * @return the strCodCiudad
     */
    public String getStrCodCiudad() {
        return strCodCiudad;
    }

    /**
     * @param strCodCiudad
     *            the strCodCiudad to set
     */
    public void setStrCodCiudad(String strCodCiudad) {
        this.strCodCiudad = strCodCiudad;
    }

    /**
     * @return the strCodCelda
     */
    public String getStrCodCelda() {
        return strCodCelda;
    }

    /**
     * @param strCodCelda
     *            the strCodCelda to set
     */
    public void setStrCodCelda(String strCodCelda) {
        this.strCodCelda = strCodCelda;
    }

    /**
     * @return the shoCodCentral
     */
    public Short getShoCodCentral() {
        return shoCodCentral;
    }

    /**
     * @param shoCodCentral
     *            the shoCodCentral to set
     */
    public void setShoCodCentral(Short shoCodCentral) {
        this.shoCodCentral = shoCodCentral;
    }

    /**
     * @return the shoCodUso
     */
    public Short getShoCodUso() {
        return shoCodUso;
    }

    /**
     * @param shoCodUso
     *            the shoCodUso to set
     */
    public void setShoCodUso(Short shoCodUso) {
        this.shoCodUso = shoCodUso;
    }

    /**
     * @return the strCodSituacion
     */
    public String getStrCodSituacion() {
        return strCodSituacion;
    }

    /**
     * @param strCodSituacion
     *            the strCodSituacion to set
     */
    public void setStrCodSituacion(String strCodSituacion) {
        this.strCodSituacion = strCodSituacion;
    }

    /**
     * @return the strIndProcAlta
     */
    public String getStrIndProcAlta() {
        return strIndProcAlta;
    }

    /**
     * @param strIndProcAlta
     *            the strIndProcAlta to set
     */
    public void setStrIndProcAlta(String strIndProcAlta) {
        this.strIndProcAlta = strIndProcAlta;
    }

    /**
     * @return the strIndProcEqui
     */
    public String getStrIndProcEqui() {
        return strIndProcEqui;
    }

    /**
     * @param strIndProcEqui
     *            the strIndProcEqui to set
     */
    public void setStrIndProcEqui(String strIndProcEqui) {
        this.strIndProcEqui = strIndProcEqui;
    }

    /**
     * @return the intCodVendedor
     */
    public Integer getIntCodVendedor() {
        return intCodVendedor;
    }

    /**
     * @param intCodVendedor
     *            the intCodVendedor to set
     */
    public void setIntCodVendedor(Integer intCodVendedor) {
        this.intCodVendedor = intCodVendedor;
    }

    /**
     * @return the intCodVendedorAgente
     */
    public Integer getIntCodVendedorAgente() {
        return intCodVendedorAgente;
    }

    /**
     * @param intCodVendedorAgente
     *            the intCodVendedorAgente to set
     */
    public void setIntCodVendedorAgente(Integer intCodVendedorAgente) {
        this.intCodVendedorAgente = intCodVendedorAgente;
    }

    /**
     * @return the strTipPlanTarif
     */
    public String getStrTipPlanTarif() {
        return strTipPlanTarif;
    }

    /**
     * @param strTipPlanTarif
     *            the strTipPlanTarif to set
     */
    public void setStrTipPlanTarif(String strTipPlanTarif) {
        this.strTipPlanTarif = strTipPlanTarif;
    }

    /**
     * @return the strTipTerminal
     */
    public String getStrTipTerminal() {
        return strTipTerminal;
    }

    /**
     * @param strTipTerminal
     *            the strTipTerminal to set
     */
    public void setStrTipTerminal(String strTipTerminal) {
        this.strTipTerminal = strTipTerminal;
    }

    /**
     * @return the strCodPlanTarif
     */
    public String getStrCodPlanTarif() {
        return strCodPlanTarif;
    }

    /**
     * @param strCodPlanTarif
     *            the strCodPlanTarif to set
     */
    public void setStrCodPlanTarif(String strCodPlanTarif) {
        this.strCodPlanTarif = strCodPlanTarif;
    }

    /**
     * @return the strCodCargoBasico
     */
    public String getStrCodCargoBasico() {
        return strCodCargoBasico;
    }

    /**
     * @param strCodCargoBasico
     *            the strCodCargoBasico to set
     */
    public void setStrCodCargoBasico(String strCodCargoBasico) {
        this.strCodCargoBasico = strCodCargoBasico;
    }

    /**
     * @return the strCodPlanServ
     */
    public String getStrCodPlanServ() {
        return strCodPlanServ;
    }

    /**
     * @param strCodPlanServ
     *            the strCodPlanServ to set
     */
    public void setStrCodPlanServ(String strCodPlanServ) {
        this.strCodPlanServ = strCodPlanServ;
    }

    /**
     * @return the strCodLimConsumo
     */
    public String getStrCodLimConsumo() {
        return strCodLimConsumo;
    }

    /**
     * @param strCodLimConsumo
     *            the strCodLimConsumo to set
     */
    public void setStrCodLimConsumo(String strCodLimConsumo) {
        this.strCodLimConsumo = strCodLimConsumo;
    }

    /**
     * @return the strNumSerie
     */
    public String getStrNumSerie() {
        return strNumSerie;
    }

    /**
     * @param strNumSerie
     *            the strNumSerie to set
     */
    public void setStrNumSerie(String strNumSerie) {
        this.strNumSerie = strNumSerie;
    }

    /**
     * @return the strNumSerieHex
     */
    public String getStrNumSerieHex() {
        return strNumSerieHex;
    }

    /**
     * @param strNumSerieHex
     *            the strNumSerieHex to set
     */
    public void setStrNumSerieHex(String strNumSerieHex) {
        this.strNumSerieHex = strNumSerieHex;
    }

    /**
     * @return the strNomUsuarora
     */
    public String getStrNomUsuarora() {
        return strNomUsuarora;
    }

    /**
     * @param strNomUsuarora
     *            the strNomUsuarora to set
     */
    public void setStrNomUsuarora(String strNomUsuarora) {
        this.strNomUsuarora = strNomUsuarora;
    }

    /**
     * @return the timFecAlta
     */
    public Timestamp getTimFecAlta() {
        return timFecAlta;
    }

    /**
     * @param timFecAlta
     *            the timFecAlta to set
     */
    public void setTimFecAlta(Timestamp timFecAlta) {
        this.timFecAlta = timFecAlta;
    }

    /**
     * @return the shoNumPercontrato
     */
    public Short getShoNumPercontrato() {
        return shoNumPercontrato;
    }

    /**
     * @param shoNumPercontrato
     *            the shoNumPercontrato to set
     */
    public void setShoNumPercontrato(Short shoNumPercontrato) {
        this.shoNumPercontrato = shoNumPercontrato;
    }

    /**
     * @return the strCodEstado
     */
    public String getStrCodEstado() {
        return strCodEstado;
    }

    /**
     * @param strCodEstado
     *            the strCodEstado to set
     */
    public void setStrCodEstado(String strCodEstado) {
        this.strCodEstado = strCodEstado;
    }

    /**
     * @return the strNumSerieMec
     */
    public String getStrNumSerieMec() {
        return strNumSerieMec;
    }

    /**
     * @param strNumSerieMec
     *            the strNumSerieMec to set
     */
    public void setStrNumSerieMec(String strNumSerieMec) {
        this.strNumSerieMec = strNumSerieMec;
    }

    /**
     * @return the lonCodHolding
     */
    public Long getLonCodHolding() {
        return lonCodHolding;
    }

    /**
     * @param lonCodHolding
     *            the lonCodHolding to set
     */
    public void setLonCodHolding(Long lonCodHolding) {
        this.lonCodHolding = lonCodHolding;
    }

    /**
     * @return the lonCodEmpresa
     */
    public Long getLonCodEmpresa() {
        return lonCodEmpresa;
    }

    /**
     * @param lonCodEmpresa
     *            the lonCodEmpresa to set
     */
    public void setLonCodEmpresa(Long lonCodEmpresa) {
        this.lonCodEmpresa = lonCodEmpresa;
    }

    /**
     * @return the strCodGrpServ
     */
    public String getStrCodGrpServ() {
        return strCodGrpServ;
    }

    /**
     * @param strCodGrpServ
     *            the strCodGrpServ to set
     */
    public void setStrCodGrpServ(String strCodGrpServ) {
        this.strCodGrpServ = strCodGrpServ;
    }

    /**
     * @return the shoIndSuperTel
     */
    public Short getShoIndSuperTel() {
        return shoIndSuperTel;
    }

    /**
     * @param shoIndSuperTel
     *            the shoIndSuperTel to set
     */
    public void setShoIndSuperTel(Short shoIndSuperTel) {
        this.shoIndSuperTel = shoIndSuperTel;
    }

    /**
     * @return the strNumTeleFija
     */
    public String getStrNumTeleFija() {
        return strNumTeleFija;
    }

    /**
     * @param strNumTeleFija
     *            the strNumTeleFija to set
     */
    public void setStrNumTeleFija(String strNumTeleFija) {
        this.strNumTeleFija = strNumTeleFija;
    }

    /**
     * @return the intCodOpredFija
     */
    public Integer getIntCodOpredFija() {
        return intCodOpredFija;
    }

    /**
     * @param intCodOpredFija
     *            the intCodOpredFija to set
     */
    public void setIntCodOpredFija(Integer intCodOpredFija) {
        this.intCodOpredFija = intCodOpredFija;
    }

    /**
     * @return the intCodCarrier
     */
    public Integer getIntCodCarrier() {
        return intCodCarrier;
    }

    /**
     * @param intCodCarrier
     *            the intCodCarrier to set
     */
    public void setIntCodCarrier(Integer intCodCarrier) {
        this.intCodCarrier = intCodCarrier;
    }

    /**
     * @return the shoIndPrepago
     */
    public Short getShoIndPrepago() {
        return shoIndPrepago;
    }

    /**
     * @param shoIndPrepago
     *            the shoIndPrepago to set
     */
    public void setShoIndPrepago(Short shoIndPrepago) {
        this.shoIndPrepago = shoIndPrepago;
    }

    /**
     * @return the shoIndPlexSys
     */
    public Short getShoIndPlexSys() {
        return shoIndPlexSys;
    }

    /**
     * @param shoIndPlexSys
     *            the shoIndPlexSys to set
     */
    public void setShoIndPlexSys(Short shoIndPlexSys) {
        this.shoIndPlexSys = shoIndPlexSys;
    }

    /**
     * @return the shoCodCentralPlex
     */
    public Short getShoCodCentralPlex() {
        return shoCodCentralPlex;
    }

    /**
     * @param shoCodCentralPlex
     *            the shoCodCentralPlex to set
     */
    public void setShoCodCentralPlex(Short shoCodCentralPlex) {
        this.shoCodCentralPlex = shoCodCentralPlex;
    }

    /**
     * @return the lonNumCelularPlex
     */
    public Long getLonNumCelularPlex() {
        return lonNumCelularPlex;
    }

    /**
     * @param lonNumCelularPlex
     *            the lonNumCelularPlex to set
     */
    public void setLonNumCelularPlex(Long lonNumCelularPlex) {
        this.lonNumCelularPlex = lonNumCelularPlex;
    }

    /**
     * @return the lonNumVenta
     */
    public Long getLonNumVenta() {
        return lonNumVenta;
    }

    /**
     * @param lonNumVenta
     *            the lonNumVenta to set
     */
    public void setLonNumVenta(Long lonNumVenta) {
        this.lonNumVenta = lonNumVenta;
    }

    /**
     * @return the shoCodModVenta
     */
    public Short getShoCodModVenta() {
        return shoCodModVenta;
    }

    /**
     * @param shoCodModVenta
     *            the shoCodModVenta to set
     */
    public void setShoCodModVenta(Short shoCodModVenta) {
        this.shoCodModVenta = shoCodModVenta;
    }

    /**
     * @return the strCodTipContrato
     */
    public String getStrCodTipContrato() {
        return strCodTipContrato;
    }

    /**
     * @param strCodTipContrato
     *            the strCodTipContrato to set
     */
    public void setStrCodTipContrato(String strCodTipContrato) {
        this.strCodTipContrato = strCodTipContrato;
    }

    /**
     * @return the strNumContrato
     */
    public String getStrNumContrato() {
        return strNumContrato;
    }

    /**
     * @param strNumContrato
     *            the strNumContrato to set
     */
    public void setStrNumContrato(String strNumContrato) {
        this.strNumContrato = strNumContrato;
    }

    /**
     * @return the strNumAnexo
     */
    public String getStrNumAnexo() {
        return strNumAnexo;
    }

    /**
     * @param strNumAnexo
     *            the strNumAnexo to set
     */
    public void setStrNumAnexo(String strNumAnexo) {
        this.strNumAnexo = strNumAnexo;
    }

    /**
     * @return the timFecCumPlan
     */
    public Timestamp getTimFecCumPlan() {
        return timFecCumPlan;
    }

    /**
     * @param timFecCumPlan
     *            the timFecCumPlan to set
     */
    public void setTimFecCumPlan(Timestamp timFecCumPlan) {
        this.timFecCumPlan = timFecCumPlan;
    }

    /**
     * @return the shoCodCredMor
     */
    public Short getShoCodCredMor() {
        return shoCodCredMor;
    }

    /**
     * @param shoCodCredMor
     *            the shoCodCredMor to set
     */
    public void setShoCodCredMor(Short shoCodCredMor) {
        this.shoCodCredMor = shoCodCredMor;
    }

    /**
     * @return the shoCodCredCon
     */
    public Short getShoCodCredCon() {
        return shoCodCredCon;
    }

    /**
     * @param shoCodCredCon
     *            the shoCodCredCon to set
     */
    public void setShoCodCredCon(Short shoCodCredCon) {
        this.shoCodCredCon = shoCodCredCon;
    }

    /**
     * @return the shoCodCiclo
     */
    public Short getShoCodCiclo() {
        return shoCodCiclo;
    }

    /**
     * @param shoCodCiclo
     *            the shoCodCiclo to set
     */
    public void setShoCodCiclo(Short shoCodCiclo) {
        this.shoCodCiclo = shoCodCiclo;
    }

    /**
     * @return the shoIndFactur
     */
    public Short getShoIndFactur() {
        return shoIndFactur;
    }

    /**
     * @param shoIndFactur
     *            the shoIndFactur to set
     */
    public void setShoIndFactur(Short shoIndFactur) {
        this.shoIndFactur = shoIndFactur;
    }

    /**
     * @return the shoIndSuspen
     */
    public Short getShoIndSuspen() {
        return shoIndSuspen;
    }

    /**
     * @param shoIndSuspen
     *            the shoIndSuspen to set
     */
    public void setShoIndSuspen(Short shoIndSuspen) {
        this.shoIndSuspen = shoIndSuspen;
    }

    /**
     * @return the shoIndRehabi
     */
    public Short getShoIndRehabi() {
        return shoIndRehabi;
    }

    /**
     * @param shoIndRehabi
     *            the shoIndRehabi to set
     */
    public void setShoIndRehabi(Short shoIndRehabi) {
        this.shoIndRehabi = shoIndRehabi;
    }

    /**
     * @return the shoIndInsGuias
     */
    public Short getShoIndInsGuias() {
        return shoIndInsGuias;
    }

    /**
     * @param shoIndInsGuias
     *            the shoIndInsGuias to set
     */
    public void setShoIndInsGuias(Short shoIndInsGuias) {
        this.shoIndInsGuias = shoIndInsGuias;
    }

    /**
     * @return the timFecFinContra
     */
    public Timestamp getTimFecFinContra() {
        return timFecFinContra;
    }

    /**
     * @param timFecFinContra
     *            the timFecFinContra to set
     */
    public void setTimFecFinContra(Timestamp timFecFinContra) {
        this.timFecFinContra = timFecFinContra;
    }

    /**
     * @return the timFecRecDocum
     */
    public Timestamp getTimFecRecDocum() {
        return timFecRecDocum;
    }

    /**
     * @param timFecRecDocum
     *            the timFecRecDocum to set
     */
    public void setTimFecRecDocum(Timestamp timFecRecDocum) {
        this.timFecRecDocum = timFecRecDocum;
    }

    /**
     * @return the timFecCumplimen
     */
    public Timestamp getTimFecCumplimen() {
        return timFecCumplimen;
    }

    /**
     * @param timFecCumplimen
     *            the timFecCumplimen to set
     */
    public void setTimFecCumplimen(Timestamp timFecCumplimen) {
        this.timFecCumplimen = timFecCumplimen;
    }

    /**
     * @return the timFecAcepVenta
     */
    public Timestamp getTimFecAcepVenta() {
        return timFecAcepVenta;
    }

    /**
     * @param timFecAcepVenta
     *            the timFecAcepVenta to set
     */
    public void setTimFecAcepVenta(Timestamp timFecAcepVenta) {
        this.timFecAcepVenta = timFecAcepVenta;
    }

    /**
     * @return the timFecActCen
     */
    public Timestamp getTimFecActCen() {
        return timFecActCen;
    }

    /**
     * @param timFecActCen
     *            the timFecActCen to set
     */
    public void setTimFecActCen(Timestamp timFecActCen) {
        this.timFecActCen = timFecActCen;
    }

    /**
     * @return the timFecBaja
     */
    public Timestamp getTimFecBaja() {
        return timFecBaja;
    }

    /**
     * @param timFecBaja
     *            the timFecBaja to set
     */
    public void setTimFecBaja(Timestamp timFecBaja) {
        this.timFecBaja = timFecBaja;
    }

    /**
     * @return the timFecBajaCen
     */
    public Timestamp getTimFecBajaCen() {
        return timFecBajaCen;
    }

    /**
     * @param timFecBajaCen
     *            the timFecBajaCen to set
     */
    public void setTimFecBajaCen(Timestamp timFecBajaCen) {
        this.timFecBajaCen = timFecBajaCen;
    }

    /**
     * @return the timFecUltMod
     */
    public Timestamp getTimFecUltMod() {
        return timFecUltMod;
    }

    /**
     * @param timFecUltMod
     *            the timFecUltMod to set
     */
    public void setTimFecUltMod(Timestamp timFecUltMod) {
        this.timFecUltMod = timFecUltMod;
    }

    /**
     * @return the strCodCausaBaja
     */
    public String getStrCodCausaBaja() {
        return strCodCausaBaja;
    }

    /**
     * @param strCodCausaBaja
     *            the strCodCausaBaja to set
     */
    public void setStrCodCausaBaja(String strCodCausaBaja) {
        this.strCodCausaBaja = strCodCausaBaja;
    }

    /**
     * @return the strNumPersonal
     */
    public String getStrNumPersonal() {
        return strNumPersonal;
    }

    /**
     * @param strNumPersonal
     *            the strNumPersonal to set
     */
    public void setStrNumPersonal(String strNumPersonal) {
        this.strNumPersonal = strNumPersonal;
    }

    /**
     * @return the shoIndSeguro
     */
    public Short getShoIndSeguro() {
        return shoIndSeguro;
    }

    /**
     * @param shoIndSeguro
     *            the shoIndSeguro to set
     */
    public void setShoIndSeguro(Short shoIndSeguro) {
        this.shoIndSeguro = shoIndSeguro;
    }

    /**
     * @return the strClaseServicio
     */
    public String getStrClaseServicio() {
        return strClaseServicio;
    }

    /**
     * @param strClaseServicio
     *            the strClaseServicio to set
     */
    public void setStrClaseServicio(String strClaseServicio) {
        this.strClaseServicio = strClaseServicio;
    }

    /**
     * @return the strPerfilAbonado
     */
    public String getStrPerfilAbonado() {
        return strPerfilAbonado;
    }

    /**
     * @param strPerfilAbonado
     *            the strPerfilAbonado to set
     */
    public void setStrPerfilAbonado(String strPerfilAbonado) {
        this.strPerfilAbonado = strPerfilAbonado;
    }

    /**
     * @return the strNumMin
     */
    public String getStrNumMin() {
        return strNumMin;
    }

    /**
     * @param strNumMin
     *            the strNumMin to set
     */
    public void setStrNumMin(String strNumMin) {
        this.strNumMin = strNumMin;
    }

    /**
     * @return the intCodVendealer
     */
    public Integer getIntCodVendealer() {
        return intCodVendealer;
    }

    /**
     * @param intCodVendealer
     *            the intCodVendealer to set
     */
    public void setIntCodVendealer(Integer intCodVendealer) {
        this.intCodVendealer = intCodVendealer;
    }

    /**
     * @return the shoIndDisp
     */
    public Short getShoIndDisp() {
        return shoIndDisp;
    }

    /**
     * @param shoIndDisp
     *            the shoIndDisp to set
     */
    public void setShoIndDisp(Short shoIndDisp) {
        this.shoIndDisp = shoIndDisp;
    }

    /**
     * @return the strCodPassword
     */
    public String getStrCodPassword() {
        return strCodPassword;
    }

    /**
     * @param strCodPassword
     *            the strCodPassword to set
     */
    public void setStrCodPassword(String strCodPassword) {
        this.strCodPassword = strCodPassword;
    }

    /**
     * @return the strIndPassword
     */
    public String getStrIndPassword() {
        return strIndPassword;
    }

    /**
     * @param strIndPassword
     *            the strIndPassword to set
     */
    public void setStrIndPassword(String strIndPassword) {
        this.strIndPassword = strIndPassword;
    }

    /**
     * @return the shoCodAfinidad
     */
    public Short getShoCodAfinidad() {
        return shoCodAfinidad;
    }

    /**
     * @param shoCodAfinidad
     *            the shoCodAfinidad to set
     */
    public void setShoCodAfinidad(Short shoCodAfinidad) {
        this.shoCodAfinidad = shoCodAfinidad;
    }

    /**
     * @return the timFecProrroga
     */
    public Timestamp getTimFecProrroga() {
        return timFecProrroga;
    }

    /**
     * @param timFecProrroga
     *            the timFecProrroga to set
     */
    public void setTimFecProrroga(Timestamp timFecProrroga) {
        this.timFecProrroga = timFecProrroga;
    }

    /**
     * @return the strIndEqPrestado
     */
    public String getStrIndEqPrestado() {
        return strIndEqPrestado;
    }

    /**
     * @param strIndEqPrestado
     *            the strIndEqPrestado to set
     */
    public void setStrIndEqPrestado(String strIndEqPrestado) {
        this.strIndEqPrestado = strIndEqPrestado;
    }

    /**
     * @return the strFlgContDigi
     */
    public String getStrFlgContDigi() {
        return strFlgContDigi;
    }

    /**
     * @param strFlgContDigi
     *            the strFlgContDigi to set
     */
    public void setStrFlgContDigi(String strFlgContDigi) {
        this.strFlgContDigi = strFlgContDigi;
    }

    /**
     * @return the timFecAltantras
     */
    public Timestamp getTimFecAltantras() {
        return timFecAltantras;
    }

    /**
     * @param timFecAltantras
     *            the timFecAltantras to set
     */
    public void setTimFecAltantras(Timestamp timFecAltantras) {
        this.timFecAltantras = timFecAltantras;
    }

    /**
     * @return the shoCodIndemnizacion
     */
    public Short getShoCodIndemnizacion() {
        return shoCodIndemnizacion;
    }

    /**
     * @param shoCodIndemnizacion
     *            the shoCodIndemnizacion to set
     */
    public void setShoCodIndemnizacion(Short shoCodIndemnizacion) {
        this.shoCodIndemnizacion = shoCodIndemnizacion;
    }

    /**
     * @return the strNumImei
     */
    public String getStrNumImei() {
        return strNumImei;
    }

    /**
     * @param strNumImei
     *            the strNumImei to set
     */
    public void setStrNumImei(String strNumImei) {
        this.strNumImei = strNumImei;
    }

    /**
     * @return the strCodTecnologia
     */
    public String getStrCodTecnologia() {
        return strCodTecnologia;
    }

    /**
     * @param strCodTecnologia
     *            the strCodTecnologia to set
     */
    public void setStrCodTecnologia(String strCodTecnologia) {
        this.strCodTecnologia = strCodTecnologia;
    }

    /**
     * @return the strNumMinMdn
     */
    public String getStrNumMinMdn() {
        return strNumMinMdn;
    }

    /**
     * @param strNumMinMdn
     *            the strNumMinMdn to set
     */
    public void setStrNumMinMdn(String strNumMinMdn) {
        this.strNumMinMdn = strNumMinMdn;
    }

    /**
     * @return the timFecActivacion
     */
    public Timestamp getTimFecActivacion() {
        return timFecActivacion;
    }

    /**
     * @param timFecActivacion
     *            the timFecActivacion to set
     */
    public void setTimFecActivacion(Timestamp timFecActivacion) {
        this.timFecActivacion = timFecActivacion;
    }

    /**
     * @return the shoIndTelefono
     */
    public Short getShoIndTelefono() {
        return shoIndTelefono;
    }

    /**
     * @param shoIndTelefono
     *            the shoIndTelefono to set
     */
    public void setShoIndTelefono(Short shoIndTelefono) {
        this.shoIndTelefono = shoIndTelefono;
    }

    /**
     * @return the strCodOficinaPrincipal
     */
    public String getStrCodOficinaPrincipal() {
        return strCodOficinaPrincipal;
    }

    /**
     * @param strCodOficinaPrincipal
     *            the strCodOficinaPrincipal to set
     */
    public void setStrCodOficinaPrincipal(String strCodOficinaPrincipal) {
        this.strCodOficinaPrincipal = strCodOficinaPrincipal;
    }

    /**
     * @return the strCodCausaVenta
     */
    public String getStrCodCausaVenta() {
        return strCodCausaVenta;
    }

    /**
     * @param strCodCausaVenta
     *            the strCodCausaVenta to set
     */
    public void setStrCodCausaVenta(String strCodCausaVenta) {
        this.strCodCausaVenta = strCodCausaVenta;
    }

    /**
     * @return the strCodOperador
     */
    public String getStrCodOperador() {
        return strCodOperador;
    }

    /**
     * @param strCodOperador
     *            the strCodOperador to set
     */
    public void setStrCodOperador(String strCodOperador) {
        this.strCodOperador = strCodOperador;
    }

    /**
     * @return the intCodClienteDist
     */
    public Integer getIntCodClienteDist() {
        return intCodClienteDist;
    }

    /**
     * @param intCodClienteDist
     *            the intCodClienteDist to set
     */
    public void setIntCodClienteDist(Integer intCodClienteDist) {
        this.intCodClienteDist = intCodClienteDist;
    }

    /**
     * @return the intSolPendienteCiclo
     */
    public Integer getIntSolPendienteCiclo() {
        return intSolPendienteCiclo;
    }

    /**
     * @param intSolPendienteCiclo
     *            the intSolPendienteCiclo to set
     */
    public void setIntSolPendienteCiclo(Integer intSolPendienteCiclo) {
        this.intSolPendienteCiclo = intSolPendienteCiclo;
    }

}
