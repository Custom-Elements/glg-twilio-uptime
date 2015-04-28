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
                this.state = response.state
                this.timeStamp = transactions[transactions.length-1].currentTimeStamp
                status = 'The dial-in ' + twilioDetail.phoneNumber + ' is down, try using ' + twilioDetail.phoneNumber
                if (more is false)
                  this.twilioUpTimeStatus = status
                  more = true
                else
                  this.moreTwilioUpTimeStatus.push status
​
##Polymer Lifecycle

      ready: () ->
        console.log 'Ready.....'
