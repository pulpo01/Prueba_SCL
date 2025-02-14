/**
 * AtributosMigracionDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dataTransferObject.customerDomain.framework.scl.tmmas.com;

public class AtributosMigracionDTO  extends dataTransferObject.customerDomain.framework.scl.tmmas.com.AtributosCargoDTO  implements java.io.Serializable {
    private java.lang.String codTipPlantarifDes;

    private java.lang.String codTipPlantarifOrig;

    private java.lang.String cod_tecnologia;

    private java.lang.String ind_cuota;

    private java.lang.String ind_equipo;

    private java.lang.String ind_paquete;

    private java.lang.String nombreUsuario;

    private java.lang.String numeroCelular;

    public AtributosMigracionDTO() {
    }

    public AtributosMigracionDTO(
           int cicloFacturacion,
           int claseProducto,
           java.lang.String codTecnologia,
           java.lang.String codigoArticuloServicio,
           int cuotas,
           java.lang.String fechaAplicacion,
           java.lang.String numAbonado,
           java.lang.String numCelular,
           java.lang.String numContrato,
           java.lang.String numImei,
           java.lang.String numSerie,
           java.lang.String numTerminal,
           int tipoProducto,
           boolean ciclo,
           boolean obligatorio,
           boolean recurrente,
           java.lang.String codTipPlantarifDes,
           java.lang.String codTipPlantarifOrig,
           java.lang.String cod_tecnologia,
           java.lang.String ind_cuota,
           java.lang.String ind_equipo,
           java.lang.String ind_paquete,
           java.lang.String nombreUsuario,
           java.lang.String numeroCelular) {
        super(
            cicloFacturacion,
            claseProducto,
            codTecnologia,
            codigoArticuloServicio,
            cuotas,
            fechaAplicacion,
            numAbonado,
            numCelular,
            numContrato,
            numImei,
            numSerie,
            numTerminal,
            tipoProducto,
            ciclo,
            obligatorio,
            recurrente);
        this.codTipPlantarifDes = codTipPlantarifDes;
        this.codTipPlantarifOrig = codTipPlantarifOrig;
        this.cod_tecnologia = cod_tecnologia;
        this.ind_cuota = ind_cuota;
        this.ind_equipo = ind_equipo;
        this.ind_paquete = ind_paquete;
        this.nombreUsuario = nombreUsuario;
        this.numeroCelular = numeroCelular;
    }


    /**
     * Gets the codTipPlantarifDes value for this AtributosMigracionDTO.
     * 
     * @return codTipPlantarifDes
     */
    public java.lang.String getCodTipPlantarifDes() {
        return codTipPlantarifDes;
    }


    /**
     * Sets the codTipPlantarifDes value for this AtributosMigracionDTO.
     * 
     * @param codTipPlantarifDes
     */
    public void setCodTipPlantarifDes(java.lang.String codTipPlantarifDes) {
        this.codTipPlantarifDes = codTipPlantarifDes;
    }


    /**
     * Gets the codTipPlantarifOrig value for this AtributosMigracionDTO.
     * 
     * @return codTipPlantarifOrig
     */
    public java.lang.String getCodTipPlantarifOrig() {
        return codTipPlantarifOrig;
    }


    /**
     * Sets the codTipPlantarifOrig value for this AtributosMigracionDTO.
     * 
     * @param codTipPlantarifOrig
     */
    public void setCodTipPlantarifOrig(java.lang.String codTipPlantarifOrig) {
        this.codTipPlantarifOrig = codTipPlantarifOrig;
    }


    /**
     * Gets the cod_tecnologia value for this AtributosMigracionDTO.
     * 
     * @return cod_tecnologia
     */
    public java.lang.String getCod_tecnologia() {
        return cod_tecnologia;
    }


    /**
     * Sets the cod_tecnologia value for this AtributosMigracionDTO.
     * 
     * @param cod_tecnologia
     */
    public void setCod_tecnologia(java.lang.String cod_tecnologia) {
        this.cod_tecnologia = cod_tecnologia;
    }


    /**
     * Gets the ind_cuota value for this AtributosMigracionDTO.
     * 
     * @return ind_cuota
     */
    public java.lang.String getInd_cuota() {
        return ind_cuota;
    }


    /**
     * Sets the ind_cuota value for this AtributosMigracionDTO.
     * 
     * @param ind_cuota
     */
    public void setInd_cuota(java.lang.String ind_cuota) {
        this.ind_cuota = ind_cuota;
    }


    /**
     * Gets the ind_equipo value for this AtributosMigracionDTO.
     * 
     * @return ind_equipo
     */
    public java.lang.String getInd_equipo() {
        return ind_equipo;
    }


    /**
     * Sets the ind_equipo value for this AtributosMigracionDTO.
     * 
     * @param ind_equipo
     */
    public void setInd_equipo(java.lang.String ind_equipo) {
        this.ind_equipo = ind_equipo;
    }


    /**
     * Gets the ind_paquete value for this AtributosMigracionDTO.
     * 
     * @return ind_paquete
     */
    public java.lang.String getInd_paquete() {
        return ind_paquete;
    }


    /**
     * Sets the ind_paquete value for this AtributosMigracionDTO.
     * 
     * @param ind_paquete
     */
    public void setInd_paquete(java.lang.String ind_paquete) {
        this.ind_paquete = ind_paquete;
    }


    /**
     * Gets the nombreUsuario value for this AtributosMigracionDTO.
     * 
     * @return nombreUsuario
     */
    public java.lang.String getNombreUsuario() {
        return nombreUsuario;
    }


    /**
     * Sets the nombreUsuario value for this AtributosMigracionDTO.
     * 
     * @param nombreUsuario
     */
    public void setNombreUsuario(java.lang.String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }


    /**
     * Gets the numeroCelular value for this AtributosMigracionDTO.
     * 
     * @return numeroCelular
     */
    public java.lang.String getNumeroCelular() {
        return numeroCelular;
    }


    /**
     * Sets the numeroCelular value for this AtributosMigracionDTO.
     * 
     * @param numeroCelular
     */
    public void setNumeroCelular(java.lang.String numeroCelular) {
        this.numeroCelular = numeroCelular;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof AtributosMigracionDTO)) return false;
        AtributosMigracionDTO other = (AtributosMigracionDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = super.equals(obj) && 
            ((this.codTipPlantarifDes==null && other.getCodTipPlantarifDes()==null) || 
             (this.codTipPlantarifDes!=null &&
              this.codTipPlantarifDes.equals(other.getCodTipPlantarifDes()))) &&
            ((this.codTipPlantarifOrig==null && other.getCodTipPlantarifOrig()==null) || 
             (this.codTipPlantarifOrig!=null &&
              this.codTipPlantarifOrig.equals(other.getCodTipPlantarifOrig()))) &&
            ((this.cod_tecnologia==null && other.getCod_tecnologia()==null) || 
             (this.cod_tecnologia!=null &&
              this.cod_tecnologia.equals(other.getCod_tecnologia()))) &&
            ((this.ind_cuota==null && other.getInd_cuota()==null) || 
             (this.ind_cuota!=null &&
              this.ind_cuota.equals(other.getInd_cuota()))) &&
            ((this.ind_equipo==null && other.getInd_equipo()==null) || 
             (this.ind_equipo!=null &&
              this.ind_equipo.equals(other.getInd_equipo()))) &&
            ((this.ind_paquete==null && other.getInd_paquete()==null) || 
             (this.ind_paquete!=null &&
              this.ind_paquete.equals(other.getInd_paquete()))) &&
            ((this.nombreUsuario==null && other.getNombreUsuario()==null) || 
             (this.nombreUsuario!=null &&
              this.nombreUsuario.equals(other.getNombreUsuario()))) &&
            ((this.numeroCelular==null && other.getNumeroCelular()==null) || 
             (this.numeroCelular!=null &&
              this.numeroCelular.equals(other.getNumeroCelular())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = super.hashCode();
        if (getCodTipPlantarifDes() != null) {
            _hashCode += getCodTipPlantarifDes().hashCode();
        }
        if (getCodTipPlantarifOrig() != null) {
            _hashCode += getCodTipPlantarifOrig().hashCode();
        }
        if (getCod_tecnologia() != null) {
            _hashCode += getCod_tecnologia().hashCode();
        }
        if (getInd_cuota() != null) {
            _hashCode += getInd_cuota().hashCode();
        }
        if (getInd_equipo() != null) {
            _hashCode += getInd_equipo().hashCode();
        }
        if (getInd_paquete() != null) {
            _hashCode += getInd_paquete().hashCode();
        }
        if (getNombreUsuario() != null) {
            _hashCode += getNombreUsuario().hashCode();
        }
        if (getNumeroCelular() != null) {
            _hashCode += getNumeroCelular().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(AtributosMigracionDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "AtributosMigracionDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codTipPlantarifDes");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "CodTipPlantarifDes"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codTipPlantarifOrig");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "CodTipPlantarifOrig"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("cod_tecnologia");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "Cod_tecnologia"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ind_cuota");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "Ind_cuota"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ind_equipo");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "Ind_equipo"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ind_paquete");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "Ind_paquete"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nombreUsuario");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "NombreUsuario"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroCelular");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.framework.customerDomain.dataTransferObject", "NumeroCelular"));
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
