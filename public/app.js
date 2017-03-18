//using product id (taken from button) as a key, increase the corresponding value by 1
function add_to_cart(id)
{
	var key= 'product_' + id;
	var x=window.localStorage.getItem(key)
	x=x*1+1;
	window.localStorage.setItem(key, x);
	update_orders();
	update_button();
}

//get order data from localstorage and out into string like "product_1=2,...product_n=x,"
function get_orders()
{
	var x="";
	for (var i = 0; i < localStorage.length; i++)
	{
		x= x + (localStorage.key(i)) + "=" + localStorage.getItem(localStorage.key(i)) + ",";
	}
return (x);
}
//count quantity of products chosen
function get_orders_number()
{
	var x=0;
	for (var i = 0; i < localStorage.length; i++)
	{
		x= x + localStorage.getItem(localStorage.key(i))*1;
	}
return (x);
}
//put order details into field of the form
function update_orders()
{
	var orders = get_orders();
	$('.orders_input').val(orders);
}
//put number of orders into text of a shopping-cart button
function update_button()
{
	var str="Shopping-cart (" + get_orders_number() + ")"
	$('#orders_button').val(str);
}
//clear shopping-cart (called on order submit)
function clear_cart()
{
	localStorage.clear();
}