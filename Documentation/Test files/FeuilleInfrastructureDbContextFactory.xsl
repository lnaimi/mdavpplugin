<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:uFN="uFN" version="2.0">
  <xsl:import href="utilFunctions.xsl"/>
	<xsl:output method="text" encoding="iso-8859-1" indent="yes"/>
<xsl:template match="Project/Models/Package/ModelChildren">
	   <xsl:result-document href="{$projectName}/{$projectName}.Infrastructure/{$projectName}ConetxtFactory.cs">
using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;

namespace <xsl:value-of select="$projectName"/>.Infrastructure
{
	public class <xsl:value-of select="$projectName"/>ContextFactory : IDesignTimeDbContextFactory&#60;<xsl:value-of select="$projectName"/>Context&#62;
	{	
		public <xsl:value-of select="$projectName"/>Conetxt CreateDbContext(string[] args)
		{
			var optionsBuilder = new DbContextOptionsBuilder&#60;<xsl:value-of select="$projectName"/>Context&#62;();
            optionsBuilder.UseSqlServer(@"Server=.;Database=<xsl:value-of select="$projectName"/>DB;Trusted_Connection=True;");

            return new <xsl:value-of select="$projectName"/>Context(optionsBuilder.Options);
		}
	}
}	
       </xsl:result-document>
</xsl:template>
</xsl:stylesheet>

