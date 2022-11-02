---
layout: post
title: 'Getting Started with Ember.js Part 1: Project Setup'
date: 2015-02-16
categories:
  - Software Development
permalink: /getting-started-with-ember-js-part-1-project-setup/
thumb:
  path: /assets/posts/getting-started-with-ember-js-part-1-project-setup/tomster-greeting.png
  alt: screenshot of the Ember mascot, the Tomster
lede:
  Shortly after sitting down to try and learn Ember.js, I learned that Ember has a “Getting Started Problem.” Everything in the docs seems reasonable, but when you go to make a real world application with a real web server, you realize there are a lot of gaps. Each individual component is well documented, but gluing them together proved to be an exercise in frustration. There are not very many examples of best practices within the context of a real application, instead of a single page to-do app.
---
{% include post_image.md name="tomster-greeting.png" %}

Shortly after sitting down to try and learn [Ember.js](http://emberjs.com/), I learned that Ember has a “Getting Started Problem.” Everything in the docs seems reasonable, but when you go to make a real world application with a real web server, you realize there are a lot of gaps. Each individual component is well documented, but gluing them together proved to be an exercise in frustration. There are not very many examples of best practices within the context of a real application, instead of a single page to-do app. In this post I’ll take you through making a single [CRUD](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete) resource. I’ll use a toy example of a car database, from which you can create, read, update and delete cars. We’ll be going through a typical [Rails](http://rubyonrails.org/) application to serve up [JSON](http://json.org/example) using [Active Model Serializers](https://github.com/rails-api/active_model_serializers) to feed the client side application using [Ember.js](https://github.com/emberjs/ember.js) and [Ember Data](https://github.com/emberjs/data). If something is amiss or is not idiomatic, let me know in the comments or via the [contact form](https://www.barnesian.com/contact/). Let’s get started!

#### Getting Started with Ember.js

* [Part 1: Project Setup](/getting-started-with-ember-js-part-1-project-setup) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample): [one](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/7b2d0f45a9990e1446fd0b94be6f3f220c85fbe9)[two](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/37740e46f20b731a7a46f08e607c2f9ea02a85ca)[three](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/69ffd477ea0491532b62653432972e522f03f5b5)
* [Part 2: The List View](/getting-started-with-ember-js-part-2-the-list-view) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/dd4ca56fe8feb6a18181e576fed0cb65b98a6d6e)
* [Part 3: Showing a Single Car](/getting-started-with-ember-js-part-3-showing-a-single-car) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/aa7ed787c33e78197fa4b4f0e95518e3514f3c2d)
* [Part 4: Creating a New Car](/getting-started-with-ember-js-part-4-creating-a-new-car) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/6658a8a1e833d491fd3bf00a74deca78f3103949)
* [Part 5: Deleting a Car and Wrapup](/getting-started-with-ember-js-part-5-deleting-a-car-and-wrapup) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/85e1569767eb96615c1588f518cadee0e46a1077)

## Setting Up the Project

View on Github: [Part 1](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/7b2d0f45a9990e1446fd0b94be6f3f220c85fbe9) [Part 2](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/37740e46f20b731a7a46f08e607c2f9ea02a85ca) [Part 3](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/69ffd477ea0491532b62653432972e522f03f5b5)

The Ember team has provided a gem, called [ember-rails](https://github.com/emberjs/ember-rails), along with a great template that will generate a typical Ember focused Rails application. It generates the typical Ember directory structure in **app/assets/javascripts**. It also configures all of the ember requests to include the Rails CSRF token. So we’ll use this to get started, however, there are instructions on the[ember-rails Github page](https://github.com/emberjs/ember-rails) on setting up an existing application.

From a shell, download the rails template from [http://emberjs.com/edge_template.rb](http://emberjs.com/edge_template.rb)
```shell
wget http://emberjs.com/edge_template.rb
```

You can stick with the default [CoffeeScript](http://coffeescript.org/), but to reduce the scope here, we’ll stick to JavaScript. Change the line that reads “generate “ember:bootstrap” to the following:
```shell
generate “ember:bootstrap –javascript-engine js”
```

Save that and generate a new Rails project using the modified Ember template. Also change into that directory.
```shell
rails new cars –m ./edge_template.rb
cd cars
```

Fire up the Rails development server.
```shell
rails s
```

Visit localhost:3000 in a browser and you should see the Ember mascot, the Tomster, giving you a warm greeting.

{% include post_image.md name="tomster-greeting.png" %}

Also note that the project template sets up a typical Ember directory structure in**app/assets/javascripts** that looks like this:
```
app/assets/javascripts/
├── adapters
│ └── application_adapter.js
├── application.js
├── cars.js
├── components
├── controllers
├── helpers
├── mixins
├── models
├── router.js
├── routes
├── templates
│ ├── components
│ └── index.js.handlebars
└── views
```

## Adding some CSS and a Header

I’ll be using Foundation to provide some styling, so you don’t want to tear your eyes out. Add [foundation.css](https://cdnjs.cloudflare.com/ajax/libs/foundation/5.5.0/css/foundation.css) and [normalize.css](https://cdnjs.cloudflare.com/ajax/libs/foundation/5.5.0/css/normalize.css) to **app/assets/stylesheets**. Since the stylesheets are in that directory, Rails will automatically include them. Obviously feel free to use any CSS library, but all the class names in this example are using Foundation.

Add a new file, **app/assets/javascripts/templates/application.js.hbs**. Since it is named application.js.hbs, Ember will assume it is a layout template that will include something like a header and a footer. That’s exactly how we’ll treat it. Add this structure to application.js.hbs. Note that {%raw%}{{outlet}}{%endraw%} yields to the template, which is currently index.js.hbs.
```erb
{%raw%}
<div id=“header” class=“sticky”>
  <nav class=“top-bar” data–topbar role=“navigation”>
    <ul class=“title-area”>
      <li class=“name”>
        <h1><a href=“/”>Cars</a></h1>
      </li>
      <li class=“toggle-topbar menu-icon”><a href=“#”><span>Menu</span></a></li>
    </ul>
  </nav>
</div>
<div class=“main-content”>
  {{outlet}}
</div>
<footer>
  <h3>Cars</h3>
</footer>
{%endraw%}
```

The footer won’t look very nice, so let’s fix that up. Add these styles to the bottom of `app/assets/stylesheets/application.css`
```css
footer {
  background-color: #333;
  height: 4em;
  position: fixed;
  width: 100%;
  bottom: 0;
  text-align: center;
}

footer h3 {
  margin-top: 0.6em;
}

footer, footer h1, footer h2, footer h3, footer h4, footer h5 {
  color: #858585;
}

.main-content {
  margin-bottom: 4em;
}

table {
  width: 100%;
}

table td:last-of-type {
text-align: right;
}

.actions {
  text-align: right;
}
```


That will give the footer some height and stick it to the bottom of the window. It’ll also make any tables span the entire width of the page and right-align save and cancel buttons, which we’ll make later. It should now look like this:

{% include post_image.md name="header-footer.png" %}

Finally let’s add some data, so we can get started with Ember. We’ll add a model, create a migration, and add some seed data.

Back at the shell, generate a new model:
```shell
rails g model Car make:string model:string color:string condition:string
```

Note that this makes a new migration in **db/migrate/*date*_create_cars.rb**. Now let’s add three cars to the database. Add this seed to **db/seeds.rb**
```ruby
Car.create([
  { make: ‘Honda’ , model: ‘Civic’, color: ‘silver’, condition: ‘new’    },
  { make: ‘Subaru’, model: ‘WRX’,   color: ‘blue’,   condition: ‘used’   },
  { make: ‘BMW’,    model: ‘i3’,    color: ‘black’,  condition: ‘broken’ }
])
```

Back at the shell, create and seed the database.
```shell
rake db:migrate
rake db:seed
```

Now we’ll add a route and a controller. Open up **config/routes.rb** and add a resource route for cars. Note that the Ember Rails template added the first two routes when the project was created. It should now look like this:
```ruby
Rails.application.routes.draw do
  root :to => ‘assets#index’
  get ‘assets/index’
  resources :cars
end
```

From a shell, add a controller without a view and with an index action. We’ll add the rest of the routes ourselves later.
```shell
rails g controller Cars index —no–template–engine
```

Open up **app/controllers/cars_controller.rb** and add a respond_to block inside the index action.
```ruby
class CarsController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: Car.all }
    end
  end
end
```

To have the respond_to block render Car.all as JSON, we’ll use an active model serializer. Generate one like this:
```shell
rails g serializer car
```

That will generate a file in **app/serializers/car_serializer.rb**. Open it up and add all of the car attributes. It should look like this:
```ruby
class CarSerializer < ApplicationSerializer
  attributes :id, :make, :model, :color, :condition
end
```

Now if you visit localhost:3000/cars.json in the browser you should see the JSON representation of the three cars we added in the seed. We’re done with the Rails bit for now; let’s move onto the client side and hook Ember up to this list of data.

Now that we’ve got Rails all set up to serve up cars via JSON, head on to [Part 2: The List View](/getting-started-with-ember-js-part-2-the-list-view)
