# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.addEventListener 'load', ->
  for element in document.querySelectorAll('.enter-submits-form')
    do (element) ->
      element.addEventListener 'keydown', (event) ->        
        if event.keyCode is 13  # Enter
          element.readOnly = true
          event.preventDefault()
          formElement = element
          until formElement.tagName is 'FORM'
            formElement = formElement.parentNode
          formElement.submit()
