<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:h="http://www.w3.org/1999/xhtml"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="#all"
                version="3.0">

<xsl:output method="html" html-version="5" indent="no"/>
<xsl:mode on-no-match="shallow-copy"/>

<xsl:template match="h:body/h:header">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates select="h:h1"/>
    <xsl:apply-templates select="h:div[contains-token(@class ,'editors')]"/>
    <div class="pubdate">
      <xsl:sequence select="format-date(current-date(), '[D01] [MNn] [Y0001]')"/>
    </div>
  </xsl:copy>
</xsl:template>

<xsl:template match="h:div[contains-token(@class ,'editors')]">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:text>Editors: </xsl:text>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:template match="h:div[contains-token(@class ,'editors')]
                     /h:span[contains-token(@class, 'name')]">
  <xsl:if test="preceding-sibling::h:span[contains-token(@class, 'name')]">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:template match="h:header/h:aside"/>

<xsl:template match="h:div[contains-token(@class, 'appendix')]/h:header/h:h2">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:text>Appendix: </xsl:text>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:template match="h:pre">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <code>
      <xsl:for-each select="node()">
        <xsl:choose>
          <xsl:when test="position() eq 1
                          and self::text()
                          and matches(., '^\s+')">
            <xsl:value-of select="replace(., '^\s+', '')"/>
          </xsl:when>
          <xsl:when test="position() eq 1
                          and self::text()
                          and matches(., '^\s$')">
            <xsl:value-of select="replace(., '^\s$', '')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="."/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </code>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>
