loadLibraries = function() {
	$.ajax({
 		type: "GET",
 		url: "/libraries",
 		dataType: "json",
 		success: function(result){
     	var data = result.libraries;
   		$.each(data, function (i, item) {
     		var row = '<tr id="library'+item.id+'" ><td> ' + item.name + ' </td> <td> ' + item.address + ' </td> <td>' + item.phone_no + '</td><td><button class="button show" onclick="show('+item.id+')">Show</button></td><td><button class="button edit" onclick="edit('+item.id+')">Edit</button></td><td><button class="button delete" onclick="destroy('+item.id+')">Delete</button></td> </tr>';
     		$("#list").append(row);
   		});
 		}
	});
}
destroy = function(id){
	if(confirm("are you sure!")){
		$.ajax({
			type: "DELETE",
			url: "/libraries/"+id,
			dataType: "json",
			success: function(result){
				$("#library"+id).remove();
			}
		});
	};
}
openForm = function(){
	window.open("/libraries/new","_self")
}
show = function(id){
	window.open("/libraries/"+id,"_self")
}
edit = function(id){
	window.open("/libraries/"+id+"/edit","_self")
}