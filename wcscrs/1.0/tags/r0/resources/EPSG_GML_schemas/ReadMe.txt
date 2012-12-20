This archive contains schema documents for the EPSG Geodetic Parameter Registry v0.1, last updated 2008-03-20.

The application schemas for the EPSG Registry conform to a pre-release version of GML 3.2.0.

A major change introduced into GML 3.2.0 which occurred just prior to the EPSG Registry release was a namespace change.
The namespace went from http://www.opengis.net/gml to http://www.opengis.net/gml/3.2. 
The EPSG Registry currently uses the former namespace, without the version number.

There have been numerous other minor changes to the GML specification, very few of which affect the EPSG Registry application schema.  
Two issues which do affect the EPSG Registry application schema which apply only if upgrading to GML 3.2.1 are:

(i) The CoordinateSystemAxis element has a "uom" attribute which in GML 3.2.1 must no longer use the "gml" prefix.
In GML 3.2.0 it was expressed as 
 <gml:CoordinateSystemAxis gml:uom="..."> 
while in GML 3.2.1 it must be expressed as  
<gml:CoordinateSystemAxis uom="...">

(ii) The <isSphere> element on an Ellipsoid has had a change to the data-type of its value to now (v3.2.1) be a boolean.  
So, GML 3.2.0 used <isSphere>Sphere</isSphere>   while GML 3.2.1 requires:    <isSphere>true</isSphere>
 

The content of the archive is:
- File EPSG.xsd:     the EPSG Registry Schema.
- Folder "gml":      the GML 3.2.0 Schema; the root document of the GML Schema is file "gml/gml.xsd"
- Folder "Smil":     this schema is here because there are errors in publicly available smil schemas at w3c site.
- Folder "xlink":    the imported W3C XLink schema (see W3C XLink 1.0)
- Folder "Smil":     this schema is here because there are errors in publicly available smil schemas at w3c site.
- Folder "iso19139": the imported GMD schema and contained schemas (see ISO/TS 19139)

http://www.epsg.org/RegistrySchemas/