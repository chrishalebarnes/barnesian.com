---
layout: post
title: Adding a Drop-down List in Rails with a Foreign Key
date: 2014-09-13
categories:
  - Software Development
permalink: /adding-a-drop-down-list-in-rails-with-a-foreign-key/
thumb:
  path: /assets/posts/adding-a-drop-down-list-in-rails-with-a-foreign-key/select_featured.png
  alt: screenshot of Rails rendering a dropdown list
lede:
  Setting up a foreign key relationship in Rails is easy, however, the form for the relationship proved to be a bit tricky. Ideally, you want the foreign key to be selected if it’s set in the show view and you want it to save in the new and edit views. Here is how to make that happen.
---
{% include post_image.md name="select_featured.png" %}

Setting up a foreign key relationship in Rails is easy, however, the form for the relationship proved to be a bit tricky. Ideally, you want the foreign key to be selected if it’s set in the show view and you want it to save in the new and edit views. Here is how to make that happen.

I’ll start from scratch here. I’m assuming you have a shell open at the root of your Rails project. We’ll make two models that have a foreign key relationship. Any Address can have one state. Address has the UI, so use the scaffold generator. It doesn’t make much sense for State to have a UI, so just use the model generator. Obviously you could write these yourself as well.
```shell
rails g scaffold Address
rails g model State name:string
```

Next we’ll want to add the states as a seed, so add this to seeds.rb in the db directory
```ruby
State.create([
  { name: 'Alabama'    },
  { name: 'Alaska'     },
  { name: 'Arizona'    },
  { name: 'Arkansas'   },
  { name: 'California' }
  #All other states...
])
```

To add the foreign key, add a belongs_to relationship in the Address migration in the db/migrate directory. It’ll look like this
```ruby
class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.belongs_to :state
      t.timestamps
    end
  end
end
```

Also add a belongs_to relationship to the Address model in `app/models/address.rb`Bootstrap. You can add whatever class you want.
```erb
<%= f.collection_select(:state_id, State.all, :id, :name, { :prompt => 'Select a State', :selected => @address.state_id }, { class: 'form-control' }) %>
```

Fire up the rails development server by typing rails s at the shell. Visit http://localhost:3000/addresses/new in the browser and it'll look like this:
```shell
rails s
```

{% include post_image.md name="select1.png" %}


{% include post_image.md name="select2.png" %}

Almost done! The state_id value won't save unless you permit it in the Address controller. Go to the Address controller in `app/controllers/addresses_controller.rb` and add the properties to permit in the address_params method at the bottom.
```ruby
def address_params
  params.require(:address).permit(:state_id)
end
```

Now you should be able to save and update Addresses with their associated State via the state_id column.
