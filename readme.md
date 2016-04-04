# VK Requests

### You can send requests to VK API easily:
Install `unirest` by command in console:
```shell
   gem install unirest
```
---
Require main module by adding:
```ruby
   require_relative 'lib/vk_request'
```
---
Generate link to receive the token for requests (permissions can be changed in token.rb):
```shell
   ./token.sh
```
---
Form request params as is needed (VK API Official Documentation). Example:
```ruby
   params = VkRequest.form_params({
   	:user_id => '88005553535',
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
```
---
Send request to VK API:
```ruby
   # first parameter is hash with previously formed params
   # second parameter - receive response_body or just status of response?
   friends = VkRequest.perform(request_params, true)      
```
