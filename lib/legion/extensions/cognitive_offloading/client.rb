# frozen_string_literal: true

require 'legion/extensions/cognitive_offloading/helpers/constants'
require 'legion/extensions/cognitive_offloading/helpers/external_store'
require 'legion/extensions/cognitive_offloading/helpers/offloaded_item'
require 'legion/extensions/cognitive_offloading/helpers/offloading_engine'
require 'legion/extensions/cognitive_offloading/runners/cognitive_offloading'

module Legion
  module Extensions
    module CognitiveOffloading
      class Client
        include Runners::CognitiveOffloading

        def initialize(engine: nil, **)
          @offloading_engine = engine || Helpers::OffloadingEngine.new
        end

        private

        attr_reader :offloading_engine
      end
    end
  end
end
