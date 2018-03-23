function create(name,address,phone_no){
	var library = { "library":{"name":name,"address":address,"phone_no":phone_no}};
	$.ajax({
		type: "POST",
		url: "/libraries/",
		data: library,
		dataType: "json",
		success: function(result){
			console.log(result);
			window.open("/libraries","_self")
		}
	});
}