shared_context "cop" do
  let(:cop) { described_class.new(RuboCop::Config.new) }
end
