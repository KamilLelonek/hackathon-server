module Accidents
  class Accident < ActiveRecord::Base
    enum kind:   [:flic, :mobile]
    enum status: [:waiting, :active, :finished, :cancelled]
  end
end
