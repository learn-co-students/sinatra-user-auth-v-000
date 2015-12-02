# User Authentication in Sinatra

# Objectives

1. Build a Sinatra application with a Users model so that users can sign up for and sign in to your app. 
2. Learn how to use sessions to authorize, i.e. log in and log out users of a web application. 

## User Authorization: Using Sessions 

### Logging In

What does it mean for a user to "log in"? The action of logging is the simple action of storing a user's ID in the `session` hash. Here's a basic user log in flow: 

1. User visits the log in page and fills out a form with their email and password. They hit "submit" and `POST` that data to a controller route. 
2. That controller route accesses the user's email and password from the params. That info is used to find the appropriate user from the database with a line such as `User.find_by(email: params[:email], password: params[:password])`. **Then, that user's ID is stored at the value of `session[:id]`.**
3. As a result, we can introspect on the `session` hash in *any other controller route* and grab current user by matching up a user ID with the `session[:id]`. That means that, for the duration of session (i.e. the time between someone logs in and logs out of your app), our app will know who the "current user" is on every page. 

#### A Note On Password Encryption 

For the time being, we will simply store a user's password in the database in it's raw form. However, that is not safe! In an upcoming lesson, we'll learn about password encryption: the act of scrambling a user's password into a super-secret code and storing a de-crypter that will be able to match up a user's password, when they log in, to the encrypted password we'll store in our database. 

### Logging Out

* What does it mean to log out? Conceptually, it means we are terminating the "session", the time in which a given user is interacting with our app. The action of "logging out" is really just the action of clearing all the data, including the user's ID, from the session hash. Luckily for us, there is already a Ruby method to empty a hash: `#clear`. 

### User Registration

Before a user can sign in, they need to sign up! What does it mean to "sign up"? A new user submits their information (for example, name, email and password) via a form. When that form gets submitted, a POST request is sent to a route defined in your controller. That route will have code that does the following: 

1. Get the new user's name, email and password from the params. 
2. Use that info to create and save a new user. For example: `User.create(name: params[:name], email: params[:email], password: params[:password])`.
3. Lastly, once a user has "signed up", we should sign them in. It would be annoying if you had to create a new account on a site and *then* sign in right afterwards. So, in the same controller route in which we create a new user, we set the `session[:id]` equal to the new user's id, effectively logging them in. 
4. Lastly, we redirect the user somewhere else, like their personal home page. 

## Project Structure

### Multiple Controllers for Multiple Features

In the MVC (model/view/controller) framework, we know that the controller is responsible for defining behaviors of each route. For example, if user visits `www.example.com/hello-world` and sees the message `"Hello World!"`, we know that the corresponding controller has some code in it that looks like this: 

```ruby
# controller file

get '/hello-word' do 
  "Hello World!"
end
```

So far, we've become comfortable with applications that have one controller file, often named something like `app.rb`. That file has been responsible for handling all of the routes of a given application. In this exercise, we'll be writing a number of different controllers, each of which handle routes pertaining to different features. For example, when a user "signs up" for you app, we consider that to be a new registration. When a user signs in or out of your app, we consider them to be creating and terminating a session. These are different functions and therefore the routes that that rely on will be coded in different controller files. 

Before we get started writing any code, let's go through our project structure. It's important to understand the set-up of our different files and the reasoning behind it. 

### Our Project

Our file structure looks like this: 

```bash
-app
  |- controllers
      |- application_controller.rb
      |- registrations_controller.rb
      |- sessions_controller.rb
      |- users_controller.rb
  |- models
      |- user.rb
  |- views
      |- home.erb
      |- registrations
          |- signup.erb
      |- sessions
          |- login.erb
      |- users
          |- home.erb
-config
-db
-spec
...       
```

This is a slightly new set sup, so let's walk through it together. 

### The `app` Folder 

The `app` folder contains the models, views and controllers that make up the core of our Sinatra application. Get used to seeing this set up. It is conventional to group these files under an `app` folder. 

#### The `controllers` Folder

The `controllers` sub-directory holds our four controllers. Four controllers?! That's a lot! However, it's better to have separate controller files for separate functions than it is too place *all* of the routes for *all* of our app's features and functionalities in one giant file. Instead, we want to separate out these features. 

* **`appliction_controller.rb`** is responsible for the the route to our root or home page. That is the route this controller handles. However, this controller *does* configure a few things for us, including setting up our ability to access the `session` hash. Consequently, all of our other controllers will *inherit* from the `ApplicationController` class, in order to have access to that configuration. 
* **`registrations_controller.rb`** is responsible for the feature of user sign up. When a new user signs up for your app, it is considered to be a new **registration**. That's why this controller is called the `RegistrationsController`. This controller has two routes: 
  * The `get '/registrations/signup'` route. This route has one responsibility: render the sign up form view. This view can be found in `app/views/registrations/signup.erb`. Notice that we don't only have separate controllers, we have separate view sub-folders to correspond to those controllers. 
  * The `post '/registrations'` route. This route is responsible for receiving the `POST` request that happens when a user hits "submit" on that signup form. It will have the code that gets the new user's info from the params, creates a new user, signs them in and then redirects them somewhere else. 
* **`sessions_controller.rb`** is responsible for user log in and log out. It has three routes:
  * The `get '/sessions/login'` route. This route is responsible for rendering the login form. 
  * The `post '/sessons'` route. This route is responsible for receiving the `POST` request that gets sent when a user hits "submit" on that login form. This route has the code that grabs the user's info from the params, finds that user from the database and signs that user in. 
  * The `get '/sessions/logout'` route. This route is responsible for logging the user out by clearing the `session` hash. 

When a user is signed in, they should be redirected somewhere special. In our app, we'll redirect our user to their personal homepage. In any given app, a user might have a homepage, a page to edit their profile or personal information, a page to message their friends from, you name it. All of these functionalities pertain to the *user* specifically. They don't belong to the act of registering, or logging in, for example. Consequently, we want a separate controller for such routes and functions. In this app, the `UsersController` has one route, the route to the user's homepage. But, we want to get into the habit of giving different functions their own place to live, so we have our: 

* **`users_controller.rb`** which has one route: 
  * The `get '/users/home'` route. This route is responsible for rendering the user's home page view. 

#### The `models` Folder

The models folder is pretty straightforward. It contains one file because we only have one model in this app: the `User` model. 

The code in `app/models/user.rb` will be pretty basic. We'll validate some of the attributes of our user by writing code that makes sure no one can sign up without inputing their name, email and password. More on this later. 

#### The `views` Folder

This folder has a few sub-folders we want to take a look at. Since we have our different controllers responsible for different functions/features, we want our view folder structure to match up. So, we have:

* The **`views/registrations`** sub-directory. This directory has just one file, the template for the new user signup form. That template will be rendered by the `get '/registrations/signup'` route in our Registrations Controller. This form will `POST` to the `post '/registrations'` route of that same controller. 
* The **`views/sessions`** sub-directory. This directory also has just one file, the template for the login form. This template is rendered by the `get '/sessions/login'` route in the Sessions Controller. The form on this page `POST`s to the `post '/sessions'` route in that same controller. 
* The **`views/users`** sub-directory. This directory has just one file, the template for the user's homepage. This page is rendered by the `get '/users/home'` route in the Users Controller. 
* We also have a `home.erb` file in the top level of the views directory. This is the page rendered by the root route, `get '/'`, defined in the Application Controller. 

#### Separation of Concerns

The idea that different code to carry out different tasks should get organized into different locations should be a familiar one. It is right in line with the **separation of concerns** design principle of object orientation. This principle states that a program or application's code should be organized into discrete units, such that each unit carries out a separate responsibility or behavior. 

So, to honor this principle of organization and design, we give different functions their own space. For example, a user's registration is it's own function, so we have a `RegistrationsController` to handle it. Similarly, the template that renders the new registration, or signup, form gets it's own subdirectory, in `views/registrations`. It may seem like a lot of work to contain some minimal code, but think about larger, more complex applications. 

Let's say you're running a popular online marketplace. You need users to be able to sign up, log in and out, browse items, add items to a shopping cart, purchase items, manager their account information and much more. If we placed the code to handle *all* of these functions in the same file, we'd have a super long, super messy file that would be really frustrating to debug and really frustrating for other developers to work collaboratively on. 

## Instructions

Much of the structure of this application has been written out for you. We do have some work to do though. We need to write our models and migrations and we need to build the content of the routes and views that have been defined for us. In Part I of this lab, we'll handle the models and migrations. In Part II we'll deal with the controllers and views. 

### Part I: Models and Migrations

Our `User` model has a few attributes. A user has a name, email and password. 

#### Step 1: Migration

Write a migration that creates a `Users` table with name, email and password. Run `rake db:migrate` and then run your test suite. 

You'll see that you're passing a number of tests, including tests like these:

```ruby
User
  is invalid without a name
  is invalid without a email
  is invalid without an password
```

Let's think about the concept of validations...

#### Advanced Step 2: Model Validations

What would happen if we allowed a user to sign up for our app without giving their name or their email or password? Well, without an email and password, it would be hard to authenticate them when they try to log in later. Without a name, we could never say `"Hi, #{you}!"` That's not very nice, not to mention inconvenient. 

Validations are a way for us to make sure that user *can't* sign up without providing all that info. How does it work? Open up `models/user.rb` and check out the following code: 

```ruby
class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password
end
``` 

This line of code `validates_presence_of :name, :email, :password` is really powerful. It means that if you try to create a save a user that is missing any of those attributes, it won't work! 

So now, if someone tries to sign up without a name, an email or a password, the code that tries to create a new user without key, validated, information, will break our app. Oh no! Okay, that's not good. But later on we'll learn how to *stop* it from breaking and instead give the user a helpful error message. For now, we're satisfied with our helpful validation code above. 

## Part II: Controllers and Views

#### Step 1: The Root Path and the Homepage

First things first, let's set up our root path and our home page. 

* Open up `app/controllers/application_controller.rb` and check out the `get '/'` route. This route should render the `app/views/home.erb` page with the following code: 

```ruby
erb :home
```
* Run your test suite again with `learn` or `rspec` in the command line and you should be passing these two tests: 

```bash
ApplicationController
  home page: GET /
    responds with a 200 status code
    renders the home page view, 'home.erb'
```
* Start up your app by running `shotgun` in the terminal. Visit the home page at `localhost:9393` and you should see message that welcomes you to Hogwarts and shows you a link to sign up and a link to log in.

* Let's look at the code behind this view. Open up that `app/views/home.rb` view and you should see the following

```ruby
<h1>Welcome to Hogwarts</h1>
  <h4>Please sign up or log in to access your @hogwarts.edu email account</h4>
  <a href="/registrations/signup">Sign Up</a>
  <a href="/sessions/login">Log In</a>
```

Notice that we have two links, the "Sign Up" link and the "Log In" link. Let's take a closer look: 

* The "href" or destination of the first link is `/registrations/signup`. This means that this link points to the route `get 'registrations/signup'`, which can be found in the Registrations Controller, in `app/registrations_controller.rb`. 
* The "href" or destination of the second link is `/sessions/login`. This means that this link points to the route `get 'sessions/loging'`, which can be found in the Sessions Controller, in `app/sessions_controller.rb`. 

Let's move on to step 2, the building our user sign up flow. 

#### Step 2: User Sign Up with the Registrations Controller and Views

* Open up `app/registrations_controller.rb` and you should see two routes. Let's take a look at the first route,  `get '/registrations/signup'`, which is responsible for rendering the signup template. 

```ruby
get '/registrations/signup' do
    erb :'/registrations/signup'
end
```

* Navigate to `localhost:9383/registrations/signup`. You should see a page that says `"sign up below:"`. Let's make a sign up form! 

* Open up `app/views/registrations/signup.erb`. Our signup form needs a field for name, email and password. It needs to `POST` data to the `'/registrations'` path, so your form action should be `/registrations'` and your form method should be `POST`. 

* Once you've written your form, go ahead and add the line: `puts params` inside the `post '/registrations` route in `app/controllers/registrations_controller.rb`. Then, fill out the form in your browser and hit the `"Sign Up"` button. 

* Hop on over to your terminal and you should see the params outputted there. It should look something like this (but with whatever info you entered into the form):

```ruby
{"name"=>"Beini Huang", "email"=>"beini@bee.com", "password"=>"password"}
```

* Okay, so we're inside our `post '/registrations'` route, we have our params that contains the user's name, email and password. Inside the `post 'registrations'` route, place the following code:

```ruby
@user = User.new(name: params["name"], email: params["email"], password: params["password"])
@user.save
```

* We did it! We registered a new user! Now we just need to sign them in. On the following line, set the `session[:id]` equal to our new user's ID:

```ruby
session[:id] = @user.id
```

* Take a look at the last line of the method: 

```ruby
redirect '/users/home'
```

Now that we've signed up and logged in our user, we want to take him or her to their home page. 

Go ahead and run the test suite again and you should see that *almost all* of the user sign up tests are passing. 

#### Step 3: Fetching the Current User

Open up the view file: `app/views/users/home.erb` and look at the following line of code:

```
"Welcome, <%=@user.name%>!"
```

Looks like this view is trying to operate on an `@user` variable. We know that the only variables that a view has access to are instance variables that are set in the controller route that renders that view page. For this page, that route can be found the Users Controller. 

Remember that, after a user signs up and is signed in via the code we wrote in the previous step, we redirect to this path: `'/users/home'`. Let's go check out that route right now. 

* Open up `app/controllers/users_controller.rb`. Here we have the route: `get '/users/home'`. This route is responsible for finding the current user, based on the ID in the `session` hash and setting that user equal to a variable, `@user` that we can render in our view page. Let's do it: 

```ruby
get '/users/home' do
    @user = User.find(session[:id])
    erb :'/users/home'
  end
```

* Run the tests again and we should be passing *all* of our user sign up tests.

#### Step 4: Logging In
* Go back to your home page and look at the second of the two links:

```ruby
<a href="/sessions/login">Log In</a>
```

* This is a link to the `get '/sessions/login'` route in the Sessions Controller. Open up `app/controllers/sessions_controller.rb` and checkout the two routes defined there. We have our `get '/sessions/login'` route and our `post '/sessions'` route. 
* The `get /sessions/login'` route renders the Log In view page. Restart your app by executing `Command + C` and then typing `shotgun` in your terminal. Navigate back to the root page, `localhost:9393` and click on the `"Log In"` link. It should take you to a page that says `"log in below:"` Let's make our log in form!
* Open up `app/views/sessions/login.erb`. We need a form that sends a `POST` request to `/sessions` and has an input field for email and password. Make your form with a submit button that says "Log In". Then, place this line: `puts params`, in the `post '/sessions'` route in the Sessions Controller. Fill our the form and hit "Log In". 
* Hop on over to your terminal and you should see the outputted params, looking something like this (but with whatever information you filled out into the form):

```ruby
{"email"=>"beini@bee.com", "password"=>"password"}
```
* Inside the `post '/sessions'` route, let's write the lines of code that will find the correct user from the database and log them in by setting the `session[:id]` equal to that user's ID. 

```ruby
@user = User.find_by(email: params["email"], password: params["password"])
session[:id] = @user.id
```
* Notice that the last line of the route redirect the user to their home page. We already coded that route in the Users Controller to retrieve the current user based on the ID stored in `session[:id]`.
* Run the test suite again and you should be passing the user log in tests. 

#### Step 5: Logging Out

* Open up `app/views/users/home.erb` and check out the following link: 

```
<a href="/sessions/logout">Log Out</a>
``` 

* We have a link that takes us to the `get '/sessions/logout'` route, which is responsible for logging us out by clearing the `session` hash. 
* Open up `app/controllers/sessions_controller.rb` and code the following line in your `get '/sessions/logout'` route: 

```ruby
session.clear
```
* Run the test suite again and you should passing everything. 

## Conclusion

Phew! This was a big lab, and we were introduced to some new concepts. Before moving on, play around with your app a bit. Practice signing up, logging out, logging in and get used to the general flow. 

There's a lot to think about here, but there are a few take-aways: 

* Separate your concerns! If you have a few routes that pertain to a specific action, give them their own controller. 
* Same goes for the views, if there are some views that pertain to those specific controller routes, give them their own sub-folder. 
* Signing up for an app is nothing more than submitting a form, grabbing data from params and using it to create a new user. 
* Logging in is nothing more that finding the right user and setting their user id equal to an `:id` key in the `session` hash. 
* Logging out is nothing more than clearing all the data from the `session` hash. 

Another important take-away from this lab is the flow of information between the different routes and views of an application. If you're still confused by the flow of signing up, logging out/logging in, try drawing it out. Can you map out where you web requests go from the point at which you click the "Sign Up" link all the way through until you sign up, log out and then even log back in? Give it a shot. 

<a href='https://learn.co/lessons/sinatra-user-auth' data-visibility='hidden'>View this lesson on Learn.co</a>
