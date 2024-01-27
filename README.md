# README

## Description
This is a simple project to demosntrate the use of ruby on rails to create a simple bank and providers dashboard.

## Pre-requisites
- Docker and docker-compose installed

## How to run
- Clone the repository
- Run `docker-compose build` to build the images
- Run `docker-compose up` to start the containers
- Run `docker-compose run web rake db:create` to create the database
- Run `docker-compose run web rake db:migrate` to run the migrations
- Run `docker-compose run web rake db:seed` to run the seeds
- Access `http://localhost:3000` to see the application running

## How to run the tests
- Run `docker-compose run web rspec` to run the tests

## Considerations
- The environment variables are visible in the repository for simplicity, but in a real project they should be stored in a secure place.
- This is a backend project, so the frontend is very simple and was not the focus of the project.