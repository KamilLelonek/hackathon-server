Rails.application.routes.draw do
  Pathname.new(Rails.root.join('config/routes/')).each_child do |route|
    instance_eval File.read route
  end
end