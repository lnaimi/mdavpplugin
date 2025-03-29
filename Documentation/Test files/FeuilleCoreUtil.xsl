<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:uFN="uFN" version="2.0">
  <xsl:import href="utilFunctions.xsl"/>
	<xsl:output method="text" encoding="iso-8859-1" indent="yes"/>

  <xsl:template match="Project/Models">
	   <xsl:result-document href="{$projectName}/{$projectName}.Core/Util.cs">
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace <xsl:value-of select="$projectName"/>.Core
{
    public static class Util
    {
        //Double le caract<xsl:text>&#232;</xsl:text>re <xsl:text>&#39;</xsl:text> dans une cha<xsl:text>&#238;</xsl:text>ne
        public static string DoubleQuote(string psString)
        {
            if (isNULL(psString))
                return "";
            if (psString == "")
                return "";
            return psString.Replace("'", "''");
        }
        #region Conversion

        public static int StringToInt(string psString)
        {
            if (isNULL(psString))
                return int.MinValue;
            if (psString.Length == 0)
                return int.MinValue;
            try
            {
                int liTemp = int.Parse(psString);

                return liTemp;
            }
            catch
            {
                return int.MinValue;
            }
        }

        #endregion

        #region TraitementChaine

        public static string RemoveDoubleSpaces(string psString)
        {
            string lsTemp = "";

            psString = psString.Trim();
            while (lsTemp != psString)
            {
                lsTemp = psString;
                psString = psString.Replace("  ", " ");
            }
            return psString;
        }

        public static string FillLenghtString(string psStringToBeFilled, int piLenght, bool pbFromStart, char pcFillingChar)
        {
            int liLenght = psStringToBeFilled.Length;

            while (piLenght > liLenght)
            {
                if (pbFromStart)
                    psStringToBeFilled = pcFillingChar + psStringToBeFilled;
                else
                    psStringToBeFilled += pcFillingChar;
                liLenght += 1;
            }
            return psStringToBeFilled;
        }

        public static string ZeroFill(int piNumber, int piQtyOfZero)
        {
            return ZeroFill(piNumber.ToString(), piQtyOfZero);
        }

        public static string ZeroFill(string psToBeFilled, int piQtyOfZero)
        {
            if (isNULL(psToBeFilled))
                return null;
            while (psToBeFilled.Length <xsl:text>&lt;</xsl:text> piQtyOfZero)
                psToBeFilled = "0" + psToBeFilled;
            return psToBeFilled;
        }

        #endregion

        #region Validation

        public static bool isNULL(object pNullableObj)
        {
            return (pNullableObj == null);
        }

        public static bool isValidGuid(string psGuid)
        {
            if (isNULL(psGuid))
                return false;
            if (psGuid == "")
                return false;
            try
            {
                Guid lGuid = new Guid(psGuid);
                return true;
            }
            catch
            {
                return false;
            }
        }

        public static bool isCharAlphaNum(char pcChar)
        {
            if (isNULL(pcChar))
                return false;

            int liChar = Convert.ToInt32(pcChar);

            //48..57         
            //65..90         
            //97..122        
            //128..154      
            //160..165      
            //181..183      
            //198           
            //199           
            //210..212      
            //214..216      
            //222           
            //224           
            //226..229      
            //233..237      
            return ((liChar <xsl:text>&gt;</xsl:text>= 48 <xsl:text>&amp;&amp;</xsl:text> liChar <xsl:text>&lt;</xsl:text>= 57) || (liChar <xsl:text>&gt;</xsl:text>= 65 <xsl:text>&amp;&amp;</xsl:text> liChar <xsl:text>&lt;</xsl:text>= 90) || (liChar <xsl:text>&gt;</xsl:text>= 97 <xsl:text>&amp;&amp;</xsl:text> liChar <xsl:text>&lt;</xsl:text>= 122) ||
                    (liChar <xsl:text>&gt;</xsl:text>= 128 <xsl:text>&amp;&amp;</xsl:text> liChar <xsl:text>&lt;</xsl:text>= 154) || (liChar <xsl:text>&gt;</xsl:text>= 160 <xsl:text>&amp;&amp;</xsl:text> liChar <xsl:text>&lt;</xsl:text>= 165) || (liChar <xsl:text>&gt;</xsl:text>= 181 <xsl:text>&amp;&amp;</xsl:text> liChar <xsl:text>&lt;</xsl:text>= 183) ||
                    (liChar == 198) || (liChar == 199) || (liChar <xsl:text>&gt;</xsl:text>= 210 <xsl:text>&amp;&amp;</xsl:text> liChar <xsl:text>&lt;</xsl:text>= 212) ||
                    (liChar <xsl:text>&gt;</xsl:text>= 214 <xsl:text>&amp;&amp;</xsl:text> liChar <xsl:text>&lt;</xsl:text>= 216) || (liChar == 222) || (liChar == 224) ||
                    (liChar <xsl:text>&gt;</xsl:text>= 226 <xsl:text>&amp;&amp;</xsl:text> liChar <xsl:text>&lt;</xsl:text>= 229) || (liChar <xsl:text>&gt;</xsl:text>= 233 <xsl:text>&amp;&amp;</xsl:text> liChar <xsl:text>&lt;</xsl:text>= 237));
        }

        #endregion

    }
}


       </xsl:result-document>
</xsl:template>
</xsl:stylesheet>

