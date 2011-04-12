module FreeAgent

  # Represents an Attachment in FreeAgent.
  #
  # == Attachment URL
  #
  # FreeAgent stores attachments on Amazon S3. The real attachment URL
  # is stored in the {Attachment#location} attribute.
  #
  #   a = FreeAgent::Attachment.first
  #   a.location
  #   # => "https://s3.amazonaws.com/freeagent-prod/attachments/165002/original.pdf"
  #
  # Attachments stored on Amazon S3 are private. For this reason,
  # the location returned by FreeAgent contains an amazon AWSAccessKeyId and Signature
  # that allows you to access the content for a limited set of time.
  #
  class Attachment < Base
  end

end
