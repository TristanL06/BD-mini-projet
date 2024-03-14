<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <head>
        <link rel="stylesheet" type="text/css" href="styles.css"/>
        <title>Liste des avis</title>
      </head>
      <body>
        <h1>Liste des avis</h1>
        <xsl:apply-templates select="//COMMENTAIRE"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="COMMENTAIRE">
    <div class="avis">
      <h2>
        <xsl:value-of select="TITRE"/>
&#xA0;
        <xsl:call-template name="generateStars">
          <xsl:with-param name="note" select="number(NOTE)"/>
        </xsl:call-template>
      </h2>
      <div class="clientName">
        <p>
          <xsl:apply-templates select="COMMANDEID"/>
        </p>
      </div>
      <p>
        <xsl:value-of select="TEXTE"/>
      </p>
    </div>
  </xsl:template>

  <!-- Template for generating stars based on the note -->
  <xsl:template name="generateStars">
    <xsl:param name="note"/>
    <xsl:param name="counter" select="1"/>
    <!-- Condition to check if counter is less than or equal to note -->
    <xsl:if test="$counter &lt;= $note">
      <!-- Output a star -->
      <xsl:text disable-output-escaping="yes">&#9733;</xsl:text>
      <!-- Recursive call to generate next star -->
      <xsl:call-template name="generateStars">
        <xsl:with-param name="note" select="$note"/>
        <xsl:with-param name="counter" select="$counter + 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template match="COMMANDEID">
    <xsl:variable name="recette" select="//RECETTES/RECETTE[@id=//COMMANDE[@id=current()]/RECETTEID]"/>
    <a href="1recettes.xml#{$recette/NOM}">
      <xsl:value-of select="$recette/NOM"/>
    </a>
    <xsl:text> • </xsl:text>
    <xsl:value-of select="//CLIENT[@id=//COMMANDE[@id=current()]/CLIENTID]/PRENOM"/>
  </xsl:template>

</xsl:stylesheet>
