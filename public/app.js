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
alert('Added to shopping-cart, product_Id: ' + id + '.\nTotal:\n' + cart_contains());
}
