/**
 * RegionDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com;

public class RegionDTO  implements java.io.Serializable {
    private java.lang.String codigoRegion;

    private java.lang.String descripcionRegion;

    public RegionDTO() {
    }

    public RegionDTO(
           java.lang.String codigoRegion,
           java.lang.String descripcionRegion) {
           this.codigoRegion = codigoRegion;
           this.descripcionRegion = descripcionRegion;
    }


    /**
     * Gets the codigoRegion value for this RegionDTO.
     * 
     * @return codigoRegion
     */
    public java.lang.String getCodigoRegion() {
        return codigoRegion;
    }


    /**
     * Sets the codigoRegion value for this RegionDTO.
     * 
     * @param codigoRegion
     */
    public void setCodigoRegion(java.lang.String codigoRegion) {
        this.codigoRegion = codigoRegion;
    }


    /**
     * Gets the descripcionRegion value for this RegionDTO.
     * 
     * @return descripcionRegion
     */
    public java.lang.String getDescripcionRegion() {
        return descripcionRegion;
    }


    /**
     * Sets the descripcionRegion value for this RegionDTO.
     * 
     * @param descripcionRegion
     */
    public void setDescripcionRegion(java.lang.String descripcionRegion) {
        this.descripcionRegion = descripcionRegion;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof RegionDTO)) return false;
        RegionDTO other = (RegionDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codigoRegion==null && other.getCodigoRegion()==null) || 
             (this.codigoRegion!=null &&
              this.codigoRegion.equals(other.getCodigoRegion()))) &&
            ((this.descripcionRegion==null && other.getDescripcionRegion()==null) || 
             (this.descripcionRegion!=null &&
              this.descripcionRegion.equals(other.getDescripcionRegion())));
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
        if (getCodigoRegion() != null) {
            _hashCode += getCodigoRegion().hashCode();
        }
        if (getDescripcionRegion() != null) {
            _hashCode += getDescripcionRegion().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(RegionDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "RegionDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoRegion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "CodigoRegion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("descripcionRegion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "DescripcionRegion"));
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
