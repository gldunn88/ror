# RSpec Integrated Rails Development Documentation
This documents the basic set of commands and project structure required by ruby on rails. It is a summation of several tutorials and sample projects. It should serve as an introduction to Ruby on Rails as a toolset and language, as well as integrated RSpec unit testing methodologies.

## References
+ [Getting Started with Rails](https://guides.rubyonrails.org/getting_started.html)
+ [Intro to RSpec in Rails](https://dev.to/isalevine/intro-to-rspec-in-rails-basic-syntax-and-strategy-for-testing-3hh6)

## Project Setup

### Preparing the Project for RSpec

+ Populate a new project without a test directory via cli:
    + rails new <app_name> -T
+ If the project was created with a test directory, delete the existing *test* directory in the project.

### Adding RSpec to a Rails Project

1. Update the project gemfile to include the entry:
    + gem 'rspec-rails'
1. Re-install the gem files to reflect the new configuration
    + $ my_app>bundle install
1. Run rspec setup commands
    + rails g rspec:install

## Running the Rails Server
Ruby on Rails relies on a server to hold information and send requests. This is achieved by a project local server defined in the project itself. 

The server may be started by executing the following command at the head of the project directory:
```console
my_app> ruby bin/rails server
=> Booting Puma
=> Rails 6.1.3 application starting in development
=> Run `bin/rails server --help` for more startup options
*** SIGUSR2 not implemented, signal based restart unavailable!
*** SIGUSR1 not implemented, signal based restart unavailable!
*** SIGHUP not implemented, signal based logs reopening unavailable!
Puma starting in single mode...
* Puma version: 5.2.1 (ruby 2.7.2-p137) ("Fettisdagsbulle")
*  Min threads: 5
*  Max threads: 5
*  Environment: development
*          PID: 35708
* Listening on http://[::1]:3000
* Listening on http://127.0.0.1:3000
Use Ctrl-C to stop
```

By default the link used to access the server should be http://localhost:3000. Accessing the localhost on a clean project should produce a 'Yay! You're on Rails!' message. This verifies that the server is running and the localhost is running properly. Any issue here should be resolved before moving on with development.

### Server Configuration 
A standard rails application uses Puma as the local server. This may be configured via the file *config/puma.rb*. 

## Ruby on Rails and MVC Overview

Ruby on Rails is an MVC framework. This results in a program that can be neatly divided in Models, View and Controllers. 

### Models

Models are defined in the local database, and inherently implement a great deal of database functionality. This includes validation rules, foreign key relationships, fields, etc. The process by which they are created and maintained is a mix of *Migration* and model file editing. 

### Views 
Views are directly linked to controllers. They serve to display the information that a controller generates. They are a mix of Ruby and HTML in implementation.

### Controllers
Controllers are Ruby classes in which each function represents an action. At the most basic level these reflect CRUD (Create, Read, Update, Destroy) actions. A simple standard controller which allows read/write access will have the following:
  + index: Links to a view which summarizes the model database records.
  + show: Links to a view which shows details of a specific Model database record.
  + new: Links to a view which populates new model instance in memory.
  + create: Saves the populated instance created by *new* into the database.
  + edit: Links to a view which modifies an existing model instance in memory.
  + update: Updates an existing model instance with the changes from *edit*.
  + destroy: Removes a specific instance of the Model from the database.
  

## Creating Controllers

Ruby on Rails does not require manual file creation via the IDE for controllers. Each controller should represent a specific Model. The name should be the plural form of the Model in question. A command to make a controller which applies CRUD to a listing of Author models would look as follows: 

```console
my_app>ruby bin/rails g controller Authors index --skip-routes
      create  app/controllers/authors_controller.rb
      invoke  erb
      create    app/views/authors
      create    app/views/authors/index.html.erb
      invoke  rspec
      create    spec/requests/authors_request_spec.rb
      create    spec/views/authors
      create    spec/views/authors/index.html.erb_spec.rb
      invoke  helper
      create    app/helpers/authors_helper.rb
      invoke    rspec
      create      spec/helpers/authors_helper_spec.rb
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/authors.scss
```

You should note that this has created a controller, index view, rspec directories, and a handful of other directories. Because there is no routing data and the --skip-routes parameter was given, we will need to make new views as they are implemented by making new <action_name>.html.erb files.

## Creating Models

Models in Ruby on rails are created by a several step Migration process. This process consists of creating new *Migration* files via the CLI, which contain what is effectively database create/alter table scripts. These scripts are database agnostic, allowing the flexibility to be independent of the underlying database layer. The process will be outlined here. 

### Generate Migration for new Model

Rails can create a migration file via a cli command. Once executed, this command will created a new file in the db/migrate directory with a timestamp. To support the author application, a sample model could look something like the following: 

```console
my_app>ruby bin/rails g model Author name:string bio:text
      invoke  active_record
      create    db/migrate/20210227230437_create_authors.rb
      create    app/models/author.rb
      invoke    rspec
      create      spec/models/author_spec.rb
```

A sample migration file created is shown below. Note the timestamps is included although we did not specify it. This will automated creation of updated and created timestamps.

```rb
# db/migrate/20210227230437_create_authors.rb
class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.text :bio

      t.timestamps
    end
  end
end
```

The Authors table is not yet in the database. It is best to think of an unprocessed migrate file as a potential change that is queued, but not yet confirmed. 

### Migrating the model into the database

The db:migrate command is the step in which all new migration files are processed and committed to the database. This finalizes the changes and makes the models usable by the controller and views. A sample execution of the migrate command is shown below.

```console
my_app>ruby bin/rails db:migrate
== 20210227230437 CreateAuthors: migrating ====================================
-- create_table(:authors)
   -> 0.0061s
== 20210227230437 CreateAuthors: migrated (0.0132s) ===========================
```

You may verify the results by checking the contents of the *db/schema.rb* file. This reflects the current database schema and the most recent applied migration. 

```rb
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_27_230437) do

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.text "bio"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
```

NOTE: Running db:migrate will only apply migrations whose timestamp version exceeds the value recorded in schema.rb. Running db:migrate again will result in no changes to the schema. 

### Modifying a Model

Modifying a model which already has a schema file is done via the *generate migration* command. The result of the command will be a new migration file which modifies, rather than creates, the affected table. The format to add a new column is: 
```console
ruby bin/rails g migration add_field_to_table field:type
```

As an example, it may be prudent to add a date of birth to the Authors table. A sample call would look as follows:

```console
my_app>ruby bin/rails g migration add_dob_to_authors dob:date
      invoke  active_record
      create    db/migrate/20210227232537_add_dob_to_authors.rb
```

The resulting migration file is a table change, rather than a table creation.

```rb
# db/migrate/20210227232537_add_dob_to_authors
class AddDobToAuthors < ActiveRecord::Migration[6.1]
  def change
    add_column :authors, :dob, :date
  end
end
```

The table change may be committed by a new call to db:migrate
```console
my_app>ruby bin/rails db:migrate
== 20210227232537 AddDobToAuthors: migrating ==================================
-- add_column(:authors, :dob, :date)
   -> 0.0032s
== 20210227232537 AddDobToAuthors: migrated (0.0044s) =========================
```

## Setting Up Data Routes

Setting up data routes is the heart of a Ruby on Rails application. This is the file which maps a url request to a specific controller function. This section defines basic setup of the file. 

### Checking Data Routes

Rails can summarize your route configurations on demand via the command line. This call is critical to debug issues in data routing in your application. A command and sample output is shown below: 

### Data Route Configuration Tags

#### root 

This tag defines the controller action that will be run when no specific controller is provided. Think of it as the homepage for your application. A sample below for the authors application sets the authors_controller.rb *index* action to load by default.
```rb
# config/routes.rb
Rails.application.routes.draw do
  root "articles#index"
  ...
end
```

#### get

This tag defines which action to load when a GET request of the given url format is provided. This can include text literals and instance specific keys. The following example contains definitions for the *index* and *show* functions in authors_controller.rb.
```rb
# config/routes.rb
Rails.application.routes.draw do
  root "articles#index"
  
  get "/authors", to: "authors#index"
  # :id represents the database key of a specific Author model
  get "/authors/:id", to: "authors#show" 
end
```

The same logic applies for DELETE and other HTML request types.

#### resources

Rather than manually specifiy each route for each kind of request, Rails is capable of providing standard CRUD routes via a the resources tag. This indicates that routes should be provided for all CRUD operations on a given conroller. The name should be the name preceeding controller in the rb file name. For example, requesting resources for *authors* would created routes for *authors_controller.rb*. A working sample is shown below:

```rb
# config/routes.rb
Rails.application.routes.draw do
  root "authors#index"

  resources :authors
end
```

A sample routes execution shows that all standard CRUD actions are created, regardless of what is actually implemented in authors_controller.rb
```console
C:\Users\gdunn1\Development\ror\personal_test>ruby bin/rails routes
        Prefix Verb   URI Pattern                         Controller#Action
          root GET    /                                   authors#index
       authors GET    /authors(.:format)                  authors#index
               POST   /authors(.:format)                  authors#create
    new_author GET    /authors/new(.:format)              authors#new  
   edit_author GET    /authors/:id/edit(.:format)         authors#edit 
        author GET    /authors/:id(.:format)              authors#show 
               PATCH  /authors/:id(.:format)              authors#update
               PUT    /authors/:id(.:format)              authors#update
               DELETE /authors/:id(.:format)              authors#destroy
```

## RSpec 

### Behavior Driven Development 

RSpec follows the principle of behavior driven development. This architecture defines what should and should result from application actions. It is best development practice to write your tests first and implement second. 

### Test Concept 

RSpec has a nearly sentence correct way of describing its tests. Each file describes a specific object, named as a class or string. Under this is a set of circumstance descriptions, such as 'valid inputs' and specific tests under those curcumstances. 

This is set up as a master describe block listing the object being tested. This will typically be the Model, View, or Request set. Under this will be a set of *describe* sub-blocks breaking the test into logical components. In the case of a Model test these would typically be a block for valid values and a block for invalid values. In the case of a request set this would be a describe block for each possible request type. 

Under these subcategories will be a number of *it* blocks defining the specific tests. Each *it* block will perform a set of actions and then validate the results by a number of expect clauses. There are two categories of *it* block. An *it* block with a body is evaluated and results in a pass unless an expect fails. An *it* block without a body is noted as a pending, unfinished test. It is best practice to define your tests in *it* blocks without a body at the start of development to establish what your application is expected to perform. 

### Spec Types

#### Model Specs

RSpec Model tests are defined in the *spec/models* directory. Each test should follow the naming convention model_spec.rb. For example, a test for the author.rb model would be under the file *spec/model/author_spec.rb*. The purpose of these tests should include internal model validation. 

The sample model spec below performs validation testing of the Author model basic properties, but only has a skeleton for the yet-undefined creation process. This will result in 1 pending test and 6 runnable tests.

```rb
# spec/model/author_spec.rb

require 'rails_helper'

RSpec.describe Author, type: :model do

  describe "Valid Entry" do
    it "is valid with valid attributes" do
      author = Author.new(name: "anything", bio: "example biography", dob: Date.new(1900,1,1))
      expect(author).to be_valid
    end
  end

  describe "Invalid Entry" do
  
    it "is not valid with no name" do
      author = Author.new(name: nil, bio: "example biography", dob: Date.new(1900,1,1))
      expect(author).to_not be_valid
    end

    it "is not valid with an empty name" do
      author = Author.new(name: "", bio: "example biography", dob: Date.new(1900,1,1))
      expect(author).to_not be_valid
    end

    it "is not valid with no bio" do
      author = Author.new(name: "anything", bio: nil, dob: Date.new(1900,1,1))
      expect(author).to_not be_valid
    end

    it "is not valid with short bio" do
      author = Author.new(name: "anything", bio: "example", dob: Date.new(1900,1,1))
      expect(author).to_not be_valid
    end
    
    it "is not valid with no dob" do
      author = Author.new(name: "anything", bio:  bio: "example biography", dob: nil)
      expect(author).to_not be_valid
    end
  
    it "is not valid with a duplicate name"
  end
end
```

#### Request Specs

Request specs serve to verify application behavior at the API level. They are stored in the *spec/requests* folder. Each file should be named by the convention *controller_request_spec.rb*. For example 

These tests inherently include controller testing. In orevious RSpec versions direct controller testing was included but this has been discouraged in recent versions.. The result of this is that to test the show action of a controller, there should be a corresponding rspec test for the GET authors/:id data route. A sample is provided for a crud validation below.

```rb
require 'rails_helper'

RSpec.describe "Authors", type: :request do

  let!(:author) { Author.create(
    name: "dude",
    bio: "A christian author in the mid-20th century",
    dob: Date.new(1900, 1, 15)
  ) }

  describe "GET authors#index" do
    it "returns http success" do
      get "/authors"
      expect(response).to have_http_status(200)
    end
  end

  describe "GET authors#show" do

    it "returns http success" do
      get "/authors/#{author.id}"
      expect(response).to have_http_status(200)
    end
    it "returns not found" do
      get "/authors/-1"
      expect(response.body).to include("<h1>Author Not Found</h1>")
    end
  end

  describe "POST authors#create" do
    it "adds a new entry to the authors database on valid input" do
      author_params = { "author": {
        name: "test, author",
        bio: "example bio",
        dob: Date.new(1900, 1, 15)
      }}
         
      expect {
        post "/authors", :params => author_params.to_json, :headers => { "Content-Type": "application/json" }
      }.to change(Author, :count).by(1)

      expect(response).to redirect_to("/authors/#{Author.count}")
    end

    it "renders new form to address validation issues" do 
      author_params = { "author": {
        name: nil,
        bio: nil,
        dob: nil
      }}
        
      post "/authors", :params => author_params
      
      expect(response.body).to include("<h1>New Author</h1>")
    end
  end

  describe "GET authors#edit" do

    it "renders the edit form for existing author" do
      get "/authors/#{author.id}/edit"
      expect(response).to have_http_status(200)
      expect(response.body).to include("<h1>Edit Author</h1>")
    end

    it "renders the notfound form for missing id" do
      get "/authors/-1/edit"
      expect(response.body).to include("<h1>Author Not Found</h1>")
    end
  end

  describe "PUT authors#update" do
    it "updates entries with valid changes then redirects to show" do
      
      author_params = { "author": {
        name: "Smith, Jane",
        bio: "An original Biography",
        dob: Date.new(1849,5,7)
      }}

      new_author_params = { "author": {
        name: "new, author",
        bio: "A replacement Biography",
        dob: Date.new(1850,5,7)
      }}

      author = Author.create(author_params[:author])
      new_author = Author.new(new_author_params[:author])
      put "/authors/#{author.id}", :params => new_author_params

      expect(author.reload.name).to eq(new_author.name)
      expect(author.reload.bio).to eq(new_author.bio)
      expect(author.reload.dob).to eq(new_author.dob)
      expect(response).to redirect_to("/authors/#{author.id}")
    end

    it "renders edit form to address validation issues" do
      author_params = { "author": {
        name: "Smith, Jane",
        bio: "An original Biography",
        dob: Date.new(1849,5,7)
      }}

      new_author_params = { "author": {
        name: "new, author",
        bio: nil,
        dob: Date.new(1850,5,7)
      }}

      author = Author.create(author_params[:author])
      new_author = Author.new(new_author_params[:author])
      put "/authors/#{author.id}", :params => new_author_params.to_json, :headers => { "Content-Type": "application/json" }

      expect(response.body).to include("<h1>Edit Author</h1>")
    end
  end

  describe "DELETE authors#destroy" do

    it "removes existing entries from the database and redirects to the index" do
      expect {
        delete "/authors/#{author.id}"
      }.to change(Author, :count).by(-1)

      expect(response).to redirect_to("/authors")
    end

    it "shows the not found page when the database entry does not exist" do
      delete "/authors/-1"
      expect(response.body).to include("<h1>Author Not Found</h1>")
    end
  end
end

```

### Executing Tests

The test bundle may be run by the command *bundle exec rspec*. This will execute all tests and provide a full summary of results. See the sample below:

```console
my_app>bundle exec rspec
*.................*

Pending: (Failures listed here are expected and do not affect your suite's status)

  1) AuthorsHelper add some examples to (or delete) C:/Users/gdunn1/Development/ror/personal_test/spec/helpers/authors_helper_spec.rb
     # Not yet implemented
     # ./spec/helpers/authors_helper_spec.rb:14

  2) authors/index.html.erb add some examples to (or delete) C:/Users/gdunn1/Development/ror/personal_test/spec/views/authors/index.html.erb_spec.rb
     # Not yet implemented
     # ./spec/views/authors/index.html.erb_spec.rb:4


Finished in 1.89 seconds (files took 31.3 seconds to load)
19 examples, 0 failures, 2 pending
```

## CRUD Controller

Assuming the application is set up as specified, each controller should set up the basic functional tasks of the application. At a minimum, these can typically be broken down into the following tasks: 
+ Create 
    + new/create controller actions
+ Read
    + index/show controller actions
+ Update
    + edit/update controller actions
+ Destroy
    + destroy controller action

The controller implementation for a CRUD application is remarkably simple. The role of the controller is to populate data in instance variables that are leveraged in the loaded views. 

The view loaded corresponds to the name of the contoller action executed. For example, the index action of the AuthorsController in *app/controllers/authors_controller.rb* will load the view in *app/views/authors/index.html.erb*. 


### Sample AuthorsController Implementation

```rb
class AuthorsController < ApplicationController
  def index
    @authors = Author.all
  end

  def show
    @author = Author.find(params[:id])

  rescue ActiveRecord::RecordNotFound
    render :notfound
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    
    if @author.save
       redirect_to @author
    else 
      render :new
    end
  end

  def edit 
    @author = Author.find(params[:id])
    
  rescue ActiveRecord::RecordNotFound
    render :notfound
  end

  def update
    @author = Author.find(params[:id])

    if @author.update(author_params)
      redirect_to @author
    else 
      render :edit
    end
  end

  def destroy

    @author = Author.find(params[:id])
    @author.destroy

    redirect_to "/authors"
  rescue ActiveRecord::RecordNotFound
    render :notfound
  end

  private 
    def author_params
      params.require(:author).permit(:name, :bio, :dob)
    end
end
```

## View Implementation Guidelines

There is no hard and fast rule for how a view should be implemented. These are by nature a mix of ruby and html, and as variable as you want them to be. This section will cover basics such as forms, lists, links, and partials, but the right way will depend heavily on your application.

### Index Showing a List

A common index implementation is to show a list of the database objects controller can manipulate. This is achieved by expecting an instance variable containing all available data entries, and iterating through it to generate a list of links. Additionally, an index will typically provide a way to add new entries.

Example: 

```rb
# app/views/authors/index.html.erb

<h1>Authors#index</h1>

<ul>
<% @authors.each do |author| %>
    <li> 
        <%= link_to author.name, author %>
    </li>
<% end %>
</ul>

<%= link_to "New Author", new_author_path %>
```

### Forms for Modifying an Object

```rb
# app/views/authors/index.html.erb

<h1>Edit Author</h1>

<%= form_with model: @author do |form| %>
    <div> 
        <%= form.label :name %> <br>
        <%= form.text_field :name %> <br> 
        <% @author.errors.full_messages_for(:name).each do |message| %>
            <div> <%= message %> </div>
        <% end %>
    </div>
    
    <div> 
        <%= form.label :bio %> <br>
        <%= form.text_area :bio %> <br> 
        <% @author.errors.full_messages_for(:bio).each do |message| %>
            <div> <%= message %> </div>
        <% end %>
    </div>
    
    <div> 
        <%= form.label :dob %> <br>
        <%= form.date_field :dob %> <br> 
        <% @author.errors.full_messages_for(:dob).each do |message| %>
            <div> <%= message %> </div>
        <% end %>
    </div>
    <div> 
        <%= form.submit %>
    </div>
    
<% end %>
```

### Common helper functions

There are a suite of helper functions which make it significantly cleaner to implement a view. The more helpful ones are detailed below.

#### link_to

This function creates an HTML link to another action. For example, the function: 
```rb
<%= link_to author.name, author %>
```
is equivalent to the following HTML:

```rb
<a href="/authors/<%= author.id %>"> <%= author.name %> </a>
```

The following variations support different crud actions

##### show 
```rb
<%= link_to author.name, author %>
```

##### create
```rb
<%= link_to "New Author", new_author_path %>
```

##### edit
```rb
<%= link_to "Edit", edit_author_path(@author) %> 
```

##### destroy
```rb
<%= link_to "Destroy", author_path(@author),
  method: :delete,
  data: { confirm: "Are you sure?" } %>
```

#### form_with

This command creates an html form for user data entry. It automates the creation of things like input fields, select lists, radio buttons, etc. It is ideal for a standard editing/creating database entries application.

The standard syntax for an author model with be: 
```rb
<%= form_with model: @author do |form| %>

  # Populate my form elements...

  <%= form.submit %>
<% end %>
```
