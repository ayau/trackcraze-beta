// Generated by CoffeeScript 1.3.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.ProgramView = (function(_super) {

    __extends(ProgramView, _super);

    function ProgramView() {
      return ProgramView.__super__.constructor.apply(this, arguments);
    }

    ProgramView.prototype.template = _.template($("#program_view").html());

    ProgramView.prototype.events = {
      'click .new_split_submit': 'newSplitCreate',
      'keypress .new_split_name': 'newProgramOnEnter',
      'click .save_program': 'saveProgram'
    };

    ProgramView.prototype.initialize = function(opt) {
      _.bindAll(this);
      this.vent = opt.vent;
      this.vent.bind('program_edit', this.edit);
      this.vent.bind('program_delete', this["delete"]);
      this.model.splits.bind('add', this.splitAdd);
      this.model.splits.bind('reset', this.splitReset);
      return this.render();
    };

    ProgramView.prototype.render = function() {
      this.setElement(this.template(this.model.toJSON()));
      this.splitReset();
      this.delegateEvents();
      return this;
    };

    ProgramView.prototype.splitAdd = function(split) {
      var split_view;
      split_view = new App.SplitView({
        model: split,
        vent: this.vent
      });
      return $(this.el).find('#split_holder').append(split_view.render().el);
    };

    ProgramView.prototype.splitReset = function() {
      if (this.model.splits.length > 0) {
        $(this.el).find('#split_holder').empty();
        return this.model.splits.each(this.splitAdd);
      }
    };

    ProgramView.prototype.newSplitCreate = function() {
      this.model.splits.create({
        name: this.split_name.val()
      });
      this.split_name.val('');
      return this.vent.trigger('program_edit');
    };

    ProgramView.prototype.newProgramOnEnter = function(e) {
      if (e.keyCode !== 13) {

      } else {
        return this.newSplitCreate();
      }
    };

    ProgramView.prototype.edit = function() {
      var _ref, _ref1, _ref2;
      if ((_ref = this.program_name) == null) {
        this.program_name = this.$('.program_name');
      }
      this.program_name.addClass('edit');
      if ((_ref1 = this.input) == null) {
        this.input = this.program_name.find('input');
      }
      this.$('.new_split').addClass('edit');
      return (_ref2 = this.split_name) != null ? _ref2 : this.split_name = this.$('.new_split_name');
    };

    ProgramView.prototype.saveProgram = function() {
      var _this = this;
      console.log('saving');
      this.model.set({
        _rev: this.model.get('rev')
      });
      this.model.set({
        _id: this.model.get('id')
      });
      return this.model.save({}, {
        success: function(model, res) {
          return _this.model.set({
            rev: res.rev
          });
        },
        error: function() {
          return console.log('error saving');
        }
      });
    };

    ProgramView.prototype["delete"] = function() {
      return this.model.destroy({
        headers: {
          'If-Match': this.model.get('rev')
        },
        success: function(model, res) {
          return console.log(res);
        },
        error: function() {
          return console.log('error');
        }
      });
    };

    ProgramView.prototype.close = function() {
      this.remove();
      this.unbind();
      this.vent.unbind();
      return this.model.splits.unbind();
    };

    return ProgramView;

  })(Backbone.View);

}).call(this);
