class Hub < ActiveRecord::Base
  # mms: no validations?
  belongs_to :user
end
