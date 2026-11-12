# Prompts — les 3 environnements d'AntSurvivor

Ambiance visée : un monde miniature vu à hauteur de fourmi, inspiré de *Arthur et les Minimoys* :
les objets du quotidien deviennent géants (brin d'herbe = arbre, caillou = falaise, capsule = bassin),
lumière chaude de cinéma, nature très détaillée et humide.

## Comment faire
1. Ouvre `01_jardin.md`, `02_fourmiliere.md`, `03_reine.md`.
2. Chaque fichier contient **3 prompts** (en anglais : les générateurs d'images comprennent mieux).
   Copie **un prompt entier à la fois** dans ton générateur d'images. Une image par prompt.
   - Prompt A : SOL (tuiles qui se raccordent)
   - Prompt B : OBJETS (chaque objet séparé, fond magenta uni)
   - Prompt C : SCÈNE de référence (pour vérifier l'ambiance, pas utilisée en jeu)
3. Si l'image ne te plaît pas, régénère avec le même prompt (n'en change pas le style, sinon les 3 niveaux
   ne se ressembleront plus). Tu peux ajouter à la fin : « more saturated », « darker », « less detail »…
4. Enregistre tes images dans le dossier `resultats/` avec ces noms exacts :
   - `jardin_sol.png`, `jardin_objets.png`, `jardin_scene.png`
   - `fourmiliere_sol.png`, `fourmiliere_objets.png`, `fourmiliere_scene.png`
   - `reine_sol.png`, `reine_objets.png`, `reine_scene.png`
5. Dis-moi « c'est dans resultats » : je découpe tout, je rends le sol raccordable,
   je détoure les objets, je mets les collisions et je crée les TileSet Godot.

## Règles importantes (déjà dans les prompts)
- Vue de dessus en 3/4 (comme Zelda ou Stardew Valley), lumière qui vient d'en haut à gauche.
- Pixel art, **aucun texte**, aucun cadre, aucune étiquette.
- Objets sur **fond magenta uni (#FF00FF)** avec de l'espace entre eux : c'est ce qui me permet de les détourer proprement.
- Le héros mesure 1 tuile : un caillou fait 2-3 tuiles, une fleur 3-4 tuiles.
