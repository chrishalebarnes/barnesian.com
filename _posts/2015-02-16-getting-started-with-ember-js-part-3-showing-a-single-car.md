---
layout: post
title: 'Getting Started with Ember.js Part 3: Showing a Single Car'
date: 2015-02-16
categories:
  - Software Development
permalink: /getting-started-with-ember-js-part-3-showing-a-single-car/
thumb:
  path: /assets/posts/getting-started-with-ember-js-part-3-showing-a-single-car/final-edit-view.png
  alt: screenshot of Ember rendering an edit view
lede:
  In the last post, we set up the index view. Let’s set up a route that shows and saves a single car’s details.
---
{% include post_image.md name="final-edit-view.png" %}

In the [last post](/getting-started-with-ember-js-part-2-the-list-view), we set up the index view. Let’s set up a route that shows and saves a single car’s details.

#### Getting Started with Ember.js

* [Part 1: Project Setup](/getting-started-with-ember-js-part-1-project-setup) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample): [one](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/7b2d0f45a9990e1446fd0b94be6f3f220c85fbe9)[two](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/37740e46f20b731a7a46f08e607c2f9ea02a85ca)[three](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/69ffd477ea0491532b62653432972e522f03f5b5)
* [Part 2: The List View](/getting-started-with-ember-js-part-2-the-list-view) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/dd4ca56fe8feb6a18181e576fed0cb65b98a6d6e)
* [Part 3: Showing a Single Car](/getting-started-with-ember-js-part-3-showing-a-single-car) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/aa7ed787c33e78197fa4b4f0e95518e3514f3c2d)
* [Part 4: Creating a New Car](/getting-started-with-ember-js-part-4-creating-a-new-car) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/6658a8a1e833d491fd3bf00a74deca78f3103949)
* [Part 5: Deleting a Car and Wrapup](/getting-started-with-ember-js-part-5-deleting-a-car-and-wrapup) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/85e1569767eb96615c1588f518cadee0e46a1077)

[View on Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/aa7ed787c33e78197fa4b4f0e95518e3514f3c2d)

I’m combining the show and edit view here since they are largely redundant. Using the show view, we’ll need to have a save button that takes the model and calls the server to save the model. We’ll also add a cancel button that returns the user back to the index route.

Add the show route to the router in `app/assets/javascripts/router.js`. Note the inclusion of the :id parameter. This gives the route URL a parameter like `/#/cars/4,` where 4 is the primary key for the car.
```js
Cars.Router.map(function() {
  this.resource('cars', function() {
    this.route('show', { path: '/:id' });
  });
});
```

Add the Ember Data call to the cars route in `app/assets/javascripts/routes/CarsRoutes.js`. When this route is triggered, Ember Data will make a get request to /cars/:id to get the list of cars to display. It should look like this:
```js
Cars.CarsIndexRoute = Ember.Route.extend({
  model: function() {
    return this.store.findAll('car');
  }
});

Cars.CarsShowRoute = Ember.Route.extend({
  model: function(params) {
    return this.store.find('car', params.id);
  }
});
```

Add the show template in `app/assets/javascripts/templates/cars/show.js.hbs`. This is using the [Foundation grid](http://foundation.zurb.com/grid.html) for formatting. All of the divs for formatting aren’t strictly necessary, but will align all of the fields. The more important bits are the Handlebars helpers like {% raw %}{{input}}{% endraw %}.
```erb
{% raw %}
<div id="cars-show" class="panel">
  <h1>Edit Car</h1>
  <form {{action 'save' model on="submit"}}>
    <div class="row">
      <div class="small-3 columns">
        <label for="make" class="right inline required">Make</label>
      </div>
      <div class="small-9 columns">
        {{input id="make" type="text" required="" value=make}}
      </div>
    </div>
    <div class="row">
      <div class="small-3 columns">
        <label for="model" class="right inline required">Model</label>
      </div>
      <div class="small-9 columns">
        {{input id="model" type="text" required="" value=model.model}}
      </div>
    </div>
    <div class="row">
      <div class="small-3 columns">
        <label for="color" class="right inline required">Color</label>
      </div>
      <div class="small-9 columns">
        {{input id="color" type="text" required="" value=color}}
      </div>
    </div>
    <div class="row">
      <div class="small-3 columns">
        <label for="condition" class="right inline required">Condition</label>
      </div>
      <div class="small-9 columns">
        {{input id="condition" type="text" required="" value=condition}}
      </div>
    </div>
    <div class="actions">
      {{#link-to 'cars.index' class='button alert' }} Cancel {{/link-to}}
    </div>
  </form>
</div>
{% endraw %}
```

If you visit localhost:3000/#/cars/1 in the browser, you should see that the route throws a 404 error in the console. This is because we haven’t set up rails to handle the show action yet. So let’s take a break and do that. Add the typical set_car and car_params methods. Also add a show method that renders json using the serializer. It should look like this now:
```ruby
class CarsController < ApplicationController
  before_action :set_car, only: [:show]

  def index
    respond_to do |format|
      format.json { render json: Car.all }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @car }
    end
  end

  private
    def set_car
      @car = Car.find(params[:id])
    end

    def car_params
      params.require(:car).permit(:id, :make, :model, :color, :condition)
    end
end
```

You should be able to get the car in JSON form at localhost:3000/cars/1.json now. Refresh the view, and it should be populated with some data.

{% include post_image.md name="show-view.png" %}

Now back at the index view in `app/assets/javascripts/templates/cars/index.js.hbs`, you can now link to the show view in the grid. Replace one of the properties with a link-to:
```erb
{% raw %}
<div id="cars-index" class="panel">
  <h1>Cars</h1>
  <table role="grid">
    <thead>
      <tr>
        <th>Make</th>
        <th>Model</th>
        <th>Color</th>
        <th>Condition</th>
      </tr>
    </thead>
    <tbody>
      {{# each car in model}}
        <tr>
          <td>{{#link-to 'cars.show' car.id}} {{car.make}} {{/link-to}}</td>
          <td>{{car.model}}</td>
          <td>{{car.color}}</td>
          <td>{{car.condition}}</td>
        </tr>
        {{/each}}
    </tbody>
  </table>
</div>
{% endraw %}
```

Now let’s add a save button. As far as I can tell,[it’s idiomatic to put the save action on the route and not the controller](http://discuss.emberjs.com/t/where-should-i-define-a-save-action/5062/20) like you might expect. So we’ll add a save action to the Cars show route.

Add a save button that submits the form and add an action-on-submit to the form. show.js.hbs should now look like this:
```erb
{% raw %}
<div id="cars-show" class="panel">
  <h1>Car</h1>
  <form {{action 'save' model on="submit"}}>
    <div class="row">
      <div class="small-3 columns">
        <label for="make" class="right inline required">Make</label>
       </div>
       <div class="small-9 columns">
         {{input id="make" type="text" required="" value=make}}
       </div>
     </div>
     <div class="row">
       <div class="small-3 columns">
         <label for="model" class="right inline required">Model</label>
       </div>
       <div class="small-9 columns">
         {{input id="model" type="text" required="" value=model.model}}
       </div>
     </div>
     <div class="row">
       <div class="small-3 columns">
         <label for="color" class="right inline required">Color</label>
       </div>
       <div class="small-9 columns">
         {{input id="color" type="text" required="" value=color}}
       </div>
     </div>
     <div class="row">
       <div class="small-3 columns">
         <label for="condition" class="right inline required">Condition</label>
       </div>
       <div class="small-9 columns">
         {{input id="condition" type="text" required="" value=condition}}
       </div>
     </div>
     <div class="actions">
       <button type="submit" class="button success">Save</button>
       {{#link-to 'cars.index' class='button alert' }} Cancel {{/link-to}}
     </div>
  </form>
</div>
{% endraw %}
```

Back in `app/assets/javascripts/routes/CarsShowRoute.js` add an action object with the Ember Data code that will save the model. Note that you can transition back to index after success, or you could stay on the same page and display some kind of success message.
back to index`
```js
Cars.CarsShowRoute = Ember.Route.extend({
  model: function(params) {
    return this.store.find('car', params.id);
  },
  actions: {
    save: function(car) {
      var self = this;
      car.save().then(function(response) {
        //you can transition back to index
        //self.transitionTo('cars.index');
      }).catch(function() {
        console.log('Failure!')
      });
    }
  }
});
```

Now if you try to save you should get another 404 put error since we haven’t added the update part to Rails. Let’s do that now.

Add an update method and add :update to the before filter. The controller should now look like this:
```ruby
class CarsController < ApplicationController
  before_action :set_car, only: [:show, :update]

  def index
    respond_to do |format|
      format.json { render json: Car.all }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @car }
    end
  end

  def update
    respond_to do |format|
      if @car.update(car_params)
        format.json { render json: @car, status: :ok }
      else
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_car
      @car = Car.find(params[:id])
    end

    def car_params
      params.require(:car).permit(:id, :make, :model, :color, :condition)
    end
end
```

Head back to the form and you should be able to save the update. Check the console for the log messages and check the index page to see if the save worked.

Now that you’ve got the show view working and saving, head on to [Part 4: Creating a New Car](/getting-started-with-ember-js-part-4-creating-a-new-car).
