<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>

    <!-- Template pour l'élément ROOT -->
    <xsl:template match="/ROOT">
        <xsl:text>{&#10;</xsl:text>
        <xsl:apply-templates select="RECETTES"/>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <!-- Template pour l'élément RECETTES -->
    <xsl:template match="RECETTES">
        <xsl:text>"RECETTES": [&#10;</xsl:text>
        <xsl:apply-templates select="RECETTE"/>
        <xsl:text>]&#10;</xsl:text>
    </xsl:template>

    <!-- Template pour l'élément RECETTE -->
    <xsl:template match="RECETTE">
        <xsl:text>{&#10;</xsl:text>
        <xsl:text>"NOM": "</xsl:text>
        <xsl:value-of select="NOM"/>
        <xsl:text>",&#10;</xsl:text>
        <xsl:text>"IMAGE": "</xsl:text>
        <xsl:value-of select="IMAGE"/>
        <xsl:text>",&#10;</xsl:text>
        <xsl:text>"QUANTITE": "</xsl:text>
        <xsl:value-of select="QUANTITE"/>
        <xsl:text>",&#10;</xsl:text>
        <xsl:text>"DUREE": "</xsl:text>
        <xsl:value-of select="DUREE"/>
        <xsl:text>",&#10;</xsl:text>
        <xsl:text>"CUISSON": "</xsl:text>
        <xsl:value-of select="CUISSON"/>
        <xsl:text>",&#10;</xsl:text>
        <xsl:text>"PRIX": "</xsl:text>
        <xsl:value-of select="PRIX"/>
        <xsl:text>",&#10;</xsl:text>
        <xsl:text>"SANTE": {&#10;</xsl:text>
        <xsl:text>"PROTEINES": "</xsl:text>
        <xsl:value-of select="SANTE/PROTEINES"/>
        <xsl:text>",&#10;</xsl:text>
        <xsl:text>"GLUCIDES": "</xsl:text>
        <xsl:value-of select="SANTE/GLUCIDES"/>
        <xsl:text>",&#10;</xsl:text>
        <xsl:text>"LIPIDES": "</xsl:text>
        <xsl:value-of select="SANTE/LIPIDES"/>
        <xsl:text>",&#10;</xsl:text>
        <xsl:text>"VITAMINES": "</xsl:text>
        <xsl:value-of select="SANTE/VITAMINES"/>
        <xsl:text>",&#10;</xsl:text>
        <xsl:text>"CALCIUM": "</xsl:text>
        <xsl:value-of select="SANTE/CALCIUM"/>
        <xsl:text>",&#10;</xsl:text>
        <xsl:text>"FER": "</xsl:text>
        <xsl:value-of select="SANTE/FER"/>
        <xsl:text>"&#10;</xsl:text>
        <xsl:text>},&#10;</xsl:text>
        <xsl:text>"INGREDIENTS": [&#10;</xsl:text>
        <xsl:apply-templates select="INGREDIENTS/INGREDIENT"/>
        <xsl:text>],&#10;</xsl:text>
        <xsl:text>"PREPARATION": [&#10;</xsl:text>
        <xsl:apply-templates select="PREPARATION/ETAPE"/>
        <xsl:text>]</xsl:text>
        <xsl:if test="position() != last()">
        </xsl:if>
        <xsl:text>&#10;}</xsl:text>
        <xsl:if test="position() != last()">
            <xsl:text>,</xsl:text>
        </xsl:if>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <!-- Template pour l'élément INGREDIENT -->
    <xsl:template match="INGREDIENT">
        <xsl:text>{ "nom": "</xsl:text>
        <xsl:variable name="ingredientID" select="@id"/>
        <xsl:value-of select="//PRODUITS/PRODUIT[@id = $ingredientID]/NOM"/>
        <xsl:text>", "quantite": "</xsl:text>
        <xsl:value-of select="@quantite"/>
        <xsl:text>", "unite": "</xsl:text>
        <xsl:variable name="uniteID" select="@unite"/>
        <xsl:value-of select="//UNITE[@id = $uniteID]"/>
        <xsl:text>", "unite_short_name": "</xsl:text>
        <xsl:value-of select="//UNITE[@id = $uniteID]/@short_name"/>
        <xsl:text>"}</xsl:text>
        <xsl:if test="position() != last()">
            <xsl:text>,</xsl:text>
        </xsl:if>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <!-- Template pour l'élément ETAPE -->
    <xsl:template match="ETAPE">
        <xsl:text>"</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>"</xsl:text>
        <xsl:if test="position() != last()">
            <xsl:text>,</xsl:text>
        </xsl:if>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

</xsl:stylesheet>
