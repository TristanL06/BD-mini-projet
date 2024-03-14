import xml.etree.ElementTree as ET

def xml_to_dict(xml_file):
    tree = ET.parse(xml_file)
    root = tree.getroot()
    return element_to_dict(root)

def element_to_dict(element):
    result = {}
    if element.attrib:
        result.update(element.attrib)
    for child in element:
        child_result = element_to_dict(child)
        if child.tag in result:
            if isinstance(result[child.tag], list):
                result[child.tag].append(child_result)
            else:
                result[child.tag] = [result[child.tag], child_result]
        else:
            result[child.tag] = child_result
    if element.text:
        result[element.tag] = element.text.strip()
    return result

def dict_tree(tree: dict)-> str:
    """
    Show the dictionary as a tree structure
    """
    def _dict_tree(tree: dict, indent: int)-> str:
        tree_str = ""
        for key, value in tree.items():
            tree_str += "  " * indent + str(key) + "\n"
            if isinstance(value, dict):
                tree_str += _dict_tree(value, indent + 1)
            elif isinstance(value, list):
                for item in value:
                    tree_str += _dict_tree(item, indent + 1)
            else:
                tree_str += "  " * (indent + 1) + str(value) + "\n"
        return tree_str
    return _dict_tree(tree, 0)

import xml.etree.ElementTree as ET

from copy import copy

def dictify(r,root=True):
    if root:
        return {r.tag : dictify(r, False)}
    d=copy(r.attrib)
    if r.text and r.text.strip():
        d["_text"]=r.text.strip()
    for x in r.findall("./*"):
        if x.tag not in d:
            d[x.tag]=[]
        d[x.tag].append(dictify(x,False))
    return d

def get_ingredient_by_id(data: dict, id: str) -> None | dict:
    """
    Get the ingredients of a recipe by its id
    """
    for ingredient in data['PRODUITS'][0]["PRODUIT"]:
        if ingredient['id'] == id:
            return ingredient['NOM'][0]["_text"]
    return None


def vide_frigo(aliments: list):
    """
    @input: aliments: list of aliments in the fridge
    @output: recipes that can be made with the aliments in the fridge
    """
    root = ET.parse('BD-mini-projet/scenarios/6database.xml').getroot()
    data = dictify(root)["ROOT"]

    recettes = []
    for recipe in data['RECETTES'][0]["RECETTE"]:
        aliments_recette = [get_ingredient_by_id(data, ingredient["id"]) for ingredient in recipe['INGREDIENTS'][0]["INGREDIENT"]]
        if all(aliment in aliments for aliment in aliments_recette):
            recettes.append(recipe["NOM"][0]["_text"])
    return recettes

def ingredients_dans(recette: str):
    """
    @input: recette: name of the recipe
    @output: ingredients of the recipe
    """
    root = ET.parse('BD-mini-projet/scenarios/6database.xml').getroot()
    data = dictify(root)["ROOT"]

    for recipe in data['RECETTES'][0]['RECETTE']:
        recipe_name = recipe["NOM"][0]["_text"]
        if recipe_name == recette:
            return [get_ingredient_by_id(data, ingredient["id"]) for ingredient in recipe['INGREDIENTS'][0]["INGREDIENT"]]

if __name__ == "__main__":
    print("Ingredients dans la recette Salade de fruits: ")
    print(ingredients_dans('Salade de fruits'))

    print("Tentative de recettes avec les aliments dans le frigo:")
    # pas suffisant pour faire une recette
    frigo = ["pomme", "banane", "orange", "kiwi"]
    print("pas suffisant pour faire une recette:")
    print(vide_frigo(frigo))

    # suffisant pour faire une salade de fruits
    frigo = ["pomme", "banane", "orange", "kiwi", "lait", "sucre", "citron", "poivre"]
    print("suffisant pour faire une salade de fruits:")
    print(vide_frigo(frigo))

    # suffisant pour faire une salade de pâtes
    frigo = ["pâtes", "tomates", "oignon", "poivron", "huile d'olive", "sel", "poivre", "concombre", "vinaigre"]
    print("suffisant pour faire une salade de pâtes:")
    print(vide_frigo(frigo))

    # suffisant pour faire des crêpes
    frigo = ["farine", "oeufs", "beurre", "lait", "sucre", "sel"]
    print("suffisant pour faire des crêpes:")
    print(vide_frigo(frigo))

    # suffisant pour faire une salade de fruits et des crêpes
    frigo = ["pomme", "banane", "orange", "kiwi", "lait", "sucre", "citron", "poivre", "farine", "oeufs", "beurre", "sel"]
    print("suffisant pour faire une salade de fruits et des crêpes:")
    print(vide_frigo(frigo))