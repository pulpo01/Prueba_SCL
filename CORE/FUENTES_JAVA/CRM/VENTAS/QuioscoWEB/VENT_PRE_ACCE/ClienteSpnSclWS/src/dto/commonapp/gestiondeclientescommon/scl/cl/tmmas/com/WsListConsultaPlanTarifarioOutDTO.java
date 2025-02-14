/**
 * WsListConsultaPlanTarifarioOutDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com;

public class WsListConsultaPlanTarifarioOutDTO  extends dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RetornoDTO  implements java.io.Serializable {
    private java.lang.String resultadoTransaccion;

    private dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsConsultaPlanTarifarioOutDTO[] wsConsultaPlanTarifarioArrOutDTO;

    public WsListConsultaPlanTarifarioOutDTO() {
    }

    public WsListConsultaPlanTarifarioOutDTO(
           java.lang.String codError,
           java.lang.String mensajseError,
           java.lang.String resultadoTransaccion,
           dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsConsultaPlanTarifarioOutDTO[] wsConsultaPlanTarifarioArrOutDTO) {
        super(
            codError,
            mensajseError);
        this.resultadoTransaccion = resultadoTransaccion;
        this.wsConsultaPlanTarifarioArrOutDTO = wsConsultaPlanTarifarioArrOutDTO;
    }


    /**
     * Gets the resultadoTransaccion value for this WsListConsultaPlanTarifarioOutDTO.
     * 
     * @return resultadoTransaccion
     */
    public java.lang.String getResultadoTransaccion() {
        return resultadoTransaccion;
    }


    /**
     * Sets the resultadoTransaccion value for this WsListConsultaPlanTarifarioOutDTO.
     * 
     * @param resultadoTransaccion
     */
    public void setResultadoTransaccion(java.lang.String resultadoTransaccion) {
        this.resultadoTransaccion = resultadoTransaccion;
    }


    /**
     * Gets the wsConsultaPlanTarifarioArrOutDTO value for this WsListConsultaPlanTarifarioOutDTO.
     * 
     * @return wsConsultaPlanTarifarioArrOutDTO
     */
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsConsultaPlanTarifarioOutDTO[] getWsConsultaPlanTarifarioArrOutDTO() {
        return wsConsultaPlanTarifarioArrOutDTO;
    }


    /**
     * Sets the wsConsultaPlanTarifarioArrOutDTO value for this WsListConsultaPlanTarifarioOutDTO.
     * 
     * @param wsConsultaPlanTarifarioArrOutDTO
     */
    public void setWsConsultaPlanTarifarioArrOutDTO(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsConsultaPlanTarifarioOutDTO[] wsConsultaPlanTarifarioArrOutDTO) {
        this.wsConsultaPlanTarifarioArrOutDTO = wsConsultaPlanTarifarioArrOutDTO;
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsConsultaPlanTarifarioOutDTO getWsConsultaPlanTarifarioArrOutDTO(int i) {
        return this.wsConsultaPlanTarifarioArrOutDTO[i];
    }

    public void setWsConsultaPlanTarifarioArrOutDTO(int i, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.WsConsultaPlanTarifarioOutDTO _value) {
        this.wsConsultaPlanTarifarioArrOutDTO[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsListConsultaPlanTarifarioOutDTO)) return false;
        WsListConsultaPlanTarifarioOutDTO other = (WsListConsultaPlanTarifarioOutDTO) obj;
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
            ((this.wsConsultaPlanTarifarioArrOutDTO==null && other.getWsConsultaPlanTarifarioArrOutDTO()==null) || 
             (this.wsConsultaPlanTarifarioArrOutDTO!=null &&
              java.util.Arrays.equals(this.wsConsultaPlanTarifarioArrOutDTO, other.getWsConsultaPlanTarifarioArrOutDTO())));
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
        if (getWsConsultaPlanTarifarioArrOutDTO() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getWsConsultaPlanTarifarioArrOutDTO());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getWsConsultaPlanTarifarioArrOutDTO(), i);
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
        new org.apache.axis.description.TypeDesc(WsListConsultaPlanTarifarioOutDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsListConsultaPlanTarifarioOutDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("resultadoTransaccion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "ResultadoTransaccion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("wsConsultaPlanTarifarioArrOutDTO");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsConsultaPlanTarifarioArrOutDTO"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsConsultaPlanTarifarioOutDTO"));
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
