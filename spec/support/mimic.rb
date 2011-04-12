require 'mimic'

Mimic.mimic do

  def fixture(*path)
    File.read(File.join(SPEC_ROOT, 'fixtures', *path))
  end

  use Rack::Auth::Basic do |username, password|
    username == 'email@example.com' and password == 'letmein'
  end

  get('/contacts.xml').returning        fixture('contacts/all.xml')
  get('/contacts/1.xml').returning      "", 404
  get('/contacts/2.xml').returning      fixture('contacts/single.xml')

  get('/invoices.xml').returning        fixture('invoices/all.xml')
  get('/invoices/1.xml').returning      "", 404
  get('/invoices/2.xml').returning      fixture('invoices/single.xml')
end
