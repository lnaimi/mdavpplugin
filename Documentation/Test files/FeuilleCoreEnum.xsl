<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:uFN="uFN" version="2.0">
  <xsl:import href="utilFunctions.xsl"/>
	<xsl:output method="text" encoding="iso-8859-1" indent="yes"/>
<xsl:template match="Project/Models/Package/ModelChildren">
	   <xsl:result-document href="{$projectName}/{$projectName}.Core/enums.cs">
using System;
using System.Collections.Generic;
using System.Text;

namespace <xsl:value-of select="$projectName"/>.Core
{
	<xsl:for-each select="./Class[.//Stereotype[@Name ='enumeration']]">
	public enum <xsl:value-of select="./@Name"/> { <xsl:value-of select="uFN:enumerations(.)"/> };
	</xsl:for-each>
}	
       </xsl:result-document>
</xsl:template>
</xsl:stylesheet>

