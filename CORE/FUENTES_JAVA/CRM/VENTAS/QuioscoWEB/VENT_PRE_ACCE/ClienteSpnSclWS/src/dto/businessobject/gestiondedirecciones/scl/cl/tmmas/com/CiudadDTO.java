/**
 * CiudadDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com;

public class CiudadDTO  implements java.io.Serializable {
    private java.lang.String codigoCiudad;

    private java.lang.String codigoProvincia;

    private java.lang.String codigoRegion;

    private java.lang.String descripcionCiudad;

    public CiudadDTO() {
    }

    public CiudadDTO(
           java.lang.String codigoCiudad,
           java.lang.String codigoProvincia,
           java.lang.String codigoRegion,
           java.lang.String descripcionCiudad) {
           this.codigoCiudad = codigoCiudad;
           this.codigoProvincia = codigoProvincia;
           this.codigoRegion = codigoRegion;
           this.descripcionCiudad = descripcionCiudad;
    }


    /**
     * Gets the codigoCiudad value for this CiudadDTO.
     * 
     * @return codigoCiudad
     */
    public java.lang.String getCodigoCiudad() {
        return codigoCiudad;
    }


    /**
     * Sets the codigoCiudad value for this CiudadDTO.
     * 
     * @param codigoCiudad
     */
    public void setCodigoCiudad(java.lang.String codigoCiudad) {
        this.codigoCiudad = codigoCiudad;
    }


    /**
     * Gets the codigoProvincia value for this CiudadDTO.
     * 
     * @return codigoProvincia
     */
    public java.lang.String getCodigoProvincia() {
        return codigoProvincia;
    }


    /**
     * Sets the codigoProvincia value for this CiudadDTO.
     * 
     * @param codigoProvincia
     */
    public void setCodigoProvincia(java.lang.String codigoProvincia) {
        this.codigoProvincia = codigoProvincia;
    }


    /**
     * Gets the codigoRegion value for this CiudadDTO.
     * 
     * @return codigoRegion
     */
    public java.lang.String getCodigoRegion() {
        return codigoRegion;
    }


    /**
     * Sets the codigoRegion value for this CiudadDTO.
     * 
     * @param codigoRegion
     */
    public void setCodigoRegion(java.lang.String codigoRegion) {
        this.codigoRegion = codigoRegion;
    }


    /**
     * Gets the descripcionCiudad value for this CiudadDTO.
     * 
     * @return descripcionCiudad
     */
    public java.lang.String getDescripcionCiudad() {
        return descripcionCiudad;
    }


    /**
     * Sets the descripcionCiudad value for this CiudadDTO.
     * 
     * @param descripcionCiudad
     */
    public void setDescripcionCiudad(java.lang.String descripcionCiudad) {
        this.descripcionCiudad = descripcionCiudad;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof CiudadDTO)) return false;
        CiudadDTO other = (CiudadDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codigoCiudad==null && other.getCodigoCiudad()==null) || 
             (this.codigoCiudad!=null &&
              this.codigoCiudad.equals(other.getCodigoCiudad()))) &&
            ((this.codigoProvincia==null && other.getCodigoProvincia()==null) || 
             (this.codigoProvincia!=null &&
              this.codigoProvincia.equals(other.getCodigoProvincia()))) &&
            ((this.codigoRegion==null && other.getCodigoRegion()==null) || 
             (this.codigoRegion!=null &&
              this.codigoRegion.equals(other.getCodigoRegion()))) &&
            ((this.descripcionCiudad==null && other.getDescripcionCiudad()==null) || 
             (this.descripcionCiudad!=null &&
              this.descripcionCiudad.equals(other.getDescripcionCiudad())));
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
        if (getCodigoCiudad() != null) {
            _hashCode += getCodigoCiudad().hashCode();
        }
        if (getCodigoProvincia() != null) {
            _hashCode += getCodigoProvincia().hashCode();
        }
        if (getCodigoRegion() != null) {
            _hashCode += getCodigoRegion().hashCode();
        }
        if (getDescripcionCiudad() != null) {
            _hashCode += getDescripcionCiudad().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(CiudadDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "CiudadDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCiudad");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "CodigoCiudad"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
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
        elemField.setFieldName("descripcionCiudad");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "DescripcionCiudad"));
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
