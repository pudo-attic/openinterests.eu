<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:iso19115="http://www.isotc211.org/iso19115/" xmlns:iso19103="http://www.isotc211.org/iso19103/" xmlns:iso19109="http://www.isotc211.org/iso19109/" xmlns:iso4217="http://www.isotc211.org/iso4217/" xmlns:iso639-2="http://www.isotc211.org/iso639-2/" xmlns:gml="http://www.opengis.net/gml" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:gisco="http://www.gisco.eurostat.cec/metadataModel/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
        <xsl:template match="/">
                <html>
                        <head>
                                <SCRIPT LANGUAGE="JavaScript"><![CDATA[

function test() {
  var ua = window.navigator.userAgent
  var msie = ua.indexOf ( "MSIE " )
  if ( msie == -1 )
    document.write("<P>" + "Netscape")
}

      function fix(e) {
        var par = e.parentNode;
        e.id = "";
        e.style.marginLeft = "0.42in";
        var pos = e.innerText.indexOf("\n");
        if (pos > 0) {
          while (pos > 0) {
            var t = e.childNodes(0);
            var n = document.createElement("PRE");
            var s = t.splitText(pos);
            e.insertAdjacentElement("afterEnd", n);
            n.appendChild(s);
            n.style.marginLeft = "0.42in";
            e = n;
            pos = e.innerText.indexOf("\n");
          }
          var count = (par.children.length);
          for (var i = 0; i < count; i++) {
            e = par.children(i);
            if (e.tagName == "PRE") {
              pos = e.innerText.indexOf(">");
              if (pos != 0) {
                n = document.createElement("DD");
                e.insertAdjacentElement("afterEnd", n);
                n.innerText = e.innerText;
                e.removeNode(true);
              }
            }
          }
          if (par.children.tags("PRE").length > 0) {
            count = (par.children.length);
            for (i = 0; i < count; i++) {
              e = par.children(i);
              if (e.tagName == "PRE") {
                e.id = "";
                if (i < (count-1)) {
                  var e2 = par.children(i + 1);
                  if (e2.tagName == "PRE") {
                    e.insertAdjacentText("beforeEnd", e2.innerText+"\n");
                    e2.removeNode(true);
                    count = count-1;
                    i = i-1;
                  }
                }
              }
            }
          }
        }
        else {
          n = document.createElement("DD");
          par.appendChild(n);
          n.innerText = e.innerText;
          e.removeNode(true);
        }
      }

    ]]></SCRIPT>
                                    <style>
                                    .sum_text {font-family:Verdana; font-size: 10pt; color:#202050;}
                                    .sum_title {font-family:Verdana; font-size: 12pt; color:#202050; font-weight: bold;}
                             .common {font-family:Verdana; font-size: 10pt; color:#0000AA;}
                             .specific {font-family:Verdana; font-size: 10pt; color:#006400;}
                             .note {font-size: 8pt;}
                             .toc {font-size: 11pt;}
                             .title_1 {color:#39393D; font-size: 12pt;}
                             .title_2 {color:#39393D}
                                   </style>
                                <title>Gisco Metadata</title>
                                <!-- label -->
                        </head>
                        <body BGCOLOR="#FFFFFF" ONCONTEXTMENU="return false" class="common">
                                        <!-- SHOW METADATA SUMMARY -->
                                        <table COLS="2" WIDTH="100%" BGCOLOR="#D0E0F0" CELLPADDING="11" BORDER="0" CELLSPACING="0">
                                                <!-- show title -->
                                                <xsl:if test="gisco:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString">
                                                        <tr ALIGN="center" VALIGN="center">
                                                                <td COLSPAN="2" class="sum_title">
                                                                                        <xsl:value-of select="gisco:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString"/>
                                                                </td>
                                                        </tr>
                                                </xsl:if>
                                                <tr ALIGN="left" VALIGN="top">
                                                        <!-- show thumbnail  -->
                                                        <xsl:if test="/gisco:MD_Metadata/gmd:identificationInfo/gisco:graphOver/gisco:bgFileName |
                                                                          /gisco:MD_Metadata/gisco:DataIdent/gisco:graphOver/gisco:bgFileName">
                                                                <td>
                                                                        <xsl:choose>
                                                                                <!-- would also test for natvform and file name -->
                                                                                <xsl:when test="/gisco:MD_Metadata[gmd:identificationInfo/gisco:descKeys[gisco:keyType/text() = 'discipline']  |
                                                                                                        gisco:DataIdent/gisco:descKeys[gisco:keyType/text() = 'discipline'] |
                                                                                                         gisco:RefSystem/gisco:refSysId/iso19115:identCode/text() |
                                                                                                         gisco:refSysInfo/gisco:refSysId/iso19115:identCode/text() |
                                                                                                         gisco:MdCoRefSys/gisco:refSysId/iso19115:identCode/text() |
                                                                                                          gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty/gmd:individualName/gco:CharacterString |
                                                                                                          gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorTransferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine/gmd:CI_OnlineResource/gmd:linkage/gmd:URL]">
                                                                                        <xsl:attribute name="WIDTH">210</xsl:attribute>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                        <xsl:attribute name="ALIGN">center</xsl:attribute>
                                                                                </xsl:otherwise>
                                                                        </xsl:choose>
                                                                        <font COLOR="#006400" FACE="Verdana" SIZE="2">
                                                                                <xsl:apply-templates select="/gisco:MD_Metadata/gmd:identificationInfo/gisco:graphOver/gisco:bgFileName | /gisco:MD_Metadata/gisco:DataIdent/gisco:graphOver/gisco:bgFileName"/>
                                                                        </font>
                                                                </td>
                                                        </xsl:if>
                                                        <!-- show format, file name, coordinate system, theme keywords -->
                                                        <xsl:if test="gisco:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:type/gmd:MD_KeywordTypeCode = 'discipline'">
                                                                <td class="sum_text">
                                                                                <xsl:call-template name="summary_tpl">
                                                                                        <xsl:with-param name="name" select="gisco:MD_Metadata/gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorFormat/gmd:MD_Format/gmd:name/gco:CharacterString"/>
                                                                                        <xsl:with-param name="label" select="'Data format: '"/>
                                                                                </xsl:call-template>
                                                                                <xsl:call-template name="summary_tpl">
                                                                                        <xsl:with-param name="name" select="gisco:MD_Metadata/gmd:referenceSystemInfo/gmd:MD_ReferenceSystem/gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:code/gco:CharacterString"/>
                                                                                        <xsl:with-param name="label" select="'Coordinate system: '"/>
                                                                                </xsl:call-template>
                                                                                <xsl:call-template name="summary_tpl">
                                                                                        <xsl:with-param name="name" select="gisco:MD_Metadata/gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString"/>
                                                                                        <xsl:with-param name="label" select="'Organisation: '"/>
                                                                                </xsl:call-template>
                                                                                <xsl:call-template name="summary_keys_tpl">
                                                                                        <xsl:with-param name="name" select="gisco:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:type/gmd:MD_KeywordTypeCode"/>
                                                                                        <xsl:with-param name="value" select="'discipline'"/>
                                                                                        <xsl:with-param name="label" select="'Theme keywords: '"/>
                                                                                        <xsl:with-param name="display" select="gisco:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:keyword/gco:CharacterString"/>
                                                                                </xsl:call-template>
                                                                                <xsl:call-template name="summary_tpl">
                                                                                        <xsl:with-param name="name" select="gisco:MD_Metadata/gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorTransferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine/gmd:CI_OnlineResource/gmd:linkage/gmd:URL"/>
                                                                                        <xsl:with-param name="label" select="'On line resource: '"/>
                                                                                </xsl:call-template>
                                                                </td>
                                                        </xsl:if>
                                                </tr>
                                        </table>
                                        <!-- build the toc -->
                                        <A name="Top"/>
                                        <H4>Gisco Metadata:</H4>
                                        <!-- label -->
                                        <ul class="toc">
                                                <!-- Metadata Identification -->
                                                <LI>
                                                        <A HREF="#Metadata_Information">Metadata Information</A>
                                                        <!-- label -->
                                                </LI>
                                                <!-- Root node "metadata" will always exist. Only add to TOC if it contains elements that describe the metadata. -->
                                                <xsl:if test="gisco:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification | gisco:MD_Metadata/gmd:dataQualityInfo">
                                                        <xsl:call-template name="toc_tpl">
                                                                <xsl:with-param name="name" select="gisco:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification"/>
                                                                <xsl:with-param name="label" select="'Data Identification'"/>
                                                                <xsl:with-param name="label_item" select="'Description'"/>
                                                        </xsl:call-template>

                        <LI>
                                <A>
                                        <xsl:attribute name="HREF">#<xsl:value-of select="generate-id(gisco:MD_Metadata/gmd:spatialRepresentationInfo)"/></xsl:attribute>
                                        Representation of Spatial Information
                                </A>
                        </LI>


                                                        <xsl:call-template name="toc_tpl">
                                                                <xsl:with-param name="name" select="gisco:MD_Metadata/gmd:dataQualityInfo"/>
                                                                <xsl:with-param name="label" select="'Data Quality'"/>
                                                                <xsl:with-param name="label_item" select="'Description'"/>
                                                        </xsl:call-template>
                                                        <xsl:if test="gisco:MD_Metadata/gmd:CRS | gisco:MD_Metadata/MdCoRefSys">
                                                                <xsl:call-template name="toc_tpl">
                                                                        <xsl:with-param name="name" select="gisco:MD_Metadata/gmd:CRS | gisco:MD_Metadata/MdCoRefSys"/>
                                                                        <xsl:with-param name="label" select="'Reference System Information'"/>
                                                                        <xsl:with-param name="label_item" select="'Description'"/>
                                                                </xsl:call-template>
                                                        </xsl:if>
                                                        <xsl:if test="not(gisco:MD_Metadata/gmd:CRS | gisco:MD_Metadata/MdCoRefSys)">
                                                                <xsl:call-template name="toc_tpl">
                                                                        <xsl:with-param name="name" select="gisco:MD_Metadata/gmd:referenceSystemInfo"/>
                                                                        <xsl:with-param name="label" select="'Reference System Information'"/>
                                                                        <xsl:with-param name="label_item" select="'Description'"/>
                                                                </xsl:call-template>
                                                        </xsl:if>
                                                        <xsl:call-template name="toc_tpl">
                                                                <xsl:with-param name="name" select="gisco:MD_Metadata/gmd:distributionInfo"/>
                                                                <xsl:with-param name="label" select="'Distribution Information'"/>
                                                                <xsl:with-param name="label_item" select="'Description'"/>
                                                        </xsl:call-template>

                                                <!-- added for GISCO -->
                                                <!-- Metadata Legislation -->
                                                <xsl:if test="gisco:MD_Metadata/gmd:legislationInformation">
                                                        <LI>
                                                                <A HREF="#Metadata_legislation">Metadata Legislation</A>
                                                        </LI>
                                                </xsl:if>
                                                <!-- Metadata Attribute Info -->
                                                <xsl:if test="gisco:MD_Metadata/gmd:entityAttributeInformation">
                                                        <LI>
                                                                <A HREF="#Metadata_AttributeInfo">Metadata Attribute Information</A>
                                                        </LI>
                                                </xsl:if>

                                                </xsl:if>
                                                <!-- added for GISCO -->
                                        </ul>
                                        <!-- Give legend used in this stylesheet -->
                                        <BLOCKQUOTE class="note">
                                                        <!-- label -->
      Metadata elements shown with blue text are defined in the
      International Organization for Standardization's (ISO) document 19115
      <I>Geographic Information - Metadata.</I>
      Elements shown with <FONT color="#2E8B00">green</FONT>
      text are defined by the Gisco project and will be documented as extentions to the
      ISO 19115. Elements shown with a green asterisk (<FONT color="#2E8B00">*</FONT>)
      will be automatically updated by ArcCatalog.
                                        </BLOCKQUOTE>
                                        <!-- PUT METADATA CONTENT ON THE HTML PAGE  -->
                                        <!-- Metadata Information -->
                                        <!-- Root node "metadata" will always exist. Only apply template if it contains elements that describe the metadata. -->
                                        <xsl:if test="gisco:MD_Metadata[gmd:parentIdentifier/gco:CharacterString | gmd:language/gco:CharacterString | gmd:characterSet/gmd:MD_CharacterSetCode | gmd:hierarchyLevel/gmd:MD_ScopeCode | gmd:hierarchyLevelName/gco:CharacterString | gmd:contact/gmd:CI_ResponsibleParty | gmd:dateStamp/gco:Date | gmd:metadataStandardName/gco:CharacterString | gmd:metadataStandardVersion/gco:CharacterString |
                                                                   gisco:mdMaint | gisco:mdConst]">
                                                <xsl:apply-templates select="gisco:MD_Metadata"/>
                                        </xsl:if>
                                        <!-- Resource Identification -->

                                        <xsl:apply-templates select="gisco:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification"/>
                                        <xsl:apply-templates select="gisco:MD_Metadata/gmd:spatialRepresentationInfo"/>

                                        <!-- Data Quality -->
                                        <xsl:apply-templates select="gisco:MD_Metadata/gmd:dataQualityInfo"/>
                                        <!-- Reference System -->
                                        <xsl:apply-templates select="gisco:MD_Metadata/gmd:referenceSystemInfo | gisco:MD_Metadata/gmd:CRS | gisco:MD_Metadata/MdCoRefSys"/>
                                        <!-- Distribution info -->
                                        <xsl:apply-templates select="gisco:MD_Metadata/gmd:distributionInfo"/>
                                        <!-- added for GISCO -->
                                        <!-- Metadata Legislation -->
                                        <xsl:if test="gisco:MD_Metadata/gmd:legislationInformation">
                                        <xsl:call-template name="legislationInfo_tpl"/>
                                        </xsl:if>
                                        <!-- Metadata Attribute Information -->
                                        <xsl:if test="gisco:MD_Metadata/gmd:entityAttributeInformation">
                                                <A name="Metadata_AttributeInfo">
                                                        <HR/>
                                                </A>
                                                <DL>
                                                <DT class="title_1"><B>Metadata Attribute Information : </B></DT>
                                                <BR/>
                                                <BR/>
                                                        <xsl:for-each select="gisco:MD_Metadata/gmd:entityAttributeInformation">

                                                                        <xsl:call-template name="attributeInfo_tpl"/>
                                                                        <br></br>
                                                </xsl:for-each>
                                                                <A HREF="#Top">Back to Top</A>
                                                </DL>
                                        </xsl:if>
                                        <!-- added for GISCO -->
                        </body>
                </html>
        </xsl:template>
        <!-- Thumbnail -->
        <xsl:template match="gisco:MD_Metadata/gmd:identificationInfo/gisco:graphOver/gisco:bgFileName | /gisco:MD_Metadata/gisco:DataIdent/gisco:graphOver/gisco:bgFileName">
                <img ID="thumbnail" ALIGN="absmiddle" STYLE="width:217; border:'2 outset #FFFFFF'; position:relative">
                        <xsl:attribute name="SRC"><xsl:value-of select="."/></xsl:attribute>
                </img>
                <br/>
                <br/>
        </xsl:template>
        <!-- Generic templates -->
        <xsl:template name="summary_tpl">
                <xsl:param name="name"/>
                <xsl:param name="label"/>
                <xsl:if test="$name">
                        <dt>
                                <b>
                                        <xsl:value-of select="$label"/>
                                </b>
                                <xsl:value-of select="$name"/>
                        </dt>
                        <br/>
                        <br/>
                </xsl:if>
        </xsl:template>
        <xsl:template name="summary_keys_tpl">
                <xsl:param name="name"/>
                <xsl:param name="value"/>
                <xsl:param name="label"/>
                <xsl:param name="display"/>
                <xsl:if test="$name[text() = $value]">
                        <dt>
                                <b>
                                        <xsl:value-of select="$label"/>
                                </b>
                                <xsl:for-each select="$name[text() = $value]">
                                        <xsl:for-each select="$display">
                                                <xsl:value-of select="."/>
                                                <xsl:text> </xsl:text>
                                        </xsl:for-each>
                                        <xsl:text> </xsl:text>
                                </xsl:for-each>
                        </dt>
                        <br/>
                        <br/>
                </xsl:if>
        </xsl:template>
        <xsl:template name="toc_tpl">
                <xsl:param name="name"/>
                <xsl:param name="label"/>
                <xsl:param name="label_item"/>
                <xsl:if test="count($name) = 1">
                        <LI>
                                <A>
                                        <xsl:attribute name="HREF">#<xsl:value-of select="generate-id($name)"/></xsl:attribute>
                                        <xsl:value-of select="$label"/>
                                </A>
                        </LI>
                </xsl:if>
                <xsl:if test="count($name) &gt; 1">
                        <LI>
                                <xsl:value-of select="$label"/>
                        </LI>
                        <xsl:for-each select="$name">
                                <LI STYLE="margin-left:0.5in">
                                        <A>
                                                <xsl:attribute name="HREF">#<xsl:value-of select="generate-id()"/></xsl:attribute>
                                                <xsl:value-of select="$label_item"/>
                                                <xsl:text> : </xsl:text>
                                                <xsl:number value="position()"/>
                                        </A>
                                </LI>
                        </xsl:for-each>
                </xsl:if>
        </xsl:template>
        <xsl:template name="display_select_tpl">
                <xsl:param name="name"/>
                <xsl:param name="label"/>
                <xsl:for-each select="$name">
                        <DT>
                                <xsl:if test="$name[@Sync = 'TRUE']">
                                        <FONT color="#2E8B00">*</FONT>
                                </xsl:if>
                                        <B>
                                                <xsl:value-of select="$label"/>
                                        </B>
                                <xsl:apply-templates select="$name"/>
                        </DT>
                </xsl:for-each>
        </xsl:template>
        <xsl:template name="display_value_tpl">
                <xsl:param name="name"/>
                <xsl:param name="label"/>
                <xsl:for-each select="$name">
                                                        <xsl:variable name="tmp"><xsl:value-of select="normalize-space($name)"/></xsl:variable>
                        <xsl:if test="not($tmp='')">
                        <DT>
                                <xsl:if test="$name[@Sync = 'TRUE']">
                                        <FONT color="#2E8B00">*</FONT>
                                </xsl:if>
                                        <B>
                                                <xsl:value-of select="$label"/>
                                        </B>
                                <xsl:value-of select="$name"/>
                        </DT>
                        </xsl:if>
                </xsl:for-each>
        </xsl:template>
        <xsl:template name="simple_select_tpl">
                <xsl:param name="name"/>
                <xsl:param name="label"/>
                <xsl:for-each select="$name">
                                        <xsl:variable name="tmp"><xsl:value-of select="normalize-space(.)"/></xsl:variable>
                        <xsl:if test="not($tmp='')">
                        <DT>
                                        <B>
                                                <xsl:value-of select="$label"/>
                                        </B>
                                <xsl:apply-templates select="$name"/>
                        </DT>
                        </xsl:if>
                </xsl:for-each>
        </xsl:template>

        <xsl:template name="simple_value_tpl">
                <xsl:param name="name"/>
                <xsl:param name="label"/>
<!--                
                <xsl:for-each select="$name">
-->
                        <xsl:variable name="tmp"><xsl:value-of select="normalize-space(.)"/></xsl:variable>
                        <xsl:if test="not($tmp='')">
                        <DT>
                                        <B>
                                                <xsl:value-of select="$label"/>
                                        </B>
                                <xsl:value-of select="$name"/>
                        </DT>
                        </xsl:if>
<!--                
                </xsl:for-each>
-->
        </xsl:template>

        <xsl:template name="simple_value_tpl_3">
                <xsl:param name="name"/>
                <xsl:param name="label"/>
                <xsl:for-each select="$name">
                                        <xsl:variable name="tmp"><xsl:value-of select="normalize-space(.)"/></xsl:variable>
                        <xsl:if test="not($tmp='')">
                                        <br/>
                                        <B>
                                                <xsl:value-of select="$label"/>
                                        </B>
                                <xsl:value-of select="."/>
                                </xsl:if>
                </xsl:for-each>
        </xsl:template>


        <!--template added by mri as it is not good idea to put layout html tags within generic template-->
        <xsl:template name="simple_value_tpl_2">
                <xsl:param name="name"/>
                <xsl:param name="label"/>
                <xsl:for-each select="$name">
                                        <xsl:variable name="tmp"><xsl:value-of select="normalize-space($name)"/></xsl:variable>
                        <xsl:if test="not($tmp='')">
                                        <B>
                                                <xsl:value-of select="$label"/>
                                        </B>
                                <xsl:value-of select="$name"/>
                                </xsl:if>
                </xsl:for-each>
        </xsl:template>

        <xsl:template name="simple_mult_tpl">
                <xsl:param name="name"/>
                <xsl:param name="label"/>
                <xsl:if test="$name[text()]">
                        <DT>
                                        <B>
                                                <xsl:value-of select="$label"/>
                                        </B>
                                <xsl:for-each select="$name[text()]">
                                        <xsl:value-of select="."/>
                                        <xsl:if test="position() != last()">, </xsl:if>
                                </xsl:for-each>
                        </DT>
                        <BR/>
                        <BR/>
                </xsl:if>
        </xsl:template>
        <xsl:template name="simple_fix_tpl">
                <xsl:param name="name"/>
                <xsl:param name="label"/>
                <xsl:for-each select="$name">
                                                        <xsl:variable name="tmp"><xsl:value-of select="normalize-space($name)"/></xsl:variable>
                        <xsl:if test="not($tmp='')">
                        <DT>
                                        <B>
                                                <xsl:value-of select="$label"/>
                                        </B>
                        </DT>
                        <PRE ID="original">
                                <xsl:value-of select="."/>
                        </PRE>
                        <SCRIPT>fix(original)</SCRIPT>
                        <BR/>
                        </xsl:if>
                </xsl:for-each>
        </xsl:template>
        <xsl:template name="simple_boolean_tpl">
                <xsl:param name="name"/>
                <xsl:param name="label"/>
                <xsl:for-each select="$name">
                        <DT>
                                        <B>
                                                <xsl:value-of select="$label"/>
                                        </B>
                                <xsl:choose>
                                        <xsl:when test=". = 'true'">Yes</xsl:when>
                                        <xsl:when test=". = 'false'">No</xsl:when>
                                        <xsl:otherwise>
                                                <xsl:value-of select="."/>
                                        </xsl:otherwise>
                                </xsl:choose>
                        </DT>
                </xsl:for-each>
        </xsl:template>



        <!-- Templates for matching the metadata description -->
        <xsl:template match="gisco:MD_Metadata">
                <A name="Metadata_Information">
                        <HR/>
                </A>
                <DL>
                        <DT class="title_1">
                                        <B>Metadata Information</B>
                                        <!-- label -->
                        </DT>
                        <BR/>
                        <BR/>
                        <DL class="common">
                                <DD>
                                        <xsl:call-template name="display_select_tpl">
                                                <!--<xsl:with-param name="name" select="gisco:mdLang/iso639-2:isoCode"/>-->
                                                <xsl:with-param name="name" select="gmd:language/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Metadata language: '"/>
                                        </xsl:call-template>


                <xsl:for-each select="gmd:characterSet/gmd:MD_CharacterSetCode">
                        <DT><B>Metadata character set: </B>
                                <xsl:value-of select="."/>
                        </DT>
                </xsl:for-each>
        <xsl:for-each select="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:characterSet/gmd:MD_CharacterSetCode">
                        <DT><B>Data character set: </B>
                                <xsl:value-of select="."/>
                        </DT>
                </xsl:for-each>


                                        <xsl:if test="gmd:language/gco:CharacterString | gmd:characterSet/gmd:MD_CharacterSetCode">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gmd:dateStamp/gco:Date"/>
                                                <xsl:with-param name="label" select="'Date that the metadata was created: '"/>
                                        </xsl:call-template>
                                        <xsl:if test="gmd:metadataMaintenance">
                                                <xsl:apply-templates select="gmd:metadataMaintenance"/>
                                        </xsl:if>

                                        <xsl:if test="(gmd:dateStamp) or (gisco:mdMaint)">
                                                <BR/>
                                        </xsl:if>
                                        <xsl:apply-templates select="gmd:contact"/>

                                        <xsl:call-template name="display_select_tpl">
                                                <xsl:with-param name="name" select="gmd:hierarchyLevel/gmd:MD_ScopeCode"/>
                                                <xsl:with-param name="label" select="'Scope of the data described by the metadata: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gmd:hierarchyLevelName/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Scope name: '"/>
                                        </xsl:call-template>
                                        <xsl:if test="gmd:hierarchyLevel | gmd:hierarchyLevelName">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gmd:metadataStandardName/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Name of the metadata standard used: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gmd:metadataStandardVersion/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Version of the metadata standard: '"/>
                                        </xsl:call-template>
                                        <xsl:if test="gmd:metadataStandardName | gmd:metadataStandardVersion">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
<!--                                        
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gmd:fileIdentifier/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Metadata identifier: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gmd:parentIdentifier/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Parent identifier: '"/>
                                        </xsl:call-template>
                                        <xsl:if test="gmd:fileIdentifier | gmd:parentIdentifier">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gmd:dataSetURI/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Dataset URI: '"/>
                                        </xsl:call-template>
-->
                                </DD>
                        </DL>
                </DL>
                <A HREF="#Top">Back to Top</A><br/>
        </xsl:template>


        <!-- Maintenance Information (B.2.5 MD_MaintenanceInformation - line142) -->
        <xsl:template match="gmd:metadataMaintenance | gmd:resourceMaintenance">
                         <xsl:variable name="name"><xsl:value-of select="name(.)"/></xsl:variable>
                <DD>
                        <xsl:choose>
                                <xsl:when test="$name = 'gmd:resourceMaintenance'">
                                        <DT class="title_2">
                                                        <B>Resource maintenance:</B>
                                                        <!-- label -->
                                        </DT>
                                        <!-- label -->
                                </xsl:when>
                                <xsl:otherwise>
                                        <DT class="title_2">
                                                        <B>Maintenance:</B>
                                                        <!-- label -->
                                        </DT>
                                        <!-- label -->
                                </xsl:otherwise>
                        </xsl:choose>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:MD_MaintenanceInformation/gmd:dateOfNextUpdate/gco:Date"/>
                                                <xsl:with-param name="label" select="'Date of next update: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_select_tpl">
                                                <xsl:with-param name="name" select="gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode"/>
                                                <xsl:with-param name="label" select="'Update frequency: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gisco:maintNote"/>
                                                <xsl:with-param name="label" select="'Other maintenance requirements: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>

        <!-- Responsible Party Information (B.3.2 CI_ResponsibleParty - line374) -->
        <xsl:template match="gmd:contact | gmd:CI_Citation/gmd:citedResponsibleParty | gmd:MD_Distributor/gmd:distributorContact">
                 <xsl:variable name="name"><xsl:value-of select="name(.)"/></xsl:variable>
                 <xsl:variable name="tmp1"><xsl:value-of select="normalize-space(gmd:CI_ResponsibleParty/gmd:individualName/gco:CharacterString)"/></xsl:variable>
                 <xsl:variable name="tmp2"><xsl:value-of select="normalize-space(gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString)"/></xsl:variable>
                 <xsl:variable name="tmp3"><xsl:value-of select="normalize-space(gmd:CI_ResponsibleParty/gmd:positionName/gco:CharacterString)"/></xsl:variable>
                 <xsl:variable name="tmp4"><xsl:for-each select="gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode"><xsl:value-of select="normalize-space(.)"/></xsl:for-each></xsl:variable>
                 <xsl:variable name="tmp5"><xsl:value-of select="normalize-space(gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:voice/gco:CharacterString)"/></xsl:variable>
                 <xsl:variable name="tmp6"><xsl:value-of select="normalize-space(gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:facsimile/gco:CharacterString)"/></xsl:variable>
                 <xsl:variable name="tmp7"><xsl:value-of select="normalize-space(gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:deliveryPoint/gco:CharacterString)"/></xsl:variable>
                 <xsl:variable name="tmp8"><xsl:value-of select="normalize-space(gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:city/gco:CharacterString)"/></xsl:variable>
                 <xsl:variable name="tmp9"><xsl:value-of select="normalize-space(gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:administrativeArea/gco:CharacterString)"/></xsl:variable>
                 <xsl:variable name="tmp10"><xsl:value-of select="normalize-space(gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:postalCode/gco:CharacterString)"/></xsl:variable>
                 <xsl:variable name="tmp11"><xsl:value-of select="normalize-space(gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:country/gco:CharacterString)"/></xsl:variable>
                 <xsl:variable name="tmp12"><xsl:value-of select="normalize-space(gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString)"/></xsl:variable>







                <DD>
                        <dt class="title_2">
                                        <xsl:choose>
                                                <xsl:when test="$name = 'gmd:contact'">
                                                        <B>Metadata contact:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="$name= 'idPoC'">
                                                        <B>Point of contact:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="$name = 'usrCntInfo'">
                                                        <B>Party using the resource:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="$name = 'stepProc'">
                                                        <B>Process contact:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="$name = 'gmd:distributorContact'">
                                                        <B>Contact information:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="$name = 'gmd:citedResponsibleParty'">
                                                        <B>Party responsible for the resource:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="$name = 'extEleSrc'">
                                                        <B>Extension source:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="$name = 'gelosRecordSource'">
                                                        <B>gelos Record Source:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="$name= 'etccdsRecordSource'">
                                                        <B>etc cds Record Source:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:otherwise>
                                                        <B>Contact information:</B>
                                                        <!-- label -->
                                                </xsl:otherwise>
                                        </xsl:choose>
                        </dt>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:CI_ResponsibleParty/gmd:individualName/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Individual name: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Organization name: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:CI_ResponsibleParty/gmd:positionName/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Contact position: '"/>
                                        </xsl:call-template>

                                        <xsl:call-template name="simple_value_tpl_3">
                                                <xsl:with-param name="name" select="gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode"/>
                                                <xsl:with-param name="label" select="'Contact role: '"/>
                                        </xsl:call-template>
                                        <xsl:if test="gmd:CI_ResponsibleParty/gmd:individualName | gmd:CI_ResponsibleParty/gmd:organisationName | gmd:CI_ResponsibleParty/gmd:positionName | gmd:CI_ResponsibleParty/gmd:role">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                        <xsl:apply-templates select="gmd:CI_ResponsibleParty/gmd:contactInfo"/>
                                </DL>
                        </DD>
                </DD>

        </xsl:template>



        <!-- Contact Information (B.3.2.2 CI_Contact - line387) -->
        <xsl:template match="gmd:CI_ResponsibleParty/gmd:contactInfo">
                <DD>
                        <DT class="title_2">
                                        <B>Contact information:</B>
                                        <!-- label -->
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:apply-templates select="gmd:CI_Contact/gmd:phone"/>
                                        <xsl:apply-templates select="gmd:CI_Contact/gmd:address"/>
                                        <xsl:apply-templates select="iso19115:cntOnlineRes"/>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>
        <!-- Telephone Information (B.3.2.6 CI_Telephone - line407) -->
        <xsl:template match="gmd:CI_Contact/gmd:phone">
                <DD>
                        <DT class="title_2">
                                        <B>Phone:</B>
                                        <!-- label -->
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:CI_Telephone/gmd:voice/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Voice: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:CI_Telephone/gmd:facsimile/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Fax: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                </DD>
                <BR/>
        </xsl:template>
        <!-- Address Information (B.3.2.1 CI_Address - line380) -->
        <xsl:template match="gmd:CI_Contact/gmd:address">
                <DD>
                        <DT class="title_2">
                                        <B>Address:</B>
                                        <!-- label -->
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_fix_tpl">
                                                <xsl:with-param name="name" select="gmd:CI_Address/gmd:deliveryPoint/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Delivery point: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:CI_Address/gmd:city/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'City: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:CI_Address/gmd:administrativeArea/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Administrative area: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:CI_Address/gmd:postalCode/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Postal code: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:CI_Address/gmd:country/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Country: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'E-mail address: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                </DD>
                <BR/>
        </xsl:template>

<!-- Online Resource Information (B.3.2.4 CI_OnLineResource - line396) -->
        <xsl:template match="iso19115:cntOnlineRes | gmd:MD_DigitalTransferOptions/gmd:onLine | gisco:extOnRes">
                      <xsl:variable name="name"><xsl:value-of select="name(.)"/></xsl:variable>
                <DD>
                        <xsl:choose>
                                <xsl:when test="$name = 'gmd:onLine'">
                                        <DT class="title_2">
                                                        <B>Online source:</B>
                                                        <!-- label -->
                                        </DT>
                                </xsl:when>
                                <xsl:when test="$name = 'extOnRes'">
                                        <DT class="title_2">
                                                        <B>Extension online resource:</B>
                                                        <!-- label -->
                                        </DT>
                                </xsl:when>
                                <xsl:otherwise>
                                        <DT class="title_2">
                                                        <B>Online resource:</B>
                                                        <!-- label -->
                                        </DT>
                                </xsl:otherwise>
                        </xsl:choose>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="iso19115:orName"/>
                                                <xsl:with-param name="label" select="'Name of resource: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gmd:CI_OnlineResource/gmd:linkage/gmd:URL"/>
                                                <xsl:with-param name="label" select="'Online location (URL): '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Connection protocol: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_select_tpl">
                                                <xsl:with-param name="name" select="gmd:CI_OnlineResource/gmd:function/gmd:CI_OnLineFunctionCode"/>
                                                <xsl:with-param name="label" select="'Function performed: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_select_OrDesc_tpl">
                                                <xsl:with-param name="name" select="gmd:CI_OnlineResource/gmd:description/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Description: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                </DD>
                <BR/>
        </xsl:template>

        <xsl:template name="simple_select_OrDesc_tpl">
                <xsl:param name="name"/>
                <xsl:param name="label"/>
                <xsl:for-each select="$name">
                        <xsl:variable name="tmp"><xsl:value-of select="normalize-space(.)"/></xsl:variable>
                        <xsl:if test="not($tmp='')">
                        <DT>
                                        <B>
                                                <xsl:value-of select="$label"/>
                                        </B>
                        <xsl:choose>
                                                <xsl:when test="substring($tmp,1,3) = '000'">None</xsl:when>
                                                <xsl:when test="substring($tmp,1,3) = '001'">Live Data and Maps</xsl:when>
                                                <xsl:when test="substring($tmp,1,3) = '002'">Downloadable Data</xsl:when>
                                                <xsl:when test="substring($tmp,1,3) = '003'">Offline Data</xsl:when>
                                                <xsl:when test="substring($tmp,1,3) = '004'">Static Map Images</xsl:when>
                                                <xsl:when test="substring($tmp,1,3) = '005'">Other Documents</xsl:when>
                                                <xsl:when test="substring($tmp,1,3) = '006'">Applications</xsl:when>
                                                <xsl:when test="substring($tmp,1,3) = '007'">Geographic Services</xsl:when>
                                                <xsl:when test="substring($tmp,1,3) = '008'">Clearinghouses</xsl:when>
                                                <xsl:when test="substring($tmp,1,3) = '009'">Map Files</xsl:when>
                                                <xsl:when test="substring($tmp,1,3) = '010'">Geographic Activities</xsl:when>
                                                <xsl:otherwise><xsl:value-of select="$tmp"/></xsl:otherwise>

                                        </xsl:choose>


                        </DT>
                        </xsl:if>
                </xsl:for-each>
        </xsl:template>




        <!-- RESOURCE IDENTIFICATION -->
        <!-- Resource Identification Information (B.2.2 MD_Identification - line23, including MD_DataIdentification - line36) -->
        <xsl:template match="gisco:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification">
                        <A name="Data_Identification">
                        <HR/></A>
                <DL>

                                <DT class="title_1">
                                                <B>Resource Identification Information:</B>
                                </DT>
                        <BR/>
                        <BR/>
                        <DL class="common">
                                <DD>
                                        <xsl:apply-templates select="gmd:citation"/>

                                        <xsl:call-template name="simple_mult_tpl">
                                                <xsl:with-param name="name" select="gmd:topicCategory/gmd:MD_TopicCategoryCode"/>
                                                <xsl:with-param name="label" select="'Themes or categories of the resource: '"/>
                                        </xsl:call-template>

                                        <xsl:apply-templates select="gmd:descriptiveKeywords/gmd:MD_Keywords"/>
                                        <xsl:call-template name="simple_fix_tpl">
                                                <xsl:with-param name="name" select="gmd:abstract/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Abstract: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_fix_tpl">
                                                <xsl:with-param name="name" select="gmd:purpose/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Purpose: '"/>
                                        </xsl:call-template>
                                        <xsl:apply-templates select="graphOver"/>
                                        <xsl:call-template name="simple_mult_tpl">
                                                <xsl:with-param name="name" select="gmd:language/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Dataset language: '"/>
                                        </xsl:call-template>
                                        <xsl:if test="gmd:language | gmd:characterSet">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                        <xsl:call-template name="simple_select_tpl">
                                                <xsl:with-param name="name" select="gmd:status/gmd:MD_ProgressCode"/>
                                                <xsl:with-param name="label" select="'Status: '"/>
                                        </xsl:call-template>
                                        <br/><br/>
                                        <xsl:apply-templates select="gmd:resourceMaintenance"/>
                                                <BR/>
                                        <br/>
                                        <xsl:apply-templates select="gmd:resourceConstraints/gmd:MD_Constraints | gmd:resourceConstraints/gmd:MD_LegalConstraints"/>
                                        <xsl:apply-templates select="gmd:resourceConstraints/gmd:MD_SecurityConstraints"/>
                                        <br/>
                                        <xsl:apply-templates select="gisco:idSpecUse"/>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:spatialRepresentationType/gmd:MD_SpatialRepresentationTypeCode"/>
                                                <xsl:with-param name="label" select="'Spatial representation type: '"/>
                                        </xsl:call-template>
                                        <xsl:apply-templates select="dsFormat"/>
                                        <xsl:if test="gisco:spatRpType and not (dsFormat)">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gisco:envirDesc"/>
                                                <xsl:with-param name="label" select="'Processing environment: '"/>
                                        </xsl:call-template>
                                        <xsl:apply-templates select="gmd:spatialResolution"/>
                                        <xsl:apply-templates select="gisco:geoBox"/>
                                        <xsl:apply-templates select="gisco:geoDesc"/>
                                        <xsl:apply-templates select="gmd:extent/gmd:EX_Extent"/>
                                        <xsl:call-template name="simple_fix_tpl">
                                                <xsl:with-param name="name" select="gisco:suppInfo"/>
                                                <xsl:with-param name="label" select="'Supplemental information: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_fix_tpl">
                                                <xsl:with-param name="name" select="gisco:idCredit"/>
                                                <xsl:with-param name="label" select="'Credits: '"/>
                                        </xsl:call-template>
                                        <xsl:apply-templates select="gisco:idPoC"/>
                                </DD>
                        </DL>
                </DL>
                <A HREF="#Top">Back to Top</A>
        </xsl:template>
        <!-- Citation Information (B.3.2 CI_Citation - line359) -->
        <xsl:template match="gmd:citation |  gmd:authority | gmd:evaluationProcedure | gmd:thesaurusName">
              <xsl:variable name="name"><xsl:value-of select="name(.)"/></xsl:variable>

        <xsl:variable name="tmp1"><xsl:value-of select="normalize-space(gmd:CI_Citation/gmd:title/gco:CharacterString)"/></xsl:variable>
        <xsl:variable name="tmp2"><xsl:value-of select="normalize-space(gmd:CI_Citation/gmd:alternateTitle/gco:CharacterString)"/></xsl:variable>
        <xsl:variable name="tmp3"><xsl:value-of select="normalize-space(gmd:CI_Citation/gmd:edition/gco:CharacterString)"/></xsl:variable>
        <xsl:variable name="tmp4"><xsl:value-of select="normalize-space(gmd:CI_Citation/gmd:editionDate/gco:Date)"/></xsl:variable>
        <xsl:variable name="tmp5"><xsl:value-of select="normalize-space(gmd:CI_Citation/gmd:presentationForm/gmd:CI_PresentationFormCode)"/></xsl:variable>


        <xsl:if test="not($tmp1='' or $tmp2='' or $tmp3='' or $tmp4='' or $tmp5='' )">

                <DD>
                        <DT class="title_2">
                                        <xsl:choose>
                                                <xsl:when test="$name = 'gmd:citation'">
                                                        <B>Citation:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="$name = 'gmd:thesaurusName'">
                                                        <B>Thesaurus name:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="$name = 'gmd:authority'">
                                                        <B>Reference that defines the value:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="$name = 'srcCitatn'">
                                                        <B>Source citation:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="$name= 'gmd:evaluationProcedure'">
                                                        <B>Description of evaluation procedure:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="$name = 'conSpec'">
                                                        <B>Description of conformance requirements:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="$name = 'paraCit'">
                                                        <B>Georeferencing parameters citation:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="$name = 'catCitation'">
                                                        <B>Feature catalogue citation:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="$name = 'asName'">
                                                        <B>Application schema name:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="$name = 'relation'">
                                                        <B>Relation: </B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:otherwise>
                                                        <B>Citation:</B>
                                                        <!-- label -->
                                                </xsl:otherwise>
                                        </xsl:choose>
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gmd:CI_Citation/gmd:title/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Title: '"/>
                                        </xsl:call-template>
                                        </DL>
                                        </DD>
                                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_mult_tpl">
                                                <xsl:with-param name="name" select="gmd:CI_Citation/gmd:alternateTitle/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Alternate titles: '"/>
                                        </xsl:call-template>
                                                                                </DL>
                                        </DD>
                                        <xsl:if test="not(gmd:alternateTitle)">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                        <DD>
                                <DL>
                                        <xsl:apply-templates select="gmd:CI_Citation/gmd:date/gmd:CI_Date"/>

                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:CI_Citation/gmd:edition/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Edition: '"/>
                                        </xsl:call-template>

                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:CI_Citation/gmd:editionDate/gco:Date"/>
                                                <xsl:with-param name="label" select="'Edition date: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="display_select_tpl">
                                                <xsl:with-param name="name" select="gmd:CI_Citation/gmd:presentationForm/gmd:CI_PresentationFormCode"/>
                                                <xsl:with-param name="label" select="'Presentation format: '"/>
                                        </xsl:call-template>
                                                                                </DL>
                                        </DD>
                                        <xsl:if test="gmd:CI_Citation/gmd:edition | gmd:CI_Citation/gmd:editionDate | gmd:CI_Citation/gmd:presentationForm">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="iso19115:isbn"/>
                                                <xsl:with-param name="label" select="'ISBN: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="iso19115:issn"/>
                                                <xsl:with-param name="label" select="'ISSN: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="iso19115:citId"/>
                                                <xsl:with-param name="label" select="'Unique resource identifier: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="iso19115:citIdType"/>
                                                <xsl:with-param name="label" select="'Reference of identifier: '"/>
                                        </xsl:call-template>
                                        <!-- not needed as not encoded via editor but tag is added for gisco validation purpose:
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="iso19115:identifierType"/>
                                                <xsl:with-param name="label" select="'Type of identifier: '"/>
                                        </xsl:call-template>
                                        <xsl:if test="iso19115:isbn | iso19115:issn | iso19115:citId | iso19115:citIdType | iso19115:identifierType">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                        -->
                                        <xsl:apply-templates select="gmd:CI_Citation/gmd:citedResponsibleParty"/>
                                        <BR/>

                </DD>
        </xsl:if>
        </xsl:template>

        <!-- Date Information (B.3.2.3 CI_Date) -->
        <xsl:template match="gmd:date/gmd:CI_Date">
                <DD>
                        <DT class="title_2">
                                        <B>Reference date:</B>
                                        <!-- label -->
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:date/gco:Date"/>
                                                <xsl:with-param name="label" select="'Date: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_select_tpl">
                                                <xsl:with-param name="name" select="gmd:dateType/gmd:CI_DateTypeCode"/>
                                                <xsl:with-param name="label" select="'Type of date: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                </DD>
                <BR/>
        </xsl:template>
        <!-- Keyword Information (B.2.2.2 MD_Keywords - line52)-->
        <xsl:template match="gmd:descriptiveKeywords/gmd:MD_Keywords | gisco:place | gisco:habitatType | gisco:issue">
                <DD>
                        <xsl:choose>
                                <xsl:when test="gmd:type/gmd:MD_KeywordTypeCode = 'discipline'">
                                        <DT class="title_2">
                                                        <B>Discipline keywords:</B>
                                                        <!--label -->
                                        </DT>
                                        <!-- label -->
                                </xsl:when>
                                <xsl:when test="gmd:type/gmd:MD_KeywordTypeCode = 'place'">
                                        <DT class="title_2">
                                                        <B>Place keywords:</B>
                                        </DT>
                                        <!-- label -->
                                </xsl:when>
                                <xsl:when test="gmd:type/gmd:MD_KeywordTypeCode = 'stratum'">
                                        <DT class="title_2">
                                                        <B>Stratum keywords:</B>
                                        </DT>
                                        <!-- label -->
                                </xsl:when>
                                <xsl:when test="gmd:type/gmd:MD_KeywordTypeCode = 'temporal'">
                                        <DT class="title_2">
                                                        <B>Temporal keywords:</B>
                                        </DT>
                                        <!-- label -->
                                </xsl:when>
                                <xsl:when test="gmd:type/gmd:MD_KeywordTypeCode = 'theme'">
                                        <DT class="title_2">
                                                        <B>Theme keywords:</B>
                                        </DT>
                                        <!-- label -->
                                </xsl:when>
                                <xsl:otherwise>
                                        <DT class="title_2">
                                                        <B>Descriptive keywords:</B>
                                        </DT>
                                        <!-- label -->
                                </xsl:otherwise>
                        </xsl:choose>
                        <DD>
                                <DL>
                                        <xsl:if test="(gmd:type/gmd:MD_KeywordTypeCode != 'discipline') and (gmd:type/gmd:MD_KeywordTypeCode != 'place') and (gmd:type/gmd:MD_KeywordTypeCode != 'stratum') and (gmd:type/gmd:MD_KeywordTypeCode != 'temporal') and (gmd:type/gmd:MD_KeywordTypeCode != 'theme')">
                                                <DT>
                                                                <B>Type of keywords:</B>
                                                        <xsl:value-of select="gmd:type/gmd:MD_KeywordTypeCode"/>
                                                </DT>
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                        <xsl:call-template name="simple_mult_tpl">
                                                <xsl:with-param name="name" select="gmd:keyword/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Keywords: '"/>
                                        </xsl:call-template>
                                        <font class="specific">
                                        <xsl:call-template name="simple_mult_tpl">
                                                <xsl:with-param name="name" select="gisco:keyID"/>
                                                <xsl:with-param name="label" select="'Keyword identifiers: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_mult_tpl">
                                                <xsl:with-param name="name" select="gisco:keyDesc"/>
                                                <xsl:with-param name="label" select="'Keyword descriptions: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gisco:thesaId"/>
                                                <xsl:with-param name="label" select="'Identifier of thesaurus: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gisco:thesaLan"/>
                                                <xsl:with-param name="label" select="'Language of thesaurus: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gisco:lanId"/>
                                                <xsl:with-param name="label" select="'Identifier of language: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gisco:thesaDesc"/>
                                                <xsl:with-param name="label" select="'Description of thesaurus: '"/>
                                        </xsl:call-template>
                                        </font>
                                        <!--<xsl:if test="gisco:thesaName"><br/><br/></xsl:if>-->
                                        <xsl:apply-templates select="gmd:thesaurusName"/>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>
        <!-- Usage Information (B.2.2.5 MD_Usage - line62) -->
        <xsl:template match="gisco:idSpecUse">
                <DD>
                        <DT class="title_2">
                                        <B>How the resource is used:</B>
                        </DT>
                        <!-- label -->
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gisco:specUsage"/>
                                                <xsl:with-param name="label" select="'Description: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gisco:usrDetLim"/>
                                                <xsl:with-param name="label" select="'How the resource must not be used: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>
        <!-- Constraints Information (B.2.3 MD_Constraints - line67) -->

        <xsl:template match="gmd:resourceConstraints/gmd:MD_SecurityConstraints">
                <DD>
    <DT class="title_2"><B>Security constraints: </B></DT>
    <DD>
    <DL>
            <xsl:for-each select="gmd:classification/gmd:MD_ClassificationCode">
      <xsl:variable name="tmp"><xsl:value-of select="."/></xsl:variable>

        <DT><FONT color="#0000AA"><B>Classification:</B></FONT>
<xsl:value-of select="$tmp"/>


        </DT>
</xsl:for-each>


    </DL>
    </DD>
  </DD>
        </xsl:template>

        <xsl:template match="gmd:resourceConstraints/gmd:MD_Constraints | gmd:resourceConstraints/gmd:MD_LegalConstraints">
                <DD>
                        <DT class="title_2">
                                        <B>Restrictions on the access and use:</B>
                        </DT>
                        <!-- label -->
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:useLimitation/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Limitation affecting the fitness for use: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_mult_tpl">
                                                <xsl:with-param name="name" select="gmd:accessConstraints/gmd:MD_RestrictionCode"/>
                                                <xsl:with-param name="label" select="'Access constraints: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_mult_tpl">
                                                <xsl:with-param name="name" select="gmd:useConstraints/gmd:MD_RestrictionCode"/>
                                                <xsl:with-param name="label" select="'Use constraints: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>
        <!-- Format Information (B.2.10.3 MD_Format - line284) -->
        <xsl:template match="gisco:dsFormat | gisco:distorFormat | gisco:distFormat">
                <DD>
                        <DT class="title_2">
                                        <xsl:choose>
                                                <xsl:when test="local-name() = 'dsFormat'">
                                                        <B>Resource format:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="local-name() = 'distorFormat'">
                                                        <B>Available format:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="local-name() = 'distFormat'">
                                                        <B>Distribution format:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:otherwise>
                                                        <B>Format:</B>
                                                        <!-- label -->
                                                </xsl:otherwise>
                                        </xsl:choose>
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gisco:formatName"/>
                                                <xsl:with-param name="label" select="'Format name: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gisco:formatVer"/>
                                                <xsl:with-param name="label" select="'Format version: '"/>
                                        </xsl:call-template>
                                        <xsl:if test="gisco:fileDecmTech != ''">
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gisco:fileDecmTech"/>
                                                <xsl:with-param name="label" select="'File decompression technique: '"/>
                                        </xsl:call-template>
                                        </xsl:if>
                                        <xsl:if test="gisco:formatName | gisco:formatVer">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>
        <!-- Resolution Information (B.2.2.4 MD_Resolution - line59) -->
        <xsl:template match="gmd:spatialResolution | gisco:srcScale">
                                 <xsl:variable name="name"><xsl:value-of select="name(.)"/></xsl:variable>
                <DD><br></br>
                        <xsl:choose>
                                <xsl:when test="$name = 'gmd:spatialResolution'">
                                        <DT class="title_2">
                                                        <B>Spatial resolution:</B>
                                                        <!-- label -->
                                        </DT>
                                        <!-- label -->
                                </xsl:when>
                                <xsl:when test="$name = 'srcScale'">
                                        <DT class="title_2">
                                                        <B>Resolution of the source data:</B>
                                                        <!-- label -->
                                        </DT>
                                        <!-- label -->
                                </xsl:when>
                                <xsl:otherwise>
                                        <DT class="title_2">
                                                        <B>Resolution:</B>
                                                        <!-- label -->
                                        </DT>
                                        <!-- label -->
                                </xsl:otherwise>
                        </xsl:choose>
                        <DD>
                                <DL>
                                        <xsl:apply-templates select="gmd:MD_Resolution/gmd:equivalentScale"/>
                                        <xsl:for-each select="gmd:MD_Resolution/gmd:distance">
                                                <DT class="title_2">
                                                                <B>Ground sample distance:</B>
                                                </DT>
                                                <!-- label -->
                                                <DD>
                                                        <DL>
                                                                <!-- value will be shown regardless of the subelement Integer, Real, or Decimal -->
                                                                <xsl:variable name="val"><xsl:for-each select="gco:Distance"><xsl:value-of select="@uom"></xsl:value-of></xsl:for-each></xsl:variable>
                                                                <xsl:call-template name="simple_value_tpl">
                                                                        <xsl:with-param name="name" select="gco:Distance"/>
                                                                        <xsl:with-param name="label" select="'Precision of spatial data: '"/>
                                                                </xsl:call-template>
                                                                <DT class="title_2">
                                                                        <B>Units of measure: </B>
                                                                </DT>
                                                                <DD>
                                                                <DL>
                                                                        <xsl:call-template name="simple_value_tpl">
                                                                                <xsl:with-param name="name" select="$val"/>
                                                                                <xsl:with-param name="label" select="'Units name: '"/>
                                                                        </xsl:call-template>
                                                                </DL>
                                                                </DD>

                                                                <xsl:if test="gco:Distance">
                                                                        <BR/>
                                                                        <BR/>
                                                                </xsl:if>
                                                        </DL>
                                                </DD>
                                        </xsl:for-each>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>
        <!-- Representative Fraction Information (B.2.2.3 MD_RepresentativeFraction - line56) -->
        <xsl:template match="gmd:MD_Resolution/gmd:equivalentScale">
                <DT class="title_2">
                                <B>Dataset's scale:</B>
                </DT>
                <DD>
                        <DL>
<!--
                        <xsl:variable name="val"><xsl:for-each select="gmd:MD_RepresentativeFraction"><xsl:value-of select="@uuid"></xsl:value-of></xsl:for-each></xsl:variable>
-->

                                <xsl:call-template name="simple_value_tpl">


                                        <xsl:with-param name="name" select="gmd:MD_RepresentativeFraction/@uuid"/>
                                        <xsl:with-param name="label" select="'Scale denominator: '"/>
                                </xsl:call-template>
                                <xsl:call-template name="simple_value_tpl">
                                        <xsl:with-param name="name" select="gisco:scale"/>
                                        <xsl:with-param name="label" select="'Fraction is derived from scale: '"/>
                                </xsl:call-template>
                        </DL>
                </DD>
                <BR/>
        </xsl:template>
        <!-- Units of Measurement Types (from ISO 19103 information in 19115 DTD) -->
        <xsl:template match="gisco:uom | gisco:_UnitOfMeasure | gisco:UomLength | gisco:UomScale | gisco:UomTime | gisco:UomArea | gisco:UomVolume | gisco:UomAngle | gisco:UomVelocity">
                <DT class="title_2">
                                <B>Units of measure: </B>
                </DT>
                <DD>
                        <DL>
                                <xsl:call-template name="simple_value_tpl">
                                        <xsl:with-param name="name" select="gisco:uomName"/>
                                        <xsl:with-param name="label" select="'Units name: '"/>
                                </xsl:call-template>
                                <xsl:call-template name="simple_value_tpl">
                                        <xsl:with-param name="name" select="gisco:uomSymbol"/>
                                        <xsl:with-param name="label" select="'Units symbol: '"/>
                                </xsl:call-template>
                        </DL>
                </DD>
                <BR/>
        </xsl:template>
        <!-- Bounding Box Information (B.3.1.1 EX_GeographicBoundingBox - line343) -->
        <xsl:template match="gisco:geoBox | gmd:geographicElement/gmd:EX_GeographicBoundingBox | gisco:GeoBndBox">
                                 <xsl:variable name="name"><xsl:value-of select="name(.)"/></xsl:variable>
                <DD>
                        <xsl:choose>
                                <xsl:when test="$name = 'geoBox'">
                                        <DT class="title_2">
                                                        <B>Resource's bounding rectangle:</B>
                                                        <!-- label -->
                                        </DT>
                                </xsl:when>
                                <xsl:otherwise>
                                        <DT class="title_2">
                                                        <B>Bounding rectangle:</B>
                                                        <!-- label -->
                                        </DT>
                                </xsl:otherwise>
                        </xsl:choose>
                        <DD>
                                <DL>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gmd:westBoundLongitude/gco:Decimal"/>
                                                <xsl:with-param name="label" select="'West longitude: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gmd:eastBoundLongitude/gco:Decimal"/>
                                                <xsl:with-param name="label" select="'East longitude: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gmd:northBoundLatitude/gco:Decimal"/>
                                                <xsl:with-param name="label" select="'North latitude: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gmd:southBoundLatitude/gco:Decimal"/>
                                                <xsl:with-param name="label" select="'South latitude: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gisco:altiBoundLongitude"/>
                                                <xsl:with-param name="label" select="'Altitude longitude: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gisco:altiBoundLatitude"/>
                                                <xsl:with-param name="label" select="'Altitude latitude: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                </DD>
                <BR/>
        </xsl:template>
        <!-- Geographic Description Information (B.3.1.1 EX_GeographicDescription - line348) -->
        <!--<xsl:template match="gisco:geoDesc | gisco:GeoExtent[@xsi:type = 'GeoDesc'] | gisco:GeoDesc">-->
        <!-- template for geoDesc has been added bellow-->
        <xsl:template match="gisco:GeoExtent[@xsi:type = 'GeoDesc'] | gisco:GeoDesc">
                <DD>
                        <DT class="title_2">
                                <B>Geographic description:</B>
                                        <!-- label -->
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_boolean_tpl">
                                                <xsl:with-param name="name" select="gisco:exTypeCode"/>
                                                <xsl:with-param name="label" select="'Extent contains the resource: '"/>
                                        </xsl:call-template>
                                        <xsl:apply-templates select="gisco:geoId"/>
                                        <xsl:if test="(gisco:exTypeCode) and not (gisco:geoId)">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>
        <xsl:template match="gisco:geoDesc">
                <xsl:if test="gisco:geoId/gisco:identCode != ''">
                <DD>
                        <DT class="title_2">
                                <B>Description of the resource's location:</B>
                                        <!-- label -->
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_boolean_tpl">
                                                <xsl:with-param name="name" select="gisco:exTypeCode"/>
                                                <xsl:with-param name="label" select="'Extent contains the resource: '"/>
                                        </xsl:call-template>
                                        <xsl:apply-templates select="gisco:geoId"/>
                                        <xsl:if test="(gisco:exTypeCode)">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                </DL>
                        </DD>
                </DD>
                </xsl:if>
        </xsl:template>
        <!-- Identifier Information (B.2.7.2 MD_Identifier - line205) -->
        <xsl:template match="gisco:geoId | gisco:refSysId | gisco:projection | gisco:ellipsoid | gisco:datum | gisco:refSysName |
      gisco:MdIdent | gisco:RS_Identifier | gisco:datumID">
                <DD>
                        <xsl:choose>
                                <xsl:when test="local-name() = 'geoId'">
                                        <DT class="title_2">
                                                        <B>Geographic identifier:</B>
                                        </DT>
                                        <!-- label -->
                                </xsl:when>
                                <!-- can't use this method to add headings for refSysID, projection, ellipsoid, and datum
          because all exist together inside MdCoRefSys - also affects RefSystem  refSysInfo-->
                                <xsl:when test="local-name() = 'refSysName'">
                                        <DT class="title_2">
                                                        <B>Reference system name identifier:</B>
                                        </DT>
                                        <!-- label -->
                                </xsl:when>
                                <xsl:when test="local-name() = 'datumID'">
                                        <DT class="title_2">
                                                        <B>Vertical datum:</B>
                                        </DT>
                                        <!-- label -->
                                </xsl:when>
                                <!-- don't include an xsl:otherwise so the identCode value will appear correctly indented under the heading -->
                        </xsl:choose>
                        <DD class="common">
                                <DL>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="iso19115:identCode"/>
                                                <xsl:with-param name="label" select="'Value: '"/>
                                        </xsl:call-template>
                                        <xsl:apply-templates select="iso19115:identAuth"/>
                                        <xsl:if test="(iso19115:identCode) and not (iso19115:identAuth)">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>
        <!-- Extent Information (B.3.1 EX_Extent - line334) -->
        <xsl:template match="gmd:extent/gmd:EX_Extent | gisco:scpExt | gisco:srcExt">
                         <xsl:variable name="name"><xsl:value-of select="name(.)"/></xsl:variable>
                <DD>
                        <DT class="title_2">
                                        <xsl:choose>
                                                <xsl:when test="$name = 'dataExt'">
                                                        <B>Other extent information:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="$name = 'scpExt'">
                                                        <B>Scope extent:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:when test="$name = 'srcExt'">
                                                        <B>Extent of the source data:</B>
                                                        <!-- label -->
                                                </xsl:when>
                                                <xsl:otherwise>
                                                        <B>Extent:</B>
                                                        <!-- label -->
                                                </xsl:otherwise>
                                        </xsl:choose>
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_fix_tpl">
                                                <xsl:with-param name="name" select="gisco:exDesc"/>
                                                <xsl:with-param name="label" select="'Extent description: '"/>
                                        </xsl:call-template>
                                        <xsl:if test="gisco:GeoExtent">
                                                <DT class="title_2">
                                                                <B>Geographic extent:</B>
                                                                <!-- label -->
                                                </DT>
                                                <DD>
                                                        <DD>
                                                                <DL>
                                                                        <xsl:apply-templates select="gisco:GeoExtent[@xsi:type = 'BoundPolyType']"/>
                                                                        <xsl:apply-templates select="gmd:EX_GeographicBoundingBox"/>
                                                                        <xsl:apply-templates select="gisco:GeoExtent[@xsi:type = 'GeoDescType']"/>
                                                                </DL>
                                                        </DD>
                                                </DD>
                                                <BR/>
                                        </xsl:if>
                                        <!-- added by mri-->
                                        <xsl:if test="gmd:geographicElement">
                                                <DT class="title_2">
                                                        <B>Geographic extent:</B>
                                                        <!-- label -->
                                                </DT>
                                                <DD>
                                                        <DD>
                                                                <DL>
                                                                        <xsl:apply-templates select="gisco:geoEle/gisco:BoundPoly"/>
                                                                        <xsl:apply-templates select="gmd:geographicElement/gmd:EX_GeographicBoundingBox"/>
                                                                        <xsl:apply-templates select="gisco:geoEle/gisco:GeoDesc"/>
                                                                </DL>
                                                        </DD>
                                                </DD>
                                                <BR/>
                                        </xsl:if>

                                        <xsl:apply-templates select="gmd:temporalElement/gmd:EX_TemporalExtent"/>
                                        <xsl:apply-templates select="gmd:verticalElement/gmd:EX_VerticalExtent"/>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>
        <!-- Bounding Polygon Information (B.3.1.1 EX_BoundingPolygon - line341) -->
        <xsl:template match="gisco:GeoExtent[@xsi:type = 'BoundPolyType'] | gisco:BoundPoly">
                <DD>
                        <DT class="title_2">
                                        <B>Bounding polygon:</B>
                                        <!-- label -->
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_boolean_tpl">
                                                <xsl:with-param name="name" select="gisco:exTypeCode"/>
                                                <xsl:with-param name="label" select="'Extent contains the resource: '"/>
                                        </xsl:call-template>
                                        <xsl:apply-templates select="gisco:polygon/gisco:polygon"/>
                                        <xsl:apply-templates select="gisco:box"/>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>
        <xsl:template match="gisco:polygon">
                <DD>
                        <DT class="title_2">
                                        <B>polygon:</B>
                                        <!-- label -->
                                        <!-- label -->
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:apply-templates select="gml:outerBoundaryIs"/>
                                        <xsl:apply-templates select="gml:innerBoundaryIs"/>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>
        <xsl:template match="gml:outerBoundaryIs | gml:innerBoundaryIs">
                <DD>
                        <xsl:choose>
                                <xsl:when test="local-name() = 'outerBoundaryIs'">
                                        <DT class="title_2">
                                                        <B>Outer boundaries:</B>
                                                        <!-- label -->
                                        </DT>
                                </xsl:when>
                                <xsl:otherwise>
                                        <DT class="title_2">
                                                        <B>Inner boundaries:</B>
                                                        <!-- label -->
                                        </DT>
                                </xsl:otherwise>
                        </xsl:choose>
                        <DD>
                                <DL>
                                        <xsl:apply-templates select="gml:LinearRing/gml:coord"/>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gml:LinearRing/gml:coordinates"/>
                                                <xsl:with-param name="label" select="'Coordinates values: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>
        <xsl:template match="gml:coord">
                <DD>
                        <DT class="title_2">
                                        <B>Coordinates:</B>
                                        <!-- label -->
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gml:X"/>
                                                <xsl:with-param name="label" select="'x: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gml:Y"/>
                                                <xsl:with-param name="label" select="'y: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gml:Z"/>
                                                <xsl:with-param name="label" select="'z: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>
        <!-- Temporal Extent Information (B.3.1.2 EX_TemporalExtent - line350) -->
        <xsl:template match="gmd:temporalElement/gmd:EX_TemporalExtent">
                <DD>
                        <DT class="title_2">
                                        <B>Temporal extent:</B>
                                        <!-- label -->
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gisco:instant"/>
                                                <xsl:with-param name="label" select="'Date - Time: '"/>
                                        </xsl:call-template>
                                        <xsl:variable name="begin"><xsl:value-of select="gmd:extent/gml:AbstractTimePrimitive/gml:beginPosition"/></xsl:variable>
                                        <xsl:variable name="beginFinal"><xsl:value-of select="substring($begin, 1, 4)"/>-<xsl:value-of select="substring($begin, 5, 2)"/>-<xsl:value-of select="substring($begin, 7,2)"/>
                                                <xsl:choose>
                                                        <xsl:when test="contains($begin, 'T')">
                                                                <xsl:value-of select="' T'"/><xsl:value-of select="substring($begin, 10, 2)"/>:<xsl:value-of select="substring($begin, 12, 2)"/>:<xsl:value-of select="substring($begin, 14, 2)"/>
                                                        </xsl:when>
                                                        <xsl:otherwise></xsl:otherwise>
                                                </xsl:choose>
                                        </xsl:variable>

                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="$beginFinal"/>
                                                <xsl:with-param name="label" select="'Beginning date: '"/>
                                        </xsl:call-template>
                                        <xsl:variable name="end"><xsl:value-of select="gmd:extent/gml:AbstractTimePrimitive/gml:endPosition"/></xsl:variable>
                                        <xsl:variable name="endFinal"><xsl:value-of select="substring($end, 1, 4)"/>-<xsl:value-of select="substring($end, 5, 2)"/>-<xsl:value-of select="substring($end, 7,2)"/>

                                                <xsl:choose>
                                                        <xsl:when test="contains($end, 'T')">
                                                                <xsl:value-of select="' T'"/><xsl:value-of select="substring($end, 10, 2)"/>:<xsl:value-of select="substring($end, 12, 2)"/>:<xsl:value-of select="substring($end, 14, 2)"/>
                                                        </xsl:when>
                                                        <xsl:otherwise></xsl:otherwise>
                                                </xsl:choose>
                                        </xsl:variable>


                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="$endFinal"/>
                                                <xsl:with-param name="label" select="'Ending date: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>

        <!-- Vertical Extent Information -->
        <xsl:template match="gmd:verticalElement/gmd:EX_VerticalExtent">
                <DD>
                        <DT class="title_2">
                                <B>Vertical extent:</B>
                                <!-- label -->
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:minimumValue/gco:Real"/>
                                                <xsl:with-param name="label" select="'Minimum value: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:maximumValue/gco:Real"/>
                                                <xsl:with-param name="label" select="'Maximum value: '"/>
                                        </xsl:call-template>
                                        <xsl:variable name="val"><xsl:for-each select="gmd:verticalCRS/gml:AbstractSingleCRS/gml:verticalCS/gml:VerticalCS/gml:identifier"><xsl:value-of select="@codeSpace"></xsl:value-of></xsl:for-each></xsl:variable>


                                        <xsl:call-template name="simple_value_tpl">
                                                <!--<xsl:with-param name="name" select="gisco:vertUoM/uomName"/>-->
                                                <xsl:with-param name="name" select="$val"/>
                                                <xsl:with-param name="label" select="'Unit of measure: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>
        <!-- Spatial Representation Information (B.2.6  MD_SpatialRepresentation - line156) -->
        <xsl:template match="gisco:MD_Metadata/gmd:spatialRepresentationInfo">
                <A>
                        <xsl:attribute name="NAME"><xsl:value-of select="generate-id()"/></xsl:attribute>
                        <HR/>
                </A>
                <DL>
                        <xsl:for-each select="gmd:MD_GridSpatialRepresentation">
                                                                <DT class="title_1"><B>Spatial Representation - Grid:</B></DT>
                                                                <BR/>
                        <BR/>
                        <xsl:apply-templates/>

                        </xsl:for-each>
                        <xsl:for-each select="gmd:MD_VectorSpatialRepresentation">
                                                        <DT class="title_1">                                                        <B>Spatial Representation - Vector:</B>                </DT>
                                                        <BR/>
                        <BR/>
                        <DL class="common"><DD><xsl:call-template name="vector_tpl"/></DD>        </DL>

                                </xsl:for-each>


                </DL>
                <A HREF="#Top">Back to Top</A>
        </xsl:template>
        <!-- Grid Information (B.2.6  MD_GridSpatialRepresentation - line157,
                MD_Georectified - line162, and MD_Georeferenceable - line170) -->

                 <xsl:template match="gmd:numberOfDimensions/gco:Integer">
      <DT><FONT color="#0000AA"><B>Number of dimensions: </B></FONT> <xsl:value-of select="."/></DT>
    </xsl:template>

     <xsl:template match="gmd:cellGeometry/gmd:MD_CellGeometryCode">
      <DT><FONT color="#0000AA"><B>Cell geometry: </B></FONT>
        <xsl:variable name="tmp" select="."/>
           <xsl:value-of select="$tmp"/>
        </DT>
    </xsl:template>




        <xsl:template match="gmd:transformationParameterAvailability/gco:Boolean">
        <DT>
               <FONT color="#0000AA"><B>Transformation parameters are available: </B></FONT>
               <xsl:variable name="tmp"> <xsl:value-of select="."/></xsl:variable>
          <xsl:choose>
            <xsl:when test="$tmp = '1'">Yes</xsl:when>
            <xsl:when test="$tmp = '0'">No</xsl:when>
            <xsl:otherwise><xsl:value-of  select="$tmp"/></xsl:otherwise>
           </xsl:choose>
      </DT>

        </xsl:template>
        <!-- Dimension Information (B.2.6.1 MD_Dimension - line179) -->
        <xsl:template match="gmd:axisDimensionProperties/gmd:MD_Dimension">
                <DD>
                        <DT class="title_2">
                                        <B>Axis dimensions properties:</B>
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="display_select_tpl">
                                                <xsl:with-param name="name" select="gmd:dimensionName/gmd:MD_DimensionNameTypeCode"/>
                                                <xsl:with-param name="label" select="'Dimension name: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gmd:dimensionSize/gco:Integer"/>
                                                <xsl:with-param name="label" select="'Dimension size: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gmd:resolution/gco:Measure"/>
                                                <xsl:with-param name="label" select="'Dimension Resolution: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>
        <xsl:template match="iso19115:_Measure | gisco:Angle | gisco:Area | gisco:Scale | gisco:Time | gisco:Velocity | gisco:Volume | gisco:Length">
                <DT class="title_2">
                                <xsl:choose>
                                        <xsl:when test="name() = 'Angle'">
                                                <B>Angle measure: </B>
                                        </xsl:when>
                                        <xsl:when test="name() = 'Area'">
                                                <B>Area measure: </B>
                                        </xsl:when>
                                        <xsl:when test="name() = 'Scale'">
                                                <B>Scale measure: </B>
                                        </xsl:when>
                                        <xsl:when test="name() = 'Time'">
                                                <B>Time measure: </B>
                                        </xsl:when>
                                        <xsl:when test="name() = 'Velocity'">
                                                <B>Velocity measure: </B>
                                        </xsl:when>
                                        <xsl:when test="name() = 'Volume'">
                                                <B>Volume measure: </B>
                                        </xsl:when>
                                        <xsl:when test="name() = 'Length'">
                                                <B>Length measure: </B>
                                        </xsl:when>
                                        <xsl:otherwise>
                                                <B>Measure: </B>
                                        </xsl:otherwise>
                                </xsl:choose>
                </DT>
                <!-- label -->
                <DD>
                        <DL>
                                <!-- value will be shown regardless of the subelement Integer, Real, or Decimal -->
                                <xsl:call-template name="simple_value_tpl">
                                        <xsl:with-param name="name" select="iso19115:value"/>
                                        <xsl:with-param name="label" select="'Value: '"/>
                                </xsl:call-template>
                                <xsl:call-template name="simple_value_tpl">
                                        <xsl:with-param name="name" select="iso19115:accuracy"/>
                                        <xsl:with-param name="label" select="'Accuracy: '"/>
                                </xsl:call-template>
                                <xsl:apply-templates select="gisco:uom"/>
                                <xsl:if test="(iso19115:value or iso19115:accuracy) and not (gisco:uom)">
                                        <BR/>
                                        <BR/>
                                </xsl:if>
                        </DL>
                </DD>
        </xsl:template>
        <!-- Vector Information (B.2.6  MD_VectorSpatialRepresentation - line176) -->
        <xsl:template name="vector_tpl">
        <xsl:for-each select="gmd:topologyLevel/gmd:MD_TopologyLevelCode">
                                                <xsl:variable name="tmp"><xsl:value-of select="normalize-space(.)"/></xsl:variable>
                                                <xsl:if test="not($tmp='')">
                                                        <DT><B>Level of topology for this dataset: </B>
                                                <xsl:apply-templates/>
                                                </DT>
                                                </xsl:if>
                                        </xsl:for-each>


                <xsl:apply-templates select="gmd:geometricObjects"/>
                <xsl:if test="gmd:topologyLevel and not (gmd:geometricObjects)">
                        <BR/>
                        <BR/>
                </xsl:if>
        </xsl:template>
        <!-- Geometric Object Information (B.2.6.2 MD_GeometricObjects - line183) -->
        <xsl:template match="gmd:geometricObjects">
                <DD>
                        <DT class="title_2">
                                        <B>Geometric objects:</B>
                        </DT>
                        <DD>
                                <DL>

                                        <xsl:for-each select="gmd:MD_GeometricObjects/gmd:geometricObjectType/gmd:MD_GeometricObjectTypeCode">
                                                <xsl:variable name="tmp"><xsl:value-of select="normalize-space(.)"/></xsl:variable>
                                                <xsl:if test="not($tmp='')">
                                                        <DT><B>Object type: </B>
                                                <xsl:apply-templates/>
                                                </DT>
                                                </xsl:if>
                                        </xsl:for-each>


                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gmd:MD_GeometricObjects/gmd:geometricObjectCount/gco:Integer"/>
                                                <xsl:with-param name="label" select="'Object count: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                </DD>
                <BR/>
        </xsl:template>
        <!-- Content Information (B.2.8 MD_ContentInformation - line232) -->
        <xsl:template match="gisco:contInfo">
                <A>
                        <xsl:attribute name="NAME"><xsl:value-of select="generate-id()"/></xsl:attribute>
                        <HR/>
                </A>
                <DL>
                        <DT class="title_1">
                                        <B>Content Information - Coverage Description:</B>
                                        <!-- label -->
                        </DT>
                        <BR/>
                        <BR/>
                        <DL class="common">
                                <DD>
                                        <xsl:call-template name="simple_select_tpl">
                                                <xsl:with-param name="name" select="gisco:contentTyp"/>
                                                <xsl:with-param name="label" select="'Type of information: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gisco:attDesc"/>
                                                <xsl:with-param name="label" select="'Attribute described by cell values: '"/>
                                        </xsl:call-template>
                                        <xsl:if test="gisco:attDesc | gisco:contentTyp">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                        <xsl:apply-templates select="gisco:covDim"/>
                                </DD>
                        </DL>
                </DL>
                <A HREF="#Top">Back to Top</A>
        </xsl:template>
        <!-- Range dimension Information (B.2.8.1 MD_RangeDimension - line256) -->
        <xsl:template match="gisco:covDim">
                <DD>
                        <DT class="title_2">
                                        <B>Cell value information:</B>
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gisco:dimDescrp"/>
                                                <xsl:with-param name="label" select="'Minimum and maximum values: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_select_tpl">
                                                <xsl:with-param name="name" select="gisco:seqID"/>
                                                <xsl:with-param name="label" select="'Band identifier: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>
        <xsl:template match="gisco:seqID">
                <DD>
                        <DL>
                                <xsl:call-template name="simple_value_tpl">
                                        <xsl:with-param name="name" select="iso19103:scope"/>
                                        <xsl:with-param name="label" select="'Scope: '"/>
                                </xsl:call-template>
                                <xsl:call-template name="simple_value_tpl">
                                        <xsl:with-param name="name" select="iso19103:aName"/>
                                        <xsl:with-param name="label" select="'Name: '"/>
                                </xsl:call-template>
                                <xsl:for-each select="iso19103:attributeType">
                                        <DT class="title_2">
                                                        <B>Attribute type:</B>
                                                        <!-- label -->
                                        </DT>
                                        <DD>
                                                <DL>
                                                        <xsl:call-template name="simple_value_tpl">
                                                                <xsl:with-param name="name" select="iso19103:scope"/>
                                                                <xsl:with-param name="label" select="'Scope: '"/>
                                                        </xsl:call-template>
                                                        <xsl:call-template name="simple_value_tpl">
                                                                <xsl:with-param name="name" select="iso19103:aName"/>
                                                                <xsl:with-param name="label" select="'Name: '"/>
                                                        </xsl:call-template>
                                                </DL>
                                        </DD>
                                </xsl:for-each>
                        </DL>
                </DD>
                <BR/>
        </xsl:template>
        <!-- Data Quality Information  (B.2.4 DQ_DataQuality - line78) -->
        <xsl:template match="gisco:MD_Metadata/gmd:dataQualityInfo">
                <A>
                        <xsl:attribute name="NAME"><xsl:value-of select="generate-id()"/></xsl:attribute>
                        <HR/>
                </A>
                <DL>
                        <xsl:if test="count(gmd:DQ_DataQuality) = 1">
                                <DT class="title_1">
                                                <B>Data Quality Information:</B>
                                </DT>
                        </xsl:if>
                        <xsl:if test="count(gmd:DQ_DataQuality) &gt; 1">
                                <DT class="title_1">
                                                <B>
       Data Quality - Description <xsl:number value="position()"/>:
      </B>
                                </DT>
                        </xsl:if>
                        <BR/>
                        <BR/>
                        <DL class="common">
                                <DD>
                                        <xsl:if test="gmd:DQ_DataQuality/gmd:scope">
                                                <xsl:apply-templates select="gmd:DQ_DataQuality/gmd:scope"/>
                                        </xsl:if>
                                        <xsl:if test="gmd:DQ_DataQuality/gmd:lineage">
                                                <xsl:apply-templates select="gmd:DQ_DataQuality/gmd:lineage"/>
                                        </xsl:if>
                                        <xsl:if test="gmd:DQ_DataQuality/gmd:report">
                                                <xsl:apply-templates select="gmd:DQ_DataQuality/gmd:report"/>
                                        </xsl:if>
                                </DD>
                        </DL>
                </DL>
                <A HREF="#Top">Back to Top</A>
        </xsl:template>
        <!-- Scope Information (B.2.4.4 DQ_Scope - line138) -->
        <xsl:template match="gmd:DQ_DataQuality/gmd:scope">
                        <DT class="title_2">
                                        <B>Scope of quality information:</B>
                        </DT>
                        <DD>
                                <DL>
                                <xsl:for-each select="gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode">
                                                <xsl:variable name="tmp"><xsl:value-of select="normalize-space(.)"/></xsl:variable>
                                                <xsl:if test="not($tmp='')">
                                                        <DT><B>Level of the data: </B><xsl:value-of select="$tmp"/>
</DT>
                                                </xsl:if>
                                        </xsl:for-each>
                                        <xsl:apply-templates select="gisco:scpLvlDesc"/>
                                        <xsl:if test="gisco:scpLvl and not (gisco:scpLvlDesc)">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                        <xsl:apply-templates select="gisco:scpExt"/>
                                </DL>
                        </DD>
        </xsl:template>
        <!-- Scope Description Information (B.2.5.1 MD_ScopeDescription - line149) -->
        <xsl:template match="gisco:scpLvlDesc | upScpDesc">
                <DD>
                        <xsl:if test="position() = 1">
                                <DT class="title_2">
                                                <B>Scope description:</B>
                                </DT>
                        </xsl:if>
                        <!--treat attributes-->
                        <xsl:call-template name="simple_value_tpl">
                                <xsl:with-param name="name" select="gisco:datasetSet"/>
                                <xsl:with-param name="label" select="'Dataset to which the information applies: '"/>
                        </xsl:call-template>
                        <xsl:call-template name="simple_value_tpl">
                                <xsl:with-param name="name" select="gisco:other"/>
                                <xsl:with-param name="label" select="'Class of information that does not fall into the other categories: '"/>
                        </xsl:call-template>
                        <xsl:call-template name="simple_select_tpl">
                                <xsl:with-param name="name" select="gisco:attribSet"/>
                                <xsl:with-param name="label" select="'Attributes: '"/>
                        </xsl:call-template>
                        <xsl:call-template name="simple_select_tpl">
                                <xsl:with-param name="name" select="gisco:featSet"/>
                                <xsl:with-param name="label" select="'Features: '"/>
                        </xsl:call-template>
                        <xsl:call-template name="simple_select_tpl">
                                <xsl:with-param name="name" select="gisco:featIntSet"/>
                                <xsl:with-param name="label" select="'Features instances: '"/>
                        </xsl:call-template>
                        <xsl:call-template name="simple_select_tpl">
                                <xsl:with-param name="name" select="gisco:attribIntSet"/>
                                <xsl:with-param name="label" select="'Attributes instances: '"/>
                        </xsl:call-template>
                        <xsl:if test="position() = last()">
                                <BR/>
                                <BR/>
                        </xsl:if>
                </DD>
        </xsl:template>
        <xsl:template match="gisco:attribSet | gisco:attribIntSet">
                <DD>
                        <xsl:for-each select="gisco:attrib">
                        <DT class="title_2">
                                        <B>Attribute: </B><xsl:value-of select="iso19109:objectName"/>
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_select_tpl">
                                                <xsl:with-param name="name" select="iso19109:memberName"/>
                                                <xsl:with-param name="label" select="'Member name: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="iso19109:definition"/>
                                                <xsl:with-param name="label" select="'definition: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_select_tpl">
                                                <xsl:with-param name="name" select="iso19109:constrainedBy"/>
                                                <xsl:with-param name="label" select="'constrained by: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_select_tpl">
                                                <xsl:with-param name="name" select="iso19109:valueType"/>
                                                <xsl:with-param name="label" select="'value type: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_select_tpl">
                                                <xsl:with-param name="name" select="iso19109:valueDomain"/>
                                                <xsl:with-param name="label" select="'value domain: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_select_tpl">
                                                <xsl:with-param name="name" select="iso19109:cardinality"/>
                                                <xsl:with-param name="label" select="'cardinality: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_select_tpl">
                                                <xsl:with-param name="name" select="iso19109:characterizedBy"/>
                                                <xsl:with-param name="label" select="'characterized by: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_select_tpl">
                                                <xsl:with-param name="name" select="iso19109:characterizes"/>
                                                <xsl:with-param name="label" select="'characterizes: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                        <BR/>
                        </xsl:for-each>
                </DD>
        </xsl:template>
        <xsl:template match="gisco:featSet | gisco:featIntSet">
                <DD>
                        <DT class="title_2">
                                        <B>Feature:</B>
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:apply-templates/>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>
        <!-- Lineage Information (B.2.4.1 LI_Lineage - line82) -->
        <xsl:template match="gmd:DQ_DataQuality/gmd:lineage">
                        <DT class="title_2">
                                        <B>Lineage:</B>
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_fix_tpl">
                                                <xsl:with-param name="name" select="gmd:LI_Lineage/gmd:statement/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Lineage statement: '"/>
                                        </xsl:call-template>
                                        <xsl:apply-templates select="gmd:LI_Lineage/gmd:processStep/gmd:LI_ProcessStep"/>
                                        <xsl:apply-templates select="gmd:LI_Lineage/gmd:source/gmd:LI_Source"/>
                                </DL>
                        </DD>
        </xsl:template>
        <!-- Process Step Information (B.2.4.1.1 LI_ProcessStep - line86) -->
        <xsl:template match="gmd:LI_Lineage/gmd:processStep/gmd:LI_ProcessStep">
                        <DT class="title_2">
                                        <B>Process step:</B>
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_fix_tpl">
                                                <xsl:with-param name="name" select="gmd:description/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Description of the event in the creation process: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
        </xsl:template>
        <!-- Source Information (B.2.4.1.2 LI_Source - line92) -->
        <xsl:template match=" gmd:LI_Lineage/gmd:source/gmd:LI_Source">
                        <DT class="title_2">
                                        <B>Source data:</B>
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_fix_tpl">
                                                <xsl:with-param name="name" select="gmd:description/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Level of the source data: '"/>
                                        </xsl:call-template>
                                        <xsl:apply-templates select="gisco:srcCitatn"/>
                                </DL>
                        </DD>
        </xsl:template>
        <xsl:template match="gmd:DQ_DataQuality/gmd:report">
                <DD>
                        <DT class="title_2">
                                        <xsl:choose>
                                                <xsl:when test="gmd:DQ_CompletenessCommission">
                                                        <B>Data quality report - Completeness commission:</B>
                                                </xsl:when>
                                                <xsl:when test="gmd:DQ_CompletenessOmission">
                                                        <B>Data quality report - Completeness omission:</B>
                                                </xsl:when>
                                                <xsl:when test="gmd:DQ_ConceptualConsistency">
                                                        <B>Data quality report - Conceptual consistency:</B>
                                                </xsl:when>
                                                <xsl:when test="gmd:DQ_DomainConsistency">
                                                        <B>Data quality report - Domain consistency:</B>
                                                </xsl:when>
                                                <xsl:when test="gmd:DQ_FormatConsistency">
                                                        <B>Data quality report - Format consistency:</B>
                                                </xsl:when>
                                                <xsl:when test="gmd:DQ_TopologicalConsistency">
                                                        <B>Data quality report - Topological consistency:</B>
                                                </xsl:when>
                                                <xsl:when test="gmd:DQ_AbsoluteExternalPositionalAccuracy">
                                                        <B>Data quality report - Absolute external positional accuracy:</B>
                                                </xsl:when>
                                                <xsl:when test="gmd:DQ_GriddedDataPositionalAccuracy">
                                                        <B>Data quality report - Gridded data positional accuracy:</B>
                                                </xsl:when>
                                                <xsl:when test="gmd:DQ_RelativeInternalPositionalAccuracy">
                                                        <B>Data quality report - Relative internal positional accuracy:</B>
                                                </xsl:when>
                                                <xsl:when test="gmd:DQ_AccuracyOfATimeMeasurement">
                                                        <B>Data quality report - Accuracy of a time measurement:</B>
                                                </xsl:when>
                                                <xsl:when test="gmd:DQ_TemporalConsistency">
                                                        <B>Data quality report - Temporal consistency:</B>
                                                </xsl:when>
                                                <xsl:when test="gmd:DQ_TemporalValidity">
                                                        <B>Data quality report - Temporal validity:</B>
                                                </xsl:when>
                                                <xsl:when test="gmd:DQ_ThematicClassificationCorrectness">
                                                        <B>Data quality report - Thematic classification correctness:</B>
                                                </xsl:when>
                                                <xsl:when test="gmd:DQ_NonQuantitativeAttributeAccuracy">
                                                        <B>Data quality report - Non quantitative attribute accuracy:</B>
                                                </xsl:when>
                                                <xsl:when test="gmd:DQ_QuantitativeAttributeAccuracy">
                                                        <B>Data quality report - Quantitative attribute accuracy:</B>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                        <B>Data quality report</B>
                                                </xsl:otherwise>
                                        </xsl:choose>
                        </DT>
                                <xsl:call-template name="dataQualityDetails"/>

                </DD>
        </xsl:template>

        <xsl:template name="dataQualityDetails">
                        <DD>
                        <DL>
                                <xsl:call-template name="simple_value_tpl">
                                        <xsl:with-param name="name" select="node()/gmd:nameOfMeasure/gco:CharacterString"/>
                                        <xsl:with-param name="label" select="'Name of the test: '"/>
                                </xsl:call-template>
                                </DL>
                                </DD>
                                <dd><dl>
                                <xsl:call-template name="simple_select_tpl">
                                        <xsl:with-param name="name" select="node()/gmd:evaluationMethodType/gmd:DQ_EvaluationMethodTypeCode"/>
                                        <xsl:with-param name="label" select="'Type of test: '"/>
                                </xsl:call-template>
                                </dl></dd>
<dd><dl>

                                <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="node()/gmd:dateTime/gco:DateTime"/>
                                                <xsl:with-param name="label" select="'Date of the test: '"/>
                                </xsl:call-template>
                                </dl></dd>
                                <xsl:if test="node()/gmd:nameOfMeasure | node()/gmd:evaluationMethodType | node()/gmd:dateTime">
                                        <BR/>
                                        <BR/>
                                </xsl:if>
                                <dd><dl>

                                <xsl:call-template name="simple_fix_tpl">
                                        <xsl:with-param name="name" select="node()/gmd:measureDescription/gco:CharacterString"/>
                                        <xsl:with-param name="label" select="'Measure produced by the test: '"/>
                                </xsl:call-template>
                                </dl></dd>
                                <dd><dl>

                                <xsl:call-template name="simple_fix_tpl">
                                        <xsl:with-param name="name" select="node()/gmd:evaluationMethodDescription/gco:CharacterString"/>
                                        <xsl:with-param name="label" select="'Evaluation method: '"/>
                                </xsl:call-template>
                                </dl></dd>
                                <xsl:for-each select="node()/gmd:measureIdentification/gmd:MD_Identifier">
                                <xsl:variable name="tmp1" select="normalize-space(gmd:code/gco:CharacterString)"></xsl:variable>
                                <xsl:variable name="tmp2" select="normalize-space(gmd:authority/gmd:CI_Citation/gmd:title)"></xsl:variable>
                                <xsl:if test="not($tmp1='' or $tmp2='')">

                                <dd><dl>

                                        <DT class="title_2">
                                                <B>Registered standard procedure:</B>
                                                </DT>
                                                <DD>
                                                <DL>
                                                        <xsl:call-template name="display_value_tpl">
                                                                        <xsl:with-param name="name" select="gmd:code/gco:CharacterString"/>
                                                                        <xsl:with-param name="label" select="'Value: '"/>
                                                        </xsl:call-template>
                                                        <xsl:apply-templates select="gmd:authority"/>
                                                                <xsl:if test="(gmd:code) and not (gmd:authority)">
                                                                        <BR/>
                                                                        <BR/>
                                                                </xsl:if>
                                                </DL>
                                                </DD>


                                        </dl></dd>
                                </xsl:if>
                                </xsl:for-each>
                                <dd><dl>
                                <xsl:apply-templates select="node()/gmd:evaluationProcedure"/>
                                <xsl:apply-templates select="node()/gmd:result/gmd:DQ_ConformanceResult"/>
                                <xsl:apply-templates select="node()/gmd:result/gmd:DQ_QuantitativeResult"/>
                                </dl></dd>
        </xsl:template>

        <!-- Conformance Result Information (B.2.4.3 DQ_ConformanceResult - line129) -->
        <xsl:template match="gmd:result/gmd:DQ_ConformanceResult">
                <DD>
                        <DT class="title_2">
                                        <B>Conformance test results:</B>
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_boolean_tpl">
                                                <xsl:with-param name="name" select="gmd:pass/gco:Boolean"/>
                                                <xsl:with-param name="label" select="'Test passed: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:explanation/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Meaning of the result: '"/>
                                        </xsl:call-template>
                                        <xsl:if test="gmd:pass | gmd:explanation">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                        <xsl:apply-templates select="gmd:specification"/>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>
        <!-- Quantitative Result Information (B.2.4.3 DQ_QuantitativeResult - line133) -->
        <xsl:template match="iso19115:measResult[@xsi:type = 'gisco:QuanResultType']">
                <DD>
                        <DT class="title_2">
                                        <B>Quality test results:</B>
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:valueType/gco:RecordType"/>
                                                <xsl:with-param name="label" select="'Values required for conformance: '"/>
                                        </xsl:call-template>
                                        <xsl:apply-templates select="gmd:valueUnit/gml:UnitDefinition | gisco:_UnitOfMeasure | gisco:UomLength | gisco:UomScale | gisco:UomTime | gisco:UomArea | gisco:UomVolume | gisco:UomAngle | gisco:UomVelocity"/>
                                        <xsl:apply-templates select="gmd:value"/>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:errorStatistic/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Statistic method used to determine teh value: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>
        <xsl:template match="gmd:value">
                <DD>
                        <DT class="title_2">
                                        <B>Quantitative value:</B>
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gisco:otherValue"/>
                                                <xsl:with-param name="label" select="'Other value: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gco:Record"/>
                                                <xsl:with-param name="label" select="'Record value: '"/>
                                        </xsl:call-template>
                                        <xsl:if test="gisco:otherValue | gco:Record">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>
        <!-- Reference System Information (B.2.7 MD_ReferenceSystem - line186) -->
        <xsl:template match="gisco:MD_Metadata/gmd:referenceSystemInfo | gisco:MD_Metadata/gmd:CRS | gisco:MD_Metadata/MdCoRefSys">

                 <xsl:variable name="sname"><xsl:value-of select="name(.)"/></xsl:variable>
                <A>
                        <xsl:attribute name="NAME"><xsl:value-of select="generate-id()"/></xsl:attribute>
                        <HR/>
                </A>
                <DL>
                        <!--xsl:if test="count(gisco:MD_Metadata/gmd:referenceSystemInfo | gisco:MD_Metadata/gisco:MdCoRefSys | gisco:MD_Metadata/MdCoRefSys) = 1"-->

                                <DT class="title_1">
                                                <B>Reference System Information:</B>
                                </DT>
                        <!--/xsl:if-->
                        <xsl:if test="count(gisco:MD_Metadata/gmd:referenceSystemInfo | gisco:MD_Metadata/gmd:CRS | gisco:MD_Metadata/MdCoRefSys) &gt; 1">
                                <DT class="title_1">
                                                <B>
        Reference System Information - System <xsl:number value="position()"/>: </B>
                                </DT>
                        </xsl:if>
                        <BR/>
                        <BR/>
                        <DL class="common">
                                <DD>
                                        <xsl:choose>
                                                <xsl:when test="$sname = 'MdCoRefSys'">
                                                        <xsl:call-template name="CoRefSys_tpl"/>
                                                </xsl:when>
                                                <xsl:when test="$sname = 'gmd:CRS'">
                                                        <xsl:call-template name="CRS_tpl"/>
                                                </xsl:when>

                                                <xsl:otherwise>
                                                        <xsl:call-template name="RefSys_tpl"/>
                                                </xsl:otherwise>
                                        </xsl:choose>
                                </DD>
                        </DL>
                </DL>
                <A HREF="#Top">Back to Top</A>
        </xsl:template>
        <!-- Reference System Information (B.2.7 MD_ReferenceSystem - line186) -->
        <xsl:template name="RefSys_tpl">
                <DT class="title_3">
                                <B>Reference system identifier: </B>
                </DT>
                <xsl:apply-templates select="gmd:MD_ReferenceSystem/gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:code/gco:CharacterString"/>
                <BR/>
        </xsl:template>
        <!-- Metadata for Coordinate Systems (B.2.7 MD_CRS - line189) -->
        <xsl:template name="CoRefSys_tpl">
                        <DT class="title_2">
                                        <B>Reference system identifier:</B>
                        </DT>
                        <dl>
                                <dt>Customized

                                </dt>
                        </dl>
                <xsl:if test="projection">
                        <DT class="title_2">
                                        <B>Projection identifier:</B>
                        </DT>
                        <xsl:apply-templates select="projection/gmd:code/gco:CharacterString"/>
                </xsl:if>
                <xsl:if test="ellipsoid">
                        <DT class="title_2">
                                        <B>Ellipsoid identifier:</B>
                        </DT>
                        <xsl:apply-templates select="ellipsoid/gmd:code/gco:CharacterString"/>
                </xsl:if>
                <xsl:if test="datum">
                        <DT class="title_2">
                                        <B>Datum identifier:</B>
                        </DT>
                        <xsl:apply-templates select="datum/gmd:code/gco:CharacterString"/>
                </xsl:if>
                <xsl:apply-templates select="projParas"/>
                <xsl:apply-templates select="ellParas"/>
                <BR/>
        </xsl:template>

        <xsl:template name="CRS_tpl">
                        <DT class="title_2">
                                        <B>Reference system identifier:</B>
                        </DT>
                        <dl>
                                <dt>Customized

                                </dt>
                        </dl>
                <xsl:if test="gmd:projection">
                        <DT class="title_2">
                                        <B>Projection identifier: </B>
                        </DT>
                        <xsl:apply-templates select="gmd:projection/gmd:RS_Identifier/gmd:code/gco:CharacterString"/>
                </xsl:if>
                <xsl:if test="gmd:ellipsoid">
                        <DT class="title_2">
                                        <B>Ellipsoid identifier: </B>
                        </DT>
                        <xsl:apply-templates select="gmd:ellipsoid/gmd:RS_Identifier/gmd:code/gco:CharacterString"/>
                </xsl:if>
                <xsl:if test="gmd:datum">
                        <DT class="title_2">
                                        <B>Datum identifier: </B>
                        </DT>
                        <xsl:apply-templates select="gmd:datum/gmd:RS_Identifier/gmd:code/gco:CharacterString"/>
                </xsl:if>
                <xsl:apply-templates select="gmd:projectionParameters/gmd:MD_ProjectionParameters"/>
                <xsl:apply-templates select="gmd:ellipsoidParameters/gmd:MD_EllipsoidParameters"/>
                <BR/>
        </xsl:template>


<xsl:template match="gmd:projectionParameters/gmd:MD_ProjectionParameters">
                <DD>
                        <DT class="title_2">
                                        <B>Projection parameters:</B>
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:zone/gco:Integer"/>
                                                <xsl:with-param name="label" select="'Zone number: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:standardParallel/gmd:realLatitude"/>
                                                <xsl:with-param name="label" select="'Standard parallel: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:longitudeOfCentralMeridian/gmd:realLongitude"/>
                                                <xsl:with-param name="label" select="'Longitude of central meridian: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:latitudeOfProjectionOrigin/gmd:realLatitude"/>
                                                <xsl:with-param name="label" select="'Latitude of projection origin: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:scaleFactorAtEquator/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Scale factor at equator: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:heightOfProspectivePointAboveSurface/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Height of prospective point above surface: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:longitudeOfProjectionCenter/gmd:realLongitude"/>
                                                <xsl:with-param name="label" select="'Longitude of projection center: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:latitudeOfProjectionCenter/gmd:realLatitude"/>
                                                <xsl:with-param name="label" select="'Latitude of projection center: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:scaleFactorAtCenterLine/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Scale factor at center line: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:straightVerticalLongitudeFromPole/gmd:realLongitude"/>
                                                <xsl:with-param name="label" select="'Straight vertical longitude from pole: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:scaleFactorAtProjectionOrigin/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Scale factor at projection origin: '"/>
                                        </xsl:call-template>
                                        <xsl:if test="gmd:zone | gmd:stanParal | gmd:longCntMer | gmd:latProjOri | gmd:sclFacEqu |
                      gmd:hgtProsPt | gmd:longProjCnt | gmd:latProjCnt | gmd:sclFacCnt | gmd:stVrLongPl | gmd:sclFacPrOr">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:falseEasting/gmd:nonNegativeReal"/>
                                                <xsl:with-param name="label" select="'False easting: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:falseNorthing/gmd:nonNegativeReal"/>
                                                <xsl:with-param name="label" select="'False northing: '"/>
                                        </xsl:call-template>
                                        <xsl:for-each select="gmd:falseEastingNorthingUnits/gml:UnitDefinition/gml:identifier">
                                                <xsl:variable name="rrrr"><xsl:value-of select="@codeSpace"/></xsl:variable>

                                                        <xsl:call-template name="simple_value_tpl">
                                                                <xsl:with-param name="name" select="$rrrr"/>
                                                                <xsl:with-param name="label" select="'False easting northing units: '"/>
                                                        </xsl:call-template>

                                        </xsl:for-each>
                                        <xsl:if test="(gmd:falEastng | gmd:falNorthng | gmd:falENUnits)">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>


        <!-- Projection Parameter Information (B.2.7.5 MD_ProjectionParameters - line215) -->
        <xsl:template match="projParas">
                <DD>
                        <DT class="title_2">
                                        <B>Projection parameters:</B>
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="zone"/>
                                                <xsl:with-param name="label" select="'Zone number: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="stanParal"/>
                                                <xsl:with-param name="label" select="'Standard parallel: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="longCntMer"/>
                                                <xsl:with-param name="label" select="'Longitude of central meridian: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="latProjOri"/>
                                                <xsl:with-param name="label" select="'Latitude of projection origin: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="sclFacEqu"/>
                                                <xsl:with-param name="label" select="'Scale factor at equator: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="hgtProsPt"/>
                                                <xsl:with-param name="label" select="'Height of prospective point above surface: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="longProjCnt"/>
                                                <xsl:with-param name="label" select="'Longitude of projection center: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="latProjCnt"/>
                                                <xsl:with-param name="label" select="'Latitude of projection center: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="sclFacCnt"/>
                                                <xsl:with-param name="label" select="'Scale factor at center line: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="stVrLongPl"/>
                                                <xsl:with-param name="label" select="'Straight vertical longitude from pole: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="sclFacPrOr"/>
                                                <xsl:with-param name="label" select="'Scale factor at projection origin: '"/>
                                        </xsl:call-template>
                                        <xsl:if test="zone | stanParal | longCntMer | latProjOri | sclFacEqu |
                      hgtProsPt | longProjCnt | latProjCnt | sclFacCnt | stVrLongPl | sclFacPrOr">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="falEastng"/>
                                                <xsl:with-param name="label" select="'False easting: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="falNorthng"/>
                                                <xsl:with-param name="label" select="'False northing: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_select_tpl">
                                                <xsl:with-param name="name" select="falENUnits"/>
                                                <xsl:with-param name="label" select="'False easting northing units: '"/>
                                        </xsl:call-template>
                                        <xsl:if test="(falEastng | falNorthng | falENUnits)">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>


        <xsl:template match="gmd:ellipsoidParameters/gmd:MD_EllipsoidParameters">
                <DD>
                        <DT class="title_2">
                                        <B>Ellipsoid parameters:</B>
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:semiMajorAxis/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Semi-major axis: '"/>
                                        </xsl:call-template>
                                        <xsl:for-each select="gmd:axisUnits/gml:UnitDefinition/gml:identifier">
	                                        <xsl:if test="@codeSpace != ''">
                                                <xsl:variable name="rrrr"><xsl:value-of select="@codeSpace"/></xsl:variable>

                                                        <xsl:call-template name="simple_value_tpl">
                                                                <xsl:with-param name="name" select="$rrrr"/>
                                                                <xsl:with-param name="label" select="'Axis units: '"/>
                                                        </xsl:call-template>
	                                        </xsl:if>
	                                    </xsl:for-each>

                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:denominatorOfFlatteningRatio/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Denominator of flattening ratio: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                </DD>
                <BR/>
        </xsl:template>


        <!-- Ellipsoid Parameter Information (B.2.7.1 MD_EllipsoidParameters - line201) -->
        <xsl:template match="ellParas">
                <DD>
                        <DT class="title_2">
                                        <B>Ellipsoid parameters:</B>
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="semiMajAx"/>
                                                <xsl:with-param name="label" select="'Semi-major axis: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_select_tpl">
                                                <xsl:with-param name="name" select="axisUnits"/>
                                                <xsl:with-param name="label" select="'Axis units: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="denFlatRat"/>
                                                <xsl:with-param name="label" select="'Denominator of flattening ratio: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                </DD>
                <BR/>
        </xsl:template>
        <!-- Distribution Information (B.2.10 MD_Distribution - line270) -->
        <xsl:template match="gisco:MD_Metadata/gmd:distributionInfo">
                <A>
                        <xsl:attribute name="NAME"><xsl:value-of select="generate-id()"/></xsl:attribute>
                        <HR/>
                </A>
                <DL>
                        <DT class="title_1">
                                        <B>Distribution Information:</B>
                        </DT>
                        <BR/>
                        <BR/>
                        <DL class="common">
                                <DD>
                                        <xsl:apply-templates select="gmd:MD_Distribution/gmd:distributor"/>

                                        <!-- toto -->
                                        <xsl:apply-templates select="gisco:distTranOps"/>
                                </DD>
                        </DL>
                </DL>
                <A HREF="#Top">Back to Top</A>
        </xsl:template>
        <!-- Distributor Information (B.2.10.2 MD_Distributor - line279) -->
        <xsl:template match="gmd:MD_Distribution/gmd:distributor | gisco:formatDist">
                <DD>
                        <DT class="title_2">
                                        <B>Distributor:</B>
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:apply-templates select="gmd:MD_Distributor/gmd:distributorContact"/>
                                        <xsl:apply-templates select="gmd:MD_Distributor/gmd:distributionOrderProcess"/>
                                        <xsl:apply-templates select="gmd:MD_Distributor/gmd:distributorTransferOptions"/>
                                        <xsl:apply-templates select="gmd:MD_Distributor/gmd:distributorFormat"/>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>

<!-- Standard Order Process Information (B.2.10.5 MD_StandardOrderProcess - line298) -->
        <xsl:template match="gmd:distributorFormat">
                <DD>
                        <DT class="title_2">
                                        <B>Available format:</B>
                        </DT>
                        <DD>
                                <DL>
                                        <!--<xsl:call-template name="simple_select_tpl"> as the esri used element is not the ISO sdt conform one-->
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:MD_Format/gmd:name"/>
                                                <xsl:with-param name="label" select="'Format name: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:MD_Format/gmd:version"/>
                                                <xsl:with-param name="label" select="'Format version: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                </DD>
                <BR/>
        </xsl:template>


        <!-- Standard Order Process Information (B.2.10.5 MD_StandardOrderProcess - line298) -->
        <xsl:template match="gmd:distributionOrderProcess">
                <DD>
                        <DT class="title_2">
                                        <B>Ordering process:</B>
                        </DT>
                        <DD>
                                <DL>
                                        <!--<xsl:call-template name="simple_select_tpl"> as the esri used element is not the ISO sdt conform one-->
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gmd:MD_StandardOrderProcess/gmd:fees"/>
                                                <xsl:with-param name="label" select="'Terms and fees: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_fix_tpl">
                                                <xsl:with-param name="name" select="gmd:MD_StandardOrderProcess/gmd:orderingInstructions"/>
                                                <xsl:with-param name="label" select="'Instructions: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_fix_tpl">
                                                <xsl:with-param name="name" select="gmd:MD_StandardOrderProcess/gmd:turnaround"/>
                                                <xsl:with-param name="label" select="'Turnaround: '"/>
                                        </xsl:call-template>

                                </DL>
                        </DD>
                </DD>
                <BR/>
        </xsl:template>



        <!-- Digital Transfer Options Information (B.2.10.1 MD_DigitalTransferOptions - line274) -->
        <xsl:template match="gisco:distorTran | gmd:MD_Distributor/gmd:distributorTransferOptions">
                <DD>
                        <DT class="title_2">
                                        <B>Transfer options:</B>
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="display_value_tpl">
                                                <xsl:with-param name="name" select="gmd:MD_DigitalTransferOptions/gmd:transferSize/gco:Real"/>
                                                <xsl:with-param name="label" select="'Transfer size: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gisco:unitsODist"/>
                                                <xsl:with-param name="label" select="'Units of distribution (e.g., tiles): '"/>
                                        </xsl:call-template>
                                        <xsl:if test="gisco:transSize | gisco:unitsODist">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                        <xsl:apply-templates select="gmd:MD_DigitalTransferOptions/gmd:onLine"/>
                                        <xsl:apply-templates select="gmd:MD_DigitalTransferOptions/gmd:offLine"/>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>


        <!-- Medium Information (B.2.10.4 MD_Medium - line291) -->
        <xsl:template match="gmd:MD_DigitalTransferOptions/gmd:offLine">
                <DD>
                        <DT class="title_2">
                                        <B>Medium of distribution:</B>
                        </DT>
                        <DD>
                                <DL>
                                        <xsl:call-template name="simple_select_tpl">
                                                <xsl:with-param name="name" select="gmd:MD_Medium/gmd:name/gmd:MD_MediumNameCode"/>
                                                <xsl:with-param name="label" select="'Medium name: '"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="simple_value_tpl">
                                                <xsl:with-param name="name" select="gisco:medVol"/>
                                                <xsl:with-param name="label" select="'Number of media items: '"/>
                                        </xsl:call-template>
                                        <xsl:if test="gmd:MD_Medium/gmd:name | gisco:medVol">
                                                <BR/>
                                                <BR/>
                                        </xsl:if>
                                        <xsl:call-template name="simple_select_tpl">
                                                <xsl:with-param name="name" select="gisco:medFormat"/>
                                                <xsl:with-param name="label" select="'How the medium is written: '"/>
                                        </xsl:call-template>
                                </DL>
                        </DD>
                </DD>
        </xsl:template>




        <!-- ========================    Legislation template    ===============================-->
                <xsl:template name="legislationInfo_tpl">
                <A name="Metadata_legislation">
                        <HR/>
                </A>
                <DL>
                        <DT class="title_1"><B>Metadata legislation : </B></DT>
                        <BR/>
                        <BR/>
                        <xsl:for-each select="gisco:MD_Metadata/gmd:legislationInformation">
                        <DD class="specific">
                                <DL>
                                        <DT>
                                        <xsl:call-template name="simple_value_tpl_2">
                                                <xsl:with-param name="name" select="gmd:title/gmd:CI_Citation/gmd:title/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Legislation title: '"/>
                                        </xsl:call-template>
                                        </DT>

                                                <DD>
                                                <xsl:call-template name="simple_value_tpl_2">
                                                        <xsl:with-param name="name" select="gmd:title/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:date/gco:Date"/>
                                                        <xsl:with-param name="label" select="'Reference Date: '"/>
                                                </xsl:call-template>
                                                </DD>
                                                <DD>
                                                <xsl:call-template name="simple_value_tpl_2">
                                                        <xsl:with-param name="name" select="gmd:title/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode"/>
                                                        <xsl:with-param name="label" select="'Reference Date Type: '"/>
                                                </xsl:call-template>
                                                </DD>

                                        <DT>
                                        <xsl:call-template name="simple_value_tpl_2">
                                                <xsl:with-param name="name" select="gmd:legislationType/gmd:MD_LegislationTypeCode"/>
                                                <xsl:with-param name="label" select="'Legislation type: '"/>
                                        </xsl:call-template>
                                        </DT>
                                        <DT>
                                        <xsl:call-template name="simple_value_tpl_2">
                                                <xsl:with-param name="name" select="gmd:countryOrOtherEntity/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Country or other entity to which the legislation corresponds: '"/>
                                        </xsl:call-template>
                                        </DT>
                                        <DT>
                                        <xsl:call-template name="simple_value_tpl_2">
                                                <xsl:with-param name="name" select="gmd:internalReference/gco:CharacterString"/>
                                                <xsl:with-param name="label" select="'Internal reference: '"/>
                                        </xsl:call-template>
                                        </DT>
                                </DL>
                        </DD>
                        <br/>
                        </xsl:for-each>

                </DL>
                <A HREF="#Top">Back to Top</A>
        </xsl:template>
        <!-- =====================================================================================-->

        <!-- =======================================Attribute Info template =====================-->
                <xsl:template name="attributeInfo_tpl">
                                <DD class="specific">
                                <DL>
                                        <xsl:if test="gmd:entityType/gmd:AT_EntityType/gmd:label/gco:CharacterString">
                                                <DT>
                                                <xsl:call-template name="simple_value_tpl_2">
                                                        <xsl:with-param name="name" select="gmd:entityType/gmd:AT_EntityType/gmd:label/gco:CharacterString"/>
                                                        <xsl:with-param name="label" select="'Entity label: '"/>
                                                </xsl:call-template>
                                                </DT>
                                        </xsl:if>

                                        <xsl:if test="gmd:entityType/gmd:AT_EntityType/gmd:definition/gco:CharacterString">
                                                <DT>
                                                <xsl:call-template name="simple_value_tpl_2">
                                                        <xsl:with-param name="name" select="gmd:entityType/gmd:AT_EntityType/gmd:definition/gco:CharacterString"/>
                                                        <xsl:with-param name="label" select="'Entity definition: '"/>
                                                </xsl:call-template>
                                                </DT>
                                        </xsl:if>

                                        <xsl:for-each select="gmd:language/gmd:AT_Attribute">
                                        <BR/>
                                        <BR/>
                                        <xsl:if test="gmd:label/gco:CharacterString">
                                                <DD>
                                                <xsl:call-template name="simple_value_tpl_2">
                                                        <xsl:with-param name="name" select="gmd:label/gco:CharacterString"/>
                                                        <xsl:with-param name="label" select="'Entity attribute label: '"/>
                                                </xsl:call-template>
                                                </DD>
                                        </xsl:if>

                                        <xsl:if test="gmd:definition/gco:CharacterString">
                                                <DD>
                                                <xsl:call-template name="simple_value_tpl_2">
                                                        <xsl:with-param name="name" select="gmd:definition/gco:CharacterString"/>
                                                        <xsl:with-param name="label" select="'Entity attribute definition: '"/>
                                                </xsl:call-template>
                                                </DD>
                                        </xsl:if>
                                        <xsl:if test="gmd:source/gco:CharacterString">
                                                <DD>
                                                <xsl:call-template name="simple_value_tpl_2">
                                                        <xsl:with-param name="name" select="gmd:source/gco:CharacterString"/>
                                                        <xsl:with-param name="label" select="'Entity attribute source: '"/>
                                                </xsl:call-template>
                                                </DD>
                                        </xsl:if>
                                        <xsl:if test="gmd:binaryWidth/gco:Integer">
                                                <DD>
                                                <xsl:call-template name="simple_value_tpl_2">
                                                        <xsl:with-param name="name" select="gmd:binaryWidth/gco:Integer"/>
                                                        <xsl:with-param name="label" select="'Entity attribute binary width: '"/>
                                                </xsl:call-template>
                                        </DD>
                                        </xsl:if>

                                        <xsl:if test="gmd:precision/gco:Integer">
                                                <DD>
                                                <xsl:call-template name="simple_value_tpl_2">
                                                        <xsl:with-param name="name" select="gmd:precision/gco:Integer"/>
                                                        <xsl:with-param name="label" select="'Entity attribute precision: '"/>
                                                </xsl:call-template>
                                                </DD>
                                        </xsl:if>

                                        <xsl:if test="gmd:scale/gco:Integer">
                                                <DD>
                                                <xsl:call-template name="simple_value_tpl_2">
                                                        <xsl:with-param name="name" select="gmd:scale/gco:Integer"/>
                                                        <xsl:with-param name="label" select="'Entity attribute scale: '"/>
                                                </xsl:call-template>
                                                </DD>
                                        </xsl:if>

                                        </xsl:for-each>
                                </DL>
                                </DD>


                <br/>
        </xsl:template>



        <!-- ENUMERATION TEMPLATES -->
        <!-- 2 letter language code list from ISO 639 : 1988, in alphabetic order by code -->
        <!-- KMP : to be completed -->
        <xsl:template match="iso639-2:isoCode">
                <xsl:choose>
                        <xsl:when test=". = 'aar'">Afar</xsl:when>
                        <xsl:when test=". = 'abk'">Abkhazian</xsl:when>
                        <xsl:when test=". = 'ace'">Ace</xsl:when>
                        <xsl:when test=". = 'ach'">Ach</xsl:when>
                        <xsl:when test=". = 'ada'">Ada</xsl:when>
                        <xsl:when test=". = 'afa'">Afrikaans</xsl:when>
                        <xsl:when test=". = 'afh'">Afh</xsl:when>
                        <xsl:when test=". = 'afr'">Afr</xsl:when>
                        <xsl:when test=". = 'am'">Amharic</xsl:when>
                        <xsl:when test=". = 'ar'">Arabic</xsl:when>
                        <xsl:when test=". = 'as'">Assamese</xsl:when>
                        <xsl:when test=". = 'ay'">Aymara</xsl:when>
                        <xsl:when test=". = 'az'">Azerbaijani</xsl:when>
                        <xsl:when test=". = 'ba'">Bashkir</xsl:when>
                        <xsl:when test=". = 'be'">Byelorussian</xsl:when>
                        <xsl:when test=". = 'bg'">Bulgarian</xsl:when>
                        <xsl:when test=". = 'bh'">Bihari</xsl:when>
                        <xsl:when test=". = 'bi'">Bislama</xsl:when>
                        <xsl:when test=". = 'bn'">Bengali, Bangla</xsl:when>
                        <xsl:when test=". = 'bo'">Tibetan</xsl:when>
                        <xsl:when test=". = 'br'">Breton</xsl:when>
                        <xsl:when test=". = 'ca'">Catalan</xsl:when>
                        <xsl:when test=". = 'co'">Corsican</xsl:when>
                        <xsl:when test=". = 'cs'">Czech</xsl:when>
                        <xsl:when test=". = 'cy'">Welsh</xsl:when>
                        <xsl:when test=". = 'da'">Danish</xsl:when>
                        <xsl:when test=". = 'de'">German</xsl:when>
                        <xsl:when test=". = 'dz'">Bhutani</xsl:when>
                        <xsl:when test=". = 'el'">Greek</xsl:when>
                        <xsl:when test=". = 'en'">English</xsl:when>
                        <xsl:when test=". = 'eo'">Esperanto</xsl:when>
                        <xsl:when test=". = 'es'">Spanish</xsl:when>
                        <xsl:when test=". = 'et'">Estonian</xsl:when>
                        <xsl:when test=". = 'eu'">Basque</xsl:when>
                        <xsl:when test=". = 'fa'">Persian</xsl:when>
                        <xsl:when test=". = 'fi'">Finnish</xsl:when>
                        <xsl:when test=". = 'fj'">Fiji</xsl:when>
                        <xsl:when test=". = 'fo'">Faroese</xsl:when>
                        <xsl:when test=". = 'fr'">French</xsl:when>
                        <xsl:when test=". = 'fy'">Frisian</xsl:when>
                        <xsl:when test=". = 'ga'">Irish</xsl:when>
                        <xsl:when test=". = 'gd'">Scots Gaelic</xsl:when>
                        <xsl:when test=". = 'gl'">Galician</xsl:when>
                        <xsl:when test=". = 'gn'">Guarani</xsl:when>
                        <xsl:when test=". = 'gu'">Gujarati</xsl:when>
                        <xsl:when test=". = 'ha'">Hausa</xsl:when>
                        <xsl:when test=". = 'hi'">Hindi</xsl:when>
                        <xsl:when test=". = 'hr'">Croatian</xsl:when>
                        <xsl:when test=". = 'hu'">Hungarian</xsl:when>
                        <xsl:when test=". = 'hy'">Armenian</xsl:when>
                        <xsl:when test=". = 'ia'">Interlingua</xsl:when>
                        <xsl:when test=". = 'ie'">Interlingue</xsl:when>
                        <xsl:when test=". = 'ik'">Inupiak</xsl:when>
                        <xsl:when test=". = 'in'">Indonesian</xsl:when>
                        <xsl:when test=". = 'is'">Icelandic</xsl:when>
                        <xsl:when test=". = 'it'">Italian</xsl:when>
                        <xsl:when test=". = 'iw'">Hebrew</xsl:when>
                        <xsl:when test=". = 'ja'">Japanese</xsl:when>
                        <xsl:when test=". = 'ji'">Yiddish</xsl:when>
                        <xsl:when test=". = 'jw'">Javanese</xsl:when>
                        <xsl:when test=". = 'ka'">Georgian</xsl:when>
                        <xsl:when test=". = 'kk'">Kazakh</xsl:when>
                        <xsl:when test=". = 'kl'">Greenlandic</xsl:when>
                        <xsl:when test=". = 'km'">Cambodian</xsl:when>
                        <xsl:when test=". = 'kn'">Kannada</xsl:when>
                        <xsl:when test=". = 'ko'">Korean</xsl:when>
                        <xsl:when test=". = 'ks'">Kashmiri</xsl:when>
                        <xsl:when test=". = 'ku'">Kurdish</xsl:when>
                        <xsl:when test=". = 'ky'">Kirghiz</xsl:when>
                        <xsl:when test=". = 'la'">Latin</xsl:when>
                        <xsl:when test=". = 'ln'">Lingala</xsl:when>
                        <xsl:when test=". = 'lo'">Laothian</xsl:when>
                        <xsl:when test=". = 'lt'">Lithuanian</xsl:when>
                        <xsl:when test=". = 'lv'">Latvian, Lettish</xsl:when>
                        <xsl:when test=". = 'mg'">Malagasy</xsl:when>
                        <xsl:when test=". = 'mi'">Maori</xsl:when>
                        <xsl:when test=". = 'mk'">Macedonian</xsl:when>
                        <xsl:when test=". = 'ml'">Malayalam</xsl:when>
                        <xsl:when test=". = 'mn'">Mongolian</xsl:when>
                        <xsl:when test=". = 'mo'">Moldavian</xsl:when>
                        <xsl:when test=". = 'mr'">Marathi</xsl:when>
                        <xsl:when test=". = 'ms'">Malay</xsl:when>
                        <xsl:when test=". = 'mt'">Maltese</xsl:when>
                        <xsl:when test=". = 'my'">Burmese</xsl:when>
                        <xsl:when test=". = 'na'">Nauru</xsl:when>
                        <xsl:when test=". = 'ne'">Nepali</xsl:when>
                        <xsl:when test=". = 'nl'">Dutch</xsl:when>
                        <xsl:when test=". = 'no'">Norwegian</xsl:when>
                        <xsl:when test=". = 'oc'">Occitan</xsl:when>
                        <xsl:when test=". = 'om'">(Afan) Oromo</xsl:when>
                        <xsl:when test=". = 'or'">Oriya</xsl:when>
                        <xsl:when test=". = 'pa'">Punjabi</xsl:when>
                        <xsl:when test=". = 'pl'">Polish</xsl:when>
                        <xsl:when test=". = 'ps'">Pashto, Pushto</xsl:when>
                        <xsl:when test=". = 'pt'">Portugese</xsl:when>
                        <xsl:when test=". = 'qu'">Quechua</xsl:when>
                        <xsl:when test=". = 'rm'">Rhaeto-Romance</xsl:when>
                        <xsl:when test=". = 'rn'">Kirundi</xsl:when>
                        <xsl:when test=". = 'ro'">Romanian</xsl:when>
                        <xsl:when test=". = 'ru'">Russian</xsl:when>
                        <xsl:when test=". = 'rw'">Kinyarwanda</xsl:when>
                        <xsl:when test=". = 'sa'">Sanskrit</xsl:when>
                        <xsl:when test=". = 'sd'">Sindhi</xsl:when>
                        <xsl:when test=". = 'sg'">Sangho</xsl:when>
                        <xsl:when test=". = 'sh'">Serbo-Croatian</xsl:when>
                        <xsl:when test=". = 'si'">Singhalese</xsl:when>
                        <xsl:when test=". = 'sk'">Slovak</xsl:when>
                        <xsl:when test=". = 'sl'">Slovenian</xsl:when>
                        <xsl:when test=". = 'sm'">Samoan</xsl:when>
                        <xsl:when test=". = 'sn'">Shona</xsl:when>
                        <xsl:when test=". = 'so'">Somali</xsl:when>
                        <xsl:when test=". = 'sq'">Albanian</xsl:when>
                        <xsl:when test=". = 'sr'">Serbian</xsl:when>
                        <xsl:when test=". = 'ss'">Siswati</xsl:when>
                        <xsl:when test=". = 'st'">Sesotho</xsl:when>
                        <xsl:when test=". = 'su'">Sundanese</xsl:when>
                        <xsl:when test=". = 'sv'">Swedish</xsl:when>
                        <xsl:when test=". = 'sw'">Swahili</xsl:when>
                        <xsl:when test=". = 'ta'">Tamil</xsl:when>
                        <xsl:when test=". = 'te'">Telugu</xsl:when>
                        <xsl:when test=". = 'tg'">Tajik</xsl:when>
                        <xsl:when test=". = 'th'">Thai</xsl:when>
                        <xsl:when test=". = 'ti'">Tigrinya</xsl:when>
                        <xsl:when test=". = 'tk'">Turkmen</xsl:when>
                        <xsl:when test=". = 'tl'">Tagalog</xsl:when>
                        <xsl:when test=". = 'tn'">Setswana</xsl:when>
                        <xsl:when test=". = 'to'">Tonga</xsl:when>
                        <xsl:when test=". = 'tr'">Turkish</xsl:when>
                        <xsl:when test=". = 'ts'">Tsonga</xsl:when>
                        <xsl:when test=". = 'tt'">Tatar</xsl:when>
                        <xsl:when test=". = 'tw'">Twi</xsl:when>
                        <xsl:when test=". = 'uk'">Ukrainian</xsl:when>
                        <xsl:when test=". = 'ur'">Urdu</xsl:when>
                        <xsl:when test=". = 'uz'">Uzbek</xsl:when>
                        <xsl:when test=". = 'vi'">Vietnamese</xsl:when>
                        <xsl:when test=". = 'vo'">Volapuk</xsl:when>
                        <xsl:when test=". = 'wo'">Wolof</xsl:when>
                        <xsl:when test=". = 'xh'">Xhosa</xsl:when>
                        <xsl:when test=". = 'yo'">Yoruba</xsl:when>
                        <xsl:when test=". = 'zh'">Chinese</xsl:when>
                        <xsl:when test=". = 'zu'">Zulu</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <!-- Character set code list (B.5.10 MD_CharacterSetCode) -->
        <xsl:template match="gisco:mdChar | gisco:dataChar">
                <xsl:choose>
                        <xsl:when test=". = 'ucs2'">ucs2 - 16 bit Universal Character Set</xsl:when>
                        <xsl:when test=". = 'ucs4'">ucs4 - 32 bit Universal Character Set</xsl:when>
                        <xsl:when test=". = 'utf8'">utf8 - 8 bit UCS Transfer Format</xsl:when>
                        <xsl:when test=". = 'utf16'">utf16 - 16 bit UCS Transfer Format</xsl:when>
                        <xsl:when test=". = '8859part1'">8859part1 - Latin-1, Western European</xsl:when>
                        <xsl:when test=". = '8859part2'">8859part2 - Latin-2, Central European</xsl:when>
                        <xsl:when test=". = '8859part3'">8859part3 - Latin-3, South European</xsl:when>
                        <xsl:when test=". = '8859part4'">8859part4 - Latin-4, North European</xsl:when>
                        <xsl:when test=". = '8859part5'">8859part5 - Cyrillic</xsl:when>
                        <xsl:when test=". = '8859part6'">8859part6 - Arabic</xsl:when>
                        <xsl:when test=". = '8859part7'">8859part7 - Greek</xsl:when>
                        <xsl:when test=". = '8859part8'">8859part8 - Hebrew</xsl:when>
                        <xsl:when test=". = '8859part9'">8859part9 - Latin-5, Turkish</xsl:when>
                        <xsl:when test=". = '8859part10'">8859part10 </xsl:when>
                        <xsl:when test=". = '8859part11'">8859part11 - Thai</xsl:when>
                        <xsl:when test=". = '8859part13'">8859part13</xsl:when>
                        <xsl:when test=". = '8859part14'">8859part14 - Latin-8</xsl:when>
                        <xsl:when test=". = '8859part15'">8859part15 - Latin-9</xsl:when>
                        <xsl:when test=". = '8859part16'">8859part16</xsl:when>
                        <xsl:when test=". = 'jis'">jis - Japanese for electronic transmission</xsl:when>
                        <xsl:when test=". = 'shiftJIS'">shiftJIS - Japanese for MS-DOS</xsl:when>
                        <xsl:when test=". = 'eucJP'">eucJP - Japanese for UNIX</xsl:when>
                        <xsl:when test=". = 'usAscii'">U.S. ASCII</xsl:when>
                        <xsl:when test=". = 'ebcdic'">ebcdic - IBM mainframe</xsl:when>
                        <xsl:when test=". = 'eucKR'">eucKR - Korean</xsl:when>
                        <xsl:when test=". = 'big5'">big5 - Taiwanese</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <xsl:template match="gisco:maintFreq">
                <xsl:choose>
                        <xsl:when test=". = 'continual'">continual</xsl:when>
                        <xsl:when test=". = 'daily'">daily</xsl:when>
                        <xsl:when test=". = 'weekly'">weekly</xsl:when>
                        <xsl:when test=". = 'fortnightly'">fortnightly</xsl:when>
                        <xsl:when test=". = 'monthly'">monthly</xsl:when>
                        <xsl:when test=". = 'quartely'">quarterly</xsl:when>
                        <xsl:when test=". = 'biannually'">biannually</xsl:when>
                        <xsl:when test=". = 'annually'">annually</xsl:when>
                        <xsl:when test=". = 'asNeeded'">as needed</xsl:when>
                        <xsl:when test=". = 'irregular'">irregular</xsl:when>
                        <xsl:when test=". = 'notPlanned'">not planned</xsl:when>
                        <xsl:when test=". = 'unknown'">unknown</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <xsl:template match="iso19115:role">
                <xsl:choose>
                        <xsl:when test=". = 'resourceProvider'">resource provider</xsl:when>
                        <xsl:when test=". = 'custodian'">custodian</xsl:when>
                        <xsl:when test=". = 'owner'">owner</xsl:when>
                        <xsl:when test=". = 'user'">user</xsl:when>
                        <xsl:when test=". = 'distributor'">distributor</xsl:when>
                        <xsl:when test=". = 'originator'">originator</xsl:when>
                        <xsl:when test=". = 'pointOfContact'">point of contact</xsl:when>
                        <xsl:when test=". = 'principalInvestigator'">principal investigator</xsl:when>
                        <xsl:when test=". = 'processor'">processor</xsl:when>
                        <xsl:when test=". = 'publisher'">publisher</xsl:when>
                        <xsl:when test=". = 'author'">author</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <xsl:template match="iso19115:orFunct">
                <xsl:choose>
                        <xsl:when test=". = 'download'">download</xsl:when>
                        <xsl:when test=". = 'information'">information</xsl:when>
                        <xsl:when test=". = 'offlineAccess'">offline access</xsl:when>
                        <xsl:when test=". = 'order'">order</xsl:when>
                        <xsl:when test=". = 'search'">search</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <xsl:template match="gmd:CI_OnlineResource/gmd:description/gco:CharacterString">
                <xsl:variable name="orDescValue"><xsl:value-of select="."/></xsl:variable>
                        <xsl:choose>
                                <xsl:when test="$orDescValue = '001'">Live Data and Maps</xsl:when>
                                <xsl:when test="$orDescValue = '002'">Downloadable Data</xsl:when>
                                <xsl:when test="$orDescValue = '003'">Offline Data</xsl:when>
                                <xsl:when test="$orDescValue = '004'">Map Files</xsl:when>
                                <xsl:when test="$orDescValue = '005'">Static Map Images</xsl:when>
                                <xsl:when test="$orDescValue = '006'">Other documents</xsl:when>
                                <xsl:when test="$orDescValue = '007'">Applications</xsl:when>
                                <xsl:when test="$orDescValue = '008'">Geographic Services</xsl:when>
                                <xsl:when test="$orDescValue = '009'">Clearinghouses</xsl:when>
                                <xsl:when test="$orDescValue = '010'">Geographic Activities</xsl:when>
                                <xsl:otherwise>
                                        <xsl:value-of select="$orDescValue"/>
                                </xsl:otherwise>
                        </xsl:choose>
        </xsl:template>
        <xsl:template match="gisco:mdHrLv | gisco:scpLvl">
                <xsl:choose>
                        <xsl:when test=". = 'attribute'">attribute</xsl:when>
                        <xsl:when test=". = 'attributeType'">attribute type</xsl:when>
                        <xsl:when test=". = 'collectionHardware'">collection hardware</xsl:when>
                        <xsl:when test=". = 'collectionSession'">collection session</xsl:when>
                        <xsl:when test=". = 'dataset'">dataset</xsl:when>
                        <xsl:when test=". = 'series'">series</xsl:when>
                        <xsl:when test=". = 'nonGeographicDataset'">non-geographic dataset</xsl:when>
                        <xsl:when test=". = 'dimensionGroup'">dimension group</xsl:when>
                        <xsl:when test=". = 'feature'">feature</xsl:when>
                        <xsl:when test=". = 'featureType'">feature type</xsl:when>
                        <xsl:when test=". = 'propertyType'">property type</xsl:when>
                        <xsl:when test=". = 'fieldSession'">field session</xsl:when>
                        <xsl:when test=". = 'software'">software</xsl:when>
                        <xsl:when test=". = 'service'">service</xsl:when>
                        <xsl:when test=". = 'model'">model</xsl:when>
                        <xsl:when test=". = 'tile'">tile</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <xsl:template match="iso19115:refDateType">
                <xsl:choose>
                        <xsl:when test=". = 'documentDigital'">document digital</xsl:when>
                        <xsl:when test=". = 'documentHardcopy'">document hardcopy</xsl:when>
                        <xsl:when test=". = 'imageDigital'">image digital</xsl:when>
                        <xsl:when test=". = 'imageHardcopy'">image hardcopy</xsl:when>
                        <xsl:when test=". = 'mapDigital'">map digital</xsl:when>
                        <xsl:when test=". = 'mapHardcopy'">map hardcopy</xsl:when>
                        <xsl:when test=". = 'modelDigital'">model digital</xsl:when>
                        <xsl:when test=". = 'modelHardcopy'">model hardcopy</xsl:when>
                        <xsl:when test=". = 'profileDigital'">profile digital</xsl:when>
                        <xsl:when test=". = 'profileHardcopy'">profile hardcopy</xsl:when>
                        <xsl:when test=". = 'tableDigital'">table digital</xsl:when>
                        <xsl:when test=". = 'tableHardcopy'">table hardcopy</xsl:when>
                        <xsl:when test=". = 'videoDigital'">video digital</xsl:when>
                        <xsl:when test=". = 'videoHardcopy'">video hardcopy</xsl:when>
                        <xsl:when test=". = 'collection'">collection</xsl:when>
                        <xsl:when test=". = 'dataset'">dataset</xsl:when>
                        <xsl:when test=". = 'event'">event</xsl:when>
                        <xsl:when test=". = 'image'">image</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>

        <xsl:template match="gmd:presentationForm/gmd:CI_PresentationFormCode">
                <xsl:choose>
                        <xsl:when test=". = 'documentDigital'">document digital</xsl:when>
                        <xsl:when test=". = 'documentHardcopy'">document hardcopy</xsl:when>
                        <xsl:when test=". = 'imageDigital'">image digital</xsl:when>
                        <xsl:when test=". = 'imageHardcopy'">image hardcopy</xsl:when>
                        <xsl:when test=". = 'mapDigital'">map digital</xsl:when>
                        <xsl:when test=". = 'mapHardcopy'">map hardcopy</xsl:when>
                        <xsl:when test=". = 'modelDigital'">model digital</xsl:when>
                        <xsl:when test=". = 'modelHardcopy'">model hardcopy</xsl:when>
                        <xsl:when test=". = 'profileDigital'">profile digital</xsl:when>
                        <xsl:when test=". = 'profileHardcopy'">profile hardcopy</xsl:when>
                        <xsl:when test=". = 'tableDigital'">table digital</xsl:when>
                        <xsl:when test=". = 'tableHardcopy'">table hardcopy</xsl:when>
                        <xsl:when test=". = 'videoDigital'">video digital</xsl:when>
                        <xsl:when test=". = 'videoHardcopy'">video hardcopy</xsl:when>
                        <xsl:when test=". = 'collection'">collection</xsl:when>
                        <xsl:when test=". = 'dataset'">dataset</xsl:when>
                        <xsl:when test=". = 'event'">event</xsl:when>
                        <xsl:when test=". = 'image'">image</xsl:when>
                        <xsl:when test=". = 'interactiveResource'">interactive resource</xsl:when>
                        <xsl:when test=". = 'service'">service</xsl:when>
                        <xsl:when test=". = 'software'">software</xsl:when>
                        <xsl:when test=". = 'sound'">sound</xsl:when>
                        <xsl:when test=". = 'text'">text</xsl:when>
                        <xsl:otherwise>
                                document Digital
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>






        <xsl:template match="gisco:tpCat">
                <xsl:choose>
                        <xsl:when test=". = 'farming'">farming</xsl:when>
                        <xsl:when test=". = 'biota'">biota</xsl:when>
                        <xsl:when test=". = 'boundaries'">boundaries</xsl:when>
                        <xsl:when test=". = 'climatologyMeteorologyAtmosphere'">climatology, meteorology, and atmosphere</xsl:when>
                        <xsl:when test=". = 'economy'">economy</xsl:when>
                        <xsl:when test=". = 'elevation'">elevation</xsl:when>
                        <xsl:when test=". = 'environment'">environment</xsl:when>
                        <xsl:when test=". = 'geoscientificInformation'">geo-scientific information</xsl:when>
                        <xsl:when test=". = 'health'">health</xsl:when>
                        <xsl:when test=". = 'imageryBaseMapsEarthCover'">imagery base maps, and earth cover</xsl:when>
                        <xsl:when test=". = 'intelligenceMilitary'">intelligence, and military</xsl:when>
                        <xsl:when test=". = 'inlandWaters'">inland waters</xsl:when>
                        <xsl:when test=". = 'location'">location</xsl:when>
                        <xsl:when test=". = 'oceans'">oceans</xsl:when>
                        <xsl:when test=". = 'planningCadastre'">planning, and cadastre</xsl:when>
                        <xsl:when test=". = 'society'">society</xsl:when>
                        <xsl:when test=". = 'structure'">structure</xsl:when>
                        <xsl:when test=". = 'transportation'">transportation</xsl:when>
                        <xsl:when test=". = 'utilitiesCommunication'">utilities, and communication</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <xsl:template match="gmd:status/gmd:status/gmd:MD_ProgressCode">
                <xsl:choose>
                        <xsl:when test=". = 'completed'">completed</xsl:when>
                        <xsl:when test=". = 'historicalArchive'">historical archive</xsl:when>
                        <xsl:when test=". = 'obsolete'">obsolete</xsl:when>
                        <xsl:when test=". = 'onGoing'">on-going</xsl:when>
                        <xsl:when test=". = 'planned'">planned</xsl:when>
                        <xsl:when test=". = 'required'">required</xsl:when>
                        <xsl:when test=". = 'underDevelopment'">under development</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <xsl:template match="gisco:spatRpType">
                <xsl:choose>
                        <xsl:when test=". = 'vector'">vector</xsl:when>
                        <xsl:when test=". = 'grid'">grid</xsl:when>
                        <xsl:when test=". = 'textTable'">text table</xsl:when>
                        <xsl:when test=". = 'tin'">tin</xsl:when>
                        <xsl:when test=". = 'stereoModel'">stereo model</xsl:when>
                        <xsl:when test=". = 'video'">video</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <xsl:template match="gisco:cellGeo">
                <xsl:choose>
                        <xsl:when test=". = 'point'">point</xsl:when>
                        <xsl:when test=". = 'area'">area</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <xsl:template match="iso19115:dimName">
                <xsl:choose>
                        <xsl:when test=". = 'row'">row (y-axis)</xsl:when>
                        <xsl:when test=". = 'column'">column (x-axis)</xsl:when>
                        <xsl:when test=". = 'vertical'">vertical (z-axis)</xsl:when>
                        <xsl:when test=". = 'track'">track (along direction of motion)</xsl:when>
                        <xsl:when test=". = 'crossTrack'">cross track (perpendicular to direction of motion)</xsl:when>
                        <xsl:when test=". = 'line'">scal line of sensor</xsl:when>
                        <xsl:when test=". = 'sample'">sample (element along scan line)</xsl:when>
                        <xsl:when test=". = 'time'">time duration</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <xsl:template match="gisco:topLvl">
                <xsl:choose>
                        <xsl:when test=". = 'geometryOnly'">geometry only</xsl:when>
                        <xsl:when test=". = 'toplogy1D'">topology 1D</xsl:when>
                        <xsl:when test=". = 'planarGraph'">planar graph</xsl:when>
                        <xsl:when test=". = 'fullPlanarGraph'">full planar graph</xsl:when>
                        <xsl:when test=". = 'surfaceGraph'">surface graph</xsl:when>
                        <xsl:when test=". = 'fullSurfaceGraph'">full surface graph</xsl:when>
                        <xsl:when test=". = 'topology3D'">topology 3D</xsl:when>
                        <xsl:when test=". = 'fullTopology3D'">full topology 3D</xsl:when>
                        <xsl:when test=". = 'abstract'">abstract</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <xsl:template match="gisco:geoObjTyp">
                <xsl:choose>
                        <xsl:when test=". = 'complex'">complexes</xsl:when>
                        <xsl:when test=". = 'composite'">composites</xsl:when>
                        <xsl:when test=". = 'curve'">curve</xsl:when>
                        <xsl:when test=". = 'point'">point</xsl:when>
                        <xsl:when test=". = 'solid'">solid</xsl:when>
                        <xsl:when test=". = 'surface'">surface</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <xsl:template match="gisco:contentTyp">
                <xsl:choose>
                        <xsl:when test=". = 'image'">image</xsl:when>
                        <xsl:when test=". = 'thematicClassification'">thematic classification</xsl:when>
                        <xsl:when test=". = 'physicalMeasurement'">physical measurement</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <xsl:template match="gisco:pointInPixel">
                <xsl:choose>
                        <xsl:when test=". = 'center'">center</xsl:when>
                        <xsl:when test=". = 'lowerLeft'">lower left</xsl:when>
                        <xsl:when test=". = 'lowerRight'">lower right</xsl:when>
                        <xsl:when test=". = 'upperLeft'">upper left</xsl:when>
                        <xsl:when test=". = 'upperRight'">upper right</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <!--<xsl:template match="gisco:evalMethType"> corrected by mri, its an iso191115 element-->
        <xsl:template match="iso19115:evalMethType">
                <xsl:choose>
                        <xsl:when test=". = 'directInternal'">direct internal</xsl:when>
                        <xsl:when test=". = 'directExternal'">direct external</xsl:when>
                        <xsl:when test=". = 'indirect'">indirect</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <xsl:template match="gisco:falENUnits | gisco:axisUnits">
                <xsl:choose>
                        <xsl:when test=". = 'kilometer'">kilometer</xsl:when>
                        <xsl:when test=". = 'meter'">meter</xsl:when>
                        <xsl:when test=". = 'decimeter'">decimeter</xsl:when>
                        <xsl:when test=". = 'mile'">mile'</xsl:when>
                        <xsl:when test=". = 'yard'">yard</xsl:when>
                        <xsl:when test=". = 'foot'">foot</xsl:when>
                        <xsl:when test=". = 'nanometer'">nanometer</xsl:when>
                        <xsl:when test=". = 'micrometer'">micrometer</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <xsl:template match="gisco:medName">
                <xsl:choose>
                        <xsl:when test=". = 'cdRom'">CD-ROM</xsl:when>
                        <xsl:when test=". = 'dvd'">DVD</xsl:when>
                        <xsl:when test=". = 'dvdRom'">DVD-ROM</xsl:when>
                        <xsl:when test=". = '3halfInchFloppy'">3.5 inch floppy disk</xsl:when>
                        <xsl:when test=". = '5quarterInchFloppy'">5.25 inch floppy disk</xsl:when>
                        <xsl:when test=". = '7trackTape'">7 track tape</xsl:when>
                        <xsl:when test=". = '9trackTape'">9 track tape</xsl:when>
                        <xsl:when test=". = '3480Cartridge'">3480 cartridge</xsl:when>
                        <xsl:when test=". = '3490Cartridge'">3490 cartridge</xsl:when>
                        <xsl:when test=". = '3580Cartridge'">3580 cartridge</xsl:when>
                        <xsl:when test=". = '4mmCartridgeTape'">4mm cartridge tape</xsl:when>
                        <xsl:when test=". = '8mmCartridgeTape'">8mm cartridge tape</xsl:when>
                        <xsl:when test=". = '1quarterInchCartridgeTape'">0.25 inch cartridge tape</xsl:when>
                        <xsl:when test=". = 'digitalLinearTape'">digital linear tape</xsl:when>
                        <xsl:when test=". = 'onLine'">online link</xsl:when>
                        <xsl:when test=". = 'satellite'">satellite link</xsl:when>
                        <xsl:when test=". = 'telephoneLink'">telephone link</xsl:when>
                        <xsl:when test=". = 'hardcopy'">hardcopy</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <xsl:template match="gisco:medFormat">
                <xsl:choose>
                        <xsl:when test=". = 'cpio'">cpio</xsl:when>
                        <xsl:when test=". = 'tar'">tar</xsl:when>
                        <xsl:when test=". = 'highSierra'">high sierra file system</xsl:when>
                        <xsl:when test=". = 'iso9660'">iso9660 (CD-ROM)</xsl:when>
                        <xsl:when test=". = 'iso9660RockRidge'">iso9660 Rock Ridge</xsl:when>
                        <xsl:when test=". = 'iso9660AppleHFS'">iso9660 Apple HFS</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        <xsl:template match="gisco:eurTopic">
                <xsl:choose>
                        <xsl:when test=". = 'elevation'">elevation</xsl:when>
                        <xsl:when test=". = 'bathymetry'">bathymetry</xsl:when>
                        <xsl:when test=". = 'shoreline'">shoreline</xsl:when>
                        <xsl:when test=". = 'terrestrialAdministrativeBoundaries'">terrestrial Administrative Boundaries</xsl:when>
                        <xsl:when test=". = 'marineAdministrativeBoundaries'">marine Administrative Boundaries</xsl:when>
                        <xsl:when test=". = infrastructure">infrastructure</xsl:when>
                        <xsl:when test=". = 'hydrography'">hydrography</xsl:when>
                        <xsl:when test=". = 'geologicalGeomorphologicalFeatures'">geological Geomorphological Features</xsl:when>
                        <xsl:when test=". = 'erosionTrend'">erosion Trend</xsl:when>
                        <xsl:when test=". = 'actualLandCover'">actual Land Cover</xsl:when>
                        <xsl:when test=". = 'landCoverChangesBetween1975And1990'">land Cover Changes Between 1975 And 1990</xsl:when>
                        <xsl:when test=". = 'hydrodynamics'">hydrodynamics</xsl:when>
                        <xsl:when test=". = 'seaLevel'">seaLevel</xsl:when>
                        <xsl:when test=". = 'biodiversityAndNaturalHabitat'">biodiversity And Natural Habitat</xsl:when>
                        <xsl:when test=". = 'socioEconomicalAspects'">socio Economical Aspects</xsl:when>
                        <xsl:when test=". = 'landOwnershipPatterns'">land Ownership Patterns</xsl:when>
                        <xsl:otherwise>
                                <xsl:value-of select="."/>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c)1998-2002 eXcelon Corp.
<metaInformation>
<scenarios ><scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\MetadataModel\SchemaDesign\XML\eurosion_instance_2.xml" htmlbaseurl="" processortype="internal" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""/></scenarios><MapperInfo srcSchemaPath="" srcSchemaRoot="" srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
</metaInformation>
-->