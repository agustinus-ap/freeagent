module FreeAgent

  # Represents a Contact in FreeAgent.
  #
  # @attr [String] first_name
  # @attr [String] last_name
  # @attr [String] organisation_name
  #
  class Contact < Base

    # == Methods
    #
    # * .all
    # * .first
    # * .last
    # * .find(id)
    # * .new
    # * .create
    #
    # * #save
    # * #update
    # * #destroy
    #
    # == Relationships
    #
    # - has_many :bills
    # - has_many :estimates
    # - has_many :projects
    # has_many :invoices


    validates_presence_of :first_name, :unless => :organisation_name?
    validates_presence_of :last_name,  :unless => :organisation_name?
    validates_presence_of :organisation_name, :unless => :name?

    schema do
      attribute :first_name,        :string
      attribute :last_name,         :string
      attribute :organisation_name, :string
    end


    # Creates the name of the contact,
    # composed by the interpolation of {#first_name} and {#last_name}.
    #
    # @return [String,nil] The Contact name.
    def name
      attrs = [first_name, last_name].reject(&:blank?)
      attrs.empty? ? nil : attrs.join(" ")
    end

    alias :name? :name


    # Gets all the invoices associated to this contact.
    #
    # @overload invoices(options = {})
    #   Gets all the invoices for this contact.
    #   @param [Hash] options Hash of options to customize the finder behavior.
    #   @return [Array<FreeAgent::Invoice>]
    #
    # @example Simple query
    #   contact.invoices
    #   # => [...]
    # @example Query with custom find params
    #   contact.invoices(:params => { :foo => 'bar' }
    #   # => [...]
    #
    def invoices(*args)
      options = args.extract_options!
      Invoice.all(options.merge!(:from => "/contacts/#{id}/invoices.xml"))
    end
  end

end
