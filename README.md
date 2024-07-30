# README
## Swivel Coding Challenge
This is my solution for the Swivel coding challenge.

## Prerequisites
Before you begin, ensure you have the following installed on your machine:
- Docker
- Docker Compose

## Setup
1. Clone the repository:
```
git@github.com:jkvithanage/swivel_challenge.git
cd swivel_challenge
```
2. Build the Docker containers:
```
docker compose build:
```
3. Run the containers:
```
docker compose up
```
It will run rails db:prepare, setting up the db and running seeds.

## API Endpoints
1. Postman collection for API endpoints:
```
https://elements.getpostman.com/redirect?entityId=15829895-39101ab2-0842-49ec-8503-fcd4fa6c4255&entityType=collection
```

## How to access API:
- The application implements a OAuth resource owner credentials grant.
- To access API endpoints, a user must be created first.
- The seed creates a user with email: ```user@example.com``` and password: ```secret```
- You can use these credentials to send a ```POST``` request to ```http://localhost:3000/oauth/token```
to obtain a access token.
- Use it as the ```Bearer``` token to access any API endpoint.

### Example cURL command to obtain access token:
```
curl --location 'http://localhost:3000/oauth/token' \
--header 'Content-Type: application/json' \
--data-raw '{
  "grant_type": "password",
  "email": "user@example.com",
  "password": "secret"
}'
```