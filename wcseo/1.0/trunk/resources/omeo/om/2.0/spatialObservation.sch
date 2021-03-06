<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" queryBinding="xslt2">
    <sch:title>Additional validation rules for XML instances including simple encodings</sch:title>
    <sch:ns uri="http://www.opengis.net/om/2.0" prefix="om"/>
    <sch:ns uri="http://www.opengis.net/gml/3.2" prefix="gml"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    <xsl:import-schema schema-location="http://schemas.opengis.net/gml/3.2.1/gml.xsd"/>
    <xsl:import-schema schema-location="http://schemas.opengis.net/om/2.0.0/observation.xsd"/>
    <sch:pattern>
        <sch:title>
            Req http://www.opengis.net/req/omxml/2.0/data/spatial-parameter , 
            Req http://www.opengis.net/req/omxml/2.0/data/spatial-parameter-name
        </sch:title>
        <sch:rule context="//*[om:resultTime]">
            <sch:assert
                test="count (om:parameter/om:NamedValue/om:name[ @xlink:href = 'http://www.opengis.net/req/omxml/2.0/data/samplingGeometry']) = 1"> 
                Requirement http://www.opengis.net/req/omxml/2.0/data/spatial-parameter : A spatial observation shall have exactly one sampling geometry encoded as XML element om:parameter in an observation.
                Requirement http://www.opengis.net/req/omxml/2.0/data/spatial-parameter-name: The xlink:href attribute in the XML element om:name of the om:parameter/om:NamedValue element that carries the sampling geometry SHALL have the value  'http://www.opengis.net/req/omxml/2.0/data/samplingGeometry'.               
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <sch:title>Req http://www.opengis.net/req/omxml/2.0/data/spatial-parameter-value </sch:title>
        <sch:rule
            context="//*[om:resultTime]/om:parameter/om:NamedValue[om:name/@xlink:href= 'http://www.opengis.net/req/omxml/2.0/data/samplingGeometry']/om:value">
            <sch:assert test="schema-element(gml:AbstractGeometry)"> 
                Requirement http://www.opengis.net/req/omxml/2.0/data/spatial-parameter-value : The XML element om:value in the om:parameter/om:NamedValue element which carries the sampling geometry shall have a value of type gml:AbstractGeometry. 
            </sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
