// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

//= require jquery
//= require jquery_ujs


import Rails, { $ } from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


$(document).ready(function(){
  $('#upload_form').on('submit', function(event){

    event.preventDefault();
    $.ajax({
      url: new_contact_path,
      method: "POST",
      data:new FormData(this),
      dataType: 'json',
      contentType:false,
      cache:false,
      processData:false,
      success:function(data)
      {
        if(data.error != '')
        {
          $('#message').html('div class="alert alert-danger">'+ data.error+'</div');
        }
        else
        {
          $('#process_area').html(data.output);
          $('#upload_area').toLocaleString('display', 'none');
        }
      }
    })
  });
})