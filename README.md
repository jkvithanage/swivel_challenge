# README
# Swivel Coding Challenge

This is a solution for the Swivel coding challenge, implementing a Ruby on Rails API with OAuth authentication, Elasticsearch integration, and nested resource management.

## Prerequisites

Before you begin, ensure you have the following installed on your machine:
- Docker
- Docker Compose

## Setup

1. Clone the repository
2. Run ```docker compose up --build```

## Features
- OAuth 2.0 authentication using Doorkeeper
- Elasticsearch integration for efficient searching
- Nested resource management (Verticals -> Categories -> Courses)
- PostgreSQL database with seed data
- Object serialization with active_model_serializers
- Pagination with Kaminari
- Docker and Docker Compose setup for easy setup


## How to Access the API

The application implements OAuth resource owner credentials grant for authentication.

1. A user must be created first to access API endpoints.
2. The seed data creates a user with the following credentials:
    - Email: `user@example.com`
    - Password: `secret`

3. To obtain an access token, send a `POST` request to `http://localhost:3000/oauth/token`

4. Use the obtained token as a `Bearer` token to access any API endpoint.

### Example cURL Command to Obtain Access Token

```bash
curl --location 'http://localhost:3000/oauth/token' \
--header 'Content-Type: application/json' \
--data-raw '{
  "grant_type": "password",
  "email": "user@example.com",
  "password": "secret"
}'
```

## API Routes
- /api/v1/verticals: CRUD operations for Verticals
- /api/v1/categories: CRUD operations for Categories
- /api/v1/courses: CRUD operations for Courses
- /api/v1/users: User creation
- Each resource (Verticals, Categories, Courses) also has a /search endpoint for Elasticsearch-powered searching.

A Postman collection for API endpoints is available at:
https://elements.getpostman.com/redirect?entityId=15829895-39101ab2-0842-49ec-8503-fcd4fa6c4255&entityType=collection

## Testing
To run the test suite,
1. Open a shell inside the container
```bash
docker compose exec -it web bash
```
2. Run test suite setting RAILS_ENV=test explicitly
```bash
RAILS_ENV=test bundle exec rspec
```
