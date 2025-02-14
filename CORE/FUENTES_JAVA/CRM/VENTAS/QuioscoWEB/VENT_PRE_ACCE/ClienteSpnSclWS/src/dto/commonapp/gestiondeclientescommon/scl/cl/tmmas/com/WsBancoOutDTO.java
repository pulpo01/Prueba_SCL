/**
 * WsBancoOutDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com;

public class WsBancoOutDTO  implements java.io.Serializable {
    private java.lang.String codBanco;

    private java.lang.String desBanco;

    private java.lang.String indPac;

    public WsBancoOutDTO() {
    }

    public WsBancoOutDTO(
           java.lang.String codBanco,
           java.lang.String desBanco,
           java.lang.String indPac) {
           this.codBanco = codBanco;
           this.desBanco = desBanco;
           this.indPac = indPac;
    }


    /**
     * Gets the codBanco value for this WsBancoOutDTO.
     * 
     * @return codBanco
     */
    public java.lang.String getCodBanco() {
        return codBanco;
    }


    /**
     * Sets the codBanco value for this WsBancoOutDTO.
     * 
     * @param codBanco
     */
    public void setCodBanco(java.lang.String codBanco) {
        this.codBanco = codBanco;
    }


    /**
     * Gets the desBanco value for this WsBancoOutDTO.
     * 
     * @return desBanco
     */
    public java.lang.String getDesBanco() {
        return desBanco;
    }


    /**
     * Sets the desBanco value for this WsBancoOutDTO.
     * 
     * @param desBanco
     */
    public void setDesBanco(java.lang.String desBanco) {
        this.desBanco = desBanco;
    }


    /**
     * Gets the indPac value for this WsBancoOutDTO.
     * 
     * @return indPac
     */
    public java.lang.String getIndPac() {
        return indPac;
    }


    /**
     * Sets the indPac value for this WsBancoOutDTO.
     * 
     * @param indPac
     */
    public void setIndPac(java.lang.String indPac) {
        this.indPac = indPac;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsBancoOutDTO)) return false;
        WsBancoOutDTO other = (WsBancoOutDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codBanco==null && other.getCodBanco()==null) || 
             (this.codBanco!=null &&
              this.codBanco.equals(other.getCodBanco()))) &&
            ((this.desBanco==null && other.getDesBanco()==null) || 
             (this.desBanco!=null &&
              this.desBanco.equals(other.getDesBanco()))) &&
            ((this.indPac==null && other.getIndPac()==null) || 
             (this.indPac!=null &&
              this.indPac.equals(other.getIndPac())));
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
        if (getCodBanco() != null) {
            _hashCode += getCodBanco().hashCode();
        }
        if (getDesBanco() != null) {
            _hashCode += getDesBanco().hashCode();
        }
        if (getIndPac() != null) {
            _hashCode += getIndPac().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsBancoOutDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsBancoOutDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codBanco");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodBanco"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("desBanco");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "DesBanco"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indPac");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IndPac"));
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
