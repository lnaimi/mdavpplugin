<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:uFN="uFN" version="2.0">
  <xsl:import href="utilFunctions.xsl"/>
	<xsl:output method="text" encoding="iso-8859-1" indent="yes"/>
<xsl:template match="Project/Models/Package/ModelChildren">
	   <xsl:result-document href="{$projectName}/{$projectName}.Infrastructure/Specifications/SpecificationEvaluator.cs">
using System.Linq;
using Microsoft.EntityFrameworkCore;
using <xsl:value-of select="$projectName"/>.SharedKernel;
using <xsl:value-of select="$projectName"/>.Core;
using <xsl:value-of select="$projectName"/>.SharedKernel.Interfaces;

namespace <xsl:value-of select="$projectName"/>.Infrastructure.Specifications
{
	public class SpecificationEvaluator&#60;T&#62; where T : BaseEntity
    {
        public static IQueryable&#60;T&#62; GetQuery(IQueryable&#60;T&#62; inputQuery, ISpecification&#60;T&#62; specification)
        {
            var query = inputQuery;

            // modify the IQueryable using the specification's criteria expression
            if (specification.Criteria != null)
            {
                query = query.Where(specification.Criteria);
            }

            // Includes all expression-based includes
            query = specification.Includes.Aggregate(query,
                                    (current, include) =&#62; current.Include(include));

            // Include any string-based include statements
            query = specification.IncludeStrings.Aggregate(query,
                                    (current, include) =&#62; current.Include(include));

            // Apply ordering if expressions are set
            if (specification.OrderBy != null)
            {
                query = query.OrderBy(specification.OrderBy);
            }
            else if (specification.OrderByDescending != null)
            {
                query = query.OrderByDescending(specification.OrderByDescending);
            }

            if (specification.GroupBy != null)
            {
                query = query.GroupBy(specification.GroupBy).SelectMany(x =&#62; x);
            }

            // Apply paging if enabled
            if (specification.IsPagingEnabled)
            {
                query = query.Skip(specification.Skip)
                             .Take(specification.Take);
            }
            return query;
        }
    }
}	
       </xsl:result-document>
</xsl:template>
</xsl:stylesheet>

