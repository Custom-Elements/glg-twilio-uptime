#glg-twilio-up-time

    Polymer 'twilio-up-time',

##Methods

      rmId: ''
      state: ''
      status: ''
      timeStamp: ''
      twilioUpTimeStatus: ''
      moreTwilioUpTimeStatus: []
      more: false
      toggleMore: () ->
        if (this.more is true)
          this.$.more.style.display = "none"
          this.more = false
        else
          this.$.more.style.display = "block"
          this.more = true
      handleTwilioUpResponse: (event, detail, sender) ->
        console.log 'handleTwilioUpResponse for rmId: %s', this.rmId
        console.log 'detail length: %d', detail.response.length

        for i, response of detail.response
          if response.state is 'ok'
            more = false
            for j, twilioDetail of response.detail
              if twilioDetail.rmId is this.rmId
                transactions = twilioDetail.transactions
                upcomingCalls = twilioDetail.upcomingCalls
                this.state = response.state
                this.timeStamp = transactions[transactions.length-1].currentTimeStamp

                for k, upcomingCall of upcomingCalls
                  consultations = upcomingCall.consultations
                  for l, consultation of consultations
                    console.log 'upcomingCall consultationId %s cmName: %s', consultation.consultationId, consultation.cmName
                    if consultation.cmName
                      status = 'The dial-in ' + twilioDetail.phoneNumber + ' scheduled ' + upcomingCall.timeDiff + ' is down for ' + consultation.consultationTitle + ' with ' + consultation.cmName + ', try using ' + twilioDetail.phoneNumber
                      this.twilioUpTimeStatus = 'Twilio Numbers down'
                      this.moreTwilioUpTimeStatus.push status
  ​
##Polymer Lifecycle

      ready: () ->
        console.log 'Ready.....'
