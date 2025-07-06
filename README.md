### flutter_nasa_challenge App

#### Description

This is the repository of the app named "flutter_nasa_challenge", a test app from a Flutter Developer interview.
The app should return a list of image from NASA Api that the user can search and will be saved on the device so that the user my access the image online and offline.

### Steps

After download the git repository, we have to run these commands to be able to use the repository:
- flutter pub get
- flutter pub run build_runner build

To be able to fetch the data, add the code bellow as run args to include your apikey as environment variable:
- --dart-define=APIKEY=YOUR-API-KEY

#### Task
Build an app for one platform (Android or iOS) to show the pictures from NASA's "Astronomy Picture of the Day" website in a fashion manner.

One of the most popular websites at NASA is the Astronomy Picture of the Day. In fact, this website is one of the most popular websites across all federal agencies.

#### Requirements
The app must contemplate the following requirements:

- Have two screens: a list of the images and a detail screen -------- Completed
- The images list must display the title, date and provide a search field in the top (find by date) -------- Completed
- The detail screen must have the image and the texts: date, title and explanation -------- Completed
- Must work offline (will be tested with airplane mode) -------- Completed
- Must support multiple resolutions and sizes -------- Completed
- Regarding the screen with the list, it would be nice to have pull-to-refresh and pagination features -------- Completed

#### Architecture
Knowing that this is a simple application, I decided to make the architecture as simple, clean and readable as possible:

	core
	 datasources
	 services
	 usecases
	models
    module
	views
	 datails
	 gallery
        cubit
	    widgets

#### Libraries
These are the libraries that were used to develop the app:
- bloc
- bloc_test
- cached_network_image
- dartz
- dio
- equatable
- flutter_modular
- flutter_bloc
- hive
- hive_flutter
- pretty_dio_logger
- flutter_test
- integration_test
- build_runner
- hive_generator
- mocktail

#### Visual

Below there is some screenshots from the app in an Emulator Device:

# Gallery Screen without any filter
![](https://i.ibb.co/m5LYxRj/Screenshot-1673201104.png)

# Gallery Screen with the search by title
![](https://i.ibb.co/r2tLLvX/Screenshot-1673201453.png)

# Gallery Screen with the search by date
![](https://i.ibb.co/SQb99nM/Screenshot-1673201516.png)

# Details Screen with all the information from the image
![](https://i.ibb.co/tsG1rk0/Screenshot-1673201479.png)

#### Tests
There where implemented the following tests:

	unit-tests
	widget-tests
	integration-tests
