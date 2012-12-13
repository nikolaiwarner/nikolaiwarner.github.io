$ ->

  game = new Game()
     
  $('.keybox').on 'mousedown', () ->
    key = $(@).data('key')
    game.keyDown(key, true)

  $('.keybox').on 'mouseup', () ->
    key = $(@).data('key')
    game.keyUp(key)

  $('.keybox').on 'touchstart', () ->
    key = $(@).data('key')
    game.keyDown(key, true)

  $('.keybox').on 'touchend', () ->
    key = $(@).data('key')
    game.keyUp(key)
    
  $(document).on 'keydown', (event) =>
    key = $.inArray(event.keyCode, game.keycodes)
    game.keyDown(key, false)
    
  $(document).on 'keyup', () ->
    key = $.inArray(event.keyCode, game.keycodes)
    game.keyUp(key)
    



  $(document).on "keypattern", (event, name) ->
    game.event(name)
  
  $('.start').on 'mousedown', () ->
    game.play()
    


class window.keyPattern
  constructor: (options) ->
    @keycodes = [65, 83, 68, 70, 74, 75, 76, 186]
    @name = options.name
    @pattern = options.keys.join("")
    @typed = ""
    
    $(document).on 'keydown', (event) =>
      key = $.inArray(event.keyCode, @keycodes) 
      if key != -1
        @checkPattern(key)
                       	
  checkPattern: (key) =>
    @typed = "" + @typed+ key
    if @typed.length > @pattern.length 
      @typed = @typed.substr(@typed.length - @pattern.length)
    if @typed == @pattern     
      $(document).trigger("keypattern", @name)
      
      @typed = ""
    
    
    
    
  


class window.Game
  constructor: () ->
    @keycodes = [65, 83, 68, 70, 74, 75, 76, 186]
    @patterns = []
    
    @cats = 0
    @birds = 0
    @girls = 0
    
    @typed = ""
      
    @setupAudio()
    @setupPatterns()
    
    @move()
      
    
    
    
      
  keyDown: (number, fakeKey=false) =>
    $('.keybox.box'+number).addClass('hover')
    $('#audio_s'+number).get(0).play()
    
    if fakeKey
      e = $.Event('keydown')
      e.keyCode = @keycodes[number]
      $(document).trigger(e) 
    
    
  keyUp: (number) =>
    if $audio = $('#audio_s'+number).get(0)
      $audio .pause()
      $audio .currentTime = 0
    
    $('.keybox').removeClass('hover')
  

  play: () =>
    $('.keybox').hide()
  
    $('.start, .nikolaiwarner').fadeOut(1000)
    $('.curtains').delay(2000).fadeOut(4000)
    $('.title').delay(4000).fadeOut(4000)
    
    $('.keybox').delay(8000).fadeIn(5000)
  
		# setup background music
    $('.game').append("<audio id='audio_bg0' autobuffer='true' preload='auto' loop='loop'><source src='audio/bg0.ogg' /><source src='audio/bg0.mp3' /></audio>")
    $('#audio_bg0').get(0).play()

		
		
		
		
  addAudio: (file, name=file, loops=false) =>
    $('.game').append("<audio id='audio_"+name+"' autobuffer='true' preload='auto'><source src='audio/"+file+".ogg' /><source src='audio/"+file+".mp3' /></audio>")
    if loops
      $('#audio_'+name).attr('loops', 'loops')


  setupAudio: () =>
    @addAudio('s0')
    @addAudio('s1')
    @addAudio('s2')
    @addAudio('s3')
    @addAudio('s4')
    @addAudio('s5')
    @addAudio('s6')
    @addAudio('s7')
  
    
    
    
  setupPatterns: () =>
    pattern_datas = [
      { name: "birds", keys: [0,2,4] }
      { name: "cats", keys: [7,2] }
      { name: "girls", keys: [3,5,6] }
      ]
    
    for pattern_data in pattern_datas
      @patterns.push(new window.keyPattern(pattern_data))
    true
		
		
		
  move: () =>
    #$('.scenery').each (index, scenery) ->     
    #  if parseInt($(scenery).css('left'), 10) + $(scenery).width() < 0
    #    $(scenery).stop().css({ left: 1200 })
    #  $(scenery).animate( { left: '-=100' },  parseInt($(scenery).data('speed'), 10) * 4000, 'linear' )
    #
    #setTimeout @move, 4000
  
  
		
  event: (eventname) =>
    console.log "event", eventname
    
    if eventname == 'girls' && @girls < 4
      #@girls = @girls + 1
      left = Math.floor(Math.random()*350)
      top = 410
      $('.game').append("<div class='character_container' style='left:"+left+"px; top:"+top+"px'><div class='girl character'></div></div>")	

    if eventname == 'birds' && @birds < 7
      #@birds = @birds + 1
	    left = Math.floor(Math.random()*1000)
	    top = Math.floor(Math.random()*400)
	    $('.game').append("<div class='character_container' style='left:"+left+"px; top:"+top+"px'><div class='bird character'></div></div>")
	    
    if eventname == 'cats' && @cats < 4
      #@cats = @cats + 1
	    left = Math.floor(Math.random()*350)
	    top = 420
	    $('.game').append("<div class='character_container' style='left:"+left+"px; top:"+top+"px'><div class='cat character'></div></div>")

		
