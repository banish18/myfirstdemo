 $.ajax({
				url: 'deletePreserv',
				type: 'POST',
				data: {_token: token,id:id},
				dataType: 'JSON',
				success: function (data) {
					swal("Deleted!", "Your imaginary Record has been deleted.", "success");
					location.reload(true);
				}
			});