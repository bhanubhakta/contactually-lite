jQuery(document).ready(function() {
  // Set up datatable.
  var table = $('#users-table').dataTable({
    "processing": true,
    "serverSide": true,
    "sAjaxSource": $('#users-table').data('source'),
    "pagingType": "full_numbers",
    "language": {
      "searchPlaceholder": "enter .com to filter .com address"
    },
    "language": {
      "search": "Type .com to filter email address with .com"
    },
    // Add extra column for delete action.
    "aoColumnDefs": [
    {
      "bSortable": false,
      "aTargets": [5],
      "mData": null,
      "mRender": function (data, type, full) {
        return '<button type="button" class="btn btn-danger delete_record" data-id='+data[5]+'>Delete</button>';
      }
    }
    ]
  });

  // Send csrf token.
  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });

  // Handle deletion of record.
  $(document).on('click', '.delete_record', function(evt) {
    var $this = $(this);
    var url = '/contacts/'+$('.delete_record').data().id;
    $.ajax({
      url: url,
      method: 'delete',
      context: document.body
    }).done(function() {
      table.api().draw();
    });
  });
});