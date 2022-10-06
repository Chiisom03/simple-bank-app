# PETER NWIBO
# Simple Bank App



A Flutter app that uses the "[Veegil's bank](https://www.https://veegil.com/)" API to fetch user's data and their finance activities.

### Content

* [Running the App](#running-the-app)
* [Previews](#previews)
* [App Architecture & Folder Structure](#app-architecture-and-folder-structure)


## Running the App
You can run the app by just typing ```flutter run``` on your console or adding the ```--release ``` argument to build a lighter version of the app

## Previews

(A simple view of the bank app's UI,

<div style="display: flex">
<img style="display: inline-block" src="https://gitlab.com/chiisom03/images/-/raw/main/simple2.gif" />
</div>

## App Architecture and Folder Structure

The code of the app applies clean architecture approach to separate the UI, services and data models folder structure.

#### Folder Structure

```
lib
├── models
├── services
├── ui
│   ├── components
│   ├── pages
│   │   └── visuals
│   └── utils
├── locator.dart
└── main.dart 
```
    
* `main.dart` file has services initialization code, wraps the root `SimpleBankApp` with a `ProviderScope` and has the `MaterialApp`
* The `models` folder contains the data structure for incoming data given by the API
* `services` folder contains the functions fetches the API data necessary for apps ui
*The `ui` folder contains the app designs
    * `components` folder holds reusable designs that avoids repetition


Using Riverpod `Provider` and `GetIt` to access the Services implementation:

```dart
   final transationsStream =
        ref.watch(locator.get<TransactionsService>().transactionProvider);
```
access implementation from the endpoint using a `Future Function`:

```dart

   final transactionProvider = FutureProvider((ref) => getTransactions());
  static Future<TransactionsModel> getTransactions() async {
    Response response;
    try {
      response = await _dio.get('$baseUrl/transactions');
      if (response.statusCode == 200) TransactionsModel.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response != null) {
        throw  throw error.response?.statusMessage ?? 'Unexpected result';
      }
      throw 'Check your Internet Connection';
    }
    return TransactionsModel.fromJson(response.data);
  }

 
```
