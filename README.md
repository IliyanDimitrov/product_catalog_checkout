# Product Catalog Checkout

## Author

**Name:** Iliyan Dimitrov  
**Date:** 11/08/2024

## Getting Started

This project uses the skeleton application as a starting point. It follows the [simple app state management tutorial](https://flutter.dev/to/state-management-sample) from the official Flutter documentation.

## Project Overview

This Flutter application implements a product catalog with checkout functionality. It demonstrates the use of state management, API consumption, and various Flutter widgets.

## Development Notes

1. **Initial Setup:**
   - Created a new project using the skeleton application as a starting point.
   - Followed the official Flutter documentation for setup.

2. **API Integration:**
   - Consumed the provided JSON with the products list.
   - Installed the Flutter `http` package for API requests.
   - Created a `ProductService` class to encapsulate the API logic.
   - Implemented `Product`, `Price` and `CartItem` classes to model the JSON response.

3. **State Management:**
   - Created a `RecentlyViewedProductsStore` (change notifier) to manage recently viewed products.
   - Developed a `CartStore` (change notifier) to manage the shopping cart state.

4. **UI Components:**
   - Implemented a product list view to display fetched products.
   - Created a product details view for individual product information.
   - Added a recently viewed products carousel widget.
   - Implemented onTap events for product cards, navigating to product details and updating recently viewed products.

5. **Code Organization:**
   - Segregated code into standalone components for improved readability.

6. **Testing:**
   - Added unit test coverage for services and stores.

## Packages Used

- `http`: For making API requests
- `provider`: For state management
- `mocktail`: For mocking in tests


