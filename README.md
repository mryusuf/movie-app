# Movie APP

Browse your favorite movies in the palm of your hand.

## Features
- Show List of Movie's poster and title
- Search based on the title of Movie
- Image preview of Movie's poster

## Installation

After cloning the project, 
1. Register on https://www.omdbapi.com/, add your API Key into SupportingFiles/Info.plist using key: API_KEY
```
<key>API_KEY</key>
<string>INSERT_API_KEY_HERE</string> 
```
2. open your terminal and run this line 
```
pod install
```

or if you're on Apple Silicon mac
```
arch -x86_64 pod install
```

2. Open the .xcworkspace file
3. Type Command + r to run the project, or Command + u for test

Current Test Coverage of UI Test + Unit Tests: 64.6%

### Built with
- **Swift 5** compiled on XCode 14
- **VIPER** View-Interactor-Presenter-Entity-Router
- **RxSwift** for reactive data binding
- **Alamofire**
- **Lightbox** for Image Preview
- **API from: https://www.omdbapi.com/ **
