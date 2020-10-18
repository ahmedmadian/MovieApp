# Movie App

This repository contains a demo for sample Search iOS App, An Application designed based on Use Cases with help of **VIPER** architecture and consumes data from [TMDB](https://www.themoviedb.org/) API.

## Getting Started

### Step 1: Install Xcode

Download Xcode from [Apple's developer website](https://developer.apple.com/xcode/) or Apple's App Store.

### Step 2: Clone Repository

Clone the repository by executing the following command from the command line.

```bash
git clone https://github.com/ahmedmadian/MovieApp.git
```
### Step 2: Build and Run

### Dependency Graph

According to VIPER Architecture, every Modules have 5 main parts, The main parts of each module are:

**View -** Displays what it is told to by the Presenter and relays user input back to the Presenter. <br /><br />
**Interactor -** Contains the business logic as specified by a use case. <br /><br />
**Presenter -** Contains view logic for preparing content for display (as received from the Interactor) and for reacting to user inputs (by requesting new data from the Interactor). <br /><br />
**Entity -** Contains basic model objects used by the Interactor. <br /><br />
**Routing -** Contains navigation logic for describing which screens are shown in which order. <br /><br />
