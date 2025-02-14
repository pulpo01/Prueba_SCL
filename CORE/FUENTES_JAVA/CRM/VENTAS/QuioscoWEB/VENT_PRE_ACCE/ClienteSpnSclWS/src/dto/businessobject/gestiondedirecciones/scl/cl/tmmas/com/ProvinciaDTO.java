/**
 * ProvinciaDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com;

public class ProvinciaDTO  implements java.io.Serializable {
    private java.lang.String codigoProvincia;

    private java.lang.String codigoRegion;

    private java.lang.String descripcionProvincia;

    public ProvinciaDTO() {
    }

    public ProvinciaDTO(
           java.lang.String codigoProvincia,
           java.lang.String codigoRegion,
           java.lang.String descripcionProvincia) {
           this.codigoProvincia = codigoProvincia;
           this.codigoRegion = codigoRegion;
           this.descripcionProvincia = descripcionProvincia;
    }


    /**
     * Gets the codigoProvincia value for this ProvinciaDTO.
     * 
     * @return codigoProvincia
     */
    public java.lang.String getCodigoProvincia() {
        return codigoProvincia;
    }


    /**
     * Sets the codigoProvincia value for this ProvinciaDTO.
     * 
     * @param codigoProvincia
     */
    public void setCodigoProvincia(java.lang.String codigoProvincia) {
        this.codigoProvincia = codigoProvincia;
    }


    /**
     * Gets the codigoRegion value for this ProvinciaDTO.
     * 
     * @return codigoRegion
     */
    public java.lang.String getCodigoRegion() {
        return codigoRegion;
    }


    /**
     * Sets the codigoRegion value for this ProvinciaDTO.
     * 
     * @param codigoRegion
     */
    public void setCodigoRegion(java.lang.String codigoRegion) {
        this.codigoRegion = codigoRegion;
    }


    /**
     * Gets the descripcionProvincia value for this ProvinciaDTO.
     * 
     * @return descripcionProvincia
     */
    public java.lang.String getDescripcionProvincia() {
        return descripcionProvincia;
    }


    /**
     * Sets the descripcionProvincia value for this ProvinciaDTO.
     * 
     * @param descripcionProvincia
     */
    public void setDescripcionProvincia(java.lang.String descripcionProvincia) {
        this.descripcionProvincia = descripcionProvincia;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof ProvinciaDTO)) return false;
        ProvinciaDTO other = (ProvinciaDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codigoProvincia==null && other.getCodigoProvincia()==null) || 
             (this.codigoProvincia!=null &&
              this.codigoProvincia.equals(other.getCodigoProvincia()))) &&
            ((this.codigoRegion==null && other.getCodigoRegion()==null) || 
             (this.codigoRegion!=null &&
              this.codigoRegion.equals(other.getCodigoRegion()))) &&
            ((this.descripcionProvincia==null && other.getDescripcionProvincia()==null) || 
             (this.descripcionProvincia!=null &&
              this.descripcionProvincia.equals(other.getDescripcionProvincia())));
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
        if (getCodigoProvincia() != null) {
            _hashCode += getCodigoProvincia().hashCode();
        }
        if (getCodigoRegion() != null) {
            _hashCode += getCodigoRegion().hashCode();
        }
        if (getDescripcionProvincia() != null) {
            _hashCode += getDescripcionProvincia().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(ProvinciaDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "ProvinciaDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoProvincia");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "CodigoProvincia"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoRegion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "CodigoRegion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("descripcionProvincia");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "DescripcionProvincia"));
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
