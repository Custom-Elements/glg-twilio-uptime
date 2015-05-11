#glg-twilio-uptime

    Polymer 'glg-twilio-uptime',

##Methods

      rmPersonId: ''
      statuses: []
      moreText: 'more...'
      toggleMore: () ->
        if (this.more is true)
          this.$.statuses.style.overflow = "hidden"
          this.moreText = 'more...'
          this.more = false
        else
          this.$.statuses.style.overflow = "visible"
          this.moreText = 'less...'
          this.more = true
      handleTwilioUpResponse: (event, detail, sender) ->
        console.log 'handleTwilioUpResponse for rmPersonId: %s', this.rmPersonId

        for i, response of detail.response
          if response.state is 'ok'
            for twilioDetail in response.detail
              mainMessage = ''
              projects = []
              for upcomingCall in twilioDetail.upcomingCalls
                for consultation in upcomingCall.consultations
                  if (consultation.primaryManager.personId is parseInt(this.rmPersonId))
                    console.log 'found consultation personId: %s rmPersonId %s', consultation.primaryManager.personId, this.rmPersonId
                    participants = consultation.participants
                    for l, participant of participants
                      name = participant.firstName + ' ' + participant.lastName
                      if name
                        mainMessage = twilioDetail.phoneNumber + ' is down; use ' + twilioDetail.phoneNumber + ' instead'
                        project = {projectName: consultation.consultationTitle, timeDiff: upcomingCall.timeDiff, participant: participant.firstName + ' ' + participant.lastName}
                        projects.push project

              if (projects.length > 0)
                status = {mainMessage: mainMessage, projects: projects}
                this.statuses.push status
                console.log('statuses: %s', JSON.stringify(this.statuses))

##Polymer Lifecycle

      ready: () ->
        console.log 'Ready.....'
