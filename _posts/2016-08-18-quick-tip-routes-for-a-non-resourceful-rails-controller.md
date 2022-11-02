---
layout: post
title: 'Quick Tip: Routes for a Non-Resourceful Rails Controller'
date: 2016-08-18
categories:
  - Software Development
permalink: /quick-tip-routes-for-a-non-resourceful-rails-controller/
thumb:
  path: /assets/posts/quick-tip-routes-for-a-non-resourceful-rails-controller/controller-route.png
  alt: screenshot of a rails controller
lede:
    Let’s say you have a few routes that are all related, but don’t really map to the usual resources. For example, a login/logout controller named SessionsController doesn’t really fit the usual resourceful route model
---
{% include post_image.md name="controller-route.png" %}

Let’s say you have a few routes that are all related, but don’t really map to the usual resources. For example, a login/logout controller named SessionsController doesn’t really fit the usual resourceful route model. One could use the usual routes HTTP verb syntax like this
```ruby
Rails.application.routes.draw do
  #...
  get  'login',  to: 'sessions#index'
  post 'login',  to: 'sessions#login'
  post 'logout', to: 'sessions#logout'
end
```

However, there’s a nifty little helper that’s not in the [routing guide](http://guides.rubyonrails.org/routing.html) but is in the [API docs](http://api.rubyonrails.org/classes/ActionDispatch/Routing.html) called controller which feels a bit cleaner.

```ruby
Rails.application.routes.draw do
  #...
  controller :sessions do
    get  :login,  action: :index
    post :login,  action: :login
    post :logout, action: :logout
  end
end
```

After running `rake routes` or `rails routes` to see what routes we’ve got, we’ll see three routes.
```shell
login  GET  /login(.:format)  sessions#index
       POST /login(.:format)  sessions#login
logout POST /logout(.:format) sessions#logout
```

If there’s an even better way, let me know in the comments!
