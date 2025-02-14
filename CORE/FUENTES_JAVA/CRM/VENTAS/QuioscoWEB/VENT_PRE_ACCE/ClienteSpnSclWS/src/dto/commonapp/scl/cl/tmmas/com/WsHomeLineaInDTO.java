/**
 * WsHomeLineaInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsHomeLineaInDTO  implements java.io.Serializable {
    private java.lang.String celda;

    private java.lang.String codigCentral;

    public WsHomeLineaInDTO() {
    }

    public WsHomeLineaInDTO(
           java.lang.String celda,
           java.lang.String codigCentral) {
           this.celda = celda;
           this.codigCentral = codigCentral;
    }


    /**
     * Gets the celda value for this WsHomeLineaInDTO.
     * 
     * @return celda
     */
    public java.lang.String getCelda() {
        return celda;
    }


    /**
     * Sets the celda value for this WsHomeLineaInDTO.
     * 
     * @param celda
     */
    public void setCelda(java.lang.String celda) {
        this.celda = celda;
    }


    /**
     * Gets the codigCentral value for this WsHomeLineaInDTO.
     * 
     * @return codigCentral
     */
    public java.lang.String getCodigCentral() {
        return codigCentral;
    }


    /**
     * Sets the codigCentral value for this WsHomeLineaInDTO.
     * 
     * @param codigCentral
     */
    public void setCodigCentral(java.lang.String codigCentral) {
        this.codigCentral = codigCentral;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsHomeLineaInDTO)) return false;
        WsHomeLineaInDTO other = (WsHomeLineaInDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.celda==null && other.getCelda()==null) || 
             (this.celda!=null &&
              this.celda.equals(other.getCelda()))) &&
            ((this.codigCentral==null && other.getCodigCentral()==null) || 
             (this.codigCentral!=null &&
              this.codigCentral.equals(other.getCodigCentral())));
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
        if (getCelda() != null) {
            _hashCode += getCelda().hashCode();
        }
        if (getCodigCentral() != null) {
            _hashCode += getCodigCentral().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsHomeLineaInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsHomeLineaInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("celda");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "Celda"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigCentral");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigCentral"));
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
