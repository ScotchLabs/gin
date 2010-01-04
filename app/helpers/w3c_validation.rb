require 'net/http'
require 'form_post'

def self.filename
  filename
end

def post_input_to_w3c_validator(input)
  @filename = Time.now.to_i.to_s+"contentvalidation.html"
  f = File.new(@filename, "w+")
  f.write(input)
  f.close
  query = MultipartPost.build_form_data(:uploaded_file  => File.new(@filename, 'r'))
  File.delete(@filename)
  Net::HTTP.start('validator.w3.org') do |http|
    http.post2("/check", query, MultipartPost::REQ_HEADER)
  end
end

def valid_response?(w3c_response)
  html = w3c_response.read_body
  html.include? "[Valid]"
end

def w3c_valid?(input)
  input = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\" dir='ltr'>\n<head>\n<title>title!</title>\n<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />\n</head>\n<body>\n#{input}\n</body>\n</html>"
  resp = post_input_to_w3c_validator(input)
  valid_response?(resp)
end

def w3c_output(input)
  input = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\" dir='ltr'>\n<head>\n<title>title</title>\n<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />\n</head>\n<body>\n#{input}\n</body>\n</html>"
  resp = post_input_to_w3c_validator(input)
  html = resp.read_body
  numerrors = html.scan(/\<td\ colspan\=\"2\"\ class\=\"invalid\"\>[\s]+([^\n]+)/)
  valid = valid_response?(resp)
  errortext = ""
  if !valid
    index1 = html.index("<div id=\"result\">")
    index2 = html.index("\n\n\n\n\n\n\n  </div>")
    errortext = html[index1+19..index2-1]
    # now we manipulate errortext
  end
  out = "<valid>#{valid}</valid><numerrors>#{numerrors}</numerrors><errortext>#{errortext}</errortext>"
end

input = "hasdf"
result = w3c_output(input)
puts result