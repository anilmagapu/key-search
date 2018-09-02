class SearchesController < ApplicationController
 def index
 end 
 def find_number
    
  if params["phone_number"] =="" 
    @contacts =  Contact.all  
    #@contacts_list = @contacts.pluck(:name,:number) if @contacts.present?
  else
   	tokens = [[],[],["a","b","c"],["d","e","f"],["g","h","i"],["j","k","l"],["m","n","o"],["p","q","r","s"],["t","u","v"],["w","x","y","z"]]
   	a = params["phone_number"].each_char.map(&:to_i)
  	a = a.length>0 ? a[0,4] : a
    string_tokens = a.map { |i| tokens[i] }
  	combination_strings = array_permutations string_tokens.reject { |c| c.empty? }
  	query = combination_strings.map! { |word| "name like '%#{word}%' or " }
  	query.last.slice! "or"
  	query = query.join()
    @contacts =  Contact.where("number like '%#{params['phone_number']}%' or #{query}")	
  end
    @contacts_list = @contacts.pluck(:name,:number) if @contacts.present?
  respond_to do |format|
    format.json { render json: @contacts_list.to_json }
  end
 end
 def array_permutations array, index=0
  result = []
  if index == array.size
    result << ""
    return result
  end
  array[index].each do |element|
    array_permutations(array, index + 1).each do |x|
      result << "#{element}#{x}"
    end
  end
  result.map! { |string| string.strip }
  #puts result.inspect
  return result
end
 	
end
