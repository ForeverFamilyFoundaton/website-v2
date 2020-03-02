class ConfigVariable < ApplicationRecord
  # attr_accessible :name, :value
  attr_readonly :name
end
