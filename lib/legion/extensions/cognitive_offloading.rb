# frozen_string_literal: true

require 'legion/extensions/cognitive_offloading/version'
require 'legion/extensions/cognitive_offloading/helpers/constants'
require 'legion/extensions/cognitive_offloading/helpers/external_store'
require 'legion/extensions/cognitive_offloading/helpers/offloaded_item'
require 'legion/extensions/cognitive_offloading/helpers/offloading_engine'
require 'legion/extensions/cognitive_offloading/runners/cognitive_offloading'

module Legion
  module Extensions
    module CognitiveOffloading
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
