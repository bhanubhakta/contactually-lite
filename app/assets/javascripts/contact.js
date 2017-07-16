jQuery(document).ready(function() {
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
    "aoColumnDefs": [
    {
      "aTargets": [5],
      "mData": null,
      "mRender": function (data, type, full) {
        return '<button type="button" class="btn btn-danger delete_record" data-id='+data[5]+'>Delete</button>';
      }
    }
    ]
  });
});