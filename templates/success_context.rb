# frozen_string_literal: true

CONTEXT_%{scenario_name_upcase} = "when using %{scenario_name} configs"

RSpec.shared_context CONTEXT_%{scenario_name_upcase} do
  let(:scenario) { "%{scenario_name}" }
  let(:overrides) {} # TODO: remove if unused
  let(:generated_files) {} # TODO: remove if unused
  let(:expected_files) do
    [
    ]
  end
end
