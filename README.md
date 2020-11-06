# GNBTrades


## Building And Running The Project (Requirements)
* Swift 5.0+
* Xcode 11.5+
* iOS 13.0+

### General Application Frameworks
- RxSwift: [Reactive framework](https://github.com/ReactiveX/RxSwift)
- RxCocoa: [Reactive framework](https://github.com/ReactiveX/RxSwift)

# In your terminal, go to the project root directory, make sure you have cocoapods setup, then run:
pod install

## Architecture
This application uses the Model-View-ViewModel (refered to as MVVM) architecture.

## Structure

### Scenes
This is for group of app scenes: Products list and product detail (with all the transactions and the total amount for all the transactions).

### Extensions
This includes all the needed extensions for classes, structures, enums, etc.

### Navigation
Base class to handle the navigation flow of the app.

### Network
Base networking class to make api requests.

### Application
Includes the AppDelegate and SceneDelegate needed to launch the app.



