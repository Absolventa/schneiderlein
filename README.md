# Schneiderlein
![Build Status](https://github.com/absolventa/schneiderlein/actions/workflows/ci.yml/badge.svg)
[![Gem Version](https://badge.fury.io/rb/schneiderlein.svg)](http://badge.fury.io/rb/schneiderlein)

**Schneiderlein** is a Rack middleware to catch parse errors coming from [ActionDispatch::ParamsParser](https://github.com/rails/rails/blob/master/actionpack/lib/action_dispatch/middleware/params_parser.rb). Malformed XML presents a 500 Internal Server Error to your API consumer. It's hardly meaningful, should instead be in the 4xx range and most importantly: it's not helping.

Since the error appears early in the middleware stack, there is no way to use `rescue_from` on controller-level in a Rails app. **Schneiderlein** blanks the defective POST data from the request environment, saves the `ParseError`'s message and passes the modified Rack env along the middleware stack.

The original error message is saved as `rack.schneiderlein.parse_errors` in the request environment. `Schneiderlein::Catch` aims to provide a convenient accessor. See the usage example below.

## Usage

Add the gem to your Rails app's Gemfile. In your API controller, you may want to add something like this:

```ruby
class Api::BaseController < ApplicationController
  before_action :handle_parse_errors

  respond_to :json, :xml

  protected

  def handle_parse_errors
    schneiderlein = Schneiderlein::Catch.new(request)
    respond_with schneiderlein.errors, status: 422 if schneiderlein.errors.any?
  end
end
```

## Naming
The name **Schneiderlein** is derived from the fairytale »Das Tapfere Schneiderlein« (»The Valiant Little Tailor«) by the Grimm Brothers. The Valiant Little Tailor catches flies, **Schneiderlein** catches errors. Funny, eh?

## Changelog

### 4.0.0
* Drop support for Rails below 6.1
* Drop support for Ruby below 3.0
* Add support for Rails 7.+
* Switch from Travis CI to GitHub Actions

### 3.0.0
* Drop support for Rails below 5.2
* Add support for Rails 6.+

### 2.0.0
* Drop support for Rails below 5.0
* Add support for Rails 5.1+

### 1.3.1
* Call middleware by their constants (fixes deprecation warning)

### 1.3.0
* Use `frozen_string_literal` magic comment
* Remove autoload calls

### 1.2.0
* Supports Rails 5
* Drops support for Rails < 4.2
* Drops support for C-Ruby v2.0.x and v2.1.x

### 1.1.0
* compactified error message presentation

### 1.0.0
* Initial release
