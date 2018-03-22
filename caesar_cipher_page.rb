require 'sinatra'
if development? require 'sinatra/reloader'

get '/' do
  raw_text = params["raw"]
  shift = params["shift"]
  erb :index, :locals => {:input => raw_text, :shift=> shift, :message => caesar_cipher(raw_text, shift)}
end

def caesar_cipher(raw_text, shift)
  if raw_text == nil
    return "Submit a phrase to cipher"
  end
  if shift == nil
    shift = 0
  end
  letterize = raw_text.split('')
  ciphered_text = []
  shift = shift.to_i
  letterize.each do |a|
    if a.ord.between?(65, 90) || a.ord.between?(97, 122)
      cipher = a.ord + shift
      if a.ord.between?(65, 90) && cipher > 90
        cipher = (a.ord - 26) + shift
      end
      if a.ord.between?(97, 122) && cipher > 122
        cipher = (a.ord - 26) + shift
      end
    else
      cipher = a.ord
    end
    ciphered_text << cipher.chr
  end
  ciphered_text.join("")
end