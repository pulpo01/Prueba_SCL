/**
 * WsBeneficioPromocionOutDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsBeneficioPromocionOutDTO  implements java.io.Serializable {
    private java.lang.String codigoCampana;

    private java.lang.String codigoTiplan;

    private java.lang.String ddescripcionCampana;

    private java.lang.String indicadorDefault;

    public WsBeneficioPromocionOutDTO() {
    }

    public WsBeneficioPromocionOutDTO(
           java.lang.String codigoCampana,
           java.lang.String codigoTiplan,
           java.lang.String ddescripcionCampana,
           java.lang.String indicadorDefault) {
           this.codigoCampana = codigoCampana;
           this.codigoTiplan = codigoTiplan;
           this.ddescripcionCampana = ddescripcionCampana;
           this.indicadorDefault = indicadorDefault;
    }


    /**
     * Gets the codigoCampana value for this WsBeneficioPromocionOutDTO.
     * 
     * @return codigoCampana
     */
    public java.lang.String getCodigoCampana() {
        return codigoCampana;
    }


    /**
     * Sets the codigoCampana value for this WsBeneficioPromocionOutDTO.
     * 
     * @param codigoCampana
     */
    public void setCodigoCampana(java.lang.String codigoCampana) {
        this.codigoCampana = codigoCampana;
    }


    /**
     * Gets the codigoTiplan value for this WsBeneficioPromocionOutDTO.
     * 
     * @return codigoTiplan
     */
    public java.lang.String getCodigoTiplan() {
        return codigoTiplan;
    }


    /**
     * Sets the codigoTiplan value for this WsBeneficioPromocionOutDTO.
     * 
     * @param codigoTiplan
     */
    public void setCodigoTiplan(java.lang.String codigoTiplan) {
        this.codigoTiplan = codigoTiplan;
    }


    /**
     * Gets the ddescripcionCampana value for this WsBeneficioPromocionOutDTO.
     * 
     * @return ddescripcionCampana
     */
    public java.lang.String getDdescripcionCampana() {
        return ddescripcionCampana;
    }


    /**
     * Sets the ddescripcionCampana value for this WsBeneficioPromocionOutDTO.
     * 
     * @param ddescripcionCampana
     */
    public void setDdescripcionCampana(java.lang.String ddescripcionCampana) {
        this.ddescripcionCampana = ddescripcionCampana;
    }


    /**
     * Gets the indicadorDefault value for this WsBeneficioPromocionOutDTO.
     * 
     * @return indicadorDefault
     */
    public java.lang.String getIndicadorDefault() {
        return indicadorDefault;
    }


    /**
     * Sets the indicadorDefault value for this WsBeneficioPromocionOutDTO.
     * 
     * @param indicadorDefault
     */
    public void setIndicadorDefault(java.lang.String indicadorDefault) {
        this.indicadorDefault = indicadorDefault;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsBeneficioPromocionOutDTO)) return false;
        WsBeneficioPromocionOutDTO other = (WsBeneficioPromocionOutDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codigoCampana==null && other.getCodigoCampana()==null) || 
             (this.codigoCampana!=null &&
              this.codigoCampana.equals(other.getCodigoCampana()))) &&
            ((this.codigoTiplan==null && other.getCodigoTiplan()==null) || 
             (this.codigoTiplan!=null &&
              this.codigoTiplan.equals(other.getCodigoTiplan()))) &&
            ((this.ddescripcionCampana==null && other.getDdescripcionCampana()==null) || 
             (this.ddescripcionCampana!=null &&
              this.ddescripcionCampana.equals(other.getDdescripcionCampana()))) &&
            ((this.indicadorDefault==null && other.getIndicadorDefault()==null) || 
             (this.indicadorDefault!=null &&
              this.indicadorDefault.equals(other.getIndicadorDefault())));
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
        if (getCodigoCampana() != null) {
            _hashCode += getCodigoCampana().hashCode();
        }
        if (getCodigoTiplan() != null) {
            _hashCode += getCodigoTiplan().hashCode();
        }
        if (getDdescripcionCampana() != null) {
            _hashCode += getDdescripcionCampana().hashCode();
        }
        if (getIndicadorDefault() != null) {
            _hashCode += getIndicadorDefault().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsBeneficioPromocionOutDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsBeneficioPromocionOutDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCampana");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoCampana"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoTiplan");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoTiplan"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ddescripcionCampana");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "DdescripcionCampana"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicadorDefault");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "IndicadorDefault"));
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
