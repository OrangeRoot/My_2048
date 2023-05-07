# 2048 Clone in Flutter with BLoC State Management

This is a clone of the popular game 2048 built in Flutter using the BLoC state management pattern. The app allows the user to play the game by swiping tiles to merge them and reach the target score of 2048.

## Installation

To run the app locally, you will need to have Flutter installed on your machine. You can download the latest version of Flutter and follow the installation instructions [here](https://flutter.dev/docs/get-started/install).

Once you have Flutter installed, you can clone this repository and run the app on an emulator or a physical device using the following command in your terminal:

`flutter run`

## Usage

To play the game, simply swipe the tiles in the direction you want them to merge. The app will keep track of your score and update the board accordingly. If you reach the target score of 2048, you win the game!

## State Management with BLoC

This app uses the BLoC state management pattern to manage the state of the game board and user score. The business logic for the game is encapsulated in a separate class, which communicates with the UI using a stream of events and states. This allows for easy testing and separation of concerns between the UI and the business logic.

## Demo

Here's a GIF of the app in action:

![App Demo](demo.gif)

## License

This project is licensed under the [MIT License](LICENSE).
