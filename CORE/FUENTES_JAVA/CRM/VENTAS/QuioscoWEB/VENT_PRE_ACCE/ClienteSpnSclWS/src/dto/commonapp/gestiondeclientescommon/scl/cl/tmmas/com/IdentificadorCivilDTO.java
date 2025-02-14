/**
 * IdentificadorCivilDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com;

public class IdentificadorCivilDTO  implements java.io.Serializable {
    private java.lang.String codigoTipIdentif;

    private java.lang.String descripcionTipIdentif;

    private java.lang.String indicadorPertrib;

    private int indicadorSalefact;

    public IdentificadorCivilDTO() {
    }

    public IdentificadorCivilDTO(
           java.lang.String codigoTipIdentif,
           java.lang.String descripcionTipIdentif,
           java.lang.String indicadorPertrib,
           int indicadorSalefact) {
           this.codigoTipIdentif = codigoTipIdentif;
           this.descripcionTipIdentif = descripcionTipIdentif;
           this.indicadorPertrib = indicadorPertrib;
           this.indicadorSalefact = indicadorSalefact;
    }


    /**
     * Gets the codigoTipIdentif value for this IdentificadorCivilDTO.
     * 
     * @return codigoTipIdentif
     */
    public java.lang.String getCodigoTipIdentif() {
        return codigoTipIdentif;
    }


    /**
     * Sets the codigoTipIdentif value for this IdentificadorCivilDTO.
     * 
     * @param codigoTipIdentif
     */
    public void setCodigoTipIdentif(java.lang.String codigoTipIdentif) {
        this.codigoTipIdentif = codigoTipIdentif;
    }


    /**
     * Gets the descripcionTipIdentif value for this IdentificadorCivilDTO.
     * 
     * @return descripcionTipIdentif
     */
    public java.lang.String getDescripcionTipIdentif() {
        return descripcionTipIdentif;
    }


    /**
     * Sets the descripcionTipIdentif value for this IdentificadorCivilDTO.
     * 
     * @param descripcionTipIdentif
     */
    public void setDescripcionTipIdentif(java.lang.String descripcionTipIdentif) {
        this.descripcionTipIdentif = descripcionTipIdentif;
    }


    /**
     * Gets the indicadorPertrib value for this IdentificadorCivilDTO.
     * 
     * @return indicadorPertrib
     */
    public java.lang.String getIndicadorPertrib() {
        return indicadorPertrib;
    }


    /**
     * Sets the indicadorPertrib value for this IdentificadorCivilDTO.
     * 
     * @param indicadorPertrib
     */
    public void setIndicadorPertrib(java.lang.String indicadorPertrib) {
        this.indicadorPertrib = indicadorPertrib;
    }


    /**
     * Gets the indicadorSalefact value for this IdentificadorCivilDTO.
     * 
     * @return indicadorSalefact
     */
    public int getIndicadorSalefact() {
        return indicadorSalefact;
    }


    /**
     * Sets the indicadorSalefact value for this IdentificadorCivilDTO.
     * 
     * @param indicadorSalefact
     */
    public void setIndicadorSalefact(int indicadorSalefact) {
        this.indicadorSalefact = indicadorSalefact;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IdentificadorCivilDTO)) return false;
        IdentificadorCivilDTO other = (IdentificadorCivilDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codigoTipIdentif==null && other.getCodigoTipIdentif()==null) || 
             (this.codigoTipIdentif!=null &&
              this.codigoTipIdentif.equals(other.getCodigoTipIdentif()))) &&
            ((this.descripcionTipIdentif==null && other.getDescripcionTipIdentif()==null) || 
             (this.descripcionTipIdentif!=null &&
              this.descripcionTipIdentif.equals(other.getDescripcionTipIdentif()))) &&
            ((this.indicadorPertrib==null && other.getIndicadorPertrib()==null) || 
             (this.indicadorPertrib!=null &&
              this.indicadorPertrib.equals(other.getIndicadorPertrib()))) &&
            this.indicadorSalefact == other.getIndicadorSalefact();
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
        if (getCodigoTipIdentif() != null) {
            _hashCode += getCodigoTipIdentif().hashCode();
        }
        if (getDescripcionTipIdentif() != null) {
            _hashCode += getDescripcionTipIdentif().hashCode();
        }
        if (getIndicadorPertrib() != null) {
            _hashCode += getIndicadorPertrib().hashCode();
        }
        _hashCode += getIndicadorSalefact();
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(IdentificadorCivilDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IdentificadorCivilDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoTipIdentif");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoTipIdentif"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("descripcionTipIdentif");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "DescripcionTipIdentif"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicadorPertrib");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IndicadorPertrib"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicadorSalefact");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IndicadorSalefact"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
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
