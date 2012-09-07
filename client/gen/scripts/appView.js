// Generated by CoffeeScript 1.3.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.AppView = (function(_super) {

    __extends(AppView, _super);

    function AppView() {
      return AppView.__super__.constructor.apply(this, arguments);
    }

    AppView.prototype.el = $('body');

    AppView.prototype.events = {
      'click #new_program': 'newProgramShow',
      'click #new_program_submit': 'newProgramCreate',
      'keypress #new_program_name': 'newProgramOnEnter'
    };

    AppView.prototype.initialize = function() {
      _.bindAll(this);
      this.programs = new App.Programs;
      this.programs.bind('reset', this.programReset);
      this.programs.bind('add', this.programAdd);
      this.programs.bind('remove', this.programReset);
      this.programListViews = [];
      this.new_program = $('#new_program');
      this.new_program_name = $('#new_program_name');
      this.new_program_submit = $('#new_program_submit');
      this.createDisabled = false;
      return this.program_create = false;
    };

    AppView.prototype.render = function() {
      return this;
    };

    AppView.prototype.programAdd = function(program) {
      var programListView;
      programListView = new App.ProgramListView({
        model: program,
        selected: this.programs.indexOf(program) === 0,
        isMain: program.id === 2
      });
      this.programListViews.push(programListView);
      this.new_program.before(programListView.render().el);
      if (this.program_create) {
        programListView.showProgram(true);
        return this.program_create = false;
      }
    };

    AppView.prototype.programReset = function() {
      var programListView, _i, _len, _ref;
      _ref = this.programListViews;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        programListView = _ref[_i];
        programListView.close();
      }
      this.programListViews = [];
      if (App.contentView != null) {
        if (this.programs.at(0) != null) {
          App.contentView.updateProgram(this.programs.at(0));
        }
      } else {
        App.contentView = new App.ContentView({
          program: this.programs.at(0)
        });
      }
      this.programs.each(this.programAdd);
      if ($('#content').height() < $("#nav_left").height() + 80) {
        return $("#content").css('minHeight', $("#nav_left").height() + 80);
      }
    };

    AppView.prototype.newProgramShow = function() {
      var _this = this;
      if (!this.new_program.hasClass('selected')) {
        this.new_program.addClass('selected');
        return this.new_program.animate({
          height: '150px'
        }, {
          duration: 400,
          specialEasing: {
            top: 'easeOutBounce'
          },
          complete: function() {
            _this.new_program_name.fadeIn();
            _this.new_program_submit.fadeIn();
            return _this.new_program_name.focus();
          }
        });
      }
    };

    AppView.prototype.newProgramCreate = function() {
      var duration, name,
        _this = this;
      if (!this.createDisabled) {
        this.createDisabled = true;
        name = this.new_program_name.val();
        name = name.trim();
        if (name.split(' ').join('').length > 0) {
          this.program_create = true;
          if (!(App.contentView != null)) {
            App.contentView = new App.ContentView;
          }
          this.programs.create({
            name: this.new_program_name.val()
          });
          duration = 10;
        } else {
          duration = 400;
        }
        this.new_program_name.val('');
        this.new_program_name.hide();
        this.new_program_submit.hide();
        return this.new_program.animate({
          height: '61px'
        }, {
          duration: duration,
          specialEasing: {
            top: 'easeOutBounce'
          },
          complete: function() {
            _this.new_program.removeClass('selected');
            return _this.createDisabled = false;
          }
        });
      }
    };

    AppView.prototype.newProgramOnEnter = function(e) {
      if (e.keyCode !== 13) {

      } else {
        return this.newProgramCreate();
      }
    };

    return AppView;

  })(Backbone.View);

  App.ContentView = (function(_super) {

    __extends(ContentView, _super);

    function ContentView() {
      return ContentView.__super__.constructor.apply(this, arguments);
    }

    ContentView.prototype.el = $('#content_holder');

    ContentView.prototype.vent = _.extend({}, Backbone.Events);

    ContentView.prototype.initialize = function(options) {
      var _this = this;
      _.bindAll(this);
      if (this.options.program != null) {
        this.program = this.options.program;
        this.program_view = new App.ProgramView({
          model: this.options.program,
          vent: this.vent
        });
      }
      this.buttonView = new App.ButtonView({
        vent: this.vent
      });
      this.button_container = $(this.buttonView.render().el);
      $("body").append(this.button_container);
      this.button_top = this.button_container.position().top;
      $(window).scroll(function(event) {
        return _this.updateButtonContainer();
      });
      return this.render();
    };

    ContentView.prototype.render = function() {
      if (this.program_view != null) {
        $(this.el).html(this.program_view.el);
      }
      this.updateButtonContainer();
      return this;
    };

    ContentView.prototype.updateProgram = function(program, edit) {
      if (edit == null) {
        edit = false;
      }
      this.program = program;
      if (this.program_view != null) {
        this.program_view.close();
      }
      this.program_view = new App.ProgramView({
        model: program,
        vent: this.vent
      });
      this.render();
      if (edit) {
        return this.vent.trigger('program_edit');
      }
    };

    ContentView.prototype.updateButtonContainer = function() {
      var y;
      y = $(window).scrollTop();
      if (y >= this.button_top - 10) {
        return this.button_container.addClass('fixed');
      } else {
        return this.button_container.removeClass('fixed');
      }
    };

    ContentView.prototype.getProgram = function() {
      return this.program;
    };

    ContentView.prototype.getProgramView = function() {
      return this.program_view;
    };

    ContentView.prototype.close = function() {
      this.remove();
      return this.unbind();
    };

    return ContentView;

  })(Backbone.View);

  App.ButtonView = (function(_super) {

    __extends(ButtonView, _super);

    function ButtonView() {
      return ButtonView.__super__.constructor.apply(this, arguments);
    }

    ButtonView.prototype.template = _.template($("#button_view").html());

    ButtonView.prototype.events = {
      'click .edit': 'edit',
      'click .delete': 'delete'
    };

    ButtonView.prototype.initialize = function(opt) {
      _.bindAll(this);
      this.vent = opt.vent;
      return this.render();
    };

    ButtonView.prototype.render = function() {
      this.setElement(this.template());
      return this;
    };

    ButtonView.prototype.edit = function() {
      return this.vent.trigger('program_edit');
    };

    ButtonView.prototype["delete"] = function() {
      var name, program, r;
      program = App.contentView.getProgram();
      name = program.get('name');
      r = confirm("You sure you want to delete '" + name + "'?");
      if (r) {
        return this.vent.trigger('program_delete');
      }
    };

    return ButtonView;

  })(Backbone.View);

}).call(this);
