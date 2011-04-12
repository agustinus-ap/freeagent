require 'mimic'

def fixture(*path)
  File.read(File.join(SPEC_ROOT, 'fixtures', *path))
end

Mimic.mimic do

  use Rack::Auth::Basic do |username, password|
    username == 'email@example.com' and password == 'letmein'
  end

  get('/attachments.xml').returning       fixture('attachments/all.xml')
  get('/attachments/1.xml').returning     "", 404
  get('/attachments/2.xml').returning     fixture('attachments/single.xml')

  get('/bank_accounts.xml').returning     fixture('bank_accounts/all.xml')
  get('/bank_accounts/1.xml').returning   "", 404
  get('/bank_accounts/2.xml').returning   fixture('bank_accounts/single.xml')

  get('/bills.xml') do
    return [400, {}, []] unless params[:period]

    [200, {}, fixture('bills/all.xml')]
  end
  get('/bills/1.xml').returning           "", 404
  get('/bills/2.xml').returning           fixture('bills/single.xml')

  get('/contacts.xml').returning          fixture('contacts/all.xml')
  get('/contacts/1.xml').returning        "", 404
  get('/contacts/2.xml').returning        fixture('contacts/single.xml')

  get('/invoices.xml').returning          fixture('invoices/all.xml')
  get('/invoices/1.xml').returning        "", 404
  get('/invoices/1/*').returning          "", 404
  get('/invoices/2.xml').returning        fixture('invoices/single.xml')
  get('/invoices/2/invoice_items.xml').returning      fixture('invoice_items/all.xml')
  get('/invoices/2/invoice_items/1.xml').returning    "", 404
  get('/invoices/2/invoice_items/2.xml').returning    fixture('invoice_items/single.xml')

  get('/projects.xml').returning                      fixture('projects/all.xml')
  get('/projects/1.xml').returning                    "", 404
  get('/projects/1/*').returning                      "", 404
  get('/projects/2.xml').returning                    fixture('projects/single.xml')
  get('/projects/2/invoices.xml').returning           fixture('projects/invoices.xml')
  get('/projects/2/tasks.xml').returning              fixture('projects/tasks.xml')
  get('/projects/2/tasks/1.xml').returning            "", 404
  get('/projects/2/tasks/2.xml').returning            fixture('tasks/single.xml')
end
