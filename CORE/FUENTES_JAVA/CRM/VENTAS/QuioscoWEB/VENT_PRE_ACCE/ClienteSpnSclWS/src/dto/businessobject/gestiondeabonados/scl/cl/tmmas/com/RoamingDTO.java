/**
 * RoamingDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.gestiondeabonados.scl.cl.tmmas.com;

public class RoamingDTO  implements java.io.Serializable {
    private java.lang.String numCelular;

    private java.lang.String uso;

    public RoamingDTO() {
    }

    public RoamingDTO(
           java.lang.String numCelular,
           java.lang.String uso) {
           this.numCelular = numCelular;
           this.uso = uso;
    }


    /**
     * Gets the numCelular value for this RoamingDTO.
     * 
     * @return numCelular
     */
    public java.lang.String getNumCelular() {
        return numCelular;
    }


    /**
     * Sets the numCelular value for this RoamingDTO.
     * 
     * @param numCelular
     */
    public void setNumCelular(java.lang.String numCelular) {
        this.numCelular = numCelular;
    }


    /**
     * Gets the uso value for this RoamingDTO.
     * 
     * @return uso
     */
    public java.lang.String getUso() {
        return uso;
    }


    /**
     * Sets the uso value for this RoamingDTO.
     * 
     * @param uso
     */
    public void setUso(java.lang.String uso) {
        this.uso = uso;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof RoamingDTO)) return false;
        RoamingDTO other = (RoamingDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.numCelular==null && other.getNumCelular()==null) || 
             (this.numCelular!=null &&
              this.numCelular.equals(other.getNumCelular()))) &&
            ((this.uso==null && other.getUso()==null) || 
             (this.uso!=null &&
              this.uso.equals(other.getUso())));
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
        if (getNumCelular() != null) {
            _hashCode += getNumCelular().hashCode();
        }
        if (getUso() != null) {
            _hashCode += getUso().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(RoamingDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "RoamingDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numCelular");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "NumCelular"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("uso");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "Uso"));
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
