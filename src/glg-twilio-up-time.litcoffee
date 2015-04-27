##Methods
      handleTwilioUpResponse: (event, detail, sender) ->
        console.log('handleTwilioUpResponse');
        
      clearMarkdown: ->
        rendered = @querySelector 'section[rendered]'
        rendered?.parentNode?.removeChild rendered

      bindMarkdown: (markdown) ->
        content = marked @trimIndents(markdown), renderer: renderer
        rendered = document.createElement 'section'
        rendered.setAttribute 'rendered', ''
        rendered.innerHTML = content
        @appendChild rendered
        @fire 'changed'

      render: ->
        @clearMarkdown()
        @bindMarkdown @value or @textContent

##Polymer Lifecycle

      ready: () ->
        @onMutation @$.markdown, @render
        @render()
