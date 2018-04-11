class OpenEpic::Patient

  def initialize(fhir_client)
    @client = fhir_client
  end


  def id
    @id ||= @client.client.params['patient']
  end


  def method_missing(m, *args, &block)
    if m.to_s.start_with?('search')
      search(m.to_s[7..-1], args)
    else
      Object.method_missing(m, args, block)
    end
  end


  def search(name, args=[])
    byebug
    klass = ('FHIR::' + name.camelize).constantize
    #TODO: add error handling

    @client.search(klass, search: {
      parameters: {
        patient: id
      }.merge(args.first || {})
    })
  end

end