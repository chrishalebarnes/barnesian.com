---
layout: post
title: 'Getting Started with Ember.js Part 2: The List View'
date: 2015-02-16
categories:
  - Software Development
permalink: /getting-started-with-ember-js-part-2-the-list-view/
thumb:
  path: /assets/posts/getting-started-with-ember-js-part-2-the-list-view/list-view.png
  alt: screenshot of Ember rendering a list view
lede:
  In the last post, we set up Rails to serve up a list of cars. Now let’s hook up Ember to display that data.
---
{% include post_image.md name="list-view.png" %}

In the [last post](/getting-started-with-ember-js-part-1-project-setup/), we set up Rails to serve up a list of cars. Now let’s hook up Ember to display that data.

#### Getting Started with Ember.js

* [Part 1: Project Setup](/getting-started-with-ember-js-part-1-project-setup) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample): [one](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/7b2d0f45a9990e1446fd0b94be6f3f220c85fbe9)[two](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/37740e46f20b731a7a46f08e607c2f9ea02a85ca)[three](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/69ffd477ea0491532b62653432972e522f03f5b5)
* [Part 2: The List View](/getting-started-with-ember-js-part-2-the-list-view) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/dd4ca56fe8feb6a18181e576fed0cb65b98a6d6e)
* [Part 3: Showing a Single Car](/getting-started-with-ember-js-part-3-showing-a-single-car) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/aa7ed787c33e78197fa4b4f0e95518e3514f3c2d)
* [Part 4: Creating a New Car](/getting-started-with-ember-js-part-4-creating-a-new-car) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/6658a8a1e833d491fd3bf00a74deca78f3103949)
* [Part 5: Deleting a Car and Wrapup](/getting-started-with-ember-js-part-5-deleting-a-car-and-wrapup) -> [Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/85e1569767eb96615c1588f518cadee0e46a1077)

[View on Github](https://github.com/chrishalebarnes/EmberRailsCarsExample/commit/dd4ca56fe8feb6a18181e576fed0cb65b98a6d6e)

Let’s start off by adding the model that describes the Car. Add a new file in `app/assets/javascripts/models/Car.js`
```js
Cars.Car = DS.Model.extend({
  make: DS.attr('string'),
  model: DS.attr('string'),
  color: DS.attr('string'),
  condition: DS.attr('string')
});
```

Add a route for the index view that uses [Ember Data](https://github.com/emberjs/data "Ember Data on Github") to find the list of cars. Note that you could certainly use JQuery’s getJSON instead.

Create a new file: `app/assets/javascripts/routes/CarsRoutes.js`. Add the index route and associate it with the Car model. findAll is part of the Ember Data API; you could just as easily replace that with a [JQuery getJSON](http://api.jquery.com/jquery.getjson/) call or any other method of issuing and HTTP call. It should look like this:
```js
Cars.CarsIndexRoute = Ember.Route.extend({
  model: function() {
    return this.store.findAll('car');
  }
});
```

Add the resource route in `app/assets/javascripts/router.js`. We’ll include more routes in the empty function later. Make sure it’s there since it changes how the routes are registered. Just leave it empty for now.
```js
Cars.Router.map(function() {
  this.resource('cars', function() {
  });
});
```

Finally, add the index template in `app/assets/javascripts/templates/cars/index.js.hbs`
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
          <td>{{car.make}}</td>
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

That’s it for the list view! Visit `localhost:3000/#/cars` and it should look like this now:

{% include post_image.md name="list-view.png" %}

Now that you’ve got the index working, head on to [Part 3: Showing a Single Car](/getting-started-with-ember-js-part-3-showing-a-single-car).
