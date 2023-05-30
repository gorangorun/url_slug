# UrlSlug

UrlSlug is a slug/permalink plugin with ActiveRecord and I18n support. It lets you create SEO friendly URLs.

With UrlSlug, it's easy to make your application use URLs like:

    https://example.com/posts/this-is-a-friendly-url

or

    https://example.com/posts/123-this-is-a-friendly-url

instead of:

    https://example.com/posts/123

## Usage

Add this line to your application's Gemfile:

```ruby
gem 'url_slug'
```

And then execute:

```shell
bundle install
```

Run the generator

```shell
# thor url_slug:install ClassName field:attr --path="path/to/class.rb"
thor url_slug:install Person name:slug --path="libs/person.rb"
```

or add it manually


```ruby
class Person
  include UrlSlug
  url_slug_for :name, attr: :slug

  ...
end

person = Person.new
person.name = "John Doe"
person.slug #=> "john-doe"
```

The `slug` attribute is optional. If you dont define it, then `:name_slug` will be used as attribute

```
  url_slug_for :name # creates :name_slug attribute

  person.name_slug
```

## Ruby on Rails

Run the install generator.

```shell
# rails g url_slug:rails ClassName field:field_slug --migration
rails g url_slug:rails Person name --migration
```

or add it manually

Edit the class file (e.g `app/models/person.rb`):

```ruby
class Person < ApplicationRecord
  include UrlSlug
  url_slug_for :name
end
```

Now when you create a new Person:

```ruby
person = Person.create!(name: "Ivan The Terrible")
person.name_slug #=> "ivan-the-terrible"
```

Optionally, if you want to persist the slug to db, create a migration

```shell
rails g migration AddNameSlugToPersons name_slug:string
rails db:migrate
```

### I18n support

Make sure you have locale files in place


```ruby
I18n.with_locale(:de) do
  person = Person.create!(name: "Wörter")
  person.name_slug #=> "worter"
end
```

## Bugs

Please report them on the [Github issue
tracker](https://github.com/gorangorun/url_slug/issues) for this project.

## License

Copyright (c) 2023 Goran Gjuroski, released under the MIT license.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
