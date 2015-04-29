#glg-twilio-up-time

    Polymer 'twilio-up-time',

##Methods

      rmPersonId: ''
      state: ''
      status: ''
      timeStamp: ''
      twilioUpTimeStatus: ''
      moreTwilioUpTimeStatus: []
      toggleMore: () ->
        if (this.more is true)
          this.$.more.style.display = "none"
          this.more = false
        else
          this.$.more.style.display = "block"
          this.more = true
      handleTwilioUpResponse: (event, detail, sender) ->
        console.log 'handleTwilioUpResponse for rmPersonId: %s', this.rmPersonId

        for i, response of detail.response
          if response.state is 'ok'
            for i, twilioDetail of response.detail
              for j, upcomingCall of twilioDetail.upcomingCalls
                for k, consultation of upcomingCall.consultations
                  if (consultation.primaryManager.personId is parseInt(this.rmPersonId))
                    console.log 'found consultation personId: %s rmPersonId %s', consultation.primaryManager.personId, this.rmPersonId
                    participants = consultation.participants
                    for l, participant of participants
                      name = participant.firstName + ' ' + participant.lastName
                      if name
                        status = 'The dial-in ' + twilioDetail.phoneNumber + ' scheduled ' + upcomingCall.timeDiff + ' is down for ' + consultation.consultationTitle + ' with ' + name + ', try using ' + twilioDetail.phoneNumber
                        this.twilioUpTimeStatus = 'Twilio Numbers down'
                        this.moreTwilioUpTimeStatus.push status

##Polymer Lifecycle

      ready: () ->
        console.log 'Ready.....'
