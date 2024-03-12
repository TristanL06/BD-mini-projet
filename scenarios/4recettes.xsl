<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <catalogue>
            <!-- Sélection de toutes les recettes et tri selon la note moyenne -->
            <xsl:apply-templates select="//RECETTE"/>
            <!--<xsl:sort select="sum(avis_client/note) div count(avis_client)" data-type="number" order="descending"/>
            </xsl:apply-templates>-->
        </catalogue>
    </xsl:template>

    <!-- Modèle de recette -->
    <xsl:template match="RECETTE">
        <recette>
            <nom>
                <xsl:value-of select="NOM"/>
            </nom>
            <image>
                <xsl:value-of select="IMAGE"/>
            </image>
            <note>
                <xsl:apply-templates select="//COMMENTAIRE"/>
                <!--<xsl:value-of select="sum(avis_client/note) div count(avis_client)"/>-->
            </note>
        </recette>
    </xsl:template>

    <xsl:template match="COMMENTAIRE">
        <xsl:value-of select="COMMANDEID"/>
        <xsl:if test="//COMMANDE[@id=//COMMENTAIRE[@id=current()]/COMMANDEID]/RECETTEID">
            <xsl:value-of select="NOTE"/>
        </xsl:if>
        <xsl:value-of select="NOTE"/>
        <xsl:value-of select="//RECETTE[@id=//COMMANDE[@id=current()]/RECETTEID]"/>
    </xsl:template>
</xsl:stylesheet>