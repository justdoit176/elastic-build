<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output omit-xml-declaration="yes" indent="yes"/>
  <xsl:template match="node()|@*">
     <xsl:copy>
       <xsl:apply-templates select="node()|@*"/>
     </xsl:copy>
  </xsl:template>
  
  <xsl:template match="/pool[@type='dir']/target/path">
    <xsl:copy-of select="."/>
    <xsl:element name="permissions">
      <xsl:element name="mode"><xsl:value-of select="'770'"/></xsl:element>
      <xsl:element name="owner"><xsl:value-of select="'0480'"/></xsl:element>
      <xsl:element name="group"><xsl:value-of select="'0475'"/></xsl:element>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
