# frozen_string_literal: true

module ApplicationHelper
  module RatingsHelper
  def matt
    @matt ||= User.find_by(name: 'Matt')
  end

  def rebecca
    @rebecca ||= User.find_by(name: 'Rebecca')
  end
end
end
