loadBooks = function() {
	$.ajax({
 		type: "GET",
 		url: "/books",
 		dataType: "json",
 		success: function(result){
     	var data = result.books;
     	console.log(data);
   		$.each(data, function (i, item) {
     		var row = '<tr id="book'+item.id+'" ><td> ' + item.name + ' </td> <td> ' + item.author + ' </td> <td>' + item.price + '</td><td><button class="button show" onclick="show('+item.id+')">Show</button></td><td><button class="button edit" onclick="edit('+item.id+')">Edit</button></td><td><button class="button delete" onclick="destroy('+item.id+')">Delete</button></td> </tr>';
     		$("#list").append(row);
   		});
 		}
	});
}
destroy = function(id){
	if(confirm("are you sure!")){
		$.ajax({
			type: "DELETE",
			url: "/books/"+id,
			dataType: "json",
			success: function(result){
				$("#book"+id).remove();
			}
		});
	};
}
show = function(id){
	window.open("/books/"+id,"_self")
}
edit = function(id){
	window.open("/books/"+id+"/edit","_self")
}