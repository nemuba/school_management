//= require active_admin/base
//= require activeadmin_addons/all
//= require active_admin/inputmask
//= require activeadmin/quill_editor/quill
//= require activeadmin/quill_editor_input
//= require index_as_calendar/application
//= require index_as_calendar/jquery.qtip.min
//= require fullcalendar/dist/locale/pt-br

document.addEventListener('DOMContentLoaded', () => {
    const $c = document.getElementById("calendar").children;
    $c[0].innerHTML = "Calendário";

});