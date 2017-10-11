<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="lid"></xsl:param>
  <xsl:param name="lang">en</xsl:param>
  <xsl:param name="field">No</xsl:param>
  <xsl:param name="datatype">number</xsl:param>
  <xsl:param name="orderby">ascending</xsl:param>
  <xsl:output method="html" />
  <xsl:template match="/">
    <p>(Instruction: Move cursor over the rows to highlight the object on the map. Press the Ctrl-key at the same time to zoom to the object.)</p>
    <p>
      <form action="embfiles/{$lid}.xls">
        <input type="submit" value="Export to Excel" />
        <input type="button" class="recCloseBtn" value="OK" onclick="mv_closeTable('')" />
      </form>
    </p>
    <table id="MVrecTable" class="recTable">
      <tr>
        <xsl:for-each select="table/fs/*">
          <th>
            <xsl:value-of select="." />
          </th>
        </xsl:for-each>
      </tr>
      <tr>
        <xsl:for-each select="table/fs/*">
          <td class="recTable">
            <nobr>
              <a>
                <a>
                  <xsl:attribute name="href">javascript:mv_sortTable('<xsl:value-of select="$lid" />','<xsl:number level="single" count="fs/*" format="1" />','<xsl:value-of select="@datatype" />','ascending');</xsl:attribute>
                  <img src="./pictures/sortascending.png" class="imgAsc" alt="Sort Ascending" />
                </a>
              </a>
              <a>
                <a>
                  <xsl:attribute name="href">javascript:mv_sortTable('<xsl:value-of select="$lid" />','<xsl:number level="single" count="fs/*" format="1" />','<xsl:value-of select="@datatype" />','descending');</xsl:attribute>
                  <img src="./pictures/sortdescending.png" class="imgAsc" alt="Sort Descending" />
                </a>
              </a>
            </nobr>
          </td>
        </xsl:for-each>
      </tr>
      <xsl:for-each select="table/records/rec">
        <xsl:sort data-type="{$datatype}" order="{$orderby}" lang="en" select="c/*[local-name() = $field]" />
        <tr>
          <xsl:if test="position() mod 2 = 0">
            <xsl:attribute name="class">recTableBGAlter</xsl:attribute>
          </xsl:if>
          <xsl:attribute name="onmouseover">mv_hiliteRec('<xsl:for-each select="ts/*"><xsl:value-of select="." />,</xsl:for-each><xsl:value-of select="@id" />','<xsl:value-of select="ext" />',this,window,event);</xsl:attribute>
          <xsl:attribute name="onmouseout">mv_recOut(this);</xsl:attribute>
          <xsl:for-each select="c/*">
            <td>
              <xsl:choose>
                <xsl:when test="contains(current(),'http://') or contains(current(),'https://') or contains(current(),'url:') or contains(current(),'@') or contains(current(),'js:')">
                  <xsl:variable name="url">
                    <xsl:choose>
                      <xsl:when test="contains(current(),';')">
                        <xsl:value-of select="substring-before(current(),';')" />
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="." />
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:variable>
                  <xsl:variable name="title">
                    <xsl:choose>
                      <xsl:when test="contains(current(),';')">
                        <xsl:value-of select="substring-after(current(),';')" />
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="." />
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:variable>
                  <xsl:variable name="url2">
                    <xsl:choose>
                      <xsl:when test="contains($url,'url:')">
                        <xsl:value-of select="substring-after($url,'url:')" />
                      </xsl:when>
                      <xsl:when test="contains($url,'@')">mailto:<xsl:value-of select="$url" /></xsl:when>
                      <xsl:when test="contains($url,'js:')">javascript:<xsl:value-of select="substring-after($url,'js:')" /></xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$url" />
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:variable>
                  <xsl:choose>
                    <xsl:when test="contains($url2,'@') or contains($url2,'javascript:')">
                      <a>
                        <xsl:attribute name="href"><xsl:value-of select="$url2" /></xsl:attribute>
                        <xsl:value-of select="$title" />
                      </a>
                    </xsl:when>
                    <xsl:when test="contains($url2,'.gif') or contains($url2,'.jpg') or contains($url2,'.png')">
                      <img>
                        <xsl:attribute name="src">
                          <xsl:value-of select="$url2" />
                        </xsl:attribute>
                        <xsl:attribute name="class">imgTable</xsl:attribute>
                        <xsl:attribute name="onclick">mv_showWindow('<xsl:value-of select="substring-after($url,'url:')" />');</xsl:attribute>
                      </img>
                    </xsl:when>
                    <xsl:otherwise>
                      <a>
                        <xsl:attribute name="href"><xsl:value-of select="$url2" /></xsl:attribute>
                        <xsl:attribute name="target">MVFullWin</xsl:attribute>
                        <xsl:value-of select="$title" />
                      </a>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:choose>
                    <xsl:when test="string(number(current())) = 'NaN' or contains($lang,'en')">
                      <xsl:value-of select="." />&#160;</xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="translate(current(), '.', ',')" />&#160;</xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
            </td>
          </xsl:for-each>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>
</xsl:stylesheet>