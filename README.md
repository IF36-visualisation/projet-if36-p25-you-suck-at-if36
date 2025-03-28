# Analyse des Observations d'OVNIs

## Introduction

### Données
Ce projet utilise un jeu de données issu de Kaggle, contenant plus de 80 000 observations d’OVNIs signalées à travers le monde. Nous l'avons choisi car il est riche en informations et propose de nombreuses variables, ce qui permet une analyse approfondie.

Voici une description des principales colonnes :

- **`datetime`** (string) : Date et heure de l'observation (format : YYYY-MM-DD HH:MM:SS).
- **`city`** (string) : Ville où l'observation a eu lieu.
- **`state`** (string) : État ou région (principalement pour les États-Unis).
- **`country`** (string) : Code pays (`us`, `gb`, etc.).
- **`shape`** (string) : Forme de l’OVNI observé (cercle, lumière, cylindre, etc.).
- **`duration (seconds)`** (numeric) : Durée de l’observation en secondes.
- **`duration (hours/min)`** (string) : Durée exprimée en heures ou minutes.
- **`comments`** (string) : Témoignages descriptifs des témoins.
- **`date posted`** (string) : Date de publication du témoignage.
- **`latitude`** (numeric) / **`longitude`** (numeric) : Coordonnées géographiques du lieu d'observation.


### Plan d’analyse
Nous souhaitons explorer ces données pour répondre aux questions suivantes :

- Y a-t-il des tendances temporelles dans les observations d’OVNIs ?
- Si oui qu'est-ce qui pourrait l'expliquer ? 
- Quels sont les pays ou les régions où les observations sont les plus fréquentes ?
- Y a-t-il des formes d’OVNIs plus courantes que d’autres ?
- Existe-t-il une corrélation entre la durée d’observation et d'autres varaibles ?

L’analyse des données nécessitera un nettoyage préalable, notamment pour traiter les valeurs manquantes et homogénéiser ou transformer les formats de certaines colonnes. Nous effectuerons des visualisations pour mettre en évidence les tendances principales et explorerons des statistiques descriptives pour mieux comprendre les données.

