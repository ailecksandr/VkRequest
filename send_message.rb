require_relative 'lib/vk_request'

params = VkRequest.form_params({
	:user_id => 20175378,
	:order => 'hints',
	:count => 10,
	:access_token => '#',
	:v => '5.37'
})

request_params = {
	:url => 'api.vk.com',
	:method => 'friends.get',
	:params => params
}

friends = VkRequest.perform(request_params, true).map{|key, value| value['items'] }.first

params = VkRequest.form_params({
	:user_id => 160070806,
	:title => VkRequest.to_ahcii!("attention! very important message!"),
	:message => VkRequest.to_ahcii!("kek"),
	:access_token => '#',
	:v => '5.37',
})

request_params = {
	:url => 'api.vk.com',
	:method => 'messages.send',
	:params => params
}

puts VkRequest.perform(request_params)
