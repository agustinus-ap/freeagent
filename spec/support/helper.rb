module Helper

  # Gets the currently described class.
  # Conversely to +subject+, it returns the class
  # instead of an instance.
  def klass
    described_class
  end

  def fixture(*name)
    File.join(SPEC_ROOT, "fixtures", *name)
  end

end

RSpec.configure do |config|
  config.include Helper
end
