class ScoutRequirement < ActiveRecord::Base
  belongs_to :scout
  belongs_to :requirement

  accepts_nested_attributes_for :requirement

end