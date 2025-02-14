/**
 * CajaDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com;

public class CajaDTO  implements java.io.Serializable {
    private java.lang.String codCaja;

    private java.lang.String desCaja;

    public CajaDTO() {
    }

    public CajaDTO(
           java.lang.String codCaja,
           java.lang.String desCaja) {
           this.codCaja = codCaja;
           this.desCaja = desCaja;
    }


    /**
     * Gets the codCaja value for this CajaDTO.
     * 
     * @return codCaja
     */
    public java.lang.String getCodCaja() {
        return codCaja;
    }


    /**
     * Sets the codCaja value for this CajaDTO.
     * 
     * @param codCaja
     */
    public void setCodCaja(java.lang.String codCaja) {
        this.codCaja = codCaja;
    }


    /**
     * Gets the desCaja value for this CajaDTO.
     * 
     * @return desCaja
     */
    public java.lang.String getDesCaja() {
        return desCaja;
    }


    /**
     * Sets the desCaja value for this CajaDTO.
     * 
     * @param desCaja
     */
    public void setDesCaja(java.lang.String desCaja) {
        this.desCaja = desCaja;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof CajaDTO)) return false;
        CajaDTO other = (CajaDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codCaja==null && other.getCodCaja()==null) || 
             (this.codCaja!=null &&
              this.codCaja.equals(other.getCodCaja()))) &&
            ((this.desCaja==null && other.getDesCaja()==null) || 
             (this.desCaja!=null &&
              this.desCaja.equals(other.getDesCaja())));
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
        if (getCodCaja() != null) {
            _hashCode += getCodCaja().hashCode();
        }
        if (getDesCaja() != null) {
            _hashCode += getDesCaja().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(CajaDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "CajaDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codCaja");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "CodCaja"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("desCaja");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "DesCaja"));
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
