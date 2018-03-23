showBook = function(){
	$.ajax({
		type: "GET",
		url: window.location.href,
		dataType: "json",
		success: function(result){
			var libraryData = result.library
			$("#library .name").html("Library Name: "+libraryData.name);
			$("#library .address").html("Library address: "+libraryData.address);
			$("#library .phone_no").html("Library phone no: "+libraryData.phone_no);
			$(".libraryId").val(libraryData.id);
			$.ajax({
				type: "GET",
				url: "/books",
				dataType: "json",
				success: function(result){
					var bookData = result.books;
   				$.each(bookData, function (i, item) {
   					if(item.library_id == libraryData.id){
	     				var row = '<tr id="book'+item.id+'" ><td> ' + item.name + ' </td> <td> ' + item.author + ' </td> <td>' + item.price + '</td><td><button class="button show" onclick="showBook('+item.id+')">Show</button></td><td><button class="button delete" onclick="destroyBook('+item.id+')">Delete</button></td> </tr>';
	     				$("#books .list").append(row);
	     			}
   				});
   				$.ajax({
   					type: "GET",
   					url: "/categories",
   					dataType: "json",
   					success: function(result){
   						var categorydata = result.categories;
   						$.each(categorydata, function (i, item){
   							$("#addBooks #category").append("<option value='"+item.id+"'>"+item.name+"</option>");
   						});
   					}
   				});
				}
			});
			$.ajax({
				type: "GET",
				url: "/members",
				dataType: "json",
				success: function(result){
					console.log(result);
					var memberData = result.members;
   				$.each(memberData, function (i, item) {
   					if(item.library_id == libraryData.id){
	     				var row = '<tr id="member'+item.id+'" ><td> ' + item.name + ' </td> <td> ' + item.address + ' </td> <td>' + item.phone_no + '</td><td><button class="button show" onclick="showMember('+item.id+')">Show</button></td><td><button class="button delete" onclick="destroyMember('+item.id+')">Delete</button></td> </tr>';
	     				$("#members .list").append(row);
	     			}
   				});
   			}
   		});
		}
	});
}
createBook = function(id,name,author,price,publication,category,code,version,no_of_copies){
	var book = { "book":{"library_id":id,"name":name,"author":author,"price":price,"publication":publication,"category_id":category,"code":code,"version":version,"no_of_copies":no_of_copies}};
	$.ajax({
		type: "POST",
		url: "/books/",
		data: book,
		dataType: "json",
		success: function(result){
			window.open(window.location.href,"_self");
		}
	});
}
createMember = function(id,name,address,phone_no,gender,code,validity_date,is_author){
	var member = {"member":{"library_id":id,"name":name,"address":address,"phone_no":phone_no,"gender":gender,"code":code,"validity_date":validity_date,"is_author":is_author}};
	$.ajax({
		type: "POST",
		url: "/members/",
		data: member,
		dataType: "json",
		success: function(result){
			console.log(result);
			window.open(window.location.href,"_self");
		}
	});
}
showBook = function(id){
	window.open("/books/"+id,"_self");
}
showMember = function(id){
	window.open("/members/"+id,"_self");
}
destroyBook = function(id){
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
destroyMember = function(id){
	if(confirm("are you sure!")){
		$.ajax({
			type: "DELETE",
			url: "/members/"+id,
			dataType: "json",
			success: function(result){
				$("#member"+id).remove();
			}
		});
	};
}