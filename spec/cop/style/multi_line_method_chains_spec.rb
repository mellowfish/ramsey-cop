require "spec_helper"

RSpec.describe RamseyCop::Cop::Style::MultiLineMethodChains do
  include_context "cop"

  context "with a single line method chain" do
    it "registers no offenses" do
      expect_no_offenses(<<~RUBY)
        one.two.three
      RUBY

      expect_no_offenses(<<~RUBY)
        MyClass.one.two.three
      RUBY
    end
  end

  context "with a partially expanded method chain" do
    it "registers an offense" do
      expect_offense(<<~RUBY)
        one.two
        ^^^^^^^ Break out each method in a chain onto its own line
           .three
      RUBY

      expect_offense(<<~RUBY)
        MyClass.one
        ^^^^^^^ Break out each method in a chain onto its own line
               .two
      RUBY
    end
  end

  context "with a fully expanded method chain" do
    it "registers no offenses" do
      expect_no_offenses(<<~RUBY)
        one
          .two
          .three
      RUBY

      expect_no_offenses(<<~RUBY)
        MyClass.one
               .two
      RUBY
    end
  end
end
