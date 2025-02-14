/**
 * DatosClienteDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com;

public class DatosClienteDTO  implements java.io.Serializable {
    private java.lang.String apellidoMaterno;

    private java.lang.String apellidoPaterno;

    private dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.ClienteDTO cliente;

    private int codCategoria;

    private int codError;

    private java.lang.String codigoTipIdentif;

    private java.lang.String descipcionTipIdentif;

    private java.lang.String descripcionCategoria;

    private dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.DireccionDTO direccionDTO;

    private java.lang.String msgError;

    private java.lang.String nomCliente;

    private int numEvento;

    private java.lang.String numIdent;

    public DatosClienteDTO() {
    }

    public DatosClienteDTO(
           java.lang.String apellidoMaterno,
           java.lang.String apellidoPaterno,
           dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.ClienteDTO cliente,
           int codCategoria,
           int codError,
           java.lang.String codigoTipIdentif,
           java.lang.String descipcionTipIdentif,
           java.lang.String descripcionCategoria,
           dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.DireccionDTO direccionDTO,
           java.lang.String msgError,
           java.lang.String nomCliente,
           int numEvento,
           java.lang.String numIdent) {
           this.apellidoMaterno = apellidoMaterno;
           this.apellidoPaterno = apellidoPaterno;
           this.cliente = cliente;
           this.codCategoria = codCategoria;
           this.codError = codError;
           this.codigoTipIdentif = codigoTipIdentif;
           this.descipcionTipIdentif = descipcionTipIdentif;
           this.descripcionCategoria = descripcionCategoria;
           this.direccionDTO = direccionDTO;
           this.msgError = msgError;
           this.nomCliente = nomCliente;
           this.numEvento = numEvento;
           this.numIdent = numIdent;
    }


    /**
     * Gets the apellidoMaterno value for this DatosClienteDTO.
     * 
     * @return apellidoMaterno
     */
    public java.lang.String getApellidoMaterno() {
        return apellidoMaterno;
    }


    /**
     * Sets the apellidoMaterno value for this DatosClienteDTO.
     * 
     * @param apellidoMaterno
     */
    public void setApellidoMaterno(java.lang.String apellidoMaterno) {
        this.apellidoMaterno = apellidoMaterno;
    }


    /**
     * Gets the apellidoPaterno value for this DatosClienteDTO.
     * 
     * @return apellidoPaterno
     */
    public java.lang.String getApellidoPaterno() {
        return apellidoPaterno;
    }


    /**
     * Sets the apellidoPaterno value for this DatosClienteDTO.
     * 
     * @param apellidoPaterno
     */
    public void setApellidoPaterno(java.lang.String apellidoPaterno) {
        this.apellidoPaterno = apellidoPaterno;
    }


    /**
     * Gets the cliente value for this DatosClienteDTO.
     * 
     * @return cliente
     */
    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.ClienteDTO getCliente() {
        return cliente;
    }


    /**
     * Sets the cliente value for this DatosClienteDTO.
     * 
     * @param cliente
     */
    public void setCliente(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.ClienteDTO cliente) {
        this.cliente = cliente;
    }


    /**
     * Gets the codCategoria value for this DatosClienteDTO.
     * 
     * @return codCategoria
     */
    public int getCodCategoria() {
        return codCategoria;
    }


    /**
     * Sets the codCategoria value for this DatosClienteDTO.
     * 
     * @param codCategoria
     */
    public void setCodCategoria(int codCategoria) {
        this.codCategoria = codCategoria;
    }


    /**
     * Gets the codError value for this DatosClienteDTO.
     * 
     * @return codError
     */
    public int getCodError() {
        return codError;
    }


    /**
     * Sets the codError value for this DatosClienteDTO.
     * 
     * @param codError
     */
    public void setCodError(int codError) {
        this.codError = codError;
    }


    /**
     * Gets the codigoTipIdentif value for this DatosClienteDTO.
     * 
     * @return codigoTipIdentif
     */
    public java.lang.String getCodigoTipIdentif() {
        return codigoTipIdentif;
    }


    /**
     * Sets the codigoTipIdentif value for this DatosClienteDTO.
     * 
     * @param codigoTipIdentif
     */
    public void setCodigoTipIdentif(java.lang.String codigoTipIdentif) {
        this.codigoTipIdentif = codigoTipIdentif;
    }


    /**
     * Gets the descipcionTipIdentif value for this DatosClienteDTO.
     * 
     * @return descipcionTipIdentif
     */
    public java.lang.String getDescipcionTipIdentif() {
        return descipcionTipIdentif;
    }


    /**
     * Sets the descipcionTipIdentif value for this DatosClienteDTO.
     * 
     * @param descipcionTipIdentif
     */
    public void setDescipcionTipIdentif(java.lang.String descipcionTipIdentif) {
        this.descipcionTipIdentif = descipcionTipIdentif;
    }


    /**
     * Gets the descripcionCategoria value for this DatosClienteDTO.
     * 
     * @return descripcionCategoria
     */
    public java.lang.String getDescripcionCategoria() {
        return descripcionCategoria;
    }


    /**
     * Sets the descripcionCategoria value for this DatosClienteDTO.
     * 
     * @param descripcionCategoria
     */
    public void setDescripcionCategoria(java.lang.String descripcionCategoria) {
        this.descripcionCategoria = descripcionCategoria;
    }


    /**
     * Gets the direccionDTO value for this DatosClienteDTO.
     * 
     * @return direccionDTO
     */
    public dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.DireccionDTO getDireccionDTO() {
        return direccionDTO;
    }


    /**
     * Sets the direccionDTO value for this DatosClienteDTO.
     * 
     * @param direccionDTO
     */
    public void setDireccionDTO(dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.DireccionDTO direccionDTO) {
        this.direccionDTO = direccionDTO;
    }


    /**
     * Gets the msgError value for this DatosClienteDTO.
     * 
     * @return msgError
     */
    public java.lang.String getMsgError() {
        return msgError;
    }


    /**
     * Sets the msgError value for this DatosClienteDTO.
     * 
     * @param msgError
     */
    public void setMsgError(java.lang.String msgError) {
        this.msgError = msgError;
    }


    /**
     * Gets the nomCliente value for this DatosClienteDTO.
     * 
     * @return nomCliente
     */
    public java.lang.String getNomCliente() {
        return nomCliente;
    }


    /**
     * Sets the nomCliente value for this DatosClienteDTO.
     * 
     * @param nomCliente
     */
    public void setNomCliente(java.lang.String nomCliente) {
        this.nomCliente = nomCliente;
    }


    /**
     * Gets the numEvento value for this DatosClienteDTO.
     * 
     * @return numEvento
     */
    public int getNumEvento() {
        return numEvento;
    }


    /**
     * Sets the numEvento value for this DatosClienteDTO.
     * 
     * @param numEvento
     */
    public void setNumEvento(int numEvento) {
        this.numEvento = numEvento;
    }


    /**
     * Gets the numIdent value for this DatosClienteDTO.
     * 
     * @return numIdent
     */
    public java.lang.String getNumIdent() {
        return numIdent;
    }


    /**
     * Sets the numIdent value for this DatosClienteDTO.
     * 
     * @param numIdent
     */
    public void setNumIdent(java.lang.String numIdent) {
        this.numIdent = numIdent;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof DatosClienteDTO)) return false;
        DatosClienteDTO other = (DatosClienteDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.apellidoMaterno==null && other.getApellidoMaterno()==null) || 
             (this.apellidoMaterno!=null &&
              this.apellidoMaterno.equals(other.getApellidoMaterno()))) &&
            ((this.apellidoPaterno==null && other.getApellidoPaterno()==null) || 
             (this.apellidoPaterno!=null &&
              this.apellidoPaterno.equals(other.getApellidoPaterno()))) &&
            ((this.cliente==null && other.getCliente()==null) || 
             (this.cliente!=null &&
              this.cliente.equals(other.getCliente()))) &&
            this.codCategoria == other.getCodCategoria() &&
            this.codError == other.getCodError() &&
            ((this.codigoTipIdentif==null && other.getCodigoTipIdentif()==null) || 
             (this.codigoTipIdentif!=null &&
              this.codigoTipIdentif.equals(other.getCodigoTipIdentif()))) &&
            ((this.descipcionTipIdentif==null && other.getDescipcionTipIdentif()==null) || 
             (this.descipcionTipIdentif!=null &&
              this.descipcionTipIdentif.equals(other.getDescipcionTipIdentif()))) &&
            ((this.descripcionCategoria==null && other.getDescripcionCategoria()==null) || 
             (this.descripcionCategoria!=null &&
              this.descripcionCategoria.equals(other.getDescripcionCategoria()))) &&
            ((this.direccionDTO==null && other.getDireccionDTO()==null) || 
             (this.direccionDTO!=null &&
              this.direccionDTO.equals(other.getDireccionDTO()))) &&
            ((this.msgError==null && other.getMsgError()==null) || 
             (this.msgError!=null &&
              this.msgError.equals(other.getMsgError()))) &&
            ((this.nomCliente==null && other.getNomCliente()==null) || 
             (this.nomCliente!=null &&
              this.nomCliente.equals(other.getNomCliente()))) &&
            this.numEvento == other.getNumEvento() &&
            ((this.numIdent==null && other.getNumIdent()==null) || 
             (this.numIdent!=null &&
              this.numIdent.equals(other.getNumIdent())));
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
        if (getApellidoMaterno() != null) {
            _hashCode += getApellidoMaterno().hashCode();
        }
        if (getApellidoPaterno() != null) {
            _hashCode += getApellidoPaterno().hashCode();
        }
        if (getCliente() != null) {
            _hashCode += getCliente().hashCode();
        }
        _hashCode += getCodCategoria();
        _hashCode += getCodError();
        if (getCodigoTipIdentif() != null) {
            _hashCode += getCodigoTipIdentif().hashCode();
        }
        if (getDescipcionTipIdentif() != null) {
            _hashCode += getDescipcionTipIdentif().hashCode();
        }
        if (getDescripcionCategoria() != null) {
            _hashCode += getDescripcionCategoria().hashCode();
        }
        if (getDireccionDTO() != null) {
            _hashCode += getDireccionDTO().hashCode();
        }
        if (getMsgError() != null) {
            _hashCode += getMsgError().hashCode();
        }
        if (getNomCliente() != null) {
            _hashCode += getNomCliente().hashCode();
        }
        _hashCode += getNumEvento();
        if (getNumIdent() != null) {
            _hashCode += getNumIdent().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(DatosClienteDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "DatosClienteDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("apellidoMaterno");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "ApellidoMaterno"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("apellidoPaterno");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "ApellidoPaterno"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("cliente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "Cliente"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "ClienteDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codCategoria");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "CodCategoria"));
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
        elemField.setFieldName("codigoTipIdentif");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "CodigoTipIdentif"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("descipcionTipIdentif");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "DescipcionTipIdentif"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("descripcionCategoria");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "DescripcionCategoria"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("direccionDTO");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "DireccionDTO"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "DireccionDTO"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("msgError");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "MsgError"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nomCliente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "NomCliente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numEvento");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "NumEvento"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numIdent");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "NumIdent"));
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
