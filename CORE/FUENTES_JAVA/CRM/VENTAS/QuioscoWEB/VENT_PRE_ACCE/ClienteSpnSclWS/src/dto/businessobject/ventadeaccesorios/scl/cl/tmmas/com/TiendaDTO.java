/**
 * TiendaDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com;

public class TiendaDTO  implements java.io.Serializable {
    private java.lang.String codCaja;

    private java.lang.String codCliente;

    private java.lang.String codTienda;

    private java.lang.String desCaja;

    private java.lang.String desTienda;

    private java.lang.String indApliPago;

    private java.lang.String nomUsuario;

    private java.lang.String nomUsuarioCajero;

    private java.lang.String nomUsuarioVendedor;

    public TiendaDTO() {
    }

    public TiendaDTO(
           java.lang.String codCaja,
           java.lang.String codCliente,
           java.lang.String codTienda,
           java.lang.String desCaja,
           java.lang.String desTienda,
           java.lang.String indApliPago,
           java.lang.String nomUsuario,
           java.lang.String nomUsuarioCajero,
           java.lang.String nomUsuarioVendedor) {
           this.codCaja = codCaja;
           this.codCliente = codCliente;
           this.codTienda = codTienda;
           this.desCaja = desCaja;
           this.desTienda = desTienda;
           this.indApliPago = indApliPago;
           this.nomUsuario = nomUsuario;
           this.nomUsuarioCajero = nomUsuarioCajero;
           this.nomUsuarioVendedor = nomUsuarioVendedor;
    }


    /**
     * Gets the codCaja value for this TiendaDTO.
     * 
     * @return codCaja
     */
    public java.lang.String getCodCaja() {
        return codCaja;
    }


    /**
     * Sets the codCaja value for this TiendaDTO.
     * 
     * @param codCaja
     */
    public void setCodCaja(java.lang.String codCaja) {
        this.codCaja = codCaja;
    }


    /**
     * Gets the codCliente value for this TiendaDTO.
     * 
     * @return codCliente
     */
    public java.lang.String getCodCliente() {
        return codCliente;
    }


    /**
     * Sets the codCliente value for this TiendaDTO.
     * 
     * @param codCliente
     */
    public void setCodCliente(java.lang.String codCliente) {
        this.codCliente = codCliente;
    }


    /**
     * Gets the codTienda value for this TiendaDTO.
     * 
     * @return codTienda
     */
    public java.lang.String getCodTienda() {
        return codTienda;
    }


    /**
     * Sets the codTienda value for this TiendaDTO.
     * 
     * @param codTienda
     */
    public void setCodTienda(java.lang.String codTienda) {
        this.codTienda = codTienda;
    }


    /**
     * Gets the desCaja value for this TiendaDTO.
     * 
     * @return desCaja
     */
    public java.lang.String getDesCaja() {
        return desCaja;
    }


    /**
     * Sets the desCaja value for this TiendaDTO.
     * 
     * @param desCaja
     */
    public void setDesCaja(java.lang.String desCaja) {
        this.desCaja = desCaja;
    }


    /**
     * Gets the desTienda value for this TiendaDTO.
     * 
     * @return desTienda
     */
    public java.lang.String getDesTienda() {
        return desTienda;
    }


    /**
     * Sets the desTienda value for this TiendaDTO.
     * 
     * @param desTienda
     */
    public void setDesTienda(java.lang.String desTienda) {
        this.desTienda = desTienda;
    }


    /**
     * Gets the indApliPago value for this TiendaDTO.
     * 
     * @return indApliPago
     */
    public java.lang.String getIndApliPago() {
        return indApliPago;
    }


    /**
     * Sets the indApliPago value for this TiendaDTO.
     * 
     * @param indApliPago
     */
    public void setIndApliPago(java.lang.String indApliPago) {
        this.indApliPago = indApliPago;
    }


    /**
     * Gets the nomUsuario value for this TiendaDTO.
     * 
     * @return nomUsuario
     */
    public java.lang.String getNomUsuario() {
        return nomUsuario;
    }


    /**
     * Sets the nomUsuario value for this TiendaDTO.
     * 
     * @param nomUsuario
     */
    public void setNomUsuario(java.lang.String nomUsuario) {
        this.nomUsuario = nomUsuario;
    }


    /**
     * Gets the nomUsuarioCajero value for this TiendaDTO.
     * 
     * @return nomUsuarioCajero
     */
    public java.lang.String getNomUsuarioCajero() {
        return nomUsuarioCajero;
    }


    /**
     * Sets the nomUsuarioCajero value for this TiendaDTO.
     * 
     * @param nomUsuarioCajero
     */
    public void setNomUsuarioCajero(java.lang.String nomUsuarioCajero) {
        this.nomUsuarioCajero = nomUsuarioCajero;
    }


    /**
     * Gets the nomUsuarioVendedor value for this TiendaDTO.
     * 
     * @return nomUsuarioVendedor
     */
    public java.lang.String getNomUsuarioVendedor() {
        return nomUsuarioVendedor;
    }


    /**
     * Sets the nomUsuarioVendedor value for this TiendaDTO.
     * 
     * @param nomUsuarioVendedor
     */
    public void setNomUsuarioVendedor(java.lang.String nomUsuarioVendedor) {
        this.nomUsuarioVendedor = nomUsuarioVendedor;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof TiendaDTO)) return false;
        TiendaDTO other = (TiendaDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codCaja==null && other.getCodCaja()==null) || 
             (this.codCaja!=null &&
              this.codCaja.equals(other.getCodCaja()))) &&
            ((this.codCliente==null && other.getCodCliente()==null) || 
             (this.codCliente!=null &&
              this.codCliente.equals(other.getCodCliente()))) &&
            ((this.codTienda==null && other.getCodTienda()==null) || 
             (this.codTienda!=null &&
              this.codTienda.equals(other.getCodTienda()))) &&
            ((this.desCaja==null && other.getDesCaja()==null) || 
             (this.desCaja!=null &&
              this.desCaja.equals(other.getDesCaja()))) &&
            ((this.desTienda==null && other.getDesTienda()==null) || 
             (this.desTienda!=null &&
              this.desTienda.equals(other.getDesTienda()))) &&
            ((this.indApliPago==null && other.getIndApliPago()==null) || 
             (this.indApliPago!=null &&
              this.indApliPago.equals(other.getIndApliPago()))) &&
            ((this.nomUsuario==null && other.getNomUsuario()==null) || 
             (this.nomUsuario!=null &&
              this.nomUsuario.equals(other.getNomUsuario()))) &&
            ((this.nomUsuarioCajero==null && other.getNomUsuarioCajero()==null) || 
             (this.nomUsuarioCajero!=null &&
              this.nomUsuarioCajero.equals(other.getNomUsuarioCajero()))) &&
            ((this.nomUsuarioVendedor==null && other.getNomUsuarioVendedor()==null) || 
             (this.nomUsuarioVendedor!=null &&
              this.nomUsuarioVendedor.equals(other.getNomUsuarioVendedor())));
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
        if (getCodCaja() != null) {
            _hashCode += getCodCaja().hashCode();
        }
        if (getCodCliente() != null) {
            _hashCode += getCodCliente().hashCode();
        }
        if (getCodTienda() != null) {
            _hashCode += getCodTienda().hashCode();
        }
        if (getDesCaja() != null) {
            _hashCode += getDesCaja().hashCode();
        }
        if (getDesTienda() != null) {
            _hashCode += getDesTienda().hashCode();
        }
        if (getIndApliPago() != null) {
            _hashCode += getIndApliPago().hashCode();
        }
        if (getNomUsuario() != null) {
            _hashCode += getNomUsuario().hashCode();
        }
        if (getNomUsuarioCajero() != null) {
            _hashCode += getNomUsuarioCajero().hashCode();
        }
        if (getNomUsuarioVendedor() != null) {
            _hashCode += getNomUsuarioVendedor().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(TiendaDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "TiendaDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codCaja");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "CodCaja"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codCliente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "CodCliente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codTienda");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "CodTienda"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("desCaja");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "DesCaja"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("desTienda");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "DesTienda"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indApliPago");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "IndApliPago"));
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
        elemField.setFieldName("nomUsuarioCajero");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "NomUsuarioCajero"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nomUsuarioVendedor");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto", "NomUsuarioVendedor"));
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
