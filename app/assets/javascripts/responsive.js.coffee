$ ->

    $('#home-menu ul a').on 'click', ->
      $('#home-menu ul').toggle(500);
      $('#logo').toggleClass('open');
