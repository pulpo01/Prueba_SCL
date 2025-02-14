/**
 * WsDatosPlanTerifarioInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsDatosPlanTerifarioInDTO  implements java.io.Serializable {
    private java.lang.String planTarifario;

    public WsDatosPlanTerifarioInDTO() {
    }

    public WsDatosPlanTerifarioInDTO(
           java.lang.String planTarifario) {
           this.planTarifario = planTarifario;
    }


    /**
     * Gets the planTarifario value for this WsDatosPlanTerifarioInDTO.
     * 
     * @return planTarifario
     */
    public java.lang.String getPlanTarifario() {
        return planTarifario;
    }


    /**
     * Sets the planTarifario value for this WsDatosPlanTerifarioInDTO.
     * 
     * @param planTarifario
     */
    public void setPlanTarifario(java.lang.String planTarifario) {
        this.planTarifario = planTarifario;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsDatosPlanTerifarioInDTO)) return false;
        WsDatosPlanTerifarioInDTO other = (WsDatosPlanTerifarioInDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.planTarifario==null && other.getPlanTarifario()==null) || 
             (this.planTarifario!=null &&
              this.planTarifario.equals(other.getPlanTarifario())));
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
        if (getPlanTarifario() != null) {
            _hashCode += getPlanTarifario().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsDatosPlanTerifarioInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsDatosPlanTerifarioInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("planTarifario");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "PlanTarifario"));
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
