#glg-twilio-up-time

    Polymer 'twilio-up-time',

##Methods

      phoneNumber: ''
      state: ''
      status: ''
      timeStamp: ''
      phoneStatus: ''
      handleTwilioUpResponse: (event, detail, sender) ->
        console.log 'handleTwilioUpResponse for phoneNumber: %s', this.phoneNumber
        console.log 'detail length: %d', detail.response.length

        for i, response of detail.response
          if response.state is 'ok'

            for j, twilioDetail of response.detail
              if twilioDetail.phoneNumber is this.phoneNumber
                console.log 'found phoneNumber'

                transactions = twilioDetail.transactions
                this.state = response.state
                this.timeStamp = transactions[transactions.length-1].currentTimeStamp
                console.log "timeStamp: %s", this.timeStamp

                this.phoneStatus = this.phoneNumber + ' was ' + this.state + ' on ' + this.timeStamp

##Polymer Lifecycle

      ready: () ->
        console.log 'Ready.....'
