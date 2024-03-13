<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <output>
            <recettes>
                <xsl:apply-templates select="//RECETTE"/>
            </recettes>
        </output>
    </xsl:template>

    <xsl:template match="RECETTE">
        <recette>
            <xsl:attribute name="id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <nom>
                <xsl:value-of select="NOM"/>
            </nom>
            <xsl:variable name="related_comments" select="//COMMENTAIRE[COMMANDEID=//COMMANDE[RECETTEID=current()/@id]/@id]"/>
            <!--
            <notes>
                <xsl:for-each select="$related_comments">
                    <note>
                        <xsl:value-of select="NOTE"/>
                    </note>
                </xsl:for-each>
            </notes>
            -->
            <moyenne>
                <xsl:value-of select="sum($related_comments/NOTE) div count($related_comments)"/>
            </moyenne>
            <xsl:value-of select="//COMMENTAIRE[RECETTEID=current()/@id]/NOTE"/>
        </recette>
    </xsl:template>
</xsl:stylesheet>
