// Generated by CoffeeScript 1.3.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.SetView = (function(_super) {

    __extends(SetView, _super);

    function SetView() {
      return SetView.__super__.constructor.apply(this, arguments);
    }

    SetView.prototype.template_first = _.template($("#set_view_first").html());

    SetView.prototype.template = _.template($("#set_view").html());

    SetView.prototype.events = {
      'keyup .new_set_set': 'valueChanged'
    };

    SetView.prototype.initialize = function(opt) {
      _.bindAll(this);
      this.vent = opt.vent;
      this.vent.bind('program_edit', this.edit);
      this.model.bind('change', this.render);
      return this.render();
    };

    SetView.prototype.render = function() {
      if (this.model.get('position') === 1) {
        this.setElement(this.template_first(this.model.toJSON()));
      } else {
        this.setElement(this.template(this.model.toJSON()));
      }
      return this;
    };

    SetView.prototype.edit = function() {
      var _ref;
      if ((_ref = this.workout_set) == null) {
        this.workout_set = this.model.get('position') === 1 ? $(this.el) : this.$('.workout_set');
      }
      return this.workout_set.addClass('edit');
    };

    SetView.prototype.valueChanged = function() {
      var set_input;
      set_input = this.$('.new_set_set');
      if (parseInt(set_input.val()) !== 1) {
        return set_input.next().text('sets');
      } else {
        return set_input.next().text('set');
      }
    };

    return SetView;

  })(Backbone.View);

}).call(this);