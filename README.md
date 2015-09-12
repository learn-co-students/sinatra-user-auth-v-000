#Objectives

1. Build a Sinatra application with a Users model so that users can sign up for and sign in to your app. 
2. Learn how to use sessions to authorize, i.e. log in and log out users of a we application. 

## User Authorization: Using Sessions 

### Loggin In

- what does it mean for a user to "log in"? Simply store some piece of info about them (i.e. their id number) in the sessions hash. What is the point in time in which we log someone in? How to we "authorize" them? Match their email and password to email and password from database. Note on password encryption, coming soon.

- remember, session is a hash that contains some info about a user's interaction with our app at a give point in time. 

- show line in app controller that gives us the sessions hash that is available anywhere, in any controller at any time. 

### Logging Out

- What does it mean to log out? We are terminating the session, so we clear the session--delete all the content including it's key of :id which pointed to the current user's id

### User Registration

Before a user can sign in, they need to sign up! What does it mean to "sign up"? User submits their info via a form, we use that info to create and save a new user, then we redirect them somewhere else, like their home page. 

## Project Structure

Intro idea of different controllers for different models/features. Registrations controller vs. sessions controller vs. users controller. Views subdirectories to match. 

## Instructions

first part, making a user model and migrations and est. root path and page content is TDD. 

second part: 

Registration

1. Registration: create controller, define route, keep empty. add link to home page. create view page, create post route, put binding in route, submit form. look at params. use params to create and save new user. 
2. LOG IN USER: put their id in the session object. redirect to their home page, get the user back out of the session object. 
3. Make user home page.

Sign In

1. make sessions controller, define route, keep empty. add linke to home page. create view page, create post route, put binding in route, submit form. Look at params, use params to find a user form the DB. mention password encryption and more sophisticated authentication coming soon. establish session id as user id--THIS IS WHAT IT MEANS TO LOG IN. redirect to user's home page. 

Log Out

1. what does it mean to log out? destroy session. make link on user's home page view. make corresponding route in sessions controller. explain about session.clear. redirect to home page

** note on when do redirect and when to render template using `erb` 





# Outline

1. what is user auth/what does it have to do with the session?

1. part I will be test-driven building out the app with a user's model and corresponding database table, routes for sign up/in/out and a home page
2. part II will be a code along, walk them through signing a user up and in with email and password and signing out. 

# Sessions and User Authorization 

## Objectives

1. Build a Sinatra app with a Users model so that users can sign up for and sign in to your web app.

2. Learn how to use sessions to authorize, i.e. log in and log out, users of a web application. 

## What do sessions have to do with user authentication?

## Instructions

### Part I: Building out the App

This part of the lab is test-driven. Use the test output to build an app that has a Users model and routes for signing up, signing in, signing out as well as a home page. 

### Part II: User Auth

This part of the lab is a code along––follow the steps below to build the ability for user's to sign up with an email and password, log in with an email and password and log out. 