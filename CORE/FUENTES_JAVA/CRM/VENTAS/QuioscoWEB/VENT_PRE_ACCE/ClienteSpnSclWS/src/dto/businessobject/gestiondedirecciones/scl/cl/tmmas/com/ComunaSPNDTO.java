/**
 * ComunaSPNDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com;

public class ComunaSPNDTO  implements java.io.Serializable {
    private java.lang.String codigoCiudad;

    private java.lang.String codigoComuna;

    private java.lang.String codigoProvincia;

    private java.lang.String codigoRegion;

    private java.lang.String descripcionComuna;

    public ComunaSPNDTO() {
    }

    public ComunaSPNDTO(
           java.lang.String codigoCiudad,
           java.lang.String codigoComuna,
           java.lang.String codigoProvincia,
           java.lang.String codigoRegion,
           java.lang.String descripcionComuna) {
           this.codigoCiudad = codigoCiudad;
           this.codigoComuna = codigoComuna;
           this.codigoProvincia = codigoProvincia;
           this.codigoRegion = codigoRegion;
           this.descripcionComuna = descripcionComuna;
    }


    /**
     * Gets the codigoCiudad value for this ComunaSPNDTO.
     * 
     * @return codigoCiudad
     */
    public java.lang.String getCodigoCiudad() {
        return codigoCiudad;
    }


    /**
     * Sets the codigoCiudad value for this ComunaSPNDTO.
     * 
     * @param codigoCiudad
     */
    public void setCodigoCiudad(java.lang.String codigoCiudad) {
        this.codigoCiudad = codigoCiudad;
    }


    /**
     * Gets the codigoComuna value for this ComunaSPNDTO.
     * 
     * @return codigoComuna
     */
    public java.lang.String getCodigoComuna() {
        return codigoComuna;
    }


    /**
     * Sets the codigoComuna value for this ComunaSPNDTO.
     * 
     * @param codigoComuna
     */
    public void setCodigoComuna(java.lang.String codigoComuna) {
        this.codigoComuna = codigoComuna;
    }


    /**
     * Gets the codigoProvincia value for this ComunaSPNDTO.
     * 
     * @return codigoProvincia
     */
    public java.lang.String getCodigoProvincia() {
        return codigoProvincia;
    }


    /**
     * Sets the codigoProvincia value for this ComunaSPNDTO.
     * 
     * @param codigoProvincia
     */
    public void setCodigoProvincia(java.lang.String codigoProvincia) {
        this.codigoProvincia = codigoProvincia;
    }


    /**
     * Gets the codigoRegion value for this ComunaSPNDTO.
     * 
     * @return codigoRegion
     */
    public java.lang.String getCodigoRegion() {
        return codigoRegion;
    }


    /**
     * Sets the codigoRegion value for this ComunaSPNDTO.
     * 
     * @param codigoRegion
     */
    public void setCodigoRegion(java.lang.String codigoRegion) {
        this.codigoRegion = codigoRegion;
    }


    /**
     * Gets the descripcionComuna value for this ComunaSPNDTO.
     * 
     * @return descripcionComuna
     */
    public java.lang.String getDescripcionComuna() {
        return descripcionComuna;
    }


    /**
     * Sets the descripcionComuna value for this ComunaSPNDTO.
     * 
     * @param descripcionComuna
     */
    public void setDescripcionComuna(java.lang.String descripcionComuna) {
        this.descripcionComuna = descripcionComuna;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof ComunaSPNDTO)) return false;
        ComunaSPNDTO other = (ComunaSPNDTO) obj;
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
            ((this.codigoComuna==null && other.getCodigoComuna()==null) || 
             (this.codigoComuna!=null &&
              this.codigoComuna.equals(other.getCodigoComuna()))) &&
            ((this.codigoProvincia==null && other.getCodigoProvincia()==null) || 
             (this.codigoProvincia!=null &&
              this.codigoProvincia.equals(other.getCodigoProvincia()))) &&
            ((this.codigoRegion==null && other.getCodigoRegion()==null) || 
             (this.codigoRegion!=null &&
              this.codigoRegion.equals(other.getCodigoRegion()))) &&
            ((this.descripcionComuna==null && other.getDescripcionComuna()==null) || 
             (this.descripcionComuna!=null &&
              this.descripcionComuna.equals(other.getDescripcionComuna())));
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
        if (getCodigoComuna() != null) {
            _hashCode += getCodigoComuna().hashCode();
        }
        if (getCodigoProvincia() != null) {
            _hashCode += getCodigoProvincia().hashCode();
        }
        if (getCodigoRegion() != null) {
            _hashCode += getCodigoRegion().hashCode();
        }
        if (getDescripcionComuna() != null) {
            _hashCode += getDescripcionComuna().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(ComunaSPNDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "ComunaSPNDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCiudad");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "CodigoCiudad"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoComuna");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "CodigoComuna"));
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
        elemField.setFieldName("descripcionComuna");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "DescripcionComuna"));
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
