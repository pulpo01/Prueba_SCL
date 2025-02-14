/**
 * WSCentralQuioscoOutDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.gestiondeabonados.scl.cl.tmmas.com;

public class WSCentralQuioscoOutDTO  implements java.io.Serializable {
    private dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.CentralDTO[] centralDTOs;

    private java.lang.String codError;

    private java.lang.String msgError;

    private java.lang.String numEvento;

    public WSCentralQuioscoOutDTO() {
    }

    public WSCentralQuioscoOutDTO(
           dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.CentralDTO[] centralDTOs,
           java.lang.String codError,
           java.lang.String msgError,
           java.lang.String numEvento) {
           this.centralDTOs = centralDTOs;
           this.codError = codError;
           this.msgError = msgError;
           this.numEvento = numEvento;
    }


    /**
     * Gets the centralDTOs value for this WSCentralQuioscoOutDTO.
     * 
     * @return centralDTOs
     */
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.CentralDTO[] getCentralDTOs() {
        return centralDTOs;
    }


    /**
     * Sets the centralDTOs value for this WSCentralQuioscoOutDTO.
     * 
     * @param centralDTOs
     */
    public void setCentralDTOs(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.CentralDTO[] centralDTOs) {
        this.centralDTOs = centralDTOs;
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.CentralDTO getCentralDTOs(int i) {
        return this.centralDTOs[i];
    }

    public void setCentralDTOs(int i, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.CentralDTO _value) {
        this.centralDTOs[i] = _value;
    }


    /**
     * Gets the codError value for this WSCentralQuioscoOutDTO.
     * 
     * @return codError
     */
    public java.lang.String getCodError() {
        return codError;
    }


    /**
     * Sets the codError value for this WSCentralQuioscoOutDTO.
     * 
     * @param codError
     */
    public void setCodError(java.lang.String codError) {
        this.codError = codError;
    }


    /**
     * Gets the msgError value for this WSCentralQuioscoOutDTO.
     * 
     * @return msgError
     */
    public java.lang.String getMsgError() {
        return msgError;
    }


    /**
     * Sets the msgError value for this WSCentralQuioscoOutDTO.
     * 
     * @param msgError
     */
    public void setMsgError(java.lang.String msgError) {
        this.msgError = msgError;
    }


    /**
     * Gets the numEvento value for this WSCentralQuioscoOutDTO.
     * 
     * @return numEvento
     */
    public java.lang.String getNumEvento() {
        return numEvento;
    }


    /**
     * Sets the numEvento value for this WSCentralQuioscoOutDTO.
     * 
     * @param numEvento
     */
    public void setNumEvento(java.lang.String numEvento) {
        this.numEvento = numEvento;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WSCentralQuioscoOutDTO)) return false;
        WSCentralQuioscoOutDTO other = (WSCentralQuioscoOutDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.centralDTOs==null && other.getCentralDTOs()==null) || 
             (this.centralDTOs!=null &&
              java.util.Arrays.equals(this.centralDTOs, other.getCentralDTOs()))) &&
            ((this.codError==null && other.getCodError()==null) || 
             (this.codError!=null &&
              this.codError.equals(other.getCodError()))) &&
            ((this.msgError==null && other.getMsgError()==null) || 
             (this.msgError!=null &&
              this.msgError.equals(other.getMsgError()))) &&
            ((this.numEvento==null && other.getNumEvento()==null) || 
             (this.numEvento!=null &&
              this.numEvento.equals(other.getNumEvento())));
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
        if (getCentralDTOs() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getCentralDTOs());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getCentralDTOs(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getCodError() != null) {
            _hashCode += getCodError().hashCode();
        }
        if (getMsgError() != null) {
            _hashCode += getMsgError().hashCode();
        }
        if (getNumEvento() != null) {
            _hashCode += getNumEvento().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WSCentralQuioscoOutDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "WSCentralQuioscoOutDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("centralDTOs");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "CentralDTOs"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CentralDTO"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codError");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "CodError"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("msgError");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "MsgError"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numEvento");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "NumEvento"));
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
