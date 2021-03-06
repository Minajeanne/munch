require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride #overrides browser support for PUT & DELETE methods
use UsersController
use ReviewsController
use RestaurantsController

run ApplicationController
