module Helper

  # Gets the currently described class.
  # Conversely to +subject+, it returns the class
  # instead of an instance.
  def klass
    described_class
  end

end

RSpec.configure do |config|
  config.include Helper
end

def fixture(*path)
  File.read(File.join(SPEC_ROOT, 'fixtures', *path))
end
