/**
 * RepresentanteLegalDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com;

public class RepresentanteLegalDTO  implements java.io.Serializable {
    private java.lang.String codigoTipoIdentificacion;

    private java.lang.String nombre;

    private java.lang.String numeroTipoIdentificacion;

    public RepresentanteLegalDTO() {
    }

    public RepresentanteLegalDTO(
           java.lang.String codigoTipoIdentificacion,
           java.lang.String nombre,
           java.lang.String numeroTipoIdentificacion) {
           this.codigoTipoIdentificacion = codigoTipoIdentificacion;
           this.nombre = nombre;
           this.numeroTipoIdentificacion = numeroTipoIdentificacion;
    }


    /**
     * Gets the codigoTipoIdentificacion value for this RepresentanteLegalDTO.
     * 
     * @return codigoTipoIdentificacion
     */
    public java.lang.String getCodigoTipoIdentificacion() {
        return codigoTipoIdentificacion;
    }


    /**
     * Sets the codigoTipoIdentificacion value for this RepresentanteLegalDTO.
     * 
     * @param codigoTipoIdentificacion
     */
    public void setCodigoTipoIdentificacion(java.lang.String codigoTipoIdentificacion) {
        this.codigoTipoIdentificacion = codigoTipoIdentificacion;
    }


    /**
     * Gets the nombre value for this RepresentanteLegalDTO.
     * 
     * @return nombre
     */
    public java.lang.String getNombre() {
        return nombre;
    }


    /**
     * Sets the nombre value for this RepresentanteLegalDTO.
     * 
     * @param nombre
     */
    public void setNombre(java.lang.String nombre) {
        this.nombre = nombre;
    }


    /**
     * Gets the numeroTipoIdentificacion value for this RepresentanteLegalDTO.
     * 
     * @return numeroTipoIdentificacion
     */
    public java.lang.String getNumeroTipoIdentificacion() {
        return numeroTipoIdentificacion;
    }


    /**
     * Sets the numeroTipoIdentificacion value for this RepresentanteLegalDTO.
     * 
     * @param numeroTipoIdentificacion
     */
    public void setNumeroTipoIdentificacion(java.lang.String numeroTipoIdentificacion) {
        this.numeroTipoIdentificacion = numeroTipoIdentificacion;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof RepresentanteLegalDTO)) return false;
        RepresentanteLegalDTO other = (RepresentanteLegalDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codigoTipoIdentificacion==null && other.getCodigoTipoIdentificacion()==null) || 
             (this.codigoTipoIdentificacion!=null &&
              this.codigoTipoIdentificacion.equals(other.getCodigoTipoIdentificacion()))) &&
            ((this.nombre==null && other.getNombre()==null) || 
             (this.nombre!=null &&
              this.nombre.equals(other.getNombre()))) &&
            ((this.numeroTipoIdentificacion==null && other.getNumeroTipoIdentificacion()==null) || 
             (this.numeroTipoIdentificacion!=null &&
              this.numeroTipoIdentificacion.equals(other.getNumeroTipoIdentificacion())));
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
        if (getCodigoTipoIdentificacion() != null) {
            _hashCode += getCodigoTipoIdentificacion().hashCode();
        }
        if (getNombre() != null) {
            _hashCode += getNombre().hashCode();
        }
        if (getNumeroTipoIdentificacion() != null) {
            _hashCode += getNumeroTipoIdentificacion().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(RepresentanteLegalDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "RepresentanteLegalDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoTipoIdentificacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoTipoIdentificacion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nombre");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "Nombre"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroTipoIdentificacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroTipoIdentificacion"));
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
