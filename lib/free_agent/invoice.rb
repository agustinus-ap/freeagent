module FreeAgent

  # Represents an Invoice in FreeAgent.
  class Invoice < Base

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
    # * #mark_as_draft
    # * #mark_as_sent
    # * #mark_as_cancelled

    # Marks the current invoice as draft.
    #
    # This method actually performs a new HTTP request
    # to FreeAgent in order to execute the update.
    #
    # @return [void]
    def mark_as_draft
      # put(:mark_as_draft).tap do |response|
      #   load_attributes_from_response(response)
      # end
      put(:mark_as_draft) && reload
    end

    # Marks the current invoice as sent.
    #
    # This method actually performs a new HTTP request
    # to FreeAgent in order to execute the update.
    # It also triggers any automatic deliver if the
    # {#send_new_invoice_emails} invoice attribute is set to true.
    #
    # @return [void]
    def mark_as_sent
      # put(:mark_as_sent).tap do |response|
      #   load_attributes_from_response(response)
      # end
      put(:mark_as_sent) && reload
    end

    # Marks the current invoice as cancelled.
    #
    # This method actually performs a new HTTP request
    # to FreeAgent in order to execute the update.
    #
    # @return [void]
    def mark_as_cancelled
      # put(:mark_as_cancelled).tap do |response|
      #   load_attributes_from_response(response)
      # end
      put(:mark_as_cancelled) && reload
    end

  end

end
