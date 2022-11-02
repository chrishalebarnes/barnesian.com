---
layout: post
title: 'Getting Started with Ember.js Part 4: Creating a New Car'
date: 2015-02-16
categories:
  - Software Development
permalink: /getting-started-with-ember-js-part-4-creating-a-new-car/
thumb:
  path: /assets/posts/getting-started-with-ember-js-part-4-creating-a-new-car/final-new-view.png
  alt: screenshot of Ember rendering a new car screen
lede:
    In the last post, we set up a show and edit view. Let’s set up a view that allows for adding new cars.
---
{% include post_image.md name="final-new-view.png" %}

In the [last post](/getting-started-with-ember-js-part-3-showing-a-single-car), we set up a show and edit view. Let’s set up a view that allows for adding new cars.

#### Getting Started with Ember.js

* [Part 1: Project Setup](/getting-started-with-ember-js-part-1-project-setup) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample): [one](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/7b2d0f45a9990e1446fd0b94be6f3f220c85fbe9)[two](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/37740e46f20b731a7a46f08e607c2f9ea02a85ca)[three](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/69ffd477ea0491532b62653432972e522f03f5b5)
* [Part 2: The List View](/getting-started-with-ember-js-part-2-the-list-view) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/dd4ca56fe8feb6a18181e576fed0cb65b98a6d6e)
* [Part 3: Showing a Single Car](/getting-started-with-ember-js-part-3-showing-a-single-car) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/aa7ed787c33e78197fa4b4f0e95518e3514f3c2d)
* [Part 4: Creating a New Car](/getting-started-with-ember-js-part-4-creating-a-new-car) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/6658a8a1e833d491fd3bf00a74deca78f3103949)
* [Part 5: Deleting a Car and Wrapup](/getting-started-with-ember-js-part-5-deleting-a-car-and-wrapup) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/85e1569767eb96615c1588f518cadee0e46a1077)

[View on Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/6658a8a1e833d491fd3bf00a74deca78f3103949)

This is a very similar process to adding the show route. Start by adding a new route to `app/assets/javascripts/router.js`. This time around we don’t have any parameters since this is a route that is creating and saving a new car.
```js
Cars.Router.map(function() {
  this.resource("cars", function() {
    this.route('show', { path: '/:id' });
    this.route('new');
  });
});
```

Add a new route in `app/assets/javascripts/routes/CarsRoutes.js`. The model for this route is a new car record. On save Ember Data will post to `/cars` with a new car to create. Note that you also have to remove it from the client side store when leaving the page, otherwise you’ll end up with a blank car in the index grid. The call to [rollback()](http://emberjs.com/api/data/classes/DS.Model.html#method_rollback) in the [deactivate function](http://emberjs.com/api/classes/Ember.Route.html#method_deactivate) removes the car if the user decides to cancel. Once again you can [transitionTo](http://emberjs.com/api/classes/Ember.Route.html#method_transitionTo) index or [transitionTo](http://emberjs.com/api/classes/Ember.Route.html#method_transitionTo) the new car on the car.show route.
```js
Cars.CarsNewRoute = Ember.Route.extend({
  model: function() {
    return this.store.createRecord('car', {});
  },
  deactivate: function() {
    var model = this.modelFor(this.routeName)
    model.rollback();
  },
  actions: {
    save: function(model) {
      var self = this;
      model.save().then(function(response) {
        console.log('Success!');
        //transition back to index
        //self.transitionTo('cars.index');

        //transition to the saved new car
        self.transitionTo('cars.show', response);
      }).catch(function() {
        console.log('Failure!');
      });
    }
  }
});
```

Finally, let’s add the template to `app/assets/javascripts/templates/cars/new.js.hbs`. This template is the same as the show template. I’ll leave it up to you to remove the duplication.
```erb
{% raw %}
<div id="cars-new" class="panel">
  <h1>New Car</h1>
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

Upon trying to save the new car, you’ll notice that Ember throws a 404 while trying to post to `/cars.` We’ll have to head back over to the Rails side of things and set up a controller action to persist the new car.

Add a create method that saves the car and renders the new car’s JSON as a response. Once again, there is a fair bit of duplication here, so I’ll leave that up to you to solve. The controller in **app/controllers/cars_controller.rb** should look like this:
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

  def create
    @car = Car.new(car_params)
    respond_to do |format|
      if @car.save
        format.json { render json: @car, status: :created }
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

Finally, add an Add button to the index view in `app/assets/javascripts/templates/cars/index.js.hbs`
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
  <div class="actions">
    {{#link-to 'cars.new' class='button success' }} Add {{/link-to}}
  </div>
</div>
{% endraw %}
```

Now that you’ve got the ability to save a new car, head on to the final post [Part 5: Deleting a Car and Wrapup](/getting-started-with-ember-js-part-5-deleting-a-car-and-wrapup).
