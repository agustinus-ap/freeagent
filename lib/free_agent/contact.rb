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
    # has_many :bills
    # has_many :estimates
    # has_many :projects
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

  end

end
