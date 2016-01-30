require "./lib/menu"

class Takeaway

attr_reader :order, :bill

	def initialize
	@menu = Menu.new
	@dishes = @menu.dishes
	@order = []
	@bill = 0
	end

	def list_menu
	puts print_menu
	end

	def select_item(item, amount=1)
	amount.times {@order << item} 
	sum_total
	"you added #{amount} #{item} to your basket"
	end

	def total	
	"Total cost\: £#{bill}"
	end

	def order_summary
    "Your order summary is:\n#{subtotal_of_items}\n Total cost: £#{bill}"
	end


	def place_order(amount)
	print @bill
	raise "payment does not match total price, please try again" if incorrect_total(amount)
	"Thank you! Your order was placed and will be delivered before #{one_hours_time}"
	end


private

def sum_total
@bill = 0
temp = @order.dup
temp.each do |item|
	 		@dishes.select do |k,v| 
	 		@bill += v	if k == item
			end
		end
	 end
@bill
end

def subtotal_of_items
items = ""
subtotal = 0
duplicates = Hash.new(0)
    @order.each do |dish|
 	duplicates[dish] += 1
 	end	
 	duplicates.each do |k, v|
 		if items.empty?
 		subtotal+=(@dishes[k] * v)
  		items << " #{v} x #{k}, £#{subtotal}\n"
  		else
  		subtotal = 0
  		subtotal+=(@dishes[k] * v)
  		items << " #{v} x #{k}, £#{subtotal}\n" 
  		end	
	end
	items.chomp
end


def incorrect_total(amount)
	amount != bill
end

def one_hours_time
	time = Time.new + 60 * 60	
	time.strftime("%H:%M")
end

def print_menu
pretty_menu = ""
@dishes.each {|k,v| pretty_menu += "Dish: #{k}, Price: £#{v}\n"} 
pretty_menu.chomp
end


# def select_item(item, amount=1)
# 		selection = @dishes.select {|k,v| k == item}
# 		@order.merge!(selection)
# 		"you added #{amount} #{item} to your basket"
# 	end