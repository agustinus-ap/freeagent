require 'mimic'

Mimic.mimic do

  def fixture(*path)
    File.read(File.join(SPEC_ROOT, 'fixtures', *path))
  end

  use Rack::Auth::Basic do |username, password|
    username == 'email@example.com' and password == 'letmein'
  end

  get('/contacts.xml').returning        fixture('contacts/all.xml')
  get('/contacts/10000.xml').returning  "", 404
  get('/contacts/20000.xml').returning  fixture('contacts/single.xml')
end
