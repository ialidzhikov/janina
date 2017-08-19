$('#delete-modal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget),
      name = button.data('name'),
      id = button.data('id'),
      modal = $(this);

  modal.find('.task-name').text(name);
  modal.find('#confirm-form').attr('action', '/tasks/' + id);
});
