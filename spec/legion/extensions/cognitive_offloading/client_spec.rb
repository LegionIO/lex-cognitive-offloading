# frozen_string_literal: true

require 'legion/extensions/cognitive_offloading/client'

RSpec.describe Legion::Extensions::CognitiveOffloading::Client do
  let(:client) { described_class.new }

  it 'responds to all runner methods' do
    expect(client).to respond_to(:register_store)
    expect(client).to respond_to(:offload_item)
    expect(client).to respond_to(:retrieve_item)
    expect(client).to respond_to(:report_retrieval_failure)
    expect(client).to respond_to(:items_in_store)
    expect(client).to respond_to(:items_by_type)
    expect(client).to respond_to(:most_important_offloaded)
    expect(client).to respond_to(:offloading_status)
  end

  it 'accepts an injected engine' do
    engine = Legion::Extensions::CognitiveOffloading::Helpers::OffloadingEngine.new
    c = described_class.new(engine: engine)
    result = c.register_store(name: 'test', store_type: :file)
    expect(result[:success]).to be true
  end

  it 'creates its own engine when none injected' do
    result = client.register_store(name: 'auto', store_type: :notes)
    expect(result[:success]).to be true
  end
end
