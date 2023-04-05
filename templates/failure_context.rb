# frozen_string_literal: true

CONTEXT_%{scenario_name_upcase} = "when using %{scenario_name}"

RSpec.shared_context CONTEXT_%{scenario_name_upcase} do
  let(:scenario) { "%{scenario_name}" }
  let(:generated_files) { [] }
  let(:expected_files) { [] }
  let(:overrides) do
    {
    }
  end

  let(:expected_errors) do
    [
    ]
  end
end
