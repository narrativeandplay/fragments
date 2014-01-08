# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window['stories#show'] = (data) ->
  lighterGrey = '#eee'
  $(document.body).css('background', lighterGrey)
  $('#error_explanation').hide()
  
  radius = 10

  tree = d3.layout.tree().sort(null).size([848, 480])
  
  nodes = tree.nodes(gon.fragments)
  
  links = tree.links(nodes)
  
  color = d3.scale.category20()
  
  svg = d3.select("#story-tree").append("svg").attr("width", 1366).attr("height", 768).append("g").attr("transform", "translate(0, #{radius*2})")
  
  diagonal = d3.svg.diagonal()
  
  link = svg.selectAll(".link").data(links).enter().append("path").attr("class", "link").attr("d", diagonal)
  
  circle = svg.selectAll(".circle").data(nodes).enter().append("g").attr("class", "circle right-off-canvas-toggle").each( (d) -> $(this).data('fragment-data', d))
  
  el = circle.append("circle").attr("cx", (d) ->
    d.x
  ).attr("cy", (d) ->
    d.y
  ).attr("r", radius).style("fill", (d) ->
    color d.author_id
  ).style("fill-opacity", 0.8).style("stroke", (d) ->
    color d.author_id
  ).append("title").text((d) ->
    d.name
  )
  
  
  $('.circle').click( ->
    $.ajax(
      url: Routes.story_fragment_path($(this).data('fragmentData').story_id, $(this).data('fragmentData').id)
      success: (data) ->
        $('#fragment-content').empty().append(data.content)
        $('#fragment_parent').val(data.id)
        $('#author').empty().append("<h5>Author: #{data.author_name}</h5>")
      error: (xhr, status, thrownError) ->
        alert(xhr.responseText, status, thrownError);
    )
  )
  
  $('#new_fragment').on('ajax:error', (event, xhr, status, error) ->
    errors = $.parseJSON(xhr.responseText)
    $('#error_explanation').empty().append("<h2>The fragment could not be saved due to the following errors: </h2>");
    $('#error_explanation').append("<ul>");
    for e in errors
      $('#error_explanation').append("<li>#{e}</li>");
    $('#error_explanation').append("</ul>");
    $('#error_explanation').show()
  )
  
  $('#new-fragment-form').on('closed', ->
    $('#error_explanation').hide()
  )
