# product_catalog_checkout

## Author

Name: Iliyan Dimitrov
Date: 11/08/2024

## Getting Started

Used the sceleton application as a starting point.

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/to/state-management-sample).

## Notes

First of followed the official documentation setup. Created a new project using the skeleton application as a starting point.

Following the requirements, I started by consuming the provided JSON with the products list.
To accomplish this, I installed the Flutter http package. Then, I created a "ProductService" class to encapsulate the logic.
Product and Price classes were created to translate the response body JSON object.
I then:

Created a ProductService to handle fetching product data from the API.

Implemented a RecentlyViewedProductsStore (change notifier) to update the state when a product card is tapped and the product is added to the recently viewed list.

Developed a CartStore (change notifier) to update the state across the app when a product is added to or removed from the cart.

An onTap event was added to each product card. Once tapped, we are navigated to the product details view and the product is added to the recently viewed products carousel widget.
Created a recently viewed products change notifier (installed 'provider' package for this purpose) to update the state when a product card is tapped and the product is being added to the recents list.
To add products to cart, I created a cart screen view and another change notifier to update the state across the app when a product is added to the cart.
I then segregated the code, moving some code out of the views to standalone components for improved readability.
Finally, I added unit test coverage for the services and stores.
Packages installed:
flutter pub add http
flutter pub add provider
flutter pub add mocktail



