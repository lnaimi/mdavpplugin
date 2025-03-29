<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:uFN="uFN" version="2.0">
  <xsl:import href="utilFunctions.xsl"/>
	<!-- <xsl:output method="text" encoding="iso-8859-1" indent="yes"/> -->
	<xsl:output method="text" encoding="UTF-8" indent="yes"/>

<xsl:template match="Project/Models/Package/ModelChildren/Class[not (.//AssociationClass) and .//Stereotype[@Name ='AggregateRoot'] and .//Stereotype[@Name ='Repository']]">
       <xsl:variable name="contextName" select="@Name"/>
	   <xsl:variable name="iDClass" select="@Id"/>
	   <xsl:result-document href="{$projectName}/{$projectName}.Core/Interfaces//I{$contextName}Repository.cs">
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using <xsl:value-of select="$projectName"/>.SharedKernel.Interfaces;

namespace <xsl:value-of select="$projectName"/>.Core.Interfaces
{
	public interface I<xsl:value-of select="$contextName"/>Repository : IAsyncRepository&#60;<xsl:value-of select="$contextName"/>&#62;
	{
	
	<!-- GetByIdWith Operation FromEnd -->
	<xsl:for-each select="/.//Association[ToEnd/AssociationEnd/@EndModelElement=$iDClass and (FromEnd/AssociationEnd/@Multiplicity='1' or FromEnd/AssociationEnd/@Multiplicity='Unspecified' or FromEnd/AssociationEnd/@Multiplicity='0..1')]">
		<xsl:variable name="fromEndClass" select="uFN:typeUMLElement(FromEnd/AssociationEnd/@EndModelElement)"/>
		Task&#60;<xsl:value-of select="$contextName"/>&#62; GetByIdWith<xsl:value-of select="$fromEndClass/@Name"/>Async(int id);
	</xsl:for-each>
	<!-- GetByIdWith Operation ToEnd -->
	<xsl:for-each select="/.//Association[FromEnd/AssociationEnd/@EndModelElement=$iDClass and (ToEnd/AssociationEnd/@Multiplicity='1' or ToEnd/AssociationEnd/@Multiplicity='Unspecified' or ToEnd/AssociationEnd/@Multiplicity='0..1')]">
		<xsl:variable name="toEndClass" select="uFN:typeUMLElement(ToEnd/AssociationEnd/@EndModelElement)"/>
		Task&#60;<xsl:value-of select="$contextName"/>&#62; GetByIdWith<xsl:value-of select="$toEndClass/@Name"/>Async(int id);
	</xsl:for-each>
	}
}	
       </xsl:result-document>.
</xsl:template>
</xsl:stylesheet>

