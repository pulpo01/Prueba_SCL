/**
 * WsStructuraAntecedentesVentaDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.quiosco.spnsclwscommon.scl.cl.tmmas.com;

public class WsStructuraAntecedentesVentaDTO  implements java.io.Serializable {
    private java.lang.String codigoVendedor;

    public WsStructuraAntecedentesVentaDTO() {
    }

    public WsStructuraAntecedentesVentaDTO(
           java.lang.String codigoVendedor) {
           this.codigoVendedor = codigoVendedor;
    }


    /**
     * Gets the codigoVendedor value for this WsStructuraAntecedentesVentaDTO.
     * 
     * @return codigoVendedor
     */
    public java.lang.String getCodigoVendedor() {
        return codigoVendedor;
    }


    /**
     * Sets the codigoVendedor value for this WsStructuraAntecedentesVentaDTO.
     * 
     * @param codigoVendedor
     */
    public void setCodigoVendedor(java.lang.String codigoVendedor) {
        this.codigoVendedor = codigoVendedor;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsStructuraAntecedentesVentaDTO)) return false;
        WsStructuraAntecedentesVentaDTO other = (WsStructuraAntecedentesVentaDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codigoVendedor==null && other.getCodigoVendedor()==null) || 
             (this.codigoVendedor!=null &&
              this.codigoVendedor.equals(other.getCodigoVendedor())));
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
        if (getCodigoVendedor() != null) {
            _hashCode += getCodigoVendedor().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsStructuraAntecedentesVentaDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraAntecedentesVentaDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoVendedor");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "CodigoVendedor"));
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
