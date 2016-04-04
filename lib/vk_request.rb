require 'unirest'

module VkRequest
	def self.perform(request_params, response_body = nil)
		link = link(request_params)
		response = Unirest.post link
		response_body ? response.body : response.code
	end

	def self.link(request_params)
		url = request_params[:url]
		method = request_params[:method]
		params = request_params[:params]
		url ? "https://#{url}#{ "/method/#{method}" if method }#{ "?#{params}" if params }" : '#'
	end

	## Form params for link
	def self.form_params(hash = nil)
		hash.map{|key, value| "#{key}=#{value}"}.join('&')
	end

	## Form permissions for link
	def self.form_permissions(params = [])
		params.join(',')
	end

	## Form attachment for link
	def self.attachment(type, owner_id, at_id)
		"#{type}#{owner_id}_#{at_id}"
	end

	def self.to_ahcii!(text)
		URI.escape text
	end
end
