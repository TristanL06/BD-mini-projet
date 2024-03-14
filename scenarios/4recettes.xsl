<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <output>
            <recettes>
                <xsl:apply-templates select="//RECETTE">
                    <xsl:sort select="moyenne"/>
                </xsl:apply-templates>
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
            <moyenne>
                <xsl:value-of select="sum($related_comments/NOTE) div count($related_comments)"/>
            </moyenne>
        </recette>
    </xsl:template>
</xsl:stylesheet>
