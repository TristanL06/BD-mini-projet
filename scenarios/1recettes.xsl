<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <head>
        <link rel="stylesheet" type="text/css" href="styles.css"/>
        <title>Liste des recettes</title>
      </head>
      <body>
        <h1>Liste des recettes</h1>
        <xsl:apply-templates select="//RECETTE"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="RECETTE">
    <div class="recette" id="{NOM}">
      <h2>
        <xsl:value-of select="NOM"/>
      </h2>
      <img src="{IMAGE}" alt=""/>

      <div class="sante">
        <div class="ligne">
          <div class="cellule">Protéines</div>
          <div class="cellule">
            <xsl:value-of select="SANTE/PROTEINES"/>
          </div>
        </div>
        <div class="ligne">
          <div class="cellule">Glucides</div>
          <div class="cellule">
            <xsl:value-of select="SANTE/GLUCIDES"/>
          </div>
        </div>
        <div class="ligne">
          <div class="cellule">Lipides</div>
          <div class="cellule">
            <xsl:value-of select="SANTE/LIPIDES"/>
          </div>
        </div>
        <div class="ligne">
          <div class="cellule">Vitamines</div>
          <div class="cellule">
            <xsl:value-of select="SANTE/VITAMINES"/>
          </div>
        </div>
        <div class="ligne">
          <div class="cellule">Calcium</div>
          <div class="cellule">
            <xsl:value-of select="SANTE/CALCIUM"/>
          </div>
        </div>
        <div class="ligne">
          <div class="cellule">Fer</div>
          <div class="cellule">
            <xsl:value-of select="SANTE/FER"/>
          </div>
        </div>
      </div>

      <div class="infos ligne">
        <div class="cellule">
          <img src="https://cdn-icons-png.flaticon.com/128/857/857681.png" loading="lazy" alt="Dish" title="Quantité" width="16" height="16"/>
          <xsl:value-of select="QUANTITE"/>
        </div>
        <div class="cellule">
          <img src="https://cdn-icons-png.flaticon.com/128/2088/2088617.png" loading="lazy" alt="Clock " title="Temps" width="16" height="16"/>
          <xsl:value-of select="DUREE"/>
        </div>
        <div class="cellule">
          <img src="https://cdn-icons-png.flaticon.com/128/3565/3565450.png" loading="lazy" alt="Oven " title="Temps de cuisson" width="16" height="16"/>
          <xsl:value-of select="CUISSON"/>
        </div>
        <div class="cellule">
          <img src="https://cdn-icons-png.flaticon.com/128/134/134597.png" loading="lazy" alt="Coins" title="Prix" width="16" height="16"/>
          <xsl:value-of select="PRIX"/>
        </div>
      </div>
      <h3>Ingrédients:</h3>
      <ul>
        <xsl:apply-templates select="INGREDIENTS/INGREDIENT"/>
      </ul>
      <h3>Préparation:</h3>
      <ol>
        <xsl:apply-templates select="PREPARATION/ETAPE"/>
      </ol>
    </div>
  </xsl:template>

  <xsl:template match="INGREDIENT">
    <li>
      <xsl:value-of select="@quantite"/>
      <xsl:text>&#xA0;</xsl:text>
      <xsl:value-of select="//UNITE[@id=current()/@unite]/@short_name"/>
      <xsl:if test="//UNITE[@id=current()/@unite]/@id != 'U4'">
        <xsl:text> de </xsl:text>
      </xsl:if>
      <xsl:value-of select="//PRODUIT[@id=current()/@id]/NOM"/>
    </li>
  </xsl:template>

  <xsl:template match="ETAPE">
    <li>
      <xsl:value-of select="."/>
    </li>
  </xsl:template>

</xsl:stylesheet>
