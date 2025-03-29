<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:uFN="uFN" version="2.0">
  <xsl:import href="utilFunctions.xsl"/>
	<xsl:output method="text" encoding="iso-8859-1" indent="yes"/>
<xsl:template match="Project/Models/Package/ModelChildren">
	   <xsl:result-document href="{$projectName}/{$projectName}.Core/Specifications/BaseSpecification.cs">
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using <xsl:value-of select="$projectName"/>.SharedKernel.Interfaces;

namespace <xsl:value-of select="$projectName"/>.Core.Specifications
{
	public abstract class BaseSpecification&#60;T&#62; : ISpecification&#60;T&#62;
  {
    protected BaseSpecification(Expression&#60;Func&#60;T, bool&#62;&#62; criteria)
    {
      Criteria = criteria;
    }
    public Expression&#60;Func&#60;T, bool&#62;&#62; Criteria { get; }
    public List&#60;Expression&#60;Func&#60;T, object&#62;&#62;&#62; Includes { get; } = new List&#60;Expression&#60;Func&#60;T, object&#62;&#62;&#62;();
    public List&#60;string&#62; IncludeStrings { get; } = new List&#60;string&#62;();
    public Expression&#60;Func&#60;T, object&#62;&#62; OrderBy { get; private set; }
    public Expression&#60;Func&#60;T, object&#62;&#62; OrderByDescending { get; private set; }
    public Expression&#60;Func&#60;T, object&#62;&#62; GroupBy { get; private set; }

    public int Take { get; private set; }
    public int Skip { get; private set; }
    public bool IsPagingEnabled { get; private set; } = false;

    protected virtual void AddInclude(Expression&#60;Func&#60;T, object&#62;&#62; includeExpression)
    {
      Includes.Add(includeExpression);
    }
    protected virtual void AddInclude(string includeString)
    {
      IncludeStrings.Add(includeString);
    }
    protected virtual void ApplyPaging(int skip, int take)
    {
      Skip = skip;
      Take = take;
      IsPagingEnabled = true;
    }
    protected virtual void ApplyOrderBy(Expression&#60;Func&#60;T, object&#62;&#62; orderByExpression)
    {
      OrderBy = orderByExpression;
    }
    protected virtual void ApplyOrderByDescending(Expression&#60;Func&#60;T, object&#62;&#62; orderByDescendingExpression)
    {
      OrderByDescending = orderByDescendingExpression;
    }

    protected virtual void ApplyGroupBy(Expression&#60;Func&#60;T, object&#62;&#62; groupByExpression)
    {
      GroupBy = groupByExpression;
    }
  }
}	
       </xsl:result-document>
</xsl:template>
</xsl:stylesheet>

