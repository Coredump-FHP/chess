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
        topMove = target.position().top - (dragger.data('position').top) + (target.outerHeight(true) - dragger.outerHeight(true)) * 2.5
        leftMove = target.position().left - (dragger.data('position').left) + (target.outerWidth(true) - dragger.outerWidth(true)) * 2.5
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
        id = ui.draggable.attr('id')
        # update the "from square" to be droppable
        from_square = $('td[data-x="' + old_x_coord + '"][data-y="' + old_y_coord + '"]')
        from_square.addClass 'droppable ui-droppable'
        # update the "to square" to not be droppable
        to_square = $('td[data-x="' + new_x_coord + '"][data-y="' + new_y_coord + '"]')
        to_square.removeClass 'droppable ui-droppable'
        # update the data-x and data-y of the chess piece
        ui.draggable.data 'x', new_x_coord
        ui.draggable.data 'y', new_y_coord
        $.ajax
            url: '/pieces/' + id
            type: 'PUT'
            data: 'x_coordinate=' + new_x_coord + '&y_coordinate=' + new_y_coord
            success: (data) ->
        return

    $('.droppable').droppable droppableOptions
    return
