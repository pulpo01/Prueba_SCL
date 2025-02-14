/**
 * WsLineaInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsLineaInDTO  implements java.io.Serializable {
    private java.lang.String codPrestacion;

    private java.lang.String codigoOperador;

    private dto.commonapp.scl.cl.tmmas.com.WsDatosPlanTerifarioInDTO datosPlanTerifario;

    private dto.commonapp.scl.cl.tmmas.com.WsHomeLineaInDTO homeLinea;

    private dto.commonapp.scl.cl.tmmas.com.WsSimcardInDTO simcard;

    private dto.commonapp.scl.cl.tmmas.com.WsTerminalInDTO terminal;

    private dto.commonapp.scl.cl.tmmas.com.WsUsuarioInDTO usuarioLinea;

    public WsLineaInDTO() {
    }

    public WsLineaInDTO(
           java.lang.String codPrestacion,
           java.lang.String codigoOperador,
           dto.commonapp.scl.cl.tmmas.com.WsDatosPlanTerifarioInDTO datosPlanTerifario,
           dto.commonapp.scl.cl.tmmas.com.WsHomeLineaInDTO homeLinea,
           dto.commonapp.scl.cl.tmmas.com.WsSimcardInDTO simcard,
           dto.commonapp.scl.cl.tmmas.com.WsTerminalInDTO terminal,
           dto.commonapp.scl.cl.tmmas.com.WsUsuarioInDTO usuarioLinea) {
           this.codPrestacion = codPrestacion;
           this.codigoOperador = codigoOperador;
           this.datosPlanTerifario = datosPlanTerifario;
           this.homeLinea = homeLinea;
           this.simcard = simcard;
           this.terminal = terminal;
           this.usuarioLinea = usuarioLinea;
    }


    /**
     * Gets the codPrestacion value for this WsLineaInDTO.
     * 
     * @return codPrestacion
     */
    public java.lang.String getCodPrestacion() {
        return codPrestacion;
    }


    /**
     * Sets the codPrestacion value for this WsLineaInDTO.
     * 
     * @param codPrestacion
     */
    public void setCodPrestacion(java.lang.String codPrestacion) {
        this.codPrestacion = codPrestacion;
    }


    /**
     * Gets the codigoOperador value for this WsLineaInDTO.
     * 
     * @return codigoOperador
     */
    public java.lang.String getCodigoOperador() {
        return codigoOperador;
    }


    /**
     * Sets the codigoOperador value for this WsLineaInDTO.
     * 
     * @param codigoOperador
     */
    public void setCodigoOperador(java.lang.String codigoOperador) {
        this.codigoOperador = codigoOperador;
    }


    /**
     * Gets the datosPlanTerifario value for this WsLineaInDTO.
     * 
     * @return datosPlanTerifario
     */
    public dto.commonapp.scl.cl.tmmas.com.WsDatosPlanTerifarioInDTO getDatosPlanTerifario() {
        return datosPlanTerifario;
    }


    /**
     * Sets the datosPlanTerifario value for this WsLineaInDTO.
     * 
     * @param datosPlanTerifario
     */
    public void setDatosPlanTerifario(dto.commonapp.scl.cl.tmmas.com.WsDatosPlanTerifarioInDTO datosPlanTerifario) {
        this.datosPlanTerifario = datosPlanTerifario;
    }


    /**
     * Gets the homeLinea value for this WsLineaInDTO.
     * 
     * @return homeLinea
     */
    public dto.commonapp.scl.cl.tmmas.com.WsHomeLineaInDTO getHomeLinea() {
        return homeLinea;
    }


    /**
     * Sets the homeLinea value for this WsLineaInDTO.
     * 
     * @param homeLinea
     */
    public void setHomeLinea(dto.commonapp.scl.cl.tmmas.com.WsHomeLineaInDTO homeLinea) {
        this.homeLinea = homeLinea;
    }


    /**
     * Gets the simcard value for this WsLineaInDTO.
     * 
     * @return simcard
     */
    public dto.commonapp.scl.cl.tmmas.com.WsSimcardInDTO getSimcard() {
        return simcard;
    }


    /**
     * Sets the simcard value for this WsLineaInDTO.
     * 
     * @param simcard
     */
    public void setSimcard(dto.commonapp.scl.cl.tmmas.com.WsSimcardInDTO simcard) {
        this.simcard = simcard;
    }


    /**
     * Gets the terminal value for this WsLineaInDTO.
     * 
     * @return terminal
     */
    public dto.commonapp.scl.cl.tmmas.com.WsTerminalInDTO getTerminal() {
        return terminal;
    }


    /**
     * Sets the terminal value for this WsLineaInDTO.
     * 
     * @param terminal
     */
    public void setTerminal(dto.commonapp.scl.cl.tmmas.com.WsTerminalInDTO terminal) {
        this.terminal = terminal;
    }


    /**
     * Gets the usuarioLinea value for this WsLineaInDTO.
     * 
     * @return usuarioLinea
     */
    public dto.commonapp.scl.cl.tmmas.com.WsUsuarioInDTO getUsuarioLinea() {
        return usuarioLinea;
    }


    /**
     * Sets the usuarioLinea value for this WsLineaInDTO.
     * 
     * @param usuarioLinea
     */
    public void setUsuarioLinea(dto.commonapp.scl.cl.tmmas.com.WsUsuarioInDTO usuarioLinea) {
        this.usuarioLinea = usuarioLinea;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsLineaInDTO)) return false;
        WsLineaInDTO other = (WsLineaInDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codPrestacion==null && other.getCodPrestacion()==null) || 
             (this.codPrestacion!=null &&
              this.codPrestacion.equals(other.getCodPrestacion()))) &&
            ((this.codigoOperador==null && other.getCodigoOperador()==null) || 
             (this.codigoOperador!=null &&
              this.codigoOperador.equals(other.getCodigoOperador()))) &&
            ((this.datosPlanTerifario==null && other.getDatosPlanTerifario()==null) || 
             (this.datosPlanTerifario!=null &&
              this.datosPlanTerifario.equals(other.getDatosPlanTerifario()))) &&
            ((this.homeLinea==null && other.getHomeLinea()==null) || 
             (this.homeLinea!=null &&
              this.homeLinea.equals(other.getHomeLinea()))) &&
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
        if (getCodPrestacion() != null) {
            _hashCode += getCodPrestacion().hashCode();
        }
        if (getCodigoOperador() != null) {
            _hashCode += getCodigoOperador().hashCode();
        }
        if (getDatosPlanTerifario() != null) {
            _hashCode += getDatosPlanTerifario().hashCode();
        }
        if (getHomeLinea() != null) {
            _hashCode += getHomeLinea().hashCode();
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
        new org.apache.axis.description.TypeDesc(WsLineaInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsLineaInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codPrestacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodPrestacion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoOperador");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodigoOperador"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("datosPlanTerifario");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "DatosPlanTerifario"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsDatosPlanTerifarioInDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("homeLinea");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "HomeLinea"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsHomeLineaInDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("simcard");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "Simcard"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsSimcardInDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("terminal");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "Terminal"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsTerminalInDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("usuarioLinea");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "UsuarioLinea"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsUsuarioInDTO"));
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
