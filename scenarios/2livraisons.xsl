<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <html lang="fr">
      <head>
        <title>Liste des commandes</title>
      </head>
      <body>
        <h1>Liste des commandes</h1>
        <table border="1">
          <tr>
            <th>Recette</th>
            <th>Quantité</th>
            <th>Date</th>
            <th>Client</th>
            <th>Livreur</th>
            <th>Détails Recette</th>
            <th>Détails Livraison</th>
            <th>Adresse</th>
          </tr>
          <xsl:apply-templates select="//COMMANDE"/>
        </table>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="COMMANDE">
    <tr>
      <td>
        <xsl:apply-templates select="RECETTEID"/>
      </td>
      <td>
        <xsl:value-of select="QUANTITE"/>
      </td>
      <td>
        <xsl:value-of select="DATE"/>
      </td>
      <td>
        <xsl:apply-templates select="CLIENTID"/>
      </td>
      <td>
        <xsl:apply-templates select="LIVREURID"/>
      </td>
      <td>
        <xsl:value-of select="DETAILS/D_RECETTE"/>
      </td>
      <td>
        <xsl:value-of select="DETAILS/D_LIVRAISON"/>
      </td>
      <td>
        <xsl:apply-templates select="CLIENTID" mode="adresse"/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="RECETTEID">
    <xsl:variable name="recette" select="//RECETTE[@id=current()]"/>
    <a href="1recettes.xml#{$recette/NOM}">
      <xsl:value-of select="$recette/NOM"/>
    </a>
  </xsl:template>

  <xsl:template match="CLIENTID">
    <xsl:variables name="client" select="//CLIENT[@id=current()]"/>
    <xsl:value-of select="//CLIENT[@id=current()]/PRENOM"/>
    <xsl:text>&#160;</xsl:text>
    <xsl:value-of select="//CLIENT[@id=current()]/NOM"/>
  </xsl:template>

  <xsl:template match="LIVREURID">
    <xsl:value-of select="//LIVREUR[@id=current()]/NOM"/>
  </xsl:template>

  <xsl:template match="CLIENTID" mode="adresse">
    <xsl:value-of select="//CLIENT[@id=current()]/ADRESSE"/>
    <br/>
    <xsl:value-of select="//CLIENT[@id=current()]/CODEPOSTAL"/>
    <xsl:text>&#160;</xsl:text>
    <xsl:value-of select="//CLIENT[@id=current()]/VILLE"/>
  </xsl:template>

</xsl:stylesheet>
