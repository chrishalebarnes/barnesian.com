---
layout: post
title: 'Getting Started with Ember.js Part 5: Deleting a Car and Wrapup'
date: 2015-02-16
categories:
  - Software Development
permalink: /getting-started-with-ember-js-part-5-deleting-a-car-and-wrapup/
thumb:
  path: /assets/posts/getting-started-with-ember-js-part-5-deleting-a-car-and-wrapup/final-list-view-2.png
  alt: screenshot of Ember rendering a list of cars
lede:
    In the last post we set up the new car view. In the final post let’s add the ability to delete a car and wrap up this series.
---
{% include post_image.md name="final-list-view-2.png" %}

In the [last post](/getting-started-with-ember-js-part-4-creating-a-new-car) we set up the new car view. In the final post let’s add the ability to delete a car and wrap up this series.

#### Getting Started with Ember.js

* [Part 1: Project Setup](/getting-started-with-ember-js-part-1-project-setup) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample): [one](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/7b2d0f45a9990e1446fd0b94be6f3f220c85fbe9)[two](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/37740e46f20b731a7a46f08e607c2f9ea02a85ca)[three](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/69ffd477ea0491532b62653432972e522f03f5b5)
* [Part 2: The List View](/getting-started-with-ember-js-part-2-the-list-view) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/dd4ca56fe8feb6a18181e576fed0cb65b98a6d6e)
* [Part 3: Showing a Single Car](/getting-started-with-ember-js-part-3-showing-a-single-car) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/aa7ed787c33e78197fa4b4f0e95518e3514f3c2d)
* [Part 4: Creating a New Car](/getting-started-with-ember-js-part-4-creating-a-new-car) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/6658a8a1e833d491fd3bf00a74deca78f3103949)
* [Part 5: Deleting a Car and Wrapup](/getting-started-with-ember-js-part-5-deleting-a-car-and-wrapup) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/85e1569767eb96615c1588f518cadee0e46a1077)

[View on Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/85e1569767eb96615c1588f518cadee0e46a1077)

Add an action object to the `app/assets/javascripts/routes/CarsRoutes.js`. This one will handle deleting a car from the grid. Note that you call [deleteRecord()](http://emberjs.com/api/data/classes/DS.Model.html#method_deleteRecord) and then [save()](http://emberjs.com/api/data/classes/DS.Model.html#method_save) which actually makes the HTTP delete call to `/cars/:id`. In this example I’ve just logged success to the console, but you’ll want to figure out a way to notify the user of success or failure. I’ve found it useful to turn off the network in the browser’s developer tools to induce a failure.
```js
Cars.CarsIndexRoute = Ember.Route.extend({
  model: function() {
    return this.store.findAll('car');
  },
  actions: {
    delete: function(car) {
    car.deleteRecord();
    car.save().then(function(response) {
      console.log('Success!')
    }).catch(function() {
      console.log('Failure!')
    });
  }
  }
});
```

Finally, add the delete button to the right most column of the grid in `app/assets/javascripts/templates/cars/index.js.hbs`. This will call the delete action and feed it the car model for that row.
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
        <th></th>
      </tr>
    </thead>
    <tbody>
      {{# each car in model}}
        <tr>
          <td>{{#link-to 'cars.show' car.id}} {{car.make}} {{/link-to}}</td>
          <td>{{car.model}}</td>
          <td>{{car.color}}</td>
          <td>{{car.condition}}</td>
          <td>
            <button {{action 'delete' car}} type="button" class="button alert tiny">
              Delete
            </button>
          </td>
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


Now if you click the delete button you’ll see an HTTP delete 404 since we haven’t set up that action in Rails yet. Head over to `app/controllers/cars_controller.rb` to add the destroy method and allow it in the before_action.
```ruby
class CarsController < ApplicationController
  before_action :set_car, only: [:show, :update, :destroy]

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

  def destroy
    respond_to do |format|
      if @car.destroy
        format.json { render json: Car.all, status: :ok }
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

One final note here, you’ll notice that we never defined a controller. This may be surprising if you’re familiar with a server-side MVC framework like Rails. A controller gives you the ability to add computed properties and have another set of actions. The controller acts as a ViewModel while the model acts as an object to shuffle around over HTTP. The bits required for persistence are in the routes, but there could be some behavior that you want to add that doesn’t interact over HTTP. For these kinds of interactions, you’d want to add a controller. If you add validation or something else in that class of interaction, you can add a controller for each route. They are located in `app/assets/javascripts/controllers` and look something like this:
```js
Cars.CarsIndexController = Ember.ArrayController.extend({
  someProperty: 'Something',
  someFunction: function() {
    console.log('Some Function Called.');
  }
});
```

Ember also has views, which adds yet another set of interactions that are possible. It can be very confusing to know what code goes into which object. Since this guide is really only concerned with building persistence with a Rails back-end, we won’t go into these. You can find the rest of the Ember documentation [right here](http://emberjs.com/guides/getting-started/).

That’ll do it! You now have a rather naive form that can create, show, update, and delete a resource.

{% include post_image.md name="final-list-view-2.png" %}

Finally, there is a lot more to Ember than simple CRUD operations. It is really a toolkit to provide a rich user experience on the client-side. It’s quite likely that you’ll need to do some kind of persistence-over-http CRUD operations for a huge amount of applications out there. That story was a bit obtuse, so hopefully this guide helped you get started. If I missed anything, or something is not idiomatic, let me know in the comments or via the [contact form](https://www.barnesian.com/contact/)!
