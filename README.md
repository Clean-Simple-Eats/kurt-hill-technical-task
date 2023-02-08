# Flutter App Development Task

## Objective

The objective of this task is to develop a flutter app that consists of two screens: "Library" and "Book".

## Getting Started

The developer should create a new branch from the `main` branch of the repository.

When commiting, the developer should follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification. Commits should be made as often as possible, and the commit messages should be descriptive.

When the development is complete, the developer should create a pull request to the `main` branch of the repository.

## Screens

- **Library**: The Library screen will be an overview of all the books. It will display the list of books in a user-friendly way, with the title, author, and the (random) image of each book.
- **Book**: The Book screen will be a detailed view of a book. The details of the book to be displayed is up to the developer.

## Data

The book data can be found in the `data.json` file. The developer should use this data to populate the Library and Book screens.

## Dependencies

The developer should use the following dependencies in the development process:

### Main

- (Navigation) `go_router`
- (State Management) `bloc`
- (Dependecy Injection) `get_it`

### Dev Dependencies (Optional, but encouraged)

- (Analysis) `very_good_analysis`
- (Testing) `bloc_test`
- (Testing) `test`
- (Mocking) `mocktail`

## Platforms

The target platforms for this app are **Android** and **Apple** _mobile_ platforms.

## Optional

1. The developer can write tests for models, blocs, repos, etc to demonstrate their testing skills.
2. Add a search bar to the Library screen to filter the books by title or author.

## Note

The focus of this task is to see the developer's approach to the implementation of the app. The UI/UX design is not a factor in the review.
