require 'mimic'

Mimic.mimic do

  use Rack::Auth::Basic do |username, password|
    username == 'email@example.com' and password == 'letmein'
  end

  get('/attachments.xml').returning       fixture('attachments/all.xml')
  get('/attachments/1.xml').returning     "", 404
  get('/attachments/2.xml').returning     fixture('attachments/single.xml')

  get('/bank_accounts.xml').returning         fixture('bank_accounts/all.xml')
  get('/bank_accounts/1.xml').returning       "", 404
  get('/bank_accounts/84192.xml').returning   fixture('bank_accounts/single.xml')

  get('/bills.xml') do
    return [400, {}, []] unless params[:period]

    [200, {}, fixture('bills/all.xml')]
  end
  get('/bills/1.xml').returning           "", 404
  get('/bills/2.xml').returning           fixture('bills/single.xml')

  get('/contacts.xml').returning fixture('contacts/all.xml')
  get('/contacts/1.xml').returning "", 404
  get('/contacts/447693.xml').returning fixture('contacts/single.xml')
  get('/contacts/1/invoices.xml').returning "", 404
  get('/contacts/469012/invoices.xml').returning fixture('contacts/invoices.xml')

  get('/invoices.xml').
      returning fixture('invoices/all.xml')
  get('/invoices/1.xml').
      returning "", 404
  get('/invoices/1/*').
      returning "", 404
  get('/invoices/2715138.xml').
      returning fixture('invoices/single.xml')

  get('/invoices/2/invoice_items.xml').
      returning fixture('invoice_items/all.xml')
  get('/invoices/2/invoice_items/1.xml').
      returning "", 404
  get('/invoices/2/invoice_items/2.xml').
      returning fixture('invoice_items/single.xml')

  put('/invoices/2715138/mark_as_draft.xml').
      returning "", 200
  put('/invoices/2715138/mark_as_sent.xml').
      returning "", 200
  put('/invoices/2715138/mark_as_cancelled.xml').
      returning "", 200

  get('/projects.xml').returning                      fixture('projects/all.xml')
  get('/projects/1.xml').returning                    "", 404
  get('/projects/1/*').returning                      "", 404
  get('/projects/2.xml').returning                    fixture('projects/single.xml')
  get('/projects/2/invoices.xml').returning           fixture('projects/invoices.xml')
  get('/projects/2/tasks.xml').returning              fixture('projects/tasks.xml')
  get('/projects/2/tasks/1.xml').returning            "", 404
  get('/projects/2/tasks/2.xml').returning            fixture('tasks/single.xml')
end
