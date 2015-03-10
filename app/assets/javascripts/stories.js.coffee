# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window['stories#new'] = (data) ->
  $('#intensity-slider').on 'change.fdntn.slider', ->
    $('#story_fragment_intensity').val($('#intensity-slider').attr('data-slider'))

  $('#story_fragment_intensity').on 'input', ->
    new_val = parseInt($(this).val())
    $('#intensity-slider').foundation('slider', 'set_value', new_val)

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
  
  circle = svg.selectAll(".circle").data(nodes).enter().append("g").attr("class", (d) ->
    "circle right-off-canvas-toggle intensity-#{d.intensity}"
  )

  circle.each( (d) -> $(this).data('fragment-data', d))
  
  el = circle.append("circle").attr("cx", (d) ->
    d.x
  ).attr("cy", (d) ->
    d.y
  ).attr("r", radius).style("fill", (d) ->
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

  $('#edit-fragment-form').on('closed', ->
    $('#error_explanation').remove()
  )
