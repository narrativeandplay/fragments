# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window['stories#show'] = (data) ->
  lighterGrey = '#eee'
  $(document.body).css('background', lighterGrey)
  
  radius = 10

  tree = d3.layout.tree().sort(null).size([848, 480])
  
  nodes = tree.nodes(gon.fragments)
  
  links = tree.links(nodes)
  
  color = d3.scale.category20()
  
  svg = d3.select("#story-tree").append("svg").attr("width", 1366).attr("height", 768).append("g").attr("transform", "translate(0, #{radius*2})")
  
  diagonal = d3.svg.diagonal()
  
  link = svg.selectAll(".link").data(links).enter().append("path").attr("class", "link").attr("d", diagonal)
  
  circle = svg.selectAll(".circle").data(nodes).enter().append("g").attr("class", "circle right-off-canvas-toggle")

  circle.each( (d) -> $(this).data('fragment-data', d))
  
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
    story_id = $(this).data('fragment-data').story_id
    fragment_id = $(this).data('fragment-data').id
    $.ajax(
      url: Routes.story_fragment_path(story_id, fragment_id)
      error: (xhr, status, thrownError) ->
        console.log(xhr.responseText, status, thrownError);
    )
  )
  
  $('#new-fragment-form').on('closed', ->
    $('#error_explanation').remove()
  )
