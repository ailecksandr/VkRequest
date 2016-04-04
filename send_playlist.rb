require_relative 'lib/vk_request'

params = VkRequest.form_params({
	:user_id => 20175378,
	:access_token => '#',
	:v => '5.37'
})

request_params = {
	:url => 'api.vk.com',
	:method => 'audio.get',
	:params => params
}

response = VkRequest.perform(request_params, true)

data = response.map{ |key, value| value['items'].map{|v| {
			id: v['id'],
			artist: v['artist'],
      title: v['title']
		}
	}
}.first

File.open("#{File.dirname(__FILE__)}/audios.json", 'w+'){|file| file.write(JSON.pretty_generate(data)) }

data = File.exist?("#{File.dirname(__FILE__)}/audios.json") ? JSON.parse( File.read("#{File.dirname(__FILE__)}/audios.json") ) : [{}]

data.each do |value|
	id = value["id"]
	artist = value["artist"]
  title = value["title"]
  user_id = 160070806

	params = VkRequest.form_params({
			:user_id => user_id,
			:title => VkRequest.to_ahcii!(artist),
			:message => VkRequest.to_ahcii!(title),
			:access_token => '#',
			:v => '5.37',
			:attachment => VkRequest.attachment(:audio, user_id, id)
	})

	request_params = {
			:url => 'api.vk.com',
			:method => 'messages.send',
			:params => params
	}
	VkRequest.perform(request_params, true)

  sleep(5)
end
