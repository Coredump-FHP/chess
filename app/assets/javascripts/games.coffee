$ ->

    draggableOptions = 
        revert: 'invalid'
        opacity: .4
        create: ->
            $(this).data 'position', $(this).position()
            return
        cursorAt: left: 15
        cursor: 'move'
        start: ->
            $(this).stop true, true
            return

    snapToMiddle = (dragger, target) ->
        topMove = target.position().top - (dragger.data('position').top) + (target.outerHeight(true) - dragger.outerHeight(true)) * .5
        leftMove = target.position().left - (dragger.data('position').left) + (target.outerWidth(true) - dragger.outerWidth(true)) * .5
        dragger.animate {
            top: topMove
            left: leftMove
        },
            duration: 600
            easing: 'easeOutBack'
        return

    $('.draggable').draggable draggableOptions
    droppableOptions = drop: (event, ui) ->
        snapToMiddle ui.draggable, $(this)
        old_x_coord = ui.draggable.attr('data-x')
        old_y_coord = ui.draggable.attr('data-y')
        new_x_coord = $(this).data('x')
        new_y_coord = $(this).data('y')
        id_including_string = ui.draggable.attr('id')
    
        # id is going to be something like "piece-12"
        id = id_including_string.split('-')[1]
        
        # update the data-x and data-y of the chess piece
        ui.draggable.attr 'data-x', new_x_coord
        ui.draggable.attr 'data-y', new_y_coord
  
        $.ajax
            url: '/pieces/' + id
            type: 'PUT'
            data: 'x_coordinate=' + new_x_coord + '&y_coordinate=' + new_y_coord
            success: (data) ->
        return

    $('.droppable').droppable droppableOptions
    return
