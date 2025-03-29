<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:uFN="uFN" version="2.0">
  <xsl:import href="utilFunctions.xsl"/>
	<xsl:output method="text" encoding="iso-8859-1" indent="yes"/>
<xsl:template match="Project/Models/Package/ModelChildren">
	   <xsl:result-document href="{$projectName}/{$projectName}.Core/Specifications/PredicateBuilder.cs">
using System;
using System.Linq;
using System.Linq.Expressions;

namespace <xsl:value-of select="$projectName"/>.Core.Specifications
{
	public static class PredicateBuilder
	{
		public static Expression&#60;Func&#60;T, bool&#62;&#62; True&#60;T&#62;() { return f =&#62; true; }
		public static Expression&#60;Func&#60;T, bool&#62;&#62; False&#60;T&#62;() { return f =&#62; false; }

		public static Expression&#60;Func&#60;T, bool&#62;&#62; Or&#60;T&#62;(this Expression&#60;Func&#60;T, bool&#62;&#62; expr1,
															Expression&#60;Func&#60;T, bool&#62;&#62; expr2)
		{
		  var invokedExpr = Expression.Invoke(expr2, expr1.Parameters.Cast&#60;Expression&#62;());
		  return Expression.Lambda&#60;Func&#60;T, bool&#62;&#62;
				(Expression.OrElse(expr1.Body, invokedExpr), expr1.Parameters);
		}

		public static Expression&#60;Func&#60;T, bool&#62;&#62; And&#60;T&#62;(this Expression&#60;Func&#60;T, bool&#62;&#62; expr1,
															 Expression&#60;Func&#60;T, bool&#62;&#62; expr2)
		{
		  var invokedExpr = Expression.Invoke(expr2, expr1.Parameters.Cast&#60;Expression&#62;());
		  return Expression.Lambda&#60;Func&#60;T, bool&#62;&#62;
				(Expression.AndAlso(expr1.Body, invokedExpr), expr1.Parameters);
		}
	}
}	
       </xsl:result-document>
</xsl:template>
</xsl:stylesheet>

