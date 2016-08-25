# meal-time
Meal ordering coordination system

# Installation
## Requirements
- mysql
- .env file (more below)
- firefox (for capybara testing)

## Environment variables
This application stores credentials (app_secret_base, facebook and github keys and secrets)
in environment variables, which must be specified for the app to work correctly on the backend
as well as the frontend. Gem **dotenv-rails** is used for loading these variables, which requires
them to be stored in `.env` file in the root path of the project.
For security reasons this file is not added to this repository and thus must be provided
manually. You can use `.env.example` file to build your own `.env` file.
