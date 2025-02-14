/**
 * ClienteDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com;

public class ClienteDTO  implements java.io.Serializable {
    private int codCiclFact;

    private long codCliente;

    private long codCuenta;

    public ClienteDTO() {
    }

    public ClienteDTO(
           int codCiclFact,
           long codCliente,
           long codCuenta) {
           this.codCiclFact = codCiclFact;
           this.codCliente = codCliente;
           this.codCuenta = codCuenta;
    }


    /**
     * Gets the codCiclFact value for this ClienteDTO.
     * 
     * @return codCiclFact
     */
    public int getCodCiclFact() {
        return codCiclFact;
    }


    /**
     * Sets the codCiclFact value for this ClienteDTO.
     * 
     * @param codCiclFact
     */
    public void setCodCiclFact(int codCiclFact) {
        this.codCiclFact = codCiclFact;
    }


    /**
     * Gets the codCliente value for this ClienteDTO.
     * 
     * @return codCliente
     */
    public long getCodCliente() {
        return codCliente;
    }


    /**
     * Sets the codCliente value for this ClienteDTO.
     * 
     * @param codCliente
     */
    public void setCodCliente(long codCliente) {
        this.codCliente = codCliente;
    }


    /**
     * Gets the codCuenta value for this ClienteDTO.
     * 
     * @return codCuenta
     */
    public long getCodCuenta() {
        return codCuenta;
    }


    /**
     * Sets the codCuenta value for this ClienteDTO.
     * 
     * @param codCuenta
     */
    public void setCodCuenta(long codCuenta) {
        this.codCuenta = codCuenta;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof ClienteDTO)) return false;
        ClienteDTO other = (ClienteDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            this.codCiclFact == other.getCodCiclFact() &&
            this.codCliente == other.getCodCliente() &&
            this.codCuenta == other.getCodCuenta();
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
        _hashCode += getCodCiclFact();
        _hashCode += new Long(getCodCliente()).hashCode();
        _hashCode += new Long(getCodCuenta()).hashCode();
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(ClienteDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "ClienteDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codCiclFact");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "CodCiclFact"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codCliente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "CodCliente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codCuenta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "CodCuenta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
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
