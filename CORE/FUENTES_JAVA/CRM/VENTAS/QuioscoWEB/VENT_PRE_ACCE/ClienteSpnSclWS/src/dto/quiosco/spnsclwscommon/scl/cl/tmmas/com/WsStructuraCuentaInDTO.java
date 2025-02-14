/**
 * WsStructuraCuentaInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.quiosco.spnsclwscommon.scl.cl.tmmas.com;

public class WsStructuraCuentaInDTO  implements java.io.Serializable {
    private dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraClienteDTO cliente;

    private java.lang.String codigoCuenta;

    public WsStructuraCuentaInDTO() {
    }

    public WsStructuraCuentaInDTO(
           dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraClienteDTO cliente,
           java.lang.String codigoCuenta) {
           this.cliente = cliente;
           this.codigoCuenta = codigoCuenta;
    }


    /**
     * Gets the cliente value for this WsStructuraCuentaInDTO.
     * 
     * @return cliente
     */
    public dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraClienteDTO getCliente() {
        return cliente;
    }


    /**
     * Sets the cliente value for this WsStructuraCuentaInDTO.
     * 
     * @param cliente
     */
    public void setCliente(dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraClienteDTO cliente) {
        this.cliente = cliente;
    }


    /**
     * Gets the codigoCuenta value for this WsStructuraCuentaInDTO.
     * 
     * @return codigoCuenta
     */
    public java.lang.String getCodigoCuenta() {
        return codigoCuenta;
    }


    /**
     * Sets the codigoCuenta value for this WsStructuraCuentaInDTO.
     * 
     * @param codigoCuenta
     */
    public void setCodigoCuenta(java.lang.String codigoCuenta) {
        this.codigoCuenta = codigoCuenta;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsStructuraCuentaInDTO)) return false;
        WsStructuraCuentaInDTO other = (WsStructuraCuentaInDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.cliente==null && other.getCliente()==null) || 
             (this.cliente!=null &&
              this.cliente.equals(other.getCliente()))) &&
            ((this.codigoCuenta==null && other.getCodigoCuenta()==null) || 
             (this.codigoCuenta!=null &&
              this.codigoCuenta.equals(other.getCodigoCuenta())));
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
        if (getCliente() != null) {
            _hashCode += getCliente().hashCode();
        }
        if (getCodigoCuenta() != null) {
            _hashCode += getCodigoCuenta().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsStructuraCuentaInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraCuentaInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("cliente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "Cliente"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraClienteDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCuenta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "CodigoCuenta"));
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
