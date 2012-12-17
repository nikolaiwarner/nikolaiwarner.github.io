class NStatus
  constructor: ->
    @nstatus = {}
    @fetch_data('nstatus.json')



  fetch_data: (data_source) =>
    $.getJSON data_source, (response) =>
      @nstatus = response
      @update_display()


  update_display: =>
    # Days since sick
    illnesses = @nstatus.illness
    last_date = illnesses[0].date
    days_since_sick = moment(last_date, "MMDDYYYY").fromNow()
    $('.days_since_sick').html(days_since_sick)
    $('.days_since_sick').prop('title', illnesses[0].description)



$ ->
  window.nstatus = new NStatus()
