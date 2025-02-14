/**
 * WsCreaStructuraComercialInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.quiosco.spnsclwscommon.scl.cl.tmmas.com;

public class WsCreaStructuraComercialInDTO  implements java.io.Serializable {
    private java.lang.String codPlanTarif;

    private java.lang.String codPrestacion;

    private dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraCuentaInDTO cuenta;

    private dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraPagoDTO pago;

    private java.lang.String usuarioAD;

    private java.lang.String usuarioOracle;

    public WsCreaStructuraComercialInDTO() {
    }

    public WsCreaStructuraComercialInDTO(
           java.lang.String codPlanTarif,
           java.lang.String codPrestacion,
           dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraCuentaInDTO cuenta,
           dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraPagoDTO pago,
           java.lang.String usuarioAD,
           java.lang.String usuarioOracle) {
           this.codPlanTarif = codPlanTarif;
           this.codPrestacion = codPrestacion;
           this.cuenta = cuenta;
           this.pago = pago;
           this.usuarioAD = usuarioAD;
           this.usuarioOracle = usuarioOracle;
    }


    /**
     * Gets the codPlanTarif value for this WsCreaStructuraComercialInDTO.
     * 
     * @return codPlanTarif
     */
    public java.lang.String getCodPlanTarif() {
        return codPlanTarif;
    }


    /**
     * Sets the codPlanTarif value for this WsCreaStructuraComercialInDTO.
     * 
     * @param codPlanTarif
     */
    public void setCodPlanTarif(java.lang.String codPlanTarif) {
        this.codPlanTarif = codPlanTarif;
    }


    /**
     * Gets the codPrestacion value for this WsCreaStructuraComercialInDTO.
     * 
     * @return codPrestacion
     */
    public java.lang.String getCodPrestacion() {
        return codPrestacion;
    }


    /**
     * Sets the codPrestacion value for this WsCreaStructuraComercialInDTO.
     * 
     * @param codPrestacion
     */
    public void setCodPrestacion(java.lang.String codPrestacion) {
        this.codPrestacion = codPrestacion;
    }


    /**
     * Gets the cuenta value for this WsCreaStructuraComercialInDTO.
     * 
     * @return cuenta
     */
    public dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraCuentaInDTO getCuenta() {
        return cuenta;
    }


    /**
     * Sets the cuenta value for this WsCreaStructuraComercialInDTO.
     * 
     * @param cuenta
     */
    public void setCuenta(dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraCuentaInDTO cuenta) {
        this.cuenta = cuenta;
    }


    /**
     * Gets the pago value for this WsCreaStructuraComercialInDTO.
     * 
     * @return pago
     */
    public dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraPagoDTO getPago() {
        return pago;
    }


    /**
     * Sets the pago value for this WsCreaStructuraComercialInDTO.
     * 
     * @param pago
     */
    public void setPago(dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraPagoDTO pago) {
        this.pago = pago;
    }


    /**
     * Gets the usuarioAD value for this WsCreaStructuraComercialInDTO.
     * 
     * @return usuarioAD
     */
    public java.lang.String getUsuarioAD() {
        return usuarioAD;
    }


    /**
     * Sets the usuarioAD value for this WsCreaStructuraComercialInDTO.
     * 
     * @param usuarioAD
     */
    public void setUsuarioAD(java.lang.String usuarioAD) {
        this.usuarioAD = usuarioAD;
    }


    /**
     * Gets the usuarioOracle value for this WsCreaStructuraComercialInDTO.
     * 
     * @return usuarioOracle
     */
    public java.lang.String getUsuarioOracle() {
        return usuarioOracle;
    }


    /**
     * Sets the usuarioOracle value for this WsCreaStructuraComercialInDTO.
     * 
     * @param usuarioOracle
     */
    public void setUsuarioOracle(java.lang.String usuarioOracle) {
        this.usuarioOracle = usuarioOracle;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsCreaStructuraComercialInDTO)) return false;
        WsCreaStructuraComercialInDTO other = (WsCreaStructuraComercialInDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codPlanTarif==null && other.getCodPlanTarif()==null) || 
             (this.codPlanTarif!=null &&
              this.codPlanTarif.equals(other.getCodPlanTarif()))) &&
            ((this.codPrestacion==null && other.getCodPrestacion()==null) || 
             (this.codPrestacion!=null &&
              this.codPrestacion.equals(other.getCodPrestacion()))) &&
            ((this.cuenta==null && other.getCuenta()==null) || 
             (this.cuenta!=null &&
              this.cuenta.equals(other.getCuenta()))) &&
            ((this.pago==null && other.getPago()==null) || 
             (this.pago!=null &&
              this.pago.equals(other.getPago()))) &&
            ((this.usuarioAD==null && other.getUsuarioAD()==null) || 
             (this.usuarioAD!=null &&
              this.usuarioAD.equals(other.getUsuarioAD()))) &&
            ((this.usuarioOracle==null && other.getUsuarioOracle()==null) || 
             (this.usuarioOracle!=null &&
              this.usuarioOracle.equals(other.getUsuarioOracle())));
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
        if (getCodPlanTarif() != null) {
            _hashCode += getCodPlanTarif().hashCode();
        }
        if (getCodPrestacion() != null) {
            _hashCode += getCodPrestacion().hashCode();
        }
        if (getCuenta() != null) {
            _hashCode += getCuenta().hashCode();
        }
        if (getPago() != null) {
            _hashCode += getPago().hashCode();
        }
        if (getUsuarioAD() != null) {
            _hashCode += getUsuarioAD().hashCode();
        }
        if (getUsuarioOracle() != null) {
            _hashCode += getUsuarioOracle().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsCreaStructuraComercialInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsCreaStructuraComercialInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codPlanTarif");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "CodPlanTarif"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codPrestacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "CodPrestacion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("cuenta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "Cuenta"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraCuentaInDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("pago");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "Pago"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraPagoDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("usuarioAD");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "UsuarioAD"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("usuarioOracle");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "UsuarioOracle"));
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
