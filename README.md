# Introduction Application Météo - MyWeatherApp
Application météo avec plusieurs écrans et plusieurs fonctionnalités. Météo du jour, de la semaine, gestion des villes favorites, cartes avec annotations etc..
L'objectif de ce projet est de découvrir et de maitriser différentes technos et libs iOS via un sample d'application.

## Organisation
Le projet de base est une application météo avec une architecture MVC classique. Le projet utilise l'API "Open Weather Map" gratuite. Il est organisé sous forme de branches avec des nouvelles features (migration de librairie, ajout de fonctionnalités..).

## Présentation technique
- Création d'un projet avec les différentes lib. Fonctionnellement, l'app permettra de récupérer des infos de météo.
- Ajout d'une première itération de l'app dans une architecture MVC. Un seul écran avec la météo du jour.
- Migration de l'architecture MVC vers un pattern MVVM. Introduction au data binding.
- Ajout d'un launchscreen.
- Ajout d'un nouvel écran permettant d'avoir le détail de la météo.
- Migration des appels réseaux de URLSession vers Moya.
- Utilisation de Realm pour enregistrer des Favoris depuis l'onglet détails.
- Ajout d'une UITabBar pour la gestion d'onglet.
- Création d'un onglet "Mes Favoris". Présentation d'une liste des lieux favoris avec un résumé de la météo actuelle. Navigation vers la page de détails pour chaque lieux favoris.
- Ajout d'un onglet "Carte" pour sélectionner un endroit dans le mode. Utilisation de MapKit.
- Création d'une MapAnnotation avec la météo courante pour la ville sélectionné.
- Affichage d'une vue en haut de la map pour chaque ville sélectionnée.
- Refacto de la navigation: Utilisation du pattern Coordinator.
- Utilisation de RXSwift pour gérer les appels.
- Implémentation de tests unitaires.
- Migration Cocoapods -> Swift Package Manager.
- Application de Swiftlint dans l'ensemble de l'app.

## Liens
- [Doc RXSwift GitHub](https://github.com/ReactiveX/RxSwift)
- [Doc RXSwift FR](https://blog.eleven-labs.com/fr/RxSwiftpourlesnuls:Partie1/)
- [Exemple RXSwift](https://medium.com/ios-os-x-development/learn-and-master-%EF%B8%8F-the-basics-of-rxswift-in-10-minutes-818ea6e0a05b)

- [Doc Realm Github](https://docs.mongodb.com/realm-legacy/docs/swift/latest/)
- [Exemple Realm x iOS](https://programmingwithswift.com/getting-started-with-realm-database-for-ios-in-swift/)

- [Doc TU XCTest](https://blog.eleven-labs.com/fr/test-unitaire-swift-xcode/)

- [Doc Moya Github](https://github.com/Moya/Moya)
- [Exemple Moya](https://www.raywenderlich.com/5121-moya-tutorial-for-ios-getting-started)
- [RX extension pour Moya](https://github.com/sunshinejr/Moya-ModelMapper/blob/master/README.md)


- [Doc théorique MVVM](https://www.guru99.com/mvc-vs-mvvm.html) 
- [MVVM x iOS](https://medium.com/flawless-app-stories/mvvm-in-ios-swift-aa1448a66fb4) 
- [MVVM x Swift](https://medium.com/codewave/mvvm-design-pattern-c5d9f4a10758) 
- [Migration MVC -> MVVM](https://www.raywenderlich.com/6733535-ios-mvvm-tutorial-refactoring-from-mvc) 

- [Coordinator: Doc & exemple d'utilisation](https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps) 
