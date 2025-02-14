/**
 * AbonadoPortadoDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.gestiondeabonados.scl.cl.tmmas.com;

public class AbonadoPortadoDTO  implements java.io.Serializable {
    private long numCelular;

    private java.lang.String perfil;

    public AbonadoPortadoDTO() {
    }

    public AbonadoPortadoDTO(
           long numCelular,
           java.lang.String perfil) {
           this.numCelular = numCelular;
           this.perfil = perfil;
    }


    /**
     * Gets the numCelular value for this AbonadoPortadoDTO.
     * 
     * @return numCelular
     */
    public long getNumCelular() {
        return numCelular;
    }


    /**
     * Sets the numCelular value for this AbonadoPortadoDTO.
     * 
     * @param numCelular
     */
    public void setNumCelular(long numCelular) {
        this.numCelular = numCelular;
    }


    /**
     * Gets the perfil value for this AbonadoPortadoDTO.
     * 
     * @return perfil
     */
    public java.lang.String getPerfil() {
        return perfil;
    }


    /**
     * Sets the perfil value for this AbonadoPortadoDTO.
     * 
     * @param perfil
     */
    public void setPerfil(java.lang.String perfil) {
        this.perfil = perfil;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof AbonadoPortadoDTO)) return false;
        AbonadoPortadoDTO other = (AbonadoPortadoDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            this.numCelular == other.getNumCelular() &&
            ((this.perfil==null && other.getPerfil()==null) || 
             (this.perfil!=null &&
              this.perfil.equals(other.getPerfil())));
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
        _hashCode += new Long(getNumCelular()).hashCode();
        if (getPerfil() != null) {
            _hashCode += getPerfil().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(AbonadoPortadoDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "AbonadoPortadoDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numCelular");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "NumCelular"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("perfil");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "Perfil"));
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
