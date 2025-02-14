/**
 * WsStructuraLineaDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.quiosco.spnsclwscommon.scl.cl.tmmas.com;

public class WsStructuraLineaDTO  implements java.io.Serializable {
    private java.lang.String codigoCentral;

    private dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraSimcardDTO simcard;

    private dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraTerminalDTO terminal;

    private dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraUsuarioLineaDTO usuarioLinea;

    public WsStructuraLineaDTO() {
    }

    public WsStructuraLineaDTO(
           java.lang.String codigoCentral,
           dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraSimcardDTO simcard,
           dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraTerminalDTO terminal,
           dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraUsuarioLineaDTO usuarioLinea) {
           this.codigoCentral = codigoCentral;
           this.simcard = simcard;
           this.terminal = terminal;
           this.usuarioLinea = usuarioLinea;
    }


    /**
     * Gets the codigoCentral value for this WsStructuraLineaDTO.
     * 
     * @return codigoCentral
     */
    public java.lang.String getCodigoCentral() {
        return codigoCentral;
    }


    /**
     * Sets the codigoCentral value for this WsStructuraLineaDTO.
     * 
     * @param codigoCentral
     */
    public void setCodigoCentral(java.lang.String codigoCentral) {
        this.codigoCentral = codigoCentral;
    }


    /**
     * Gets the simcard value for this WsStructuraLineaDTO.
     * 
     * @return simcard
     */
    public dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraSimcardDTO getSimcard() {
        return simcard;
    }


    /**
     * Sets the simcard value for this WsStructuraLineaDTO.
     * 
     * @param simcard
     */
    public void setSimcard(dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraSimcardDTO simcard) {
        this.simcard = simcard;
    }


    /**
     * Gets the terminal value for this WsStructuraLineaDTO.
     * 
     * @return terminal
     */
    public dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraTerminalDTO getTerminal() {
        return terminal;
    }


    /**
     * Sets the terminal value for this WsStructuraLineaDTO.
     * 
     * @param terminal
     */
    public void setTerminal(dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraTerminalDTO terminal) {
        this.terminal = terminal;
    }


    /**
     * Gets the usuarioLinea value for this WsStructuraLineaDTO.
     * 
     * @return usuarioLinea
     */
    public dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraUsuarioLineaDTO getUsuarioLinea() {
        return usuarioLinea;
    }


    /**
     * Sets the usuarioLinea value for this WsStructuraLineaDTO.
     * 
     * @param usuarioLinea
     */
    public void setUsuarioLinea(dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraUsuarioLineaDTO usuarioLinea) {
        this.usuarioLinea = usuarioLinea;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsStructuraLineaDTO)) return false;
        WsStructuraLineaDTO other = (WsStructuraLineaDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codigoCentral==null && other.getCodigoCentral()==null) || 
             (this.codigoCentral!=null &&
              this.codigoCentral.equals(other.getCodigoCentral()))) &&
            ((this.simcard==null && other.getSimcard()==null) || 
             (this.simcard!=null &&
              this.simcard.equals(other.getSimcard()))) &&
            ((this.terminal==null && other.getTerminal()==null) || 
             (this.terminal!=null &&
              this.terminal.equals(other.getTerminal()))) &&
            ((this.usuarioLinea==null && other.getUsuarioLinea()==null) || 
             (this.usuarioLinea!=null &&
              this.usuarioLinea.equals(other.getUsuarioLinea())));
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
        if (getCodigoCentral() != null) {
            _hashCode += getCodigoCentral().hashCode();
        }
        if (getSimcard() != null) {
            _hashCode += getSimcard().hashCode();
        }
        if (getTerminal() != null) {
            _hashCode += getTerminal().hashCode();
        }
        if (getUsuarioLinea() != null) {
            _hashCode += getUsuarioLinea().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsStructuraLineaDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraLineaDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCentral");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "CodigoCentral"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("simcard");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "Simcard"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraSimcardDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("terminal");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "Terminal"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraTerminalDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("usuarioLinea");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "UsuarioLinea"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.spnsclwscommon.quiosco.dto", "WsStructuraUsuarioLineaDTO"));
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
