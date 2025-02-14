/**
 * WsPlanTarifarioInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com;

public class WsPlanTarifarioInDTO  implements java.io.Serializable {
    private java.lang.String codigoTecnologia;

    private java.lang.String codigoTiplan;

    private java.lang.String indicaodorFamiliar;

    private java.lang.String tipPlanTarif;

    private java.lang.String tipoRed;

    public WsPlanTarifarioInDTO() {
    }

    public WsPlanTarifarioInDTO(
           java.lang.String codigoTecnologia,
           java.lang.String codigoTiplan,
           java.lang.String indicaodorFamiliar,
           java.lang.String tipPlanTarif,
           java.lang.String tipoRed) {
           this.codigoTecnologia = codigoTecnologia;
           this.codigoTiplan = codigoTiplan;
           this.indicaodorFamiliar = indicaodorFamiliar;
           this.tipPlanTarif = tipPlanTarif;
           this.tipoRed = tipoRed;
    }


    /**
     * Gets the codigoTecnologia value for this WsPlanTarifarioInDTO.
     * 
     * @return codigoTecnologia
     */
    public java.lang.String getCodigoTecnologia() {
        return codigoTecnologia;
    }


    /**
     * Sets the codigoTecnologia value for this WsPlanTarifarioInDTO.
     * 
     * @param codigoTecnologia
     */
    public void setCodigoTecnologia(java.lang.String codigoTecnologia) {
        this.codigoTecnologia = codigoTecnologia;
    }


    /**
     * Gets the codigoTiplan value for this WsPlanTarifarioInDTO.
     * 
     * @return codigoTiplan
     */
    public java.lang.String getCodigoTiplan() {
        return codigoTiplan;
    }


    /**
     * Sets the codigoTiplan value for this WsPlanTarifarioInDTO.
     * 
     * @param codigoTiplan
     */
    public void setCodigoTiplan(java.lang.String codigoTiplan) {
        this.codigoTiplan = codigoTiplan;
    }


    /**
     * Gets the indicaodorFamiliar value for this WsPlanTarifarioInDTO.
     * 
     * @return indicaodorFamiliar
     */
    public java.lang.String getIndicaodorFamiliar() {
        return indicaodorFamiliar;
    }


    /**
     * Sets the indicaodorFamiliar value for this WsPlanTarifarioInDTO.
     * 
     * @param indicaodorFamiliar
     */
    public void setIndicaodorFamiliar(java.lang.String indicaodorFamiliar) {
        this.indicaodorFamiliar = indicaodorFamiliar;
    }


    /**
     * Gets the tipPlanTarif value for this WsPlanTarifarioInDTO.
     * 
     * @return tipPlanTarif
     */
    public java.lang.String getTipPlanTarif() {
        return tipPlanTarif;
    }


    /**
     * Sets the tipPlanTarif value for this WsPlanTarifarioInDTO.
     * 
     * @param tipPlanTarif
     */
    public void setTipPlanTarif(java.lang.String tipPlanTarif) {
        this.tipPlanTarif = tipPlanTarif;
    }


    /**
     * Gets the tipoRed value for this WsPlanTarifarioInDTO.
     * 
     * @return tipoRed
     */
    public java.lang.String getTipoRed() {
        return tipoRed;
    }


    /**
     * Sets the tipoRed value for this WsPlanTarifarioInDTO.
     * 
     * @param tipoRed
     */
    public void setTipoRed(java.lang.String tipoRed) {
        this.tipoRed = tipoRed;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsPlanTarifarioInDTO)) return false;
        WsPlanTarifarioInDTO other = (WsPlanTarifarioInDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codigoTecnologia==null && other.getCodigoTecnologia()==null) || 
             (this.codigoTecnologia!=null &&
              this.codigoTecnologia.equals(other.getCodigoTecnologia()))) &&
            ((this.codigoTiplan==null && other.getCodigoTiplan()==null) || 
             (this.codigoTiplan!=null &&
              this.codigoTiplan.equals(other.getCodigoTiplan()))) &&
            ((this.indicaodorFamiliar==null && other.getIndicaodorFamiliar()==null) || 
             (this.indicaodorFamiliar!=null &&
              this.indicaodorFamiliar.equals(other.getIndicaodorFamiliar()))) &&
            ((this.tipPlanTarif==null && other.getTipPlanTarif()==null) || 
             (this.tipPlanTarif!=null &&
              this.tipPlanTarif.equals(other.getTipPlanTarif()))) &&
            ((this.tipoRed==null && other.getTipoRed()==null) || 
             (this.tipoRed!=null &&
              this.tipoRed.equals(other.getTipoRed())));
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
        if (getCodigoTecnologia() != null) {
            _hashCode += getCodigoTecnologia().hashCode();
        }
        if (getCodigoTiplan() != null) {
            _hashCode += getCodigoTiplan().hashCode();
        }
        if (getIndicaodorFamiliar() != null) {
            _hashCode += getIndicaodorFamiliar().hashCode();
        }
        if (getTipPlanTarif() != null) {
            _hashCode += getTipPlanTarif().hashCode();
        }
        if (getTipoRed() != null) {
            _hashCode += getTipoRed().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsPlanTarifarioInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "WsPlanTarifarioInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoTecnologia");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoTecnologia"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoTiplan");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoTiplan"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicaodorFamiliar");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IndicaodorFamiliar"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("tipPlanTarif");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "TipPlanTarif"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("tipoRed");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "TipoRed"));
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
