require_relative 'lib/vk_request'

permissions = %w(offline status messages audio)

params = VkRequest.form_params({
	:client_id => 5243944,
	:display => 'page',
	:redirect_uri => 'https://oauth.vk.com/blank.html',
	:scope => VkRequest.form_permissions(permissions),
	:response_type => 'token',
	:v => 5.37
})

request_params = {
	:url => 'oauth.vk.com/authorize',
	:params => params
}

puts VkRequest.link(request_params)