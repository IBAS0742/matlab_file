//tools 
var str = "";
window.onload = function(){
	var c = "102 102 102;102 102 153;102 102 204;102 102 255;102 153 102;102 153 153;102 153 204;102 153 255;102 204 102;102 204 153;102 204 204;102 204 255;102 255 102;102 255 153;102 255 204;102 255 255;153 102 102;153 102 153;153 102 204;153 102 255;153 153 102;153 153 153;153 153 204;153 153 255;153 204 102;153 204 153;153 204 204;153 204 255;153 255 102;153 255 153;153 255 204;153 255 255;204 102 102;204 102 153;204 102 204;204 102 255;204 153 102;204 153 153;204 153 204;204 153 255;204 204 102;204 204 153;204 204 204;204 204 255;204 255 102;204 255 153;204 255 204;204 255 255;255 102 102;255 102 153;255 102 204;255 102 255;255 153 102;255 153 153;255 153 204;255 153 255;255 204 102;255 204 153;255 204 204;255 204 255;255 255 102;255 255 153;255 255 204;255 255 255";
	str = invoke(c);
}

invoke = function(c){
	var str = "";
	c.split(';').forEach(function(i) {
		var str_ = "";
		var str__ = "rgb(";
		i.split(' ').forEach(function(j,k) {
			if (!k) {
				str_ += ((parseFloat(j) / 256));
				str__ += parseFloat(j)
			} else {
				str_ += (" " + (parseFloat(j) / 256));
				str__ += "," + parseFloat(j)
			}
		});
		str += str_ + "\r\n";
		str_ = str_.replace(' ','\r\n');
		str__ += ")";
		document.body.appendChild(createDiv(str_.replace(' ','\r\n'),str__));
	});
	return str;
}

createDiv = function(text_,color_) {
	var ele = document.createElement("div");
	ele.style.float = "left";
	ele.style.border = "1px solid " + color_;
	ele.style.borderRadius = "20";
	ele.style.width = "150px";
	ele.style.height = "60px";
	ele.innerText = text_;
	ele.style.background = color_;
	ele.style.padding = "0px 2px";
	return ele;
}
