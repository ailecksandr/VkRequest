require_relative 'lib/vk_request'
require_relative 'lib/status_preparator'

params = VkRequest.form_params({
	:text => StatusPreparator.status(:archive),
	:v => '5.37',
	:access_token => '#'
})

request_params = {
	:url => 'api.vk.com',
	:method => 'status.set',
	:params => params
}

puts VkRequest.perform(request_params)