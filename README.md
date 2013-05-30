# Haml Underscore Template Compiler

This project is an addendum to the Underscore Template Compiler built by Jean-Sebastien Ney. You can follow my fork
link back to his project if you are interested in the original code. This code will no longer be following that repository.

# Purpose

Say that you're using **BackboneJS**, **UnderscoreJS**, and **jQuery**. A lot of the time you end up putting templates
directly in to the HTML, and then go after them utilizing the jQuery `$('#template-for-things').html()` functionality,
rather than having them directly included within your asset pipeline. That is not an insignificant operation for the browser
to have to go running after, every time a page boots up. This functionality already exists in sprockets implemented as
EJS and the JST function from the browser side. Additionally, if you're using haml and have already built a lot
of your templates in that matter, it is a non-trivial task to convert those all over to HTML. And really, why would you want to?
HAML is a lot easier to write than HTML, and it's a lot easier to reason about. Thus, this project.

[Backbone.js](http://documentcloud.github.com/backbone) | 
[Underscore.js](http://documentcloud.github.com/underscore/) | 
[ejs](http://github.com/sstephenson/ruby-ejs) | 
[sprockets](http://github.com/sstephenson/sprockets) | 
[JST](https://github.com/sstephenson/sprockets#javascript-templating-with-ejs-and-eco) | 

Just add this to your `Gemfile` :

    gem 'underscore-template'
    
Example :

    <!-- templates/hello.jst._ -->
    .hello 
      Hello
      %span <%= name %>!

    // application.js
    //= require templates/hello
    $("#hello").html(JST["templates/hello"]({ name: "Sam" }));

Invoke the function in a JavaScript environment to produce a string
value. You can pass an optional object specifying local variables for
template evaluation.

The underscore template tag syntax is as follows:

* `<% ... %>` silently evaluates the statement inside the tags.
* `<%= ... %>` evaluates the expression inside the tags and inserts
  its string value into the template output.
* `<%- ... %>` behaves like `<%= ... %>` but HTML-escapes its output.

If you have the [ExecJS](https://github.com/sstephenson/execjs/)
library and a suitable JavaScript runtime installed, you can pass a
template and an optional hash of local variables to `UnderscoreTemplate.evaluate`:

    Underscore::Template.evaluate("Hello <%= name %>", :name => "world")
    # => "Hello world"

-----

&copy; 2012 Christopher Rueber

(most code originally written by [Jean-Sebastien Ney](http://github.com/jney/ruby-underscore-template), and a lot of framework code by [@sstephenson](http://github.com/sstephenson))

The MIT License
