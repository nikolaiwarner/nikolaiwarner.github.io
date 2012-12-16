class NStatus
  constructor: ->
    @fetch_data('nstatus.json')


  fetch_data: (data_source) =>
    $.get data_source, (response) =>
      @nickwarner = response.nickwarner
      @update_display()


  update_display: =>
    # Days since sick
    last_date = @nickwarner.dates_of_recent_illness[0]
    days_since_sick = moment("20111031", "MMDDYYYY").fromNow()
    $('.days_since_sick').html(days_since_sick)



$ ->
  window.nstatus = new NStatus()
