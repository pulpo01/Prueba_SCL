/**
 * WsCierreVentaInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package in.dto.commonapp.spnsclwscommon.scl.cl.tmmas.com;

public class WsCierreVentaInDTO  implements java.io.Serializable {
    private java.lang.String identificadorTransaccion;

    private java.lang.Float mtoGarantia;

    private java.lang.String usuario;

    private java.lang.String venta;

    public WsCierreVentaInDTO() {
    }

    public WsCierreVentaInDTO(
           java.lang.String identificadorTransaccion,
           java.lang.Float mtoGarantia,
           java.lang.String usuario,
           java.lang.String venta) {
           this.identificadorTransaccion = identificadorTransaccion;
           this.mtoGarantia = mtoGarantia;
           this.usuario = usuario;
           this.venta = venta;
    }


    /**
     * Gets the identificadorTransaccion value for this WsCierreVentaInDTO.
     * 
     * @return identificadorTransaccion
     */
    public java.lang.String getIdentificadorTransaccion() {
        return identificadorTransaccion;
    }


    /**
     * Sets the identificadorTransaccion value for this WsCierreVentaInDTO.
     * 
     * @param identificadorTransaccion
     */
    public void setIdentificadorTransaccion(java.lang.String identificadorTransaccion) {
        this.identificadorTransaccion = identificadorTransaccion;
    }


    /**
     * Gets the mtoGarantia value for this WsCierreVentaInDTO.
     * 
     * @return mtoGarantia
     */
    public java.lang.Float getMtoGarantia() {
        return mtoGarantia;
    }


    /**
     * Sets the mtoGarantia value for this WsCierreVentaInDTO.
     * 
     * @param mtoGarantia
     */
    public void setMtoGarantia(java.lang.Float mtoGarantia) {
        this.mtoGarantia = mtoGarantia;
    }


    /**
     * Gets the usuario value for this WsCierreVentaInDTO.
     * 
     * @return usuario
     */
    public java.lang.String getUsuario() {
        return usuario;
    }


    /**
     * Sets the usuario value for this WsCierreVentaInDTO.
     * 
     * @param usuario
     */
    public void setUsuario(java.lang.String usuario) {
        this.usuario = usuario;
    }


    /**
     * Gets the venta value for this WsCierreVentaInDTO.
     * 
     * @return venta
     */
    public java.lang.String getVenta() {
        return venta;
    }


    /**
     * Sets the venta value for this WsCierreVentaInDTO.
     * 
     * @param venta
     */
    public void setVenta(java.lang.String venta) {
        this.venta = venta;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsCierreVentaInDTO)) return false;
        WsCierreVentaInDTO other = (WsCierreVentaInDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.identificadorTransaccion==null && other.getIdentificadorTransaccion()==null) || 
             (this.identificadorTransaccion!=null &&
              this.identificadorTransaccion.equals(other.getIdentificadorTransaccion()))) &&
            ((this.mtoGarantia==null && other.getMtoGarantia()==null) || 
             (this.mtoGarantia!=null &&
              this.mtoGarantia.equals(other.getMtoGarantia()))) &&
            ((this.usuario==null && other.getUsuario()==null) || 
             (this.usuario!=null &&
              this.usuario.equals(other.getUsuario()))) &&
            ((this.venta==null && other.getVenta()==null) || 
             (this.venta!=null &&
              this.venta.equals(other.getVenta())));
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
        if (getIdentificadorTransaccion() != null) {
            _hashCode += getIdentificadorTransaccion().hashCode();
        }
        if (getMtoGarantia() != null) {
            _hashCode += getMtoGarantia().hashCode();
        }
        if (getUsuario() != null) {
            _hashCode += getUsuario().hashCode();
        }
        if (getVenta() != null) {
            _hashCode += getVenta().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsCierreVentaInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in", "WsCierreVentaInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("identificadorTransaccion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in", "IdentificadorTransaccion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("mtoGarantia");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in", "MtoGarantia"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "float"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("usuario");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in", "Usuario"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("venta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in", "Venta"));
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
