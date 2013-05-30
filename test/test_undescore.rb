require "underscore-template"
require "test/unit"

FUNCTION_PATTERN = /^_\.template\(.*?\)$/

module TestHelper
  def test(name, &block)
    define_method("test #{name.inspect}", &block)
  end
end

class UndescoreTemplateCompilationTest < Test::Unit::TestCase
  extend TestHelper

  test "compile" do
    result = Underscore::Engine.compile("Hello <%= name %>")
    assert_match FUNCTION_PATTERN, result
    assert_equal('_.template("Hello <%= name %>\n")', result)
  end

end

class UnderscoreEvaluationTest < Test::Unit::TestCase
  extend TestHelper

  test "quotes" do
    template = "<%= thing %> is gettin' on my noives!"
    assert_equal "This is gettin' on my noives!\n", Underscore::Engine.evaluate(template, :thing => "This")
  end

  test "backslashes" do
    template = "<%= thing %> is \\ridanculous"
    assert_equal "This is \\ridanculous\n", Underscore::Engine.evaluate(template, :thing => "This")
  end

  test "backslashes into interpolation" do
    template = %q{<%= "Hello \"World\"" %>}
    assert_equal "Hello \"World\"\n", Underscore::Engine.evaluate(template)
  end

  test "implicit semicolon" do
    template = "<% var foo = 'bar' %>"
    assert_equal "\n", Underscore::Engine.evaluate(template)
  end

  test "iteration" do
    template = "%ul <% for (var i = 0; i < people.length; i++) { %><li><%= people[i] %></li><% } %>"
    result = Underscore::Engine.evaluate(template, :people => ["Moe", "Larry", "Curly"])
    assert_equal "<ul><li>Moe</li><li>Larry</li><li>Curly</li></ul>\n", result
  end

  test "without interpolation" do
    template = "<div><p>Just some text. Hey, I know this is silly but it aids consistency.</p></div>"
    assert_equal template + "\n", Underscore::Engine.evaluate(template)
  end

  test "two quotes" do
    template = "It's its, not it's"
    assert_equal template + "\n", Underscore::Engine.evaluate(template)
  end

  test "quote in statement and body" do
    template = "<% if(foo == 'bar'){ %>Statement quotes and 'quotes'.<% } %>"
    assert_equal "Statement quotes and 'quotes'.\n", Underscore::Engine.evaluate(template, :foo => "bar")
  end

  test "newlines and tabs" do
    assert_raise Haml::SyntaxError do
      template = "This\n\tis: <%= x %>.\n\tok.\nend."
      Underscore::Engine.evaluate(template, :x => "that")
    end
  end

  test "escaping" do
    template = "<%- foobar %>"
    assert_equal "&lt;b&gt;Foo Bar&lt;&#x2F;b&gt;\n", Underscore::Engine.evaluate(template, { :foobar => "<b>Foo Bar</b>" })

    template = "<%- foobar %>"
    assert_equal "Foo &amp; Bar\n", Underscore::Engine.evaluate(template, { :foobar => "Foo & Bar" })

    template = "<%- foobar %>"
    assert_equal "&quot;Foo Bar&quot;\n", Underscore::Engine.evaluate(template, { :foobar => '"Foo Bar"' })

    template = "<%- foobar %>"
    assert_equal "&#x27;Foo Bar&#x27;\n", Underscore::Engine.evaluate(template, { :foobar => "'Foo Bar'" })
  end

end
