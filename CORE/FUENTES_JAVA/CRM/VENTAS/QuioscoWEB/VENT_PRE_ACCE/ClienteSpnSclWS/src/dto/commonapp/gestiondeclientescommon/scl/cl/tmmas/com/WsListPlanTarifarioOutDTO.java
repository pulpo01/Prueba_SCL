/**
 * WsListPlanTarifarioOutDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com;

public class WsListPlanTarifarioOutDTO  extends dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO  implements java.io.Serializable {
    private java.lang.String resultadoTransaccion;

    private dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsPlanTarifarioOutDTO[] wsPlanTarifarioArrOutDTO;

    public WsListPlanTarifarioOutDTO() {
    }

    public WsListPlanTarifarioOutDTO(
           java.lang.String codError,
           java.lang.String mensajseError,
           java.lang.String resultadoTransaccion,
           dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsPlanTarifarioOutDTO[] wsPlanTarifarioArrOutDTO) {
        super(
            codError,
            mensajseError);
        this.resultadoTransaccion = resultadoTransaccion;
        this.wsPlanTarifarioArrOutDTO = wsPlanTarifarioArrOutDTO;
    }


    /**
     * Gets the resultadoTransaccion value for this WsListPlanTarifarioOutDTO.
     * 
     * @return resultadoTransaccion
     */
    public java.lang.String getResultadoTransaccion() {
        return resultadoTransaccion;
    }


    /**
     * Sets the resultadoTransaccion value for this WsListPlanTarifarioOutDTO.
     * 
     * @param resultadoTransaccion
     */
    public void setResultadoTransaccion(java.lang.String resultadoTransaccion) {
        this.resultadoTransaccion = resultadoTransaccion;
    }


    /**
     * Gets the wsPlanTarifarioArrOutDTO value for this WsListPlanTarifarioOutDTO.
     * 
     * @return wsPlanTarifarioArrOutDTO
     */
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsPlanTarifarioOutDTO[] getWsPlanTarifarioArrOutDTO() {
        return wsPlanTarifarioArrOutDTO;
    }


    /**
     * Sets the wsPlanTarifarioArrOutDTO value for this WsListPlanTarifarioOutDTO.
     * 
     * @param wsPlanTarifarioArrOutDTO
     */
    public void setWsPlanTarifarioArrOutDTO(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsPlanTarifarioOutDTO[] wsPlanTarifarioArrOutDTO) {
        this.wsPlanTarifarioArrOutDTO = wsPlanTarifarioArrOutDTO;
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsPlanTarifarioOutDTO getWsPlanTarifarioArrOutDTO(int i) {
        return this.wsPlanTarifarioArrOutDTO[i];
    }

    public void setWsPlanTarifarioArrOutDTO(int i, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsPlanTarifarioOutDTO _value) {
        this.wsPlanTarifarioArrOutDTO[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsListPlanTarifarioOutDTO)) return false;
        WsListPlanTarifarioOutDTO other = (WsListPlanTarifarioOutDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = super.equals(obj) && 
            ((this.resultadoTransaccion==null && other.getResultadoTransaccion()==null) || 
             (this.resultadoTransaccion!=null &&
              this.resultadoTransaccion.equals(other.getResultadoTransaccion()))) &&
            ((this.wsPlanTarifarioArrOutDTO==null && other.getWsPlanTarifarioArrOutDTO()==null) || 
             (this.wsPlanTarifarioArrOutDTO!=null &&
              java.util.Arrays.equals(this.wsPlanTarifarioArrOutDTO, other.getWsPlanTarifarioArrOutDTO())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = super.hashCode();
        if (getResultadoTransaccion() != null) {
            _hashCode += getResultadoTransaccion().hashCode();
        }
        if (getWsPlanTarifarioArrOutDTO() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getWsPlanTarifarioArrOutDTO());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getWsPlanTarifarioArrOutDTO(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsListPlanTarifarioOutDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListPlanTarifarioOutDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("resultadoTransaccion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "ResultadoTransaccion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("wsPlanTarifarioArrOutDTO");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsPlanTarifarioArrOutDTO"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsPlanTarifarioOutDTO"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        elemField.setMaxOccursUnbounded(true);
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
