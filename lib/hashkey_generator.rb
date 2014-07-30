require 'digest/sha1'

module HashkeyGenerator
  # create a string representation of passed hash, which can be encoded in a URL
  def concat_params(params)
    result = ""
    return result if params.empty?
    params.map{|key,val| result += "#{key}=#{val}&" unless val.nil? or val == ''}
    result.chomp!('&')
  end

  # sort the parameters in alphabetical order of keys
  def sort_params(params)
    Hash[params.sort]
  end

  # Generate a hashkey using SHA1 for a provided API key
  # List of parameters
  # *params : a list of parameters as a hash, that needs to be used for hashkey generation
  # *api_key: a unique API key provided to you for authenticating the API calls
  def generate_hashkey_for(params, api_key)
    sorted_params = sort_params(params)
    params_string = concat_params(sorted_params)
    Digest::SHA1.hexdigest "#{params_string}&#{api_key}"
  end
end
