<?xml version="1.0" encoding="UTF-8"?>
<ctl:package
 xmlns="http://www.occamlab.com/ctl"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:ctl="http://www.occamlab.com/ctl"
 xmlns:parsers="http://www.occamlab.com/te/parsers"
 xmlns:p="http://teamengine.sourceforge.net/parsers"
 xmlns:saxon="http://saxon.sf.net/"
 xmlns:csw="http://www.opengis.net/cat/csw"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
 xmlns:xi="http://www.w3.org/2001/XInclude">

    <ctl:test name="csw:run-DescribeRecord-POST">
      <param name="csw.GetCapabilities.document" />
      <ctl:assertion>
      Run test group for DescribeRecord requests using the POST method.
      </ctl:assertion>
      <ctl:code>
        <xsl:variable name="csw.DescribeRecord.post.url">
		<xsl:for-each select="$csw.GetCapabilities.document//ows:OperationsMetadata/ows:Operation[@name='DescribeRecord']/ows:DCP/ows:HTTP">
			<xsl:choose>
				<xsl:when test="ows:Post[ows:Constraint[@name='PostEncoding']/ows:Value='XML']">
					<xsl:value-of select="ows:Post[ows:Constraint[@name='PostEncoding']/ows:Value='XML']/@xlink:href"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="ows:Post[not(ows:Constraint[@name='PostEncoding'])]/@xlink:href"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:variable>
        <ctl:message>Target endpoint is <xsl:value-of select="$csw.DescribeRecord.post.url"/></ctl:message>
        
  <ctl:call-test name="csw:csw-2.0.1-DescribeRecord-tc1.1">
    <ctl:with-param name="csw.DescribeRecord.post.url" select="$csw.DescribeRecord.post.url"/>
  </ctl:call-test>
  <ctl:call-test name="csw:csw-2.0.1-DescribeRecord-tc2.1">
    <ctl:with-param name="csw.DescribeRecord.post.url" select="$csw.DescribeRecord.post.url"/>
  </ctl:call-test>
  <ctl:call-test name="csw:csw-2.0.1-DescribeRecord-tc3.1">
    <ctl:with-param name="csw.DescribeRecord.post.url" select="$csw.DescribeRecord.post.url"/>
  </ctl:call-test>
  <ctl:call-test name="csw:csw-2.0.1-DescribeRecord-tc4.1">
    <ctl:with-param name="csw.DescribeRecord.post.url" select="$csw.DescribeRecord.post.url"/>
  </ctl:call-test>
  <ctl:call-test name="csw:csw-2.0.1-DescribeRecord-tc5.1">
    <ctl:with-param name="csw.DescribeRecord.post.url" select="$csw.DescribeRecord.post.url"/>
  </ctl:call-test>
  <ctl:call-test name="csw:csw-2.0.1-DescribeRecord-tc6.1">
    <ctl:with-param name="csw.DescribeRecord.post.url" select="$csw.DescribeRecord.post.url"/>
  </ctl:call-test>
  <ctl:call-test name="csw:csw-2.0.1-DescribeRecord-tc7.1">
    <ctl:with-param name="csw.DescribeRecord.post.url" select="$csw.DescribeRecord.post.url"/>
  </ctl:call-test>

      </ctl:code>
    </ctl:test>
   
    <test name="csw:csw-2.0.1-DescribeRecord-tc1.1">
      <param name="csw.DescribeRecord.post.url"/>
      <assertion>
      The response to a DescribeRecord request that does not include any TypeName 
      elements and does not specify a schema language must produce a response that 
      describes all supported record types using the XML Schema language.
      </assertion>
      <comment>
      Pass if the response is valid and contains XML Schema components for all 
      supported record types.
      </comment>
      <link>csw-</link>
		<code>
			<xsl:variable name="response">
				<request>
					<url>
						<xsl:value-of select="$csw.DescribeRecord.post.url"/>
					</url>
					<method>POST</method>
					<body>
                      <csw:DescribeRecord xmlns:csw="http://www.opengis.net/cat/csw" service="CSW" version="2.0.1" />
					  <!--<xi:include href="./csw-2.0.1-DescribeRecord-tc1.1.body.xml"/>-->
					</body>
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
		            <ctl:with-param name="schema">sch/csw/2.0.1/DescribeRecord.sch</ctl:with-param>
		            <ctl:with-param name="phase">DefaultPhase</ctl:with-param>
	            </ctl:call-test>
              </xsl:otherwise>
            </xsl:choose>
		</code>
	</test>
    
    <test name="csw:csw-2.0.1-DescribeRecord-tc2.1">
      <param name="csw.DescribeRecord.post.url"/>
      <assertion>
      The response to a DescribeRecord request containing TypeName elements must 
      include schema components for each requested record type.
      </assertion>
      <comment>
      Pass if the response is valid and contains XML Schema components (i.e., 
      element declarations or a schema containing element declarations) for 
      the record types in the correct target namespaces.
      </comment>
      <link>csw-</link>
		<code>
			<xsl:variable name="response">
				<request>
					<url>
						<xsl:value-of select="$csw.DescribeRecord.post.url"/>
					</url>
					<method>POST</method>
					<body>
                      <csw:DescribeRecord xmlns:csw="http://www.opengis.net/cat/csw" 
                        service="CSW" version="2.0.1" 
                        schemaLanguage="http://www.w3.org/XML/Schema">
                        <csw:TypeName targetNamespace="http://www.opengis.net/cat/csw">SummaryRecord</csw:TypeName>
                      </csw:DescribeRecord>
					  <!--<xi:include href="./csw-2.0.1-DescribeRecord-tc2.1.body.xml"/>-->
					</body>
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
		            <ctl:with-param name="schema">sch/csw/2.0.1/DescribeRecord.sch</ctl:with-param>
		            <ctl:with-param name="phase">DefaultPhase</ctl:with-param>
	            </ctl:call-test>
                <xsl:variable name="element" 
                  select="$response//csw:SchemaComponent/xsd:element/@name = 'SummaryRecord'" />
                <xsl:variable name="schema" 
                  select="$response//csw:SchemaComponent/xsd:schema/xsd:element/@name = 'SummaryRecord'" />
                <xsl:if test="not($element or $schema)">
                  <ctl:message>FAILURE: Missing element declaration for csw:SummaryRecord</ctl:message>
                  <ctl:fail/>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
		</code>
	</test>
    
    <test name="csw:csw-2.0.1-DescribeRecord-tc3.1">
      <param name="csw.DescribeRecord.post.url"/>
      <assertion>
      The response to a DescribeRecord request that contains an unknown TypeName 
      element must not include any csw:SchemaComponent elements.
      </assertion>
      <comment>
      Pass if the response is valid and contains no csw:SchemaComponent elements.
      </comment>
      <link>csw-</link>
		<code>
			<xsl:variable name="response">
				<request>
					<url>
						<xsl:value-of select="$csw.DescribeRecord.post.url"/>
					</url>
					<method>POST</method>
					<body>
                      <csw:DescribeRecord xmlns:csw="http://www.opengis.net/cat/csw" 
                        service="CSW" version="2.0.1" 
                        schemaLanguage="http://www.w3.org/XML/Schema">
                        <csw:TypeName targetNamespace="http://www.opengis.net/cat/csw">DummyRecord</csw:TypeName>
                      </csw:DescribeRecord>
					  <!--<xi:include href="./csw-2.0.1-DescribeRecord-tc3.1.body.xml"/>-->
					</body>
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
		            <ctl:with-param name="schema">sch/csw/2.0.1/DescribeRecord.sch</ctl:with-param>
		            <ctl:with-param name="phase">NoSchemaComponentsPhase</ctl:with-param>
	            </ctl:call-test>
              </xsl:otherwise>
            </xsl:choose>
		</code>
	</test>
    
    <test name="csw:csw-2.0.1-DescribeRecord-tc4.1">
      <param name="csw.DescribeRecord.post.url"/>
      <assertion>
      A response message containing an entity body must contain a Content-Type entity 
      header field that correctly indicates the media type of the message body.
      </assertion>
      <comment>Pass if the Content-Type entity header field indicates an XML media type.</comment>
      <link>OGC 05-008: 11.7 (p.61)</link>
		<code>
			<xsl:variable name="response">
				<request>
					<url>
						<xsl:value-of select="$csw.DescribeRecord.post.url"/>
					</url>
					<method>POST</method>
					<body>
                      <csw:DescribeRecord xmlns:csw="http://www.opengis.net/cat/csw" 
                        service="CSW" version="2.0.1" 
                        schemaLanguage="http://www.w3.org/XML/Schema">
                        <csw:TypeName targetNamespace="http://www.opengis.net/cat/csw">SummaryRecord</csw:TypeName>
                      </csw:DescribeRecord>
					  <!--<xi:include href="./csw-2.0.1-DescribeRecord-tc4.1.body.xml"/>-->
					</body>
					<parsers:HTTPParser />
				</request>
			</xsl:variable>
			
            <xsl:choose>
              <xsl:when test="not($response/*)">
                  <ctl:message>FAILURE: Missing response.</ctl:message>
                  <ctl:fail/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:variable name="content-type" 
                  select="$response//headers/header[@name='Content-Type']"/>
                <xsl:if test="matches($content-type,'.+/xml') != true()">
                    <ctl:message>FAILURE: Content-Type response header does not indicate an XML media type (<xsl:value-of select="$content-type"/>)</ctl:message>
                    <ctl:fail/>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
		</code>
	</test>
    
    <test name="csw:csw-2.0.1-DescribeRecord-tc5.1">
      <param name="csw.DescribeRecord.post.url"/>
      <assertion>
      The response to a DescribeRecord request that specifies an unsupported 
      output format must include an exception report.
      </assertion>
      <comment>
      Pass if all of the following conditions are true: (1) the response 
      entity has &lt;ows:ExceptionReport&gt; as the document element; and (2) 
      ows:Exception/@exceptionCode="InvalidParameterValue" (@outputFormat).
      </comment>
      <link>csw-</link>
		<code>
			<xsl:variable name="response">
				<request>
					<url>
						<xsl:value-of select="$csw.DescribeRecord.post.url"/>
					</url>
					<method>POST</method>
					<body>
                      <csw:DescribeRecord xmlns:csw="http://www.opengis.net/cat/csw" 
                        service="CSW" version="2.0.1" 
                        schemaLanguage="http://www.w3.org/XML/Schema"
                        outputFormat="text/sgml">
                        <csw:TypeName targetNamespace="http://www.opengis.net/cat/csw">SummaryRecord</csw:TypeName>
                      </csw:DescribeRecord>
					  <!--<xi:include href="./csw-2.0.1-DescribeRecord-tc5.1.body.xml"/>-->
					</body>
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
                <xsl:if test="not(lower-case($response//ows:Exception/@locator) = 'outputformat')">
                  <ctl:message>
                  FAILURE: ows:Exception/@locator is absent or does not identify the invalid 'outputFormat' attribute.
                  </ctl:message>
                  <ctl:fail/>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
		</code>
	</test>
    
    <test name="csw:csw-2.0.1-DescribeRecord-tc6.1">
      <param name="csw.DescribeRecord.post.url"/>
      <assertion>
      The response to a DescribeRecord request that specifies an unsupported 
      schema language must include an exception report.
      </assertion>
      <comment>
      Pass if all of the following conditions are true: (1) the response 
      entity has &lt;ows:ExceptionReport&gt; as the document element; and (2) 
      ows:Exception/@exceptionCode="InvalidParameterValue".
      </comment>
      <link>csw-</link>
		<code>
			<xsl:variable name="response">
				<request>
					<url>
						<xsl:value-of select="$csw.DescribeRecord.post.url"/>
					</url>
					<method>POST</method>
					<body>
                      <csw:DescribeRecord xmlns:csw="http://www.opengis.net/cat/csw" 
                        service="CSW" version="2.0.1" 
                        schemaLanguage="http://purl.oclc.org/dsdl/schematron">
                        <csw:TypeName targetNamespace="http://www.opengis.net/cat/csw">SummaryRecord</csw:TypeName>
                      </csw:DescribeRecord>
					  <!--<xi:include href="./csw-2.0.1-DescribeRecord-tc6.1.body.xml"/>-->
					</body>
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
                <xsl:if test="not(lower-case($response//ows:Exception/@locator) = 'schemalanguage')">
                  <ctl:message>
                  FAILURE: ows:Exception/@locator is absent or does not identify the invalid 'schemaLanguage' attribute.
                  </ctl:message>
                  <ctl:fail/>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
		</code>
	</test>
    
    <test name="csw:csw-2.0.1-DescribeRecord-tc7.1">
      <param name="csw.DescribeRecord.post.url"/>
      <assertion>
      The response to an invalid DescribeRecord request must include an exception report.
      </assertion>
      <comment>
      Pass if all of the following conditions are true: (1) the response 
      entity has &lt;ows:ExceptionReport&gt; as the document element; and (2) 
      ows:Exception/@exceptionCode="MissingParameterValue" (csw:TypeName/@targetNamespace).
      </comment>
      <link>csw-</link>
		<code>
			<xsl:variable name="response">
				<request>
					<url>
						<xsl:value-of select="$csw.DescribeRecord.post.url"/>
					</url>
					<method>POST</method>
					<body>
                      <csw:DescribeRecord xmlns:csw="http://www.opengis.net/cat/csw" 
                        service="CSW" version="2.0.1" 
                        schemaLanguage="http://www.w3.org/XML/Schema">
                        <csw:TypeName>Record</csw:TypeName>
                      </csw:DescribeRecord>
					  <!--<xi:include href="./csw-2.0.1-DescribeRecord-tc7.1.body.xml"/>-->
					</body>
					<p:XMLValidatingParser.CSW/>
				</request>
			</xsl:variable>
			
            <xsl:choose>
              <xsl:when test="not($response/*)">
                  <ctl:message>FAILURE: Missing or invalid response entity.</ctl:message>
                  <ctl:fail/>
              </xsl:when>
              <xsl:otherwise>
                <ctl:call-test name="ctl:SchematronValidatingParser">
		            <ctl:with-param name="doc" select="$response" />
		            <ctl:with-param name="schema">sch/ows/1.0.0/ExceptionReport.sch</ctl:with-param>
		            <ctl:with-param name="phase">MissingParameterValuePhase</ctl:with-param>
	            </ctl:call-test>
              </xsl:otherwise>
            </xsl:choose>
		</code>
	</test>
</ctl:package>
