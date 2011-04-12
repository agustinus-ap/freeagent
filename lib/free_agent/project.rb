module FreeAgent

  # Represents a Project in FreeAgent.
  class Project < Base

    # Gets all the invoices associated to this project.
    #
    # @overload invoices(options = {})
    #   Gets all the invoices for this project.
    #   @param [Hash] options Hash of options to customize the finder behavior.
    #   @return [Array<FreeAgent::Invoice>]
    #
    # @example Simple query
    #   project.invoices
    #   # => [...]
    # @example Query with custom find params
    #   project.invoices(:params => { :foo => 'bar' }
    #   # => [...]
    #
    def invoices(*args)
      options = args.extract_options!
      Invoice.all(options.merge!(:from => "/projects/#{id}/invoices.xml"))
    end

  end

end
