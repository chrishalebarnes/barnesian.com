---
layout: post
title: Continuous Testing in Rails using Guard and MiniTest
date: 2015-02-02
categories:
  - Software Development
permalink: /continuous-testing-in-rails-using-guard-and-minitest/
thumb:
  path: /assets/posts/continuous-testing-in-rails-using-guard-and-minitest/test_case.png
  alt: screenshot of Guard running in a terminal
lede:
  Testing is important in any software project. The faster the code is tested and the shorter the feedback cycle, the better. Here’s how to set up Guard and Guard::MiniTest to provide notifications for the fastest feedback loop possible. Anytime a file watched by Guard is saved it will run the test suite and pop up a notification. I’m using Fedora with Gnome 3 for the notifications bit, so the details might vary if you’re using something else like Ubuntu with Unity.
---
{% include post_image.md name="test_case.png" %}

Testing is important in any software project. The faster the code is tested and the shorter the feedback cycle, the better. Here’s how to set up [Guard](https://github.com/guard/guard "Guard on Github") and [Guard::MiniTest](https://github.com/guard/guard-minitest "Guiard::MiniTest on Github") to provide notifications for the fastest feedback loop possible. Anytime a file watched by Guard is saved it will run the test suite and pop up a notification. I’m using Fedora with Gnome 3 for the notifications bit, so the details might vary if you’re using something else like Ubuntu with Unity. I’ll start from scratch here.

Let’s get started. Open up a shell and create a new Rails project.
```shell
rails new continuous_testing
cd continuous_testing
```

Add the three gems to the Gemfile at the root of the project inside the :development group.
```ruby
group :development, :test do
  #…Other gems here
  gem ‘guard’
  gem ‘guard-minitest’
  gem ‘libnotify’
end
```

Back at the shell, install the gems:
```shell
bundle
```

Initialize Guard. This will create a file called Guardfile at the root of the project.
```shell
guard init minitest
```

Open up the Guardfile and uncomment the lines near # Rails 4. This tells Guard which files and directories to watch for changes. That section should look like this:
```ruby
guard :minitest do
  #… Other default configurations here
  # Rails 4
  watch(%r{^app/(.+)\.rb$})                               { |m| “test/#{m[1]}_test.rb” }
  watch(%r{^app/controllers/application_controller\.rb$}) { ‘test/controllers’ }
  watch(%r{^app/controllers/(.+)_controller\.rb$})        { |m| “test/integration/#{m[1]}_test.rb” }
  watch(%r{^app/views/(.+)_mailer/.+})                   { |m| “test/mailers/#{m[1]}_mailer_test.rb” }
  watch(%r{^lib/(.+)\.rb$})                               { |m| “test/lib/#{m[1]}_test.rb” }
  watch(%r{^test/.+_test\.rb$})
  watch(%r{^test/test_helper\.rb$}) { ‘test’ }
  #… Other default configurations here
end
```

Let’s use the scaffolding to generate a model, and a matching test. Also run rake db:migrate to initialize the database.
```shell
rails g scaffold SomeModel
rake db:migrate
```

Now you can run the generated test by running
```shell
rake test
```

You should notice a notification popup indicating success.

Now to make this truly continuous, Guard will watch for file changes and run the tests when something changes. It will popup a notification with the results.

At the root of the project, simply run Guard like this
```shell
guard
```

Note that you can stop Guard by typing ‘exit’.

Now let’s change something to see if it worked. Open up the generated test in test/models/some_model_test.rb. There is a bit of code that is commented out. Uncomment it, and save the file. After a second you should see the test results notification. The useless test case should look like this:
```ruby
test “the truth” do
  assert true
end
```

Upon saving the file you should see something like this notification. Again, I’m using Fedora, so it may vary depending on what platform you’re on.

{% include post_image.md name="test_results.png" %}

Happy frictionless testing!
