(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  $(function() {
    var game;
    var _this = this;
    game = new Game();
    $('.keybox').on('mousedown', function() {
      var key;
      key = $(this).data('key');
      return game.keyDown(key, true);
    });
    $('.keybox').on('mouseup', function() {
      var key;
      key = $(this).data('key');
      return game.keyUp(key);
    });
    $('.keybox').on('touchstart', function() {
      var key;
      key = $(this).data('key');
      return game.keyDown(key, true);
    });
    $('.keybox').on('touchend', function() {
      var key;
      key = $(this).data('key');
      return game.keyUp(key);
    });
    $(document).on('keydown', function(event) {
      var key;
      key = $.inArray(event.keyCode, game.keycodes);
      return game.keyDown(key, false);
    });
    $(document).on('keyup', function() {
      var key;
      key = $.inArray(event.keyCode, game.keycodes);
      return game.keyUp(key);
    });
    $(document).on("keypattern", function(event, name) {
      return game.event(name);
    });
    return $('.start').on('mousedown', function() {
      return game.play();
    });
  });

  window.keyPattern = (function() {

    function keyPattern(options) {
      this.checkPattern = __bind(this.checkPattern, this);
      var _this = this;
      this.keycodes = [65, 83, 68, 70, 74, 75, 76, 186];
      this.name = options.name;
      this.pattern = options.keys.join("");
      this.typed = "";
      $(document).on('keydown', function(event) {
        var key;
        key = $.inArray(event.keyCode, _this.keycodes);
        if (key !== -1) return _this.checkPattern(key);
      });
    }

    keyPattern.prototype.checkPattern = function(key) {
      this.typed = "" + this.typed + key;
      if (this.typed.length > this.pattern.length) {
        this.typed = this.typed.substr(this.typed.length - this.pattern.length);
      }
      if (this.typed === this.pattern) {
        $(document).trigger("keypattern", this.name);
        return this.typed = "";
      }
    };

    return keyPattern;

  })();

  window.Game = (function() {

    function Game() {
      this.event = __bind(this.event, this);
      this.move = __bind(this.move, this);
      this.setupPatterns = __bind(this.setupPatterns, this);
      this.setupAudio = __bind(this.setupAudio, this);
      this.addAudio = __bind(this.addAudio, this);
      this.play = __bind(this.play, this);
      this.keyUp = __bind(this.keyUp, this);
      this.keyDown = __bind(this.keyDown, this);      this.keycodes = [65, 83, 68, 70, 74, 75, 76, 186];
      this.patterns = [];
      this.cats = 0;
      this.birds = 0;
      this.girls = 0;
      this.typed = "";
      this.setupAudio();
      this.setupPatterns();
      this.move();
    }

    Game.prototype.keyDown = function(number, fakeKey) {
      var e;
      if (fakeKey == null) fakeKey = false;
      $('.keybox.box' + number).addClass('hover');
      $('#audio_s' + number).get(0).play();
      if (fakeKey) {
        e = $.Event('keydown');
        e.keyCode = this.keycodes[number];
        return $(document).trigger(e);
      }
    };

    Game.prototype.keyUp = function(number) {
      var $audio;
      if ($audio = $('#audio_s' + number).get(0)) {
        $audio.pause();
        $audio.currentTime = 0;
      }
      return $('.keybox').removeClass('hover');
    };

    Game.prototype.play = function() {
      $('.keybox').hide();
      $('.start, .nikolaiwarner').fadeOut(1000);
      $('.curtains').delay(2000).fadeOut(4000);
      $('.title').delay(4000).fadeOut(4000);
      $('.keybox').delay(8000).fadeIn(5000);
      $('.game').append("<audio id='audio_bg0' autobuffer='true' preload='auto' loop='loop'><source src='audio/bg0.ogg' /><source src='audio/bg0.mp3' /></audio>");
      return $('#audio_bg0').get(0).play();
    };

    Game.prototype.addAudio = function(file, name, loops) {
      if (name == null) name = file;
      if (loops == null) loops = false;
      $('.game').append("<audio id='audio_" + name + "' autobuffer='true' preload='auto'><source src='audio/" + file + ".ogg' /><source src='audio/" + file + ".mp3' /></audio>");
      if (loops) return $('#audio_' + name).attr('loops', 'loops');
    };

    Game.prototype.setupAudio = function() {
      this.addAudio('s0');
      this.addAudio('s1');
      this.addAudio('s2');
      this.addAudio('s3');
      this.addAudio('s4');
      this.addAudio('s5');
      this.addAudio('s6');
      return this.addAudio('s7');
    };

    Game.prototype.setupPatterns = function() {
      var pattern_data, pattern_datas, _i, _len;
      pattern_datas = [
        {
          name: "birds",
          keys: [0, 2, 4]
        }, {
          name: "cats",
          keys: [7, 2]
        }, {
          name: "girls",
          keys: [3, 5, 6]
        }
      ];
      for (_i = 0, _len = pattern_datas.length; _i < _len; _i++) {
        pattern_data = pattern_datas[_i];
        this.patterns.push(new window.keyPattern(pattern_data));
      }
      return true;
    };

    Game.prototype.move = function() {};

    Game.prototype.event = function(eventname) {
      var left, top;
      console.log("event", eventname);
      if (eventname === 'girls' && this.girls < 4) {
        left = Math.floor(Math.random() * 350);
        top = 410;
        $('.game').append("<div class='character_container' style='left:" + left + "px; top:" + top + "px'><div class='girl character'></div></div>");
      }
      if (eventname === 'birds' && this.birds < 7) {
        left = Math.floor(Math.random() * 1000);
        top = Math.floor(Math.random() * 400);
        $('.game').append("<div class='character_container' style='left:" + left + "px; top:" + top + "px'><div class='bird character'></div></div>");
      }
      if (eventname === 'cats' && this.cats < 4) {
        left = Math.floor(Math.random() * 350);
        top = 420;
        return $('.game').append("<div class='character_container' style='left:" + left + "px; top:" + top + "px'><div class='cat character'></div></div>");
      }
    };

    return Game;

  })();

}).call(this);
