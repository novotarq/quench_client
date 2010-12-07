require 'httparty'
module QuenchClient
  class Panthera
    include HTTParty
    format :json
    
    attr_accessor :base_url
    attr_accessor :application_id
    attr_accessor :application_key
    
    def initialize(options = {})
      options[:base_url] ? @base_url = options[:base_url] : @base_url = 'http://panthera-api.quenchnetworks.net'
      options[:application_id] ? @application_id = options[:application_id] : @application_id = '2'
      options[:application_key] ? @application_key = options[:application_key] : @application_key = 'f7da7c578fa0c4de7b5e37fa7e5018bb'
      self.class.send(:base_uri, @base_url)
    end
    
    def query(method, resource, params = {}, data = nil)
      raise "Use 'post' or 'get' to define query method" unless valid_method method
      options = { :query => normalize_params(params) }
      self.class.send(method, resource, options)
    end
    
    private
    def valid_method(method)
      method == 'post' || method == 'get'
    end

    def normalize_params(params)
      params[:applicationid] = @application_id
      params[:applicationkey] = @application_key
      params
    end
    
  end
end