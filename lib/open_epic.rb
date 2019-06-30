require 'fhir_client'
require 'oauth2'
require 'open_epic/patient'

class OpenEpic

  attr_reader :oauth2_token
  attr_reader :client


  def initialize(fhir_base_url, client_id, options={})
    @client_id    = client_id

    @client       = FHIR::Client.new(fhir_base_url)

    oauth_urls    = @client.get_oauth2_metadata_from_conformance
    #TODO: add error handling

    @options      = {
      :authorize_url  => oauth_urls[:authorize_url],
      :token_url      => oauth_urls[:token_url],
      :redirect_uri   => 'http://localhost:3000/oauth2/callback',
    }.merge(options)
  end


  def test_method()
     first = 1
     second = 2
  end

  def authorize_url
    oauth2_client.auth_code.authorize_url
  end



  def get_token(code)
    @oauth2_token = oauth2_client.auth_code.get_token(code)
    #TODO: add error handling

    configure_fhir_client(@oauth2_token)

    return @oauth2_token.token
  end



  def patient
    OpenEpic::Patient.new(@client)
  end

  def restore_oauth2_token(data)
    @oauth2_token = OAuth2::AccessToken.from_hash(oauth2_client, data)

    configure_fhir_client(@oauth2_token)
  end

  private



  def oauth2_client
    @oauth2_client ||= OAuth2::Client.new(@client_id, nil, @options)
  end


  def configure_fhir_client(oauth2_token)
    @client.use_oauth2_auth = true
    @client.use_basic_auth  = false

    @client.client = oauth2_token
  end


end
