# IF36 \- Proposition

## Introduction

Dans le cadre du projet pour l’UE IF36, “Visualiser des données”, notre groupe utilisera le jeu de données suivant : “Spotify and Youtube, Statistics for the Top 10 songs of various spotify artists and their yt video”. Ce dataset provient du site kaggle.com, et est fait par Salvatore Rastelli, Marco Sallustio et Marco Guarisco. Le dataset a été publié le 7 février 2023, avec les données provenant de 2 sources : Spotify, Youtube.

Ce jeu de données est composé de 20 717 individus, avec 28 features. Le tableau suivant contient chaque feature, type et son description : 

| *Feature*  | *Type* | *Description* |
| :---- | :---- | :---- |
| \# | entier | id |
| `Track` | string | Nom de la chanson tel qu'affiché sur Spotify. |
| `Artist` | string | Nom de l'artiste. |
| `Url_spotify` | string | Lien URL vers le profil Spotify de l'artiste. |
| `Album` | string | Album Spotify contenant la chanson. |
| `Album_type` | catégorielle | Indique si la chanson est sortie en tant que single, un album, ou autre. |
| `Uri` | string | Lien Spotify utilisé pour identifier précisément la chanson via l’API Spotify. |
| `Danceability` | float | Score (0 à 1\) indiquant à quel point la chanson est adaptée à la danse (0 \= peu adaptée, 1 \= très adaptée). |
| `Energy` | float | Mesure (0 à 1\) de l'intensité et de l'activité du morceau. Plus la valeur est élevée, plus le morceau est énergique et dynamique. |
| `Key` | catégorielle | Tonalité de la chanson représentée par un chiffre (0 \= Do, 1 \= Do♯/Ré♭, 2 \= Ré, etc.). Une valeur de \-1 indique une tonalité non détectée. |
| `Loudness` | float | Volume moyen de la chanson en décibels (dB), généralement entre \-60 et 0 dB. |
| `Speechiness` | float | Indique (0 à 1\) la présence de paroles parlées (0 \= essentiellement musicale, \>0.66 \= essentiellement parlée, entre 0.33 et 0.66 \= mixte). |
| `Acousticness` | float | Probabilité (0 à 1\) que le morceau soit acoustique (1 \= forte certitude d’un morceau acoustique). |
| `Instrumentalness` | float | Probabilité (0 à 1\) que le morceau soit instrumental (sans voix). Plus la valeur est élevée, plus la chanson est probablement instrumentale. |
| `Liveness` | float | Probabilité (0 à 1\) que le morceau ait été enregistré en direct (live). Valeurs \> 0.8 indiquent probablement une performance live. |
| `Valence` | float | Score (0 à 1\) représentant l’émotion positive transmise par la chanson (0 \= négatif/triste, 1 \= positif/joyeux). |
| `Tempo` | float | Tempo moyen de la chanson en battements par minute (BPM). |
| `Duration_ms` | float | Durée totale du morceau en millisecondes. |
| `Stream` | entier | Nombre total d’écoutes de la chanson sur Spotify. |
| `Url_youtube` | string | Lien vers la vidéo de la chanson sur YouTube, si disponible. |
| `Title` | string | Titre de la vidéo YouTube associée. |
| `Channel` | string | Nom de la chaîne YouTube qui a publié la vidéo. |
| `Views` | entier | Nombre de vues sur YouTube. |
| `Likes` | entier | Nombre de "J’aime" sur YouTube. |
| `Comments` | entier | Nombre de commentaires sur la vidéo YouTube. |
| `Description` | string | Description de la vidéo sur YouTube. |
| `Licensed` | catégorielle | Indique si la vidéo contient du contenu sous licence officielle revendiquée par un partenaire YouTube. |
| `official_video` | catégorielle | Valeur booléenne (Vrai/Faux) indiquant si la vidéo YouTube est la vidéo officielle de la chanson. |

Le dataset utilisé est complet et ne devrait pas nécessiter de traitement de données particulier avant son utilisation. Cependant, pour l’analyse de données dans le cadre de notre projet, certaines features ne sont pas nécessaires, tel que : 

* `Url_spotify`
* `Uri`  
* `Url_youtube`  
* `Description`

## Plan d’analyse

1. **Quelle est la répartition des types d'albums (album vs single) dans le dataset ?**

L’objectif est de visualiser la fréquence des chansons issues d’albums par rapport aux singles.

Variables utilisées : `Album_type`

Types de visualisations à envisager :

* Un barplot pour comparer les 2

Problèmes potentiels :

* Données mal renseignées ou mal orthographiées (ex. : “Single” vs “single”)

---

2. **Y a-t-il une corrélation entre la “danceability” et le tempo ?**

L’objectif est d’observer si un tempo élevé rend une chanson plus dansante.

Variables utilisées : `Danceability`, `Tempo`

Types de visualisations à envisager :

* Un nuage de points (scatterplot) avec une ligne de tendance

Problèmes potentiels :

* Outliers (ex. : tempo très bas ou très élevé)

---

3. **Quelle est la distribution des émotions (valence) des chansons ?**

On souhaite voir si les morceaux sont globalement joyeux ou tristes.

Variables utilisées : `Valence`

Types de visualisations à envisager :

* Un histogramme ou une courbe de densité

Problèmes potentiels :

* Données extrêmes ou incorrectes (valeurs hors de \[0,1\])

---

4. **Les chansons live ont-elles tendance à avoir plus de vues sur YouTube que sur Spotify ?**

L’objectif est d’examiner si les morceaux enregistrés en live sont proportionnellement plus vus sur YouTube que streamés sur Spotify, en comparant le ratio `Stream/Views`.

Variables utilisées : `Liveness`, `Views`, `Stream`

Types de visualisations à envisager :

* Un boxplot du ratio `Stream/Views` pour les morceaux avec `Liveness > 0.8` (live) vs les autres

Problèmes potentiels :

* Données manquantes sur l’une des deux plateformes

* Faible proportion de morceaux live (biais possible)

* Ratios potentiellement très variables

---

5. **Quelle est la distribution des durées des morceaux ?**

Observer si les morceaux suivent une longueur standard (environ 3 minutes).

Variables utilisées : `Duration_ms`

Types de visualisations à envisager :

* Un histogramme des durées converties en minutes  
* Une boxplot pour détecter les extrêmes

Problèmes potentiels :

* Présence de très longs fichiers (ex. : lives ou compilations)

---

6. **Les vidéos officielles ont-elles plus de vues que les autres ?**

On souhaite savoir si le fait qu'une vidéo soit “officielle” influence sa popularité.

Variables utilisées : `official_video`, `Views`

Types de visualisations à envisager :

* Une boxplot comparant les vues selon la variable `official_video`

Problèmes potentiels :

* Certaines vidéos non-officielles peuvent devenir virales

---

7. **Quelles sont les variables qui influencent les performances sur YouTube et les streams Spotify ?**

L’objectif est d’identifier les caractéristiques des chansons (audio features) qui ont le plus d’impact sur la popularité, à la fois en termes de streams, de vues, de commentaires et de likes.

Variables utilisées :

* Variables indépendantes : `Danceability`, `Energy`, `Loudness`, `Speechiness`, `Acousticness`, `Instrumentalness`, `Liveness`, `Valence`, `Key`, `Tempo`, `Duration_ms`, etc.

* Variables cibles : `Likes`, `Views`, `Stream`, `Comments` 

Types de visualisations à envisager :

* Une heatmap des corrélations entre toutes les variables numériques

* Des barplots des coefficients ou importances des variables par cible (`Likes`, `Views`, `Stream`)

Problèmes potentiels :

* Corrélations faibles ou multicolinéarité

* Nécessité de normaliser les valeurs (ex. : `Duration_ms` qui sera en moyenne beaucoup plus grand que `Liveness`)

---

8. **Quels sont les morceaux les plus populaires sur Spotify et sur YouTube, et se recoupent-ils ?**

Comparer les chansons les plus populaires sur chaque plateforme.

Variables utilisées : `Stream`, `Views`, `Track`, `Artist`

Types de visualisations à envisager :

* Deux barplots côte à côte : top 10 Spotify vs top 10 YouTube  
* Mise en évidence des morceaux présents dans les deux classements

Problèmes potentiels :

* Données manquantes d’un côté (ex : YouTube ou Spotify)

---

9. **Quelle est la tonalité la plus fréquente dans les chansons du dataset ?**

Identifier les tonalités musicales les plus utilisées.

Variables utilisées : `Key`

Types de visualisations à envisager :

* Un barplot avec les notes de musique comme catégories

Problèmes potentiels :

* Valeur \-1 indiquant une tonalité non détectée

---

10. **Quelle est la relation entre la présence d’un contenu sous licence et le nombre de vues ?**

Analyser si le contenu “officiel” est plus souvent regardé.

Variables utilisées : `Licensed`, `Views`

Types de visualisations à envisager :

* Un boxplot ou histogramme comparatif

Problèmes potentiels :

* Absence d’information sur la stratégie de distribution

---

11. **Est-ce qu’une tonalité a un effet sur le type de chanson  ?**

Examiner les caractéristiques des musiques pour chaque tonalité. On sait que, dans certains genres musicaux, on favorise des tonalités en raison de contraintes techniques (système sons dans les clubs pour l’électro, tempérament pour le classique, …).

Variables utilisées : `Key`, `Danceability, Energy, Valence, Speechiness, Tempo, Instrumentalness`

Types de visualisations à envisager :

* Un barplot par tonalité avec les caractéristiques par moyenne représenté par une barre chacune

Problèmes potentiels :

* Des données extrêmes sur certaines chansons peuvent fausser le résultat.

---

12. **Est-ce qu’un compte YouTube officiel est plus populaire qu’un compte fan  ?** 

Examiner et comparer la popularité des comptes YouTube, en fonction de leur type.

Variables utilisées : `Likes, Channel.`

Types de visualisations à envisager :

* Bar plot  
* Scatter plot

Problèmes potentiels :

* Le besoin d’ajouter une nouvelle feature, qui donne le type d’un channel YouTube (officiel ou fan).

---

13. **Quel artiste est le plus populaire du moment ?** 

Afficher les artistes les plus populaires au moment du 7 février 2023\. Possibilité de faire 3 graphiques (graphique 1 : Selons les vues sur Youtube, graphique 2 : Selons les écoutes sur Spotify, graphique 3 : Selons l’ensemble des 2 plateformes), afin de voir l’influence de la plateforme sur la popularité de l’artiste.

Variables utilisées : `Artist, Stream, Views.`

Types de visualisations à envisager :

* 3 Cleveland Dot Plots, triées par le nombre d'écoutes ou de vues.

Problèmes potentiels :

* Le nombre d’artistes est trop important (2079 valeurs uniques) pour le mettre sur un seul graphique. Possibilité d’afficher que 50 ou 100 artistes les plus populaires.

---

14. **Peut-on regrouper les chansons selon des profils sonores dominants ?**

L'objectif est d'utiliser une PCA pour résumer les principales caractéristiques audio des chansons. Cela permettra de visualiser quelles variables sont les plus importantes et de repérer d’éventuels groupes similaires.

Toutes les variables audio continues : `Danceability, Energy, Loudness,Speechiness, Acousticness, Instrumentalness, Liveness, Valence, Tempo, Duration_ms`

Types de visualisations à envisager :

* 3 Cleveland Dot Plots, triées par le nombre d'écoutes ou de vues.

Problèmes potentiels :

* Le nombre d’artistes est trop important (2079 valeurs uniques) pour le mettre sur un seul graphique. Possibilité d’afficher que 50 ou 100 artistes les plus populaires.

---

15. **Existe-t-il un ratio stable entre streams/views ? Si oui quelles sont les musiques les plus populaires en additionnant les 2 plateformes.**

Afficher un boxplot permettant de déduire s’il existe un ratio stable.

Variables utilisées : `Stream, Views.`

Types de visualisations à envisager :

* Boxplot

Problèmes potentiels :

* S’il n’y a pas de corrélation on ne peut pas faire la suite de la question
