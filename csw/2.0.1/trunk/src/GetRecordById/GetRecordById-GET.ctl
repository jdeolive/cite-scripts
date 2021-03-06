<?xml version="1.0" encoding="UTF-8"?>
<ctl:package
 xmlns="http://www.occamlab.com/ctl"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:ctl="http://www.occamlab.com/ctl"
 xmlns:parsers="http://www.occamlab.com/te/parsers"
 xmlns:p="http://teamengine.sourceforge.net/parsers"
 xmlns:saxon="http://saxon.sf.net/"
 xmlns:csw="http://www.opengis.net/cat/csw" 
 xmlns:dc="http://purl.org/dc/elements/1.1/" 
 xmlns:xi="http://www.w3.org/2001/XInclude">

    <ctl:test name="csw:run-GetRecordById-GET">
      <param name="csw.GetCapabilities.document" />
      <ctl:assertion>
      Run test group for GetRecordById requests using the GET method.
      </ctl:assertion>
      <ctl:code>
        <xsl:variable name="csw.GetRecordById.get.url">
		    <xsl:value-of select="$csw.GetCapabilities.document//ows:OperationsMetadata/ows:Operation[@name='GetRecordById']/ows:DCP/ows:HTTP/ows:Get/@xlink:href"/>
		</xsl:variable>
        <xsl:variable name="csw.GetRecords.post.url">
            <xsl:value-of select="$csw.GetCapabilities.document//ows:OperationsMetadata/ows:Operation[@name='GetRecords']/ows:DCP/ows:HTTP/ows:Post/@xlink:href"/>
	    </xsl:variable>
        <ctl:message>Target endpoint is <xsl:value-of select="$csw.GetRecordById.get.url"/></ctl:message>
        
  <ctl:call-test name="csw:csw-2.0.1-GetRecordById-tc1.1">
    <ctl:with-param name="csw.GetRecordById.get.url" select="$csw.GetRecordById.get.url"/>
    <ctl:with-param name="csw.GetRecords.post.url" select="$csw.GetRecords.post.url"/>
  </ctl:call-test>
  <ctl:call-test name="csw:csw-2.0.1-GetRecordById-tc1.2">
    <ctl:with-param name="csw.GetRecordById.get.url" select="$csw.GetRecordById.get.url"/>
    <ctl:with-param name="csw.GetRecords.post.url" select="$csw.GetRecords.post.url"/>
  </ctl:call-test>
  <ctl:call-test name="csw:csw-2.0.1-GetRecordById-tc2.1">
    <ctl:with-param name="csw.GetRecordById.get.url" select="$csw.GetRecordById.get.url"/>
    <ctl:with-param name="csw.GetRecords.post.url" select="$csw.GetRecords.post.url"/>
  </ctl:call-test>
  <ctl:call-test name="csw:csw-2.0.1-GetRecordById-tc3.1">
    <ctl:with-param name="csw.GetRecordById.get.url" select="$csw.GetRecordById.get.url"/>
  </ctl:call-test>
  <ctl:call-test name="csw:csw-2.0.1-GetRecordById-tc4.1">
    <ctl:with-param name="csw.GetRecordById.get.url" select="$csw.GetRecordById.get.url"/>
  </ctl:call-test>
  <ctl:call-test name="csw:csw-2.0.1-GetRecordById-tc5.1">
    <ctl:with-param name="csw.GetRecordById.get.url" select="$csw.GetRecordById.get.url"/>
  </ctl:call-test>
      </ctl:code>
    </ctl:test>
   
    <test name="csw:csw-2.0.1-GetRecordById-tc1.1">
      <param name="csw.GetRecordById.get.url"/>
      <param name="csw.GetRecords.post.url"/>
      <assertion>
      All CSW-based catalogue services must implement getRecordById using the 
      GET method. A GetRecordById request without the ElementSetName parameter 
      must produce a response containing a brief view of all matching records. 
      </assertion>
      <comment>
      Pass if the response is schema valid and includes a csw:BriefRecord representation of all matching records.
      </comment>
      <link>ows-</link>
		<code>
            <xsl:variable name="response0">
				<ctl:request>
					<ctl:url>
						<xsl:value-of select="$csw.GetRecords.post.url"/>
					</ctl:url>
                    <ctl:method>POST</ctl:method>
					<ctl:body>
                      <csw:GetRecords xmlns:csw="http://www.opengis.net/cat/csw" 
                        service="CSW" version="2.0.1" resultType="results">
                        <csw:Query typeNames="csw:Record">
                          <csw:ElementSetName>brief</csw:ElementSetName>
                        </csw:Query>
                      </csw:GetRecords>
					</ctl:body>
					<p:XMLValidatingParser.CSW/>
				</ctl:request>
			</xsl:variable>
            <xsl:variable name="id.1">
              <xsl:value-of select="$response0//csw:SearchResults/*[1]/dc:identifier"/>
            </xsl:variable>
			<xsl:variable name="response">
				<ctl:request>
					<ctl:url>
						<xsl:value-of select="$csw.GetRecordById.get.url"/>
					</ctl:url>
					<ctl:method>GET</ctl:method>
					<ctl:param name="service">CSW</ctl:param>
                    <ctl:param name="version">2.0.1</ctl:param>
					<ctl:param name="request">GetRecordById</ctl:param>
                    <ctl:param name="id"><xsl:value-of select="encode-for-uri($id.1)"/></ctl:param>
					<p:XMLValidatingParser.CSW/>
				</ctl:request>
			</xsl:variable>
			
            <xsl:choose>
              <xsl:when test="not($response/*)">
                  <ctl:message>FAILURE: Missing response entity.</ctl:message>
                  <ctl:fail/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:if test="$response//csw:BriefRecord/dc:identifier != $id.1">
                  <ctl:message>
                  FAILURE: Expected csw:BriefRecord with dc:identifier = <xsl:value-of select="$id.1"/>.
                  </ctl:message>
				  <ctl:fail/>
			    </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
		</code>
	</test>
    
    <test name="csw:csw-2.0.1-GetRecordById-tc1.2">
      <param name="csw.GetRecordById.get.url"/>
      <param name="csw.GetRecords.post.url"/>
      <assertion>
      The response to a GetRecordById request without the ElementSetName parameter 
      must produce a response containing a brief view of all matching records. 
      </assertion>
      <comment>
      Pass if the response is schema valid and includes only 1 csw:BriefRecord element.
      </comment>
      <link>ows-</link>
		<code>
            <xsl:variable name="response0">
				<ctl:request>
					<ctl:url>
						<xsl:value-of select="$csw.GetRecords.post.url"/>
					</ctl:url>
                    <ctl:method>POST</ctl:method>
					<ctl:body>
                      <csw:GetRecords xmlns:csw="http://www.opengis.net/cat/csw" 
                        service="CSW" version="2.0.1" resultType="results">
                        <csw:Query typeNames="csw:Record">
                          <csw:ElementSetName>brief</csw:ElementSetName>
                        </csw:Query>
                      </csw:GetRecords>
					</ctl:body>
					<p:XMLValidatingParser.CSW/>
				</ctl:request>
			</xsl:variable>
            <xsl:variable name="id.2">
              <xsl:value-of select="$response0//csw:SearchResults/*[2]/dc:identifier"/>
            </xsl:variable>
			<xsl:variable name="response">
				<ctl:request>
					<ctl:url>
						<xsl:value-of select="$csw.GetRecordById.get.url"/>
					</ctl:url>
					<ctl:method>GET</ctl:method>
					<ctl:param name="service">CSW</ctl:param>
                    <ctl:param name="version">2.0.1</ctl:param>
					<ctl:param name="request">GetRecordById</ctl:param>
                    <ctl:param name="id">urn:uuid:ce8627a0-685c-11db-bd13-0800200c9a66,<xsl:value-of select="escape-html-uri($id.2)"/></ctl:param>
					<p:XMLValidatingParser.CSW/>
				</ctl:request>
			</xsl:variable>
			
            <xsl:choose>
              <xsl:when test="not($response/*)">
                  <ctl:message>FAILURE: Missing response entity.</ctl:message>
                  <ctl:fail/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:if test="count($response//csw:GetRecordByIdResponse/*) != 1">
                  <ctl:message>
                  FAILURE: Expected one record in response.
                  </ctl:message>
				  <ctl:fail/>
			    </xsl:if>
                <xsl:if test="$response//csw:BriefRecord/dc:identifier != $id.2">
                  <ctl:message>
                  FAILURE: Expected csw:BriefRecord with dc:identifier = <xsl:value-of select="$id.2"/>.
                  </ctl:message>
				  <ctl:fail/>
			    </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
		</code>
	</test>
    
    <test name="csw:csw-2.0.1-GetRecordById-tc2.1">
      <param name="csw.GetRecordById.get.url"/>
      <param name="csw.GetRecords.post.url"/>
      <assertion>
      The response to a GetRecordById request containing the ElementSetName parameter 
      must produce a response containing the corresponding view of all matching 
      records. 
      </assertion>
      <comment>
      Pass if the response is schema valid and includes a csw:SummaryRecord representation.
      </comment>
      <link>ows-</link>
		<code>
            <xsl:variable name="response0">
				<ctl:request>
					<ctl:url>
						<xsl:value-of select="$csw.GetRecords.post.url"/>
					</ctl:url>
                    <ctl:method>POST</ctl:method>
					<ctl:body>
                      <csw:GetRecords xmlns:csw="http://www.opengis.net/cat/csw" 
                        service="CSW" version="2.0.1" resultType="results">
                        <csw:Query typeNames="csw:Record">
                          <csw:ElementSetName>brief</csw:ElementSetName>
                        </csw:Query>
                      </csw:GetRecords>
					</ctl:body>
					<p:XMLValidatingParser.CSW/>
				</ctl:request>
			</xsl:variable>
            <xsl:variable name="id.3">
              <xsl:value-of select="$response0//csw:SearchResults/*[3]/dc:identifier"/>
            </xsl:variable>
			<xsl:variable name="response">
				<request>
					<url>
						<xsl:value-of select="$csw.GetRecordById.get.url"/>
					</url>
					<method>GET</method>
					<param name="Service">CSW</param>
                    <param name="Version">2.0.1</param>
					<param name="Request">GetRecordById</param>
                    <param name="ElementSetName">summary</param>
                    <param name="ID"><xsl:value-of select="encode-for-uri($id.3)"/></param>
					<p:XMLValidatingParser.CSW/>
				</request>
			</xsl:variable>
			
            <xsl:choose>
              <xsl:when test="not($response/*)">
                  <ctl:message>FAILURE: Missing response entity.</ctl:message>
                  <ctl:fail/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:variable name="summaryRecCount" select="count($response/csw:GetRecordByIdResponse/csw:SummaryRecord)" />
                <xsl:variable name="recCount" select="count($response/csw:GetRecordByIdResponse/*)" />
                <xsl:if test="($summaryRecCount != $recCount) and ($recCount != 1)">
                  <ctl:message>FAILURE: Expected one csw:SummaryRecord element in response.</ctl:message>
				  <ctl:fail/>
			    </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
		</code>
	</test>
    
    <test name="csw:csw-2.0.1-GetRecordById-tc3.1">
      <param name="csw.GetRecordById.get.url"/>
      <assertion>
      The response to a GetRecordById request containing no matching identifiers
      must be empty.
      </assertion>
      <comment>
      Pass if the response entity is schema valid and includes no records.
      </comment>
      <link>ows-</link>
		<code>
			<xsl:variable name="response">
				<request>
					<url>
						<xsl:value-of select="$csw.GetRecordById.get.url"/>
					</url>
					<method>GET</method>
					<param name="service">CSW</param>
                    <param name="version">2.0.1</param>
					<param name="request">GetRecordById</param>
                    <param name="id">urn:uuid:ce8627a0-685c-11db-bd13-0800200c9a66</param>
					<p:XMLValidatingParser.CSW/>
				</request>
			</xsl:variable>
			
            <xsl:choose>
              <xsl:when test="not($response/*)">
                  <ctl:message>FAILURE: Missing response entity.</ctl:message>
                  <ctl:fail/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:if test="count($response/csw:GetRecordByIdResponse/*) != 0">
                  <ctl:message>
                  FAILURE: Expected empty csw:GetRecordByIdResponse element.
                  </ctl:message>
				  <ctl:fail/>
			    </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
		</code>
	</test>
    
    <test name="csw:csw-2.0.1-GetRecordById-tc4.1">
      <param name="csw.GetRecordById.get.url"/>
      <assertion>
      The response to a GetRecordById request missing the required Id parameter 
      must include an exception report. 
      </assertion>
      <comment>
      Pass if all of the following conditions are true: (1) the response is a 
      valid ows:ExceptionReport; (2) the reported exceptionCode is "MissingParameterValue".
      </comment>
      <link>ows-</link>
		<code>
			<xsl:variable name="response">
				<request>
					<url>
						<xsl:value-of select="$csw.GetRecordById.get.url"/>
					</url>
					<method>GET</method>
					<param name="service">CSW</param>
                    <param name="version">2.0.1</param>
					<param name="request">GetRecordById</param>
					<p:XMLValidatingParser.OWS/>
				</request>
			</xsl:variable>
			
            <xsl:choose>
              <xsl:when test="not($response/*)">
                  <ctl:message>FAILURE: Missing response entity.</ctl:message>
                  <ctl:fail/>
              </xsl:when>
              <xsl:otherwise>
                <ctl:call-test name="ctl:SchematronValidatingParser">
		            <ctl:with-param name="doc" select="$response" />
		            <ctl:with-param name="schema">sch/ows/1.0.0/ExceptionReport.sch</ctl:with-param>
		            <ctl:with-param name="phase">MissingParameterValuePhase</ctl:with-param>
	            </ctl:call-test>
                <xsl:if test="not(lower-case($response//ows:Exception/@locator) = 'id')">
                  <ctl:message>
                  FAILURE: ows:Exception/@locator is absent or does not identify the missing 'id' parameter.
                  </ctl:message>
                  <ctl:fail/>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
		</code>
	</test>
    
    <test name="csw:csw-2.0.1-GetRecordById-tc5.1">
      <param name="csw.GetRecordById.get.url"/>
      <assertion>
      The response to a GetRecordById request with an invalid ElementSetName 
      parameter value must include an exception report. 
      </assertion>
      <comment>
      Pass if all of the following conditions are true: (1) the response is a 
      valid ows:ExceptionReport; (2) the reported exceptionCode is "InvalidParameterValue".
      </comment>
      <link>ows-</link>
		<code>
			<xsl:variable name="response">
				<request>
					<url>
						<xsl:value-of select="$csw.GetRecordById.get.url"/>
					</url>
					<method>GET</method>
					<param name="Service">CSW</param>
                    <param name="Version">2.0.1</param>
					<param name="Request">GetRecordById</param>
                    <param name="ElementSetName">complete</param>
                    <param name="Id">urn:uuid:a06af396-3105-442d-8b40-22b57a90d2f2,urn:uuid:19887a8a-f6b0-4a63-ae56-7fba0e17801f,urn:uuid:ab42a8c4-95e8-4630-bf79-33e59241605a</param>
					<p:XMLValidatingParser.CSW/>
				</request>
			</xsl:variable>
			
            <xsl:choose>
              <xsl:when test="not($response/*)">
                  <ctl:message>FAILURE: Missing response entity.</ctl:message>
                  <ctl:fail/>
              </xsl:when>
              <xsl:otherwise>
                <ctl:call-test name="ctl:SchematronValidatingParser">
		            <ctl:with-param name="doc" select="$response" />
		            <ctl:with-param name="schema">sch/ows/1.0.0/ExceptionReport.sch</ctl:with-param>
		            <ctl:with-param name="phase">InvalidParameterValuePhase</ctl:with-param>
	            </ctl:call-test>
                <xsl:if test="not(lower-case($response//ows:Exception/@locator) = 'elementsetname')">
                  <ctl:message>
                  FAILURE: ows:Exception/@locator is absent or does not identify the invalid 'ElementSetName' parameter.
                  </ctl:message>
                  <ctl:fail/>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
		</code>
	</test>
</ctl:package>
