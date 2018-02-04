function refresh()
{
		var req = new XMLHttpRequest();
		req.onreadystatechange=function() {
			if (req.readyState==4 && req.status==200) {
				var temp = req.responseText;
				document.getElementById('update_temperature').innerText = temp;
				document.getElementById('update_temperature_inline').innerText = temp;
			}
		}
		req.open("GET", './1/temp', true);
		req.send(null);
}
function init()
{
	refresh()
	var int=self.setInterval(function(){refresh()},5000);
}