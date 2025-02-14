/**
 * WsPlanTarifarioOutDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com;

public class WsPlanTarifarioOutDTO  implements java.io.Serializable {
    private java.lang.String codPlanTarif;

    private java.lang.String codTiplan;

    private java.lang.String desPlanTarif;

    private java.lang.String numAbonados;

    public WsPlanTarifarioOutDTO() {
    }

    public WsPlanTarifarioOutDTO(
           java.lang.String codPlanTarif,
           java.lang.String codTiplan,
           java.lang.String desPlanTarif,
           java.lang.String numAbonados) {
           this.codPlanTarif = codPlanTarif;
           this.codTiplan = codTiplan;
           this.desPlanTarif = desPlanTarif;
           this.numAbonados = numAbonados;
    }


    /**
     * Gets the codPlanTarif value for this WsPlanTarifarioOutDTO.
     * 
     * @return codPlanTarif
     */
    public java.lang.String getCodPlanTarif() {
        return codPlanTarif;
    }


    /**
     * Sets the codPlanTarif value for this WsPlanTarifarioOutDTO.
     * 
     * @param codPlanTarif
     */
    public void setCodPlanTarif(java.lang.String codPlanTarif) {
        this.codPlanTarif = codPlanTarif;
    }


    /**
     * Gets the codTiplan value for this WsPlanTarifarioOutDTO.
     * 
     * @return codTiplan
     */
    public java.lang.String getCodTiplan() {
        return codTiplan;
    }


    /**
     * Sets the codTiplan value for this WsPlanTarifarioOutDTO.
     * 
     * @param codTiplan
     */
    public void setCodTiplan(java.lang.String codTiplan) {
        this.codTiplan = codTiplan;
    }


    /**
     * Gets the desPlanTarif value for this WsPlanTarifarioOutDTO.
     * 
     * @return desPlanTarif
     */
    public java.lang.String getDesPlanTarif() {
        return desPlanTarif;
    }


    /**
     * Sets the desPlanTarif value for this WsPlanTarifarioOutDTO.
     * 
     * @param desPlanTarif
     */
    public void setDesPlanTarif(java.lang.String desPlanTarif) {
        this.desPlanTarif = desPlanTarif;
    }


    /**
     * Gets the numAbonados value for this WsPlanTarifarioOutDTO.
     * 
     * @return numAbonados
     */
    public java.lang.String getNumAbonados() {
        return numAbonados;
    }


    /**
     * Sets the numAbonados value for this WsPlanTarifarioOutDTO.
     * 
     * @param numAbonados
     */
    public void setNumAbonados(java.lang.String numAbonados) {
        this.numAbonados = numAbonados;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsPlanTarifarioOutDTO)) return false;
        WsPlanTarifarioOutDTO other = (WsPlanTarifarioOutDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codPlanTarif==null && other.getCodPlanTarif()==null) || 
             (this.codPlanTarif!=null &&
              this.codPlanTarif.equals(other.getCodPlanTarif()))) &&
            ((this.codTiplan==null && other.getCodTiplan()==null) || 
             (this.codTiplan!=null &&
              this.codTiplan.equals(other.getCodTiplan()))) &&
            ((this.desPlanTarif==null && other.getDesPlanTarif()==null) || 
             (this.desPlanTarif!=null &&
              this.desPlanTarif.equals(other.getDesPlanTarif()))) &&
            ((this.numAbonados==null && other.getNumAbonados()==null) || 
             (this.numAbonados!=null &&
              this.numAbonados.equals(other.getNumAbonados())));
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
        if (getCodPlanTarif() != null) {
            _hashCode += getCodPlanTarif().hashCode();
        }
        if (getCodTiplan() != null) {
            _hashCode += getCodTiplan().hashCode();
        }
        if (getDesPlanTarif() != null) {
            _hashCode += getDesPlanTarif().hashCode();
        }
        if (getNumAbonados() != null) {
            _hashCode += getNumAbonados().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsPlanTarifarioOutDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsPlanTarifarioOutDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codPlanTarif");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodPlanTarif"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codTiplan");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodTiplan"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("desPlanTarif");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "DesPlanTarif"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numAbonados");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumAbonados"));
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
