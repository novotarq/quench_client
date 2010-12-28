require File.join(File.dirname(__FILE__), "quench_client", "panthera")

module QuenchClient
  
  class << self

    @@base ||= Panthera.new

    def application_key
      @@base.application_key
    end
    
    def application_id
      @@base.application_id
    end
    
    def base_url
      @@base.base_uri
    end
        
    def query(method, resource, params, data)
      @@base.query(method, resource, params, data).parsed_response
    end
    
    def load_options(options={})
      @@base = Panthera.new options
      self
    end
    
    def search(query='')
      self.query('get', '/globalsearch', {:q =>query}, nil)
    end   
    
    def get_stores
      self.query('get', '/store', {}, nil)['stores']
    end 
    
    def get_store(id)
      self.query('get', '/store/' + id.to_s, {}, nil)
    end

    def get_categories
      self.query('get', '/category', {}, nil)['categories']
    end

    def get_category(id)
      self.query('get', '/category/' + id.to_s, {}, nil)
    end

    def get_root_categories
      self.get_category(0)['categories']
    end
    
    def get_product_data(id)
      self.query('get', '/product/' + id.to_s + '/data', {}, nil)
    end

    def get_product(id)
      self.query('get', '/product/' + id.to_s, {}, nil)
    end

    def get_products
      self.query('get', '/product/', {}, nil)
    end

    def get_products(id)
      self.query('get', '/product/' + id.to_s, {}, nil)
    end
    
    def get_products_with_stores(id)
      self.query('get', '/product/' + id.to_s, {:showstores => '1'}, nil)
    end
    
    def get_category_products(id)
      self.query('get', '/category/' + id.to_s + '/products', {}, nil)
    end

    def get_store_redirect(id)
      self.query('get', '/store/' + id.to_s + '/redirect', {}, nil)
    end
    
    def get_product_redirect(id, feed_entry_id)
      options = {:id => feed_entry_id}
      self.query('get', '/product/' + id.to_s + '/redirect', options, nil)
    end

    def update_stores(site_ids = {}, active_stores = nil)
      options = {}
      site_ids.each do |network_id, site_id|
        options[:site_id[network_id.to_sym]] = site_id
      end
      options[:activestores] = active_stores
      
      self.query('post', '/store/', options, nil)
    end
    
    def get_search_result(query, id, sort, page, lp = nil, up = nil, manufacturer = nil, fields = {})
      options = {}
      options[:q] = query
      options[:id] = id
      options[:s] = sort
      options[:pg] = page
      fields.each do |k, v|
        options["field_" + k] = v
      end
      unless (lp.nil? || up.nil?)
        options[:lp] = lp
        options[:up] = up
      end
      options[:manufacturer] = manufacturer unless manufacturer.nil?
      self.query('get', '/search', options, nil)
    end

  end

end