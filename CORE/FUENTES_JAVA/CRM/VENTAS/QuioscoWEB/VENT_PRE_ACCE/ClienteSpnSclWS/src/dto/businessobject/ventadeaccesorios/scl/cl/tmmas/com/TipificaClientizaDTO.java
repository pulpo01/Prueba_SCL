/**
 * TipificaClientizaDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com;

public class TipificaClientizaDTO  implements java.io.Serializable {
    private int codArticulo;

    private int codError;

    private java.lang.String codTipificacion;

    private java.lang.String desTipificacion;

    private int flagClientizable;

    private java.lang.String msgError;

    private java.lang.String nomUsuario;

    private int numEvento;

    public TipificaClientizaDTO() {
    }

    public TipificaClientizaDTO(
           int codArticulo,
           int codError,
           java.lang.String codTipificacion,
           java.lang.String desTipificacion,
           int flagClientizable,
           java.lang.String msgError,
           java.lang.String nomUsuario,
           int numEvento) {
           this.codArticulo = codArticulo;
           this.codError = codError;
           this.codTipificacion = codTipificacion;
           this.desTipificacion = desTipificacion;
           this.flagClientizable = flagClientizable;
           this.msgError = msgError;
           this.nomUsuario = nomUsuario;
           this.numEvento = numEvento;
    }


    /**
     * Gets the codArticulo value for this TipificaClientizaDTO.
     * 
     * @return codArticulo
     */
    public int getCodArticulo() {
        return codArticulo;
    }


    /**
     * Sets the codArticulo value for this TipificaClientizaDTO.
     * 
     * @param codArticulo
     */
    public void setCodArticulo(int codArticulo) {
        this.codArticulo = codArticulo;
    }


    /**
     * Gets the codError value for this TipificaClientizaDTO.
     * 
     * @return codError
     */
    public int getCodError() {
        return codError;
    }


    /**
     * Sets the codError value for this TipificaClientizaDTO.
     * 
     * @param codError
     */
    public void setCodError(int codError) {
        this.codError = codError;
    }


    /**
     * Gets the codTipificacion value for this TipificaClientizaDTO.
     * 
     * @return codTipificacion
     */
    public java.lang.String getCodTipificacion() {
        return codTipificacion;
    }


    /**
     * Sets the codTipificacion value for this TipificaClientizaDTO.
     * 
     * @param codTipificacion
     */
    public void setCodTipificacion(java.lang.String codTipificacion) {
        this.codTipificacion = codTipificacion;
    }


    /**
     * Gets the desTipificacion value for this TipificaClientizaDTO.
     * 
     * @return desTipificacion
     */
    public java.lang.String getDesTipificacion() {
        return desTipificacion;
    }


    /**
     * Sets the desTipificacion value for this TipificaClientizaDTO.
     * 
     * @param desTipificacion
     */
    public void setDesTipificacion(java.lang.String desTipificacion) {
        this.desTipificacion = desTipificacion;
    }


    /**
     * Gets the flagClientizable value for this TipificaClientizaDTO.
     * 
     * @return flagClientizable
     */
    public int getFlagClientizable() {
        return flagClientizable;
    }


    /**
     * Sets the flagClientizable value for this TipificaClientizaDTO.
     * 
     * @param flagClientizable
     */
    public void setFlagClientizable(int flagClientizable) {
        this.flagClientizable = flagClientizable;
    }


    /**
     * Gets the msgError value for this TipificaClientizaDTO.
     * 
     * @return msgError
     */
    public java.lang.String getMsgError() {
        return msgError;
    }


    /**
     * Sets the msgError value for this TipificaClientizaDTO.
     * 
     * @param msgError
     */
    public void setMsgError(java.lang.String msgError) {
        this.msgError = msgError;
    }


    /**
     * Gets the nomUsuario value for this TipificaClientizaDTO.
     * 
     * @return nomUsuario
     */
    public java.lang.String getNomUsuario() {
        return nomUsuario;
    }


    /**
     * Sets the nomUsuario value for this TipificaClientizaDTO.
     * 
     * @param nomUsuario
     */
    public void setNomUsuario(java.lang.String nomUsuario) {
        this.nomUsuario = nomUsuario;
    }


    /**
     * Gets the numEvento value for this TipificaClientizaDTO.
     * 
     * @return numEvento
     */
    public int getNumEvento() {
        return numEvento;
    }


    /**
     * Sets the numEvento value for this TipificaClientizaDTO.
     * 
     * @param numEvento
     */
    public void setNumEvento(int numEvento) {
        this.numEvento = numEvento;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof TipificaClientizaDTO)) return false;
        TipificaClientizaDTO other = (TipificaClientizaDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            this.codArticulo == other.getCodArticulo() &&
            this.codError == other.getCodError() &&
            ((this.codTipificacion==null && other.getCodTipificacion()==null) || 
             (this.codTipificacion!=null &&
              this.codTipificacion.equals(other.getCodTipificacion()))) &&
            ((this.desTipificacion==null && other.getDesTipificacion()==null) || 
             (this.desTipificacion!=null &&
              this.desTipificacion.equals(other.getDesTipificacion()))) &&
            this.flagClientizable == other.getFlagClientizable() &&
            ((this.msgError==null && other.getMsgError()==null) || 
             (this.msgError!=null &&
              this.msgError.equals(other.getMsgError()))) &&
            ((this.nomUsuario==null && other.getNomUsuario()==null) || 
             (this.nomUsuario!=null &&
              this.nomUsuario.equals(other.getNomUsuario()))) &&
            this.numEvento == other.getNumEvento();
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
        _hashCode += getCodArticulo();
        _hashCode += getCodError();
        if (getCodTipificacion() != null) {
            _hashCode += getCodTipificacion().hashCode();
        }
        if (getDesTipificacion() != null) {
            _hashCode += getDesTipificacion().hashCode();
        }
        _hashCode += getFlagClientizable();
        if (getMsgError() != null) {
            _hashCode += getMsgError().hashCode();
        }
        if (getNomUsuario() != null) {
            _hashCode += getNomUsuario().hashCode();
        }
        _hashCode += getNumEvento();
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(TipificaClientizaDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "TipificaClientizaDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codArticulo");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "CodArticulo"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codError");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "CodError"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codTipificacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "CodTipificacion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("desTipificacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "DesTipificacion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("flagClientizable");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "FlagClientizable"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("msgError");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "MsgError"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nomUsuario");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "NomUsuario"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numEvento");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "NumEvento"));
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
