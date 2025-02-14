/**
 * WsTarjetaOutDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com;

public class WsTarjetaOutDTO  implements java.io.Serializable {
    private java.lang.String codTarjeta;

    private java.lang.String desTarjeta;

    public WsTarjetaOutDTO() {
    }

    public WsTarjetaOutDTO(
           java.lang.String codTarjeta,
           java.lang.String desTarjeta) {
           this.codTarjeta = codTarjeta;
           this.desTarjeta = desTarjeta;
    }


    /**
     * Gets the codTarjeta value for this WsTarjetaOutDTO.
     * 
     * @return codTarjeta
     */
    public java.lang.String getCodTarjeta() {
        return codTarjeta;
    }


    /**
     * Sets the codTarjeta value for this WsTarjetaOutDTO.
     * 
     * @param codTarjeta
     */
    public void setCodTarjeta(java.lang.String codTarjeta) {
        this.codTarjeta = codTarjeta;
    }


    /**
     * Gets the desTarjeta value for this WsTarjetaOutDTO.
     * 
     * @return desTarjeta
     */
    public java.lang.String getDesTarjeta() {
        return desTarjeta;
    }


    /**
     * Sets the desTarjeta value for this WsTarjetaOutDTO.
     * 
     * @param desTarjeta
     */
    public void setDesTarjeta(java.lang.String desTarjeta) {
        this.desTarjeta = desTarjeta;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsTarjetaOutDTO)) return false;
        WsTarjetaOutDTO other = (WsTarjetaOutDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codTarjeta==null && other.getCodTarjeta()==null) || 
             (this.codTarjeta!=null &&
              this.codTarjeta.equals(other.getCodTarjeta()))) &&
            ((this.desTarjeta==null && other.getDesTarjeta()==null) || 
             (this.desTarjeta!=null &&
              this.desTarjeta.equals(other.getDesTarjeta())));
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
        if (getCodTarjeta() != null) {
            _hashCode += getCodTarjeta().hashCode();
        }
        if (getDesTarjeta() != null) {
            _hashCode += getDesTarjeta().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsTarjetaOutDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsTarjetaOutDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codTarjeta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodTarjeta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("desTarjeta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "DesTarjeta"));
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
