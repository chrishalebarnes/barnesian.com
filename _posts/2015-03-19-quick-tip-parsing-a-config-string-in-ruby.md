---
layout: post
title: 'Quick Tip: Parsing a Config String in Ruby'
date: 2015-03-19
categories:
  - Software Development
permalink: /quick-tip-parsing-a-config-string-in-ruby/
thumb:
  path: /assets/posts/quick-tip-parsing-a-config-string-in-ruby/irb_config.png
  alt: screenshot of some Ruby code that parses a config string in an irb console
lede:
    'Recently I came across the need to parse a bit of a config file, in this kind of format: "Category=filetype;…" Here is how one would do such a thing using split, inject, and map.'
---
{% include post_image.md name="irb_config.png" %}

Recently I came across the need to parse a bit of a config file, in this kind of format: “Category=filetype;…” Here is how one would do such a thing using [split](http://ruby-doc.org/core-2.2.1/String.html#method-i-split), [inject](http://ruby-doc.org/core-2.2.1/Enumerable.html#method-i-inject "Docs for enumerable inject") and [map](http://ruby-doc.org/core-2.2.1/Enumerable.html#method-i-map "Docs for enumerable map").
```ruby
raw_config = "Image=jpg,tiff,png;Document=docx,doc,pdf;Other=rb,cs,c;"

config = raw_config.split(";").inject({}) do |result, fragment|
  type, extensions = fragment.split("=")
  result[type.strip.downcase.to_sym] = extensions.split(",").map{ |s| s.strip }
  result
end
```

The result is a [hash](http://ruby-doc.org/core-2.2.1/Hash.html "Docs for Ruby Hash") where you can get an array of the file extensions for a given category like this
`config[:image]`
and the resulting hash looks like this:
```ruby
{
  :image => ["jpg", "tiff", "png"],
  :document => ["docx", "doc", "pdf"],
  :other => ["rb", "cs", "c"]
}
```

Let me know in the comments if you have a better way!
