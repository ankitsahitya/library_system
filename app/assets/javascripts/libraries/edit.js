editLibrary = function(){
	$.ajax({
		type: "GET",
		url: window.location.href,
		dataType: "json",
		success: function(result){
			var data = result.library
			$("#libraryId").val(data.id);
			$("#libraryName").val(data.name);
			$("#address").val(data.address);
			$("#phoneNo").val(data.phone_no);
		}
	});
}
update = function(name,address,phone_no,id){
	console.log(id);
	var library = { "library":{"name":name,"address":address,"phone_no":phone_no}};
	$.ajax({
		type: "PUT",
		url: "/libraries/"+id,
		data: library,
		dataType: "json",
		success: function(result){
			window.open("/libraries","_self");
		}
	});
}