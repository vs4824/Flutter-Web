# Flutter Web


## Requirements

To create a Flutter app with web support, you need the following software:

1. Flutter SDK. See the Flutter SDK installation instructions.

2. Chrome; debugging a web app requires the Chrome browser.

3. Optional: An IDE that supports Flutter. You can install Visual Studio Code, Android Studio, IntelliJ IDEA. Also install the Flutter and Dart plugins to enable language support and tools for refactoring, running, debugging, and reloading your web app within an editor. See setting up an editor for more details.

## Create a new project with web support

You can use the following steps to create a new project with web support.

### Set up

Run the following commands to use the latest version of the Flutter SDK:

   ```
   flutter channel stable
   flutter upgrade
   ```

If Chrome is installed, the flutter devices command outputs a Chrome device that opens the Chrome browser with your app running, and a Web Server that provides the URL serving the app.

   ```
   flutter devices
   1 connected device:
   Chrome (web) • chrome • web-javascript • Google Chrome 88.0.4324.150
   ```

In your IDE, you should see Chrome (web) in the device pulldown.

## Create and run

Creating a new project with web support is no different than creating a new Flutter project for other platforms.

### IDE

Create a new app in your IDE and it automatically creates iOS, Android, desktop, and web versions of your app. From the device pulldown, select Chrome (web) and run your app to see it launch in Chrome.

### Command line

To create a new app that includes web support (in addition to mobile support), run the following commands, substituting my_app with the name of your project:

   ```
   flutter create my_app
   cd my_app
   ```

To serve your app from localhost in Chrome, enter the following from the top of the package:

   ```
   flutter run -d chrome
   ```

The flutter run command launches the application using the development compiler in a Chrome browser.

## Build

Run the following command to generate a release build:

   ```
   flutter build web
   ```

A release build uses dart2js (instead of the development compiler) to produce a single JavaScript file main.dart.js. You can create a release build using release mode (flutter run --release) or by using flutter build web. This populates a build/web directory with built files, including an assets directory, which need to be served together.

You can also include --web-renderer html or --web-renderer canvaskit to select between the HTML or CanvasKit renderers, respectively. For more information, see Web renderers.

For more information, see Build and release a web app.

## Add web support to an existing app

To add web support to an existing project created using a previous version of Flutter, run the following command from your project’s top-level directory:

   ```
   flutter create --platforms web .
   ```