function cart_contains()
{
	var x="";
	for (var i = 0; i < localStorage.length; i++)
	{
		//$('body').append(localStorage.getItem(localStorage.key(i)));
		x= x + (localStorage.key(i)) + " - " + localStorage.getItem(localStorage.key(i)) + "\n";
	}
return (x);
}

function add_to_cart(id)
{
var key= 'product_' + id;
var x=window.localStorage.getItem(key)
x=x*1+1;
window.localStorage.setItem(key, x);
//alert('Added to shopping-cart, product_Id: ' + id + '.\nTotal:\n' + cart_contains());
update_orders();
update_button();
}

function update_orders()
{
	var orders = get_orders();
	$('#orders_input').val(orders);
}


function get_orders()
{
	var x="";
	for (var i = 0; i < localStorage.length; i++)
	{
		x= x + (localStorage.key(i)) + "=" + localStorage.getItem(localStorage.key(i)) + ",";
	}
return (x);
}

function get_orders_number()
{
	var x=0;
	for (var i = 0; i < localStorage.length; i++)
	{
		x= x + localStorage.getItem(localStorage.key(i))*1;
	}
return (x);
}

function update_button()
{
	var str="Shopping cart (" + get_orders_number() + ")"
	$('#orders_button').val(str);
}

function clear_cart()
{
	localStorage.clear();
}