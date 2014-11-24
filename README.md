# Schneiderlein [![Build Status](https://travis-ci.org/Absolventa/schneiderlein.svg?branch=master)](https://travis-ci.org/Absolventa/schneiderlein)

**Schneiderlein** is a Rack middleware to catch parse errors coming from [ActionDispatch::ParamsParser](https://github.com/rails/rails/blob/master/actionpack/lib/action_dispatch/middleware/params_parser.rb).

Since the error appears early in the middleware stack, there is no way to use `rescue_from` on controller-level in a Rails app. **Schneiderlein** blanks the defective POST data from the request environment, saves the `ParseError`'s message and passes the modified Rack env along the middleware stack.

The original error message is saved as `rack.schneiderlein.parse_errors` in the request environment.

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
The name **Schneiderlein** is derived from the fairytale »Das Tapfere Schneiderlein« (»The Valiant Little Tailor«) by the Grimm Brothers. The Valiant Little Tailer catches flies, **Schneiderlein** catches errors. Funny, eh?

## Changelog

### 0.1.0
* Initial release