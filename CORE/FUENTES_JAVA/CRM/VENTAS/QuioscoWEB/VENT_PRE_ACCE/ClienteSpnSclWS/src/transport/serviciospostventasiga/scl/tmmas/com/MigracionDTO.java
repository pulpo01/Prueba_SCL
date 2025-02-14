/**
 * MigracionDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package transport.serviciospostventasiga.scl.tmmas.com;

public class MigracionDTO  implements java.io.Serializable {
    private java.lang.Long codCliente;

    private java.lang.String codOficina;

    private java.lang.String codPlanTarif;

    private java.lang.String imei;

    private java.lang.String indProcEqTerminal;

    private java.lang.String nomUsuarioVendedor;

    private java.lang.Long numCelular;

    public MigracionDTO() {
    }

    public MigracionDTO(
           java.lang.Long codCliente,
           java.lang.String codOficina,
           java.lang.String codPlanTarif,
           java.lang.String imei,
           java.lang.String indProcEqTerminal,
           java.lang.String nomUsuarioVendedor,
           java.lang.Long numCelular) {
           this.codCliente = codCliente;
           this.codOficina = codOficina;
           this.codPlanTarif = codPlanTarif;
           this.imei = imei;
           this.indProcEqTerminal = indProcEqTerminal;
           this.nomUsuarioVendedor = nomUsuarioVendedor;
           this.numCelular = numCelular;
    }


    /**
     * Gets the codCliente value for this MigracionDTO.
     * 
     * @return codCliente
     */
    public java.lang.Long getCodCliente() {
        return codCliente;
    }


    /**
     * Sets the codCliente value for this MigracionDTO.
     * 
     * @param codCliente
     */
    public void setCodCliente(java.lang.Long codCliente) {
        this.codCliente = codCliente;
    }


    /**
     * Gets the codOficina value for this MigracionDTO.
     * 
     * @return codOficina
     */
    public java.lang.String getCodOficina() {
        return codOficina;
    }


    /**
     * Sets the codOficina value for this MigracionDTO.
     * 
     * @param codOficina
     */
    public void setCodOficina(java.lang.String codOficina) {
        this.codOficina = codOficina;
    }


    /**
     * Gets the codPlanTarif value for this MigracionDTO.
     * 
     * @return codPlanTarif
     */
    public java.lang.String getCodPlanTarif() {
        return codPlanTarif;
    }


    /**
     * Sets the codPlanTarif value for this MigracionDTO.
     * 
     * @param codPlanTarif
     */
    public void setCodPlanTarif(java.lang.String codPlanTarif) {
        this.codPlanTarif = codPlanTarif;
    }


    /**
     * Gets the imei value for this MigracionDTO.
     * 
     * @return imei
     */
    public java.lang.String getImei() {
        return imei;
    }


    /**
     * Sets the imei value for this MigracionDTO.
     * 
     * @param imei
     */
    public void setImei(java.lang.String imei) {
        this.imei = imei;
    }


    /**
     * Gets the indProcEqTerminal value for this MigracionDTO.
     * 
     * @return indProcEqTerminal
     */
    public java.lang.String getIndProcEqTerminal() {
        return indProcEqTerminal;
    }


    /**
     * Sets the indProcEqTerminal value for this MigracionDTO.
     * 
     * @param indProcEqTerminal
     */
    public void setIndProcEqTerminal(java.lang.String indProcEqTerminal) {
        this.indProcEqTerminal = indProcEqTerminal;
    }


    /**
     * Gets the nomUsuarioVendedor value for this MigracionDTO.
     * 
     * @return nomUsuarioVendedor
     */
    public java.lang.String getNomUsuarioVendedor() {
        return nomUsuarioVendedor;
    }


    /**
     * Sets the nomUsuarioVendedor value for this MigracionDTO.
     * 
     * @param nomUsuarioVendedor
     */
    public void setNomUsuarioVendedor(java.lang.String nomUsuarioVendedor) {
        this.nomUsuarioVendedor = nomUsuarioVendedor;
    }


    /**
     * Gets the numCelular value for this MigracionDTO.
     * 
     * @return numCelular
     */
    public java.lang.Long getNumCelular() {
        return numCelular;
    }


    /**
     * Sets the numCelular value for this MigracionDTO.
     * 
     * @param numCelular
     */
    public void setNumCelular(java.lang.Long numCelular) {
        this.numCelular = numCelular;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof MigracionDTO)) return false;
        MigracionDTO other = (MigracionDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codCliente==null && other.getCodCliente()==null) || 
             (this.codCliente!=null &&
              this.codCliente.equals(other.getCodCliente()))) &&
            ((this.codOficina==null && other.getCodOficina()==null) || 
             (this.codOficina!=null &&
              this.codOficina.equals(other.getCodOficina()))) &&
            ((this.codPlanTarif==null && other.getCodPlanTarif()==null) || 
             (this.codPlanTarif!=null &&
              this.codPlanTarif.equals(other.getCodPlanTarif()))) &&
            ((this.imei==null && other.getImei()==null) || 
             (this.imei!=null &&
              this.imei.equals(other.getImei()))) &&
            ((this.indProcEqTerminal==null && other.getIndProcEqTerminal()==null) || 
             (this.indProcEqTerminal!=null &&
              this.indProcEqTerminal.equals(other.getIndProcEqTerminal()))) &&
            ((this.nomUsuarioVendedor==null && other.getNomUsuarioVendedor()==null) || 
             (this.nomUsuarioVendedor!=null &&
              this.nomUsuarioVendedor.equals(other.getNomUsuarioVendedor()))) &&
            ((this.numCelular==null && other.getNumCelular()==null) || 
             (this.numCelular!=null &&
              this.numCelular.equals(other.getNumCelular())));
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
        if (getCodCliente() != null) {
            _hashCode += getCodCliente().hashCode();
        }
        if (getCodOficina() != null) {
            _hashCode += getCodOficina().hashCode();
        }
        if (getCodPlanTarif() != null) {
            _hashCode += getCodPlanTarif().hashCode();
        }
        if (getImei() != null) {
            _hashCode += getImei().hashCode();
        }
        if (getIndProcEqTerminal() != null) {
            _hashCode += getIndProcEqTerminal().hashCode();
        }
        if (getNomUsuarioVendedor() != null) {
            _hashCode += getNomUsuarioVendedor().hashCode();
        }
        if (getNumCelular() != null) {
            _hashCode += getNumCelular().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(MigracionDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.scl.serviciospostventasiga.transport", "MigracionDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codCliente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.serviciospostventasiga.transport", "CodCliente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codOficina");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.serviciospostventasiga.transport", "CodOficina"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codPlanTarif");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.serviciospostventasiga.transport", "CodPlanTarif"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("imei");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.serviciospostventasiga.transport", "Imei"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indProcEqTerminal");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.serviciospostventasiga.transport", "IndProcEqTerminal"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nomUsuarioVendedor");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.serviciospostventasiga.transport", "NomUsuarioVendedor"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numCelular");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.serviciospostventasiga.transport", "NumCelular"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
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
